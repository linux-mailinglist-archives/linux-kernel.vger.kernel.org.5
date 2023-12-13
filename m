Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884C4809DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573458AbjLHH6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjLHH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:57:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC119AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:56:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493CDC433C9;
        Fri,  8 Dec 2023 07:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022215;
        bh=wwgWUbJPWqlb+bZeQqTM8loYnLVE59V8olZbVwXR8no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=av3AiQ/jWL7GIVewZq5aZ8FocejkU6OnB5DbJRNv7d8IkA58gQkQCrBZsuvsDkjqV
         rVn+gLOEkAwHQW7KDu7ltdcsh4nzuTjVn1DM31GmOVGE0QFlq88JUVVs0uAk3RWI/0
         JH/oF4vXL9/QDTQRn/chmd6Bo0x0MVi8umxdMt8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.142
Date:   Fri,  8 Dec 2023 08:56:49 +0100
Message-ID: <2023120849-during-shaking-eeb3@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023120848-coping-hydrogen-d258@gregkh>
References: <2023120848-coping-hydrogen-d258@gregkh>
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
index 63c79319d769..678e712591f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 141
+SUBLEVEL = 142
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 87245c584784..8d94739d75c6 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -75,7 +75,6 @@
 
 /* We now return you to your regularly scheduled HPUX. */
 
-#define ENOSYM		215	/* symbol does not exist in executable */
 #define	ENOTSOCK	216	/* Socket operation on non-socket */
 #define	EDESTADDRREQ	217	/* Destination address required */
 #define	EMSGSIZE	218	/* Message too long */
@@ -101,7 +100,6 @@
 #define	ETIMEDOUT	238	/* Connection timed out */
 #define	ECONNREFUSED	239	/* Connection refused */
 #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
-#define	EREMOTERELEASE	240	/* Remote peer released connection */
 #define	EHOSTDOWN	241	/* Host is down */
 #define	EHOSTUNREACH	242	/* No route to host */
 
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index ba4afe3b5a9c..294abd2cd526 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -23,6 +23,15 @@
 #include <asm/feature-fixups.h>
 
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
@@ -41,9 +50,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
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
 
@@ -67,6 +78,7 @@ _GLOBAL(store_fp_state)
 	SAVE_32FPVSRS(0, R4, R3)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r3)
+	REST_1FPVSR(0, R4, R3)
 	blr
 EXPORT_SYMBOL(store_fp_state)
 
@@ -133,4 +145,5 @@ _GLOBAL(save_fpu)
 2:	SAVE_32FPVSRS(0, R4, R6)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
+	REST_1FPVSR(0, R4, R6)
 	blr
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index ba03eedfdcd8..d2c23cf91f49 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -32,6 +32,7 @@ _GLOBAL(store_vr_state)
 	mfvscr	v0
 	li	r4, VRSTATE_VSCR
 	stvx	v0, r4, r3
+	lvx	v0, 0, r3
 	blr
 EXPORT_SYMBOL(store_vr_state)
 
@@ -104,6 +105,7 @@ _GLOBAL(save_altivec)
 	mfvscr	v0
 	li	r4,VRSTATE_VSCR
 	stvx	v0,r4,r7
+	lvx	v0,0,r7
 	blr
 
 #ifdef CONFIG_VSX
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 90beb26ed34e..67f98a083d22 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -209,6 +209,14 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
+static void imx6x_disable_freq_in_opp(struct device *dev, unsigned long freq)
+{
+	int ret = dev_pm_opp_disable(dev, freq);
+
+	if (ret < 0 && ret != -ENODEV)
+		dev_warn(dev, "failed to disable %ldMHz OPP\n", freq / 1000000);
+}
+
 #define OCOTP_CFG3			0x440
 #define OCOTP_CFG3_SPEED_SHIFT		16
 #define OCOTP_CFG3_SPEED_1P2GHZ		0x3
