Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3F97819EA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjHSONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHSONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:13:53 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226D93E1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:44 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-589c7801d1cso20132857b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692454363; x=1693059163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf9CTvZgeFnZIxznv1sHeC3yripV+bDt6DFW7z/9P+A=;
        b=gc/1EWDc23XJKVaSsGUTWb76KcCm7bL450mDTtcfp5orDsZ0x+Im2b89o82pkGYPWI
         2kKh97M0Pq7E6YI2JQ/rY98jLUI6q+y6Lfk5DxI3rTh/kXImFMu6dvwiSxbbwTFx4DWs
         BmPmqnq0ztWSsuWtLDuqVl8xesUfwyR/COfFhlO+wFNYUEJbVGZOGxxCyhaqLsZpUhHt
         psuAlS3iNnxR5tqGB6vLwR8cAkieCaqf8MJCvd4Kd5NQMPMeZf1RaksZoemImF2e5Sps
         Xq8VtTGwn6+KwuC2/RzFwbmFFxUBOeaU4SX5xY1EWJUuY/hz2lGPWJifS4G6MR1+kdNA
         ApSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454363; x=1693059163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf9CTvZgeFnZIxznv1sHeC3yripV+bDt6DFW7z/9P+A=;
        b=EN75cyIsRsyhdhQbCLdxDDKx8OAPKxupUC5PT03cT/RgT3D2NS1jjhTlddYxbwJItW
         nK4xXBNYDF1GtcZWbJWkv/tPhapDhRwHlBOi4e4CivaP9qmjiiBEAC793VYfoKXQH3Ut
         TeZqoaGnecA311HF0ACWKim4dLR3TrQL7dofbX3k0av44hAads0SkY/pzgkD+wRQsbHS
         K6NAW3mwTTt0BRhLbhwqaYnCsgi4GwhS0MATMhiQc09NMMG+d2w+sMhTbtTtS3h48h1g
         h8eMFO4Zf2xIDCN7UR/t0Bmdo0J2KOXL9fZEuZhxCgueTcDSIjsAySletzzX2ggDrWth
         9Yfw==
X-Gm-Message-State: AOJu0Yye1/ZCo6/DS+3BXq2b9Q/eME1JslZM90Q9vSTfunKSeKWBOEka
        cFfPRaDhEfRD8UP23UE+X88RWOFsEo4=
X-Google-Smtp-Source: AGHT+IEoff5wDnqvsze/t8OiCL4lM8ZHmxWRyutUm7aAYNfsUsVv7+2AJf68cb+zqoIwdne80+wp6A==
X-Received: by 2002:a0d:eb8f:0:b0:589:c2fe:2afb with SMTP id u137-20020a0deb8f000000b00589c2fe2afbmr2161158ywe.30.1692454363496;
        Sat, 19 Aug 2023 07:12:43 -0700 (PDT)
Received: from localhost ([32.218.242.113])
        by smtp.gmail.com with ESMTPSA id g20-20020a0ce4d4000000b0063d245c00b5sm1482645qvm.0.2023.08.19.07.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:12:43 -0700 (PDT)
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
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 1/6] numa: generalize numa_map_to_online_node()
Date:   Sat, 19 Aug 2023 07:12:33 -0700
Message-Id: <20230819141239.287290-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819141239.287290-1-yury.norov@gmail.com>
References: <20230819141239.287290-1-yury.norov@gmail.com>
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

The function in fact searches the nearest node for a given one,
based on a N_ONLINE state. This is a common pattern to search
for a nearest node.

This patch converts numa_map_to_online_node() to numa_nearest_node()
so that others won't need to opencode the logic.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/numa.h |  7 +++++--
 mm/mempolicy.c       | 18 +++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/numa.h b/include/linux/numa.h
index 59df211d051f..fb30a42f0700 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -25,7 +25,7 @@
 #include <asm/sparsemem.h>
 
 /* Generic implementation available */
-int numa_map_to_online_node(int node);
+int numa_nearest_node(int node, unsigned int state);
 
 #ifndef memory_add_physaddr_to_nid
 static inline int memory_add_physaddr_to_nid(u64 start)
@@ -44,10 +44,11 @@ static inline int phys_to_target_node(u64 start)
 }
 #endif
 #else /* !CONFIG_NUMA */
-static inline int numa_map_to_online_node(int node)
+static inline int numa_nearest_node(int node, unsigned int state)
 {
 	return NUMA_NO_NODE;
 }
+
 static inline int memory_add_physaddr_to_nid(u64 start)
 {
 	return 0;
@@ -58,6 +59,8 @@ static inline int phys_to_target_node(u64 start)
 }
 #endif
 
+#define numa_map_to_online_node(node) numa_nearest_node(node, N_ONLINE)
+
 #ifdef CONFIG_HAVE_ARCH_NODE_DEV_GROUP
 extern const struct attribute_group arch_node_dev_group;
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c53f8beeb507..0fc9a3b1d765 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,22 +131,26 @@ static struct mempolicy default_policy = {
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
 /**
- * numa_map_to_online_node - Find closest online node
+ * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
+ * @state: State to filter the search
  *
- * Lookup the next closest node by distance if @nid is not online.
+ * Lookup the closest node by distance if @nid is not in state.
  *
- * Return: this @node if it is online, otherwise the closest node by distance
+ * Return: this @node if it is in state, otherwise the closest node by distance
  */
-int numa_map_to_online_node(int node)
+int numa_nearest_node(int node, unsigned int state)
 {
 	int min_dist = INT_MAX, dist, n, min_node;
 
-	if (node == NUMA_NO_NODE || node_online(node))
+	if (state >= NR_NODE_STATES)
+		return -EINVAL;
+
+	if (node == NUMA_NO_NODE || node_state(node, state))
 		return node;
 
 	min_node = node;
-	for_each_online_node(n) {
+	for_each_node_state(n, state) {
 		dist = node_distance(node, n);
 		if (dist < min_dist) {
 			min_dist = dist;
@@ -156,7 +160,7 @@ int numa_map_to_online_node(int node)
 
 	return min_node;
 }
-EXPORT_SYMBOL_GPL(numa_map_to_online_node);
+EXPORT_SYMBOL_GPL(numa_nearest_node);
 
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
-- 
2.39.2

