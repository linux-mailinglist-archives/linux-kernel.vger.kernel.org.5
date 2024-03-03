Return-Path: <linux-kernel+bounces-89925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B186F75D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C164128157B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDC27A722;
	Sun,  3 Mar 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XUCxMCjQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA07A706
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709503846; cv=none; b=nmfXl7IGu8PQ7wqI05Qadg+YQDCPTlhHARea11vkih90PBen/DckLk40FeYDYdgoZ5rmOc+/YAQIi2FP4laCEVPXARu2VgDHzkpdCBhDe0FVwn0I4PdDlJftp0xWXroxaHu4Y9td0dzo/uiVhhL9TGgvc5s/YSTqSDDIfu8mF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709503846; c=relaxed/simple;
	bh=6Qn0zxJQ9XzUSYuTh6t2EXz0z4JIHfAZlvSKfLWHBoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqtLMdW82SZhJ2o1IhKFYy13htUaccuR5x04XpV/fyCPLalcDqKDBv3DrQ4TCW6VHnQSwf/hzCn8xHylQJeEDJNjJRs83abIcy/srZMGccvIn16Z8zd9Ap0lK2i+SD/uvYnRvZvcDK+pGzPBS2+Cf09hKZfDuZomLMOTnvFFgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XUCxMCjQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C09C440E0185;
	Sun,  3 Mar 2024 22:10:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HTi674Zwq0-y; Sun,  3 Mar 2024 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709503837; bh=pQ905fKNiJSh+Bs2XBMZTLixhWliqu9uqSB+rX4FcrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUCxMCjQG5VLupIrlCjqVnbq52vsOMpagh1DslLjyOjzCxQq5gUusxKBuVPnHW1/u
	 eZtrYvLgpuMMzRlueURr8vY/BlrtaYxhFwKzw+ZRdy8m5F5U6tp3DUwKZ8GKIpYn2U
	 QKMOzmyd3nf852idj8wZXShCD+r7Om7NrcXapv7P5OXuXj2uPrZaMSftmUkWrFgfJb
	 y1oCNF+Qikaw57WCXQuUzeBTgzF+pos41FCSUUh07/DqL5M6p3Ac/gEDV/ZMETT7Hc
	 a5T5SEk5rObL/kKOAm7uhyCIXruoAbM804Mt0SgptveOLyunCVOrdpvARwoBJKoQ1C
	 UQaWBFlNd6JxHgpT7KEr7SU897wdQVWiBt6kFx5uxVOs3NvsARw6FTEJ8xzrvpK029
	 LFHdp48ilxLonGla37rLDZH5ykuCahiSNF4zVaWXcYw2Tn5KZiYc/TVmetdSkX7QX/
	 d7dLKN6Smx7fygCgxgS5PGHSs8SWKOTHf0JfhJHpyZo61oRC9deK4rMnPTKrsoFBH3
	 sDZs5CN/zUub8qwhUR6vXKBvh8FdgId5Tacdhs2FV24wc8Og0e04HcXu1nOXfKtxHP
	 SdTLGrPFlNAZz24rc9ql9ropCxlSWIAxf16Mpdpsisd1pls+40P1BfRC5emEPEl+yp
	 TqUNZTHaOfgGvR/WyvJqcixU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 301B640E016C;
	Sun,  3 Mar 2024 22:10:26 +0000 (UTC)
Date: Sun, 3 Mar 2024 23:10:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level
 paging global variables
Message-ID: <20240303221019.GBZeT1S4295Y3MVuBG@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-13-ardb+git@google.com>
 <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local>
 <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
 <20240301160921.GBZeH9sZhp73xX40ze@fat_crate.local>
 <CAMj1kXFJwEUExy7+Snh3QHVn-ATj0C+sYje22Qmc+y=cCtAV7g@mail.gmail.com>
 <20240301173323.GDZeIRY_BVBqpudkEo@fat_crate.local>
 <20240303192654.GAZeTO_nxJ4bE2A2zD@fat_crate.local>
 <CAMj1kXEmNWNH8ZRXcMQ=NKyvOWd4=K5kC4mZMzH-8BmBtvmw+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEmNWNH8ZRXcMQ=NKyvOWd4=K5kC4mZMzH-8BmBtvmw+A@mail.gmail.com>

On Sun, Mar 03, 2024 at 10:56:49PM +0100, Ard Biesheuvel wrote:
> How are you passing the root device to the kernel? Via root= on the
> command line?

Yeah:

qemu
..
-kernel arch/x86/boot/bzImage
-append "root=/dev/sda2 resume=/dev/sda3 ...

> and this is OVMF.

Yap.

> I have tried both of these, with i440fx as well as q35, and they all
> work happily with my Debian guest image passed via -hda to QEMU, and
> with root=/dev/sda2 on the kernel command line.

Interesting. I'm not passing any machine type. Maybe I should even
thought I've never done it before.

/me goes and tries machine type.

Well, I'll be damned!

-machine type=pc-i440fx-2.8 - no workie BUT

-machine type=pc-q35-2.8

booted.

Now on to figure out what's different with q35 and why it is magical and
it finds the root device just fine:

[    2.732908] mount_root_generic: i: 2, fs_name: ext4
[    2.734275] do_mount_root: name: /dev/root
[    2.735093] kern_path: filename: ffff88800d4de000 of name: /root
[    2.736954] kern_path: ret: 0
[    2.737727] init_mount: kern_path(/root), ret: 0
[    2.738964] path_mount: will do_new_mount
[    2.739784] do_new_mount: 1, fc source: (null)
[    2.740961] do_new_mount: 2, err: 0
[    2.741722] do_new_mount: 3, err: 0
[    2.742448] do_new_mount: 4, err: 0
[    2.743164] vfs_get_tree: fc->root: 0000000000000000
[    2.744095] kern_path: filename: ffff88800d4de000 of name: /dev/root
[    2.745352] kern_path: ret: 0
[    2.745994] lookup_bdev: kern_path(/dev/root, , path: ffff88800cf163c0), error: 0
[    2.747288] lookup_bdev: inode->i_rdev: 0x800002
[    2.748163] get_tree_bdev: lookup_bdev(/dev/root, dev: 0x800002), error: 0
							  ^^^^^^^^^

> How did you get this output? Are these debug printk()s you added yourself?

Yeah, the good old "sprinkle printks" debugging method. Figured I should
look at the VFS code out of interest. :-)

Thanks a lot for the suggestions, especially about q35!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

