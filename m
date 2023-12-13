Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21EE809DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573343AbjLHH40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjLHH4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:56:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E4171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:56:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA90BC433C9;
        Fri,  8 Dec 2023 07:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022185;
        bh=e0ogDcUJq+MYk2Otu24z/MUvBuwbnVct7mZFYY8jnNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTdir0pNsjSdfMJFOh/vHLxY10dJPm3OcjVnk2wLPdvdepQmScxctp83z70+lTEnc
         NwZqNbwFVeQ/Ghrs3gG9ElAU/noixrEVGd8tMTvArN+iuDoAf+FKEnr+FdsbCYzXxF
         5Ewa05owxPDgZ1buW94MY1ouym/6inBnlCFI82To=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.332
Date:   Fri,  8 Dec 2023 08:56:16 +0100
Message-ID: <2023120815-resurrect-palpable-bc9e@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023120815-agony-resize-1fd9@gregkh>
References: <2023120815-agony-resize-1fd9@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index bfc684652972..212a18108a9b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 331
+SUBLEVEL = 332
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 32aa108b2b7c..7a18bdf32ecc 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -376,7 +376,8 @@ static int __init xen_guest_init(void)
 	 * for secondary CPUs as they are brought up.
 	 * For uniformity we use VCPUOP_register_vcpu_info even on cpu0.
 	 */
-	xen_vcpu_info = alloc_percpu(struct vcpu_info);
+	xen_vcpu_info = __alloc_percpu(sizeof(struct vcpu_info),
+				       1 << fls(sizeof(struct vcpu_info) - 1));
 	if (xen_vcpu_info == NULL)
 		return -ENOMEM;
 
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 6c509f39bbde..6363b35ed39e 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -27,6 +27,15 @@
 #include <asm/export.h>
 
 #ifdef CONFIG_VSX
+#define __REST_1FPVSR(n,c,base)						\
+BEGIN_FTR_SECTION							\
+	b	2f;							\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+	REST_FPR(n,base);						\
+	b	3f;							\
+2:	REST_VSR(n,c,base);						\
+3:
+
 #define __REST_32FPVSRS(n,c,base)					\
 BEGIN_FTR_SECTION							\
 	b	2f;							\
@@ -45,9 +54,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 2:	SAVE_32VSRS(n,c,base);						\
 3:
 #else
+#define __REST_1FPVSR(n,b,base)		REST_FPR(n, base)
 #define __REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
 #define __SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
 #endif
+#define REST_1FPVSR(n,c,base)   __REST_1FPVSR(n,__REG_##c,__REG_##base)
 #define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
@@ -70,6 +81,7 @@ _GLOBAL(store_fp_state)
 	SAVE_32FPVSRS(0, R4, R3)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r3)
+	REST_1FPVSR(0, R4, R3)
 	blr
 EXPORT_SYMBOL(store_fp_state)
 
@@ -134,6 +146,7 @@ _GLOBAL(save_fpu)
 2:	SAVE_32FPVSRS(0, R4, R6)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
