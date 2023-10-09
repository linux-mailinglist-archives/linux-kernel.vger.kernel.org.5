Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2840D7C5E95
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjJKUoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjJKUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:44:06 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46589E;
        Wed, 11 Oct 2023 13:44:04 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-59f6492b415so2124367b3.0;
        Wed, 11 Oct 2023 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057044; x=1697661844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AKsmkTQtU/rhqiAGHEzho0MRurJuhinBZFCGxQETC4=;
        b=A9RblMU5uCCTQamjKzeenzEYrFcmuZxsY9CE2iMOFAVSrrbqO7NifM+bxmT1m66VIr
         IFNdIFuEZroj46RJTxB6lQDKbTpoKKeGMNLf+3Su0Poa/dIV2mU7f67WmgBSbmc/w7nL
         /VcyNMFgdDfOe8dGeOAaITOins4pVEd+k5uUhw4aEAXjixvxjS01QLwXcL+EitmBesR3
         d5fxSVkqU5IWB7n6mgP3qXAkWGZvM/k4MkuCe4uWwhbEKWCcBXIyjuueJwwlZ+rGl346
         l6g0dmrPjv+etqRsw3qYFdMiRW6874xl8gqjvgwtfisUI6y9eGu1gbVDWpw6fiYyQvkS
         PP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057044; x=1697661844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AKsmkTQtU/rhqiAGHEzho0MRurJuhinBZFCGxQETC4=;
        b=ephZp6ITKzF7VB2glbLO/0oMJXi+ENQWZOiRkrgpbdjKzFqJpb92RgrVQZD/ijcuKX
         uhyh2yN+Hv4CpaKNHXGHMONosPvqO7g02CzZIAdTIH6AVx7S/5M0FJvHHEW6jaw+Gz5f
         pFN4jNRNVsRDqcsW7gCEY3kzFEEhF6pwhyjRx4epjr3JzNql/OGWvh9Zo06wV1Z5oiHP
         v8yZWmOismoP7utc4yvb6nR8wA6Fzy5ThWbbI+pbK/+ATG0QsapCSZOGqcpex/oVkUly
         SExegugTe6fp5ZfNbrbOhiRwqxxmPI6/l6MtPbL94AhcORLJRuaS4m6vOzltbla/vs7y
         8Vng==
X-Gm-Message-State: AOJu0YyX/i3CGSKN045lMu/NuidQzbJ1tNO+nJQebNR3ACckIsFQ7jMu
        Fm9FBtIxzKzAWgrtixA3+Q==
X-Google-Smtp-Source: AGHT+IHk5yLZJeaUXqy1B+rDus9A8q+EqrUxM9q2jVm64kJSM7T3hF2zy2+/xYWfSyGz2fhCfP8TIg==
X-Received: by 2002:a81:528b:0:b0:5a5:575:e944 with SMTP id g133-20020a81528b000000b005a50575e944mr11929290ywb.4.1697057044087;
        Wed, 11 Oct 2023 13:44:04 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id q2-20020a819902000000b0059bc0d766f8sm1844588ywg.34.2023.10.11.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:44:03 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com,
        ying.huang@intel.com, gregory.price@memverge.com
Subject: [RFC PATCH v2 1/3] mm/memory-tiers: change mutex to rw semaphore
Date:   Mon,  9 Oct 2023 16:42:57 -0400
Message-Id: <20231009204259.875232-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231009204259.875232-1-gregory.price@memverge.com>
References: <20231009204259.875232-1-gregory.price@memverge.com>
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

Tiers will have externally readable information, such as weights,
which may change at runtime. This information is expected to be
used by task threads during memory allocation so it cannot be
protected by hard mutual exclusion.

To support this, change the tiering mutex to a rw semaphore.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/memory-tiers.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 37a4f59d9585..0a3241a2cadc 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -5,6 +5,7 @@
 #include <linux/kobject.h>
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
+#include <linux/rwsem.h>
 
 #include "internal.h"
 
@@ -33,7 +34,7 @@ struct node_memory_type_map {
 	int map_count;
 };
 
-static DEFINE_MUTEX(memory_tier_lock);
+static DECLARE_RWSEM(memory_tier_sem);
 static LIST_HEAD(memory_tiers);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 static struct memory_dev_type *default_dram_type;
@@ -137,10 +138,10 @@ static ssize_t nodelist_show(struct device *dev,
 	int ret;
 	nodemask_t nmask;
 
-	mutex_lock(&memory_tier_lock);
+	down_read(&memory_tier_sem);
 	nmask = get_memtier_nodemask(to_memory_tier(dev));
 	ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
-	mutex_unlock(&memory_tier_lock);
+	up_read(&memory_tier_sem);
 	return ret;
 }
 static DEVICE_ATTR_RO(nodelist);
