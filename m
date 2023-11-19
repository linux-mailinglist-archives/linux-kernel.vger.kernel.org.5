Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433097F088D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjKSTsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjKSTsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:30 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D08D67
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:22 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso3169833b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423301; x=1701028101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UpGTVr/h0gRLNFrOGvqL9Asvs1D6zvF8lBMhGssTB0o=;
        b=XnNMl8Ga2yZtHo/rmlT8dejCkZca0iXOSyw88mV4ZxNzqnt7obnsKqxL67gT9F7mP4
         stNe9RLFHjpiZPchL4n3ojUiIQaXnbHn2Oo4tcAJPfvaozdUkhcMm5kVseBWYD4PatrX
         it/4SaVCte/NV+BqH0IOwZECAaDm2sw6al/DdYT7mLNPYv5eavbyWLFIAHD/yv1kIxWd
         zOmT4ECj5Z9JBfMDdRF4tKdF/ogC6yfZwab4FSsjOp/Ht4cZ3KC9T5CV445o3L0s5sVW
         0Msu/X32pj7swmQbSUuzeJJeVh9uO1ytJtp/0dcE0k3QMT9q1DJF3xi+0/gnS4R/kATu
         BbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423301; x=1701028101;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpGTVr/h0gRLNFrOGvqL9Asvs1D6zvF8lBMhGssTB0o=;
        b=nuJJ1y1Qm3xvE17ZW5aCs0+rt97ONmOzYjE16hHOrIFHsiubPCdfmSdNmbSrDrnHvT
         8r4XZocPlYrut1stIvNVCZxzFzuz8m1kdNV8agyFj7dzCLzgk8NtZHY6TwuwNtZPiAcC
         tamCIWZ0sOoSj8XTOFqdn2VU1c/lo8ubtM/4ptn/t0PuJwUb13wBZmnyMM32SbP41s5q
         ieYzgz0kesnmxNZiHTqz1lP5XrVaWmEvd09/j6/mxBK1JYe++r7skTiXPA2tMU4ASchE
         0KUPQyFiIcASeKeAC62AU/hvJJzjUFN8GxnUABMHC37Ke/h3teNcq9s0T12h5plowK06
         5XsQ==
X-Gm-Message-State: AOJu0YyzaIzwjM9x3vxbPNNVRFync1bFzFeiCqEMsO+lxFTMWAL4jL8+
        1LWtc0LCozmpbaehmdu7s1cTjUOUP/3EYKfH
X-Google-Smtp-Source: AGHT+IHfs1/JMlpqrq4TKTabAC0wuT2f0zXPPKJXJ4FxpJjeabGpgVADWj7Pztf6px1yswvAICZfaA==
X-Received: by 2002:a05:6a20:b797:b0:187:8eca:8dc6 with SMTP id fh23-20020a056a20b79700b001878eca8dc6mr2490060pzb.34.1700423301416;
        Sun, 19 Nov 2023 11:48:21 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:20 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 06/24] swap: rework swapin_no_readahead arguments
Date:   Mon, 20 Nov 2023 03:47:22 +0800
Message-ID: <20231119194740.94101-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119194740.94101-1-ryncsn@gmail.com>
References: <20231119194740.94101-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Make it use alloc_pages_mpol instead of vma_alloc_folio, and accept
mm_struct directly as an argument instead of taking a vmf as argument.
Make its arguments similar to swap_{cluster,vma}_readahead, to
make the code more aligned.

Also prepare for following commits which will skip vmf for certain
swapin paths.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index fd0047ae324e..ff6756f2e8e4 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -867,17 +867,17 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * in.
  */
 static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
-					struct vm_fault *vmf)
+					struct mempolicy *mpol, pgoff_t ilx,
+					struct mm_struct *mm)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = NULL;
 	struct folio *folio;
+	struct page *page;
 	void *shadow = NULL;
 
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-				vma, vmf->address, false);
+	page = alloc_pages_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
+	folio = (struct folio *)page;
 	if (folio) {
-		if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
+		if (mem_cgroup_swapin_charge_folio(folio, mm,
 						   GFP_KERNEL, entry)) {
 			folio_put(folio);
 			return NULL;
@@ -896,7 +896,6 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 		/* To provide entry to swap_readpage() */
 		folio->swap = entry;
-		page = &folio->page;
 		swap_readpage(page, true, NULL);
 		folio->private = NULL;
 	}
@@ -928,7 +927,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
-		page = swapin_no_readahead(entry, gfp_mask, vmf);
+		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
 		cached = false;
 	} else if (swap_use_vma_readahead()) {
 		page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
-- 
2.42.0

