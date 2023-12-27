Return-Path: <linux-kernel+bounces-12299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E181F286
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6148A1C20B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23B481CC;
	Wed, 27 Dec 2023 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ZA9sKaLZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6E38DC8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:To:From:Cc:Sender;
	bh=crCdZvciDTPmcSncvl8IIv33ew0qDiUotCooh2fwT2k=; b=ZA9sKaLZO6iO3UwXGfb5k8w8DT
	88bFEa8Ti0KRH8tJE3k2gU7PZGo4mviGPf3jVbGp+nMleNqQlQVUiJnKt7ARaW95GQZXfCs2uN5Ol
	dYIyRUU353slFTXIMkO5j1uPC22yJ0mSXZQJyI+A7yOoV/8od4f817iKi+a05HE7AA4PXRFRxk1tf
	3hjcc/skuiHHeIxjBPtuw6S2bd2qGPdUUxtRqsGmo82ZwZqEnmi/yLodqjbLls86Xx+FFhAYNOAZ8
	d7BVOavlY5effW7qRDeNj93VzTFNQPsDTZWNEvCXdk5w05uXdLgcwA+4btjUNgWxgWT9F/yJmI1Bw
	MAMYzNzQ==;
Received: from [10.69.139.10] (helo=uriel.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rIcGW-0046rc-2c;
	Wed, 27 Dec 2023 16:20:41 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wine-devel@winehq.org
Subject: x86 SGDT emulation for Wine
Date: Wed, 27 Dec 2023 16:20:37 -0600
Message-ID: <2285758.taCxCBeP46@uriel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello all,

There is a Windows 98 program, a game called Nuclear Strike, which wants to do 
some amount of direct VGA access. Part of this is port I/O, which naturally 
throws SIGILL that we can trivially catch and emulate in Wine. The other part 
is direct access to the video memory at 0xa0000, which in general isn't a 
problem to catch and virtualize as well.

However, this program is a bit creative about how it accesses that memory; 
instead of just writing to 0xa0000 directly, it looks up a segment descriptor 
whose base is at 0xa0000 and then uses the %es override to write bytes. In 
pseudo-C, what it does is:

int get_vga_selector()
{
    sgdt(&gdt_size, &gdt_ptr);
    sldt(&ldt_segment);
    ++gdt_size;
    descriptor = gdt_ptr;
    while (descriptor->base != 0xa0000)
    {
        ++descriptor;
        gdt_size -= sizeof(*descriptor);
        if (!gdt_size)
            break;
    }

    if (gdt_size)
        return (descriptor - gdt_ptr) << 3;

    descriptor = gdt_ptr[ldt_segment >> 3]->base;
    ldt_size = gdt_ptr[ldt_segment >> 3]->limit + 1;
    while (descriptor->base != 0xa0000)
    {
        ++descriptor;
        ldt_size -= sizeof(*descriptor);
        if (!ldt_size)
            break;
    }

    if (ldt_size)
        return (descriptor - ldt_ptr) << 3;

    return 0;
}


Currently we emulate IDT access. On a read fault, we execute sidt ourselves, 
check if the read address falls within the IDT, and return some dummy data 
from the exception handler if it does [1]. We can easily enough implement GDT 
access as well this way, and there is even an out-of-tree patch written some 
years ago that does this, and helps the game run.

However, there are two problems that I have observed or anticipated:

(1) On systems with UMIP, the kernel emulates sgdt instructions and returns a 
consistent address which we can guarantee is invalid. However, it also returns 
a size of zero. The program doesn't expect this (cf. the way the loop is 
written above) and I believe will effectively loop forever in that case, or 
until it finds the VGA selector or hits invalid memory.

    I see two obvious ways to fix this: either adjust the size of the fake 
kernel GDT, or provide a switch to stop emulating and let Wine handle it. The 
latter may very well a more sustainable option in the long term (although I'll 
admit I can't immediately come up with a reason why, other than "we might need 
to raise the size yet again".)

    Does anyone have opinions on this particular topic? I can look into 
writing a patch but I'm not sure what the best approach is.

(2) On 64-bit systems without UMIP, sgdt returns a truncated address when in 
32-bit mode. This truncated address in practice might point anywhere in the 
address space, including to valid memory.

    In order to fix this, we would need the kernel to guarantee that the GDT 
base points to an address whose bottom 32 bits we can guarantee are 
inaccessible. This is relatively easy to achieve ourselves by simply mapping 
those pages as noaccess, but it also means that those pages can't overlap 
something we need; we already go to pains to make sure that certain parts of 
the address space are free. Broadly anything above the 2G boundary *should* be 
okay though. Is this feasible?

    We could also just decide we don't care about systems without UMIP, but 
that seems a bit unfortunate; it's not that old of a feature. But I also have 
no idea how hard it would be to make this kind of a guarantee on the kernel 
side.

    This is also, theoretically, a problem for the IDT, except that on the 
machines I've tested, the IDT is always at 0xfffffe0000000000. That's not 
great either (it's certainly caused some weirdness and confusion when 
debugging, when we unexpectedly catch an unrelated null pointer access) but it 
seems to work in practice.

--Zeb

[1] https://source.winehq.org/git/wine.git/blob/HEAD:/dlls/krnl386.exe16/
instr.c#l702



