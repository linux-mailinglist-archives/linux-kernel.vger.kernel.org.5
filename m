Return-Path: <linux-kernel+bounces-48768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A418460F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982A11F27310
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1A8562A;
	Thu,  1 Feb 2024 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJvgEKp3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710628528E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815789; cv=none; b=NYft214ZR5bqrJzE6Cwkqof5kT7mmuNhf8c1Rs5PsFKEPwLB+2A/aOJWai1NslRPn0Ys+EkwkBYcImDsll84TPL5/cYcilShB+06SoHqiszdDXv1X0oMrnZoEnA0TWG2d2u0SdOOFu9LAeY2xdhbbqIDEjFOva7Lmk429+Wjl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815789; c=relaxed/simple;
	bh=xWMKzJ3E5dP2kBqORp++Jj3aGv9et0AAr3ZkPRCk9II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imqiWy1ztj6HO938jd1E32ihZBj+VwbkAFPi/rN226dca1bTHXyo1elRNvPUJdOfEj2MIcdOcylo7QXFMfvUN+VPbRaF3J/SUl286vZgy9NBqrRlSfLRQZrgvoe4/1YRFRPH+miVgNhsdZDGCY2vbAfG6Z3AL5oqqfWVk/DC+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJvgEKp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7FEC43390;
	Thu,  1 Feb 2024 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706815789;
	bh=xWMKzJ3E5dP2kBqORp++Jj3aGv9et0AAr3ZkPRCk9II=;
	h=From:To:Cc:Subject:Date:From;
	b=CJvgEKp3D2MvQ4Bwk+5UvYK7n6A8dqVdyLCClCiVPTyKKUiZsuKWzbdUeStUUn7yL
	 8yxzXCM45gXg/EQ5/fH1gwVKFcwU6hjIwcFJOOvellj8UDIWijRlw7R46UXC6r8prp
	 MyijSz+vU+2I/7m53DDNl0Yn+Vm6EiPGLlTiA3ewCjhzNYEGCIhYxtY6bKTK5z1PA6
	 xM/vmrVxhAFoirEdXjLRgesruO/nB+czXELbFknW1dRigMNZF5IOrSjThJ5ARkYXdP
	 rc2DTwyTdjoptte+horOYpY6VSmXxlrdaaWcixGU7iNSPYdC9Uui0grtMLVZMLH+gf
	 IaMcbrgdK7r8w==
From: Rob Herring <robh@kernel.org>
To: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: fsl: qbman: Remove RESERVEDMEM_OF_DECLARE usage
Date: Thu,  1 Feb 2024 13:29:30 -0600
Message-ID: <20240201192931.1324130-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason to use RESERVEDMEM_OF_DECLARE() as the initialization
hook just saves off the base address and size. Use of
RESERVEDMEM_OF_DECLARE() is reserved for non-driver code and
initialization which must be done early. For qbman, retrieving the
address and size can be done in probe just as easily.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/fsl/qbman/bman_ccsr.c | 27 +++---------
 drivers/soc/fsl/qbman/dpaa_sys.c  | 12 +++--
 drivers/soc/fsl/qbman/dpaa_sys.h  |  4 +-
 drivers/soc/fsl/qbman/qman_ccsr.c | 73 ++++++++++---------------------
 4 files changed, 38 insertions(+), 78 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
index cb24a08be084..b0f26f6f731e 100644
--- a/drivers/soc/fsl/qbman/bman_ccsr.c
+++ b/drivers/soc/fsl/qbman/bman_ccsr.c
@@ -144,17 +144,6 @@ static int bm_set_memory(u64 ba, u32 size)
 static dma_addr_t fbpr_a;
 static size_t fbpr_sz;
 
