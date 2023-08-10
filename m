Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30335777E29
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjHJQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjHJQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:24:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2223103
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:24:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68783004143so844048b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684690; x=1692289490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt6CR9HHeK7zgBz6fcScWFIY0NBszh7vNKMQXcDtos0=;
        b=XFsFzQqdaTaPQRn6vyEKmgGKISYvFL/a6YMDa77xCoXUJFV6954HgACo6As6lTmO69
         ZKjDlc1V8S38EIFNwQ0yt7lx8Z747kn6RUFY4Q5T9mQSdTsnHof2DwQo90tMjIUhcmhF
         1NhyZ+FgbibFcbOArCPbbApw3NYcJ4Vrut4/yslOdF0A4ayO1+QkunBxsDzw0LkGKSKx
         mQ+LFHEM/UbfAFr4g/ODj6M2NkfxFAisnT6/viOipN9H1YfSFKNeqk2mG0glgsX+ERvC
         b7qSUha5wggKGIAq/HTrx7uiVRJD5SS5OTzVVL1sKQOUZEaeG1gNeiU/HMRGYAp8JkJg
         fLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684690; x=1692289490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt6CR9HHeK7zgBz6fcScWFIY0NBszh7vNKMQXcDtos0=;
        b=JJ6Xsg5IecJC11THrWqZaCIufMHrdW0WaQv7iaVwGxdEM1LSEKa/22uI9cbgHP44tM
         qAU1p2IfWJSblQ6cMXDLOeykDwoJav/nLCwq+vkJPqDHgxn381U2hetX4ozTq0Jakv5V
         tptLWmQqBz6Iu/wo19k8zQER4yscSsZoW2dWdm7cC4z2PO+SLITnUO6TAwsfuWuOx1zD
         XK08vuvZBW/hCXkD7r6VJXqu1NLBPsxzdnRhvx36BGENnA4sIxWVt4hsgYa6/7F1Zgx7
         zIs404DxE7t48RQrAj0s0UX5Q9jBp+S4TfwtottTm1AIqGttCXV2yf0PET+rjO0kWuOl
         Lf9Q==
X-Gm-Message-State: AOJu0YwpwaB2kxDv6hLVMlbl9kS1W4nvQoa8dkTgGFpiQsVeRwdzDe68
        zEsTlTUW5M5Bkscriy+yitBfrtXZ814=
X-Google-Smtp-Source: AGHT+IF+HSKdTxdkxlmBxL9la1pCFwMfvcL9kLyLQbU13M/krB/0NdbxKsUiSjtnGTzzM/pJoXXx/A==
X-Received: by 2002:a05:6a21:3e0a:b0:13a:fa9e:787b with SMTP id bk10-20020a056a213e0a00b0013afa9e787bmr2366502pzc.12.1691684689654;
        Thu, 10 Aug 2023 09:24:49 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id l6-20020a62be06000000b0066f37665a63sm1724928pff.73.2023.08.10.09.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:24:49 -0700 (PDT)
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
Subject: [PATCH 1/4] numa: generalize numa_map_to_online_node()
Date:   Thu, 10 Aug 2023 09:24:39 -0700
Message-Id: <20230810162442.9863-2-yury.norov@gmail.com>
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

The function is in fact searches for the nearest node for a given one,
based on a N_ONLINE state. This is a common pattern to search for a
nearest node.

This patch converts numa_map_to_online_node(node) to
numa_nearest_node(node, state), so that others won't need opencode the
logic. The following patches apply it where applicable.

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
index c53f8beeb507..db74dd957d2c 100644
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

