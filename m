Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66F765DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjG0VXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjG0VXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:23:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD39E1BC1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:23:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317716a4622so1452169f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492986; x=1691097786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DvlsOnR4Pls28Go9VLQiPdtzYKx4bsGyZo1fzogJdIc=;
        b=HEo5AGgGQCeVahhOXRNMbQ3Ii99AWr2j5kKcx0+1rZ3TKtxvVaxCsey1glTtNuAomp
         gPR2o5UKERvaniUo5rIrk+rV7tfB8W3adLf0d7IctsrTWzVKUbb+9fnEfpVpzy0MIMIe
         yHjmsYtbScZPKDRc43I9VrFuNdqMut6jrTSLbCM96dcJ4q4Q0uOx8EAbuxPqf9cq5xG6
         oZyx8f5LmTwTsCrE18Zup43+xGtcAh1EY7gja3G/Gmw0xRVadpD++yvnXhhug+Ckgmki
         m3JgAyrRDz3iJPA881bHYw9GOhSkmTwJMtGjaur0IGfPg9zjXC9Ir1vYhBzBe0q59nkC
         /vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492986; x=1691097786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvlsOnR4Pls28Go9VLQiPdtzYKx4bsGyZo1fzogJdIc=;
        b=cvjEVJu9P+TgRJIo8flDkyPQPiQBmPHRe/M4OSnfPzmNKW/pw5rgxzo5tY7AUsoC/Y
         mT7CBjK0eIEVscKy6nKKciQRuJwEfinev8yXLgzQgMtNZe27td0cTx8gHr3QcQe0exGR
         oWCkgUq1QkJvreXsBbDnrnbLlioOp+vPN6NyWSD1hUrgFI8HebpjVHANovBbTTkzNv+k
         jHz3qP2rglh4Hc7k1hiaXJloBLQ2hvUfFqqAuGzSNqlJnsopTvGhjWyfPrf1c676sbPp
         jTiu3saYh2cwSm6PiC0CbS3k6zV0dyJi3fc/lIYkoxuKJXchxmcsmUd0OLIyqHY7ufky
         tehQ==
X-Gm-Message-State: ABy/qLZlegEePPBuCYqqbvhB/fkUCSnwdnGN00FqdV0HCmWK9cYCze2x
        9f5+rUCtmU9/FL6snk2lAas=
X-Google-Smtp-Source: APBJJlFj/vFiLMgc/lDsstP6er7i1+BHaOLLVifczT1cA84N9TCP66BkQHw5K/0qKwlj0hBOy3AKOg==
X-Received: by 2002:adf:fe4b:0:b0:316:f25f:eb4 with SMTP id m11-20020adffe4b000000b00316f25f0eb4mr218377wrs.60.1690492985888;
        Thu, 27 Jul 2023 14:23:05 -0700 (PDT)
Received: from localhost.localdomain (host31-52-141-59.range31-52.btcentralplus.com. [31.52.141.59])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c00d400b003faef96ee78sm5539194wmm.33.2023.07.27.14.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:23:05 -0700 (PDT)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v2] damon: Use pmdp_get instead of drectly dereferencing pmd.
Date:   Fri, 28 Jul 2023 06:21:57 +0900
Message-Id: <20230727212157.2985025-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As ptep_get, Use the pmdp_get wrapper when we accessing pmdval
instead of directly dereferencing pmd.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 mm/damon/ops-common.c |  2 +-
 mm/damon/paddr.c      |  2 +-
 mm/damon/vaddr.c      | 23 +++++++++++++++--------
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index e940802a15a4..ac1c3fa80f98 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -54,7 +54,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	struct folio *folio = damon_get_folio(pmd_pfn(*pmd));
+	struct folio *folio = damon_get_folio(pmd_pfn(pmdp_get(pmd)));
 
 	if (!folio)
 		return;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 40801e38fcf0..909db25efb35 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -94,7 +94,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 				mmu_notifier_test_young(vma->vm_mm, addr);
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			*accessed = pmd_young(*pvmw.pmd) ||
+			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 #else
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2fcc9731528a..d01cc46f4bf4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -301,16 +301,19 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
 	pte_t *pte;
+	pmd_t pmde;
 	spinlock_t *ptl;
 
-	if (pmd_trans_huge(*pmd)) {
+	if (pmd_trans_huge(pmdp_get(pmd))) {
 		ptl = pmd_lock(walk->mm, pmd);
-		if (!pmd_present(*pmd)) {
+		pmde = pmdp_get(pmd);
+
+		if (!pmd_present(pmde)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (pmd_trans_huge(*pmd)) {
+		if (pmd_trans_huge(pmde)) {
 			damon_pmdp_mkold(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			return 0;
@@ -439,21 +442,25 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damon_young_walk_private *priv = walk->private;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_trans_huge(*pmd)) {
+	if (pmd_trans_huge(pmdp_get(pmd))) {
+		pmd_t pmde;
+
 		ptl = pmd_lock(walk->mm, pmd);
-		if (!pmd_present(*pmd)) {
+		pmde = pmdp_get(pmd);
+
+		if (!pmd_present(pmde)) {
 			spin_unlock(ptl);
 			return 0;
 		}
 
-		if (!pmd_trans_huge(*pmd)) {
+		if (!pmd_trans_huge(pmde)) {
 			spin_unlock(ptl);
 			goto regular_page;
 		}
-		folio = damon_get_folio(pmd_pfn(*pmd));
+		folio = damon_get_folio(pmd_pfn(pmde));
 		if (!folio)
 			goto huge_out;
-		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
+		if (pmd_young(pmde) || !folio_test_idle(folio) ||
 					mmu_notifier_test_young(walk->mm,
 						addr))
 			priv->young = true;
-- 
2.37.2

