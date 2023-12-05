Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712BD804482
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjLECOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLECOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:14:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D782109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:14:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC604C433C7;
        Tue,  5 Dec 2023 02:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701742448;
        bh=Ptz0fJBcWbfsG0oxaIzA0E/svH7JZtCOrjX9y9bQLyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKx3XjHV3fTHtX9IMh4wMxd+mVu98af3QIcNrtzqEa3jNUUtHdGghmc6Z2WnBvkgy
         EuauIQv3c4Q6CIXeFFVtbZqOuirDPCPCxrWOZONK6Hq0mQtvO7ahX7eCydaQOEVKDh
         0XdHojXjflQkf+c0CZmhyLW2JAQmza7Php6CpJY+WXUINDPcWYxM+nBrGyTveFFx9s
         ZPa6/HvB08+sl/dp/NyYdr44vhuwkJo9LfpGKtuzwcXyfsZm+ak9uZyjk2PrPR+vVA
         9UIyHsq0OpwPVZd5YweB1/SIvaEAl1eYFVpFpnDORY01+Ffl89IFTmn8K5tecOWH3O
         DyBqbwOU/D2AQ==
Date:   Mon, 4 Dec 2023 18:14:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <20231205021406.GD1168@sol.localdomain>
References: <20231203135753.1575-1-jszhang@kernel.org>
 <20231203135753.1575-2-jszhang@kernel.org>
 <ZW4lUDpl0eZVNjrp@ghost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW4lUDpl0eZVNjrp@ghost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:15:28AM -0800, Charlie Jenkins wrote:
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 7f8aa25457ba..0a76209e9b02 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -654,6 +654,18 @@ config RISCV_MISALIGNED
> >  	  load/store for both kernel and userspace. When disable, misaligned
> >  	  accesses will generate SIGBUS in userspace and panic in kernel.
> >  
> > +config RISCV_EFFICIENT_UNALIGNED_ACCESS
> 
> There already exists hwprobe for this purpose. If kernel code wants to
> leverage the efficient unaligned accesses of hardware, it can use static
> keys. I have a patch that will set this static key if the hardware was
> detected to have fast unaligned accesses:
> 
> https://lore.kernel.org/linux-riscv/20231117-optimize_checksum-v11-2-7d9d954fe361@rivosinc.com/

Is the plan to make the get_unaligned* and put_unaligned* macros expand to code
for both cases, and select between them using a static key?  Note that there are
a very large number of callers of these macros in the kernel.  And what about
kernel code that checks CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS directly?

AFAIK, no other Linux architecture supports kernel images where the unaligned
access support is unknown at compile time.  It's not clear to me that such an
approach is feasible.  A static key can easily be provided, but it's unclear
what code would use it, given that currently lots of kernel code assumes that
unaligned access support is known at compile time.

Meanwhile, there are people building kernels they know will only be deployed on
systems where unaligned accesses are supported.  To me, it seems useful to
provide a kconfig option for them to build a more efficient kernel.

- Eric
