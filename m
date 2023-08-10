Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F42777E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjHJQY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjHJQYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:24:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6CE2698
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:24:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6873a30d02eso807792b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684693; x=1692289493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97Np0Dq1sjh/AlJqPoAcdype5uG/AKghnCitY+NNEhM=;
        b=A28IsFYWvTZlltxjPz79uMSyOph+88G9Ft3TaE6hmpdwtTjAbpLjj36Y8D1rDP5tsx
         gqNrKYT1WaVWHMwBgHXzOMScx0r58umABHAX7X4pOuPQYd591n7NqkzmlhOTkIYVBQ3E
         MUZPgcWKB0YzfP6uKnviDTG4+uKLPED3865QUmLUUL7UFawQ2V0wm4gVkkAZcpfi5rZH
         cwyvQA7rOIFLZu455sw2Oy9pbys4jHsxVhgUieAUKjUp7qbRHT83k5UbKOy1ArvX0tRy
         d7aMj1rbYp4sZIB56MqBWrF+cJL6gbbrA1ROBmN+zF9kgt+n7OS35AsGnir2YZyx7kAE
         cl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684693; x=1692289493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97Np0Dq1sjh/AlJqPoAcdype5uG/AKghnCitY+NNEhM=;
        b=FM922jVPdeUL4kiZNOfQYnI1kCq3AJSUviTohxZ09ftK2NCbCkq8sCbhWCuyKE6Nzs
         R5b5mwK3eHQFRJoO+2z3f2UMLgLP2jkTYn+l0KkNw5ABdmTMY6vWPzle7tQP4Yn0iiWe
         MFc2rHF8vpqPIct3imxv0eC6vtCTNUegcRkk1l1LbbT1CmZ+Hg04K0P46xFQ6XtsyA4+
         WliFjCrMKwrgySjvFlUH/qYJYKt6+DZ6iJikKKRFtOAPB8K+67kdXx1uvYcHGkoGnkS+
         CN7fB9R3b7vCJKBh539sJi45WUBuEiddhhO0oTkBVm4QwcqfA88mfbXFGttZFEsiSUBQ
         dSFg==
X-Gm-Message-State: AOJu0YzHRMlGSMSeFBEzILWTMzvefPQij+GjRsbbeoS/EGtGHRGSrFny
        UI7zMpnDkbyLZHXxJ9E8ljaTDIJl8J0=
X-Google-Smtp-Source: AGHT+IHsk0h5rwGZHG4cMG39kTlHSH3djuCACl1aU9H9G7Tq9XIknzH67+DdDoStnlXXCDW22OILnQ==
X-Received: by 2002:a05:6a20:325a:b0:134:a8a1:3bf with SMTP id hm26-20020a056a20325a00b00134a8a103bfmr2389040pzc.30.1691684693125;
        Thu, 10 Aug 2023 09:24:53 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b00686a80f431dsm1711885pfn.126.2023.08.10.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:24:52 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Lafreniere <peter@n8pjl.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/4] sched/fair: fix opencoded numa_nearest_node()
Date:   Thu, 10 Aug 2023 09:24:40 -0700
Message-Id: <20230810162442.9863-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810162442.9863-1-yury.norov@gmail.com>
References: <20230810162442.9863-1-yury.norov@gmail.com>
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

task_numa_placement() searches for a nearest node by calling
for_each_node_state(). Now that we have numa_nearest_node(), switch to
using it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/fair.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be58e2b..e7b7cf87937b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2645,19 +2645,7 @@ static void task_numa_placement(struct task_struct *p)
 	}
 
 	/* Cannot migrate task to CPU-less node */
-	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
-		int near_nid = max_nid;
-		int distance, near_distance = INT_MAX;
-
-		for_each_node_state(nid, N_CPU) {
-			distance = node_distance(max_nid, nid);
-			if (distance < near_distance) {
-				near_nid = nid;
-				near_distance = distance;
-			}
-		}
-		max_nid = near_nid;
-	}
+	max_nid = numa_nearest_node(max_nid, N_CPU);
 
 	if (ng) {
 		numa_group_count_active_nodes(ng);
-- 
2.39.2

