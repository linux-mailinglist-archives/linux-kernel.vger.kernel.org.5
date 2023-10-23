Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1DF7D2D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjJWJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjJWJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:02:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEBF198;
        Mon, 23 Oct 2023 02:02:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2812F4;
        Mon, 23 Oct 2023 02:03:22 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1B703F64C;
        Mon, 23 Oct 2023 02:02:39 -0700 (PDT)
Date:   Mon, 23 Oct 2023 10:02:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maria Yu <quic_aiquny@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] arm64: module: PLT allowed even !RANDOM_BASE
Message-ID: <ZTY2rdkY5FfTBUVL@FVFF77S0Q05N>
References: <20231023075714.21672-1-quic_aiquny@quicinc.com>
 <56c2d30b-2f25-4613-aab1-00fccbd2fa05@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c2d30b-2f25-4613-aab1-00fccbd2fa05@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:08:33AM +0200, Arnd Bergmann wrote:
> On Mon, Oct 23, 2023, at 09:57, Maria Yu wrote:
> > Module PLT feature can be enabled even when RANDOM_BASE is disabled.
> > Break BLT entry counts of relocation types will make module plt entry
> > allocation fail and finally exec format error for even correct and plt
> > allocation available modules.

Has an actual problem been seen in practice, or was this found by looking at
the code?

> >
> > Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> 
> Adding Ard Biesheuvel to Cc, as he added the check in commit
> a257e02579e42 ("arm64/kernel: don't ban ADRP to work around
> Cortex-A53 erratum #843419")

I think that the actual mistake is in commit:

  3e35d303ab7d22c4 ("arm64: module: rework module VA range selection")

Prior to that commit, when CONFIG_RANDOMIZE_BASE=n all modules and code had to
be within 128M of each other, and so there were no PLTs necessary for B/BL.
After that commit we can have a 2G module range regardless of
CONFIG_RANDOMIZE_BASE, and PLTs may be necessary for B/BL.

We should have removed the check for !CONFIG_RANDOMIZE_BASE as part of that.

> >  arch/arm64/kernel/module-plts.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/module-plts.c 
> > b/arch/arm64/kernel/module-plts.c
> > index bd69a4e7cd60..21a67d52d7a0 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -167,9 +167,6 @@ static unsigned int count_plts(Elf64_Sym *syms, 
> > Elf64_Rela *rela, int num,
> >  		switch (ELF64_R_TYPE(rela[i].r_info)) {
> >  		case R_AARCH64_JUMP26:
> >  		case R_AARCH64_CALL26:
> > -			if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > -				break;
> > -
> >  			/*
> >  			 * We only have to consider branch targets that resolve
> >  			 * to symbols that are defined in a different section.
> 
> I see there are two such checks (in partition_branch_plt_relas()
> and in count_plts()), can you explain in more detail how you
> concluded that one of them is correct but the other one is not?

I believe that the one in partition_branch_plt_relas() needs to go too; that's
just a minor optimization for the case where there shouldn't be any PLTs for
B/BL, and it no longer holds after the module VA range rework.

That was introduced in commit:

  d4e0340919fb9190 ("arm64/module: Optimize module load time by optimizing PLT counting")

Thanks,
Mark.