-static int bman_fbpr(struct reserved_mem *rmem)
-{
-	fbpr_a = rmem->base;
-	fbpr_sz = rmem->size;
-
-	WARN_ON(!(fbpr_a && fbpr_sz));
-
-	return 0;
-}
-RESERVEDMEM_OF_DECLARE(bman_fbpr, "fsl,bman-fbpr", bman_fbpr);
-
 static irqreturn_t bman_isr(int irq, void *ptr)
 {
 	u32 isr_val, ier_val, ecsr_val, isr_mask, i;
@@ -242,17 +231,11 @@ static int fsl_bman_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/*
-	 * If FBPR memory wasn't defined using the qbman compatible string
-	 * try using the of_reserved_mem_device method
-	 */
-	if (!fbpr_a) {
-		ret = qbman_init_private_mem(dev, 0, &fbpr_a, &fbpr_sz);
-		if (ret) {
-			dev_err(dev, "qbman_init_private_mem() failed 0x%x\n",
-				ret);
-			return -ENODEV;
-		}
+	ret = qbman_init_private_mem(dev, 0, "fsl,bman-fbpr", &fbpr_a, &fbpr_sz);
+	if (ret) {
+		dev_err(dev, "qbman_init_private_mem() failed 0x%x\n",
+			ret);
+		return -ENODEV;
 	}
 
 	dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
diff --git a/drivers/soc/fsl/qbman/dpaa_sys.c b/drivers/soc/fsl/qbman/dpaa_sys.c
index 33751450047e..e1d7b79cc450 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.c
+++ b/drivers/soc/fsl/qbman/dpaa_sys.c
@@ -34,8 +34,8 @@
 /*
  * Initialize a devices private memory region
  */
-int qbman_init_private_mem(struct device *dev, int idx, dma_addr_t *addr,
-				size_t *size)
+int qbman_init_private_mem(struct device *dev, int idx, const char *compat,
+			   dma_addr_t *addr, size_t *size)
 {
 	struct device_node *mem_node;
 	struct reserved_mem *rmem;
@@ -44,8 +44,12 @@ int qbman_init_private_mem(struct device *dev, int idx, dma_addr_t *addr,
 
 	mem_node = of_parse_phandle(dev->of_node, "memory-region", idx);
 	if (!mem_node) {
-		dev_err(dev, "No memory-region found for index %d\n", idx);
-		return -ENODEV;
+		mem_node = of_find_compatible_node(NULL, NULL, compat);
+		if (!mem_node) {
+			dev_err(dev, "No memory-region found for index %d or compatible '%s'\n",
+				idx, compat);
+			return -ENODEV;
+		}
 	}
 
 	rmem = of_reserved_mem_lookup(mem_node);
diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index ae8afa552b1e..16485bde9636 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -101,8 +101,8 @@ static inline u8 dpaa_cyc_diff(u8 ringsize, u8 first, u8 last)
 #define DPAA_GENALLOC_OFF	0x80000000
 
 /* Initialize the devices private memory region */
-int qbman_init_private_mem(struct device *dev, int idx, dma_addr_t *addr,
-				size_t *size);
+int qbman_init_private_mem(struct device *dev, int idx, const char *compat,
+			   dma_addr_t *addr, size_t *size);
 
 /* memremap() attributes for different platforms */
 #ifdef CONFIG_PPC
diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 157659fd033a..392e54f14dbe 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -468,28 +468,6 @@ static int zero_priv_mem(phys_addr_t addr, size_t sz)
 
 	return 0;
 }
-
-static int qman_fqd(struct reserved_mem *rmem)
-{
-	fqd_a = rmem->base;
-	fqd_sz = rmem->size;
-
-	WARN_ON(!(fqd_a && fqd_sz));
-	return 0;
-}
-RESERVEDMEM_OF_DECLARE(qman_fqd, "fsl,qman-fqd", qman_fqd);
-
-static int qman_pfdr(struct reserved_mem *rmem)
-{
-	pfdr_a = rmem->base;
-	pfdr_sz = rmem->size;
-
-	WARN_ON(!(pfdr_a && pfdr_sz));
-
-	return 0;
-}
-RESERVEDMEM_OF_DECLARE(qman_pfdr, "fsl,qman-pfdr", qman_pfdr);
-
 #endif
 
 unsigned int qm_get_fqid_maxcnt(void)
@@ -796,39 +774,34 @@ static int fsl_qman_probe(struct platform_device *pdev)
 		qm_channel_caam = QMAN_CHANNEL_CAAM_REV3;
 	}
 
-	if (fqd_a) {
+	/*
+	* Order of memory regions is assumed as FQD followed by PFDR
+	* in order to ensure allocations from the correct regions the
+	* driver initializes then allocates each piece in order
+	*/
+	ret = qbman_init_private_mem(dev, 0, "fsl,qman-fqd", &fqd_a, &fqd_sz);
+	if (ret) {
+		dev_err(dev, "qbman_init_private_mem() for FQD failed 0x%x\n",
+			ret);
+		return -ENODEV;
+	}
 #ifdef CONFIG_PPC
-		/*
-		 * For PPC backward DT compatibility
-		 * FQD memory MUST be zero'd by software
-		 */
-		zero_priv_mem(fqd_a, fqd_sz);
+	/*
+	 * For PPC backward DT compatibility
+	 * FQD memory MUST be zero'd by software
+	 */
+	zero_priv_mem(fqd_a, fqd_sz);
 #else
-		WARN(1, "Unexpected architecture using non shared-dma-mem reservations");
+	WARN(1, "Unexpected architecture using non shared-dma-mem reservations");
 #endif
-	} else {
-		/*
-		 * Order of memory regions is assumed as FQD followed by PFDR
-		 * in order to ensure allocations from the correct regions the
-		 * driver initializes then allocates each piece in order
-		 */
-		ret = qbman_init_private_mem(dev, 0, &fqd_a, &fqd_sz);
-		if (ret) {
-			dev_err(dev, "qbman_init_private_mem() for FQD failed 0x%x\n",
-				ret);
-			return -ENODEV;
-		}
-	}
 	dev_dbg(dev, "Allocated FQD 0x%llx 0x%zx\n", fqd_a, fqd_sz);
 
-	if (!pfdr_a) {
-		/* Setup PFDR memory */
-		ret = qbman_init_private_mem(dev, 1, &pfdr_a, &pfdr_sz);
-		if (ret) {
-			dev_err(dev, "qbman_init_private_mem() for PFDR failed 0x%x\n",
-				ret);
-			return -ENODEV;
-		}
+	/* Setup PFDR memory */
+	ret = qbman_init_private_mem(dev, 1, "fsl,qman-pfdr", &pfdr_a, &pfdr_sz);
+	if (ret) {
+		dev_err(dev, "qbman_init_private_mem() for PFDR failed 0x%x\n",
+			ret);
+		return -ENODEV;
 	}
 	dev_dbg(dev, "Allocated PFDR 0x%llx 0x%zx\n", pfdr_a, pfdr_sz);
 
-- 
2.43.0


