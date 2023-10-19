Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F177CF58D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345155AbjJSKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjJSKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:44:54 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D8F185
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:44:52 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-582a82e6d10so175147eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697712292; x=1698317092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdZK381RBjQZyfHFZ18jHnyg7m+suieSGZz1SIv3ey8=;
        b=jeeeWztpWqmLnNUW6UK7HQtdN9Ao/wEuvdus7bPVlYmoRseZZf/8vdVH1W3GU3Z8bn
         bkx6y1oMm/maqybEynke4cwo5hnFDyAOIf/q+tKebFVJ2oN4mN8teeSLXrpnVuC7g9q/
         wTUFsNITXO1ANayQJFIQwa343TzqZFt5DRmZ+ZFpg1iz9M6cw+GTOPXcIS11hEH7kRA2
         sB44zNE0wkzvYwU1IQFVbXXA7vqbBqk/m57q30CjRYIZtkZD+Fbw7OmtLvJfLQZQbd4f
         npb3lm3/90dacetfnzAziC8wL8zwdBg5OOc6i4VguM6MAFYODfV/AIXwi+aznvQ8Pafh
         NuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712292; x=1698317092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdZK381RBjQZyfHFZ18jHnyg7m+suieSGZz1SIv3ey8=;
        b=UpOCcQFw9IzGCVgU/n1Hftfq+EYzgC3/v7LDw9ACR3kK/TX1LY/xjqHbIYDp6Syh4B
         RajHuqbEfA9+kOS3JMTANXY1kP2f/bbY4xJ2tyUAJ7kfTniTH7V55gQQbknnDOaSPORC
         ZPBhvtKER3epgC8z4vhhZKEAj53l/bYXCqA6E3AxtD91K56KIekDGVQan/6UDly+VXVT
         5CdHMxH0WbGlz1YEyNHRepzMxCnaNQB65aHPMzHSnWuU4rb05W/tzA1BCSIVLd+Repfq
         4ZnHPbOLXusZ9N+Dm01Uzzhwbm619DmtefGPISO9A9q1atwAU5tpFmLj4ocEE5uMIa0E
         7K9g==
X-Gm-Message-State: AOJu0Yy+zGOXOrJp1syjvEzSiPqIc2jdYjBDE9Ds3mxVE+5dbkoE5ipa
        zW9/dnMSO5GbsF8exk6Zh9ZH4A==
X-Google-Smtp-Source: AGHT+IEKtgaD9gW+wGXJDbqDaemkokq1LTLe2VIcWMQxnk/34R61ymLdL7teHgXuzKgJcNIS7AXK9w==
X-Received: by 2002:a05:6359:3902:b0:168:a332:e1f2 with SMTP id xa2-20020a056359390200b00168a332e1f2mr1426065rwb.1.1697712291794;
        Thu, 19 Oct 2023 03:44:51 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y13-20020aa79e0d000000b006bdfb718e17sm4812290pfq.124.2023.10.19.03.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:44:51 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 1/2] mm: page_alloc: skip memoryless nodes entirely
Date:   Thu, 19 Oct 2023 18:43:54 +0800
Message-Id: <157013e978468241de4a4c05d5337a44638ecb0e.1697711415.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1697711415.git.zhengqi.arch@bytedance.com>
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In find_next_best_node(), We skipped the memoryless nodes
when building the zonelists of other normal nodes (N_NORMAL),
but did not skip the memoryless node itself when building
the zonelist. This will cause it to be traversed at runtime.

For example, say we have node0 and node1, node0 is memoryless
node, then the fallback order of node0 and node1 as follows:

[    0.153005] Fallback order for Node 0: 0 1
[    0.153564] Fallback order for Node 1: 1

After this patch, we skip memoryless node0 entirely, then
the fallback order of node0 and node1 as follows:

[    0.155236] Fallback order for Node 0: 1
[    0.155806] Fallback order for Node 1: 1

So it becomes completely invisible, which will reduce runtime
overhead.

And in this way, we will not try to allocate pages from memoryless
node0, then the panic mentioned in [1] will also be fixed. Even though
this problem has been solved by dropping the NODE_MIN_SIZE constrain
in x86 [2], it would be better to fix it in core MM as well.

[1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
[2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ee392a324802..e978272699d3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5052,8 +5052,11 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
 	int min_val = INT_MAX;
 	int best_node = NUMA_NO_NODE;
 
-	/* Use the local node if we haven't already */
-	if (!node_isset(node, *used_node_mask)) {
+	/*
+	 * Use the local node if we haven't already. But for memoryless local
+	 * node, we should skip it and fallback to other nodes.
+	 */
+	if (!node_isset(node, *used_node_mask) && node_state(node, N_MEMORY)) {
 		node_set(node, *used_node_mask);
 		return node;
 	}
-- 
2.30.2

