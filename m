Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3657C5E99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376394AbjJKUoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjJKUoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:44:07 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E67A9;
        Wed, 11 Oct 2023 13:44:06 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5a7db1f864bso3166057b3.3;
        Wed, 11 Oct 2023 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057045; x=1697661845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9UI87hogpDREX7ILSAbskFyWe+DuAm4NfdE6acGURg=;
        b=U8JDKXSnyEemEKTWKbYcx1RgfsreFQEeEsKkhP0/xU21a8AIR1bUe35jyy0G7VJer5
         +Imv8crFmtCMTjmLYt0xPC9HR2nIAJ73pfWI3FRvYVgbMGf5n4nCe25s3BWgHO+fCB+4
         BrkwCDKO8D93IQmI4UPB8+k+JQMQyEgaZ5lRinxKEzow61Uz48lK4+bPZKdlAcFjtn+v
         nSD9J0INtUv56Y3cxF6DqOjYPBurVPo+CKdYccredrauqi7js8JFGbw5ASGA0ufVDNSf
         z5qbSNF+0WqvWBnrNvM+jgcc+3idPnr/CpHlH726R93B93kZpanK6azY3d9B/Sa9zEvT
         iITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057045; x=1697661845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9UI87hogpDREX7ILSAbskFyWe+DuAm4NfdE6acGURg=;
        b=dFoSkNwmJKOPTimKgpEKvzWNFDh7PYG8x5Mgtdkk27q5ivmJBrsD49FN63U9UeCzir
         dW4cAIbEbaFp4i67WncYjMlhXQwzPVLy6TQauLTNjdYWHg8NcwqSh1AyYmHTFj+2/u5b
         LBC4/2L1BrZdZMZ7aP7+AEEdMxHMehwqS1fqXUWZ10YgxUuFy7Fkz6cHg+gOLXlRbvEE
         C9IkJiOblRat+EvYp1fsKx5cCg3ejWZnwCHn43LMGCRPkVjWY6Ot7oQ+Bd6+O/aBJ3Ep
         lHoTzVC/EA+ZlgWhtgsA4NqyRi7Tk7pJuhgbsimLkXItZIH8U+vHSTNcmSGWhbASScJH
         Xsxg==
X-Gm-Message-State: AOJu0YwrabHcxXSUTdTc2aV7+2gNxgLPI9/1CV5Kz1EouBEWadPKeQxE
        qc5KMTlrC5WhznsgOX4G2f+y76YucfwvlQE=
X-Google-Smtp-Source: AGHT+IFBybVofn8uA1QG5FhUr2s6pjfiaJnoBxHbehRcIa/YpEEJNFJWO1bMZ/d+F+TzB5zVTpZ6LQ==
X-Received: by 2002:a05:690c:368b:b0:5a5:575:cf42 with SMTP id fu11-20020a05690c368b00b005a50575cf42mr20698083ywb.40.1697057045483;
        Wed, 11 Oct 2023 13:44:05 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id q2-20020a819902000000b0059bc0d766f8sm1844588ywg.34.2023.10.11.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:44:05 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com,
        ying.huang@intel.com, gregory.price@memverge.com,
        Ravi Jonnalagadda <ravis.opensrc@micron.com>
Subject: [RFC PATCH v2 2/3] mm/memory-tiers: Introduce sysfs for tier interleave weights
Date:   Mon,  9 Oct 2023 16:42:58 -0400
Message-Id: <20231009204259.875232-3-gregory.price@memverge.com>
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

Allocating pages across tiers is accomplished by provisioning
interleave weights for each tier, with the distribution based on
these weight values.

Weights are relative to the node requesting it (i.e. the weight
for tier2 from node0 may be different than the weight for tier2
from node1).  This allows for cpu-bound tasks to have more
precise control over the distribution of memory.

To represent this, tiers are captured as an array of weights,
where the index is the source node.

tier->interleave_weight[source_node] = weight;

weights are set with the following sysfs mechanism:

Set tier4 weight from node 0 to 85
echo 0:85 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight

By default, all tiers will have a weight of 1 for all source nodes,
which maintains the default interleave behavior.

Weights are effectively aligned (up) to the number of nodes in the
operating nodemask (i.e. (policy_nodes & tier_nodes)) to simplify
the allocation logic and to avoid having to hold the tiering
semaphore for a long period of time during bulk allocation.

Weights apply to a tier, not each node in the tier.  The weight is
split between the nodes in that tier, similar to hardware interleaving.
However, when the task defines a nodemask that splits a tier's nodes,
the weight will be split between the remaining nodes - retaining the
overall weight of the tier.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
Co-developed-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
Co-developed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/memory-tiers.h |  16 ++++
 mm/memory-tiers.c            | 140 ++++++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 437441cdf78f..a000b9745543 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -19,6 +19,8 @@
  */
 #define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
 
+#define MAX_TIER_INTERLEAVE_WEIGHT 100
+
 struct memory_tier;
 struct memory_dev_type {
 	/* list of memory types that are part of same tier as this type */
@@ -36,6 +38,9 @@ struct memory_dev_type *alloc_memory_type(int adistance);
 void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype);
+unsigned char memtier_get_node_weight(int from_node, int target_node,
+				      nodemask_t *pol_nodes);
+unsigned int memtier_get_total_weight(int from_node, nodemask_t *pol_nodes);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -97,5 +102,16 @@ static inline bool node_is_toptier(int node)
 {
 	return true;
 }
