Return-Path: <linux-kernel+bounces-131580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97288989B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33E61C29AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86F1292F2;
	Thu,  4 Apr 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM9sLNZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E21292EB;
	Thu,  4 Apr 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240138; cv=none; b=D3eiWxnJD+OdnzGa5mmLkyza3T0dSKsVAcdGD3FYWbgnZvY8oLh7KeH9pjXjp6ERpBKbW3rk3QYtir3p90EYCgl0IKRB4jajbodx+fooapSONlMAY/tDmnrSFM9PeDvcD667j24eALl2Penwb4jgUPauOBTWjQ9q0X7AQ0/UO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240138; c=relaxed/simple;
	bh=3WdnQmshomibzByZClEkGia7PnK6CWBXCQshlze4d+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMrrNHmBACtU7pIv84o1Mys6SIg52FfYKbcpFufBQMR6lg7KdtszWSZ9P5dA8B4gVE8oyizSlk6pbMq5iYZZOXUhFLgN1mvXmK5SejDu+LnzkDNF9t5aoS34r1Md9dquI134IOzrsWL5UKnkaj1BLHyY9qyBjJenU1TrRNbnJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM9sLNZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C55C43390;
	Thu,  4 Apr 2024 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712240138;
	bh=3WdnQmshomibzByZClEkGia7PnK6CWBXCQshlze4d+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jM9sLNZDJCyGA8EVCGqMJDWNJurpEUFOlM0x6Am4RGRjjBGFRiRaB9NsO5fFyJ+MX
	 WfUqw+KJneyFVcctw4j3ZS7orXCXOUg5Pu1sdOa8FDJhTvXiU5yDbrCR2eWtNBAKFN
	 bLgJ1T8jicXImpA6g1Lt8o4fGfDK72CDUb4vMAL/nSi/tmG2SloBvicaq0UXivXFy4
	 DnyG4Ovj24vn6mgTgb09yM5YwVZrtu3V2eLmld+vPuphTDL9zkSojaf+whzZIb0TUv
	 tj/mGPGrRMyq2hsY6A98qJHwa9nkCfQViQnXKfehcxbtBHXLfp3x25lTN7u9JglQ5u
	 qyTiz1YN9aU8g==
From: Rob Herring <robh@kernel.org>
Date: Thu, 04 Apr 2024 09:15:11 -0500
Subject: [PATCH 2/3] of: Use scope based kfree() cleanups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-dt-cleanup-free-v1-2-c60e6cba8da9@kernel.org>
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
In-Reply-To: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev

Use the relatively new scope based kfree() cleanup to simplify error
handling. Doing so reduces the chances of memory leaks and simplifies
error paths by avoiding the need for goto statements.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c     | 34 ++++++++--------------------------
 drivers/of/dynamic.c  | 11 ++++-------
 drivers/of/resolver.c | 35 +++++++++++++----------------------
 3 files changed, 25 insertions(+), 55 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8856c67c466a..20603d3c9931 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/cpu.h>
