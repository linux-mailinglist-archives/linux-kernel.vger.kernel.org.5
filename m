Return-Path: <linux-kernel+bounces-99350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BE6878719
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF7E1F218FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47CD53E0A;
	Mon, 11 Mar 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkrS8WAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC973BB29;
	Mon, 11 Mar 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180884; cv=none; b=Ijeq6SzVz8P87ZABTdxWAw7hwAmrdpgV187Dip+gxGVjR32sSUfLkmRyNBJG0BsbejWFVEqgsPyAXBfprTgwkA6bvXyHGb6Jn1BkwyeBpjf91kedkbEyijNAs5dO3zPJ4VH4FVlW0mGS1mrEkA7ugG5ZXHlSlIQCyTqh0+vAMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180884; c=relaxed/simple;
	bh=lSb+0tXHRomol4V2KClwntyt4wRb4xhImCPl/rB2eLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIY0Me3S5f1jPyGyN1TPirz7QQfAbe08eVYWfctC3YHCfa++5UdAQ/tkA+h+lcyJlJ4eUtDMHdOq9G9nMWHMNaABu7wg9t6y1VC2LMs/TzWDiq+Wlg0OEuSpUZBnmw/pTqllcR7CQjPWa/hNvdwglaMV5DIZiVg3mD8N5UHdiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkrS8WAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3981C433C7;
	Mon, 11 Mar 2024 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710180884;
	bh=lSb+0tXHRomol4V2KClwntyt4wRb4xhImCPl/rB2eLY=;
	h=From:To:Cc:Subject:Date:From;
	b=RkrS8WAqZ1r7vlKZX76iYcSMNFGFY0Ks5GoarLClo3QV0hoJm3lWU1ljpRn+8eZKR
	 kIZz+z1Y8ietMv3O1Wg8mcdhTAC9rSxJWrH9RBac9LO/g1/PNJTvqMMZhy+jHP1lsq
	 +YGqOvmrXFDBF8hNn+BkD1v2MjXLMvhodlHq7Hd7/u8A//3QudyV0TpvK21RELAv6u
	 gOpVQiGXZIzjgmzQw57w3RqfviPxZejdu/m+uKmhQ9cQlIZuQ6bJD9cdsje3lCOKKr
	 IyWjpPeCX2zR+4NKYulBM8MuVPy+nlihsaDUigiomdneqFNyJCQn02E5f/pbt1OJLv
	 EDlqGVH5Bb99w==
From: Rob Herring <robh@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: Move all FDT reserved-memory handling into of_reserved_mem.c
Date: Mon, 11 Mar 2024 12:13:03 -0600
Message-ID: <20240311181303.1516514-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The split of /reserved-memory handling between fdt.c and
of_reserved_mem.c makes for reading and restructuring the code
difficult. As of_reserved_mem.c is only built for
CONFIG_OF_EARLY_FLATTREE already, move all the code to one spot.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Oreoluwa, Please rebase your series on top of this.

 drivers/of/fdt.c             | 123 +---------------------------------
 drivers/of/of_private.h      |   5 +-
 drivers/of/of_reserved_mem.c | 125 ++++++++++++++++++++++++++++++++++-
 3 files changed, 127 insertions(+), 126 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e5a385285149..a8a04f27915b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -17,7 +17,6 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
-#include <linux/of_reserved_mem.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -88,7 +87,7 @@ void __init of_fdt_limit_memory(int limit)
 	}
 }
 
