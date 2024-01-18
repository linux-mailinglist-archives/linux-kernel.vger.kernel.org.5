Return-Path: <linux-kernel+bounces-29890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B3D8314C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5591F2182F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5B1F946;
	Thu, 18 Jan 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X5r1MALB"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E271D533
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566235; cv=none; b=r/Kq35JWyCADoRKYAyYwq5YewxcIqwAeokEwO2JaJtRQHLr1RYq2plqxlvD7Z17ly4OJO2YsTtT9mL19iEHz08+2IGEDgWXrHPoHvmB5yKL7Y3Fp3c2HmivT4QOcpOUtxtA13fHd+3phxyopcKEjOT/j4qq/5gkx+QNy7Bg2yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566235; c=relaxed/simple;
	bh=BdVsw0FTwqzD+KS2xpaOjxHqz260SFBO0mWzXEz7i7M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 User-Agent; b=F6i8l8WlB3b1O7KP2Fg1ZDXoX5TDulOSa8GfNLxqnwJ2ITy6PfLr2aw0KOXpQWw3HYNmik6EdvhJsOr0ODuTtKLiLwK+LLklWDbGDmQwmQ7eMkyJ9gnabx5SmAskOL70Ym+xCCUhn0rpGytkWbVMcUFBbXL9vhqVs/hMfqZl4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=X5r1MALB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cfa71498feso125833a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705566232; x=1706171032; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=welEo0/WJxuhwoTNRxCpfyX7sfk5voOc4sTxJMWj2Aw=;
        b=X5r1MALBFW7ed78ST+6HoXg0Nu5rxmHBG0KX6AsJEKoSq2SZPRxGHTBsTjWSBkVVtZ
         +NWuZRx1AdDpyvlpWruNDuv1aP5EKvr/ry7Qv1wLHXd3BskwZxenyM0neB5tdLWDOBC4
         vvd290gTbbTRnN+PYblJEHY91cLuP7sEW/DFiUJYSCkUneY5+DZiIxn0h1gDpGQl3KqH
         Y1OtF50CFf6rnMgQO7uzJdq8GNHs3WHPGImliLbIDNEVIejVXrz5MmrgUKoZvJNEznP+
         gju2SwU2c+trLu1cHUbTkYSduSnX3Q5ZE+WRW/RsUnwYzSyCs2Wl87AWuaf2BAHA+UkR
         gACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705566232; x=1706171032;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=welEo0/WJxuhwoTNRxCpfyX7sfk5voOc4sTxJMWj2Aw=;
        b=CfBu8VaooQrMz6b3Gluu0vpug5A7rNCK5+ihyVUzcJG1VmTR9sqvoWTAGpkyMJN+47
         DWGgjb6p1W3Qy+zGhVkk2jafuX7X2CWOhwxS2QGK2NF488qgIVPzqYlWFJv0iZ8MvZ2X
         0obGeNZh9awas9z88M/PeOyXMCqt4LRHLI2se8H1l5fLJpGSd/8+FlRZIz4NzU/gNv5q
         a2SF3y9GbeWhQokcrAiPChye6AuEQyU9jTVyp2WdCIW/xAF0S4VZBnlUe3DoNjtmvtWT
         pl5XyWDA7GP/jamGMSxmEafSCbOoph3cOh2R/E1qA/J03V+AJXZAiKS7DI/skyZnw7n/
         AxQg==
X-Gm-Message-State: AOJu0Yx0nGSlvvC4RrqGf7W/nVL0LudKKpj0TlIn1c85fgnsi9B7yUGe
	3QYQgyUnLDIr3Citm6YYpjRJVK+ExQ5qaRKNaxVMQ6CTyg2znYBNguGgdZNaBV4=
