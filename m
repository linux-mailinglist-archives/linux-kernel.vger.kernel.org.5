Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ABA80457C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbjLEDJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343930AbjLEDJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:09:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A728BF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:09:06 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce52d796d2so1516747b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 19:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701745746; x=1702350546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U90AZwx0u64U412UxCK0KCGmEXN+Ai+QPINiscHKrO8=;
        b=F/LnkcUODZuPVx4oUDtMsx+BhTZnmphfyXDjI2rmBu+lndSwI+2+utjib2vBq8IRZP
         4FeBOYHpL1JaV1b0PCcZDxFe3wDWpZd2aTX923EMY2bpWwpxMEEOAs+7y3I5T+tTKzvj
         7+xUCuRcY86engvAx5oJtDiws6oA0P27JMoCirV5IH6II1ZZ1ZY2EDA/rg22JvXN8fNp
         Ct4IiLT82L5OEePLjWhCssMGumCi0CS4LqENVacEfi0pxTVbljM+Bor+6GL4JIObrkcG
         HJuso3oclgWCPlrhQXEdXmUxdlFpqTdeyMuzObmExbb6JEIlytToYNzWJO7WVKSlG3Ns
         rqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701745746; x=1702350546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U90AZwx0u64U412UxCK0KCGmEXN+Ai+QPINiscHKrO8=;
        b=Ex3aq+aeIve5tcy7wU5WJM/PJA5ORdhv+sRKYOu866vjNqUWvz5FheocqScr7KCkbU
         EfBT1MMOBplM/d4MZJR+I2GB/yUfSeZhP9Pl9W6OjIcL1E6LW8c1YDu16pDAoS1kqIYh
         ztnsKT96hFrn5C+BtCndP+wuvUyz2GGhUb8YuU5lMS0HhYfpcFIpcgDi7xzUbnUN96ux
         9GRyMFerph9UZL0kzxBEmdLwLL2A9jZB94WwuOCkPirP4fEctnj4OwsWgWjP6w24hE+L
         A8A5URtGLmSDyyX7mLJPVPqz9b1gujpKIcE9Y+A3bUgiMRNzNa+jtu9x1qbkoGu/Ri5o
         LV2Q==
X-Gm-Message-State: AOJu0YwErgyFUnGNdxXopJPS9aF4IQxPTA5piBqOMzbpXX0vA3dpT9tE
        WhTaj0i1sBAdv49i+xhP7VJM5g==
X-Google-Smtp-Source: AGHT+IEzQfDv9VGzVKsBlFQTjRF34+fkm6hAacFqusPIW7gAuJ24V1lKK5t7tS1NNlZtGQXs4s7AkA==
X-Received: by 2002:a05:6a00:6c9e:b0:6ce:5431:6e43 with SMTP id jc30-20020a056a006c9e00b006ce54316e43mr868206pfb.33.1701745745972;
        Mon, 04 Dec 2023 19:09:05 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id n28-20020a056a000d5c00b006ce647b9aacsm964357pfv.130.2023.12.04.19.09.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Dec 2023 19:09:05 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: hugetlb_vmemmap: move mmap lock to vmemmap_remap_range()
Date:   Tue,  5 Dec 2023 11:08:53 +0800
Message-Id: <20231205030853.3921-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the users of vmemmap_remap_range() will hold the mmap lock
and release it once it returns, it is naturally to move the
lock to vmemmap_remap_range() to simplify the code and the users.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 54f388aa361fb..9a35b5789361f 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -163,8 +163,10 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 
 	VM_BUG_ON(!PAGE_ALIGNED(start | end));
 
+	mmap_read_lock(&init_mm);
 	ret = walk_page_range_novma(&init_mm, start, end, &vmemmap_remap_ops,
 				    NULL, walk);
+	mmap_read_unlock(&init_mm);
 	if (ret)
 		return ret;
 
@@ -282,7 +284,6 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 static int vmemmap_remap_split(unsigned long start, unsigned long end,
 			       unsigned long reuse)
 {
-	int ret;
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= NULL,
 		.flags		= VMEMMAP_SPLIT_NO_TLB_FLUSH,
@@ -291,11 +292,7 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
 	/* See the comment in the vmemmap_remap_free(). */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	mmap_read_lock(&init_mm);
-	ret = vmemmap_remap_range(reuse, end, &walk);
-	mmap_read_unlock(&init_mm);
-
-	return ret;
+	return vmemmap_remap_range(reuse, end, &walk);
 }
 
 /**
@@ -358,7 +355,6 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	 */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	mmap_read_lock(&init_mm);
 	ret = vmemmap_remap_range(reuse, end, &walk);
 	if (ret && walk.nr_walked) {
 		end = reuse + walk.nr_walked * PAGE_SIZE;
@@ -377,7 +373,6 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 
 		vmemmap_remap_range(reuse, end, &walk);
 	}
-	mmap_read_unlock(&init_mm);
 
 	return ret;
 }
@@ -434,11 +429,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 	if (alloc_vmemmap_page_list(start, end, &vmemmap_pages))
 		return -ENOMEM;
 
-	mmap_read_lock(&init_mm);
-	vmemmap_remap_range(reuse, end, &walk);
-	mmap_read_unlock(&init_mm);
-
-	return 0;
+	return vmemmap_remap_range(reuse, end, &walk);
 }
 
 DEFINE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
-- 
2.20.1