-static bool of_fdt_device_is_available(const void *blob, unsigned long node)
+bool of_fdt_device_is_available(const void *blob, unsigned long node)
 {
 	const char *status = fdt_getprop(blob, node, "status", NULL);
 
@@ -484,126 +483,6 @@ void *initial_boot_params __ro_after_init;
 
 static u32 of_fdt_crc32;
 
-static int __init early_init_dt_reserve_memory(phys_addr_t base,
-					       phys_addr_t size, bool nomap)
-{
-	if (nomap) {
-		/*
-		 * If the memory is already reserved (by another region), we
-		 * should not allow it to be marked nomap, but don't worry
-		 * if the region isn't memory as it won't be mapped.
-		 */
-		if (memblock_overlaps_region(&memblock.memory, base, size) &&
-		    memblock_is_region_reserved(base, size))
-			return -EBUSY;
-
-		return memblock_mark_nomap(base, size);
-	}
-	return memblock_reserve(base, size);
-}
-
-/*
- * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
- */
-static int __init __reserved_mem_reserve_reg(unsigned long node,
-					     const char *uname)
-{
-	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
-	phys_addr_t base, size;
-	int len;
-	const __be32 *prop;
-	int first = 1;
-	bool nomap;
-
-	prop = of_get_flat_dt_prop(node, "reg", &len);
-	if (!prop)
-		return -ENOENT;
-
-	if (len && len % t_len != 0) {
-		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
-		       uname);
-		return -EINVAL;
-	}
-
-	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-
-	while (len >= t_len) {
-		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
-		size = dt_mem_next_cell(dt_root_size_cells, &prop);
-
-		if (size &&
-		    early_init_dt_reserve_memory(base, size, nomap) == 0)
-			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
-				uname, &base, (unsigned long)(size / SZ_1M));
-		else
-			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
-			       uname, &base, (unsigned long)(size / SZ_1M));
-
-		len -= t_len;
-		if (first) {
-			fdt_reserved_mem_save_node(node, uname, base, size);
-			first = 0;
-		}
-	}
-	return 0;
-}
-
-/*
- * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
- * in /reserved-memory matches the values supported by the current implementation,
- * also check if ranges property has been provided
- */
-static int __init __reserved_mem_check_root(unsigned long node)
-{
-	const __be32 *prop;
-
-	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
-	if (!prop || be32_to_cpup(prop) != dt_root_size_cells)
-		return -EINVAL;
-
-	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
-	if (!prop || be32_to_cpup(prop) != dt_root_addr_cells)
-		return -EINVAL;
-
-	prop = of_get_flat_dt_prop(node, "ranges", NULL);
-	if (!prop)
-		return -EINVAL;
-	return 0;
-}
-
-/*
- * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
- */
-static int __init fdt_scan_reserved_mem(void)
-{
-	int node, child;
-	const void *fdt = initial_boot_params;
-
-	node = fdt_path_offset(fdt, "/reserved-memory");
-	if (node < 0)
-		return -ENODEV;
-
-	if (__reserved_mem_check_root(node) != 0) {
-		pr_err("Reserved memory: unsupported node format, ignoring\n");
-		return -EINVAL;
-	}
-
-	fdt_for_each_subnode(child, fdt, node) {
-		const char *uname;
-		int err;
-
-		if (!of_fdt_device_is_available(fdt, child))
-			continue;
-
-		uname = fdt_get_name(fdt, child, NULL);
-
-		err = __reserved_mem_reserve_reg(child, uname);
-		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			fdt_reserved_mem_save_node(child, uname, 0, 0);
-	}
-	return 0;
-}
-
 /*
  * fdt_reserve_elfcorehdr() - reserves memory for elf core header
  *
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f38397c7b582..485483524b7f 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -175,8 +175,9 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 }
 #endif
 
+int fdt_scan_reserved_mem(void);
 void fdt_init_reserved_mem(void);
-void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
-			       phys_addr_t base, phys_addr_t size);
+
+bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcbddb..8236ecae2953 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"OF: reserved mem: " fmt
 
 #include <linux/err.h>
+#include <linux/libfdt.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
@@ -58,8 +59,8 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
-void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
-				      phys_addr_t base, phys_addr_t size)
+static void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
+					      phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
@@ -77,6 +78,126 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 	return;
 }
 
+static int __init early_init_dt_reserve_memory(phys_addr_t base,
+					       phys_addr_t size, bool nomap)
+{
+	if (nomap) {
+		/*
+		 * If the memory is already reserved (by another region), we
+		 * should not allow it to be marked nomap, but don't worry
+		 * if the region isn't memory as it won't be mapped.
+		 */
+		if (memblock_overlaps_region(&memblock.memory, base, size) &&
+		    memblock_is_region_reserved(base, size))
+			return -EBUSY;
+
+		return memblock_mark_nomap(base, size);
+	}
+	return memblock_reserve(base, size);
+}
+
+/*
+ * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
+ */
+static int __init __reserved_mem_reserve_reg(unsigned long node,
+					     const char *uname)
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	phys_addr_t base, size;
+	int len;
+	const __be32 *prop;
+	int first = 1;
+	bool nomap;
+
+	prop = of_get_flat_dt_prop(node, "reg", &len);
+	if (!prop)
+		return -ENOENT;
+
+	if (len && len % t_len != 0) {
+		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+		       uname);
+		return -EINVAL;
+	}
+
+	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+
+	while (len >= t_len) {
+		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+		if (size &&
+		    early_init_dt_reserve_memory(base, size, nomap) == 0)
+			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
+				uname, &base, (unsigned long)(size / SZ_1M));
+		else
+			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
+			       uname, &base, (unsigned long)(size / SZ_1M));
+
+		len -= t_len;
+		if (first) {
+			fdt_reserved_mem_save_node(node, uname, base, size);
+			first = 0;
+		}
+	}
+	return 0;
+}
+
+/*
+ * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
+ * in /reserved-memory matches the values supported by the current implementation,
+ * also check if ranges property has been provided
+ */
+static int __init __reserved_mem_check_root(unsigned long node)
+{
+	const __be32 *prop;
+
+	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
+	if (!prop || be32_to_cpup(prop) != dt_root_size_cells)
+		return -EINVAL;
+
+	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
+	if (!prop || be32_to_cpup(prop) != dt_root_addr_cells)
+		return -EINVAL;
+
+	prop = of_get_flat_dt_prop(node, "ranges", NULL);
+	if (!prop)
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
+ */
+int __init fdt_scan_reserved_mem(void)
+{
+	int node, child;
+	const void *fdt = initial_boot_params;
+
+	node = fdt_path_offset(fdt, "/reserved-memory");
+	if (node < 0)
+		return -ENODEV;
+
+	if (__reserved_mem_check_root(node) != 0) {
+		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		return -EINVAL;
+	}
+
+	fdt_for_each_subnode(child, fdt, node) {
+		const char *uname;
+		int err;
+
+		if (!of_fdt_device_is_available(fdt, child))
+			continue;
+
+		uname = fdt_get_name(fdt, child, NULL);
+
+		err = __reserved_mem_reserve_reg(child, uname);
+		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
+			fdt_reserved_mem_save_node(child, uname, 0, 0);
+	}
+	return 0;
+}
+
 /*
  * __reserved_mem_alloc_in_range() - allocate reserved memory described with
  *	'alloc-ranges'. Choose bottom-up/top-down depending on nearby existing
-- 
2.43.0


