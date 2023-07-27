Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B6765C81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjG0Ty7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjG0Ty6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD6E2D73
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D77461F28
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD92C433C8;
        Thu, 27 Jul 2023 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690487695;
        bh=/jP1tCMthxFNPSaqOUszBlNwQ94CB6jBYZ00mppC3O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfyH29vTZiN6nYEmK0Ow4XeWsSUlDWlyD0eAMjr1NYeIMgM6CuIBywSrfyCeFUdPw
         kG1lwWJPAVfSf0Kbq4YNX4Ogu544UZ9RagOE3raqEZsra27siYVtDkClAc5ggUK0yk
         i7o0MObK2/D0G7/sgcPOHohO0dYgcHc2Lz6e0L8AAoekqKp8cMNtYZtmM9aL6L9shD
         TbEsS9wgDCtNXk3WNhoPrVLqDQrKn802+VcYowGlZfxbSpGF0Yly/5Ta+ItjPXs1lC
         kkFmtwzPRzFeOaOUGrE8IJGyRIEGOQtrjIehusVrE3x7TRrngiZg6Lm8utpg47i2gM
         GsCGk8gsV2rJQ==
From:   SeongJae Park <sj@kernel.org>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
Date:   Thu, 27 Jul 2023 19:54:53 +0000
Message-Id: <20230727195453.67611-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727183745.682880-1-ppbuk5246@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levi,


Thank you for this patch.

Nit for the subject, what about s/drect/directly/?  Also, let's remove the
period at the end.

On Fri, 28 Jul 2023 03:37:45 +0900 Levi Yun <ppbuk5246@gmail.com> wrote:

> As ptep_get, Use the pmdp_get wrapper when we accessing pmdval
> instead of direct dereferencing pmd.

Nit: s/Use/use/ and s/direct/directly

> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  mm/damon/ops-common.c |  2 +-
>  mm/damon/paddr.c      |  2 +-
>  mm/damon/vaddr.c      | 22 ++++++++++++++--------
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index e940802a15a4..ac1c3fa80f98 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -54,7 +54,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
>  void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	struct folio *folio = damon_get_folio(pmd_pfn(*pmd));
> +	struct folio *folio = damon_get_folio(pmd_pfn(pmdp_get(pmd)));
>  
>  	if (!folio)
>  		return;
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 40801e38fcf0..909db25efb35 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -94,7 +94,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
>  				mmu_notifier_test_young(vma->vm_mm, addr);
>  		} else {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -			*accessed = pmd_young(*pvmw.pmd) ||
> +			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
>  				!folio_test_idle(folio) ||
>  				mmu_notifier_test_young(vma->vm_mm, addr);
>  #else
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 2fcc9731528a..82f7865719fe 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -301,16 +301,19 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		unsigned long next, struct mm_walk *walk)
>  {
>  	pte_t *pte;
> +	pmd_t pmde;
>  	spinlock_t *ptl;
>  
> -	if (pmd_trans_huge(*pmd)) {
> +	if (pmd_trans_huge(pmdp_get_lockless(pmd))) {

I don't think we really need to use pmdp_get_lockless() here, since we will do
this check again with the lock, and we have the fallback for the intermediate
changes.

>  		ptl = pmd_lock(walk->mm, pmd);
> -		if (!pmd_present(*pmd)) {
> +		pmde = pmdp_get(pmd);
> +
> +		if (!pmd_present(pmde)) {
>  			spin_unlock(ptl);
>  			return 0;
>  		}
>  
> -		if (pmd_trans_huge(*pmd)) {
> +		if (pmd_trans_huge(pmde)) {
>  			damon_pmdp_mkold(pmd, walk->vma, addr);
>  			spin_unlock(ptl);
>  			return 0;
> @@ -434,26 +437,29 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  {
>  	pte_t *pte;
>  	pte_t ptent;
> +	pmd_t pmde;

This would cause below build warning if CONFIG_TRANSPARENT_HUGEPAGE is not
defined.

.../mm/damon/vaddr.c:440:8: warning: unused variable 'pmde' [-Wunused-variable]
  440 |  pmd_t pmde;
      |        ^~~~


>  	spinlock_t *ptl;
>  	struct folio *folio;
>  	struct damon_young_walk_private *priv = walk->private;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (pmd_trans_huge(*pmd)) {
> +	if (pmd_trans_huge(pmdp_get_lockless(pmd))) {

Again, pmdp_get() might be enough?

>  		ptl = pmd_lock(walk->mm, pmd);
> -		if (!pmd_present(*pmd)) {
> +		pmde = pmdp_get(pmd);
> +
> +		if (!pmd_present(pmde)) {
>  			spin_unlock(ptl);
>  			return 0;
>  		}
>  
> -		if (!pmd_trans_huge(*pmd)) {
> +		if (!pmd_trans_huge(pmde)) {
>  			spin_unlock(ptl);
>  			goto regular_page;
>  		}
> -		folio = damon_get_folio(pmd_pfn(*pmd));
> +		folio = damon_get_folio(pmd_pfn(pmde));
>  		if (!folio)
>  			goto huge_out;
> -		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
> +		if (pmd_young(pmde) || !folio_test_idle(folio) ||
>  					mmu_notifier_test_young(walk->mm,
>  						addr))
>  			priv->young = true;
> -- 
> 2.37.2
> 

Thanks,
SJ
