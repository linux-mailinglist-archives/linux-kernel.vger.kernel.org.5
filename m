Return-Path: <linux-kernel+bounces-89922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6767A86F756
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927DA1C208A2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C157A715;
	Sun,  3 Mar 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxFc5SjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054879DB6
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709503023; cv=none; b=cS5F53+gZEsbaL7bDuot3+zPyBt4YNxaqB0A+yCbTzCsRBHwLRA7w/PuQEg/BDZJMIvrNVoXbbyMPRTsIgXiVrs4xckOlJSkcNGQzlODTw7/BqV5IYVvYk26luOQn91tBXbV6yoGfVa6h0Hxy+HJQRdMUuWKF9OaqJTQ8QCrIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709503023; c=relaxed/simple;
	bh=yBugoWgQAYcskdBuGMNWHxzysZg3JCbfaz8uiiWHdko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQpGaGB3en1aINUeSlQaJRpLOkruYp7mNVLj8h2c0Lm/ObWhUwgOhOC43fRH0vsNbMij0/wWa5RLnjn7lRkPP7+cfSOFyDBLZPRXEwkvVckEnjcfg/16tHKyyB9mtojH263c+mKTXuCFwsctoyERQFpXkvzkCeXzDzPqgeeODT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxFc5SjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7329C433F1
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 21:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709503022;
	bh=yBugoWgQAYcskdBuGMNWHxzysZg3JCbfaz8uiiWHdko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UxFc5SjKMJZWPj6dHiRT3fLLQ0I0GCpW5WQw2OWCG10VGkBHbX7//DzwQ6cFHpYqV
	 +0oxTmJ31hDzKgyznx3ysUnjFuYcSguvgi1CrjV2MAtJJHKrtFZjb6pv0L0DaI9ZsI
	 6SiVWP2nkWGLLOudIX1xZqiEwMspWWz5LGtLblVcbB0txmUYJ/EfYyndqCv0+cKCel
	 lBcuwIsEkrhbDUgh0SX2tgjp3lVKs7RKAmWi3ba5qwzjotx7i51wf3l0hHMZODLmL6
	 VtIo9ovvdG7UiV5N6rhJS24h2eoLvYqtuSmFMBWGAzWAeRouPmHId4T4DI8Z2LL97V
	 9r+2CwCuhnDTg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d311081954so42235111fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 13:57:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUy6cVrz+G1Q1WkedmW06GWlg4lw5oEtEPEMNVM4wu8YYbznWn210rIHjFzUjPcOnEQxZU8ZgQ9hEHMC2+QuKmhahug6bNQE7j8o1O5
X-Gm-Message-State: AOJu0Yzeh1RH1k3PSdbo1JQucyuaqyRn8uT0+IAFsEiE3/4uV8zrLwvd
	mdCA88T+niBFqS20lvZB73J0slOFApmZSE+q5OIAu0GCviTX7oWv+fJ4zbXNDssU8lY0I0fr4wT
	KPIyfZSKDRlVlPRJV1B4c0GXri8E=
X-Google-Smtp-Source: AGHT+IGkCE6KduDw4XSaElSxE8ellqIcyx7yRIOsSrLDLQG0snlMa0CXYX/avdOqBnuq2bCaRf6sZsTNoJudi9TxMu4=
X-Received: by 2002:a05:6512:3d1c:b0:513:3310:4062 with SMTP id
 d28-20020a0565123d1c00b0051333104062mr5718558lfv.64.1709503021033; Sun, 03
 Mar 2024 13:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <20240227151907.387873-13-ardb+git@google.com>
 <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local> <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
 <20240301160921.GBZeH9sZhp73xX40ze@fat_crate.local> <CAMj1kXFJwEUExy7+Snh3QHVn-ATj0C+sYje22Qmc+y=cCtAV7g@mail.gmail.com>
 <20240301173323.GDZeIRY_BVBqpudkEo@fat_crate.local> <20240303192654.GAZeTO_nxJ4bE2A2zD@fat_crate.local>
In-Reply-To: <20240303192654.GAZeTO_nxJ4bE2A2zD@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 3 Mar 2024 22:56:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEmNWNH8ZRXcMQ=NKyvOWd4=K5kC4mZMzH-8BmBtvmw+A@mail.gmail.com>
Message-ID: <CAMj1kXEmNWNH8ZRXcMQ=NKyvOWd4=K5kC4mZMzH-8BmBtvmw+A@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level paging
 global variables
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Mar 2024 at 20:27, Borislav Petkov <bp@alien8.de> wrote:
>
..
>
> Btw, on a semi-related note, do you have an idea whether a normal guest
> kernel using OVMF istead of seabios would be even able to boot a kernel
> supplied with -kernel like above but without an -initrd?
>

How are you passing the root device to the kernel? Via root= on the
command line?

> I have everything builtin and the same kernel boots fine in a guest with
> a
> [    0.000000] SMBIOS 3.0.0 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>

OK, so this is SeaBIOS

> but if I try to boot the respective guest installed with the OVMF BIOS
> from the debian package:
>
> [    0.000000] efi: EFI v2.7 by Debian distribution of EDK II
> [    0.000000] efi: SMBIOS=0x7f788000 SMBIOS 3.0=0x7f786000 ACPI=0x7f97e000 ACPI 2.0=0x7f97e014 MEMATTR=0x7ddfe018
>

and this is OVMF.

I have tried both of these, with i440fx as well as q35, and they all
work happily with my Debian guest image passed via -hda to QEMU, and
with root=/dev/sda2 on the kernel command line.


> it fails looking up the /dev/root device major/minor deep in the bowels
> of the vfs:
>
> [    2.565651] do_new_mount:
> [    2.566380] vfs_get_tree: fc->root: 0000000000000000
> [    2.567298] kern_path: filename: ffff88800d666000 of name: /dev/root
> [    2.568418] kern_path: ret: 0
> [    2.569009] lookup_bdev: kern_path(/dev/root, , path: ffff88800e537380), error: 0
> [    2.571645] lookup_bdev: inode->i_rdev: 0x0
> [    2.572417] get_tree_bdev: lookup_bdev(/dev/root, dev: 0x0), error: 0
>                                                      ^^^^^^^^^
>
> That dev_t should be 0x800002 - the major and minor of /dev/sda2 but it
> looks like something else is missing in this case...
>

How did you get this output? Are these debug printk()s you added yourself?

