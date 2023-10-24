Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D128A7D4D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjJXKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjJXKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:14:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFA9B118;
        Tue, 24 Oct 2023 03:13:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2845F2F4;
        Tue, 24 Oct 2023 03:14:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.68.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A36513F64C;
        Tue, 24 Oct 2023 03:13:56 -0700 (PDT)
Date:   Tue, 24 Oct 2023 11:13:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH v2] arm64: module: PLT allowed even !RANDOM_BASE
Message-ID: <ZTeY0oBH3P22yOqA@FVFF77S0Q05N>
References: <20231024010954.6768-1-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024010954.6768-1-quic_aiquny@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 09:09:54AM +0800, Maria Yu wrote:
> Module PLT feature can be enabled even when RANDOM_BASE is disabled.
> Break BLT entry counts of relocation types will make module plt entry
> allocation fail and finally exec format error for even correct and plt
> allocation available modules.

The patch itself looks good; it would be better if we could make the commit
message explicit that this is a fix. Could we please replace that with:

| arm64: module: fix PLT counting when CONFIG_RANDOMIZE_BASE=n
| 
| The counting of module PLTs has been broken when CONFIG_RANDOMIZE_BASE=n
| since commit:
| 
|   3e35d303ab7d22c4 ("arm64: module: rework module VA range selection")
| 
| Prior to that commit, when CONFIG_RANDOMIZE_BASE=n, the kernel image and
| all modules were placed within a 128M region, and no PLTs were necessary
| for B or BL. Hence count_plts() and partition_branch_plt_relas() skipped
| handling B and BL when CONFIG_RANDOMIZE_BASE=n.
| 
| After that commit, modules can be placed anywhere within a 2G window
| regardless of CONFIG_RANDOMIZE_BASE, and hence PLTs may be necessary for
| B and BL even when CONFIG_RANDOMIZE_BASE=n. Unfortunately that commit
| failed to update count_plts() and partition_branch_plt_relas()
| accordingly.
| 
| Due to this, module_emit_plt_entry() may fail if an insufficient number
| of PLT entries have been reserved, resulting in modules failing to load
| with -ENOEXEC.
|
| Fix this by counting PLTs regardless of CONFIG_RANDOMIZE_BASE in 
| count_plts() and partition_branch_plt_relas().

... and add a fixes tag:

Fixes: 3e35d303ab7d22c4 ("arm64: module: rework module VA range selection")

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>  arch/arm64/kernel/module-plts.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index bd69a4e7cd60..79200f21e123 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -167,9 +167,6 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
>  		switch (ELF64_R_TYPE(rela[i].r_info)) {
>  		case R_AARCH64_JUMP26:
>  		case R_AARCH64_CALL26:
> -			if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -				break;
> -
>  			/*
>  			 * We only have to consider branch targets that resolve
>  			 * to symbols that are defined in a different section.
> @@ -269,9 +266,6 @@ static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
>  {
>  	int i = 0, j = numrels - 1;
>  
> -	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -		return 0;
> -
>  	while (i < j) {
>  		if (branch_rela_needs_plt(syms, &rela[i], dstidx))
>  			i++;
> 
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> -- 
> 2.17.1
> 
