Return-Path: <linux-kernel+bounces-66010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2211855530
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41F31C22569
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF6A13F013;
	Wed, 14 Feb 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EGrvNimn"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC318E0C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947827; cv=none; b=lTvzGy4zfPY8rx7S58mgmye77B0E4K4Zr9X9bWKfeu41tvgSrgiIMV30iq6txyVTk09oCAWcryVA+QGbkY4yCiTawWjHUeSDe6mvPjdKg6oc0BOmq7I6oiHHOMqLnaK3DDh99OrRXA5qhkA6swvnQUR1M4gdzp+1MFW6sBlee50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947827; c=relaxed/simple;
	bh=M2VX53hh2X2+EDZ9L6EW8YSDDt5OHDvGvJYbu8/dn38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aQ+NUXl7/Y0RHkKe+YU8UTQqq+5ZRplbtGo4CFvDhd3OpujMLYowh4hE/h/PwB7TFaXShuInPMD4DRLQvYIdSp45/GbbYBsR36oQyFEmsLjp0LqIBjHZZAezMPpK8M1gtvz697ea/mHeNPgVFa0NoZanv0HBPUTDt8Kslr/6194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=EGrvNimn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1707947821;
	bh=ptVY8+ctsEMPdzQdMVEcEaylbr4N9FMoA+0k/Zm7vvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EGrvNimnx3BgExLs+6EE6sBnci2Wyn1SmyHYST8YoKmsjteL24VJ1RqdGiuvUJeLn
	 urHV4WCzxmFQbyh/4ecwRbZBROvSzbRhSXj/uVhWJDupWoYClulsQOtz/QavCw2kUI
	 +1agm6/2zUxzdaaO90cQESACk/IeqZ5WWu+SgAGu89qz/IipGnoSg0+6Cw34ss/Lgg
	 Stpl97P/OrKl47x2zE/UuqcquMI8/mfO0QOixENxDblJiLZpvK1uMI+Nloz0ngrJZv
	 N3LeXGLRvjxaFJ6u86npcfuX13XR9pYsrlzKfn55vAPN4XK4OtILfeM/sQ80caoHhE
	 RVgwW+JtWteZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZsVN6WXmz4wcb;
	Thu, 15 Feb 2024 08:57:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Gal
 Pressman <gal@nvidia.com>
Subject: Re: [PATCH] powerpc/64s: Increase default stack size to 32KB
In-Reply-To: <87ttmau5mg.fsf@nvidia.com>
References: <20231215124449.317597-1-mpe@ellerman.id.au>
 <87ttmau5mg.fsf@nvidia.com>
Date: Thu, 15 Feb 2024 08:56:59 +1100
Message-ID: <87cysy7lqs.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rahul Rameshbabu <rrameshbabu@nvidia.com> writes:
> On Fri, 15 Dec, 2023 23:44:49 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>> There are reports of kernels crashing due to stack overflow while
>> running OpenShift (Kubernetes). The primary contributor to the stack
>> usage seems to be openvswitch, which is used by OVN-Kubernetes (based on
>> OVN (Open Virtual Network)), but NFS also contributes in some stack
>> traces.
>>
>> There may be some opportunities to reduce stack usage in the openvswitch
>> code, but doing so potentially require tradeoffs vs performance, and
>> also requires testing across architectures.
>>
>> Looking at stack usage across the kernel (using -fstack-usage), shows
>> that ppc64le stack frames are on average 50-100% larger than the
>> equivalent function built for x86-64. Which is not surprising given the
>> minimum stack frame size is 32 bytes on ppc64le vs 16 bytes on x86-64.
>>
>> So increase the default stack size to 32KB for the modern 64-bit Book3S
>> platforms, ie. pseries (virtualised) and powernv (bare metal). That
>> leaves the older systems like G5s, and the AmigaOne (pasemi) with a 16KB
>> stack which should be sufficient on those machines.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>
> We noticed this change is causing assembler issues for us when building
> the kernel.
>
>   make ARCH=powerpc KERNELRELEASE=6.8.0-rc2_for_upstream_debug_2024_02_06_20_01 KBUILD_BUILD_VERSION=1
>   arch/powerpc/kernel/switch.S: Assembler messages:
>   arch/powerpc/kernel/switch.S:249: Error: operand out of range (0x000000000000fe50 is not between 0xffffffffffff8000 and 0x0000000000007fff)
>   make[6]: *** [scripts/Makefile.build:361: arch/powerpc/kernel/switch.o] Error 1
>   make[5]: *** [scripts/Makefile.build:481: arch/powerpc/kernel] Error 2
>   make[5]: *** Waiting for unfinished jobs....
>   make[4]: *** [scripts/Makefile.build:481: arch/powerpc] Error 2
>   make[4]: *** Waiting for unfinished jobs....
>   make[3]: *** [Makefile:1921: .] Error 2

There's a fix in my fixes branch:
  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=f1acb109505d983779bbb7e20a1ee6244d2b5736

I'll send it to Linus this week.

cheers