X-Google-Smtp-Source: AGHT+IGaoDDx9aDO0YNH0g7XdpqbNuTcRdbMFDYtV1SQWylCAw0oi0AjU/zcDHvavTfmpNNLtZt26w==
X-Received: by 2002:a05:6a20:43a7:b0:19b:7e77:7279 with SMTP id i39-20020a056a2043a700b0019b7e777279mr643544pzl.18.1705566232336;
        Thu, 18 Jan 2024 00:23:52 -0800 (PST)
Received: from hsinchu15 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id fc13-20020a056a002e0d00b006d9cf4b56edsm2812458pfb.175.2024.01.18.00.23.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2024 00:23:51 -0800 (PST)
Date: Thu, 18 Jan 2024 16:23:47 +0800
From: Nylon Chen <nylon.chen@sifive.com>
To: alex@ghiti.fr
Cc: apatel@ventanamicro.com, alexghiti@rivosinc.com,
	catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, robh+dt@kernel.org,
	frowand.list@gmail.com, rppt@kernel.org, akpm@linux-foundation.org,
	anup@brainfault.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org, zong.li@sifive.com,
	nylon7717@gmail.com
Subject: Re: Fwd: [PATCH v8 0/4] riscv: Use PUD/P4D/PGD pages for the linear
 mapping
Message-ID: <20240118082346.GB31078@hsinchu15>
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <CAK9=C2XJtSG2d_nsyDv7kU1v7Jj0chdevqrMc0MpJswukcEABA@mail.gmail.com>
 <CAHVXubhhxpzHDM-n91V_rceY5t_VqLvrwZj3RP_tNL2=F9mqjQ@mail.gmail.com>
 <CAK9=C2WVOpSqtt8r1U4hnzSZ=cc1PocpukgQjNyahP2XuPhozw@mail.gmail.com>
 <d0087922-4721-ccf1-80bf-9f74099d0948@ghiti.fr>
 <CAPqJEFr6MgUyARfbWAo7EeQKLVd4xRJz_LOYN68UC-kPD1Hr5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPqJEFr6MgUyARfbWAo7EeQKLVd4xRJz_LOYN68UC-kPD1Hr5A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

