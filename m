Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15957A8C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjITTDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjITTD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB0E4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5789de5c677so64987a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236600; x=1695841400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zmtAWomE9UHhxu4UCSwc3QxDlD+DtTBiD3PMp93+3PE=;
        b=RbMDCyefZ18r4dVeYKpV5jTNhWp+lns/rjINo5dQExzLjthyWFHE7YkXjKlrQlIYUj
         r/YpDNrgoc7ZLUFts5AeuYEb2TKS80mLeZkdXuNrSOFMAc3sC1yGaYFoOElGSTF7uApc
         BScSTGlSU2fLOKK706SBDyviMRE7aNItX2WqCOea02XiJhXg6VmtCvGOuza2ExTNJlYe
         9zsyEhzDmjacS17Ixf8br5LtYwxOsDAG08MFU6G4rIPFvkEEx4U/j7VEV4buxXdon0v+
         1i1n087r+tMa2c3RRvByZqkvGZ0MWkita+wFun/Kcjb6GPUyGOiydG9G5QkQ0z0jY5L+
         +wrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236600; x=1695841400;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmtAWomE9UHhxu4UCSwc3QxDlD+DtTBiD3PMp93+3PE=;
        b=FnkNIBYKKDw2j4Y+x+DzIsmkE7VLkrEImPw+bYgiTgRgenkVm3ud2cKomROySgxCP1
         uA0zhNVYmwcep1KziJSF/dfxYu99HkZzef2lpVGpYzbzXsNO9jVR8qYIOhjUcXbSyLhC
         nHswrO79SnXr52YXESzq7dB8Z/5Dx7UWgiPjX3l6z0wY+lmlRDIfvgC4FjHsyYS4hDZh
         vJB7jo+VW+4rj92/rcZmFYvvtwQtHdAKdzkEnahV0YNU87VEU65EPZ9xwDQDu3/6LVK0
         4poTZMeX0kW7CX/Dxpwi4vWG28aU/9LMZhWZAftePCUxROS0R+2akZKiF1vn0LHoeHCs
         FNZg==
X-Gm-Message-State: AOJu0YzEWDOa5FyMcklkoset2XNJWz4nGyj+uiDXDazbEVAQ3gcfgqAl
        75tyNwXOdB2WmVwHchaz6xo=
X-Google-Smtp-Source: AGHT+IG0njOPD64WNQhILSI7Yy7mRF1jtyrvGzCcw3tGXClzEqYzeGMpn4pGWqrWE4Nnji19RDQnKw==
X-Received: by 2002:a05:6a20:138c:b0:145:6857:457a with SMTP id hn12-20020a056a20138c00b001456857457amr3193200pzc.4.1695236599694;
        Wed, 20 Sep 2023 12:03:19 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([124.127.145.18])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006871fdde2c7sm423935pfa.110.2023.09.20.12.03.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 12:03:19 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Yuanchu Xie <yuanchu@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH v3 5/6] mm, lru_gen: convert avg_total and avg_refaulted to atomic
Date:   Thu, 21 Sep 2023 03:02:43 +0800
Message-ID: <20230920190244.16839-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920190244.16839-1-ryncsn@gmail.com>
References: <20230920190244.16839-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

No feature change, prepare for later patch.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mmzone.h |  4 ++--
 mm/vmscan.c            | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..d944987b67d3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -425,9 +425,9 @@ struct lru_gen_folio {
 	/* the multi-gen LRU sizes, eventually consistent */
 	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the exponential moving average of refaulted */
-	unsigned long avg_refaulted[ANON_AND_FILE][MAX_NR_TIERS];
+	atomic_long_t avg_refaulted[ANON_AND_FILE][MAX_NR_TIERS];
 	/* the exponential moving average of evicted+protected */
-	unsigned long avg_total[ANON_AND_FILE][MAX_NR_TIERS];
+	atomic_long_t avg_total[ANON_AND_FILE][MAX_NR_TIERS];
 	/* the first tier doesn't need protection, hence the minus one */
 	unsigned long protected[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS - 1];
 	/* can be modified without holding the LRU lock */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3f4de75e5186..82acc1934c86 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3705,9 +3705,9 @@ static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
-	pos->refaulted = lrugen->avg_refaulted[type][tier] +
+	pos->refaulted = atomic_long_read(&lrugen->avg_refaulted[type][tier]) +
 			 atomic_long_read(&lrugen->refaulted[hist][type][tier]);
-	pos->total = lrugen->avg_total[type][tier] +
+	pos->total = atomic_long_read(&lrugen->avg_total[type][tier]) +
 		     atomic_long_read(&lrugen->evicted[hist][type][tier]);
 	if (tier)
 		pos->total += lrugen->protected[hist][type][tier - 1];
@@ -3732,15 +3732,15 @@ static void reset_ctrl_pos(struct lruvec *lruvec, int type, bool carryover)
 		if (carryover) {
 			unsigned long sum;
 
-			sum = lrugen->avg_refaulted[type][tier] +
+			sum = atomic_long_read(&lrugen->avg_refaulted[type][tier]) +
 			      atomic_long_read(&lrugen->refaulted[hist][type][tier]);
-			WRITE_ONCE(lrugen->avg_refaulted[type][tier], sum / 2);
+			atomic_long_set(&lrugen->avg_refaulted[type][tier], sum / 2);
 
-			sum = lrugen->avg_total[type][tier] +
+			sum = atomic_long_read(&lrugen->avg_total[type][tier]) +
 			      atomic_long_read(&lrugen->evicted[hist][type][tier]);
 			if (tier)
 				sum += lrugen->protected[hist][type][tier - 1];
-			WRITE_ONCE(lrugen->avg_total[type][tier], sum / 2);
+			atomic_long_set(&lrugen->avg_total[type][tier], sum / 2);
 		}
 
 		if (clear) {
@@ -5885,8 +5885,8 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 
 			if (seq == max_seq) {
 				s = "RT ";
-				n[0] = READ_ONCE(lrugen->avg_refaulted[type][tier]);
-				n[1] = READ_ONCE(lrugen->avg_total[type][tier]);
+				n[0] = atomic_long_read(&lrugen->avg_refaulted[type][tier]);
+				n[1] = atomic_long_read(&lrugen->avg_total[type][tier]);
 			} else if (seq == min_seq[type] || NR_HIST_GENS > 1) {
 				s = "rep";
 				n[0] = atomic_long_read(&lrugen->refaulted[hist][type][tier]);
-- 
2.41.0