@@ -167,7 +168,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 	int adistance = memtype->adistance;
 	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
 
-	lockdep_assert_held_once(&memory_tier_lock);
+	lockdep_assert_held_write(&memory_tier_sem);
 
 	adistance = round_down(adistance, memtier_adistance_chunk_size);
 	/*
@@ -230,12 +231,12 @@ static struct memory_tier *__node_get_memory_tier(int node)
 	if (!pgdat)
 		return NULL;
 	/*
-	 * Since we hold memory_tier_lock, we can avoid
+	 * Since we hold memory_tier_sem, we can avoid
 	 * RCU read locks when accessing the details. No
 	 * parallel updates are possible here.
 	 */
 	return rcu_dereference_check(pgdat->memtier,
-				     lockdep_is_held(&memory_tier_lock));
+				     lockdep_is_held(&memory_tier_sem));
 }
 
 #ifdef CONFIG_MIGRATION
@@ -335,7 +336,7 @@ static void disable_all_demotion_targets(void)
 	for_each_node_state(node, N_MEMORY) {
 		node_demotion[node].preferred = NODE_MASK_NONE;
 		/*
-		 * We are holding memory_tier_lock, it is safe
+		 * We are holding memory_tier_sem, it is safe
 		 * to access pgda->memtier.
 		 */
 		memtier = __node_get_memory_tier(node);
@@ -364,7 +365,7 @@ static void establish_demotion_targets(void)
 	int distance, best_distance;
 	nodemask_t tier_nodes, lower_tier;
 
-	lockdep_assert_held_once(&memory_tier_lock);
+	lockdep_assert_held_write(&memory_tier_sem);
 
 	if (!node_demotion)
 		return;
@@ -479,7 +480,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 	pg_data_t *pgdat = NODE_DATA(node);
 
 
-	lockdep_assert_held_once(&memory_tier_lock);
+	lockdep_assert_held_write(&memory_tier_sem);
 
 	if (!node_state(node, N_MEMORY))
 		return ERR_PTR(-EINVAL);
@@ -569,15 +570,15 @@ EXPORT_SYMBOL_GPL(put_memory_type);
 void init_node_memory_type(int node, struct memory_dev_type *memtype)
 {
 
-	mutex_lock(&memory_tier_lock);
+	down_write(&memory_tier_sem);
 	__init_node_memory_type(node, memtype);
-	mutex_unlock(&memory_tier_lock);
+	up_write(&memory_tier_sem);
 }
 EXPORT_SYMBOL_GPL(init_node_memory_type);
 
 void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 {
-	mutex_lock(&memory_tier_lock);
+	down_write(&memory_tier_sem);
 	if (node_memory_types[node].memtype == memtype)
 		node_memory_types[node].map_count--;
 	/*
@@ -588,7 +589,7 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 		node_memory_types[node].memtype = NULL;
 		put_memory_type(memtype);
 	}
-	mutex_unlock(&memory_tier_lock);
+	up_write(&memory_tier_sem);
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
@@ -607,17 +608,17 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 
 	switch (action) {
 	case MEM_OFFLINE:
-		mutex_lock(&memory_tier_lock);
+		down_write(&memory_tier_sem);
 		if (clear_node_memory_tier(arg->status_change_nid))
 			establish_demotion_targets();
-		mutex_unlock(&memory_tier_lock);
+		up_write(&memory_tier_sem);
 		break;
 	case MEM_ONLINE:
-		mutex_lock(&memory_tier_lock);
+		down_write(&memory_tier_sem);
 		memtier = set_node_memory_tier(arg->status_change_nid);
 		if (!IS_ERR(memtier))
 			establish_demotion_targets();
-		mutex_unlock(&memory_tier_lock);
+		up_write(&memory_tier_sem);
 		break;
 	}
 
@@ -638,7 +639,7 @@ static int __init memory_tier_init(void)
 				GFP_KERNEL);
 	WARN_ON(!node_demotion);
 #endif
-	mutex_lock(&memory_tier_lock);
+	down_write(&memory_tier_sem);
 	/*
 	 * For now we can have 4 faster memory tiers with smaller adistance
 	 * than default DRAM tier.
@@ -661,7 +662,7 @@ static int __init memory_tier_init(void)
 			break;
 	}
 	establish_demotion_targets();
-	mutex_unlock(&memory_tier_lock);
+	up_write(&memory_tier_sem);
 
 	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
 	return 0;
-- 
2.39.1