> On 3/23/23 15:55, Anup Patel wrote:
> > On Thu, Mar 23, 2023 at 6:24 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >> Hi Anup,
> >>
> >> On Thu, Mar 23, 2023 at 1:18 PM Anup Patel <apatel@ventanamicro.com> wrote:
> >>> Hi Alex,
> >>>
> >>> On Thu, Mar 16, 2023 at 6:48 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >>>> This patchset intends to improve tlb utilization by using hugepages for
> >>>> the linear mapping.
> >>>>
> >>>> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
> >>>> take care of isolating the kernel text and rodata so that they are not
> >>>> mapped with a PUD mapping which would then assign wrong permissions to
> >>>> the whole region: it is achieved by introducing a new memblock API.
> >>>>
> >>>> Another patch makes use of this new API in arm64 which used some sort of
> >>>> hack to solve this issue: it was built/boot tested successfully.
> >>>>
> >>>> base-commit-tag: v6.3-rc1
> >>>>
> >>>> v8:
> >>>> - Fix rv32, as reported by Anup
> >>>> - Do not modify memblock_isolate_range and fixes comment, as suggested by Mike
> >>>> - Use the new memblock API for crash kernel too in arm64, as suggested by Andrew
> >>>> - Fix arm64 double mapping (which to me did not work in v7), but ends up not
> >>>>    being pretty at all, will wait for comments from arm64 reviewers, but
> >>>>    this patch can easily be dropped if they do not want it.
> >>>>
> >>>> v7:
> >>>> - Fix Anup bug report by introducing memblock_isolate_memory which
> >>>>    allows us to split the memblock mappings and then avoid to map the
> >>>>    the PUD which contains the kernel as read only
> >>>> - Add a patch to arm64 to use this newly introduced API
> >>>>
> >>>> v6:
> >>>> - quiet LLVM warning by casting phys_ram_base into an unsigned long
> >>>>
> >>>> v5:
> >>>> - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, thanks
> >>>>    Conor
> >>>> - Add RB from Andrew
> >>>>
> >>>> v4:
> >>>> - Rebase on top of v6.2-rc3, as noted by Conor
> >>>> - Add Acked-by Rob
> >>>>
> >>>> v3:
> >>>> - Change the comment about initrd_start VA conversion so that it fits
> >>>>    ARM64 and RISCV64 (and others in the future if needed), as suggested
> >>>>    by Rob
> >>>>
> >>>> v2:
> >>>> - Add a comment on why RISCV64 does not need to set initrd_start/end that
> >>>>    early in the boot process, as asked by Rob
> >>>>
> >>>> Alexandre Ghiti (4):
> >>>>    riscv: Get rid of riscv_pfn_base variable
> >>>>    mm: Introduce memblock_isolate_memory
> >>>>    arm64: Make use of memblock_isolate_memory for the linear mapping
> >>>>    riscv: Use PUD/P4D/PGD pages for the linear mapping
> >>> Kernel boot fine on RV64 but there is a failure which is still not
> >>> addressed. You can see this failure as following message in
> >>> kernel boot log:
> >>>      0.000000] Failed to add a System RAM resource at 80200000
> >> Hmmm I don't get that in any of my test configs, would you mind
> >> sharing yours and your qemu command line?
> > Try alexghiti_test branch at
> > https://github.com/avpatel/linux.git
> >
> > I am building the kernel using defconfig and my rootfs is
> > based on busybox.
> >
> > My QEMU command is:
> > qemu-system-riscv64 -M virt -m 512M -nographic -bios
> > opensbi/build/platform/generic/firmware/fw_dynamic.bin -kernel
> > ./build-riscv64/arch/riscv/boot/Image -append "root=/dev/ram rw
> > console=ttyS0 earlycon" -initrd ./rootfs_riscv64.img -smp 4
> 
> 
> So splitting memblock.memory is the culprit, it "confuses" the resources
> addition and I can only find hacky ways to fix that...
Hi Alexandre,

We encountered the same error as Anup. After adding your patch
(3335068f87217ea59d08f462187dc856652eea15), we will not encounter the
error again.

What I have observed so far is

- before your patch
When merging consecutive memblocks, if the memblock types are different,
they will be merged into reserved
- after your patch
When consecutive memblocks are merged, if the memblock types are
different, they will be merged into memory.

Such a result will cause the memory location of OpenSBI to be changed
from reserved to memory. Will this have any side effects?
> 
> So given that the arm64 patch with the new API is not pretty and that
> the simplest solution is to re-merge the memblock regions afterwards
> (which is done by memblock_clear_nomap), I'll drop the new API and the
> arm64 patch to use the nomap API like arm64: I'll take advantage of that
> to clean setup_vm_final which I have wanted to do for a long time.
> 
> @Mike Thanks for you reviews!
> 
> @Anup Thanks for all your bug reports on this patchset, I have to
> improve my test flow (it is in the work :)).
> 
> 
> > Regards,
> > Anup
> >
> >> Thanks
> >>
> >>> Regards,
> >>> Anup
> >>>
> >>>>   arch/arm64/mm/mmu.c           | 25 +++++++++++------
> >>>>   arch/riscv/include/asm/page.h | 19 +++++++++++--
> >>>>   arch/riscv/mm/init.c          | 53 ++++++++++++++++++++++++++++-------
> >>>>   arch/riscv/mm/physaddr.c      | 16 +++++++++++
> >>>>   drivers/of/fdt.c              | 11 ++++----
> >>>>   include/linux/memblock.h      |  1 +
> >>>>   mm/memblock.c                 | 20 +++++++++++++
> >>>>   7 files changed, 119 insertions(+), 26 deletions(-)
> >>>>
> >>>> --
> >>>> 2.37.2
> >>>>
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

