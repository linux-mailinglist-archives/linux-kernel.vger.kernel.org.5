Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171D3809A07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573013AbjLHDG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjLHDG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:06:26 -0500
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D8110CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:06:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702004191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pp4e2f1m5xzOKYlTpY9BWRD9Si0GcTtJwwlQEj1BdUw=;
        b=xCPbD/P/C8PYRd/iq7qfzqNK7O0vfM4mGjzdmECDhFGARzzFYf7ZUvm3GJRa/0jylY7zUT
        N3Cjp/IbGSXRZjSJwSaNafZSlWhPPcdcKRiXSe/Rf6LKUweMgiwkUisLIKD6Z6m69WS41p
        OKm5SMXqb5fUw2uMJ7ByFbDYnO/E6Mw=
From:   Gang Li <gang.li@linux.dev>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ligang.bdlg@bytedance.com, Gang Li <gang.li@linux.dev>
Subject: [PATCH 1/1] hugetlb: add timing to hugetlb allocations on boot
Date:   Fri,  8 Dec 2023 10:56:17 +0800
Message-Id: <20231208025617.5299-1-gang.li@linux.dev>
In-Reply-To: <20231208025240.4744-1-gang.li@linux.dev>
References: <20231208025240.4744-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timing to hugetlb allocations for further optimization.

Debug only.

Signed-off-by: Gang Li <gang.li@linux.dev>
---
 mm/hugetlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1169ef2f2176f..51f50bb3dc092 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4490,6 +4490,7 @@ static inline void hugetlb_sysctl_init(void) { }
 static int __init hugetlb_init(void)
 {
 	int i;
+	unsigned long start;
 
 	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
 			__NR_HPAGEFLAGS);
@@ -4536,8 +4537,11 @@ static int __init hugetlb_init(void)
 	}
 
 	hugetlb_cma_check();
+	start = jiffies;
 	hugetlb_init_hstates();
 	gather_bootmem_prealloc();
+	pr_info("HugeTLB: 2M alloc, init and 1G init takes %u ms\n",
+		jiffies_to_msecs(jiffies - start));
 	report_hugepages();
 
 	hugetlb_sysfs_init();
@@ -4682,6 +4686,7 @@ static int __init hugepages_setup(char *s)
 		}
 	}
 
+	unsigned long start = jiffies;
 	/*
 	 * Global state is always initialized later in hugetlb_init.
 	 * But we need to allocate gigantic hstates here early to still
@@ -4692,6 +4697,7 @@ static int __init hugepages_setup(char *s)
 
 	last_mhp = mhp;
 
+	pr_info("HugeTLB: 1G alloc takes %u ms\n", jiffies_to_msecs(jiffies - start));
 	return 1;
 
 invalid:
-- 
2.30.2