+
+unsigned char memtier_get_node_weight(int from_node, int target_node,
+				      nodemask_t *pol_nodes)
+{
+	return 0;
+}
+
+unsigned int memtier_get_total_weight(int from_node, nodemask_t *pol_nodes)
+{
+	return 0;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0a3241a2cadc..37fc4b3f69a4 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -14,6 +14,11 @@ struct memory_tier {
 	struct list_head list;
 	/* list of all memory types part of this tier */
 	struct list_head memory_types;
+	/*
+	 * By default all tiers will have weight as 1, which means they
+	 * follow default standard allocation.
+	 */
+	unsigned char interleave_weight[MAX_NUMNODES];
 	/*
 	 * start value of abstract distance. memory tier maps
 	 * an abstract distance  range,
@@ -146,8 +151,72 @@ static ssize_t nodelist_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(nodelist);
 
+static ssize_t interleave_weight_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	int ret = 0;
+	struct memory_tier *tier = to_memory_tier(dev);
+	int node;
+	int count = 0;
+
+	down_read(&memory_tier_sem);
+	for_each_online_node(node) {
+		if (count > 0)
+			ret += sysfs_emit_at(buf, ret, ",");
+		ret += sysfs_emit_at(buf, ret, "%d:%d", node, tier->interleave_weight[node]);
+		count++;
+	}
+	up_read(&memory_tier_sem);
+	sysfs_emit_at(buf, ret++, "\n");
+
+	return ret;
+}
+
+static ssize_t interleave_weight_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t size)
+{
+	unsigned char weight;
+	int from_node;
+	char *delim;
+	int ret;
+	struct memory_tier *tier;
+
+	delim = strchr(buf, ':');
+	if (!delim)
+		return -EINVAL;
+	delim[0] = '\0';
+
+	ret = kstrtou32(buf, 10, &from_node);
+	if (ret)
+		return ret;
+
+	if (from_node >= MAX_NUMNODES || !node_online(from_node))
+		return -EINVAL;
+
+	ret = kstrtou8(delim+1, 0, &weight);
+	if (ret)
+		return ret;
+
+	if (weight > MAX_TIER_INTERLEAVE_WEIGHT)
+		return -EINVAL;
+
+	down_write(&memory_tier_sem);
+	tier = to_memory_tier(dev);
+	if (tier)
+		tier->interleave_weight[from_node] = weight;
+	else
+		ret = -ENODEV;
+	up_write(&memory_tier_sem);
+
+	return size;
+}
+static DEVICE_ATTR_RW(interleave_weight);
+
 static struct attribute *memtier_dev_attrs[] = {
 	&dev_attr_nodelist.attr,
+	&dev_attr_interleave_weight.attr,
 	NULL
 };
 
@@ -239,6 +308,72 @@ static struct memory_tier *__node_get_memory_tier(int node)
 				     lockdep_is_held(&memory_tier_sem));
 }
 
+unsigned char memtier_get_node_weight(int from_node, int target_node,
+				      nodemask_t *pol_nodes)
+{
+	struct memory_tier *tier;
+	unsigned char tier_weight, node_weight = 1;
+	int tier_nodes;
+	nodemask_t tier_nmask, tier_and_pol;
+
+	/*
+	 * If the lock is already held, revert to a low weight temporarily
+	 * This should revert any interleave behavior to basic interleave
+	 * this only happens if weights are being updated or during init
+	 */
+	if (!down_read_trylock(&memory_tier_sem))
+		return 1;
+
+	tier = __node_get_memory_tier(target_node);
+	if (tier) {
+		tier_nmask = get_memtier_nodemask(tier);
+		nodes_and(tier_and_pol, tier_nmask, *pol_nodes);
+		tier_nodes = nodes_weight(tier_and_pol);
+		tier_weight = tier->interleave_weight[from_node];
+		node_weight = tier_weight / tier_nodes;
+		node_weight += (tier_weight % tier_nodes) ? 1 : 0;
+	}
+	up_read(&memory_tier_sem);
+	return node_weight;
+}
+
+unsigned int memtier_get_total_weight(int from_node, nodemask_t *pol_nodes)
+{
+	unsigned int weight = 0;
+	struct memory_tier *tier;
+	unsigned int min = nodes_weight(*pol_nodes);
+	int node;
+	nodemask_t tier_nmask, tier_and_pol;
+	int tier_nodes;
+	unsigned int tier_weight;
+
+	/*
+	 * If the lock is already held, revert to a low weight temporarily
+	 * This should revert any interleave behavior to basic interleave
+	 * this only happens if weights are being updated or during init
+	 */
+	if (!down_read_trylock(&memory_tier_sem))
+		return nodes_weight(*pol_nodes);
+
+	for_each_node_mask(node, *pol_nodes) {
+		tier = __node_get_memory_tier(node);
+		if (!tier) {
+			weight += 1;
+			continue;
+		}
+		tier_nmask = get_memtier_nodemask(tier);
+		nodes_and(tier_and_pol, tier_nmask, *pol_nodes);
+		tier_nodes = nodes_weight(tier_and_pol);
+		/* divide node weight by number of nodes, take ceil */
+		tier_weight = tier->interleave_weight[from_node];
+		weight += tier_weight / tier_nodes;
+		weight += (tier_weight % tier_nodes) ? 1 : 0;
+	}
+	up_read(&memory_tier_sem);
+
+	return weight >= min ? weight : min;
+}
+
 #ifdef CONFIG_MIGRATION
 bool node_is_toptier(int node)
 {
@@ -490,8 +625,11 @@ static struct memory_tier *set_node_memory_tier(int node)
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
 	memtier = find_create_memory_tier(memtype);
-	if (!IS_ERR(memtier))
+	if (!IS_ERR(memtier)) {
 		rcu_assign_pointer(pgdat->memtier, memtier);
+		memset(memtier->interleave_weight, 1,
+		       sizeof(memtier->interleave_weight));
+	}
 	return memtier;
 }
 
-- 
2.39.1

