Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39C791A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbjIDPJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjIDPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:09:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997DCBD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:09:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso25849101fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693840167; x=1694444967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pqa6X94cnx/SA5Kco+qqSw4Yn4MifOppIUbtHTsLH8=;
        b=QzYdrwRZOS3wjVzrW4DQC5eI7h2f8ptBb3RE4DuDz6IquDyh7tdM9Zko1+KG8YDf6W
         8n8MOeJdQVbcEGGyFSg8MiFqMDcTtqKyL85jOwnhBZGwvGto8KAG/nasde4rC5Mcjq2x
         Jl5wU1pApdZE47yKR3lntSsOkebAMvnaXN1n9IJ+l+aDnBqVRC+Kdb7qwHscvL+Xot1a
         XhrGswgdXacfm7NuP/bMnonPaBsL5eFjk5z1ZjvcoKmusTGJym88WDpxr2kLNZUmTG1J
         SQJqNwERsv+jaUZ5Wr65ixt9FxoaHwpOVe4fyTZRAXrLE0KhVJwfO9e1Z1wfNHtp5xoz
         FAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693840167; x=1694444967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pqa6X94cnx/SA5Kco+qqSw4Yn4MifOppIUbtHTsLH8=;
        b=fsPLxZf68AQ38tvCy5pYUJZd65mTciwt+/d9ek7sqco2osTm7NB106+os7gyqBqRSG
         CQu2gVmeH0336euNOj9pZqMVt7fDCTh3iroDYBoSizEeHy51TfGes2WhDjkr8ykqG5V+
         J2GEwW/XBdM55Rs7HI4RRtofGbHjdIp6DvwVbeZkLsLQrtNpsFPhgOcz0ErYdDi8QId4
         L/GrSMPw9fmNkCwDUus5do4kDI/vXF6jWaStLUkvMrq8Uh6NptR1kHG8GiYx1DtO3xbj
         pIJTkvcdpyH5+LjVUVV8xBe0/iDc4AebJncCin4ikq/URiTSlGs4raIKRolCzTaGDf+1
         vmzg==
X-Gm-Message-State: AOJu0Yw5SPjq5HsOg/hqTNWecqaByZcIicN+U5IU5WoEKtDCub3U5Djh
        EQm2Arv6i26XVTjOgs+bd7E=
X-Google-Smtp-Source: AGHT+IFSefigFg6EPsF+g1BaJ26YH6ra4bHnK+bpoPkThpcpOU1PW7RYGE71sdcXjwKweO9K0gD5tg==
X-Received: by 2002:a2e:96d2:0:b0:2bd:16e6:e34e with SMTP id d18-20020a2e96d2000000b002bd16e6e34emr7701626ljj.1.1693840166553;
        Mon, 04 Sep 2023 08:09:26 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id fx4-20020a170906b74400b009887f4e0291sm6251775ejb.27.2023.09.04.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:09:26 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/vmstat: Use this_cpu_try_cmpxchg in mod_{zone,node}_state
Date:   Mon,  4 Sep 2023 17:08:49 +0200
Message-ID: <20230904150917.8318-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Use this_cpu_try_cmpxchg instead of this_cpu_cmpxchg (*ptr, old, new) == old
in mod_zone_state and mod_node_state.  x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg (and
related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 mm/vmstat.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 00e81e99c6ee..894e4c88d241 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -559,8 +559,10 @@ static inline void mod_zone_state(struct zone *zone,
 {
 	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
 	s8 __percpu *p = pcp->vm_stat_diff + item;
-	long o, n, t, z;
+	long n, t, z;
+	s8 o;
 
+	o = this_cpu_read(*p);
 	do {
 		z = 0;  /* overflow to zone counters */
 
@@ -576,8 +578,7 @@ static inline void mod_zone_state(struct zone *zone,
 		 */
 		t = this_cpu_read(pcp->stat_threshold);
 
-		o = this_cpu_read(*p);
-		n = delta + o;
+		n = delta + (long)o;
 
 		if (abs(n) > t) {
 			int os = overstep_mode * (t >> 1) ;
@@ -586,7 +587,7 @@ static inline void mod_zone_state(struct zone *zone,
 			z = n + os;
 			n = -os;
 		}
-	} while (this_cpu_cmpxchg(*p, o, n) != o);
+	} while (!this_cpu_try_cmpxchg(*p, &o, n));
 
 	if (z)
 		zone_page_state_add(z, zone, item);
@@ -616,7 +617,8 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
 	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	long o, n, t, z;
+	long n, t, z;
+	s8 o;
 
 	if (vmstat_item_in_bytes(item)) {
 		/*
@@ -629,6 +631,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		delta >>= PAGE_SHIFT;
 	}
 
+	o = this_cpu_read(*p);
 	do {
 		z = 0;  /* overflow to node counters */
 
@@ -644,8 +647,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		 */
 		t = this_cpu_read(pcp->stat_threshold);
 
-		o = this_cpu_read(*p);
-		n = delta + o;
+		n = delta + (long)o;
 
 		if (abs(n) > t) {
 			int os = overstep_mode * (t >> 1) ;
@@ -654,7 +656,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 			z = n + os;
 			n = -os;
 		}
-	} while (this_cpu_cmpxchg(*p, o, n) != o);
+	} while (!this_cpu_try_cmpxchg(*p, &o, n));
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
-- 
2.41.0

