Return-Path: <linux-kernel+bounces-90260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D886FC91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97CD1F22FA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6C1B5B2;
	Mon,  4 Mar 2024 09:00:12 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C51A28C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542811; cv=none; b=jL8sQSqM567sdNoHOs1HcjDs0lUogoXfyqGIMcCEIMd2j+7+IijAg/nK4zqBLtluUV1HPtUBvQQrkY6mLbxfuppJZxIk7emq+kVCDSeT6ARsGKwLqYsJrTY+X1faQBhQKVuMAmRjUKY3P4qhXmUM8f59Koknq98zFTILDHYl71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542811; c=relaxed/simple;
	bh=fkFvKS6wbb3bjx6Xi0ab716kzkSQfBfhQVCG+goLYcY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tZ/Ouj6cR5ORswz/cTGIT5RetJsTxYtb9fzqYxXey3ZOss/CsspDVs9ylKHBUQ3St6+mmLss1d32QFr6I6aAcO3PjjhhRv+z5Y2FG+0oAVZJgmFFtCDGiP2ThqXZ+1D0eS2Gd2aTgICgz42yEtN1l12jqGF1EjxE6iivUERNS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by albert.telenet-ops.be with bizsmtp
	id uZ072B00D2qflky06Z074z; Mon, 04 Mar 2024 10:00:07 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rh4B5-002H9k-C1;
	Mon, 04 Mar 2024 10:00:07 +0100
Date: Mon, 4 Mar 2024 10:00:07 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: sparclinux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.8-rc7
In-Reply-To: <20240304083122.361773-1-geert@linux-m68k.org>
Message-ID: <35a869c8-52e8-177-1d4d-e57578b99b6@linux-m68k.org>
References: <CAHk-=wgwt9b3yMxAQRCVJ0Jh6-4Dz1Fgo2au7g_U9VWVxXoS6Q@mail.gmail.com> <20240304083122.361773-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 4 Mar 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.8-rc7[1] to v6.8-rc6[3], the summaries are:
>  - build errors: +6/-0

   + /kisskb/src/drivers/sbus/char/bbc_envctrl.c: error: no previous prototype for 'bbc_envctrl_cleanup' [-Werror=missing-prototypes]:  => 594:6
   + /kisskb/src/drivers/sbus/char/bbc_envctrl.c: error: no previous prototype for 'bbc_envctrl_init' [-Werror=missing-prototypes]:  => 566:5

sparc64-gcc13/sparc64-allmodconfig (seen before)

   + /kisskb/src/include/linux/rcupdate.h: error: dereferencing pointer to incomplete type 'struct dpll_pin':  => 462:36

arm64-gcc5/arm64-allmodconfig
mips-gcc8/mips-allmodconfig
powerpc-gcc5/powerpc-all{mod,yes}config
powerpc-gcc5/{ppc32,ppc64_book3e,ppc64le}_allmodconfig
sparc64-gcc5/sparc{,64}-allmodconfig
x86_64-gcc8/x86-allmodconfig

     src/net/core/dev.c: In function 'netdev_dpll_pin_assign':
     include/linux/rcupdate.h:462:36: error: dereferencing pointer to incomplete type 'struct dpll_pin'
      #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
 					^~~~
     include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONCE'
       *(volatile typeof(x) *)&(x) = (val);    \
 				     ^~~
     arch/x86/include/asm/barrier.h:67:2: note: in expansion of macro 'WRITE_ONCE'
       WRITE_ONCE(*p, v);      \
       ^~~~~~~~~~
     include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
      #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
 							   ^~~~~~~~~~~~~~~~~~~
     include/linux/rcupdate.h:503:3: note: in expansion of macro 'smp_store_release'
        smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
        ^~~~~~~~~~~~~~~~~
     include/linux/rcupdate.h:503:25: note: in expansion of macro 'RCU_INITIALIZER'
        smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
 			     ^~~~~~~~~~~~~~~
     net/core/dev.c:9081:2: note: in expansion of macro 'rcu_assign_pointer'
       rcu_assign_pointer(dev->dpll_pin, dpll_pin);
       ^~~~~~~~~~~~~~~~~~

   + {standard input}: Error: invalid operands for opcode:  => 606
   + {standard input}: Error: missing operand:  => 606
   + {standard input}: Error: unknown pseudo-op: `.cfi_def_cfa_offse':  => 605

SH ICE crickets

*** WARNINGS ***

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/90d35da658da8cff0d4ecbb5113f5fac9d00eb72/ (138 out of 239 configs)

> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d206a76d7d2726f3b096037f2079ce0bd3ba329b/ (138 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

