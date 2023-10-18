Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2EE7CD868
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjJRJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:42:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DBF9F7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:42:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E8E2F4;
        Wed, 18 Oct 2023 02:43:02 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.67.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B84ED3F64C;
        Wed, 18 Oct 2023 02:42:19 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:42:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
        anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64: mm: Validate CONFIG_PGTABLE_LEVELS conditionally
Message-ID: <ZS-oSirRfxRko9ia@FVFF77S0Q05N>
References: <20231017005300.334140-1-gshan@redhat.com>
 <ZS5qZtcJAjtaKP3X@FVFF77S0Q05N>
 <c383e11e-8067-4350-8a10-ae9c514b222f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c383e11e-8067-4350-8a10-ae9c514b222f@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 04:33:09PM +1000, Gavin Shan wrote:
> Hi Mark,
> 
> On 10/17/23 21:05, Mark Rutland wrote:
> > On Tue, Oct 17, 2023 at 10:53:00AM +1000, Gavin Shan wrote:
> > > It's allowed for the fixmap virtual address space to span multiple
> > > PMD entries. Instead, the address space isn't allowed to span multiple
> > > PUD entries. However, PMD entries are folded to PUD and PGD entries
> > > in the following combination. In this particular case, the validation
> > > on NR_BM_PMD_TABLES should be avoided.
> > > 
> > >    CONFIG_ARM64_PAGE_SHIFT = 14
> > >    CONFIG_ARM64_VA_BITS_36 = y
> > >    CONFIG_PGTABLE_LEVELS   = 2
> > 
> > Is this something you found by inspection, or are you hitting a real issue on a
> > particular config?
> > 
> > I built a kernel with:
> > 
> >    defconfig + CONFIG_ARM64_16K_PAGES=y + CONFIG_ARM64_VA_BITS_36=y
> > 
> > ... which gives the CONFIG_* configuration you list above, and that works just
> > fine.
> > 
> > For 2-level 16K pages we'd need to reserve more than 32M of fixmap slots for
> > the assertion to fire, and we only reserve ~6M of slots in total today, so I
> > can't see how this would be a problem unless you have 26M+ of local additions
> > to the fixmap?
> > 
> > Regardless of that, I don't think it's right to elide the check entirely.
> > 
> 
> It's all about code inspection. When CONFIG_PGTABLE_LEVELS == 2, PGD/PUD/PMD
> are equivalent. The following two macros are interchangeable. The forthcoming
> static_assert() enforces that the fixmap virtual space can't span multiple
> PMD entries, meaning the space is limited to 32MB with above configuration.
> 
>   #define NR_BM_PMD_TABLES \
>           SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PUD_SHIFT)
>   #define NR_BM_PMD_TABLES \
>           SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
> 
>   static_assert(NR_BM_PMD_TABLES == 1);
> 
> However, multiple PTE tables are allowed. It means the fixmap virtual space
> can span multiple PMD entries, which is controversial to the above enforcement
> from the code level. Hopefully, I understood everything correctly.
> 
>   #define NR_BM_PTE_TABLES \
>           SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
>   static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
> 

The intent is that the fixmap can span multiple PTE tables, but has to fall
within a single PMD table (and within a single PGD entry). See the next couple
of lines where we only allocate one PMD table and one PUD table:

    static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
    static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
    static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;

The NR_BM_PMD_TABLES definition is only there for the static_assert().

> You're correct that the following edition is needed to trigger the assert.
> The point is to have the fixmap virtual space larger than 32MB.

It's not intended to be more than 32M.

If we want to support 32M and larger, we'd need to rework the rest of the code,
allocating more intermediate tables and manipulating multiple PGD entries. As
we have no need for that, it's simpler to leave it as-is, with the
static_assert() ther to catch if/when someone tries to expand it beyond what is supported.

> 
>   enum fixed_addresses {
>         FIX_HOLE,
>          :
>         FIX_PTE,
>         FIX_PMD,
>         FIX_PUD,
>         FIX_PGD,
>         FIX_DUMMY = FIX_PGD + 2048,
> 
>         __end_of_fixed_addresses
> };
> 
> 
> > The point of the check is to make sure that the fixmap VA range doesn't span
> > across multiple PMD/PUD/P4D/PGD entries, as the early_fixmap_init() and
> > fixmap_copy() code don't handle that in general. When using 2-level 16K pages,
> > we still want to ensure the fixmap is contained within a single PGD, and
> > checking that it falls within a single folded PMD will check that.
> > 
> > See the message for commit:
> > 
> >    414c109bdf496195 ("arm64: mm: always map fixmap at page granularity")
> > 
> > ... and the bits that deleted from early_fixmap_init().
> > 
> > AFAICT this is fine as-is.
> > 
> 
> As I can see, multiple PMD entries can be handled well in early_fixmap_init().
> However, multiple PMD entries aren't handled in fixmap_copy(), as you said.
> 
>   early_fixmap_init
>     early_fixmap_init_pud
>       early_fixmap_init_pmd       // multiple PMD entries handled in the loop

If you remove the restriction of a single PMD entry, you also permit multiple
PUD/P4D/PGD entries, and the early_fixmap_init() code cannot handle that.
Consider how early_fixmap_init_pud() and early_fixmap_init_pmd() use bm_pud and
bm_pmd respectively.

As above, this code doesn't need to change:

* It works today, there is no configuration where the statis_assert() fires
  spuriously.

* If the static_assert() were to fire, we'd need to alter some portion of the
  code to handle that case (e.g. expanding bm_pmd and/or bm_pud, altering
  fixmap_copy()).

* It's simpler and better to have the assertion today rather than making the
  code handle the currently-impossible cases. That avoids wasting memory on
  unusable tables, and avoids having code which is never tested.

Mark.
