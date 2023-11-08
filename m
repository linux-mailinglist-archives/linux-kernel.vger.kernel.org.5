Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D055F7E5C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjKHR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjKHR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:26:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC241BC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:26:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D3AC433C7;
        Wed,  8 Nov 2023 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699464366;
        bh=q1GZXP4sRw+ul4Jtvwv3+dY6DViWo2qiD2nXGTncu0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBwvdQkBjjEAYpVllBsIU7M5WlIOmdiQjZIdDFX6qEtra8NVzjISX0k8KEDpsYEvA
         yQ9Cqc0zNPbGx9lWDkc4DiLCCg3zHmtDSsOuEhISI3SRcKZ3mmIwSQE0Ix6qm6jzLd
         vcbomFvpb8Tl+K9sSvbWWCPc9FCT1TA91xq7eC/5dX3kVFj0l7V1B11JgBqUjIGr1f
         ZQt0VmB7hZLgDjYJrdiG7sUP04AUQxEdUOeE0wbE7oxQtqCYYLhrGJqFSb6kVDjkbP
         TIHBPYSVK67agcRwjakHjg8WOuQT1pNSSZ4PI7p9LvzaWzirO4x+hh6V4Hyh/WEAt2
         nx56PWQ2sZrAg==
Date:   Thu, 9 Nov 2023 01:13:48 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
Message-ID: <ZUvBzDytyoz/Hqvk@xhacker>
References: <20231012143746.454-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012143746.454-1-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:37:44PM +0800, Jisheng Zhang wrote:
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

Hi Palmer,

I know you are busy ;) Just want to know is there any chance for this
series to be merged for v6.7?

Thanks
> 
> Hi Guo,
> 
> I didn't use wback_inv for wback as you suggested during v1 reviewing,
> this can be left as future optimizations.
> 
> Thanks
> 
> since v3:
>   - collect Reviewed-by tag
> 
> since v2:
>   - collect Reviewed-by tag (but missed them in fact)
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