+	REST_1FPVSR(0, R4, R6)
 	blr
 
 /*
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index f314fd475491..80729cfb3306 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -30,6 +30,7 @@ _GLOBAL(store_vr_state)
 	mfvscr	v0
 	li	r4, VRSTATE_VSCR
 	stvx	v0, r4, r3
+	lvx	v0, 0, r3
 	blr
 EXPORT_SYMBOL(store_vr_state)
 
@@ -100,6 +101,7 @@ _GLOBAL(save_altivec)
 	mfvscr	v0
 	li	r4,VRSTATE_VSCR
 	stvx	v0,r4,r7
+	lvx	v0,0,r7
 	blr
 
 #ifdef CONFIG_VSX
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 994f168b54a8..4ffbc2a63f8f 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -81,6 +81,9 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 	if (pnp_port_valid(idev, 1)) {
 		ctl_addr = devm_ioport_map(&idev->dev,
 					   pnp_port_start(idev, 1), 1);
+		if (!ctl_addr)
+			return -ENOMEM;
+
 		ap->ioaddr.altstatus_addr = ctl_addr;
 		ap->ioaddr.ctl_addr = ctl_addr;
 		ap->ops = &isapnp_port_ops;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0f006cad2be7..a12552ae4c74 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -869,8 +869,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		else if (drv->remove)
 			drv->remove(dev);
 
-		device_links_driver_cleanup(dev);
-
 		devres_release_all(dev);
 		dma_deconfigure(dev);
 		dev->driver = NULL;
@@ -879,6 +877,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			dev->pm_domain->dismiss(dev);
 		pm_runtime_reinit(dev);
 
+		device_links_driver_cleanup(dev);
+
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
 		if (dev->bus)
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 7c2eed76011e..a293b39fd4ce 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -732,14 +732,11 @@ static void create_units(struct fw_device *device)
 					fw_unit_attributes,
 					&unit->attribute_group);
 
-		if (device_register(&unit->device) < 0)
-			goto skip_unit;
-
 		fw_device_get(device);
-		continue;
-
-	skip_unit:
-		kfree(unit);
+		if (device_register(&unit->device) < 0) {
+			put_device(&unit->device);
+			continue;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8bee025c0622..0b50213c0d25 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1062,13 +1062,13 @@ static const struct panel_desc innolux_at070tn92 = {
 static const struct display_timing innolux_g101ice_l01_timing = {
 	.pixelclock = { 60400000, 71100000, 74700000 },
 	.hactive = { 1280, 1280, 1280 },
-	.hfront_porch = { 41, 80, 100 },
-	.hback_porch = { 40, 79, 99 },
-	.hsync_len = { 1, 1, 1 },
+	.hfront_porch = { 30, 60, 70 },
+	.hback_porch = { 30, 60, 70 },
+	.hsync_len = { 22, 40, 60 },
 	.vactive = { 800, 800, 800 },
-	.vfront_porch = { 5, 11, 14 },
-	.vback_porch = { 4, 11, 14 },
-	.vsync_len = { 1, 1, 1 },
+	.vfront_porch = { 3, 8, 14 },
+	.vback_porch = { 3, 8, 14 },
+	.vsync_len = { 4, 7, 12 },
 	.flags = DISPLAY_FLAGS_DE_HIGH,
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 3f32be1a682e..9302233b5503 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -202,14 +202,22 @@ static inline void vop_cfg_done(struct vop *vop)
 	VOP_REG_SET(vop, common, cfg_done, 1);
 }
 
-static bool has_rb_swapped(uint32_t format)
+static bool has_rb_swapped(uint32_t version, uint32_t format)
 {
 	switch (format) {
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
-	case DRM_FORMAT_BGR888:
 	case DRM_FORMAT_BGR565:
 		return true;
+	/*
+	 * full framework (IP version 3.x) only need rb swapped for RGB888 and
+	 * little framework (IP version 2.x) only need rb swapped for BGR888,
+	 * check for 3.x to also only rb swap BGR888 for unknown vop version
+	 */
+	case DRM_FORMAT_RGB888:
+		return VOP_MAJOR(version) == 3;
+	case DRM_FORMAT_BGR888:
+		return VOP_MAJOR(version) != 3;
 	default:
 		return false;
 	}
@@ -786,7 +794,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
 	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
 
