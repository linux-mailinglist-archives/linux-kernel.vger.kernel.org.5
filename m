Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508F768612
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjG3OhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjG3OhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:37:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9238ECA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 07:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E75A60BA6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8F2C433C7;
        Sun, 30 Jul 2023 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690727839;
        bh=o8Gc/P95YN1AULlhWvUaiLcwNxlJDRgI2XG/sKEwRNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TI1dt1FfjHIB0V9hdfVRp9AMihxBSWpNay0ysWMhBiDC54h7dMWfyeQ1qfazV86WN
         shsVtSHgyG8p1iRnpbQVJzdPZ09ufOgctfLzqZHbmfYAHhBoU601NfMFRJWR9mngTf
         8YSSmGysWque4KUxitWc5S1cj7zlcF0ysA0SRSjjDPVY1Ew2xMPTK/V+C0TZuKQcfs
         dlnL3zr6m3+yNAFs+vWuIVUWabEx9k1SjmmQZZXD9OAAIxNJA9wdg270VER3Q+rLqW
         X2j46UZgALPO9Pm7MEbWEtg0HxxUdN+03/3TJi+h5Klvpi9lZJbb00gUZyZZqKBrct
         LqmLJKBLTZXCQ==
Date:   Sun, 30 Jul 2023 22:25:41 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: enable DEBUG_FORCE_FUNCTION_ALIGN_64B
Message-ID: <ZMZy5ZA0POhm2tAQ@xhacker>
References: <20230727160356.3874-1-jszhang@kernel.org>
 <20230729-shucking-slang-370c6baa358e@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230729-shucking-slang-370c6baa358e@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 11:34:38AM +0100, Conor Dooley wrote:
> Hey,
> 
> On Fri, Jul 28, 2023 at 12:03:56AM +0800, Jisheng Zhang wrote:
> > Allow to force all function address 64B aligned as it is possible for
> > other architectures. This may be useful when verify if performance
> > bump is caused by function alignment changes.
> > 
> > Before commit 1bf18da62106 ("lib/Kconfig.debug: add ARCH dependency
> > for FUNCTION_ALIGN option"), riscv supports enabling the
> > DEBUG_FORCE_FUNCTION_ALIGN_64B option, but after that commit, each
> > arch needs to claim the support explicitly. I tried the config file in
> > [1] for both RV64 and RV32, I can't reproduce the build error as [1],
> > there is no reason for not allowing to enforce this function alignment.
> > 
> > Link: https://lore.kernel.org/lkml/202202271612.W32UJAj2-lkp@intel.com/ [1]
> 
> This is a CSKY randconfig, is there any particular reason that running
> that randconfig (over a year later) and on a different architecture
> would trigger whatever the condition was?

Just use the randconfig and then s/CSKY/RISCV to check whether RV32
and RV64 can reproduce the compile error ;)

> 
> The original commit here seems far too penal - why was it not just
> disabled on CSKY??? I tried looking a bit on lore, but didn't see
> anything explaining the subset of supported archs they picked.
> I did see Guo Ren wondering if rv32 would be similarly problematic - but
> since this is something likely to just trip up randconfigs, I think we
> should go for it and if rv32 becomes a problem, restrict this to 64-bit.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  lib/Kconfig.debug | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index fbc89baf7de6..39ffd218e960 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -502,7 +502,7 @@ config SECTION_MISMATCH_WARN_ONLY
> >  
> >  config DEBUG_FORCE_FUNCTION_ALIGN_64B
> >  	bool "Force all function address 64B aligned"
> > -	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC || S390)
> > +	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC || RISCV || S390)
> >  	select FUNCTION_ALIGNMENT_64B
> >  	help
> >  	  There are cases that a commit from one domain changes the function
> > -- 
> > 2.40.1
> > 


