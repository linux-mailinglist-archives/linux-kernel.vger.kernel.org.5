Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71D7CC178
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbjJQLFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjJQLFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:05:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08EB0A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:05:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D61B2F4;
        Tue, 17 Oct 2023 04:05:55 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.68.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 581FC3F5A1;
        Tue, 17 Oct 2023 04:05:13 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:05:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
        anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64: mm: Validate CONFIG_PGTABLE_LEVELS conditionally
Message-ID: <ZS5qZtcJAjtaKP3X@FVFF77S0Q05N>
References: <20231017005300.334140-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017005300.334140-1-gshan@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 10:53:00AM +1000, Gavin Shan wrote:
> It's allowed for the fixmap virtual address space to span multiple
> PMD entries. Instead, the address space isn't allowed to span multiple
> PUD entries. However, PMD entries are folded to PUD and PGD entries
> in the following combination. In this particular case, the validation
> on NR_BM_PMD_TABLES should be avoided.
> 
>   CONFIG_ARM64_PAGE_SHIFT = 14
>   CONFIG_ARM64_VA_BITS_36 = y
>   CONFIG_PGTABLE_LEVELS   = 2

Is this something you found by inspection, or are you hitting a real issue on a
particular config?

I built a kernel with:

  defconfig + CONFIG_ARM64_16K_PAGES=y + CONFIG_ARM64_VA_BITS_36=y

... which gives the CONFIG_* configuration you list above, and that works just
fine.

For 2-level 16K pages we'd need to reserve more than 32M of fixmap slots for
the assertion to fire, and we only reserve ~6M of slots in total today, so I
can't see how this would be a problem unless you have 26M+ of local additions
to the fixmap?

Regardless of that, I don't think it's right to elide the check entirely.

The point of the check is to make sure that the fixmap VA range doesn't span
across multiple PMD/PUD/P4D/PGD entries, as the early_fixmap_init() and
fixmap_copy() code don't handle that in general. When using 2-level 16K pages,
we still want to ensure the fixmap is contained within a single PGD, and
checking that it falls within a single folded PMD will check that.

See the message for commit:

  414c109bdf496195 ("arm64: mm: always map fixmap at page granularity")

... and the bits that deleted from early_fixmap_init().

AFAICT this is fine as-is.

Mark.

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/mm/fixmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index c0a3301203bd..5384e5c3aeaa 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -18,10 +18,11 @@
>  
>  #define NR_BM_PTE_TABLES \
>  	SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
> +#if CONFIG_PGTABLE_LEVELS > 2
>  #define NR_BM_PMD_TABLES \
>  	SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PUD_SHIFT)
> -
>  static_assert(NR_BM_PMD_TABLES == 1);
> +#endif
>  
>  #define __BM_TABLE_IDX(addr, shift) \
>  	(((addr) >> (shift)) - (FIXADDR_TOT_START >> (shift)))
> -- 
> 2.41.0
> 