-	rb_swap = has_rb_swapped(fb->format->format);
+	rb_swap = has_rb_swapped(vop->data->version, fb->format->format);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
 	if (is_alpha_support(fb->format->format)) {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index 472ef4d6e858..2b87550b960d 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -2853,6 +2853,9 @@ static enum i40iw_status_code i40iw_sc_alloc_stag(
 	u64 header;
 	enum i40iw_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	page_size = (info->page_size == 0x200000) ? I40IW_PAGE_SIZE_2M : I40IW_PAGE_SIZE_4K;
 	cqp = dev->cqp;
 	wqe = i40iw_sc_cqp_get_next_send_wqe(cqp, scratch);
@@ -2911,6 +2914,9 @@ static enum i40iw_status_code i40iw_sc_mr_reg_non_shared(
 	u8 addr_type;
 	enum i40iw_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	page_size = (info->page_size == 0x200000) ? I40IW_PAGE_SIZE_2M : I40IW_PAGE_SIZE_4K;
 	if (info->access_rights & (I40IW_ACCESS_FLAGS_REMOTEREAD_ONLY |
 				   I40IW_ACCESS_FLAGS_REMOTEWRITE_ONLY))
diff --git a/drivers/infiniband/hw/i40iw/i40iw_type.h b/drivers/infiniband/hw/i40iw/i40iw_type.h
index 63118f6d5ab4..2084c7f5fcc4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_type.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_type.h
@@ -780,6 +780,7 @@ struct i40iw_allocate_stag_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fcn_index;
 	bool use_pf_rid;
+	bool all_memory;
 };
 
 struct i40iw_reg_ns_stag_info {
@@ -798,6 +799,7 @@ struct i40iw_reg_ns_stag_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fcn_index;
 	bool use_pf_rid;
+	bool all_memory;
 };
 
 struct i40iw_fast_reg_stag_info {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index cc943b4b7474..a6a44cdb94a9 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1579,7 +1579,8 @@ static int i40iw_handle_q_mem(struct i40iw_device *iwdev,
 static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr)
 {
 	struct i40iw_allocate_stag_info *info;
-	struct i40iw_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct i40iw_pd *iwpd = to_iwpd(pd);
 	enum i40iw_status_code status;
 	int err = 0;
 	struct i40iw_cqp_request *cqp_request;
@@ -1596,6 +1597,7 @@ static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr
 	info->stag_idx = iwmr->stag >> I40IW_CQPSQ_STAG_IDX_SHIFT;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->length;
+	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -1649,6 +1651,8 @@ static struct ib_mr *i40iw_alloc_mr(struct ib_pd *pd,
 	iwmr->type = IW_MEMREG_TYPE_MEM;
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
+	/* Use system PAGE_SIZE as the sg page sizes are unknown at this point */
+	iwmr->length = max_num_sg * PAGE_SIZE;
 	mutex_lock(&iwdev->pbl_mutex);
 	status = i40iw_get_pble(&iwdev->sc_dev, iwdev->pble_rsrc, palloc, iwmr->page_cnt);
 	mutex_unlock(&iwdev->pbl_mutex);
@@ -1745,7 +1749,8 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
 {
 	struct i40iw_pbl *iwpbl = &iwmr->iwpbl;
 	struct i40iw_reg_ns_stag_info *stag_info;
-	struct i40iw_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct i40iw_pd *iwpd = to_iwpd(pd);
 	struct i40iw_pble_alloc *palloc = &iwpbl->pble_alloc;
 	enum i40iw_status_code status;
 	int err = 0;
@@ -1765,6 +1770,7 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
 	stag_info->total_len = iwmr->length;
 	stag_info->access_rights = access;
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
+	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	stag_info->addr_type = I40IW_ADDR_TYPE_VA_BASED;
 	stag_info->page_size = iwmr->page_size;
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index fba0fff8040d..37ac4e846205 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1483,6 +1483,8 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 		return 0;
 
 	n = btree_node_alloc_replacement(replace, NULL);
+	if (IS_ERR(n))
+		return 0;
 
 	/* recheck reserve after allocating replacement node */
 	if (btree_check_reserve(b, NULL)) {
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index def9c3478b89..23279c34a1c9 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -831,7 +831,7 @@ SHOW(__bch_cache)
 			sum += INITIAL_PRIO - cached[i];
 
 		if (n)
-			do_div(sum, n);
+			sum = div64_u64(sum, n);
 
 		for (i = 0; i < ARRAY_SIZE(q); i++)
 			q[i] = INITIAL_PRIO - cached[n * (i + 1) /
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 0fe6cc3007f5..a819578408df 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -28,7 +28,8 @@ bool verity_fec_is_enabled(struct dm_verity *v)
  */
 static inline struct dm_verity_fec_io *fec_io(struct dm_verity_io *io)
 {
-	return (struct dm_verity_fec_io *) verity_io_digest_end(io->v, io);
+	return (struct dm_verity_fec_io *)
+		((char *)io + io->v->ti->per_io_data_size - sizeof(struct dm_verity_fec_io));
 }
 
 /*
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 77fca0432d25..99861e034f7a 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -588,7 +588,9 @@ static void verity_end_io(struct bio *bio)
 	struct dm_verity_io *io = bio->bi_private;
 
 	if (bio->bi_status &&
-	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
+	    (!verity_fec_is_enabled(io->v) ||
+	     verity_is_system_shutting_down() ||
+	     (bio->bi_opf & REQ_RAHEAD))) {
 		verity_finish_io(io, bio->bi_status);
 		return;
 	}
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index a59e0ada6fd3..5509d69fd29f 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -113,12 +113,6 @@ static inline u8 *verity_io_want_digest(struct dm_verity *v,
 	return (u8 *)(io + 1) + v->ahash_reqsize + v->digest_size;
 }
 
-static inline u8 *verity_io_digest_end(struct dm_verity *v,
-				       struct dm_verity_io *io)
-{
-	return verity_io_want_digest(v, io) + v->digest_size;
-}
-
 extern int verity_for_bv_block(struct dm_verity *v, struct dm_verity_io *io,
 			       struct bvec_iter *iter,
 			       int (*process)(struct dm_verity *v,
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index fa66663df6e8..267bbba09afb 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1753,6 +1753,7 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	int bitflips = 0;
 	int page = addr >> chip->page_shift;
 	int ret;
+	void *ecc_chunk;
 
 	if (!buf) {
 		buf = chip->buffers->databuf;
@@ -1769,7 +1770,9 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 		return ret;
 
 	for (i = 0; i < chip->ecc.steps; i++, oob += sas) {
-		ret = nand_check_erased_ecc_chunk(buf, chip->ecc.size,
+		ecc_chunk = buf + chip->ecc.size * i;
+		ret = nand_check_erased_ecc_chunk(ecc_chunk,
+						  chip->ecc.size,
 						  oob, sas, NULL, 0,
 						  chip->ecc.strength);
 		if (ret < 0)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index ff397bb25042..0e67621031e0 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -314,10 +314,15 @@ static int xgbe_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.phy_address = pdata->phy.address;
 
-	cmd->base.autoneg = pdata->phy.autoneg;
-	cmd->base.speed = pdata->phy.speed;
-	cmd->base.duplex = pdata->phy.duplex;
+	if (netif_carrier_ok(netdev)) {
+		cmd->base.speed = pdata->phy.speed;
+		cmd->base.duplex = pdata->phy.duplex;
+	} else {
+		cmd->base.speed = SPEED_UNKNOWN;
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+	}
 
+	cmd->base.autoneg = pdata->phy.autoneg;
 	cmd->base.port = PORT_NONE;
 
 	XGBE_LM_COPY(cmd, supported, lks, supported);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index bbb93c2637f3..ef78ad84b0f4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1192,7 +1192,19 @@ static int xgbe_phy_config_fixed(struct xgbe_prv_data *pdata)
 	if (pdata->phy.duplex != DUPLEX_FULL)
 		return -EINVAL;
 
-	xgbe_set_mode(pdata, mode);
+	/* Force the mode change for SFI in Fixed PHY config.
+	 * Fixed PHY configs needs PLL to be enabled while doing mode set.
+	 * When the SFP module isn't connected during boot, driver assumes
+	 * AN is ON and attempts autonegotiation. However, if the connected
+	 * SFP comes up in Fixed PHY config, the link will not come up as
+	 * PLL isn't enabled while the initial mode set command is issued.
+	 * So, force the mode change for SFI in Fixed PHY configuration to
+	 * fix link issues.
+	 */
+	if (mode == XGBE_MODE_SFI)
+		xgbe_change_mode(pdata, mode);
+	else
+		xgbe_set_mode(pdata, mode);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4acea1ab6000..b97d450214df 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1429,13 +1429,13 @@ static int ravb_open(struct net_device *ndev)
 	if (priv->chip_id == RCAR_GEN2)
 		ravb_ptp_init(ndev, priv->pdev);
 
-	netif_tx_start_all_queues(ndev);
-
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
 	if (error)
 		goto out_ptp_stop;
 
+	netif_tx_start_all_queues(ndev);
+
 	return 0;
 
 out_ptp_stop:
@@ -1484,6 +1484,12 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	struct net_device *ndev = priv->ndev;
 	int error;
 
+	if (!rtnl_trylock()) {
+		usleep_range(1000, 2000);
+		schedule_work(&priv->work);
+		return;
+	}
+
 	netif_tx_stop_all_queues(ndev);
 
 	/* Stop PTP Clock driver */
@@ -1516,7 +1522,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		 */
 		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
 			   __func__, error);
-		return;
+		goto out_unlock;
 	}
 	ravb_emac_init(ndev);
 
@@ -1526,6 +1532,9 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
+
+out_unlock:
+	rtnl_unlock();
 }
 
 /* Packet transmit function for Ethernet AVB */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 7876e56a5b5d..c88fed98d8c3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -692,7 +692,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
 			/* Tx Full Checksum Offload Enabled */
 			cur_p->app0 |= 2;
-		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
 			csum_start_off = skb_transport_offset(skb);
 			csum_index_off = csum_start_off + skb->csum_offset;
 			/* Tx Partial Checksum Offload Enabled */
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 8a48df80b59a..93df58b49338 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1610,11 +1610,11 @@ static int ax88179_reset(struct usbnet *dev)
 
 	*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
-	msleep(200);
+	msleep(500);
 
 	*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
-	msleep(100);
+	msleep(200);
 
 	/* Ethernet PHY Auto Detach*/
 	ax88179_auto_detach(dev, 0);
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 83f439906d31..7069f5d65199 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1196,17 +1196,17 @@ EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
 static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = p->state;
+	struct pinctrl_state *old_state = READ_ONCE(p->state);
 	int ret;
 
-	if (p->state) {
+	if (old_state) {
 		/*
 		 * For each pinmux setting in the old state, forget SW's record
 		 * of mux owner for that pingroup. Any pingroups which are
 		 * still owned by the new state will be re-acquired by the call
 		 * to pinmux_enable_setting() in the loop below.
 		 */
-		list_for_each_entry(setting, &p->state->settings, node) {
+		list_for_each_entry(setting, &old_state->settings, node) {
 			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
 				continue;
 			pinmux_disable_setting(setting);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d3a11a168616..0e8ea597e017 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -721,18 +721,20 @@ static void dasd_profile_start(struct dasd_block *block,
 	 * we count each request only once.
 	 */
 	device = cqr->startdev;
-	if (device->profile.data) {
-		counter = 1; /* request is not yet queued on the start device */
-		list_for_each(l, &device->ccw_queue)
-			if (++counter >= 31)
-				break;
-	}
+	if (!device->profile.data)
+		return;
+
+	spin_lock(get_ccwdev_lock(device->cdev));
+	counter = 1; /* request is not yet queued on the start device */
+	list_for_each(l, &device->ccw_queue)
+		if (++counter >= 31)
+			break;
+	spin_unlock(get_ccwdev_lock(device->cdev));
+
 	spin_lock(&device->profile.lock);
-	if (device->profile.data) {
-		device->profile.data->dasd_io_nr_req[counter]++;
-		if (rq_data_dir(req) == READ)
-			device->profile.data->dasd_read_nr_req[counter]++;
-	}
+	device->profile.data->dasd_io_nr_req[counter]++;
+	if (rq_data_dir(req) == READ)
+		device->profile.data->dasd_read_nr_req[counter]++;
 	spin_unlock(&device->profile.lock);
 }
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 558e730d25f0..2e0ef23d2122 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1288,6 +1288,8 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_debugfs_init(dwc);
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err5:
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 43a812f4edb6..07bf2297a9c1 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -206,8 +206,8 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
-#define DELL_PRODUCT_FM101R			0x8213
-#define DELL_PRODUCT_FM101R_ESIM		0x8215
+#define DELL_PRODUCT_FM101R_ESIM		0x8213
+#define DELL_PRODUCT_FM101R			0x8215
 
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
@@ -612,6 +612,8 @@ static void option_instat_callback(struct urb *urb);
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+/* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
+#define LUAT_PRODUCT_AIR720U			0x4e00
 
 /* Device flags */
 
@@ -1549,7 +1551,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0165, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0167, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0191, 0xff, 0xff, 0xff), /* ZTE EuFi890 */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0196, 0xff, 0xff, 0xff) },
@@ -2251,6 +2254,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1782, 0x4d11, 0xff) },			/* Fibocom L610 (ECM/RNDIS mode) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0001, 0xff, 0xff, 0xff) },	/* Fibocom L716-EU (ECM/RNDIS mode) */
 	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
@@ -2273,6 +2277,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b08e7fcd8c34..f2cb7fec7547 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6680,7 +6680,7 @@ long btrfs_ioctl_send(struct file *mnt_file, void __user *arg_)
 	sctx->flags = arg->flags;
 
 	sctx->send_filp = fget(arg->send_fd);
-	if (!sctx->send_filp) {
+	if (!sctx->send_filp || !(sctx->send_filp->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 455d8f8b9dfb..e34a52337bda 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2823,7 +2823,7 @@ static struct extent_map *get_chunk_map(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (em->start > logical || em->start + em->len < logical) {
+	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
 			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
 			   logical, length, em->start, em->start + em->len);
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index bdc232f6f27c..42c7b412da2a 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -224,8 +224,10 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 	int tv = prandom_u32() % max_delay;
 
 	im->tm_running = 1;
-	if (!mod_timer(&im->timer, jiffies+tv+2))
-		refcount_inc(&im->refcnt);
+	if (refcount_inc_not_zero(&im->refcnt)) {
+		if (mod_timer(&im->timer, jiffies + tv + 2))
+			ip_ma_put(im);
+	}
 }
 
 static void igmp_gq_start_timer(struct in_device *in_dev)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4a6f4ef369d0..239b54c03a65 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -806,7 +806,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 			goto reject_redirect;
 	}
 
-	n = __ipv4_neigh_lookup(rt->dst.dev, new_gw);
+	n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw);
 	if (!n)
 		n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
 	if (!IS_ERR(n)) {
