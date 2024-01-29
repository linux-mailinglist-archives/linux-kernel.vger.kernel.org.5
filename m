Return-Path: <linux-kernel+bounces-42584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4284037A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677561F22B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1EC5B20C;
	Mon, 29 Jan 2024 11:06:41 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA605B5DE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526401; cv=none; b=ILkHfneUoAqw6rSoNItDLsBHwl8qaTMFaVAi6V7J4uLR5TwbMbbVbZjDdRlNu+7TNjKgafzWfdeWU0S9aBp0wXPDe83TMJUOeMikVhY8UMBFxKV9qL5dOtcrN3d61S7Bcyxepzujy81UsOerAyBkSPOy9H91BO5dJ8EJpGZoOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526401; c=relaxed/simple;
	bh=bN8edVEibQUi4cNIoeXwKAWhUhuvpW1rx432LV6Rp34=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TidUNRCYrll1QfEGHtW3QJg9PUlh4qrcfFYUAVlGiu0PFwbKy5mapQIF1sg7qiJE7k+WjbQJxYfrLJxn2YID7PSwVZC5RKjd+pL3BOIi83AGs/mQ3t+z34EyiZY5kOS1Teqez1IM4KQzpp8l3qtYHQvWPVD0CalrjKDsaWjFpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3b5f:c6ad:b5fc:a0f3])
	by laurent.telenet-ops.be with bizsmtp
	id gb6X2B0022ZPkuY01b6XDK; Mon, 29 Jan 2024 12:06:31 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rUPTC-00GgzQ-W5;
	Mon, 29 Jan 2024 12:06:31 +0100
Date: Mon, 29 Jan 2024 12:06:30 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: Build regressions/improvements in v6.8-rc2
In-Reply-To: <20240129104954.1778339-1-geert@linux-m68k.org>
Message-ID: <8ea40b3-adde-acb5-5e46-fe1fd395daf@linux-m68k.org>
References: <CAHk-=wgxzm+Oc1ywuNGxb1R1=ZEC85LJi776R2QEpk6=_2Qfdw@mail.gmail.com> <20240129104954.1778339-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Jan 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.8-rc2[1] to v6.8-rc1[3], the summaries are:
>  - build errors: +26/-14


   + /kisskb/src/arch/sparc/kernel/setup_64.c: error: no previous prototype for 'alloc_irqstack_bootmem' [-Werror=missing-prototypes]:  => 602:13

sparc64-gcc{5,1[123]}/sparc64-{allno,def}config

   + /kisskb/src/drivers/gpu/drm/nouveau/nvif/object.c: error: 'memcpy' specified bound between 4294967240 and 4294967263 exceeds maximum object size 2147483647 [-Werror=stringop-overflow=]:  => 298:17
   + /kisskb/src/drivers/gpu/drm/nouveau/nvif/object.c: error: 'memcpy' specified bound between 4294967264 and 4294967287 exceeds maximum object size 2147483647 [-Werror=stringop-overflow=]:  => 161:9

parisc-gcc1[23]/generic-32bit_defconfig
parisc-gcc1[23]/parisc-{allmod,def}config

   + /kisskb/src/drivers/hwmon/pc87360.c: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]:  => 383:51

arm64-gcc12/arm64-allmodconfig
parisc-gcc12/parisc-allmodconfig

   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1045' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1065' declared with attribute error: FIELD_PREP: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1084' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1095' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1137' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1139' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1148' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1150' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_924' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_935' declared with attribute error: FIELD_GET: mask is not constant:  => 435:38

in drivers/gpu/drm/xe/xe_guc_ct.c:526
arm64-gcc5/arm64-allmodconfig
powerpc-gcc5/powerpc-all{mod,yes}config
powerpc-gcc5/ppc{32,64le,64_book3e}_allmodconfig
(seen before in v6.8-rc1, with different assertion numbers)

   + /kisskb/src/include/linux/fortify-string.h: error: writing 16 bytes into a region of size 0 [-Werror=stringop-overflow=]:  => 57:33

in drivers/gpu/drm/xe/xe_gt_pagefault.c:340
arm64-gcc13/arm64-allmodconfig
s390x-gcc13/s390-all{mod,yes}config

   + {standard input}: Error: displacement to undefined symbol .L101 overflows 8-bit field :  => 593
   + {standard input}: Error: displacement to undefined symbol .L104 overflows 8-bit field :  => 588
   + {standard input}: Error: displacement to undefined symbol .L139 overflows 8-bit field :  => 606
   + {standard input}: Error: displacement to undefined symbol .L73 overflows 12-bit field:  => 594
   + {standard input}: Error: displacement to undefined symbol .L74 overflows 8-bit field :  => 585
   + {standard input}: Error: displacement to undefined symbol .L75 overflows 12-bit field: 606, 586 => 589, 606, 586
   + {standard input}: Error: displacement to undefined symbol .L76 overflows 8-bit field : 577 => 580, 577
   + {standard input}: Error: displacement to undefined symbol .L80 overflows 8-bit field : 601 => 601, 607
   + {standard input}: Error: displacement to undefined symbol .L81 overflows 8-bit field : 606, 604 => 604, 610, 606
   + {standard input}: Error: displacement to undefined symbol .L96 overflows 12-bit field:  => 602
   + {standard input}: Error: displacement to undefined symbol .L99 overflows 12-bit field:  => 607

The usual SH ICE crickets.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/41bccc98fb7931d63d03f326a746ac4d429c1dd3/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6613476e225e090cc9aad49be7fa504e290dd33d/ (all 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

