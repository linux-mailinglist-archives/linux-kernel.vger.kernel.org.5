Return-Path: <linux-kernel+bounces-89880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1E86F6D3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB82D1F21107
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3B76C68;
	Sun,  3 Mar 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IrvUukiR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55FC43AB3
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709494055; cv=none; b=oh3XjXkTc/MRORmFBYfPJb2K40+YdD2fk6liS/HVx5BY2oyWuLALd6gXrl7PvfyY6lkRHqvZIgrjOXY43qDqNBlYCKy/eYo2N2UMQmzE5yNpGuFYr6ysJHekK7vLwo/Y7YnLv/zDhaNE8FFFzemGEzh1Gd6X5OX0K7ZaPFCKmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709494055; c=relaxed/simple;
	bh=XwxzVyKmED83ZL+4yFCYapZmwY2na4dJIvwKR0llUv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvoK6dNgA37ltHLsWoar3M8ONgPuCI1q+bw5+fLFhACc4wKUCUDz1aMrKGOD5r1sy6mdsloByd9J8kCyyl6rWqYVqv1af0m/DT884y+br0p2r/hzOUwR32cH4v968trCKGOHVslPEEY1a45Y1ovmYZqLnBLSYgQWUbmm1cQIAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IrvUukiR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2B10A40E019B;
	Sun,  3 Mar 2024 19:27:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vE_d3cBpokka; Sun,  3 Mar 2024 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709494039; bh=8Ho+q4kIRBEDDcBYfwDDw2iENT8f/OLBpqH2DKALBHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrvUukiRaRTZ6TBIx4lec5bVxzGI3gmZNsndJIsEfgQOYHB9hOqmdxuId6bdgv+fW
	 KnzJSqCDSezTcxRghIR/GAvRRuzqel5JlpQWqcIni41rynv0nkcr3gq9bMnLySwo0+
	 6ZcJJujQL78rGA7+CNoD17LqmcQJGOuyhAwXpMFQXJsaC1pzqgVEg0NhgGXqsr6hLa
	 83yFF5W/BKYSGJ+LlecgvyIyS3V3/bJKqdKar4GYBUxl3kh679sBgX8rZTyh9dsrqf
	 VBCmvhmHxLTtuzMT3Nwjxo9LPPOkVJG+0b4mwxdjEYxM3MKmdgq25EbiVt0v9BJQCt
	 k0py0SMVydjbydsWF92w5KFuKZArPoyTYs/oswwzBEatrme7S8NYpZ2EjMJUPCzqE6
	 3urAvN1WgB5X2SMRCKo34/3KunDwKq7HKN77x/LlSy/DEZELrqEJKfeI/NPOy4f+cm
	 MUZW66MgiUf/fmHQOtRV0qOtCH4h+Q9XOetbC4msJ5moel6X7ndcdPbb2x8+HYPi3s
	 u6Ws9FL5R4FL+kRXexLQl2ML+IAW8Z2TU4vM2uPJlO8zdvyKh1FPquobVmsEnLxRwy
	 ysNwND2qt6IVW74fCpyrTXM0ABtWDcImLtWfaHI45O7VFKvMu+ea8My8Kn3xXETQmW
	 2zzq9rMNLkvKRsA6sQB4zBOY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4A2440E016C;
	Sun,  3 Mar 2024 19:27:07 +0000 (UTC)
Date: Sun, 3 Mar 2024 20:26:54 +0100
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
Message-ID: <20240303192654.GAZeTO_nxJ4bE2A2zD@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-13-ardb+git@google.com>
 <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local>
 <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
 <20240301160921.GBZeH9sZhp73xX40ze@fat_crate.local>
 <CAMj1kXFJwEUExy7+Snh3QHVn-ATj0C+sYje22Qmc+y=cCtAV7g@mail.gmail.com>
 <20240301173323.GDZeIRY_BVBqpudkEo@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301173323.GDZeIRY_BVBqpudkEo@fat_crate.local>

On Fri, Mar 01, 2024 at 06:33:23PM +0100, Borislav Petkov wrote:
> > I've built a debug OVMF image using the latest version of the series,
> > and put it at [0]
> > 
> > Run like this
> > 
> > qemu-system-x86_64 -M q35 \
> >   -cpu qemu64,+la57 -smp 4 \
> >   -bios OVMF-5level.fd \
> >   -kernel arch/x86/boot/bzImage \
> >   -append console=ttyS0\ earlyprintk=ttyS0 \
> >   -vga none -nographic -m 1g \
> >   -initrd <initrd.img>
> > 
> > and you will get loads of DEBUG output from the firmware first, and
> > then boot into Linux. (initrd can be omitted)
> > 
> > Right before entering, it will print
> > 
> > CpuDxe: 5-Level Paging = 1
> > 
> > which confirms that the firmware is running with 5 levels of paging.
> > 
> > I've confirmed that this boots happily with this series applied,
> > including when using 'no5lvl' on the command line, or when disabling
> > CONFIG_X86_5LEVEL [confirmed by inspecting
> > /sys/kernel/debug/page_tables/kernel].
> > 
> > 
> > [0] http://files.workofard.com/OVMF-5level.fd.gz
> 
> Nice, that might come in handy for other testing too.

Btw, on a semi-related note, do you have an idea whether a normal guest
kernel using OVMF istead of seabios would be even able to boot a kernel
supplied with -kernel like above but without an -initrd?

I have everything builtin and the same kernel boots fine in a guest with
a
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

but if I try to boot the respective guest installed with the OVMF BIOS
from the debian package:

[    0.000000] efi: EFI v2.7 by Debian distribution of EDK II
[    0.000000] efi: SMBIOS=0x7f788000 SMBIOS 3.0=0x7f786000 ACPI=0x7f97e000 ACPI 2.0=0x7f97e014 MEMATTR=0x7ddfe018

it fails looking up the /dev/root device major/minor deep in the bowels
of the vfs:

[    2.565651] do_new_mount:
[    2.566380] vfs_get_tree: fc->root: 0000000000000000
[    2.567298] kern_path: filename: ffff88800d666000 of name: /dev/root
[    2.568418] kern_path: ret: 0
[    2.569009] lookup_bdev: kern_path(/dev/root, , path: ffff88800e537380), error: 0
[    2.571645] lookup_bdev: inode->i_rdev: 0x0
[    2.572417] get_tree_bdev: lookup_bdev(/dev/root, dev: 0x0), error: 0
						     ^^^^^^^^^

That dev_t should be 0x800002 - the major and minor of /dev/sda2 but it
looks like something else is missing in this case...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

