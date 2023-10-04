Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ADF7B7EEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbjJDMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjJDMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:19:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500E6B0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:19:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A09C433C7;
        Wed,  4 Oct 2023 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696421980;
        bh=Jjv+CIZgDjDEX/17AWRFDrfvrea0mMzt1tHHLzjMDhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAcdhEBL+OvdiOlN1gqsikDxDKbJgV7ZN6NkjJqaOhajhIAe64VzacCg03JZ5U4W3
         Q1N2ZuhuCkSBttSxuWRpl9w+Ta24ATd7f3ZKhFYoDawizaQxrTaJAmdEESSGU8odye
         NKgDKgTXqUuwEggQ7rLy9qoDoLGy4vKhjJWz+5raTcbFLRbcLiamifjkGDcF+mg6Jc
         6CcN5J7HuMPDYk03BG92kNN7n+keXt7cU5ALkR7Qksz+30dBDK8gl0BwVVCouml5xD
         8qTId8y4ImeJZi0q+T6qYyAZxKbkPx/XhjHcukdEGat6AGXw0xWYWMBHZsHgjMuBGV
         HLTyVimzl0Bqw==
Date:   Wed, 4 Oct 2023 20:07:35 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2] riscv: mm: update T-Head memory type definitions
Message-ID: <ZR1Vh6kXay3uNvs0@xhacker>
References: <20230912072510.2510-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912072510.2510-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:25:10PM +0800, Jisheng Zhang wrote:
> Update T-Head memory type definitions according to C910 doc [1]
> For NC and IO, SH property isn't configurable, hardcoded as SH,
> so set SH for NOCACHE and IO.
> 
> And also set bit[61](Bufferable) for NOCACHE according to the
> table 6.1 in the doc [1].
> 
> Link: https://github.com/T-head-Semi/openc910 [1]
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Tested-by: Drew Fustini <dfustini@baylibre.com>

Hi Palmer,

I believe this is a fix, could you please review and take it for 6.6
fix?

Thanks

> ---
> 
> Since v1:
>  - collect Reviewed-by and Tested-by tag
>  - rebase on linux 6.6-rc1
> 
>  arch/riscv/include/asm/pgtable-64.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 7a5097202e15..9a2c780a11e9 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -126,14 +126,18 @@ enum napot_cont_order {
>  
>  /*
>   * [63:59] T-Head Memory Type definitions:
> - *
> - * 00000 - NC   Weakly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
> + * bit[63] SO - Strong Order
> + * bit[62] C - Cacheable
> + * bit[61] B - Bufferable
> + * bit[60] SH - Shareable
> + * bit[59] Sec - Trustable
> + * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, Non-trustable
>   * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
> - * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
> + * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
>   */
>  #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
> -#define _PAGE_NOCACHE_THEAD	0UL
> -#define _PAGE_IO_THEAD		(1UL << 63)
> +#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
> +#define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
>  #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
>  
>  static inline u64 riscv_page_mtmask(void)
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
