Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA46A7CF16C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjJSHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjJSHiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:38:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251149F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ca3c63d7f0so3702135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697701092; x=1698305892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrlA2D0tsTZAhmUT4zIyvppYy9kAGeNu6j+59eQyeHI=;
        b=Z4+ZKW4vnMcMLXiJtV6pHmXtWRjyLa2zxGWvaZxjcHSzjdMsnHjaTz9uQuBDSSGaC5
         ytoN/7dxUbCHHgAXtbFI8S7FtVG+rd6g5AhHYxbnIAS+8ixWr9kC8GvY1d/G+okEDya+
         jbNiZjcD5LRV1P0fw9wx71JLddJrGdrCTRK/naH9kMSt1MQbUbM9J96G5V+43PAcfZh7
         j8QVa9e1ubHMf3wpffnxLBZsebo5n6Gxpf0a7G6xoe3nOlhevpv3Ev/u+1BKiH+fwn96
         RAYPYGedSBMDsNh5HnbmREoIKIeEBXkVDGcxIPj2TDa8Adoy9+22xJsIRDlSC64WpXTD
         aFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697701092; x=1698305892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrlA2D0tsTZAhmUT4zIyvppYy9kAGeNu6j+59eQyeHI=;
        b=u7v0PqTzC2T0bkuePgOQ1eveiL5lSG5i0EigrZEruWCc1hGbrdkZf0/dhs8lTmL644
         1hecIgOrGCRCaz3Ma8ZijpEycGIDo7sObQLMkL+cQZkDg+i7B/ZafOj2vqrgjuipxY5O
         xotD8zbuKxSkhOQlPyjcrfwPQRak92EcGX9+B4xs2A5rpQro6GiS7FnX4ZVJSbPYPTUs
         +fmB0rejO5GZ25o4hwFfN8og6yaHgS7UOJZbFAHXaEthFcJIAaiALmZdDbgyRuZC1h1g
         iikPUakjYBXmhY7X020eS2iZj/EOkYdN18sZDtDCoVs071h0qqo+PXRNnk9udnfaMeps
         Beog==
X-Gm-Message-State: AOJu0YykX70xFDyNjSd0tJKzPH5BtiK9ArFFIuPvE+jPsIYQutOtMfrb
        3hnvyRCgR8wMoILnllYdHgHm6kZXYKu6b0BvpNI=
X-Google-Smtp-Source: AGHT+IFjDgx7I8RE61UxKsbQGrvNTb8O4D1v2H9dfhDr8mxzcuSeWnOhjtJ/Uw3I1OjPQ8RpbMiOOA==
X-Received: by 2002:a17:902:e5c1:b0:1ca:858d:5bef with SMTP id u1-20020a170902e5c100b001ca858d5befmr1524433plf.4.1697701092603;
        Thu, 19 Oct 2023 00:38:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b001c5d09e9437sm1194306plo.25.2023.10.19.00.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:38:12 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net, mingo@kernel.org,
        aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/2] mm: page_alloc: skip memoryless nodes entirely
Date:   Thu, 19 Oct 2023 15:36:26 +0800
Message-Id: <7928768f2658cd563978f5e5bf8109be1d559320.1697687357.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1697687357.git.zhengqi.arch@bytedance.com>
References: <cover.1697687357.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

