Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC117D0E19
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377155AbjJTLFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377133AbjJTLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:05:43 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F35F114
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:05:20 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1ea1742c1a5so193812fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697799918; x=1698404718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK+cFoR1MyWIl8n0phUtp2lC8tfEt3+4PWkcgkrk9lI=;
        b=W2OvXBWY6ET60Qygx4/Ibtx3Rj1fhBlEekqxnVVX7LnDXDlymTiAiyFxVQc00AvOP/
         3kddzv2ak9MteblZwE0zexI++ygY6ZPZ0nZbKtGR1Gd5ar3U81E9TCqOilP+WQ4Czxyl
         Y2MOqc+DbTPJHpJg1MbspAWG5crvo8ebKbc2Pk29g/iTCE3MtAQS31EOCsTPNcAsEa4q
         ZHaFUmJ/yPRVqJb+Z/7PD6vCXhDZPy6q8DCuwiZdv5/KRQrdj+mhyyz3ducrw4BtsQeX
         yhRX58xLBXXnjBQgFPY/dlPb0cWuTCw1fxSkHaMrWoVQuCRL7NiyEPwNyquRNaj5NlS7
         VKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799918; x=1698404718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK+cFoR1MyWIl8n0phUtp2lC8tfEt3+4PWkcgkrk9lI=;
        b=RQk0N6EzkPMD0UjdbiKdEuJD21RH5qPJsajrO5VnQUJEcm+cLCUcQgyL6K9lG85I+I
         nYrVyi4+1bku8cMJLSxyS2hPSY4lRlMt6UALwc98WctZ46dtdnnCHm1l+K6OHV9rIVEX
         TP0QiB88qh8VKmkJRX5xMk31ygRjpKmOvNCoSz5Z+DUXRxS40D6MWnp9BAQoysCN4gdB
         RC3uWIWa4KiZGjhYTltFNdGmF7VhvIEOqEtpjDg5tv4MHo5EBbJ1UT0VEbHYELGSbeNH
         XTp98ajjIDpFYQV+VXZJCMDZhIxBw/nbp8r5fZ/HUVastHpxqEgFOWKtzmcEWAnpxmPQ
         k6Uw==
X-Gm-Message-State: AOJu0Yx+6iQzzep2LtuTrh8fQwJBW0I4DugQMXeiZnIfO3evMOHf1AK3
        w/KV6ZQX5D7rIq3PyJ9aemiXdg==
X-Google-Smtp-Source: AGHT+IHzpFn+0JMDaI4Gs/mdtLhr+NGf107MOT2wTDU+64UeBpwHiVD2ZcJQjGH+akRjScgKxgEiwg==
X-Received: by 2002:a05:6358:5922:b0:168:a35c:f07b with SMTP id g34-20020a056358592200b00168a35cf07bmr1449368rwf.0.1697799917664;
        Fri, 20 Oct 2023 04:05:17 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b006be4bb0d2dcsm1323865pfr.149.2023.10.20.04.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:05:17 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 1/2] mm: page_alloc: skip memoryless nodes entirely
Date:   Fri, 20 Oct 2023 19:04:45 +0800
Message-Id: <7300fc00a057eefeb9a68c8ad28171c3f0ce66ce.1697799303.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1697799303.git.zhengqi.arch@bytedance.com>
References: <cover.1697799303.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In find_next_best_node(), we skipped memoryless nodes
when building the zonelists of other normal nodes (N_NORMAL),
but did not skip the memoryless node itself when building
the zonelist. This will cause it to be traversed at runtime.

For example, say we have node0 and node1, node0 is memoryless
node, then the fall back order of node0 and node1 as follows:

[    0.153005] Fallback order for Node 0: 0 1
[    0.153564] Fallback order for Node 1: 1

After this patch, we skip memoryless node0 entirely, then
the fall back order of node0 and node1 as follows:

[    0.155236] Fallback order for Node 0: 1
[    0.155806] Fallback order for Node 1: 1

So it becomes completely invisible, which will reduce runtime
overhead.

And in this way, we will not try to allocate pages from memoryless
node0, then the panic mentioned in [1] will also be fixed. Even though
this problem has been solved by dropping the NODE_MIN_SIZE constrain
in x86 [2], it would be better to fix it in the core MM as well.

[1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
[2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 mm/page_alloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ee392a324802..1f852929709f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5052,8 +5052,11 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
 	int min_val = INT_MAX;
 	int best_node = NUMA_NO_NODE;
 
-	/* Use the local node if we haven't already */
-	if (!node_isset(node, *used_node_mask)) {
+	/*
+	 * Use the local node if we haven't already, but for memoryless local
+	 * node, we should skip it and fall back to other nodes.
+	 */
+	if (!node_isset(node, *used_node_mask) && node_state(node, N_MEMORY)) {
 		node_set(node, *used_node_mask);
 		return node;
 	}
-- 
2.30.2

