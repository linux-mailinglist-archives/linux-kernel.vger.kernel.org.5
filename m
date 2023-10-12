Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4344B7C704A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378990AbjJLO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378679AbjJLO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:29:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F1B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:29:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A60C433CB;
        Thu, 12 Oct 2023 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697120977;
        bh=CbyeFLuAiEasZtHALx1Y0pmtF2I8Cj6/dbf/zW55VS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtoLPg323lnx4rDDFh52ErfvO6Lh6rYnZE3c7kBFuX0QcAufzqbECI6EXYEvDPuRG
         WvkWIFXpTxWqvoxMG63t7BzjvOtYlqtOHNI5YHwuToujQYCxIyNADCg6wZp5xjuJKN
         N7kS2ZKIFYyvxR8p25TQ2Uf787JjweoVSiGIBw1O0RXQM9rpTjrtcXjGXlAcmLSrln
         88KKvNGbOegfJckm3rWWwPvDvawdktOEV6HRtP8Iv0IH9Cof2slgxClgYG61LyEIvw
         P00CWUTUgBp/M1A1r7eYkCn1EWvBokQIJVGiLx6Sm7jSZ86A59ED9tLyv6QNY5t7MS
         KvOu7cB2jlXqw==
Date:   Thu, 12 Oct 2023 22:17:26 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v2 1/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
Message-ID: <ZSf/9oxUHIG0XiXQ@xhacker>
References: <20231001103433.3187-1-jszhang@kernel.org>
 <20231001103433.3187-2-jszhang@kernel.org>
 <41b3c8c8-260d-4de1-92a4-245973274a60@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41b3c8c8-260d-4de1-92a4-245973274a60@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 02:43:18PM +0200, Clément Léger wrote:
> 
> 
> On 01/10/2023 12:34, Jisheng Zhang wrote:
> > Previously, we use alternative mechanism to dynamically patch
> > the CMO operations for THEAD C906/C910 during boot for performance
> > reason. But as pointed out by Arnd, "there is already a significant
> > cost in accessing the invalidated cache lines afterwards, which is
> > likely going to be much higher than the cost of an indirect branch".
> > And indeed, there's no performance difference with GMAC and EMMC per
> > my test on Sipeed Lichee Pi 4A board.
> > 
> > Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> > the alternative code, and to acchieve Arnd's goal -- "I think
> > moving the THEAD ops at the same level as all nonstandard operations
> > makes sense, but I'd still leave CMO as an explicit fast path that
> > avoids the indirect branch. This seems like the right thing to do both
> > for readability and for platforms on which the indirect branch has a
> > noticeable overhead."
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > ---
> >  arch/riscv/Kconfig.errata            |  1 +
> >  arch/riscv/errata/thead/errata.c     | 75 +++++++++++++++++++++++++++-
> >  arch/riscv/include/asm/errata_list.h | 50 +++----------------
> >  3 files changed, 80 insertions(+), 46 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index 566bcefeab50..d7972914f9de 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -78,6 +78,7 @@ config ERRATA_THEAD_CMO
> >  	bool "Apply T-Head cache management errata"
> >  	depends on ERRATA_THEAD && MMU
> >  	select RISCV_DMA_NONCOHERENT
> > +	select RISCV_NONSTANDARD_CACHE_OPS
> >  	default y
> >  	help
> >  	  This will apply the cache management errata to handle the
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index 0554ed4bf087..3fefeb1b456e 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -12,8 +12,10 @@
> >  #include <asm/alternative.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/dma-noncoherent.h>
> >  #include <asm/errata_list.h>
> >  #include <asm/hwprobe.h>
> > +#include <asm/io.h>
> >  #include <asm/patch.h>
> >  #include <asm/vendorid_list.h>
> >  
> > @@ -33,6 +35,75 @@ static bool errata_probe_pbmt(unsigned int stage,
> >  	return false;
> >  }
> >  
> > +/*
> > + * dcache.ipa rs1 (invalidate, physical address)
> > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > + *   0000001    01010      rs1       000      00000  0001011
> > + * dache.iva rs1 (invalida, virtual address)
> 
> Small typo here: invalidate instead of invalida

another typo: s/dache/dcache
these typo have existed there for a long time ;) I just fixed them in
v3.

Thanks for pointing this out.
