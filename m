Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC9175A74A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGTHIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjGTHIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:08:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9882122
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:08:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc68c4e046aso425968276.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836912; x=1692428912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTtTsHYHZoypkh/ZbOFrb+97cNaIZGVMYPTBvEUZ8QA=;
        b=1DoBmPRpqoKxp5AI1ATOavPZeo0Whgkd5Tc59Swf0g3JyV+Sf4czsw5vt5hRV/iIWU
         m0gxZI0ZpwmKuzcQe6n8ABa+pR3RNfGEwG4M79yda3Vq21aVBJ/g7QPw4WwY0KIttAPP
         qZs11I8hXcrNiTzcuVsx+5sSznkYJ5ijPhs+K2QY4AKhJ+1OPsJskvfvc2riuWl1X0pr
         fjY+rxKO1ypRGpwy/gVhyEiUbivpXGQsHDrV1rAgXPICZpfqdKSn1Khg2rXXV4x7hO0B
         V/yFis6Q3bBvFsNeipAISnXIhdf4e5y1csYuoWKJL9e1bvfMGj/AyzmZSyj99NVp9/vT
         61xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836912; x=1692428912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTtTsHYHZoypkh/ZbOFrb+97cNaIZGVMYPTBvEUZ8QA=;
        b=kLEBeK4TU+vAXxGxG6RpvoVc723ve4N5oDM0mtNyWjwTyX0I4OQiYXs9Ing/v514Td
         0XK2X4TYugJzZaHbYDOOuC8AXrvZGt4qqFUwIWsCzvxiqncU7Sjo1Lve37CPiISXif0B
         K8NghvaZAuPLe2cM9Qa50qJOY3LuNVC+IvB/ct2i6os0ivjKu69DH9M5IZHC7KAP2JJ6
         KZ0T87Bo0sGDjsLW/NnHuTi5Jm3tcuI1R81EfTwpHxlMVsGX80e+Ut35vi5aeZmNWzAt
         P+4zVQ3VKtnMN32Wc/rB8v0bk/l4aZapZIr6cRtbMSYplY6F+/1Jk4psOnAm9w4+mEdm
         j/9A==
X-Gm-Message-State: ABy/qLaz92+k+PPLEtUNmf7f56yeY0QCW/7Yrde1J6VpUEBG1COi+16L
        rx4K6dO0E+SiRySe5k8Kl549WzMPKiW/4v8x
X-Google-Smtp-Source: APBJJlFLKOPz8aT2ynaMGRvS7LvS60oh3DFyuJzygEiZuz8hLCEZV4fcd2R5Eiopcv2P65Ha4e5fn/ebih6t3IaU
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:53c4:0:b0:c6e:fe1a:3657 with SMTP
 id h187-20020a2553c4000000b00c6efe1a3657mr38214ybb.3.1689836911707; Thu, 20
 Jul 2023 00:08:31 -0700 (PDT)
Date:   Thu, 20 Jul 2023 07:08:19 +0000
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720070825.992023-3-yosryahmed@google.com>
Subject: [RFC PATCH 2/8] mm: vmscan: add lruvec_for_each_list() helper
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is used to provide a callback to be called for each lruvec
list. This abstracts different lruvec implementations (MGLRU vs. classic
LRUs). The helper is used by a following commit to iterate all folios in
all LRUs lists for memcg recharging.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/swap.h |  8 ++++++++
 mm/vmscan.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 456546443f1f..c0621deceb03 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -406,6 +406,14 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
 
 /* linux/mm/vmscan.c */
+typedef bool (*lruvec_list_fn_t)(struct lruvec *lruvec,
+				 struct list_head *list,
+				 enum lru_list lru,
+				 void *arg);
+extern void lruvec_for_each_list(struct lruvec *lruvec,
+				 lruvec_list_fn_t fn,
+				 void *arg);
+
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1080209a568b..e7956000a3b6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6254,6 +6254,34 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 
 #endif /* CONFIG_LRU_GEN */
 
+/*
+ * lruvec_for_each_list - make a callback for every folio list in the lruvec
+ * @lruvec: the lruvec to iterate lists in
+ * @fn: the callback to make for each list, iteration stops if it returns true
+ * @arg: argument to pass to @fn
+ */
+void lruvec_for_each_list(struct lruvec *lruvec, lruvec_list_fn_t fn, void *arg)
+{
+	enum lru_list lru;
+
+#ifdef CONFIG_LRU_GEN
+	if (lru_gen_enabled()) {
+		int gen, type, zone;
+
+		for_each_gen_type_zone(gen, type, zone) {
+			lru = type * LRU_INACTIVE_FILE;
+			if (fn(lruvec, &lruvec->lrugen.folios[gen][type][zone],
+			       lru, arg))
+				break;
+		}
+	} else
+#endif
+		for_each_evictable_lru(lru) {
+			if (fn(lruvec, &lruvec->lists[lru], lru, arg))
+				break;
+		}
+}
+
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	unsigned long nr[NR_LRU_LISTS];
-- 
2.41.0.255.g8b1d071c50-goog

