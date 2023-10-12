Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0560D7C7058
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJLOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjJLOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:33:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04202BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:33:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FB4C433C8;
        Thu, 12 Oct 2023 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697121199;
        bh=Ev2GnSgnN2D6OU+cvZem2qbvf+gC1yIh+IRKc5cJw4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moZ684sDcVQ3HUjjeJR3BezTmgl1nG8v7DSoDIUmhpckZKKm8jjW4bl1WVeCDljDA
         PO2cDZDaCvAeyM4+5HxUmn98bZ4rrukkScwXdVTcX6+Ex8MA+nD0QyiX2LdbZJt0CQ
         aQz7Rv5A8EZhKvSDKtb3uDBy3JcpYat99a7d4E8IrNEYnpmh5cAz+PMRLZaf4qQ9rH
         ale/nDMpo0ZMEoasY78mee7FeHuJjTRA63lT7TDgB1dxU8YKFeL4OABStDLK+G3F+z
         GabLbkcnBj5weEPXXv8cBBprFoNyP5aDGKjhBfXJxPvl+HJoXBxpsUF1hxSuc+L6TA
         YakNxuVJCvhvw==
Date:   Thu, 12 Oct 2023 22:21:08 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
Message-ID: <ZSgA1BtMv/YDHzQX@xhacker>
References: <20231012141456.4078-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012141456.4078-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:14:54PM +0800, Jisheng Zhang wrote:
> Previously, we use alternative mechanism to dynamically patch
> the CMO operations for THEAD C906/C910 during boot for performance
> reason. But as pointed out by Arnd, "there is already a significant
> cost in accessing the invalidated cache lines afterwards, which is
> likely going to be much higher than the cost of an indirect branch".
> And indeed, there's no performance difference with GMAC and EMMC per
> my test on Sipeed Lichee Pi 4A board.
> 
> Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> the alternative code, and to acchieve Arnd's goal -- "I think
> moving the THEAD ops at the same level as all nonstandard operations
> makes sense, but I'd still leave CMO as an explicit fast path that
> avoids the indirect branch. This seems like the right thing to do both
> for readability and for platforms on which the indirect branch has a
> noticeable overhead."
> 
> To make bisect easy, I use two patches here: patch1 does the conversion
> which just mimics current CMO behavior via. riscv_nonstd_cache_ops, I
> assume no functionalities changes. patch2 uses T-HEAD PA based CMO
> instructions so that we don't need to covert PA to VA.
> 
> Hi Guo,
> 
> I didn't use wback_inv for wback as you suggested during v1 reviewing,
> this can be left as future optimizations.
> 
> Thanks
> 
> since v2:
>   - collect Reviewed-by tag

Oh, I missed the tag collection, but I know maintainers are using b4 which can
collect and apply tags automatically ;). let me know if want a new
version.

>   - fix typo
> 
> since v1:
>   - collect Tested-by tag
>   - add patch2 to use T-HEAD PA based CMO instructions.
> 
> Jisheng Zhang (2):
>   riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
>   riscv: errata: thead: use pa based instructions for CMO
> 
>  arch/riscv/Kconfig.errata            |  1 +
>  arch/riscv/errata/thead/errata.c     | 69 +++++++++++++++++++++++++++-
>  arch/riscv/include/asm/errata_list.h | 50 +++-----------------
>  3 files changed, 74 insertions(+), 46 deletions(-)
> 
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
