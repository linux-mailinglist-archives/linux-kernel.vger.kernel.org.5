Return-Path: <linux-kernel+bounces-115493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45712889406
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF21D294E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC31148830;
	Mon, 25 Mar 2024 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smHebqY0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42001DCCB9;
	Sun, 24 Mar 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320914; cv=none; b=mZrbuMFnfTpxIaP9VpD8pFBwlCI6xVf6B+WPtAbJdRWIMvtnI0FVzJsBPSwpgGtsvSkV9UqCpg4nuH5mIHocGHtJ9JEI8pQZsESo80vvhkcT6iXbV+NKE/JrvgVx0nfQqVvIRGcGdQXJyY2rWtbaHp8kWoOlLvaKlh9InMkeAtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320914; c=relaxed/simple;
	bh=XrDfJCtAnf69kzmz42Qf1087fuBP6Zjhu5G7+jGlxAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeX2o3d5OHI0FXN7e/BpyMuRpUkyRFGfxi8AT28VWQ+GZgxIU1humS3isBgDSmMRJ+zHxQVcoO/ZUhvhYzV4zcIwWw6aIuxo0qOIEjOnoMdmBsfzHib2hcNsO28wXFY8pzbIGMJKvDcqrxnt7elRjVYEz2Y8HxKhGZLpfEI3O44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smHebqY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC1EC433F1;
	Sun, 24 Mar 2024 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320913;
	bh=XrDfJCtAnf69kzmz42Qf1087fuBP6Zjhu5G7+jGlxAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smHebqY07dgyfSPpmzvdFPwZFE+qnGJ/HvWksWEGtPWRHlUvSInRJ5ijbRhEoqBTa
	 6EAbUg47NLiAD6ogk/EEeFjja0hiXlRo/e7fdiNQOYttWRtyjgENbDERezxKg82qbm
	 lxPQ3lqkCqMLvPLFkJkIF61jBaj7MPjgYaXjzXCe2Z1VEmXNqYMUahxYgP3YTBelBb
	 pfrtGs5yuPNoQy6XJ+18W75bYaBdoFGTvpn2Hetcug+KXUkHgnMM9qSMgp8GXnLzTi
	 I0AL1jO/rBMZ91x9X3CuUKFW4UxhQ/HONKp8BKl53W3AUiLcTBYVJldHBKYum6nd53
	 VwOZFK7bq4DYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 477/713] drm/msm/dpu: use devres-managed allocation for HW blocks
Date: Sun, 24 Mar 2024 18:43:23 -0400
Message-ID: <20240324224720.1345309-478-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit a106ed98af6848ef5810b12f5c9e2e0566f1d9c4 ]

Use devm_kzalloc to create HW block structure. This allows us to remove
corresponding kfree and drop all dpu_hw_*_destroy() functions as well as
dpu_rm_destroy(), which becomes empty afterwards.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/570041/
Link: https://lore.kernel.org/r/20231201211845.1026967-7-dmitry.baryshkov@linaro.org
Stable-dep-of: 49e27d3c9cd6 ("drm/msm/dpu: finalise global state object")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c    | 19 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h    | 16 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c    | 12 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h    | 10 ++-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c    |  7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c   | 16 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h   | 12 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   | 16 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h   | 13 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c     | 14 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h     | 12 +--
 .../gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c    | 14 ++-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h    | 13 +--
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   | 15 ++--
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   | 14 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   | 17 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h   | 16 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c     | 15 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h     | 13 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |  1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c        | 90 +++----------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h        | 11 +--
 23 files changed, 127 insertions(+), 247 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 86182c7346060..e7b680a151d6d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -4,6 +4,9 @@
  */
 
 #include <linux/delay.h>
+
+#include <drm/drm_managed.h>
+
 #include "dpu_hwio.h"
 #include "dpu_hw_ctl.h"
 #include "dpu_kms.h"
@@ -680,14 +683,15 @@ static void _setup_ctl_ops(struct dpu_hw_ctl_ops *ops,
 		ops->set_active_pipes = dpu_hw_ctl_set_fetch_pipe_active;
 };
 