@@ -254,17 +262,15 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
 	val &= 0x3;
 
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
-		if (dev_pm_opp_disable(dev, 996000000))
-			dev_warn(dev, "failed to disable 996MHz OPP\n");
+		imx6x_disable_freq_in_opp(dev, 996000000);
 
 	if (of_machine_is_compatible("fsl,imx6q") ||
 	    of_machine_is_compatible("fsl,imx6qp")) {
 		if (val != OCOTP_CFG3_SPEED_852MHZ)
-			if (dev_pm_opp_disable(dev, 852000000))
-				dev_warn(dev, "failed to disable 852MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 852000000);
+
 		if (val != OCOTP_CFG3_SPEED_1P2GHZ)
-			if (dev_pm_opp_disable(dev, 1200000000))
-				dev_warn(dev, "failed to disable 1.2GHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 1200000000);
 	}
 
 	return 0;
@@ -316,20 +322,16 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
-	if (of_machine_is_compatible("fsl,imx6ul")) {
+	if (of_machine_is_compatible("fsl,imx6ul"))
 		if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
-			if (dev_pm_opp_disable(dev, 696000000))
-				dev_warn(dev, "failed to disable 696MHz OPP\n");
-	}
+			imx6x_disable_freq_in_opp(dev, 696000000);
 
 	if (of_machine_is_compatible("fsl,imx6ull")) {
-		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
-			if (dev_pm_opp_disable(dev, 792000000))
-				dev_warn(dev, "failed to disable 792MHz OPP\n");
+		if (val < OCOTP_CFG3_6ULL_SPEED_792MHZ)
+			imx6x_disable_freq_in_opp(dev, 792000000);
 
 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
-			if (dev_pm_opp_disable(dev, 900000000))
-				dev_warn(dev, "failed to disable 900MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 900000000);
 	}
 
 	return ret;
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 90ed8fdaba75..e820c36718ff 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -719,14 +719,11 @@ static void create_units(struct fw_device *device)
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
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index a87af6a89508..3bf5c787f914 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -120,6 +120,7 @@ static const struct xpad_device {
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f10, "Thrustmaster Modena GT Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0xb326, "Thrustmaster Gamepad GP XID", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
@@ -434,6 +435,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One Controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 7c20083d4a79..0ad33d8d99d1 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1518,6 +1518,15 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 {
 	struct qi_desc desc;
 
+	/*
+	 * VT-d spec, section 4.3:
+	 *
+	 * Software is recommended to not submit any Device-TLB invalidation
+	 * requests while address remapping hardware is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
 	if (mask) {
 		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
 		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
@@ -1583,6 +1592,15 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
 
+	/*
+	 * VT-d spec, section 4.3:
+	 *
+	 * Software is recommended to not submit any Device-TLB invalidation
+	 * requests while address remapping hardware is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
 	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
 		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
 		QI_DEV_IOTLB_PFSID(pfsid);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b3aa6ce9d3d7..46b2751c3f00 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4465,8 +4465,8 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
-	if (!info->iommu || !info->dev || !dev_is_pci(info->dev))
-		return;
+	if (!dev_is_pci(info->dev))
+		domain_context_clear_one(info, info->bus, info->devfn);
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
@@ -5749,7 +5749,7 @@ static void quirk_igfx_skip_te_disable(struct pci_dev *dev)
 	ver = (dev->device >> 8) & 0xff;
 	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
 	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
-	    ver != 0x9a && ver != 0xa7)
+	    ver != 0x9a && ver != 0xa7 && ver != 0x7d)
 		return;
 
 	if (risky_device(dev))
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index efef92dc7858..c7878ba35f3c 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1489,7 +1489,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	bch_keylist_free(&keylist);
 
 	for (i = 0; i < nodes; i++)
-		if (!IS_ERR(new_nodes[i])) {
+		if (!IS_ERR_OR_NULL(new_nodes[i])) {
 			btree_node_free(new_nodes[i]);
 			rw_unlock(true, new_nodes[i]);
 		}
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index cea2b3789736..442437e4e03b 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -24,7 +24,8 @@ bool verity_fec_is_enabled(struct dm_verity *v)
  */
 static inline struct dm_verity_fec_io *fec_io(struct dm_verity_io *io)
 {
-	return (struct dm_verity_fec_io *) verity_io_digest_end(io->v, io);
+	return (struct dm_verity_fec_io *)
+		((char *)io + io->v->ti->per_io_data_size - sizeof(struct dm_verity_fec_io));
 }
 
 /*
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 1a2509623874..905764e333e8 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -583,7 +583,9 @@ static void verity_end_io(struct bio *bio)
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
index 4e769d13473a..78d1e51195ad 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -111,12 +111,6 @@ static inline u8 *verity_io_want_digest(struct dm_verity *v,
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
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 25077a1a3d82..206bd5523ab7 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1465,6 +1465,8 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 			blk_mq_requeue_request(req, true);
 		else
 			__blk_mq_end_request(req, BLK_STS_OK);
+	} else if (mq->in_recovery) {
+		blk_mq_requeue_request(req, true);
 	} else {
 		blk_mq_end_request(req, BLK_STS_OK);
 	}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 07eda6cc6767..a6dcc68d68ee 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -552,7 +552,9 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
+	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, MMC_BUSY_IO);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
@@ -560,10 +562,13 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	host->cqe_ops->cqe_recovery_finish(host);
 
+	if (err)
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
 	mmc_retune_release(host);
 
 	return err;
diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a467ef..4dcbc2281d2b 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -271,3 +271,44 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
+
+/**
+ * mmc_regulator_enable_vqmmc - enable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Enables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (!IS_ERR(mmc->supply.vqmmc) && !mmc->vqmmc_enabled) {
+		ret = regulator_enable(mmc->supply.vqmmc);
+		if (ret < 0)
+			dev_err(mmc_dev(mmc), "enabling vqmmc regulator failed\n");
+		else
+			mmc->vqmmc_enabled = true;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_enable_vqmmc);
+
+/**
+ * mmc_regulator_disable_vqmmc - disable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Disables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc)
+{
+	if (!IS_ERR(mmc->supply.vqmmc) && mmc->vqmmc_enabled) {
+		regulator_disable(mmc->supply.vqmmc);
+		mmc->vqmmc_enabled = false;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_disable_vqmmc);
diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 31f841231609..961442e9a6c1 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -935,8 +935,8 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_tasks_cleared(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to clear tasks\n",
-			 mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to clear tasks\n",
+			mmc_hostname(mmc));
 
 	return ret;
 }
@@ -969,7 +969,7 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_halted(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
 
 	return ret;
 }
@@ -977,10 +977,10 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 /*
  * After halting we expect to be able to use the command line. We interpret the
  * failure to halt to mean the data lines might still be in use (and the upper
- * layers will need to send a STOP command), so we set the timeout based on a
- * generous command timeout.
+ * layers will need to send a STOP command), however failing to halt complicates
+ * the recovery, so set a timeout that would reasonably allow I/O to complete.
  */
-#define CQHCI_START_HALT_TIMEOUT	5
+#define CQHCI_START_HALT_TIMEOUT	500
 
 static void cqhci_recovery_start(struct mmc_host *mmc)
 {
@@ -1068,28 +1068,28 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 
 	ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
 
-	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-		ok = false;
-
 	/*
 	 * The specification contradicts itself, by saying that tasks cannot be
 	 * cleared if CQHCI does not halt, but if CQHCI does not halt, it should
 	 * be disabled/re-enabled, but not to disable before clearing tasks.
 	 * Have a go anyway.
 	 */
-	if (!ok) {
-		pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
-		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-		cqcfg &= ~CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		cqcfg |= CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		/* Be sure that there are no tasks */
-		ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
-		if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-			ok = false;
-		WARN_ON(!ok);
-	}
+	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
+		ok = false;
+
+	/* Disable to make sure tasks really are cleared */
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
+
+	if (!ok)
+		cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT);
 
 	cqhci_recover_mrqs(cq_host);
 
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 256260339f69..1cfc1aed4452 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -392,12 +392,33 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
+				 unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	switch (mode) {
+	case MMC_POWER_OFF:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+
+		mmc_regulator_disable_vqmmc(mmc);
+		break;
+	case MMC_POWER_ON:
+		mmc_regulator_enable_vqmmc(mmc);
+		break;
+	case MMC_POWER_UP:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
+		break;
+	}
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
 	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
+	.set_power = sdhci_sprd_set_power,
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -663,6 +684,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
 
+	ret = mmc_regulator_get_supply(host->mmc);
+	if (ret)
+		goto pm_runtime_disable;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index c48d41093651..78040a09313e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -952,14 +952,12 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-
-	/* If there's enough room to align the FD address, do it.
-	 * It will help hardware optimize accesses.
-	 */
 	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
 				  DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
+	else
+		return -ENOMEM;
 
 	/* Store a backpointer to the skb at the beginning of the buffer
 	 * (in the private data area) such that we can release it
@@ -4446,6 +4444,8 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (err)
 		goto err_dl_port_add;
 
+	net_dev->needed_headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
+
 	err = register_netdev(net_dev);
 	if (err < 0) {
 		dev_err(dev, "register_netdev() failed\n");
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index cdb623d5f2c1..67fd926331fe 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -670,7 +670,7 @@ static inline bool dpaa2_eth_rx_pause_enabled(u64 link_options)
 
 static inline unsigned int dpaa2_eth_needed_headroom(struct sk_buff *skb)
 {
-	unsigned int headroom = DPAA2_ETH_SWA_SIZE;
+	unsigned int headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
 
 	/* If we don't have an skb (e.g. XDP buffer), we only need space for
 	 * the software annotation area
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 1593efc4502b..5f9f6da5c45b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5045,6 +5045,8 @@ int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
 
 		ipolicer = &nix_hw->ipolicer[layer];
 		for (idx = 0; idx < req->prof_count[layer]; idx++) {
+			if (idx == MAX_BANDPROF_PER_PFFUNC)
+				break;
 			prof_idx = req->prof_idx[layer][idx];
 			if (prof_idx >= ipolicer->band_prof.max ||
 			    ipolicer->pfvf_map[prof_idx] != pcifunc)
@@ -5058,8 +5060,6 @@ int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
 			ipolicer->pfvf_map[prof_idx] = 0x00;
 			ipolicer->match_id[prof_idx] = 0;
 			rvu_free_rsrc(&ipolicer->band_prof, prof_idx);
-			if (idx == MAX_BANDPROF_PER_PFFUNC)
-				break;
 		}
 	}
 	mutex_unlock(&rvu->rsrc_lock);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 8cb4b16ffad7..4eec574631c7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -557,7 +557,9 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 		otx2_write64(pf, RVU_PF_VFPF_MBOX_INTX(1), intr);
 		otx2_queue_work(mbox, pf->mbox_pfvf_wq, 64, vfs, intr,
 				TYPE_PFVF);
-		vfs -= 64;
+		if (intr)
+			trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+		vfs = 64;
 	}
 
 	intr = otx2_read64(pf, RVU_PF_VFPF_MBOX_INTX(0));
@@ -565,7 +567,8 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 
 	otx2_queue_work(mbox, pf->mbox_pfvf_wq, 0, vfs, intr, TYPE_PFVF);
 
-	trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+	if (intr)
+		trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d4de5ec690e5..d2fbd169f25b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -588,6 +588,8 @@ struct rtl8169_tc_offsets {
 enum rtl_flag {
 	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
+	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
+	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
 
@@ -4029,7 +4031,7 @@ static void rtl8169_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 
-	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
+	rtl_schedule_task(tp, RTL_FLAG_TASK_TX_TIMEOUT);
 }
 
 static int rtl8169_tx_map(struct rtl8169_private *tp, const u32 *opts, u32 len,
@@ -4624,6 +4626,7 @@ static void rtl_task(struct work_struct *work)
 {
 	struct rtl8169_private *tp =
 		container_of(work, struct rtl8169_private, wk.work);
+	int ret;
 
 	rtnl_lock();
 
@@ -4631,9 +4634,21 @@ static void rtl_task(struct work_struct *work)
 	    !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
 		goto out_unlock;
 
+	if (test_and_clear_bit(RTL_FLAG_TASK_TX_TIMEOUT, tp->wk.flags)) {
+		/* ASPM compatibility issues are a typical reason for tx timeouts */
+		ret = pci_disable_link_state(tp->pci_dev, PCIE_LINK_STATE_L1 |
+							  PCIE_LINK_STATE_L0S);
+		if (!ret)
+			netdev_warn_once(tp->dev, "ASPM disabled on Tx timeout\n");
+		goto reset;
+	}
+
 	if (test_and_clear_bit(RTL_FLAG_TASK_RESET_PENDING, tp->wk.flags)) {
+reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
+	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
+		rtl_reset_work(tp);
 	}
 out_unlock:
 	rtnl_unlock();
@@ -4667,7 +4682,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	} else {
 		/* In few cases rx is broken after link-down otherwise */
 		if (rtl_is_8125(tp))
-			rtl_reset_work(tp);
+			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
 		pm_runtime_idle(d);
 	}
 
@@ -4744,7 +4759,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	cancel_work_sync(&tp->wk.work);
+	cancel_work(&tp->wk.work);
 
 	free_irq(pci_irq_vector(pdev, 0), tp);
 
@@ -5000,6 +5015,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_get_noresume(&pdev->dev);
 
+	cancel_work_sync(&tp->wk.work);
+
 	unregister_netdev(tp->dev);
 
 	if (tp->dash_type != RTL_DASH_NONE)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 19733c9a7c25..1fa002c42c88 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1448,19 +1448,20 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp)
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
 	/* Stop PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
+	ravb_stop_dma(ndev);
 out_free_irq_nc_tx:
 	if (!info->multi_irqs)
 		goto out_free_irq;
@@ -1504,6 +1505,12 @@ static void ravb_tx_timeout_work(struct work_struct *work)
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
@@ -1536,7 +1543,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		 */
 		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
 			   __func__, error);
-		return;
+		goto out_unlock;
 	}
 	ravb_emac_init(ndev);
 
