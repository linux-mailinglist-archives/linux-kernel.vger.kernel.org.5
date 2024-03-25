Return-Path: <linux-kernel+bounces-117272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C86988A980
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EAD1F21E01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACDE130E38;
	Mon, 25 Mar 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH5TJY26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76A58135
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377579; cv=none; b=L0vq7o1tlpiaZckJSPx3z6ZOea6XP0H4J/ue/6EAdgFvUkzAzI7HqqudwW3zc6zQ4omns1jxQP9PaaUhSxy14tfldH7X1F6UU/uulMbOceYD4pwC8C9RgY7LsYfmt9RXwwKBjsDCTrsuIDyaKukoPn4xou9AUKCQEkEk6yLXQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377579; c=relaxed/simple;
	bh=PZs0rghxCeYopxbWbw9MtO4OhtjlQGpnCDFbcAELFfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUjr5bWhz6HxMkNmELcLfF2TRZFLsiif1764HdFsNM1fdssLo/F2WkPQXEngXIjON+V0Kx2K30FrkZs2vdZNEO4YZGEZ3vLkyECzJiB8miciO55Slsl0pUVCKB0OoIoPerScLgIV6JpdPWTpiZLHWBB+K6KaT2OJqUKlMzl3F3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH5TJY26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED77C433F1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711377579;
	bh=PZs0rghxCeYopxbWbw9MtO4OhtjlQGpnCDFbcAELFfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WH5TJY26+0r6af4PCB3nC8dtbN+CiM/zxpxYd3TrNv0IQOlfeie5r7m4xlD5DgJZH
	 qtyp4yrdJFbG9Q0zQcSxnn1BVB0zmWluyZABlreoMDsCQz16A9FjyG/g7lc4irqEYU
	 3cJ51nKFUJ3XpWSnD55ZCBEgHExZ/vEM8njiehkxc5ZifPUVbhhIkgOhG6T3JauR3g
	 stttZqJjYGDvqerngylxCCpvKKJEokwAIX7eUuqVxy2MyHmOm6sXJGo6F9fOAhREIe
	 r9w+YY5PYnX86qN4sjk8UPXMaBycOd/915XTt+a13oZAAjwDDO6qduAEDh5AsMRFnZ
	 1CrcjuGadibsA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28051376eso83958311fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:39:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9VHfYKsVO/iLVaQ/V/4CECpAYTxF9wkKOF9nJQ055Gaz2fXtfMz/qY/C92SpP01sPhMVG3XrZLzyqWSbjYCQYh+kzNCMs0WvMUs12
X-Gm-Message-State: AOJu0YzMXvmEmHGeHpUXoU6n/NW++aWYmzur6hP3NyZjgHXNnBfSVF6i
	72NmBM0MruhTLVyRXo3qTRlraBymtz6klU0Jrxce70Yjctt9kcPQDZLvKFhNd550Koi+EZfbVAh
	QyDkqI3ZphmfkO8/mTia6FtXt4vo=
X-Google-Smtp-Source: AGHT+IHH26cHmmV9SSXvercnOW3q4Z3IV8TeJsgM4tS6cTt2iQbN68nCt0arJtH4KDnq7tOk1RLaXmAqJ/1c9CQYySE=
X-Received: by 2002:a05:651c:2108:b0:2d6:cd05:1899 with SMTP id
 a8-20020a05651c210800b002d6cd051899mr5202179ljq.17.1711377577590; Mon, 25 Mar
 2024 07:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403221630.2692c998-oliver.sang@intel.com> <20240324142532.GAZgA33M_u1lW_E_1n@fat_crate.local>
In-Reply-To: <20240324142532.GAZgA33M_u1lW_E_1n@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Mar 2024 16:39:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE97o_T61AJ6wRAOpUvzon-45fnsT2dGB0GBP1x7bfGaw@mail.gmail.com>
Message-ID: <CAMj1kXE97o_T61AJ6wRAOpUvzon-45fnsT2dGB0GBP1x7bfGaw@mail.gmail.com>
Subject: Re: [linus:master] [x86/sme] 48204aba80: BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 16:26, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 22, 2024 at 05:03:18PM +0800, kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)" on:
> >
> > commit: 48204aba801f1b512b3abed10b8e1a63e03f3dd1 ("x86/sme: Move early SME kernel encryption handling into .head.text")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linus/master 741e9d668aa50c91e4f681511ce0e408d55dd7ce]
> > [test failed on linux-next/master a1e7655b77e3391b58ac28256789ea45b1685abb]
> >
> > in testcase: boot
> >
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> My guest boots with your .config and SNB as CPU model:
>
> ...
> [    0.373770][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
>
> Artefacts like:
>
> -initrd initrd-vm-meta-180.cgz
>
> or
>
> RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-rhel-8.3-bpf/gcc-12/48204aba801f1b512b3abed10b8e1a63e03f3dd1/3
>
> I don't have and don't know how to generate here so I can't run your
> exact reproducer.
>

I ran the reproducer using the instructions, and things seem to work fine.

https://paste.debian.net/1311951/

Could you provide any information regarding the QEMU version and its
BIOS implementation?