-struct dpu_hw_ctl *dpu_hw_ctl_init(const struct dpu_ctl_cfg *cfg,
-		void __iomem *addr,
-		u32 mixer_count,
-		const struct dpu_lm_cfg *mixer)
+struct dpu_hw_ctl *dpu_hw_ctl_init(struct drm_device *dev,
+				   const struct dpu_ctl_cfg *cfg,
+				   void __iomem *addr,
+				   u32 mixer_count,
+				   const struct dpu_lm_cfg *mixer)
 {
 	struct dpu_hw_ctl *c;
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
@@ -702,8 +706,3 @@ struct dpu_hw_ctl *dpu_hw_ctl_init(const struct dpu_ctl_cfg *cfg,
 
 	return c;
 }
-
-void dpu_hw_ctl_destroy(struct dpu_hw_ctl *ctx)
-{
-	kfree(ctx);
-}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index 1c242298ff2ee..279ebd8dfbff7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -274,20 +274,16 @@ static inline struct dpu_hw_ctl *to_dpu_hw_ctl(struct dpu_hw_blk *hw)
 /**
  * dpu_hw_ctl_init() - Initializes the ctl_path hw driver object.
  * Should be called before accessing any ctl_path register.
+ * @dev:  Corresponding device for devres management
  * @cfg:  ctl_path catalog entry for which driver object is required
  * @addr: mapped register io address of MDP
  * @mixer_count: Number of mixers in @mixer
  * @mixer: Pointer to an array of Layer Mixers defined in the catalog
  */
-struct dpu_hw_ctl *dpu_hw_ctl_init(const struct dpu_ctl_cfg *cfg,
-		void __iomem *addr,
-		u32 mixer_count,
-		const struct dpu_lm_cfg *mixer);
-
-/**
- * dpu_hw_ctl_destroy(): Destroys ctl driver context
- * should be called to free the context
- */
-void dpu_hw_ctl_destroy(struct dpu_hw_ctl *ctx);
+struct dpu_hw_ctl *dpu_hw_ctl_init(struct drm_device *dev,
+				   const struct dpu_ctl_cfg *cfg,
+				   void __iomem *addr,
+				   u32 mixer_count,
+				   const struct dpu_lm_cfg *mixer);
 
 #endif /*_DPU_HW_CTL_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
index 509dbaa51d878..5e9aad1b2aa28 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2020-2022, Linaro Limited
  */
 
+#include <drm/drm_managed.h>
+
 #include <drm/display/drm_dsc_helper.h>
 
 #include "dpu_kms.h"
@@ -188,12 +190,13 @@ static void _setup_dsc_ops(struct dpu_hw_dsc_ops *ops,
 		ops->dsc_bind_pingpong_blk = dpu_hw_dsc_bind_pingpong_blk;
 };
 
-struct dpu_hw_dsc *dpu_hw_dsc_init(const struct dpu_dsc_cfg *cfg,
+struct dpu_hw_dsc *dpu_hw_dsc_init(struct drm_device *dev,
+				   const struct dpu_dsc_cfg *cfg,
 				   void __iomem *addr)
 {
 	struct dpu_hw_dsc *c;
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
@@ -206,8 +209,3 @@ struct dpu_hw_dsc *dpu_hw_dsc_init(const struct dpu_dsc_cfg *cfg,
 
 	return c;
 }
-
-void dpu_hw_dsc_destroy(struct dpu_hw_dsc *dsc)
-{
-	kfree(dsc);
-}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
index d5b597ab8c5ca..989c88d2449b6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
@@ -64,20 +64,24 @@ struct dpu_hw_dsc {
 
 /**
  * dpu_hw_dsc_init() - Initializes the DSC hw driver object.
+ * @dev:  Corresponding device for devres management
  * @cfg:  DSC catalog entry for which driver object is required
  * @addr: Mapped register io address of MDP
  * Return: Error code or allocated dpu_hw_dsc context
  */
-struct dpu_hw_dsc *dpu_hw_dsc_init(const struct dpu_dsc_cfg *cfg,
-		void __iomem *addr);
+struct dpu_hw_dsc *dpu_hw_dsc_init(struct drm_device *dev,
+				   const struct dpu_dsc_cfg *cfg,
+				   void __iomem *addr);
 
 /**
  * dpu_hw_dsc_init_1_2() - initializes the v1.2 DSC hw driver object
+ * @dev:  Corresponding device for devres management
  * @cfg:  DSC catalog entry for which driver object is required
  * @addr: Mapped register io address of MDP
  * Returns: Error code or allocated dpu_hw_dsc context
  */
-struct dpu_hw_dsc *dpu_hw_dsc_init_1_2(const struct dpu_dsc_cfg *cfg,
+struct dpu_hw_dsc *dpu_hw_dsc_init_1_2(struct drm_device *dev,
+				       const struct dpu_dsc_cfg *cfg,
 				       void __iomem *addr);
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
index 24fe1d98eb86a..ba193b0376fe8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved
  */
 
+#include <drm/drm_managed.h>
+
 #include <drm/display/drm_dsc_helper.h>
 
 #include "dpu_kms.h"
@@ -367,12 +369,13 @@ static void _setup_dcs_ops_1_2(struct dpu_hw_dsc_ops *ops,
 	ops->dsc_bind_pingpong_blk = dpu_hw_dsc_bind_pingpong_blk_1_2;
 }
 
-struct dpu_hw_dsc *dpu_hw_dsc_init_1_2(const struct dpu_dsc_cfg *cfg,
+struct dpu_hw_dsc *dpu_hw_dsc_init_1_2(struct drm_device *dev,
+				       const struct dpu_dsc_cfg *cfg,
 				       void __iomem *addr)
 {
 	struct dpu_hw_dsc *c;
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
index 9419b2209af88..b1da88e2935f4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
  */
 
+#include <drm/drm_managed.h>
+
 #include "dpu_hwio.h"
 #include "dpu_hw_catalog.h"
 #include "dpu_hw_lm.h"
@@ -68,15 +70,16 @@ static void _setup_dspp_ops(struct dpu_hw_dspp *c,
 		c->ops.setup_pcc = dpu_setup_dspp_pcc;
 }
 
-struct dpu_hw_dspp *dpu_hw_dspp_init(const struct dpu_dspp_cfg *cfg,
-			void __iomem *addr)
+struct dpu_hw_dspp *dpu_hw_dspp_init(struct drm_device *dev,
+				     const struct dpu_dspp_cfg *cfg,
+				     void __iomem *addr)
 {
 	struct dpu_hw_dspp *c;
 
 	if (!addr)
 		return ERR_PTR(-EINVAL);
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
@@ -90,10 +93,3 @@ struct dpu_hw_dspp *dpu_hw_dspp_init(const struct dpu_dspp_cfg *cfg,
 
 	return c;
 }
-
-void dpu_hw_dspp_destroy(struct dpu_hw_dspp *dspp)
-{
-	kfree(dspp);
-}
-
-
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h
index bea9656813301..3b435690b6ccb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h
@@ -81,18 +81,14 @@ static inline struct dpu_hw_dspp *to_dpu_hw_dspp(struct dpu_hw_blk *hw)
 /**
  * dpu_hw_dspp_init() - Initializes the DSPP hw driver object.
  * should be called once before accessing every DSPP.
+ * @dev:  Corresponding device for devres management
  * @cfg:  DSPP catalog entry for which driver object is required
  * @addr: Mapped register io address of MDP
  * Return: pointer to structure or ERR_PTR
  */
-struct dpu_hw_dspp *dpu_hw_dspp_init(const struct dpu_dspp_cfg *cfg,
-	void __iomem *addr);
-
-/**
- * dpu_hw_dspp_destroy(): Destroys DSPP driver context
- * @dspp: Pointer to DSPP driver context
- */
-void dpu_hw_dspp_destroy(struct dpu_hw_dspp *dspp);
+struct dpu_hw_dspp *dpu_hw_dspp_init(struct drm_device *dev,
+				     const struct dpu_dspp_cfg *cfg,
+				     void __iomem *addr);
 
 #endif /*_DPU_HW_DSPP_H */
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index b3d6cf97830dc..965692ef7892c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -12,6 +12,8 @@
 
 #include <linux/iopoll.h>
 
+#include <drm/drm_managed.h>
+
 #define INTF_TIMING_ENGINE_EN           0x000
 #define INTF_CONFIG                     0x004
 #define INTF_HSYNC_CTL                  0x008
@@ -530,8 +532,10 @@ static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,
 	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
 }
 
-struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
-		void __iomem *addr, const struct dpu_mdss_version *mdss_rev)
+struct dpu_hw_intf *dpu_hw_intf_init(struct drm_device *dev,
+				     const struct dpu_intf_cfg *cfg,
+				     void __iomem *addr,
+				     const struct dpu_mdss_version *mdss_rev)
 {
 	struct dpu_hw_intf *c;
 
@@ -540,7 +544,7 @@ struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
 		return NULL;
 	}
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
@@ -584,9 +588,3 @@ struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
 
 	return c;
 }
-
-void dpu_hw_intf_destroy(struct dpu_hw_intf *intf)
-{
-	kfree(intf);
-}
-
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index 366fd87e26c74..6f4c87244f944 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -132,17 +132,14 @@ struct dpu_hw_intf {
 /**
  * dpu_hw_intf_init() - Initializes the INTF driver for the passed
  * interface catalog entry.
+ * @dev:  Corresponding device for devres management
  * @cfg:  interface catalog entry for which driver object is required
  * @addr: mapped register io address of MDP
  * @mdss_rev: dpu core's major and minor versions
  */
-struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
-		void __iomem *addr, const struct dpu_mdss_version *mdss_rev);
-
-/**
- * dpu_hw_intf_destroy(): Destroys INTF driver context
- * @intf:   Pointer to INTF driver context
- */
-void dpu_hw_intf_destroy(struct dpu_hw_intf *intf);
+struct dpu_hw_intf *dpu_hw_intf_init(struct drm_device *dev,
+				     const struct dpu_intf_cfg *cfg,
+				     void __iomem *addr,
+				     const struct dpu_mdss_version *mdss_rev);
 
 #endif /*_DPU_HW_INTF_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index a590c1f7465fb..1d3ccf3228c62 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
  */
 
+#include <drm/drm_managed.h>
+
 #include "dpu_kms.h"
 #include "dpu_hw_catalog.h"
 #include "dpu_hwio.h"
@@ -156,8 +158,9 @@ static void _setup_mixer_ops(struct dpu_hw_lm_ops *ops,
 	ops->collect_misr = dpu_hw_lm_collect_misr;
 }
 
-struct dpu_hw_mixer *dpu_hw_lm_init(const struct dpu_lm_cfg *cfg,
-		void __iomem *addr)
+struct dpu_hw_mixer *dpu_hw_lm_init(struct drm_device *dev,
+				    const struct dpu_lm_cfg *cfg,
+				    void __iomem *addr)
 {
 	struct dpu_hw_mixer *c;
 
@@ -166,7 +169,7 @@ struct dpu_hw_mixer *dpu_hw_lm_init(const struct dpu_lm_cfg *cfg,
 		return NULL;
 	}
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
@@ -180,8 +183,3 @@ struct dpu_hw_mixer *dpu_hw_lm_init(const struct dpu_lm_cfg *cfg,
 
 	return c;
 }
-
-void dpu_hw_lm_destroy(struct dpu_hw_mixer *lm)
-{
-	kfree(lm);
-}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
index 98b77cda65472..0a33817552499 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
@@ -96,16 +96,12 @@ static inline struct dpu_hw_mixer *to_dpu_hw_mixer(struct dpu_hw_blk *hw)
 /**
  * dpu_hw_lm_init() - Initializes the mixer hw driver object.
  * should be called once before accessing every mixer.
+ * @dev:  Corresponding device for devres management
  * @cfg:  mixer catalog entry for which driver object is required
  * @addr: mapped register io address of MDP
  */
-struct dpu_hw_mixer *dpu_hw_lm_init(const struct dpu_lm_cfg *cfg,
-		void __iomem *addr);
-
-/**
- * dpu_hw_lm_destroy(): Destroys layer mixer driver context
- * @lm:   Pointer to LM driver context
- */
-void dpu_hw_lm_destroy(struct dpu_hw_mixer *lm);
+struct dpu_hw_mixer *dpu_hw_lm_init(struct drm_device *dev,
+				    const struct dpu_lm_cfg *cfg,
+				    void __iomem *addr);
 
 #endif /*_DPU_HW_LM_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c
index 90e0e05eff8d3..ddfa40a959cbd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c
@@ -4,6 +4,8 @@
 
 #include <linux/iopoll.h>
 
+#include <drm/drm_managed.h>
+
 #include "dpu_hw_mdss.h"
 #include "dpu_hwio.h"
 #include "dpu_hw_catalog.h"
@@ -37,12 +39,13 @@ static void _setup_merge_3d_ops(struct dpu_hw_merge_3d *c,
 	c->ops.setup_3d_mode = dpu_hw_merge_3d_setup_3d_mode;
 };
 
-struct dpu_hw_merge_3d *dpu_hw_merge_3d_init(const struct dpu_merge_3d_cfg *cfg,
-		void __iomem *addr)
+struct dpu_hw_merge_3d *dpu_hw_merge_3d_init(struct drm_device *dev,
+					     const struct dpu_merge_3d_cfg *cfg,
+					     void __iomem *addr)
 {
 	struct dpu_hw_merge_3d *c;
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
@@ -55,8 +58,3 @@ struct dpu_hw_merge_3d *dpu_hw_merge_3d_init(const struct dpu_merge_3d_cfg *cfg,
 
 	return c;
 }
-
-void dpu_hw_merge_3d_destroy(struct dpu_hw_merge_3d *hw)
-{
-	kfree(hw);
-}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h
index 19cec5e887221..c192f02ec1abc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h
@@ -48,18 +48,13 @@ static inline struct dpu_hw_merge_3d *to_dpu_hw_merge_3d(struct dpu_hw_blk *hw)
 /**
  * dpu_hw_merge_3d_init() - Initializes the merge_3d driver for the passed
  * merge3d catalog entry.
+ * @dev:  Corresponding device for devres management
  * @cfg:  Pingpong catalog entry for which driver object is required
  * @addr: Mapped register io address of MDP
  * Return: Error code or allocated dpu_hw_merge_3d context
  */
-struct dpu_hw_merge_3d *dpu_hw_merge_3d_init(const struct dpu_merge_3d_cfg *cfg,
-		void __iomem *addr);
-
-/**
- * dpu_hw_merge_3d_destroy - destroys merge_3d driver context
- *	should be called to free the context
- * @pp:   Pointer to PP driver context returned by dpu_hw_merge_3d_init
- */
-void dpu_hw_merge_3d_destroy(struct dpu_hw_merge_3d *pp);
+struct dpu_hw_merge_3d *dpu_hw_merge_3d_init(struct drm_device *dev,
+					     const struct dpu_merge_3d_cfg *cfg,
+					     void __iomem *addr);
 
 #endif /*_DPU_HW_MERGE3D_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
index 057cac7f5d936..2db4c6fba37ac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
@@ -4,6 +4,8 @@
 
 #include <linux/iopoll.h>
 
+#include <drm/drm_managed.h>
+
 #include "dpu_hw_mdss.h"
 #include "dpu_hwio.h"
 #include "dpu_hw_catalog.h"
@@ -281,12 +283,14 @@ static int dpu_hw_pp_setup_dsc(struct dpu_hw_pingpong *pp)
 	return 0;
 }
 
-struct dpu_hw_pingpong *dpu_hw_pingpong_init(const struct dpu_pingpong_cfg *cfg,
-		void __iomem *addr, const struct dpu_mdss_version *mdss_rev)
+struct dpu_hw_pingpong *dpu_hw_pingpong_init(struct drm_device *dev,
+					     const struct dpu_pingpong_cfg *cfg,
+					     void __iomem *addr,
+					     const struct dpu_mdss_version *mdss_rev)
 {
 	struct dpu_hw_pingpong *c;
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
@@ -317,8 +321,3 @@ struct dpu_hw_pingpong *dpu_hw_pingpong_init(const struct dpu_pingpong_cfg *cfg,
 
 	return c;
 }
-
-void dpu_hw_pingpong_destroy(struct dpu_hw_pingpong *pp)
-{
-	kfree(pp);
-}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
index 0d541ca5b0566..a48b69fd79a3b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
@@ -121,19 +121,15 @@ static inline struct dpu_hw_pingpong *to_dpu_hw_pingpong(struct dpu_hw_blk *hw)
 /**
  * dpu_hw_pingpong_init() - initializes the pingpong driver for the passed
  * pingpong catalog entry.
+ * @dev:  Corresponding device for devres management
  * @cfg:  Pingpong catalog entry for which driver object is required
  * @addr: Mapped register io address of MDP
  * @mdss_rev: dpu core's major and minor versions
  * Return: Error code or allocated dpu_hw_pingpong context
  */
-struct dpu_hw_pingpong *dpu_hw_pingpong_init(const struct dpu_pingpong_cfg *cfg,
-		void __iomem *addr, const struct dpu_mdss_version *mdss_rev);
-
-/**
- * dpu_hw_pingpong_destroy - destroys pingpong driver context
- *	should be called to free the context
- * @pp:   Pointer to PP driver context returned by dpu_hw_pingpong_init
- */
-void dpu_hw_pingpong_destroy(struct dpu_hw_pingpong *pp);
+struct dpu_hw_pingpong *dpu_hw_pingpong_init(struct drm_device *dev,
+					     const struct dpu_pingpong_cfg *cfg,
+					     void __iomem *addr,
+					     const struct dpu_mdss_version *mdss_rev);
 
 #endif /*_DPU_HW_PINGPONG_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index 8e3c65989c498..069bf429e5203 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -11,6 +11,7 @@
 #include "msm_mdss.h"
 
 #include <drm/drm_file.h>
+#include <drm/drm_managed.h>
 
 #define DPU_FETCH_CONFIG_RESET_VALUE   0x00000087
 
@@ -685,16 +686,18 @@ int _dpu_hw_sspp_init_debugfs(struct dpu_hw_sspp *hw_pipe, struct dpu_kms *kms,
 }
 #endif
 
-struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
-		void __iomem *addr, const struct msm_mdss_data *mdss_data,
-		const struct dpu_mdss_version *mdss_rev)
+struct dpu_hw_sspp *dpu_hw_sspp_init(struct drm_device *dev,
+				     const struct dpu_sspp_cfg *cfg,
+				     void __iomem *addr,
+				     const struct msm_mdss_data *mdss_data,
+				     const struct dpu_mdss_version *mdss_rev)
 {
 	struct dpu_hw_sspp *hw_pipe;
 
 	if (!addr)
 		return ERR_PTR(-EINVAL);
 
-	hw_pipe = kzalloc(sizeof(*hw_pipe), GFP_KERNEL);
+	hw_pipe = drmm_kzalloc(dev, sizeof(*hw_pipe), GFP_KERNEL);
 	if (!hw_pipe)
 		return ERR_PTR(-ENOMEM);
 
@@ -709,9 +712,3 @@ struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
 
 	return hw_pipe;
 }
-
-void dpu_hw_sspp_destroy(struct dpu_hw_sspp *ctx)
-{
-	kfree(ctx);
-}
-
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index f93969fddb225..3641ef6bef530 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -339,21 +339,17 @@ struct dpu_kms;
 /**
  * dpu_hw_sspp_init() - Initializes the sspp hw driver object.
  * Should be called once before accessing every pipe.
+ * @dev:  Corresponding device for devres management
  * @cfg:  Pipe catalog entry for which driver object is required
  * @addr: Mapped register io address of MDP
  * @mdss_data: UBWC / MDSS configuration data
  * @mdss_rev: dpu core's major and minor versions
  */
-struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
-		void __iomem *addr, const struct msm_mdss_data *mdss_data,
-		const struct dpu_mdss_version *mdss_rev);
-
-/**
- * dpu_hw_sspp_destroy(): Destroys SSPP driver context
- * should be called during Hw pipe cleanup.
- * @ctx:  Pointer to SSPP driver context returned by dpu_hw_sspp_init
- */
-void dpu_hw_sspp_destroy(struct dpu_hw_sspp *ctx);
+struct dpu_hw_sspp *dpu_hw_sspp_init(struct drm_device *dev,
+				     const struct dpu_sspp_cfg *cfg,
+				     void __iomem *addr,
+				     const struct msm_mdss_data *mdss_data,
+				     const struct dpu_mdss_version *mdss_rev);
 
 int _dpu_hw_sspp_init_debugfs(struct dpu_hw_sspp *hw_pipe, struct dpu_kms *kms,
 			      struct dentry *entry);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
index d49b3ef7689eb..e75995f7fcea9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -3,6 +3,8 @@
   * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved
   */
 
+#include <drm/drm_managed.h>
+
 #include "dpu_hw_mdss.h"
 #include "dpu_hwio.h"
 #include "dpu_hw_catalog.h"
@@ -211,15 +213,17 @@ static void _setup_wb_ops(struct dpu_hw_wb_ops *ops,
 		ops->setup_clk_force_ctrl = dpu_hw_wb_setup_clk_force_ctrl;
 }
 
-struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
-		void __iomem *addr, const struct dpu_mdss_version *mdss_rev)
+struct dpu_hw_wb *dpu_hw_wb_init(struct drm_device *dev,
+				 const struct dpu_wb_cfg *cfg,
+				 void __iomem *addr,
+				 const struct dpu_mdss_version *mdss_rev)
 {
 	struct dpu_hw_wb *c;
 
 	if (!addr)
 		return ERR_PTR(-EINVAL);
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
 
@@ -233,8 +237,3 @@ struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
 
 	return c;
 }
-
-void dpu_hw_wb_destroy(struct dpu_hw_wb *hw_wb)
-{
-	kfree(hw_wb);
-}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
index 88792f450a927..e671796ea379c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
@@ -76,18 +76,15 @@ struct dpu_hw_wb {
 
 /**
  * dpu_hw_wb_init() - Initializes the writeback hw driver object.
+ * @dev:  Corresponding device for devres management
  * @cfg:  wb_path catalog entry for which driver object is required
  * @addr: mapped register io address of MDP
  * @mdss_rev: dpu core's major and minor versions
  * Return: Error code or allocated dpu_hw_wb context
  */
-struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
-		void __iomem *addr, const struct dpu_mdss_version *mdss_rev);
-
-/**
- * dpu_hw_wb_destroy(): Destroy writeback hw driver object.
- * @hw_wb:  Pointer to writeback hw driver object
- */
-void dpu_hw_wb_destroy(struct dpu_hw_wb *hw_wb);
+struct dpu_hw_wb *dpu_hw_wb_init(struct drm_device *dev,
+				 const struct dpu_wb_cfg *cfg,
+				 void __iomem *addr,
+				 const struct dpu_mdss_version *mdss_rev);
 
 #endif /*_DPU_HW_WB_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index a7ae4479e12e9..797099e5e53d9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -822,10 +822,6 @@ static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 		}
 	}
 
-	if (dpu_kms->rm_init)
-		dpu_rm_destroy(&dpu_kms->rm);
-	dpu_kms->rm_init = false;
-
 	dpu_kms->catalog = NULL;
 
 	dpu_kms->hw_mdp = NULL;
@@ -1102,14 +1098,12 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
 		goto power_error;
 	}
 
-	rc = dpu_rm_init(&dpu_kms->rm, dpu_kms->catalog, dpu_kms->mdss, dpu_kms->mmio);
+	rc = dpu_rm_init(dev, &dpu_kms->rm, dpu_kms->catalog, dpu_kms->mdss, dpu_kms->mmio);
 	if (rc) {
 		DPU_ERROR("rm init failed: %d\n", rc);
 		goto power_error;
 	}
 
-	dpu_kms->rm_init = true;
-
 	dpu_kms->hw_mdp = dpu_hw_mdptop_init(dev,
 					     dpu_kms->catalog->mdp,
 					     dpu_kms->mmio,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index f5473d4dea92f..9112a702a00f2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -89,7 +89,6 @@ struct dpu_kms {
 	struct drm_private_obj global_state;
 
 	struct dpu_rm rm;
-	bool rm_init;
 
 	struct dpu_hw_vbif *hw_vbif[VBIF_MAX];
 	struct dpu_hw_mdp *hw_mdp;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 8759466e2f379..0bb28cf4a6cbc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -34,72 +34,8 @@ struct dpu_rm_requirements {
 	struct msm_display_topology topology;
 };
 
-int dpu_rm_destroy(struct dpu_rm *rm)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(rm->dspp_blks); i++) {
-		struct dpu_hw_dspp *hw;
-
-		if (rm->dspp_blks[i]) {
-			hw = to_dpu_hw_dspp(rm->dspp_blks[i]);
-			dpu_hw_dspp_destroy(hw);
-		}
-	}
-	for (i = 0; i < ARRAY_SIZE(rm->pingpong_blks); i++) {
-		struct dpu_hw_pingpong *hw;
-
-		if (rm->pingpong_blks[i]) {
-			hw = to_dpu_hw_pingpong(rm->pingpong_blks[i]);
-			dpu_hw_pingpong_destroy(hw);
-		}
-	}
-	for (i = 0; i < ARRAY_SIZE(rm->merge_3d_blks); i++) {
-		struct dpu_hw_merge_3d *hw;
-
-		if (rm->merge_3d_blks[i]) {
-			hw = to_dpu_hw_merge_3d(rm->merge_3d_blks[i]);
-			dpu_hw_merge_3d_destroy(hw);
-		}
-	}
-	for (i = 0; i < ARRAY_SIZE(rm->mixer_blks); i++) {
-		struct dpu_hw_mixer *hw;
-
-		if (rm->mixer_blks[i]) {
-			hw = to_dpu_hw_mixer(rm->mixer_blks[i]);
-			dpu_hw_lm_destroy(hw);
-		}
-	}
-	for (i = 0; i < ARRAY_SIZE(rm->ctl_blks); i++) {
-		struct dpu_hw_ctl *hw;
-
-		if (rm->ctl_blks[i]) {
-			hw = to_dpu_hw_ctl(rm->ctl_blks[i]);
-			dpu_hw_ctl_destroy(hw);
-		}
-	}
-	for (i = 0; i < ARRAY_SIZE(rm->hw_intf); i++)
-		dpu_hw_intf_destroy(rm->hw_intf[i]);
-
-	for (i = 0; i < ARRAY_SIZE(rm->dsc_blks); i++) {
-		struct dpu_hw_dsc *hw;
-
-		if (rm->dsc_blks[i]) {
-			hw = to_dpu_hw_dsc(rm->dsc_blks[i]);
-			dpu_hw_dsc_destroy(hw);
-		}
-	}
-
-	for (i = 0; i < ARRAY_SIZE(rm->hw_wb); i++)
-		dpu_hw_wb_destroy(rm->hw_wb[i]);
-
-	for (i = 0; i < ARRAY_SIZE(rm->hw_sspp); i++)
-		dpu_hw_sspp_destroy(rm->hw_sspp[i]);
-
-	return 0;
-}
-
-int dpu_rm_init(struct dpu_rm *rm,
+int dpu_rm_init(struct drm_device *dev,
+		struct dpu_rm *rm,
 		const struct dpu_mdss_cfg *cat,
 		const struct msm_mdss_data *mdss_data,
 		void __iomem *mmio)
@@ -119,7 +55,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_mixer *hw;
 		const struct dpu_lm_cfg *lm = &cat->mixer[i];
 
-		hw = dpu_hw_lm_init(lm, mmio);
+		hw = dpu_hw_lm_init(dev, lm, mmio);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed lm object creation: err %d\n", rc);
@@ -132,7 +68,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_merge_3d *hw;
 		const struct dpu_merge_3d_cfg *merge_3d = &cat->merge_3d[i];
 
-		hw = dpu_hw_merge_3d_init(merge_3d, mmio);
+		hw = dpu_hw_merge_3d_init(dev, merge_3d, mmio);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed merge_3d object creation: err %d\n",
@@ -146,7 +82,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_pingpong *hw;
 		const struct dpu_pingpong_cfg *pp = &cat->pingpong[i];
 
-		hw = dpu_hw_pingpong_init(pp, mmio, cat->mdss_ver);
+		hw = dpu_hw_pingpong_init(dev, pp, mmio, cat->mdss_ver);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed pingpong object creation: err %d\n",
@@ -162,7 +98,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_intf *hw;
 		const struct dpu_intf_cfg *intf = &cat->intf[i];
 
-		hw = dpu_hw_intf_init(intf, mmio, cat->mdss_ver);
+		hw = dpu_hw_intf_init(dev, intf, mmio, cat->mdss_ver);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed intf object creation: err %d\n", rc);
@@ -175,7 +111,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_wb *hw;
 		const struct dpu_wb_cfg *wb = &cat->wb[i];
 
-		hw = dpu_hw_wb_init(wb, mmio, cat->mdss_ver);
+		hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed wb object creation: err %d\n", rc);
@@ -188,7 +124,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_ctl *hw;
 		const struct dpu_ctl_cfg *ctl = &cat->ctl[i];
 
-		hw = dpu_hw_ctl_init(ctl, mmio, cat->mixer_count, cat->mixer);
+		hw = dpu_hw_ctl_init(dev, ctl, mmio, cat->mixer_count, cat->mixer);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed ctl object creation: err %d\n", rc);
@@ -201,7 +137,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_dspp *hw;
 		const struct dpu_dspp_cfg *dspp = &cat->dspp[i];
 
-		hw = dpu_hw_dspp_init(dspp, mmio);
+		hw = dpu_hw_dspp_init(dev, dspp, mmio);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed dspp object creation: err %d\n", rc);
@@ -215,9 +151,9 @@ int dpu_rm_init(struct dpu_rm *rm,
 		const struct dpu_dsc_cfg *dsc = &cat->dsc[i];
 
 		if (test_bit(DPU_DSC_HW_REV_1_2, &dsc->features))
-			hw = dpu_hw_dsc_init_1_2(dsc, mmio);
+			hw = dpu_hw_dsc_init_1_2(dev, dsc, mmio);
 		else
-			hw = dpu_hw_dsc_init(dsc, mmio);
+			hw = dpu_hw_dsc_init(dev, dsc, mmio);
 
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
@@ -231,7 +167,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_sspp *hw;
 		const struct dpu_sspp_cfg *sspp = &cat->sspp[i];
 
-		hw = dpu_hw_sspp_init(sspp, mmio, mdss_data, cat->mdss_ver);
+		hw = dpu_hw_sspp_init(dev, sspp, mmio, mdss_data, cat->mdss_ver);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed sspp object creation: err %d\n", rc);
@@ -243,8 +179,6 @@ int dpu_rm_init(struct dpu_rm *rm,
 	return 0;
 
 fail:
-	dpu_rm_destroy(rm);
-
 	return rc ? rc : -EFAULT;
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
index 2b551566cbf48..36752d837be4c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
@@ -38,24 +38,19 @@ struct dpu_rm {
 /**
  * dpu_rm_init - Read hardware catalog and create reservation tracking objects
  *	for all HW blocks.
+ * @dev:  Corresponding device for devres management
  * @rm: DPU Resource Manager handle
  * @cat: Pointer to hardware catalog
  * @mdss_data: Pointer to MDSS / UBWC configuration
  * @mmio: mapped register io address of MDP
  * @Return: 0 on Success otherwise -ERROR
  */
-int dpu_rm_init(struct dpu_rm *rm,
+int dpu_rm_init(struct drm_device *dev,
+		struct dpu_rm *rm,
 		const struct dpu_mdss_cfg *cat,
 		const struct msm_mdss_data *mdss_data,
 		void __iomem *mmio);
 
-/**
- * dpu_rm_destroy - Free all memory allocated by dpu_rm_init
- * @rm: DPU Resource Manager handle
- * @Return: 0 on Success otherwise -ERROR
- */
-int dpu_rm_destroy(struct dpu_rm *rm);
-
 /**
  * dpu_rm_reserve - Given a CRTC->Encoder->Connector display chain, analyze
  *	the use connections and user requirements, specified through related
-- 
2.43.0


