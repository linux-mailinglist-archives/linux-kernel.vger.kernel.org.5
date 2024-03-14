Return-Path: <linux-kernel+bounces-103268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0B87BD38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAD72827B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F925A11F;
	Thu, 14 Mar 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Paf02xM3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBB5A0F2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421385; cv=none; b=rpNHSSyjb57u47GdRdKOhbwgLyezIkkQmvjh28rZc2jLfqYMTe6yg9iTLVDFFxU+uqBKbqc4y2uCHdCdufg7dclvYWcZnkkhFwMI3V24t5II+nHvp37LML3ADPfP/cRkaMPnqbkQuyVwH7EUzOzVHB1hlpIPBhajnjReCNPQJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421385; c=relaxed/simple;
	bh=+4t0kurOkBw0/uuMkCzeDFvoETy8dmlihhhNQfTE92s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4H0TFwD1J5BO+DjsuQljqYMC571sY1LL6/QVNZNPnRqYwlU74s0ERsl/QmNgrCUxplqYwPmUcL0lGcB3R2PgHFB8HFf7qqhakQGjjHSpztJOxkx09l2exYyl/eOb0tQslFFAFuwlfuIwNhwBUNsGvCwb/Un5VlNbncjXTBQ3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Paf02xM3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710421383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPly0vMKCUXLoKRkQ6t3RWJ8bsdSfgA8CK9VGL1bM5U=;
	b=Paf02xM30B20QuSFWX9ccG50iw7MDa8VkNlEdOZiR/ULmv5x5vZKEFXPH/WtUB9HBOGT3g
	CxBX+7l+2kM6Yn3SQlHBhUP0gs7o00NVKszp98WVQ3Gn2H0rPA3W1F25l3PMOISvPA/VWd
	ZNeDl8QvQ0y6kfdYpB0sEuxkfKbuQ6s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-bR1910l5MtSlwZwXc9xaHA-1; Thu,
 14 Mar 2024 09:02:59 -0400
X-MC-Unique: bR1910l5MtSlwZwXc9xaHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3539D3C0EAB7;
	Thu, 14 Mar 2024 13:02:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BDA1C060A4;
	Thu, 14 Mar 2024 13:02:57 +0000 (UTC)
Date: Thu, 14 Mar 2024 21:02:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	akpm@linux-foundation.org, joe@perches.com, dyoung@redhat.com
Subject: Re: [PATCH] kexec: fix the unexpected kexec_dprintk() macro
Message-ID: <ZfL1fvlfcziCVBsP@MiWiFi-R3L-srv>
References: <20240314103947.717991-1-bhe@redhat.com>
 <5d10552a-1c73-4f35-84be-ce6c1dcd800b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d10552a-1c73-4f35-84be-ce6c1dcd800b@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 03/14/24 at 12:54pm, Jiri Slaby wrote:
> On 14. 03. 24, 11:39, Baoquan He wrote:
> > Jiri reported that the current kexec_dprintk() always prints out
> > debugging message whenever kexec/kdmmp loading is triggered. That is
> > not wanted. The debugging message is supposed to be printed out when
> > 'kexec -s -d' is specified for kexec/kdump loading.
> > 
> > After investigating, the reason is the current kexec_dprintk() takes
> > printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> > specified. However, distros usually have defaulg log level like below:
> > 
> >   [~]# cat /proc/sys/kernel/printk
> >   7	 4	1	7
> > 
> > So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> > prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> > not.
> > 
> > Fix it by changing to use pr_info() and pr_debug() instead which are
> > expected to work.
> 
> Hi,
> 
> sow, you'd need both -d, and dyndbg updates. Hence, again my question:
> ===
> Actually what was wrong on the pr_debug()s? Can you simply turn them on from
> the kernel when -d is passed to kexec instead of all this?

I checked code, it's because some codes are shared by both kexec_load and
kexec_file_load, e.g below function on arm64:

arch/arm64/kernel/machine_kexec.c:machine_kexec_post_load()

"kexec -c -l -d" is for kexec_load debugging message printing, it's all
done in user space kexec-tools utility. The pr_debug() have been there
for arm64 developer's debugging if they want to. I don't want to change
that.

If 'kexec -s -l -d', pr_info() is called to print out. If 'kexec -s -l'
w/o '-d', or 'kexec -c -l', it's still pr_debug just as before.

> ===
> 
> And yet, it is still missing a prefix :).

It looks like this now, seems no need to add prefix.
 
[  102.609784] kexec_file: kernel: 0000000081fc03e0 kernel_size: 0xccb200
[  102.617084] PEFILE: Unsigned PE binary
[  102.753174] ima: kexec measurement buffer for the loaded kernel at 0x71435000.
[  102.761335] kexec-bzImage64: Loaded purgatory at 0x71430000
[  102.767571] kexec-bzImage64: Loaded boot_param, command line and misc at 0x7142c000 bufsz=0x1320 memsz=0x2000
[  102.778650] kexec-bzImage64: Loaded 64bit kernel at 0x6d000000 bufsz=0xcc6200 memsz=0x3c4c000
[  102.788251] kexec-bzImage64: Loaded initrd at 0x6ac0f000 bufsz=0x23f0175 memsz=0x23f0175
[  102.797283] kexec-bzImage64: Final command line is: root=/dev/mapper/fedora_lenovo--electron--sr850--01-root ro rd.lvm.lv=fedora_lenovo-electron-sr850-01/root console=ttyS0,115200n81
[  102.815435] kexec-bzImage64: E820 memmap:
[  102.819912] kexec-bzImage64: 0000000000000000-000000000003dfff (1)
[  102.826817] kexec-bzImage64: 000000000003e000-000000000003ffff (2)
[  103.021435] kexec-bzImage64: 00000000ff000000-00000000ffffffff (2)
.....snip
[  103.028336] kexec-bzImage64: 0000000100000000-000000403fffffff (1)
[  103.269194] kexec_file: nr_segments = 5
[  103.273484] kexec_file: segment[0]: buf=0x00000000898981dd bufsz=0x59e mem=0x71435000 memsz=0x1000
[  103.283616] kexec_file: segment[1]: buf=0x000000003d8dd363 bufsz=0x4000 mem=0x71430000 memsz=0x5000
[  103.293748] kexec_file: segment[2]: buf=0x00000000ba27c5ef bufsz=0x1320 mem=0x7142c000 memsz=0x2000
[  103.303865] kexec_file: segment[3]: buf=0x0000000026acdcf4 bufsz=0xcc6200 mem=0x6d000000 memsz=0x3c4c000
[  103.333455] kexec_file: segment[4]: buf=0x000000001a7dac7f bufsz=0x23f0175 mem=0x6ac0f000 memsz=0x23f1000
[  103.356698] kexec_file: kexec_file_load: type:0, start:0x714301a0 head:0x1222da002 flags:0x8