@@ -1546,6 +1553,9 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
+
+out_unlock:
+	rtnl_unlock();
 }
 
 /* Packet transmit function for Ethernet AVB */
@@ -2179,9 +2189,14 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 
-	reset_control_deassert(rstc);
+	error = reset_control_deassert(rstc);
+	if (error)
+		goto out_free_netdev;
+
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0)
+		goto out_rpm_disable;
 
 	if (info->multi_irqs)
 		irq = platform_get_irq_byname(pdev, "ch22");
@@ -2364,11 +2379,12 @@ static int ravb_probe(struct platform_device *pdev)
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
-	free_netdev(ndev);
-
 	pm_runtime_put(&pdev->dev);
+out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(rstc);
+out_free_netdev:
+	free_netdev(ndev);
 	return error;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index a57b0fa815ab..a510bac0b825 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -177,8 +177,10 @@
 #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
 #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
 
+#define MMC_XGMAC_TX_FPE_INTR_MASK	0x204
 #define MMC_XGMAC_TX_FPE_FRAG		0x208
 #define MMC_XGMAC_TX_HOLD_REQ		0x20c
+#define MMC_XGMAC_RX_FPE_INTR_MASK	0x224
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
 #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
@@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
 {
 	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
 	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_TX_FPE_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_FPE_INTR_MASK);
 	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
 }
 
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ce1b299c89f5..c3a8ac244a08 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2563,15 +2563,6 @@ static int netvsc_probe(struct hv_device *dev,
 		goto devinfo_failed;
 	}
 
-	nvdev = rndis_filter_device_add(dev, device_info);
-	if (IS_ERR(nvdev)) {
-		ret = PTR_ERR(nvdev);
-		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
-		goto rndis_failed;
-	}
-
-	memcpy(net->dev_addr, device_info->mac_adr, ETH_ALEN);
-
 	/* We must get rtnl lock before scheduling nvdev->subchan_work,
 	 * otherwise netvsc_subchan_work() can get rtnl lock first and wait
 	 * all subchannels to show up, but that may not happen because
@@ -2579,9 +2570,23 @@ static int netvsc_probe(struct hv_device *dev,
 	 * -> ... -> device_add() -> ... -> __device_attach() can't get
 	 * the device lock, so all the subchannels can't be processed --
 	 * finally netvsc_subchan_work() hangs forever.
+	 *
+	 * The rtnl lock also needs to be held before rndis_filter_device_add()
+	 * which advertises nvsp_2_vsc_capability / sriov bit, and triggers
+	 * VF NIC offering and registering. If VF NIC finished register_netdev()
+	 * earlier it may cause name based config failure.
 	 */
 	rtnl_lock();
 
+	nvdev = rndis_filter_device_add(dev, device_info);
+	if (IS_ERR(nvdev)) {
+		ret = PTR_ERR(nvdev);
+		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
+		goto rndis_failed;
+	}
+
+	memcpy(net->dev_addr, device_info->mac_adr, ETH_ALEN);
+
 	if (nvdev->num_chn > 1)
 		schedule_work(&nvdev->subchan_work);
 
