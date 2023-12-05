Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485F28056BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbjLEOGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbjLEOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:06:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D318D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:06:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E145DC433C8;
        Tue,  5 Dec 2023 14:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701785181;
        bh=ztrbzYTZQKsvH33tkgl+qwxlT0HfVPRGVJ2xrk1JJVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmHmUefIXAFabqnUAvfcofVrTfm2RcsTluAm+Xmw61SuLNhe5yjfdiqa+lU2oaxIc
         icituGymcVYow/PXPTqTAU2Sqo89b3S0A+JRMA1Jx7l4b/n2Aeww8e2Usc35lDCyac
         OWDjd7AeeoAgpmfCtRU0yqekStpY1do1ZGxNlPaU+a9+NwwXcVwL61m9/VRLRVGiJs
         5XwNg2VDcZMo/+TY+qF2EjH5JAr46unQvCEebQkUgR9i1bq1ISFCza+QbUzPRk6XU1
         I82U8TSJlERrTvk7LvGS2LvCt5AeEgbrPjWuEJRXMaAMlcKvJe80r7OUtmJ9Tg7RZr
         M86gdse7FdLhA==
Date:   Tue, 5 Dec 2023 21:53:50 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Charlie Jenkins <charlie@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <ZW8rbgsTqmuLTvoK@xhacker>
References: <20231203135753.1575-1-jszhang@kernel.org>
 <20231203135753.1575-2-jszhang@kernel.org>
 <ZW4lUDpl0eZVNjrp@ghost>
 <20231205021406.GD1168@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205021406.GD1168@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 06:14:06PM -0800, Eric Biggers wrote:
> On Mon, Dec 04, 2023 at 11:15:28AM -0800, Charlie Jenkins wrote:
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 7f8aa25457ba..0a76209e9b02 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -654,6 +654,18 @@ config RISCV_MISALIGNED
> > >  	  load/store for both kernel and userspace. When disable, misaligned
> > >  	  accesses will generate SIGBUS in userspace and panic in kernel.
> > >  
> > > +config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > 
> > There already exists hwprobe for this purpose. If kernel code wants to
> > leverage the efficient unaligned accesses of hardware, it can use static
> > keys. I have a patch that will set this static key if the hardware was
> > detected to have fast unaligned accesses:
> > 
> > https://lore.kernel.org/linux-riscv/20231117-optimize_checksum-v11-2-7d9d954fe361@rivosinc.com/
> 
> Is the plan to make the get_unaligned* and put_unaligned* macros expand to code
> for both cases, and select between them using a static key?  Note that there are
> a very large number of callers of these macros in the kernel.  And what about
> kernel code that checks CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS directly?
> 
> AFAIK, no other Linux architecture supports kernel images where the unaligned
> access support is unknown at compile time.  It's not clear to me that such an
> approach is feasible.  A static key can easily be provided, but it's unclear
> what code would use it, given that currently lots of kernel code assumes that
> unaligned access support is known at compile time.
> 
> Meanwhile, there are people building kernels they know will only be deployed on
> systems where unaligned accesses are supported.  To me, it seems useful to
> provide a kconfig option for them to build a more efficient kernel.

Generally, I agree with Eric's above points. Various subsystem such as net, mm,
lib and so on have different code path for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
while Charlie's patch only touch partial code of arch/riscv, and even if those
subsystem maintainers agree with dynamic code patching(I still believe
persuading those subsystem maintainers is not easy), that's still a
huge task which needs to be done step by step. So before that, we'd
better let this series merged and benefit all efficient unaligned access
riscv systems. When the huge task is completed, we can remove the config
option.

Thanks
