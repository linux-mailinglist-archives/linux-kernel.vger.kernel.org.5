Return-Path: <linux-kernel+bounces-131581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1A8989B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747E01F2D62C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8127129E66;
	Thu,  4 Apr 2024 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC98v50z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C6129A9A;
	Thu,  4 Apr 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240141; cv=none; b=DXR09WqZCqKgPi9LXmhUVEELEKO07Kw24Dd5O4Sv86eIkArbyKIJeQ8+zKrRB9fFebDfqNg9uLzBb/VUA4RuK06T7SnwWt+ZMlOtphJa9oDlx3Oy0PePMpr+OqV9LMgTNQBS6jzCZ4isOilS4eBWgTiwnz4fbObOG25An26CNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240141; c=relaxed/simple;
	bh=+tPhXsIiXNNLRaL9PO2nWdDpnfyN5wkWP/ceOwTMptM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OORWihrQyQsoanZvQ2xAUZ0GHGKTU3RxUenmo/7BAI6DrjPVEjD6TK5bXD+lqEZmLeNnnNaAf2x4XSZRph3CAuMaJMMnpOsb+o7YhxivcFT7ADo668QK82v6QRv27uQ24lkMJjuGi0b2vofSObuO9TePTVVfCz2rev9X5MjhYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC98v50z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40579C433C7;
	Thu,  4 Apr 2024 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712240140;
	bh=+tPhXsIiXNNLRaL9PO2nWdDpnfyN5wkWP/ceOwTMptM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eC98v50zw8xKuQevrDgaMGLl7AICPcIgw1AGIP+N5S641/EZEN6DvSGgeg4IyQhOj
	 wKXmV/GOGdWnHKGiK/kQlSfh+RflJWZBmfff1gGPBH067goHEhm8u37Bn8h9ev0SBj
	 dakANYhkjCZ58h8X07U+DeuQn++dAAP/O8q9M4xA9ozXpUMAeNsSeInpVUESVFRmXV
	 W5lhWYFlylXjh9kM+nNt6QuW7kdMO+aePArtvk4ddSqeO/v916BDzDGIW+vjQ++7nE
	 E4Ur+BCZFPf83BKCQJKOeLJKJ004A3k3WplGXHp145FLNg/jTFjLJCQAYoZB59EgyJ
	 s5B01R+uLk/FA==
From: Rob Herring <robh@kernel.org>
Date: Thu, 04 Apr 2024 09:15:12 -0500
Subject: [PATCH 3/3] of: Use scope based of_node_put() cleanups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-dt-cleanup-free-v1-3-c60e6cba8da9@kernel.org>
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
In-Reply-To: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev

Use the relatively new scope based of_node_put() cleanup to simplify
function exit handling. Doing so reduces the chances of forgetting an
of_node_put() and simplifies error paths by avoiding the need for goto
statements.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c  | 60 ++++++++++++++++-----------------------------------
 drivers/of/property.c | 22 ++++++-------------
 2 files changed, 26 insertions(+), 56 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index ae46a3605904..f7b2d535a6d1 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -491,7 +491,6 @@ static u64 __of_translate_address(struct device_node *dev,
 				  const __be32 *in_addr, const char *rprop,
 				  struct device_node **host)
 {
-	struct device_node *parent = NULL;
 	struct of_bus *bus, *pbus;
 	__be32 addr[OF_MAX_ADDR_CELLS];
 	int na, ns, pna, pns;
@@ -504,7 +503,7 @@ static u64 __of_translate_address(struct device_node *dev,
 
 	*host = NULL;
 	/* Get parent & match bus type */
-	parent = get_parent(dev);
+	struct device_node *parent __free(device_node) = get_parent(dev);
 	if (parent == NULL)
 		goto bail;
 	bus = of_match_bus(parent);
@@ -573,7 +572,6 @@ static u64 __of_translate_address(struct device_node *dev,
 		of_dump_addr("one level translation:", addr, na);
 	}
  bail:
-	of_node_put(parent);
 	of_node_put(dev);
 
 	return result;
@@ -654,19 +652,16 @@ EXPORT_SYMBOL(of_translate_dma_address);
 const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *prop,
 				      phys_addr_t *start, size_t *length)
 {
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = __of_get_dma_parent(dev);
 	u64 address, size;
 	int na, ns;
 
-	parent = __of_get_dma_parent(dev);
 	if (!parent)
 		return NULL;
 
 	na = of_bus_n_addr_cells(parent);
 	ns = of_bus_n_size_cells(parent);
 
-	of_node_put(parent);
-
 	address = of_translate_dma_address(dev, prop);
 	if (address == OF_BAD_ADDR)
 		return NULL;
@@ -688,21 +683,19 @@ const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
 {
 	const __be32 *prop;
 	unsigned int psize;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = of_get_parent(dev);
 	struct of_bus *bus;
 	int onesize, i, na, ns;
 
-	/* Get parent & match bus type */
-	parent = of_get_parent(dev);
 	if (parent == NULL)
 		return NULL;
+
+	/* match the parent's bus type */
 	bus = of_match_bus(parent);
-	if (strcmp(bus->name, "pci") && (bar_no >= 0)) {
-		of_node_put(parent);
+	if (strcmp(bus->name, "pci") && (bar_no >= 0))
 		return NULL;
-	}
+
 	bus->count_cells(dev, &na, &ns);
-	of_node_put(parent);
 	if (!OF_CHECK_ADDR_COUNT(na))
 		return NULL;
 
@@ -888,14 +881,13 @@ static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
  */
 int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 {
-	struct device_node *node = of_node_get(np);
+	struct device_node *node __free(device_node) = of_node_get(np);
 	const __be32 *ranges = NULL;
 	bool found_dma_ranges = false;
 	struct of_range_parser parser;
 	struct of_range range;
 	struct bus_dma_region *r;
 	int len, num_ranges = 0;
-	int ret = 0;
 
 	while (node) {
 		ranges = of_get_property(node, "dma-ranges", &len);
@@ -905,10 +897,9 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 			break;
 
 		/* Once we find 'dma-ranges', then a missing one is an error */
-		if (found_dma_ranges && !ranges) {
-			ret = -ENODEV;
-			goto out;
-		}
+		if (found_dma_ranges && !ranges)
+			return -ENODEV;
+
 		found_dma_ranges = true;
 
 		node = of_get_next_dma_parent(node);
@@ -916,10 +907,8 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 
 	if (!node || !ranges) {
 		pr_debug("no dma-ranges found for node(%pOF)\n", np);
-		ret = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
-
 	of_dma_range_parser_init(&parser, node);
 	for_each_of_range(&parser, &range) {
 		if (range.cpu_addr == OF_BAD_ADDR) {
@@ -930,16 +919,12 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 		num_ranges++;
 	}
 
-	if (!num_ranges) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!num_ranges)
+		return -EINVAL;
 
 	r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
-	if (!r) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!r)
+		return -ENOMEM;
 
 	/*
 	 * Record all info in the generic DMA ranges array for struct device,
@@ -957,9 +942,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 		r->size = range.size;
 		r++;
 	}
-out:
-	of_node_put(node);
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_HAS_DMA */
 
@@ -1016,11 +999,9 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
  */
 bool of_dma_is_coherent(struct device_node *np)
 {
-	struct device_node *node;
+	struct device_node *node __free(device_node) = of_node_get(np);
 	bool is_coherent = dma_default_coherent;
 
-	node = of_node_get(np);
-
 	while (node) {
 		if (of_property_read_bool(node, "dma-coherent")) {
 			is_coherent = true;
@@ -1032,7 +1013,6 @@ bool of_dma_is_coherent(struct device_node *np)
 		}
 		node = of_get_next_dma_parent(node);
 	}
-	of_node_put(node);
 	return is_coherent;
 }
 EXPORT_SYMBOL_GPL(of_dma_is_coherent);
@@ -1049,19 +1029,17 @@ EXPORT_SYMBOL_GPL(of_dma_is_coherent);
  */
 static bool of_mmio_is_nonposted(struct device_node *np)
 {
-	struct device_node *parent;
 	bool nonposted;
 
 	if (!IS_ENABLED(CONFIG_ARCH_APPLE))
 		return false;
 
-	parent = of_get_parent(np);
+	struct device_node *parent __free(device_node) = of_get_parent(np);
 	if (!parent)
 		return false;
 
 	nonposted = of_property_read_bool(parent, "nonposted-mmio");
 
-	of_node_put(parent);
 	return nonposted;
 }
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index a6358ee99b74..b73daf81c99d 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -40,15 +40,12 @@
  */
 bool of_graph_is_present(const struct device_node *node)
 {
-	struct device_node *ports, *port;
+	struct device_node *ports __free(device_node) = of_get_child_by_name(node, "ports");
 
-	ports = of_get_child_by_name(node, "ports");
 	if (ports)
 		node = ports;
 
-	port = of_get_child_by_name(node, "port");
-	of_node_put(ports);
-	of_node_put(port);
+	struct device_node *port __free(device_node) = of_get_child_by_name(node, "port");
 
 	return !!port;
 }
@@ -610,9 +607,9 @@ EXPORT_SYMBOL(of_graph_parse_endpoint);
  */
 struct device_node *of_graph_get_port_by_id(struct device_node *parent, u32 id)
 {
-	struct device_node *node, *port;
+	struct device_node *port;
+	struct device_node *node __free(device_node) = of_get_child_by_name(parent, "ports");
 
-	node = of_get_child_by_name(parent, "ports");
 	if (node)
 		parent = node;
 
@@ -626,8 +623,6 @@ struct device_node *of_graph_get_port_by_id(struct device_node *parent, u32 id)
 			break;
 	}
 
-	of_node_put(node);
-
 	return port;
 }
 EXPORT_SYMBOL(of_graph_get_port_by_id);
@@ -655,14 +650,13 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 	 * parent port node.
 	 */
 	if (!prev) {
-		struct device_node *node;
+		struct device_node *node __free(device_node) =
+			of_get_child_by_name(parent, "ports");
 
-		node = of_get_child_by_name(parent, "ports");
 		if (node)
 			parent = node;
 
 		port = of_get_child_by_name(parent, "port");
-		of_node_put(node);
 
 		if (!port) {
 			pr_debug("graph: no port node found in %pOF\n", parent);
@@ -1052,15 +1046,13 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 					  struct fwnode_endpoint *endpoint)
 {
 	const struct device_node *node = to_of_node(fwnode);
-	struct device_node *port_node = of_get_parent(node);
+	struct device_node *port_node __free(device_node) = of_get_parent(node);
 
 	endpoint->local_fwnode = fwnode;
 
 	of_property_read_u32(port_node, "reg", &endpoint->port);
 	of_property_read_u32(node, "reg", &endpoint->id);
 
-	of_node_put(port_node);
-
 	return 0;
 }
 

-- 
2.43.0