@@ -1393,8 +1394,10 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 				   const char *stem_name,
 				   int index, struct of_phandle_args *out_args)
 {
-	char *cells_name, *map_name = NULL, *mask_name = NULL;
-	char *pass_name = NULL;
+	char *cells_name __free(kfree) = kasprintf(GFP_KERNEL, "#%s-cells", stem_name);
+	char *map_name __free(kfree) = kasprintf(GFP_KERNEL, "%s-map", stem_name);
+	char *mask_name __free(kfree) = kasprintf(GFP_KERNEL, "%s-map-mask", stem_name);
+	char *pass_name __free(kfree) = kasprintf(GFP_KERNEL, "%s-map-pass-thru", stem_name);
 	struct device_node *cur, *new = NULL;
 	const __be32 *map, *mask, *pass;
 	static const __be32 dummy_mask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
@@ -1407,27 +1410,13 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 	if (index < 0)
 		return -EINVAL;
 
-	cells_name = kasprintf(GFP_KERNEL, "#%s-cells", stem_name);
-	if (!cells_name)
+	if (!cells_name || !map_name || !mask_name || !pass_name)
 		return -ENOMEM;
 
-	ret = -ENOMEM;
-	map_name = kasprintf(GFP_KERNEL, "%s-map", stem_name);
-	if (!map_name)
-		goto free;
-
-	mask_name = kasprintf(GFP_KERNEL, "%s-map-mask", stem_name);
-	if (!mask_name)
-		goto free;
-
-	pass_name = kasprintf(GFP_KERNEL, "%s-map-pass-thru", stem_name);
-	if (!pass_name)
-		goto free;
-
 	ret = __of_parse_phandle_with_args(np, list_name, cells_name, -1, index,
 					   out_args);
 	if (ret)
-		goto free;
+		return ret;
 
 	/* Get the #<list>-cells property */
 	cur = out_args->np;
@@ -1444,8 +1433,7 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 		/* Get the <list>-map property */
 		map = of_get_property(cur, map_name, &map_len);
 		if (!map) {
-			ret = 0;
-			goto free;
+			return 0;
 		}
 		map_len /= sizeof(u32);
 
@@ -1521,12 +1509,6 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 put:
 	of_node_put(cur);
 	of_node_put(new);
-free:
-	kfree(mask_name);
-	kfree(map_name);
-	kfree(cells_name);
-	kfree(pass_name);
-
 	return ret;
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args_map);
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index af7c57a7a25d..43f4e2c93bd2 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -1019,10 +1020,9 @@ int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
 				    const u32 *array, size_t sz)
 {
 	struct property prop;
-	__be32 *val;
-	int i, ret;
+	__be32 *val __free(kfree) = kcalloc(sz, sizeof(__be32), GFP_KERNEL);
+	int i;
 
-	val = kcalloc(sz, sizeof(__be32), GFP_KERNEL);
 	if (!val)
 		return -ENOMEM;
 
@@ -1032,9 +1032,6 @@ int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
 	prop.length = sizeof(u32) * sz;
 	prop.value = (void *)val;
 
-	ret = of_changeset_add_prop_helper(ocs, np, &prop);
-	kfree(val);
-
-	return ret;
+	return of_changeset_add_prop_helper(ocs, np, &prop);
 }
 EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index b278ab4338ce..2780928764a4 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt)	"OF: resolver: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -74,11 +75,11 @@ static int update_usages_of_a_phandle_reference(struct device_node *overlay,
 {
 	struct device_node *refnode;
 	struct property *prop;
-	char *value, *cur, *end, *node_path, *prop_name, *s;
+	char *value __free(kfree) = kmemdup(prop_fixup->value, prop_fixup->length, GFP_KERNEL);
+	char *cur, *end, *node_path, *prop_name, *s;
 	int offset, len;
 	int err = 0;
 
-	value = kmemdup(prop_fixup->value, prop_fixup->length, GFP_KERNEL);
 	if (!value)
 		return -ENOMEM;
 
@@ -89,23 +90,19 @@ static int update_usages_of_a_phandle_reference(struct device_node *overlay,
 
 		node_path = cur;
 		s = strchr(cur, ':');
-		if (!s) {
-			err = -EINVAL;
-			goto err_fail;
-		}
+		if (!s)
+			return -EINVAL;
 		*s++ = '\0';
 
 		prop_name = s;
 		s = strchr(s, ':');
-		if (!s) {
-			err = -EINVAL;
-			goto err_fail;
-		}
+		if (!s)
+			return -EINVAL;
 		*s++ = '\0';
 
 		err = kstrtoint(s, 10, &offset);
 		if (err)
-			goto err_fail;
+			return err;
 
 		refnode = __of_find_node_by_full_path(of_node_get(overlay), node_path);
 		if (!refnode)
@@ -117,22 +114,16 @@ static int update_usages_of_a_phandle_reference(struct device_node *overlay,
 		}
 		of_node_put(refnode);
 
-		if (!prop) {
-			err = -ENOENT;
-			goto err_fail;
-		}
+		if (!prop)
+			return -ENOENT;
 
-		if (offset < 0 || offset + sizeof(__be32) > prop->length) {
-			err = -EINVAL;
-			goto err_fail;
-		}
+		if (offset < 0 || offset + sizeof(__be32) > prop->length)
+			return -EINVAL;
 
 		*(__be32 *)(prop->value + offset) = cpu_to_be32(phandle);
 	}
 
-err_fail:
-	kfree(value);
-	return err;
+	return 0;
 }
 
 /* compare nodes taking into account that 'name' strips out the @ part */

-- 
2.43.0