@@ -2615,9 +2620,9 @@ static int netvsc_probe(struct hv_device *dev,
 	return 0;
 
 register_failed:
-	rtnl_unlock();
 	rndis_filter_device_remove(dev, nvdev);
 rndis_failed:
+	rtnl_unlock();
 	netvsc_devinfo_put(device_info);
 devinfo_failed:
 	free_percpu(net_device_ctx->vf_stats);
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ffe39336fcac..456b72041c34 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1239,17 +1239,17 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
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
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 00e28456e4cc..5f190bfe8800 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -61,7 +61,7 @@ static void usb_parse_ssp_isoc_endpoint_companion(struct device *ddev,
 	desc = (struct usb_ssp_isoc_ep_comp_descriptor *) buffer;
 	if (desc->bDescriptorType != USB_DT_SSP_ISOC_ENDPOINT_COMP ||
 	    size < USB_DT_SSP_ISOC_EP_COMP_SIZE) {
-		dev_warn(ddev, "Invalid SuperSpeedPlus isoc endpoint companion"
+		dev_notice(ddev, "Invalid SuperSpeedPlus isoc endpoint companion"
 			 "for config %d interface %d altsetting %d ep %d.\n",
 			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		return;
@@ -83,7 +83,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 
 	if (desc->bDescriptorType != USB_DT_SS_ENDPOINT_COMP ||
 			size < USB_DT_SS_EP_COMP_SIZE) {
-		dev_warn(ddev, "No SuperSpeed endpoint companion for config %d "
+		dev_notice(ddev, "No SuperSpeed endpoint companion for config %d "
 				" interface %d altsetting %d ep %d: "
 				"using minimum values\n",
 				cfgno, inum, asnum, ep->desc.bEndpointAddress);
@@ -109,13 +109,13 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 
 	/* Check the various values */
 	if (usb_endpoint_xfer_control(&ep->desc) && desc->bMaxBurst != 0) {
-		dev_warn(ddev, "Control endpoint with bMaxBurst = %d in "
+		dev_notice(ddev, "Control endpoint with bMaxBurst = %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to zero\n", desc->bMaxBurst,
 				cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		ep->ss_ep_comp.bMaxBurst = 0;
 	} else if (desc->bMaxBurst > 15) {
-		dev_warn(ddev, "Endpoint with bMaxBurst = %d in "
+		dev_notice(ddev, "Endpoint with bMaxBurst = %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to 15\n", desc->bMaxBurst,
 				cfgno, inum, asnum, ep->desc.bEndpointAddress);
@@ -125,7 +125,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	if ((usb_endpoint_xfer_control(&ep->desc) ||
 			usb_endpoint_xfer_int(&ep->desc)) &&
 				desc->bmAttributes != 0) {
-		dev_warn(ddev, "%s endpoint with bmAttributes = %d in "
+		dev_notice(ddev, "%s endpoint with bmAttributes = %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to zero\n",
 				usb_endpoint_xfer_control(&ep->desc) ? "Control" : "Bulk",
@@ -134,7 +134,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 		ep->ss_ep_comp.bmAttributes = 0;
 	} else if (usb_endpoint_xfer_bulk(&ep->desc) &&
 			desc->bmAttributes > 16) {
-		dev_warn(ddev, "Bulk endpoint with more than 65536 streams in "
+		dev_notice(ddev, "Bulk endpoint with more than 65536 streams in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to max\n",
 				cfgno, inum, asnum, ep->desc.bEndpointAddress);
@@ -142,7 +142,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	} else if (usb_endpoint_xfer_isoc(&ep->desc) &&
 		   !USB_SS_SSP_ISOC_COMP(desc->bmAttributes) &&
 		   USB_SS_MULT(desc->bmAttributes) > 3) {
-		dev_warn(ddev, "Isoc endpoint has Mult of %d in "
+		dev_notice(ddev, "Isoc endpoint has Mult of %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to 3\n",
 				USB_SS_MULT(desc->bmAttributes),
@@ -160,7 +160,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	else
 		max_tx = 999999;
 	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx) {
-		dev_warn(ddev, "%s endpoint with wBytesPerInterval of %d in "
+		dev_notice(ddev, "%s endpoint with wBytesPerInterval of %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to %d\n",
 				usb_endpoint_xfer_isoc(&ep->desc) ? "Isoc" : "Int",
@@ -273,7 +273,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	else if (d->bLength >= USB_DT_ENDPOINT_SIZE)
 		n = USB_DT_ENDPOINT_SIZE;
 	else {
-		dev_warn(ddev, "config %d interface %d altsetting %d has an "
+		dev_notice(ddev, "config %d interface %d altsetting %d has an "
 		    "invalid endpoint descriptor of length %d, skipping\n",
 		    cfgno, inum, asnum, d->bLength);
 		goto skip_to_next_endpoint_or_interface_descriptor;
@@ -281,7 +281,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 
 	i = d->bEndpointAddress & ~USB_ENDPOINT_DIR_MASK;
 	if (i >= 16 || i == 0) {
-		dev_warn(ddev, "config %d interface %d altsetting %d has an "
+		dev_notice(ddev, "config %d interface %d altsetting %d has an "
 		    "invalid endpoint with address 0x%X, skipping\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
 		goto skip_to_next_endpoint_or_interface_descriptor;
@@ -293,7 +293,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 
 	/* Check for duplicate endpoint addresses */
 	if (config_endpoint_is_duplicate(config, inum, asnum, d)) {
-		dev_warn(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
+		dev_notice(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
 				cfgno, inum, asnum, d->bEndpointAddress);
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
@@ -301,7 +301,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	/* Ignore some endpoints */
 	if (udev->quirks & USB_QUIRK_ENDPOINT_IGNORE) {
 		if (usb_endpoint_is_ignored(udev, ifp, d)) {
-			dev_warn(ddev, "config %d interface %d altsetting %d has an ignored endpoint with address 0x%X, skipping\n",
+			dev_notice(ddev, "config %d interface %d altsetting %d has an ignored endpoint with address 0x%X, skipping\n",
 					cfgno, inum, asnum,
 					d->bEndpointAddress);
 			goto skip_to_next_endpoint_or_interface_descriptor;
@@ -378,7 +378,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		}
 	}
 	if (d->bInterval < i || d->bInterval > j) {
-		dev_warn(ddev, "config %d interface %d altsetting %d "
+		dev_notice(ddev, "config %d interface %d altsetting %d "
 		    "endpoint 0x%X has an invalid bInterval %d, "
 		    "changing to %d\n",
 		    cfgno, inum, asnum,
@@ -391,7 +391,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 * them usable, we will try treating them as Interrupt endpoints.
 	 */
 	if (udev->speed == USB_SPEED_LOW && usb_endpoint_xfer_bulk(d)) {
-		dev_warn(ddev, "config %d interface %d altsetting %d "
+		dev_notice(ddev, "config %d interface %d altsetting %d "
 		    "endpoint 0x%X is Bulk; changing to Interrupt\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
 		endpoint->desc.bmAttributes = USB_ENDPOINT_XFER_INT;
@@ -408,7 +408,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 */
 	maxp = le16_to_cpu(endpoint->desc.wMaxPacketSize);
 	if (maxp == 0 && !(usb_endpoint_xfer_isoc(d) && asnum == 0)) {
-		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid wMaxPacketSize 0\n",
+		dev_notice(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid wMaxPacketSize 0\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
 	}
 
@@ -439,7 +439,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	j = maxpacket_maxes[usb_endpoint_type(&endpoint->desc)];
 
 	if (maxp > j) {
-		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid maxpacket %d, setting to %d\n",
+		dev_notice(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid maxpacket %d, setting to %d\n",
 		    cfgno, inum, asnum, d->bEndpointAddress, maxp, j);
 		maxp = j;
 		endpoint->desc.wMaxPacketSize = cpu_to_le16(i | maxp);
@@ -452,7 +452,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 */
 	if (udev->speed == USB_SPEED_HIGH && usb_endpoint_xfer_bulk(d)) {
 		if (maxp != 512)
-			dev_warn(ddev, "config %d interface %d altsetting %d "
+			dev_notice(ddev, "config %d interface %d altsetting %d "
 				"bulk endpoint 0x%X has invalid maxpacket %d\n",
 				cfgno, inum, asnum, d->bEndpointAddress,
 				maxp);
@@ -533,7 +533,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	      i < intfc->num_altsetting;
 	     (++i, ++alt)) {
 		if (alt->desc.bAlternateSetting == asnum) {
-			dev_warn(ddev, "Duplicate descriptor for config %d "
+			dev_notice(ddev, "Duplicate descriptor for config %d "
 			    "interface %d altsetting %d, skipping\n",
 			    cfgno, inum, asnum);
 			goto skip_to_next_interface_descriptor;
@@ -559,7 +559,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	num_ep = num_ep_orig = alt->desc.bNumEndpoints;
 	alt->desc.bNumEndpoints = 0;		/* Use as a counter */
 	if (num_ep > USB_MAXENDPOINTS) {
-		dev_warn(ddev, "too many endpoints for config %d interface %d "
+		dev_notice(ddev, "too many endpoints for config %d interface %d "
 		    "altsetting %d: %d, using maximum allowed: %d\n",
 		    cfgno, inum, asnum, num_ep, USB_MAXENDPOINTS);
 		num_ep = USB_MAXENDPOINTS;
@@ -590,7 +590,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	}
 
 	if (n != num_ep_orig)
-		dev_warn(ddev, "config %d interface %d altsetting %d has %d "
+		dev_notice(ddev, "config %d interface %d altsetting %d has %d "
 		    "endpoint descriptor%s, different from the interface "
 		    "descriptor's value: %d\n",
 		    cfgno, inum, asnum, n, plural(n), num_ep_orig);
@@ -625,7 +625,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	if (config->desc.bDescriptorType != USB_DT_CONFIG ||
 	    config->desc.bLength < USB_DT_CONFIG_SIZE ||
 	    config->desc.bLength > size) {
-		dev_err(ddev, "invalid descriptor for config index %d: "
+		dev_notice(ddev, "invalid descriptor for config index %d: "
 		    "type = 0x%X, length = %d\n", cfgidx,
 		    config->desc.bDescriptorType, config->desc.bLength);
 		return -EINVAL;
@@ -636,7 +636,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	size -= config->desc.bLength;
 
 	if (nintf > USB_MAXINTERFACES) {
-		dev_warn(ddev, "config %d has too many interfaces: %d, "
+		dev_notice(ddev, "config %d has too many interfaces: %d, "
 		    "using maximum allowed: %d\n",
 		    cfgno, nintf, USB_MAXINTERFACES);
 		nintf = USB_MAXINTERFACES;
@@ -650,7 +650,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	     (buffer2 += header->bLength, size2 -= header->bLength)) {
 
 		if (size2 < sizeof(struct usb_descriptor_header)) {
-			dev_warn(ddev, "config %d descriptor has %d excess "
+			dev_notice(ddev, "config %d descriptor has %d excess "
 			    "byte%s, ignoring\n",
 			    cfgno, size2, plural(size2));
 			break;
@@ -658,7 +658,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 		header = (struct usb_descriptor_header *) buffer2;
 		if ((header->bLength > size2) || (header->bLength < 2)) {
-			dev_warn(ddev, "config %d has an invalid descriptor "
+			dev_notice(ddev, "config %d has an invalid descriptor "
 			    "of length %d, skipping remainder of the config\n",
 			    cfgno, header->bLength);
 			break;
@@ -670,7 +670,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 			d = (struct usb_interface_descriptor *) header;
 			if (d->bLength < USB_DT_INTERFACE_SIZE) {
-				dev_warn(ddev, "config %d has an invalid "
+				dev_notice(ddev, "config %d has an invalid "
 				    "interface descriptor of length %d, "
 				    "skipping\n", cfgno, d->bLength);
 				continue;
@@ -680,7 +680,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 			if ((dev->quirks & USB_QUIRK_HONOR_BNUMINTERFACES) &&
 			    n >= nintf_orig) {
-				dev_warn(ddev, "config %d has more interface "
+				dev_notice(ddev, "config %d has more interface "
 				    "descriptors, than it declares in "
 				    "bNumInterfaces, ignoring interface "
 				    "number: %d\n", cfgno, inum);
@@ -688,7 +688,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 			}
 
 			if (inum >= nintf_orig)
-				dev_warn(ddev, "config %d has an invalid "
+				dev_notice(ddev, "config %d has an invalid "
 				    "interface number: %d but max is %d\n",
 				    cfgno, inum, nintf_orig - 1);
 
@@ -713,14 +713,14 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 			d = (struct usb_interface_assoc_descriptor *)header;
 			if (d->bLength < USB_DT_INTERFACE_ASSOCIATION_SIZE) {
-				dev_warn(ddev,
+				dev_notice(ddev,
 					 "config %d has an invalid interface association descriptor of length %d, skipping\n",
 					 cfgno, d->bLength);
 				continue;
 			}
 
 			if (iad_num == USB_MAXIADS) {
-				dev_warn(ddev, "found more Interface "
+				dev_notice(ddev, "found more Interface "
 					       "Association Descriptors "
 					       "than allocated for in "
 					       "configuration %d\n", cfgno);
@@ -731,7 +731,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 		} else if (header->bDescriptorType == USB_DT_DEVICE ||
 			    header->bDescriptorType == USB_DT_CONFIG)
-			dev_warn(ddev, "config %d contains an unexpected "
+			dev_notice(ddev, "config %d contains an unexpected "
 			    "descriptor of type 0x%X, skipping\n",
 			    cfgno, header->bDescriptorType);
 
@@ -740,11 +740,11 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	config->desc.wTotalLength = cpu_to_le16(buffer2 - buffer0);
 
 	if (n != nintf)
-		dev_warn(ddev, "config %d has %d interface%s, different from "
+		dev_notice(ddev, "config %d has %d interface%s, different from "
 		    "the descriptor's value: %d\n",
 		    cfgno, n, plural(n), nintf_orig);
 	else if (n == 0)
-		dev_warn(ddev, "config %d has no interfaces?\n", cfgno);
+		dev_notice(ddev, "config %d has no interfaces?\n", cfgno);
 	config->desc.bNumInterfaces = nintf = n;
 
 	/* Check for missing interface numbers */
@@ -754,7 +754,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 				break;
 		}
 		if (j >= nintf)
-			dev_warn(ddev, "config %d has no interface number "
+			dev_notice(ddev, "config %d has no interface number "
 			    "%d\n", cfgno, i);
 	}
 
@@ -762,7 +762,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	for (i = 0; i < nintf; ++i) {
 		j = nalts[i];
 		if (j > USB_MAXALTSETTING) {
-			dev_warn(ddev, "too many alternate settings for "
+			dev_notice(ddev, "too many alternate settings for "
 			    "config %d interface %d: %d, "
 			    "using maximum allowed: %d\n",
 			    cfgno, inums[i], j, USB_MAXALTSETTING);
@@ -811,7 +811,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 					break;
 			}
 			if (n >= intfc->num_altsetting)
-				dev_warn(ddev, "config %d interface %d has no "
+				dev_notice(ddev, "config %d interface %d has no "
 				    "altsetting %d\n", cfgno, inums[i], j);
 		}
 	}
@@ -868,7 +868,7 @@ int usb_get_configuration(struct usb_device *dev)
 	int result;
 
 	if (ncfg > USB_MAXCONFIG) {
-		dev_warn(ddev, "too many configurations: %d, "
+		dev_notice(ddev, "too many configurations: %d, "
 		    "using maximum allowed: %d\n", ncfg, USB_MAXCONFIG);
 		dev->descriptor.bNumConfigurations = ncfg = USB_MAXCONFIG;
 	}
@@ -902,7 +902,7 @@ int usb_get_configuration(struct usb_device *dev)
 			    "descriptor/%s: %d\n", cfgno, "start", result);
 			if (result != -EPIPE)
 				goto err;
-			dev_err(ddev, "chopping to %d config(s)\n", cfgno);
+			dev_notice(ddev, "chopping to %d config(s)\n", cfgno);
 			dev->descriptor.bNumConfigurations = cfgno;
 			break;
 		} else if (result < 4) {
@@ -934,7 +934,7 @@ int usb_get_configuration(struct usb_device *dev)
 			goto err;
 		}
 		if (result < length) {
-			dev_warn(ddev, "config index %d descriptor too short "
+			dev_notice(ddev, "config index %d descriptor too short "
 			    "(expected %i, got %i)\n", cfgno, length, result);
 			length = result;
 		}
@@ -993,7 +993,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 	/* Get BOS descriptor */
 	ret = usb_get_descriptor(dev, USB_DT_BOS, 0, bos, USB_DT_BOS_SIZE);
 	if (ret < USB_DT_BOS_SIZE || bos->bLength < USB_DT_BOS_SIZE) {
-		dev_err(ddev, "unable to get BOS descriptor or descriptor too short\n");
+		dev_notice(ddev, "unable to get BOS descriptor or descriptor too short\n");
 		if (ret >= 0)
 			ret = -ENOMSG;
 		kfree(bos);
@@ -1021,7 +1021,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 
 	ret = usb_get_descriptor(dev, USB_DT_BOS, 0, buffer, total_len);
 	if (ret < total_len) {
-		dev_err(ddev, "unable to get BOS descriptor set\n");
+		dev_notice(ddev, "unable to get BOS descriptor set\n");
 		if (ret >= 0)
 			ret = -ENOMSG;
 		goto err;
@@ -1046,8 +1046,8 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 		}
 
 		if (cap->bDescriptorType != USB_DT_DEVICE_CAPABILITY) {
-			dev_warn(ddev, "descriptor type invalid, skip\n");
-			continue;
+			dev_notice(ddev, "descriptor type invalid, skip\n");
+			goto skip_to_next_descriptor;
 		}
 
 		switch (cap_type) {
@@ -1081,6 +1081,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 			break;
 		}
 
+skip_to_next_descriptor:
 		total_len -= length;
 		buffer += length;
 	}
diff --git a/drivers/video/fbdev/sticore.h b/drivers/video/fbdev/sticore.h
index 0ebdd28a0b81..d83ab3ded5f3 100644
--- a/drivers/video/fbdev/sticore.h
+++ b/drivers/video/fbdev/sticore.h
@@ -231,7 +231,7 @@ struct sti_rom_font {
 	 u8 height;
 	 u8 font_type;		/* language type */
 	 u8 bytes_per_char;
-	u32 next_font;
+	s32 next_font;		/* note: signed int */
 	 u8 underline_height;
 	 u8 underline_pos;
 	 u8 res008[2];
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f0654fe80b34..24d10b541a13 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3204,6 +3204,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
+	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
 	 * corrupted, we'll find out
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index d2062d5f71dd..50a5a5cfe38f 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -788,6 +788,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		} else if (be->num_refs == 0) {
 			btrfs_err(fs_info,
@@ -797,6 +798,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		}
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 692ae2e2f8cc..c9fd598b0325 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7576,7 +7576,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	sctx->flags = arg->flags;
 
 	sctx->send_filp = fget(arg->send_fd);
-	if (!sctx->send_filp) {
+	if (!sctx->send_filp || !(sctx->send_filp->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out;
 	}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2fd0ee0e6e93..718119e3830d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -337,7 +337,10 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 
 static void btrfs_put_super(struct super_block *sb)
 {
-	close_ctree(btrfs_sb(sb));
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+
+	btrfs_info(fs_info, "last unmount of filesystem %pU", fs_info->fs_devices->fsid);
+	close_ctree(fs_info);
 }
 
 enum {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 56ea2ec26436..cc18ba50a61c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3064,15 +3064,16 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	read_unlock(&em_tree->lock);
 
 	if (!em) {
-		btrfs_crit(fs_info, "unable to find logical %llu length %llu",
+		btrfs_crit(fs_info,
+			   "unable to find chunk map for logical %llu length %llu",
 			   logical, length);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (em->start > logical || em->start + em->len < logical) {
+	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
-			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
-			   logical, length, em->start, em->start + em->len);
+			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
+			   logical, logical + length, em->start, em->start + em->len);
 		free_extent_map(em);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index b5ae209539ff..af688e39f31a 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1127,6 +1127,7 @@ const struct inode_operations cifs_file_inode_ops = {
 
 const struct inode_operations cifs_symlink_inode_ops = {
 	.get_link = cifs_get_link,
+	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 9d486fbbfbbd..6f719b9cf9e9 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -150,10 +150,13 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
 			goto out;
 
-		if (pTcon->ses->server->ops->set_EA)
+		if (pTcon->ses->server->ops->set_EA) {
 			rc = pTcon->ses->server->ops->set_EA(xid, pTcon,
 				full_path, name, value, (__u16)size,
 				cifs_sb->local_nls, cifs_sb);
+			if (rc == 0)
+				inode_set_ctime_current(inode);
+		}
 		break;
 
 	case XATTR_CIFS_ACL:
diff --git a/fs/inode.c b/fs/inode.c
index 7cb048a3b3bd..ec41a11e2f8f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2335,6 +2335,22 @@ struct timespec64 current_time(struct inode *inode)
 }
 EXPORT_SYMBOL(current_time);
 
+/**
+ * inode_set_ctime_current - set the ctime to current_time
+ * @inode: inode
+ *
+ * Set the inode->i_ctime to the current value for the inode. Returns
+ * the current value that was assigned to i_ctime.
+ */
+struct timespec64 inode_set_ctime_current(struct inode *inode)
+{
+	struct timespec64 now = current_time(inode);
+
+	inode_set_ctime(inode, now.tv_sec, now.tv_nsec);
+	return now;
+}
+EXPORT_SYMBOL(inode_set_ctime_current);
+
 /**
  * in_group_or_capable - check whether caller is CAP_FSETID privileged
  * @mnt_userns: user namespace of the mount @inode was found from
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 468dcbba45bc..4ee7790f7b2e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -92,7 +92,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 		if (offset + ret > dio->i_size &&
 		    !(dio->flags & IOMAP_DIO_WRITE))
 			ret = dio->i_size - offset;
-		iocb->ki_pos += ret;
 	}
 
 	/*
@@ -118,18 +117,19 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	}
 
 	inode_dio_end(file_inode(iocb->ki_filp));
-	/*
-	 * If this is a DSYNC write, make sure we push it to stable storage now
-	 * that we've written data.
-	 */
-	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
-		ret = generic_write_sync(iocb, ret);
-
-	if (ret > 0)
-		ret += dio->done_before;
+	if (ret > 0) {
+		iocb->ki_pos += ret;
 
+		/*
+		 * If this is a DSYNC write, make sure we push it to stable
+		 * storage now that we've written data.
+		 */
+		if (dio->flags & IOMAP_DIO_NEED_SYNC)
+			ret = generic_write_sync(iocb, ret);
+		if (ret > 0)
+			ret += dio->done_before;
+	}
 	kfree(dio);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_complete);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6bba7a58c95c..6f287fac0ece 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1722,7 +1722,50 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	       kgid_has_mapping(fs_userns, kgid);
 }
 
-extern struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_time(struct inode *inode);
+struct timespec64 inode_set_ctime_current(struct inode *inode);
+
+/**
+ * inode_get_ctime - fetch the current ctime from the inode
+ * @inode: inode from which to fetch ctime
+ *
+ * Grab the current ctime from the inode and return it.
+ */
+static inline struct timespec64 inode_get_ctime(const struct inode *inode)
+{
+	return inode->i_ctime;
+}
+
+/**
+ * inode_set_ctime_to_ts - set the ctime in the inode
+ * @inode: inode in which to set the ctime
+ * @ts: value to set in the ctime field
+ *
+ * Set the ctime in @inode to @ts
+ */
+static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
+						      struct timespec64 ts)
+{
+	inode->i_ctime = ts;
+	return ts;
+}
+
+/**
+ * inode_set_ctime - set the ctime in the inode
+ * @inode: inode in which to set the ctime
+ * @sec: tv_sec value to set
+ * @nsec: tv_nsec value to set
+ *
+ * Set the ctime in @inode to { @sec, @nsec }
+ */
+static inline struct timespec64 inode_set_ctime(struct inode *inode,
+						time64_t sec, long nsec)
+{
+	struct timespec64 ts = { .tv_sec  = sec,
+				 .tv_nsec = nsec };
+
+	return inode_set_ctime_to_ts(inode, ts);
+}
 
 /*
  * Snapshotting support.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c0c9a0fdf57..a4ec7269b629 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -428,6 +428,7 @@ struct mmc_host {
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
+	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
@@ -574,6 +575,8 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc);
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc);
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
diff --git a/include/linux/platform_data/x86/soc.h b/include/linux/platform_data/x86/soc.h
new file mode 100644
index 000000000000..da05f425587a
--- /dev/null
+++ b/include/linux/platform_data/x86/soc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Helpers for Intel SoC model detection
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ */
+
+#ifndef __PLATFORM_DATA_X86_SOC_H
+#define __PLATFORM_DATA_X86_SOC_H
+
+#if IS_ENABLED(CONFIG_X86)
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+
+#define SOC_INTEL_IS_CPU(soc, type)				\
+static inline bool soc_intel_is_##soc(void)			\
+{								\
+	static const struct x86_cpu_id soc##_cpu_ids[] = {	\
+		X86_MATCH_INTEL_FAM6_MODEL(type, NULL),		\
+		{}						\
+	};							\
+	const struct x86_cpu_id *id;				\
+								\
+	id = x86_match_cpu(soc##_cpu_ids);			\
+	if (id)							\
+		return true;					\
+	return false;						\
+}
+
+SOC_INTEL_IS_CPU(byt, ATOM_SILVERMONT);
+SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
+SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
+SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
+SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
+
+#else /* IS_ENABLED(CONFIG_X86) */
+
+static inline bool soc_intel_is_byt(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_cht(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_apl(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_glk(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_cml(void)
+{
+	return false;
+}
+#endif /* IS_ENABLED(CONFIG_X86) */
+
+#endif /* __PLATFORM_DATA_X86_SOC_H */
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 1e96680f5023..5f2e531d0a80 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -462,6 +462,7 @@ extern int schedule_on_each_cpu(work_func_t func);
 int execute_in_process_context(work_func_t fn, struct execute_work *);
 
 extern bool flush_work(struct work_struct *work);
+extern bool cancel_work(struct work_struct *work);
 extern bool cancel_work_sync(struct work_struct *work);
 
 extern bool flush_delayed_work(struct delayed_work *dwork);
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 7837ba4fe728..dcd50fb2164a 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -27,7 +27,7 @@
 	union { \
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
-	}
+	} ATTRS
 
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f1a73a1f8472..b48b42d76474 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -458,7 +458,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * be quite short, for example, in the case of the call from
  * rcu_read_unlock_special().
  */
-static void
+static notrace void
 rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 {
 	bool empty_exp;
@@ -578,7 +578,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  * is disabled.  This function cannot be expected to understand these
  * nuances, so the caller must handle them.
  */
-static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
@@ -592,7 +592,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
  * evaluate safety in terms of interrupt, softirq, and preemption
  * disabling.
  */
-static void rcu_preempt_deferred_qs(struct task_struct *t)
+static notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
 
@@ -923,7 +923,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * Because there is no preemptible RCU, there can be no deferred quiescent
  * states.
  */
-static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return false;
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 962ee27ec7d7..d5f30b610217 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3277,6 +3277,15 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
 	return ret;
 }
 
+/*
+ * See cancel_delayed_work()
+ */
+bool cancel_work(struct work_struct *work)
+{
+	return __cancel_work(work, false);
+}
+EXPORT_SYMBOL(cancel_work);
+
 /**
  * cancel_delayed_work - cancel a delayed work
  * @dwork: delayed_work to cancel
diff --git a/lib/errname.c b/lib/errname.c
index 67739b174a8c..0c336b0f12f6 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -111,9 +111,6 @@ static const char *names_0[] = {
 	E(ENOSPC),
 	E(ENOSR),
 	E(ENOSTR),
-#ifdef ENOSYM
-	E(ENOSYM),
-#endif
 	E(ENOSYS),
 	E(ENOTBLK),
 	E(ENOTCONN),
@@ -144,9 +141,6 @@ static const char *names_0[] = {
 #endif
 	E(EREMOTE),
 	E(EREMOTEIO),
-#ifdef EREMOTERELEASE
-	E(EREMOTERELEASE),
-#endif
 	E(ERESTART),
 	E(ERFKILL),
 	E(EROFS),
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 1a705a4ef7fa..5eaf38875554 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -129,6 +129,7 @@ void vlan_dev_set_ingress_priority(const struct net_device *dev,
 				   u32 skb_prio, u16 vlan_prio);
 int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio);
+void vlan_dev_free_egress_priority(const struct net_device *dev);
 int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32 mask);
 void vlan_dev_get_realdev_name(const struct net_device *dev, char *result,
 			       size_t size);
@@ -139,7 +140,6 @@ int vlan_check_real_dev(struct net_device *real_dev,
 void vlan_setup(struct net_device *dev);
 int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack);
 void unregister_vlan_dev(struct net_device *dev, struct list_head *head);
-void vlan_dev_uninit(struct net_device *dev);
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev);
 
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 3d0f0d0a323b..ad2d3ad34b7d 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -622,7 +622,7 @@ static int vlan_dev_init(struct net_device *dev)
 }
 
 /* Note: this function might be called multiple times for the same device. */
-void vlan_dev_uninit(struct net_device *dev)
+void vlan_dev_free_egress_priority(const struct net_device *dev)
 {
 	struct vlan_priority_tci_mapping *pm;
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
@@ -636,6 +636,16 @@ void vlan_dev_uninit(struct net_device *dev)
 	}
 }
 
+static void vlan_dev_uninit(struct net_device *dev)
+{
+	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+
+	vlan_dev_free_egress_priority(dev);
+
+	/* Get rid of the vlan's reference to real_dev */
+	dev_put(vlan->real_dev);
+}
+
 static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
 	netdev_features_t features)
 {
@@ -846,9 +856,6 @@ static void vlan_dev_free(struct net_device *dev)
 
 	free_percpu(vlan->vlan_pcpu_stats);
 	vlan->vlan_pcpu_stats = NULL;
-
-	/* Get rid of the vlan's reference to real_dev */
-	dev_put(vlan->real_dev);
 }
 
 void vlan_setup(struct net_device *dev)
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 0db85aeb119b..53b1955b027f 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -183,10 +183,11 @@ static int vlan_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 
 	err = vlan_changelink(dev, tb, data, extack);
-	if (!err)
-		err = register_vlan_dev(dev, extack);
 	if (err)
-		vlan_dev_uninit(dev);
+		return err;
+	err = register_vlan_dev(dev, extack);
+	if (err)
+		vlan_dev_free_egress_priority(dev);
 	return err;
 }
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 1f63dc8897a4..88e780a16865 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -216,8 +216,10 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
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
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1e9092d7e9e8..65f7e3dc4602 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2210,6 +2210,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugs.launchpad.net/bugs/1821663 */
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	/* KONTRON SinglePC may cause a stall at runtime resume */
+	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	{}
 };
 #endif /* CONFIG_PM */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4ab3cbef72e8..463e8d1eae68 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1980,6 +1980,7 @@ enum {
 	ALC887_FIXUP_ASUS_AUDIO,
 	ALC887_FIXUP_ASUS_HMIC,
 	ALCS1200A_FIXUP_MIC_VREF,
+	ALC888VD_FIXUP_MIC_100VREF,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2533,6 +2534,13 @@ static const struct hda_fixup alc882_fixups[] = {
 			{}
 		}
 	},
+	[ALC888VD_FIXUP_MIC_100VREF] = {
+		.type = HDA_FIXUP_PINCTLS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, PIN_VREF100 }, /* headset mic */
+			{}
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2602,6 +2610,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x4a00, "Macbook 5,2", ALC889_FIXUP_MBA11_VREF),
 
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
+	SND_PCI_QUIRK(0x10ec, 0x12d8, "iBase Elo Touch", ALC888VD_FIXUP_MIC_100VREF),
 	SND_PCI_QUIRK(0x13fe, 0x1009, "Advantech MIT-W101", ALC886_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
@@ -3249,6 +3258,7 @@ static void alc_disable_headset_jack_key(struct hda_codec *codec)
 	case 0x10ec0230:
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_write_coef_idx(codec, 0x48, 0x0);
 		alc_update_coef_idx(codec, 0x49, 0x0045, 0x0);
@@ -3278,6 +3288,7 @@ static void alc_enable_headset_jack_key(struct hda_codec *codec)
 	case 0x10ec0230:
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_write_coef_idx(codec, 0x48, 0xd011);
 		alc_update_coef_idx(codec, 0x49, 0x007f, 0x0045);
@@ -6472,6 +6483,7 @@ static void alc_combo_jack_hp_jd_restart(struct hda_codec *codec)
 	case 0x10ec0236:
 	case 0x10ec0255:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
 		alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
index a93987ab7f4d..de4e550c5b34 100644
--- a/sound/soc/intel/common/soc-intel-quirks.h
+++ b/sound/soc/intel/common/soc-intel-quirks.h
@@ -9,34 +9,13 @@
 #ifndef _SND_SOC_INTEL_QUIRKS_H
 #define _SND_SOC_INTEL_QUIRKS_H
 
+#include <linux/platform_data/x86/soc.h>
+
 #if IS_ENABLED(CONFIG_X86)
 
 #include <linux/dmi.h>
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
 
-#define SOC_INTEL_IS_CPU(soc, type)				\
-static inline bool soc_intel_is_##soc(void)			\
-{								\
-	static const struct x86_cpu_id soc##_cpu_ids[] = {	\
-		X86_MATCH_INTEL_FAM6_MODEL(type, NULL),		\
-		{}						\
-	};							\
-	const struct x86_cpu_id *id;				\
-								\
-	id = x86_match_cpu(soc##_cpu_ids);			\
-	if (id)							\
-		return true;					\
-	return false;						\
-}
-
-SOC_INTEL_IS_CPU(byt, ATOM_SILVERMONT);
-SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
-SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
-SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
-SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
-
 static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
 {
 	/*
@@ -114,30 +93,6 @@ static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
 	return false;
 }
 
-static inline bool soc_intel_is_byt(void)
-{
-	return false;
-}
-
-static inline bool soc_intel_is_cht(void)
-{
-	return false;
-}
-
-static inline bool soc_intel_is_apl(void)
-{
-	return false;
-}
-
-static inline bool soc_intel_is_glk(void)
-{
-	return false;
-}
-
-static inline bool soc_intel_is_cml(void)
-{
-	return false;
-}
 #endif
 
- #endif /* _SND_SOC_INTEL_QUIRKS_H */
+#endif /* _SND_SOC_INTEL_QUIRKS_H */
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 3b4c011e0283..ec40053041e1 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -12,6 +12,7 @@
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/pm_runtime.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
@@ -27,17 +28,22 @@ static char *tplg_path;
 module_param(tplg_path, charp, 0444);
 MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
 
+static char *tplg_filename;
+module_param(tplg_filename, charp, 0444);
+MODULE_PARM_DESC(tplg_filename, "alternate filename for SOF topology.");
+
 static int sof_pci_debug;
 module_param_named(sof_pci_debug, sof_pci_debug, int, 0444);
 MODULE_PARM_DESC(sof_pci_debug, "SOF PCI debug options (0x0 all off)");
 
-static const char *sof_override_tplg_name;
+static const char *sof_dmi_override_tplg_name;
+static bool sof_dmi_use_community_key;
 
 #define SOF_PCI_DISABLE_PM_RUNTIME BIT(0)
 
 static int sof_tplg_cb(const struct dmi_system_id *id)
 {
-	sof_override_tplg_name = id->driver_data;
+	sof_dmi_override_tplg_name = id->driver_data;
 	return 1;
 }
 
@@ -62,25 +68,44 @@ static const struct dmi_system_id sof_tplg_table[] = {
 	{}
 };
 
+/* all Up boards use the community key */
+static int up_use_community_key(const struct dmi_system_id *id)
+{
+	sof_dmi_use_community_key = true;
+	return 1;
+}
+
+/*
+ * For ApolloLake Chromebooks we want to force the use of the Intel production key.
+ * All newer platforms use the community key
+ */
+static int chromebook_use_community_key(const struct dmi_system_id *id)
+{
+	if (!soc_intel_is_apl())
+		sof_dmi_use_community_key = true;
+	return 1;
+}
+
 static const struct dmi_system_id community_key_platforms[] = {
 	{
-		.ident = "Up Squared",
+		.ident = "Up boards",
+		.callback = up_use_community_key,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_BOARD_NAME, "UP-APL01"),
 		}
 	},
 	{
-		.ident = "Up Extreme",
+		.ident = "Google Chromebooks",
+		.callback = chromebook_use_community_key,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
 		}
 	},
 	{
-		.ident = "Google Chromebooks",
+		.ident = "Google firmware",
+		.callback = chromebook_use_community_key,
 		.matches = {
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
+			DMI_MATCH(DMI_BIOS_VERSION, "Google"),
 		}
 	},
 	{},
@@ -171,7 +196,7 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 			"Module parameter used, changed fw path to %s\n",
 			sof_pdata->fw_filename_prefix);
 
-	} else if (dmi_check_system(community_key_platforms)) {
+	} else if (dmi_check_system(community_key_platforms) && sof_dmi_use_community_key) {
 		sof_pdata->fw_filename_prefix =
 			devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
 				       sof_pdata->desc->default_fw_path,
@@ -191,9 +216,20 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		sof_pdata->tplg_filename_prefix =
 			sof_pdata->desc->default_tplg_path;
 
-	dmi_check_system(sof_tplg_table);
-	if (sof_override_tplg_name)
-		sof_pdata->tplg_filename = sof_override_tplg_name;
+	/*
+	 * the topology filename will be provided in the machine descriptor, unless
+	 * it is overridden by a module parameter or DMI quirk.
+	 */
+	if (tplg_filename) {
+		sof_pdata->tplg_filename = tplg_filename;
+
+		dev_dbg(dev, "Module parameter used, changed tplg filename to %s\n",
+			sof_pdata->tplg_filename);
+	} else {
+		dmi_check_system(sof_tplg_table);
+		if (sof_dmi_override_tplg_name)
+			sof_pdata->tplg_filename = sof_dmi_override_tplg_name;
+	}
 
 	/* set callback to be called on successful device probe to enable runtime_pm */
 	sof_pdata->sof_probe_complete = sof_pci_probe_complete;
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 87245c584784..8d94739d75c6 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -75,7 +75,6 @@
 
 /* We now return you to your regularly scheduled HPUX. */
 
-#define ENOSYM		215	/* symbol does not exist in executable */
 #define	ENOTSOCK	216	/* Socket operation on non-socket */
 #define	EDESTADDRREQ	217	/* Destination address required */
 #define	EMSGSIZE	218	/* Message too long */
@@ -101,7 +100,6 @@
 #define	ETIMEDOUT	238	/* Connection timed out */
 #define	ECONNREFUSED	239	/* Connection refused */
 #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
-#define	EREMOTERELEASE	240	/* Remote peer released connection */
 #define	EHOSTDOWN	241	/* Host is down */
 #define	EHOSTUNREACH	242	/* No route to host */
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 7a2ce387079e..805bad9364e9 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1346,9 +1346,11 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 	} else if (ptq->state->flags & INTEL_PT_ASYNC) {
 		if (!ptq->state->to_ip)
 			ptq->flags = PERF_IP_FLAG_BRANCH |
+				     PERF_IP_FLAG_ASYNC |
 				     PERF_IP_FLAG_TRACE_END;
 		else if (ptq->state->from_nr && !ptq->state->to_nr)
 			ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
+				     PERF_IP_FLAG_ASYNC |
 				     PERF_IP_FLAG_VMEXIT;
 		else
 			ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 3d7dde2c321b..c5be3f390849 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -2278,7 +2278,7 @@ static int check_results(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int nr_process = 1;
+	long nr_process = 1;
 	int route_sock = -1, ret = KSFT_SKIP;
 	int test_desc_fd[2];
 	uint32_t route_seq;
@@ -2299,7 +2299,7 @@ int main(int argc, char **argv)
 			exit_usage(argv);
 		}
 
-		if (nr_process > MAX_PROCESSES || !nr_process) {
+		if (nr_process > MAX_PROCESSES || nr_process < 1) {
 			printk("nr_process should be between [1; %u]",
 					MAX_PROCESSES);
 			exit_usage(argv);
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 9cc7e0108c8b..2deac2031de9 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,4 +1,6 @@
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index dbe5cfb54558..4597bba66ad4 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #ifndef RESCTRL_H
 #define RESCTRL_H
 #include <stdio.h>
