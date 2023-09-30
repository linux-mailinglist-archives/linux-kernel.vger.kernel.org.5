Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657537B3DD4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjI3DaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 23:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjI3DaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:30:12 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A447CE7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 20:30:07 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-419628fb297so26245821cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696044606; x=1696649406; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5lBL1dIqosEB13vnHNJcMu3nNFm9z6wAJ0sm8x1c/Y=;
        b=4pNbCMPfFspO8G7/MhfmAy9r3B7X4+80ptLvUHsca9nvtZ/21NwNQBRB56wAMz2ooj
         RqqXeRlj9niyjk3mAs9Opz6wBVJCZDAZYEETLb/cH9tf2+216tYEvoDTQJUJ7Te/Tlbr
         wGqr0cncxmDRR/XJvTR8OD8huvDrKCx85uhQrloiOY2QFq05wXVy5owIldkh0Nz+icO2
         GSlnjlIN3e1R/1tsuF55J+yUFRx8YiVS6HAU8Zd5jZC9IwXvUkHKsTh7U7AIip6GbE46
         8lE5dtajfRT1q1e+DO11VmRnVzTKYHp09w/O1+o94fsUa1VH4ZeoKgzygxpcriXftomr
         HVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696044606; x=1696649406;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5lBL1dIqosEB13vnHNJcMu3nNFm9z6wAJ0sm8x1c/Y=;
        b=qIG+1PoIzBSgLj61iQNCbclr5PGgKMugXSuhw3lm2rBaDSfOGoBD46t4fSEB9meA+c
         BnMh+0/5Hd6pHa9VFVCPaZLqlkBLtt4ZDXQPNpZPy52nGdz/dhtjI6ygGg9xba1XX1Kg
         znm8p/z1U/a/TECat8ZWBLh4Pt9GBOhjhMK2HDwWcmHfqyXiN+GO8wezPphf7ONas1jt
         gfQZwiFEAUnG2wbav3PGDrNw9qnwGoGLwLX1mID1ellT2mPkFRNQi5FBnHl5sYspu0RD
         yeHD4DeoIzS55glEU4CW+txw/Hj8FDdbPsmWfyauOMh8PttdbeSYvtePrKzpEDpjijt/
         CgQg==
X-Gm-Message-State: AOJu0YyLbvYczX+jDh9rPYVcEIRSZHjWaxmLqxic9DslQHvrDeUiMU1Y
        M2rovAPf3UlJXNipvfVRPkg/lA==
X-Google-Smtp-Source: AGHT+IGP2fxP6CWffX9Qi9wXG2I3wbOa1qZMTS36GprFKCZ9FBnqMrcBGIljlzMe7rrEDbitBUPjPw==
X-Received: by 2002:a05:622a:5cb:b0:412:c2a:eaef with SMTP id d11-20020a05622a05cb00b004120c2aeaefmr6834494qtb.11.1696044606428;
        Fri, 29 Sep 2023 20:30:06 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r74-20020a0de84d000000b0059bc980b1eesm5981929ywe.6.2023.09.29.20.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 20:30:05 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:30:03 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 5/8] shmem: shmem_acct_blocks() and
 shmem_inode_acct_blocks()
In-Reply-To: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
Message-ID: <9124094-e4ab-8be7-ef80-9a87bdc2e4fc@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By historical accident, shmem_acct_block() and shmem_inode_acct_block()
were never pluralized when the pages argument was added, despite their
complements being shmem_unacct_blocks() and shmem_inode_unacct_blocks()
all along.  It has been an irritation: fix their naming at last.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index caee8ba841f7..63ba6037b23a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -189,10 +189,10 @@ static inline int shmem_reacct_size(unsigned long flags,
 /*
  * ... whereas tmpfs objects are accounted incrementally as
  * pages are allocated, in order to allow large sparse files.
- * shmem_get_folio reports shmem_acct_block failure as -ENOSPC not -ENOMEM,
+ * shmem_get_folio reports shmem_acct_blocks failure as -ENOSPC not -ENOMEM,
  * so that a failure on a sparse tmpfs mapping will give SIGBUS not OOM.
  */
-static inline int shmem_acct_block(unsigned long flags, long pages)
+static inline int shmem_acct_blocks(unsigned long flags, long pages)
 {
 	if (!(flags & VM_NORESERVE))
 		return 0;
@@ -207,13 +207,13 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
-static int shmem_inode_acct_block(struct inode *inode, long pages)
+static int shmem_inode_acct_blocks(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	int err = -ENOSPC;
 
-	if (shmem_acct_block(info->flags, pages))
+	if (shmem_acct_blocks(info->flags, pages))
 		return err;
 
 	might_sleep();	/* when quotas */
@@ -447,7 +447,7 @@ bool shmem_charge(struct inode *inode, long pages)
 {
 	struct address_space *mapping = inode->i_mapping;
 
-	if (shmem_inode_acct_block(inode, pages))
+	if (shmem_inode_acct_blocks(inode, pages))
 		return false;
 
 	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
@@ -1671,7 +1671,7 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
 		huge = false;
 	nr = huge ? HPAGE_PMD_NR : 1;
 
-	err = shmem_inode_acct_block(inode, nr);
+	err = shmem_inode_acct_blocks(inode, nr);
 	if (err)
 		goto failed;
 
@@ -2572,7 +2572,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	int ret;
 	pgoff_t max_off;
 
-	if (shmem_inode_acct_block(inode, 1)) {
+	if (shmem_inode_acct_blocks(inode, 1)) {
 		/*
 		 * We may have got a page, returned -ENOENT triggering a retry,
 		 * and now we find ourselves with -ENOMEM. Release the page, to
-- 
2.35.3

