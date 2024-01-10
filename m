Return-Path: <linux-kernel+bounces-17958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74A082560B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3786F1F27A10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88F2E416;
	Fri,  5 Jan 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="utSqsuIH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8212E414;
	Fri,  5 Jan 2024 14:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED01AC433C8;
	Fri,  5 Jan 2024 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465892;
	bh=nL08fW6qqAah08W7yjTcbBrWp8WbeZl2lNKMFPJ1sQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utSqsuIHd845zHetZRhOvaAp8MIySQX39+PyvUsgXYTG1WfGP1zj4Qzf55Nce5Rto
	 2RjU6229LDp/pjIyd8/FNZY/2rHBq0+03XTY7GXJZnkP1SgplWjgh2f0Pxsk54GHDB
	 WaAYmpDTFnIgUocQ1hpVYZ+vQi0RcfsE/4HsEvvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.10
Date: Fri,  5 Jan 2024 15:42:48 +0100
Message-ID: <2024010548-bounding-clutch-8c24@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024010547-tanning-ogle-0916@gregkh>
References: <2024010547-tanning-ogle-0916@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 4d1d5e925bb2..50a862316e15 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d5d5388973ac..4640cee33f12 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -607,10 +607,10 @@ config ARCH_SUPPORTS_KEXEC
 	def_bool PPC_BOOK3S || PPC_E500 || (44x && !SMP)
 
 config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool PPC64 && CRYPTO=y && CRYPTO_SHA256=y
+	def_bool PPC64
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
-	def_bool KEXEC_FILE
+	def_bool y
 
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6688cbbed0b4..9e6d442773ee 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -686,9 +686,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	select KEXEC_ELF
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
-	def_bool KEXEC_FILE
-	depends on CRYPTO=y
-	depends on CRYPTO_SHA256=y
+	def_bool ARCH_SUPPORTS_KEXEC_FILE
 
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ae29e4392664..bd4782f23f66 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -252,13 +252,13 @@ config ARCH_SUPPORTS_KEXEC
 	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
+	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool MODULE_SIG_FORMAT
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
-	def_bool KEXEC_FILE
+	def_bool y
 
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..fe3292e310d4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2034,7 +2034,7 @@ config ARCH_SUPPORTS_KEXEC
 	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool X86_64 && CRYPTO && CRYPTO_SHA256
+	def_bool X86_64
 
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
@@ -2042,7 +2042,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
-	def_bool KEXEC_FILE
+	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool y
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e..206f1b4e5eb1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2548,24 +2548,17 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 * the controller.  Abort any ios on the association and let the
 	 * create_association error path resolve things.
 	 */
-	enum nvme_ctrl_state state;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrl->lock, flags);
-	state = ctrl->ctrl.state;
-	if (state == NVME_CTRL_CONNECTING) {
-		set_bit(ASSOC_FAILED, &ctrl->flags);
-		spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
+		set_bit(ASSOC_FAILED, &ctrl->flags);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
 			ctrl->cnum);
 		return;
 	}
-	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (state != NVME_CTRL_LIVE)
+	if (ctrl->ctrl.state != NVME_CTRL_LIVE)
 		return;
 
 	dev_warn(ctrl->ctrl.device,
@@ -3179,16 +3172,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
 	}
-
-	spin_lock_irqsave(&ctrl->lock, flags);
 	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
 		ret = -EIO;
-	if (ret) {
-		spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (ret)
 		goto out_term_aen_ops;
-	}
+
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	ctrl->ctrl.nr_reconnects = 0;
 
diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index 5006008e01be..606f7678bcb0 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -314,16 +314,13 @@ int adl_core_init(struct pmc_dev *pmcdev)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 
+	pmcdev->suspend = cnl_suspend;
+	pmcdev->resume = cnl_resume;
+
 	pmc->map = &adl_reg_map;
 	ret = get_primary_reg_base(pmc);
 	if (ret)
 		return ret;
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 420aaa1d7c76..98b36651201a 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -204,21 +204,35 @@ const struct pmc_reg_map cnp_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+void cnl_suspend(struct pmc_dev *pmcdev)
+{
+	/*
+	 * Due to a hardware limitation, the GBE LTR blocks PC10
+	 * when a cable is attached. To unblock PC10 during suspend,
+	 * tell the PMC to ignore it.
+	 */
+	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
+}
+
+int cnl_resume(struct pmc_dev *pmcdev)
+{
+	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
+
+	return pmc_core_resume_common(pmcdev);
+}
+
 int cnp_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 
+	pmcdev->suspend = cnl_suspend;
+	pmcdev->resume = cnl_resume;
+
 	pmc->map = &cnp_reg_map;
 	ret = get_primary_reg_base(pmc);
 	if (ret)
 		return ret;
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e95d3011b999..022afb97d531 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -460,7 +460,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
-int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
+int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 {
 	struct pmc *pmc;
 	const struct pmc_reg_map *map;
@@ -498,7 +498,10 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
 	mutex_lock(&pmcdev->lock);
 
 	reg = pmc_core_reg_read(pmc, map->ltr_ignore_offset);
-	reg |= BIT(ltr_index);
+	if (ignore)
+		reg |= BIT(ltr_index);
+	else
+		reg &= ~BIT(ltr_index);
 	pmc_core_reg_write(pmc, map->ltr_ignore_offset, reg);
 
 	mutex_unlock(&pmcdev->lock);
@@ -521,7 +524,7 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 	if (err)
 		return err;
 
-	err = pmc_core_send_ltr_ignore(pmcdev, value);
+	err = pmc_core_send_ltr_ignore(pmcdev, value, 1);
 
 	return err == 0 ? count : err;
 }
@@ -1279,6 +1282,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 
+	if (pmcdev->suspend)
+		pmcdev->suspend(pmcdev);
+
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 0729f593c6a7..b66dacbfb94b 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -363,6 +363,7 @@ struct pmc {
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
+ * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  *
  * pmc_dev contains info about power management controller device.
@@ -379,6 +380,7 @@ struct pmc_dev {
 	u64 s0ix_counter;
 	int num_lpm_modes;
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
+	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 
 	bool has_die_c6;
@@ -486,7 +488,7 @@ extern const struct pmc_bit_map *mtl_ioem_lpm_maps[];
 extern const struct pmc_reg_map mtl_ioem_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
-extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
+int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
@@ -500,6 +502,9 @@ int tgl_core_init(struct pmc_dev *pmcdev);
 int adl_core_init(struct pmc_dev *pmcdev);
 int mtl_core_init(struct pmc_dev *pmcdev);
 
+void cnl_suspend(struct pmc_dev *pmcdev);
+int cnl_resume(struct pmc_dev *pmcdev);
+
 #define pmc_for_each_mode(i, mode, pmcdev)		\
 	for (i = 0, mode = pmcdev->lpm_en_modes[i];	\
 	     i < pmcdev->num_lpm_modes;			\
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 2204bc666980..504e3e273c32 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -979,6 +979,8 @@ static void mtl_d3_fixup(void)
 static int mtl_resume(struct pmc_dev *pmcdev)
 {
 	mtl_d3_fixup();
+	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
+
 	return pmc_core_resume_common(pmcdev);
 }
 
@@ -989,6 +991,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 
 	mtl_d3_fixup();
 
+	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = mtl_resume;
 
 	pmcdev->regmap_list = mtl_pmc_info_list;
@@ -1002,11 +1005,5 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 			return ret;
 	}
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 2449940102db..e88d3d00c853 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -259,16 +259,15 @@ int tgl_core_init(struct pmc_dev *pmcdev)
 	int ret;
 
 	pmc->map = &tgl_reg_map;
+
+	pmcdev->suspend = cnl_suspend;
+	pmcdev->resume = cnl_resume;
+
 	ret = get_primary_reg_base(pmc);
 	if (ret)
 		return ret;
 
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
 
 	return 0;
 }
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d8f3299c10..49299b1f9ec7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3219,8 +3219,7 @@ void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
 	if (!vq->use_dma_api)
 		return;
 
-	dma_sync_single_range_for_cpu(dev, addr, offset, size,
-				      DMA_BIDIRECTIONAL);
+	dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
 
@@ -3246,8 +3245,7 @@ void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
 	if (!vq->use_dma_api)
 		return;
 
-	dma_sync_single_range_for_device(dev, addr, offset, size,
-					 DMA_BIDIRECTIONAL);
+	dma_sync_single_range_for_device(dev, addr, offset, size, dir);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 189447cf4acf..dc0f7519045f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -549,7 +549,8 @@ void simple_recursive_removal(struct dentry *dentry,
 				dput(victim);		// unpin it
 			}
 			if (victim == dentry) {
-				inode->i_mtime = inode_set_ctime_current(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_set_ctime_current(inode));
 				if (d_is_dir(dentry))
 					drop_nlink(inode);
 				inode_unlock(inode);
@@ -590,7 +591,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	 */
 	root->i_ino = 1;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
-	root->i_atime = root->i_mtime = inode_set_ctime_current(root);
+	simple_inode_init_ts(root);
 	s->s_root = d_make_root(root);
 	if (!s->s_root)
 		return -ENOMEM;
@@ -646,8 +647,8 @@ int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *den
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	dir->i_mtime = inode_set_ctime_to_ts(dir,
-					     inode_set_ctime_current(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	inc_nlink(inode);
 	ihold(inode);
 	dget(dentry);
@@ -681,8 +682,8 @@ int simple_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	dir->i_mtime = inode_set_ctime_to_ts(dir,
-					     inode_set_ctime_current(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	drop_nlink(inode);
 	dput(dentry);
 	return 0;
@@ -717,9 +718,10 @@ void simple_rename_timestamp(struct inode *old_dir, struct dentry *old_dentry,
 {
 	struct inode *newino = d_inode(new_dentry);
 
-	old_dir->i_mtime = inode_set_ctime_current(old_dir);
+	inode_set_mtime_to_ts(old_dir, inode_set_ctime_current(old_dir));
 	if (new_dir != old_dir)
-		new_dir->i_mtime = inode_set_ctime_current(new_dir);
+		inode_set_mtime_to_ts(new_dir,
+				      inode_set_ctime_current(new_dir));
 	inode_set_ctime_current(d_inode(old_dentry));
 	if (newino)
 		inode_set_ctime_current(newino);
@@ -934,7 +936,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 	 */
 	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0755;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
@@ -960,7 +962,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 			goto out;
 		}
 		inode->i_mode = S_IFREG | files->mode;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_fop = files->ops;
 		inode->i_ino = i;
 		d_add(dentry, inode);
@@ -1528,7 +1530,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	inode->i_flags |= S_PRIVATE;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	return inode;
 }
 EXPORT_SYMBOL(alloc_anon_inode);
@@ -1920,3 +1922,20 @@ ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
 	return direct_written + buffered_written;
 }
 EXPORT_SYMBOL_GPL(direct_write_fallback);
+
+/**
+ * simple_inode_init_ts - initialize the timestamps for a new inode
+ * @inode: inode to be initialized
+ *
+ * When a new inode is created, most filesystems set the timestamps to the
+ * current time. Add a helper to do this.
+ */
+struct timespec64 simple_inode_init_ts(struct inode *inode)
+{
+	struct timespec64 ts = inode_set_ctime_current(inode);
+
+	inode_set_atime_to_ts(inode, ts);
+	inode_set_mtime_to_ts(inode, ts);
+	return ts;
+}
+EXPORT_SYMBOL(simple_inode_init_ts);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 2108b3b40ce9..32a8525415d9 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1085,7 +1085,8 @@ int cifs_close(struct inode *inode, struct file *file)
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
 		    dclose) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
-				inode->i_mtime = inode_set_ctime_current(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_set_ctime_current(inode));
 			}
 			spin_lock(&cinode->deferred_lock);
 			cifs_add_deferred_close(cfile, dclose);
@@ -2596,7 +2597,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 					   write_data, to - from, &offset);
 		cifsFileInfo_put(open_file);
 		/* Does mm or vfs already set times? */
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		if ((bytes_written > 0) && (offset))
 			rc = 0;
 		else if (bytes_written < 0)
@@ -4647,11 +4648,13 @@ static void cifs_readahead(struct readahead_control *ractl)
 static int cifs_readpage_worker(struct file *file, struct page *page,
 	loff_t *poffset)
 {
+	struct inode *inode = file_inode(file);
+	struct timespec64 atime, mtime;
 	char *read_data;
 	int rc;
 
 	/* Is the page cached? */
-	rc = cifs_readpage_from_fscache(file_inode(file), page);
+	rc = cifs_readpage_from_fscache(inode, page);
 	if (rc == 0)
 		goto read_complete;
 
@@ -4666,11 +4669,10 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 		cifs_dbg(FYI, "Bytes read %d\n", rc);
 
 	/* we do not want atime to be less than mtime, it broke some apps */
-	file_inode(file)->i_atime = current_time(file_inode(file));
-	if (timespec64_compare(&(file_inode(file)->i_atime), &(file_inode(file)->i_mtime)))
-		file_inode(file)->i_atime = file_inode(file)->i_mtime;
-	else
-		file_inode(file)->i_atime = current_time(file_inode(file));
+	atime = inode_set_atime_to_ts(inode, current_time(inode));
+	mtime = inode_get_mtime(inode);
+	if (timespec64_compare(&atime, &mtime) < 0)
+		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 
 	if (PAGE_SIZE > rc)
 		memset(read_data + rc, 0, PAGE_SIZE - rc);
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index 84f3b09367d2..a3d73720914f 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -49,12 +49,12 @@ static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
 				 struct cifs_fscache_inode_coherency_data *cd)
 {
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 mtime = inode_get_mtime(inode);
 
 	memset(cd, 0, sizeof(*cd));
-	cd->last_write_time_sec   = cpu_to_le64(cifsi->netfs.inode.i_mtime.tv_sec);
-	cd->last_write_time_nsec  = cpu_to_le32(cifsi->netfs.inode.i_mtime.tv_nsec);
+	cd->last_write_time_sec   = cpu_to_le64(mtime.tv_sec);
+	cd->last_write_time_nsec  = cpu_to_le32(mtime.tv_nsec);
 	cd->last_change_time_sec  = cpu_to_le64(ctime.tv_sec);
 	cd->last_change_time_nsec = cpu_to_le32(ctime.tv_nsec);
 }
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 6a856945f2b4..09c5c0f5c96e 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -82,6 +82,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 {
 	struct cifs_fscache_inode_coherency_data cd;
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
+	struct timespec64 mtime;
 
 	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
 		 __func__, cifs_i->uniqueid);
@@ -101,7 +102,8 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 
 	 /* revalidate if mtime or size have changed */
 	fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
-	if (timespec64_equal(&inode->i_mtime, &fattr->cf_mtime) &&
+	mtime = inode_get_mtime(inode);
+	if (timespec64_equal(&mtime, &fattr->cf_mtime) &&
 	    cifs_i->server_eof == fattr->cf_eof) {
 		cifs_dbg(FYI, "%s: inode %llu is unchanged\n",
 			 __func__, cifs_i->uniqueid);
@@ -164,10 +166,10 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	fattr->cf_ctime = timestamp_truncate(fattr->cf_ctime, inode);
 	/* we do not want atime to be less than mtime, it broke some apps */
 	if (timespec64_compare(&fattr->cf_atime, &fattr->cf_mtime) < 0)
-		inode->i_atime = fattr->cf_mtime;
+		inode_set_atime_to_ts(inode, fattr->cf_mtime);
 	else
-		inode->i_atime = fattr->cf_atime;
-	inode->i_mtime = fattr->cf_mtime;
+		inode_set_atime_to_ts(inode, fattr->cf_atime);
+	inode_set_mtime_to_ts(inode, fattr->cf_mtime);
 	inode_set_ctime_to_ts(inode, fattr->cf_ctime);
 	inode->i_rdev = fattr->cf_rdev;
 	cifs_nlink_fattr_to_inode(inode, fattr);
@@ -1868,7 +1870,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 					   when needed */
 		inode_set_ctime_current(inode);
 	}
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	cifs_inode = CIFS_I(dir);
 	CIFS_I(dir)->time = 0;	/* force revalidate of dir as well */
 unlink_out:
@@ -2183,7 +2185,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	cifsInode->time = 0;
 
 	inode_set_ctime_current(d_inode(direntry));
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 rmdir_exit:
 	free_dentry_path(page);
@@ -2389,9 +2391,6 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	/* force revalidate to go get info when needed */
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
-	source_dir->i_mtime = target_dir->i_mtime = inode_set_ctime_to_ts(source_dir,
-									  inode_set_ctime_current(target_dir));
-
 cifs_rename_exit:
 	kfree(info_buf_source);
 	free_dentry_path(page2);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2187921580ac..e917eeba9c77 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1409,12 +1409,14 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Creation time should not need to be updated on close */
 	if (file_inf.LastWriteTime)
-		inode->i_mtime = cifs_NTtimeToUnix(file_inf.LastWriteTime);
+		inode_set_mtime_to_ts(inode,
+				      cifs_NTtimeToUnix(file_inf.LastWriteTime));
 	if (file_inf.ChangeTime)
 		inode_set_ctime_to_ts(inode,
 				      cifs_NTtimeToUnix(file_inf.ChangeTime));
 	if (file_inf.LastAccessTime)
-		inode->i_atime = cifs_NTtimeToUnix(file_inf.LastAccessTime);
+		inode_set_atime_to_ts(inode,
+				      cifs_NTtimeToUnix(file_inf.LastAccessTime));
 
 	/*
 	 * i_blocks is not related to (i_size / i_blksize),
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index ec20c83cc836..d58550c1c937 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1228,6 +1228,7 @@ struct create_mxac_rsp {
 #define SMB2_LEASE_WRITE_CACHING_LE		cpu_to_le32(0x04)
 
 #define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE	cpu_to_le32(0x02)
+#define SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE	cpu_to_le32(0x04)
 
 #define SMB2_LEASE_KEY_SIZE			16
 
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 4b38c3a285f6..b6fa1e285c40 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -167,23 +167,7 @@ void ksmbd_all_conn_set_status(u64 sess_id, u32 status)
 
 void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
 {
-	struct ksmbd_conn *bind_conn;
-
 	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
-
-	down_read(&conn_list_lock);
-	list_for_each_entry(bind_conn, &conn_list, conns_list) {
-		if (bind_conn == conn)
-			continue;
-
-		if ((bind_conn->binding || xa_load(&bind_conn->sessions, sess_id)) &&
-		    !ksmbd_conn_releasing(bind_conn) &&
-		    atomic_read(&bind_conn->req_running)) {
-			wait_event(bind_conn->req_running_q,
-				atomic_read(&bind_conn->req_running) == 0);
-		}
-	}
-	up_read(&conn_list_lock);
 }
 
 int ksmbd_conn_write(struct ksmbd_work *work)
diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 51def3ca74c0..d7c676c151e2 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -56,6 +56,9 @@ void ksmbd_free_work_struct(struct ksmbd_work *work)
 	kfree(work->tr_buf);
 	kvfree(work->request_buf);
 	kfree(work->iov);
+	if (!list_empty(&work->interim_entry))
+		list_del(&work->interim_entry);
+
 	if (work->async_id)
 		ksmbd_release_id(&work->conn->async_ida, work->async_id);
 	kmem_cache_free(work_cache, work);
@@ -95,32 +98,42 @@ bool ksmbd_queue_work(struct ksmbd_work *work)
 	return queue_work(ksmbd_wq, &work->work);
 }
 
-static int ksmbd_realloc_iov_pin(struct ksmbd_work *work, void *ib,
-				 unsigned int ib_len)
+static inline void __ksmbd_iov_pin(struct ksmbd_work *work, void *ib,
+				   unsigned int ib_len)
+{
+	work->iov[++work->iov_idx].iov_base = ib;
+	work->iov[work->iov_idx].iov_len = ib_len;
+	work->iov_cnt++;
+}
+
+static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
+			       void *aux_buf, unsigned int aux_size)
 {
+	struct aux_read *ar = NULL;
+	int need_iov_cnt = 1;
+
+	if (aux_size) {
+		need_iov_cnt++;
+		ar = kmalloc(sizeof(struct aux_read), GFP_KERNEL);
+		if (!ar)
+			return -ENOMEM;
+	}
 
-	if (work->iov_alloc_cnt <= work->iov_cnt) {
+	if (work->iov_alloc_cnt < work->iov_cnt + need_iov_cnt) {
 		struct kvec *new;
 
 		work->iov_alloc_cnt += 4;
 		new = krealloc(work->iov,
 			       sizeof(struct kvec) * work->iov_alloc_cnt,
 			       GFP_KERNEL | __GFP_ZERO);
-		if (!new)
+		if (!new) {
+			kfree(ar);
+			work->iov_alloc_cnt -= 4;
 			return -ENOMEM;
+		}
 		work->iov = new;
 	}
 
-	work->iov[++work->iov_idx].iov_base = ib;
-	work->iov[work->iov_idx].iov_len = ib_len;
-	work->iov_cnt++;
-
-	return 0;
-}
-
-static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
-			       void *aux_buf, unsigned int aux_size)
-{
 	/* Plus rfc_length size on first iov */
 	if (!work->iov_idx) {
 		work->iov[work->iov_idx].iov_base = work->response_buf;
@@ -129,19 +142,13 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 		work->iov_cnt++;
 	}
 
-	ksmbd_realloc_iov_pin(work, ib, len);
+	__ksmbd_iov_pin(work, ib, len);
 	inc_rfc1001_len(work->iov[0].iov_base, len);
 
 	if (aux_size) {
-		struct aux_read *ar;
-
-		ksmbd_realloc_iov_pin(work, aux_buf, aux_size);
+		__ksmbd_iov_pin(work, aux_buf, aux_size);
 		inc_rfc1001_len(work->iov[0].iov_base, aux_size);
 
-		ar = kmalloc(sizeof(struct aux_read), GFP_KERNEL);
-		if (!ar)
-			return -ENOMEM;
-
 		ar->buf = aux_buf;
 		list_add(&ar->entry, &work->aux_read_list);
 	}
diff --git a/fs/smb/server/mgmt/user_config.h b/fs/smb/server/mgmt/user_config.h
index 6a44109617f1..e068a19fd904 100644
--- a/fs/smb/server/mgmt/user_config.h
+++ b/fs/smb/server/mgmt/user_config.h
@@ -18,7 +18,6 @@ struct ksmbd_user {
 
 	size_t			passkey_sz;
 	char			*passkey;
-	unsigned int		failed_login_count;
 };
 
 static inline bool user_guest(struct ksmbd_user *user)
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 9bc0103720f5..562b180459a1 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -102,9 +102,10 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->new_state = 0;
 	lease->flags = lctx->flags;
 	lease->duration = lctx->duration;
+	lease->is_dir = lctx->is_dir;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
-	lease->epoch = 0;
+	lease->epoch = le16_to_cpu(lctx->epoch);
 	INIT_LIST_HEAD(&opinfo->lease_entry);
 	opinfo->o_lease = lease;
 
@@ -395,8 +396,8 @@ void close_id_del_oplock(struct ksmbd_file *fp)
 {
 	struct oplock_info *opinfo;
 
-	if (S_ISDIR(file_inode(fp->filp)->i_mode))
-		return;
+	if (fp->reserve_lease_break)
+		smb_lazy_parent_lease_break_close(fp);
 
 	opinfo = opinfo_get(fp);
 	if (!opinfo)
@@ -543,12 +544,13 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
 			     atomic_read(&ci->sop_count)) == 1) {
-				if (lease->state ==
-				    (lctx->req_state & lease->state)) {
+				if (lease->state != SMB2_LEASE_NONE_LE &&
+				    lease->state == (lctx->req_state & lease->state)) {
 					lease->state |= lctx->req_state;
 					if (lctx->req_state &
 						SMB2_LEASE_WRITE_CACHING_LE)
 						lease_read_to_write(opinfo);
+
 				}
 			} else if ((atomic_read(&ci->op_count) +
 				    atomic_read(&ci->sop_count)) > 1) {
@@ -833,7 +835,8 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 					     interim_entry);
 			setup_async_work(in_work, NULL, NULL);
 			smb2_send_interim_resp(in_work, STATUS_PENDING);
-			list_del(&in_work->interim_entry);
+			list_del_init(&in_work->interim_entry);
+			release_async_work(in_work);
 		}
 		INIT_WORK(&work->work, __smb2_lease_break_noti);
 		ksmbd_queue_work(work);
@@ -899,7 +902,8 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
 					lease->new_state =
 						SMB2_LEASE_READ_CACHING_LE;
 			} else {
-				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE &&
+						!lease->is_dir)
 					lease->new_state =
 						SMB2_LEASE_READ_CACHING_LE;
 				else
@@ -1031,6 +1035,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	       SMB2_LEASE_KEY_SIZE);
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
+	lease2->epoch = lease1->epoch++;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
@@ -1080,6 +1085,89 @@ static void set_oplock_level(struct oplock_info *opinfo, int level,
 	}
 }
 
+void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
+				      struct lease_ctx_info *lctx)
+{
+	struct oplock_info *opinfo;
+	struct ksmbd_inode *p_ci = NULL;
+
+	if (lctx->version != 2)
+		return;
+
+	p_ci = ksmbd_inode_lookup_lock(fp->filp->f_path.dentry->d_parent);
+	if (!p_ci)
+		return;
+
+	read_lock(&p_ci->m_lock);
+	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
+		if (!opinfo->is_lease)
+			continue;
+
+		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE &&
+		    (!(lctx->flags & SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE) ||
+		     !compare_guid_key(opinfo, fp->conn->ClientGUID,
+				      lctx->parent_lease_key))) {
+			if (!atomic_inc_not_zero(&opinfo->refcount))
+				continue;
+
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				continue;
+			}
+
+			read_unlock(&p_ci->m_lock);
+			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
+			opinfo_conn_put(opinfo);
+			read_lock(&p_ci->m_lock);
+		}
+	}
+	read_unlock(&p_ci->m_lock);
+
+	ksmbd_inode_put(p_ci);
+}
+
+void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo;
+	struct ksmbd_inode *p_ci = NULL;
+
+	rcu_read_lock();
+	opinfo = rcu_dereference(fp->f_opinfo);
+	rcu_read_unlock();
+
+	if (!opinfo->is_lease || opinfo->o_lease->version != 2)
+		return;
+
+	p_ci = ksmbd_inode_lookup_lock(fp->filp->f_path.dentry->d_parent);
+	if (!p_ci)
+		return;
+
+	read_lock(&p_ci->m_lock);
+	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
+		if (!opinfo->is_lease)
+			continue;
+
+		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE) {
+			if (!atomic_inc_not_zero(&opinfo->refcount))
+				continue;
+
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				continue;
+			}
+			read_unlock(&p_ci->m_lock);
+			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
+			opinfo_conn_put(opinfo);
+			read_lock(&p_ci->m_lock);
+		}
+	}
+	read_unlock(&p_ci->m_lock);
+
+	ksmbd_inode_put(p_ci);
+}
+
 /**
  * smb_grant_oplock() - handle oplock/lease request on file open
  * @work:		smb work
@@ -1103,10 +1191,6 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	bool prev_op_has_lease;
 	__le32 prev_op_state = 0;
 
-	/* not support directory lease */
-	if (S_ISDIR(file_inode(fp->filp)->i_mode))
-		return 0;
-
 	opinfo = alloc_opinfo(work, pid, tid);
 	if (!opinfo)
 		return -ENOMEM;
@@ -1363,6 +1447,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
 		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
+		buf->lcontext.Epoch = cpu_to_le16(++lease->epoch);
 		buf->lcontext.LeaseState = lease->state;
 		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
 		       SMB2_LEASE_KEY_SIZE);
@@ -1399,10 +1484,11 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 /**
  * parse_lease_state() - parse lease context containted in file open request
  * @open_req:	buffer containing smb2 file open(create) request
+ * @is_dir:	whether leasing file is directory
  *
  * Return:  oplock state, -ENOENT if create lease context not found
  */
-struct lease_ctx_info *parse_lease_state(void *open_req)
+struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 {
 	struct create_context *cc;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
@@ -1420,8 +1506,14 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-		lreq->req_state = lc->lcontext.LeaseState;
+		if (is_dir) {
+			lreq->req_state = lc->lcontext.LeaseState &
+				~SMB2_LEASE_WRITE_CACHING_LE;
+			lreq->is_dir = true;
+		} else
+			lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->epoch = lc->lcontext.Epoch;
 		lreq->duration = lc->lcontext.LeaseDuration;
 		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
 				SMB2_LEASE_KEY_SIZE);
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index 4b0fe6da7694..5b93ea9196c0 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -34,7 +34,9 @@ struct lease_ctx_info {
 	__le32			flags;
 	__le64			duration;
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
+	__le16			epoch;
 	int			version;
+	bool			is_dir;
 };
 
 struct lease_table {
@@ -53,6 +55,7 @@ struct lease {
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
 	int			version;
 	unsigned short		epoch;
+	bool			is_dir;
 	struct lease_table	*l_lb;
 };
 
@@ -108,7 +111,7 @@ void opinfo_put(struct oplock_info *opinfo);
 
 /* Lease related functions */
 void create_lease_buf(u8 *rbuf, struct lease *lease);
-struct lease_ctx_info *parse_lease_state(void *open_req);
+struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir);
 __u8 smb2_map_lease_to_oplock(__le32 lease_state);
 int lease_read_to_write(struct oplock_info *opinfo);
 
@@ -124,4 +127,7 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			struct lease_ctx_info *lctx);
 void destroy_lease_table(struct ksmbd_conn *conn);
+void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
+				      struct lease_ctx_info *lctx);
+void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 23bd3d1209df..03dded29a980 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -106,16 +106,25 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	case SMB2_CREATE:
 	{
+		unsigned short int name_off =
+			le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
+		unsigned short int name_len =
+			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+
 		if (((struct smb2_create_req *)hdr)->CreateContextsLength) {
 			*off = le32_to_cpu(((struct smb2_create_req *)
 				hdr)->CreateContextsOffset);
 			*len = le32_to_cpu(((struct smb2_create_req *)
 				hdr)->CreateContextsLength);
-			break;
+			if (!name_len)
+				break;
+
+			if (name_off + name_len < (u64)*off + *len)
+				break;
 		}
 
-		*off = le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
-		*len = le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+		*off = name_off;
+		*len = name_len;
 		break;
 	}
 	case SMB2_QUERY_INFO:
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index aed7704a0672..27a9dce3e03a 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -221,7 +221,8 @@ void init_smb3_0_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
 	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
@@ -245,7 +246,8 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
@@ -270,7 +272,8 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2b248d45d40a..fbd708bb4a5b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -657,13 +657,9 @@ smb2_get_name(const char *src, const int maxlen, struct nls_table *local_nls)
 
 int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 {
-	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_conn *conn = work->conn;
 	int id;
 
-	rsp_hdr = ksmbd_resp_buf_next(work);
-	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
-
 	id = ksmbd_acquire_async_msg_id(&conn->async_ida);
 	if (id < 0) {
 		pr_err("Failed to alloc async message id\n");
@@ -671,7 +667,6 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 	}
 	work->asynchronous = true;
 	work->async_id = id;
-	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
 	ksmbd_debug(SMB,
 		    "Send interim Response to inform async request id : %d\n",
@@ -723,6 +718,8 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 	       __SMB2_HEADER_STRUCTURE_SIZE);
 
 	rsp_hdr = smb2_get_msg(in_work->response_buf);
+	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
+	rsp_hdr->Id.AsyncId = cpu_to_le64(work->async_id);
 	smb2_set_err_rsp(in_work);
 	rsp_hdr->Status = status;
 
@@ -2691,7 +2688,7 @@ int smb2_open(struct ksmbd_work *work)
 		    *(char *)req->Buffer == '\\') {
 			pr_err("not allow directory name included leading slash\n");
 			rc = -EINVAL;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		name = smb2_get_name(req->Buffer,
@@ -2702,7 +2699,7 @@ int smb2_open(struct ksmbd_work *work)
 			if (rc != -ENOMEM)
 				rc = -ENOENT;
 			name = NULL;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		ksmbd_debug(SMB, "converted name = %s\n", name);
@@ -2710,48 +2707,44 @@ int smb2_open(struct ksmbd_work *work)
 			if (!test_share_config_flag(work->tcon->share_conf,
 						    KSMBD_SHARE_FLAG_STREAMS)) {
 				rc = -EBADF;
-				goto err_out1;
+				goto err_out2;
 			}
 			rc = parse_stream_name(name, &stream_name, &s_type);
 			if (rc < 0)
-				goto err_out1;
+				goto err_out2;
 		}
 
 		rc = ksmbd_validate_filename(name);
 		if (rc < 0)
-			goto err_out1;
+			goto err_out2;
 
 		if (ksmbd_share_veto_filename(share, name)) {
 			rc = -ENOENT;
 			ksmbd_debug(SMB, "Reject open(), vetoed file: %s\n",
 				    name);
-			goto err_out1;
+			goto err_out2;
 		}
 	} else {
 		name = kstrdup("", GFP_KERNEL);
 		if (!name) {
 			rc = -ENOMEM;
-			goto err_out1;
+			goto err_out2;
 		}
 	}
 
-	req_op_level = req->RequestedOplockLevel;
-	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
-		lc = parse_lease_state(req);
-
 	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE)) {
 		pr_err("Invalid impersonationlevel : 0x%x\n",
 		       le32_to_cpu(req->ImpersonationLevel));
 		rc = -EIO;
 		rsp->hdr.Status = STATUS_BAD_IMPERSONATION_LEVEL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->CreateOptions && !(req->CreateOptions & CREATE_OPTIONS_MASK_LE)) {
 		pr_err("Invalid create options : 0x%x\n",
 		       le32_to_cpu(req->CreateOptions));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	} else {
 		if (req->CreateOptions & FILE_SEQUENTIAL_ONLY_LE &&
 		    req->CreateOptions & FILE_RANDOM_ACCESS_LE)
@@ -2761,13 +2754,13 @@ int smb2_open(struct ksmbd_work *work)
 		    (FILE_OPEN_BY_FILE_ID_LE | CREATE_TREE_CONNECTION |
 		     FILE_RESERVE_OPFILTER_LE)) {
 			rc = -EOPNOTSUPP;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
 			if (req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE) {
 				rc = -EINVAL;
-				goto err_out1;
+				goto err_out2;
 			} else if (req->CreateOptions & FILE_NO_COMPRESSION_LE) {
 				req->CreateOptions = ~(FILE_NO_COMPRESSION_LE);
 			}
@@ -2779,21 +2772,21 @@ int smb2_open(struct ksmbd_work *work)
 		pr_err("Invalid create disposition : 0x%x\n",
 		       le32_to_cpu(req->CreateDisposition));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (!(req->DesiredAccess & DESIRED_ACCESS_MASK)) {
 		pr_err("Invalid desired access : 0x%x\n",
 		       le32_to_cpu(req->DesiredAccess));
 		rc = -EACCES;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->FileAttributes && !(req->FileAttributes & FILE_ATTRIBUTE_MASK_LE)) {
 		pr_err("Invalid file attribute : 0x%x\n",
 		       le32_to_cpu(req->FileAttributes));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->CreateContextsOffset) {
@@ -2801,19 +2794,19 @@ int smb2_open(struct ksmbd_work *work)
 		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ea_buf = (struct create_ea_buf_req *)context;
 			if (le16_to_cpu(context->DataOffset) +
 			    le32_to_cpu(context->DataLength) <
 			    sizeof(struct create_ea_buf_req)) {
 				rc = -EINVAL;
-				goto err_out1;
+				goto err_out2;
 			}
 			if (req->CreateOptions & FILE_NO_EA_KNOWLEDGE_LE) {
 				rsp->hdr.Status = STATUS_ACCESS_DENIED;
 				rc = -EACCES;
-				goto err_out1;
+				goto err_out2;
 			}
 		}
 
@@ -2821,7 +2814,7 @@ int smb2_open(struct ksmbd_work *work)
 						 SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ksmbd_debug(SMB,
 				    "get query maximal access context\n");
@@ -2832,11 +2825,11 @@ int smb2_open(struct ksmbd_work *work)
 						 SMB2_CREATE_TIMEWARP_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ksmbd_debug(SMB, "get timewarp context\n");
 			rc = -EBADF;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		if (tcon->posix_extensions) {
@@ -2844,7 +2837,7 @@ int smb2_open(struct ksmbd_work *work)
 							 SMB2_CREATE_TAG_POSIX, 16);
 			if (IS_ERR(context)) {
 				rc = PTR_ERR(context);
-				goto err_out1;
+				goto err_out2;
 			} else if (context) {
 				struct create_posix *posix =
 					(struct create_posix *)context;
@@ -2852,7 +2845,7 @@ int smb2_open(struct ksmbd_work *work)
 				    le32_to_cpu(context->DataLength) <
 				    sizeof(struct create_posix) - 4) {
 					rc = -EINVAL;
-					goto err_out1;
+					goto err_out2;
 				}
 				ksmbd_debug(SMB, "get posix context\n");
 
@@ -2864,7 +2857,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (ksmbd_override_fsids(work)) {
 		rc = -ENOMEM;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS,
@@ -3039,7 +3032,7 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
-	rc = ksmbd_query_inode_status(d_inode(path.dentry->d_parent));
+	rc = ksmbd_query_inode_status(path.dentry->d_parent);
 	if (rc == KSMBD_INODE_STATUS_PENDING_DELETE) {
 		rc = -EBUSY;
 		goto err_out;
@@ -3177,11 +3170,6 @@ int smb2_open(struct ksmbd_work *work)
 
 	fp->attrib_only = !(req->DesiredAccess & ~(FILE_READ_ATTRIBUTES_LE |
 			FILE_WRITE_ATTRIBUTES_LE | FILE_SYNCHRONIZE_LE));
-	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
-	    !fp->attrib_only && !stream_name) {
-		smb_break_all_oplock(work, fp);
-		need_truncate = 1;
-	}
 
 	/* fp should be searchable through ksmbd_inode.m_fp_list
 	 * after daccess, saccess, attrib_only, and stream are
@@ -3197,23 +3185,60 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out;
 	}
 
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc)
+		goto err_out;
+
+	if (stat.result_mask & STATX_BTIME)
+		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
+	else
+		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
+	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
+		fp->f_ci->m_fattr =
+			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
+
+	if (!created)
+		smb2_update_xattrs(tcon, &path, fp);
+	else
+		smb2_new_xattrs(tcon, &path, fp);
+
+	if (file_present || created)
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
+	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
+	    !fp->attrib_only && !stream_name) {
+		smb_break_all_oplock(work, fp);
+		need_truncate = 1;
+	}
+
+	req_op_level = req->RequestedOplockLevel;
+	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
+		lc = parse_lease_state(req, S_ISDIR(file_inode(filp)->i_mode));
+
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
 	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
 	     !(conn->vals->capabilities & SMB2_GLOBAL_CAP_LEASING))) {
 		if (share_ret < 0 && !S_ISDIR(file_inode(fp->filp)->i_mode)) {
 			rc = share_ret;
-			goto err_out;
+			goto err_out1;
 		}
 	} else {
 		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+			/*
+			 * Compare parent lease using parent key. If there is no
+			 * a lease that has same parent key, Send lease break
+			 * notification.
+			 */
+			smb_send_parent_lease_break_noti(fp, lc);
+
 			req_op_level = smb2_map_lease_to_oplock(lc->req_state);
 			ksmbd_debug(SMB,
 				    "lease req for(%s) req oplock state 0x%x, lease state 0x%x\n",
 				    name, req_op_level, lc->req_state);
 			rc = find_same_lease_key(sess, fp->f_ci, lc);
 			if (rc)
-				goto err_out;
+				goto err_out1;
 		} else if (open_flags == O_RDONLY &&
 			   (req_op_level == SMB2_OPLOCK_LEVEL_BATCH ||
 			    req_op_level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))
@@ -3224,12 +3249,18 @@ int smb2_open(struct ksmbd_work *work)
 				      le32_to_cpu(req->hdr.Id.SyncId.TreeId),
 				      lc, share_ret);
 		if (rc < 0)
-			goto err_out;
+			goto err_out1;
 	}
 
 	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)
 		ksmbd_fd_set_delete_on_close(fp, file_info);
 
+	if (need_truncate) {
+		rc = smb2_create_truncate(&fp->filp->f_path);
+		if (rc)
+			goto err_out1;
+	}
+
 	if (req->CreateContextsOffset) {
 		struct create_alloc_size_req *az_req;
 
@@ -3237,7 +3268,7 @@ int smb2_open(struct ksmbd_work *work)
 					SMB2_CREATE_ALLOCATION_SIZE, 4);
 		if (IS_ERR(az_req)) {
 			rc = PTR_ERR(az_req);
-			goto err_out;
+			goto err_out1;
 		} else if (az_req) {
 			loff_t alloc_size;
 			int err;
@@ -3246,7 +3277,7 @@ int smb2_open(struct ksmbd_work *work)
 			    le32_to_cpu(az_req->ccontext.DataLength) <
 			    sizeof(struct create_alloc_size_req)) {
 				rc = -EINVAL;
-				goto err_out;
+				goto err_out1;
 			}
 			alloc_size = le64_to_cpu(az_req->AllocationSize);
 			ksmbd_debug(SMB,
@@ -3264,30 +3295,13 @@ int smb2_open(struct ksmbd_work *work)
 		context = smb2_find_context_vals(req, SMB2_CREATE_QUERY_ON_DISK_ID, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out;
+			goto err_out1;
 		} else if (context) {
 			ksmbd_debug(SMB, "get query on disk id context\n");
 			query_disk_id = 1;
 		}
 	}
 
-	rc = ksmbd_vfs_getattr(&path, &stat);
-	if (rc)
-		goto err_out;
-
-	if (stat.result_mask & STATX_BTIME)
-		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
-	else
-		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
-	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
-		fp->f_ci->m_fattr =
-			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
-
-	if (!created)
-		smb2_update_xattrs(tcon, &path, fp);
-	else
-		smb2_new_xattrs(tcon, &path, fp);
-
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
 	rsp->StructureSize = cpu_to_le16(89);
@@ -3394,14 +3408,13 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 err_out:
-	if (file_present || created)
+	if (rc && (file_present || created))
 		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
-	if (fp && need_truncate)
-		rc = smb2_create_truncate(&fp->filp->f_path);
-
-	ksmbd_revert_fsids(work);
 err_out1:
+	ksmbd_revert_fsids(work);
+
+err_out2:
 	if (!rc) {
 		ksmbd_update_fstate(&work->sess->file_table, fp, FP_INITED);
 		rc = ksmbd_iov_pin_rsp(work, (void *)rsp, iov_len);
@@ -8206,6 +8219,11 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 			    le32_to_cpu(req->LeaseState));
 	}
 
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
 	lease_state = lease->state;
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
@@ -8213,11 +8231,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	wake_up_interruptible_all(&opinfo->oplock_brk);
 	opinfo_put(opinfo);
 
-	if (ret < 0) {
-		rsp->hdr.Status = err;
-		goto err_out;
-	}
-
 	rsp->StructureSize = cpu_to_le16(36);
 	rsp->Reserved = 0;
 	rsp->Flags = 0;
@@ -8229,7 +8242,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 		return;
 
 err_out:
-	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 3b269e1f523a..c5629a68c8b7 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2140,8 +2140,7 @@ static int smb_direct_ib_client_add(struct ib_device *ib_dev)
 	if (ib_dev->node_type != RDMA_NODE_IB_CA)
 		smb_direct_port = SMB_DIRECT_PORT_IWARP;
 
-	if (!ib_dev->ops.get_netdev ||
-	    !rdma_frwr_is_supported(&ib_dev->attrs))
+	if (!rdma_frwr_is_supported(&ib_dev->attrs))
 		return 0;
 
 	smb_dev = kzalloc(sizeof(*smb_dev), GFP_KERNEL);
@@ -2241,17 +2240,38 @@ bool ksmbd_rdma_capable_netdev(struct net_device *netdev)
 		for (i = 0; i < smb_dev->ib_dev->phys_port_cnt; i++) {
 			struct net_device *ndev;
 
-			ndev = smb_dev->ib_dev->ops.get_netdev(smb_dev->ib_dev,
-							       i + 1);
-			if (!ndev)
-				continue;
+			if (smb_dev->ib_dev->ops.get_netdev) {
+				ndev = smb_dev->ib_dev->ops.get_netdev(
+					smb_dev->ib_dev, i + 1);
+				if (!ndev)
+					continue;
 
-			if (ndev == netdev) {
+				if (ndev == netdev) {
+					dev_put(ndev);
+					rdma_capable = true;
+					goto out;
+				}
 				dev_put(ndev);
-				rdma_capable = true;
-				goto out;
+			/* if ib_dev does not implement ops.get_netdev
+			 * check for matching infiniband GUID in hw_addr
+			 */
+			} else if (netdev->type == ARPHRD_INFINIBAND) {
+				struct netdev_hw_addr *ha;
+				union ib_gid gid;
+				u32 port_num;
+				int ret;
+
+				netdev_hw_addr_list_for_each(
+					ha, &netdev->dev_addrs) {
+					memcpy(&gid, ha->addr + 4, sizeof(gid));
+					ret = ib_find_gid(smb_dev->ib_dev, &gid,
+							  &port_num, NULL);
+					if (!ret) {
+						rdma_capable = true;
+						goto out;
+					}
+				}
 			}
-			dev_put(ndev);
 		}
 	}
 out:
diff --git a/fs/smb/server/unicode.c b/fs/smb/server/unicode.c
index 393dd4a7432b..43ed29ee44ea 100644
--- a/fs/smb/server/unicode.c
+++ b/fs/smb/server/unicode.c
@@ -13,46 +13,10 @@
 #include "unicode.h"
 #include "smb_common.h"
 
-/*
- * smb_utf16_bytes() - how long will a string be after conversion?
- * @from:	pointer to input string
- * @maxbytes:	don't go past this many bytes of input string
- * @codepage:	destination codepage
- *
- * Walk a utf16le string and return the number of bytes that the string will
- * be after being converted to the given charset, not including any null
- * termination required. Don't walk past maxbytes in the source buffer.
- *
- * Return:	string length after conversion
- */
-static int smb_utf16_bytes(const __le16 *from, int maxbytes,
-			   const struct nls_table *codepage)
-{
-	int i;
-	int charlen, outlen = 0;
-	int maxwords = maxbytes / 2;
-	char tmp[NLS_MAX_CHARSET_SIZE];
-	__u16 ftmp;
-
-	for (i = 0; i < maxwords; i++) {
-		ftmp = get_unaligned_le16(&from[i]);
-		if (ftmp == 0)
-			break;
-
-		charlen = codepage->uni2char(ftmp, tmp, NLS_MAX_CHARSET_SIZE);
-		if (charlen > 0)
-			outlen += charlen;
-		else
-			outlen++;
-	}
-
-	return outlen;
-}
-
 /*
  * cifs_mapchar() - convert a host-endian char to proper char in codepage
  * @target:	where converted character should be copied
- * @src_char:	2 byte host-endian source character
+ * @from:	host-endian source string
  * @cp:		codepage to which character should be converted
  * @mapchar:	should character be mapped according to mapchars mount option?
  *
@@ -63,10 +27,13 @@ static int smb_utf16_bytes(const __le16 *from, int maxbytes,
  * Return:	string length after conversion
  */
 static int
-cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
+cifs_mapchar(char *target, const __u16 *from, const struct nls_table *cp,
 	     bool mapchar)
 {
 	int len = 1;
+	__u16 src_char;
+
+	src_char = *from;
 
 	if (!mapchar)
 		goto cp_convert;
@@ -104,12 +71,66 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
 
 cp_convert:
 	len = cp->uni2char(src_char, target, NLS_MAX_CHARSET_SIZE);
-	if (len <= 0) {
-		*target = '?';
-		len = 1;
-	}
+	if (len <= 0)
+		goto surrogate_pair;
 
 	goto out;
+
+surrogate_pair:
+	/* convert SURROGATE_PAIR and IVS */
+	if (strcmp(cp->charset, "utf8"))
+		goto unknown;
+	len = utf16s_to_utf8s(from, 3, UTF16_LITTLE_ENDIAN, target, 6);
+	if (len <= 0)
+		goto unknown;
+	return len;
+
+unknown:
+	*target = '?';
+	len = 1;
+	goto out;
+}
+
+/*
+ * smb_utf16_bytes() - compute converted string length
+ * @from:	pointer to input string
+ * @maxbytes:	input string length
+ * @codepage:	destination codepage
+ *
+ * Walk a utf16le string and return the number of bytes that the string will
+ * be after being converted to the given charset, not including any null
+ * termination required. Don't walk past maxbytes in the source buffer.
+ *
+ * Return:	string length after conversion
+ */
+static int smb_utf16_bytes(const __le16 *from, int maxbytes,
+			   const struct nls_table *codepage)
+{
+	int i, j;
+	int charlen, outlen = 0;
+	int maxwords = maxbytes / 2;
+	char tmp[NLS_MAX_CHARSET_SIZE];
+	__u16 ftmp[3];
+
+	for (i = 0; i < maxwords; i++) {
+		ftmp[0] = get_unaligned_le16(&from[i]);
+		if (ftmp[0] == 0)
+			break;
+		for (j = 1; j <= 2; j++) {
+			if (i + j < maxwords)
+				ftmp[j] = get_unaligned_le16(&from[i + j]);
+			else
+				ftmp[j] = 0;
+		}
+
+		charlen = cifs_mapchar(tmp, ftmp, codepage, 0);
+		if (charlen > 0)
+			outlen += charlen;
+		else
+			outlen++;
+	}
+
+	return outlen;
 }
 
 /*
@@ -139,12 +160,12 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
 static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 			  const struct nls_table *codepage, bool mapchar)
 {
-	int i, charlen, safelen;
+	int i, j, charlen, safelen;
 	int outlen = 0;
 	int nullsize = nls_nullsize(codepage);
 	int fromwords = fromlen / 2;
 	char tmp[NLS_MAX_CHARSET_SIZE];
-	__u16 ftmp;
+	__u16 ftmp[3];	/* ftmp[3] = 3array x 2bytes = 6bytes UTF-16 */
 
 	/*
 	 * because the chars can be of varying widths, we need to take care
@@ -155,9 +176,15 @@ static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 	safelen = tolen - (NLS_MAX_CHARSET_SIZE + nullsize);
 
 	for (i = 0; i < fromwords; i++) {
-		ftmp = get_unaligned_le16(&from[i]);
-		if (ftmp == 0)
+		ftmp[0] = get_unaligned_le16(&from[i]);
+		if (ftmp[0] == 0)
 			break;
+		for (j = 1; j <= 2; j++) {
+			if (i + j < fromwords)
+				ftmp[j] = get_unaligned_le16(&from[i + j]);
+			else
+				ftmp[j] = 0;
+		}
 
 		/*
 		 * check to see if converting this character might make the
@@ -172,6 +199,19 @@ static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 		/* put converted char into 'to' buffer */
 		charlen = cifs_mapchar(&to[outlen], ftmp, codepage, mapchar);
 		outlen += charlen;
+
+		/*
+		 * charlen (=bytes of UTF-8 for 1 character)
+		 * 4bytes UTF-8(surrogate pair) is charlen=4
+		 * (4bytes UTF-16 code)
+		 * 7-8bytes UTF-8(IVS) is charlen=3+4 or 4+4
+		 * (2 UTF-8 pairs divided to 2 UTF-16 pairs)
+		 */
+		if (charlen == 4)
+			i++;
+		else if (charlen >= 5)
+			/* 5-6bytes UTF-8 */
+			i += 2;
 	}
 
 	/* properly null-terminate string */
@@ -306,6 +346,9 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 	char src_char;
 	__le16 dst_char;
 	wchar_t tmp;
+	wchar_t wchar_to[6];	/* UTF-16 */
+	int ret;
+	unicode_t u;
 
 	if (!mapchars)
 		return smb_strtoUTF16(target, source, srclen, cp);
@@ -348,11 +391,57 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 			 * if no match, use question mark, which at least in
 			 * some cases serves as wild card
 			 */
-			if (charlen < 1) {
-				dst_char = cpu_to_le16(0x003f);
-				charlen = 1;
+			if (charlen > 0)
+				goto ctoUTF16;
+
+			/* convert SURROGATE_PAIR */
+			if (strcmp(cp->charset, "utf8"))
+				goto unknown;
+			if (*(source + i) & 0x80) {
+				charlen = utf8_to_utf32(source + i, 6, &u);
+				if (charlen < 0)
+					goto unknown;
+			} else
+				goto unknown;
+			ret  = utf8s_to_utf16s(source + i, charlen,
+					UTF16_LITTLE_ENDIAN,
+					wchar_to, 6);
+			if (ret < 0)
+				goto unknown;
+
+			i += charlen;
+			dst_char = cpu_to_le16(*wchar_to);
+			if (charlen <= 3)
+				/* 1-3bytes UTF-8 to 2bytes UTF-16 */
+				put_unaligned(dst_char, &target[j]);
+			else if (charlen == 4) {
+				/*
+				 * 4bytes UTF-8(surrogate pair) to 4bytes UTF-16
+				 * 7-8bytes UTF-8(IVS) divided to 2 UTF-16
+				 * (charlen=3+4 or 4+4)
+				 */
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 1));
+				j++;
+				put_unaligned(dst_char, &target[j]);
+			} else if (charlen >= 5) {
+				/* 5-6bytes UTF-8 to 6bytes UTF-16 */
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 1));
+				j++;
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 2));
+				j++;
+				put_unaligned(dst_char, &target[j]);
 			}
+			continue;
+
+unknown:
+			dst_char = cpu_to_le16(0x003f);
+			charlen = 1;
 		}
+
+ctoUTF16:
 		/*
 		 * character may take more than one byte in the source string,
 		 * but will take exactly two bytes in the target string
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 5a41c0b4e933..4277750a6da1 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -517,6 +517,9 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		}
 	}
 
+	/* Reserve lease break for parent dir at closing time */
+	fp->reserve_lease_break = true;
+
 	/* Do we need to break any of a levelII oplock? */
 	smb_break_all_levII_oplock(work, fp, 1);
 
@@ -719,7 +722,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out3;
 	}
 
-	parent_fp = ksmbd_lookup_fd_inode(d_inode(old_child->d_parent));
+	parent_fp = ksmbd_lookup_fd_inode(old_child->d_parent);
 	if (parent_fp) {
 		if (parent_fp->daccess & FILE_DELETE_LE) {
 			pr_err("parent dir is opened with delete access\n");
@@ -906,7 +909,7 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 /**
  * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
  * @idmap:	idmap of the relevant mount
- * @dentry:	dentry to set XATTR at
+ * @path:	path of dentry to set XATTR at
  * @attr_name:	xattr name for setxattr
  * @attr_value:	xattr value to set
  * @attr_size:	size of xattr value
@@ -1186,9 +1189,10 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
 
 /**
  * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
- * @name:	file path that is relative to share
- * @flags:	lookup flags
- * @path:	if lookup succeed, return path info
+ * @name:		file path that is relative to share
+ * @flags:		lookup flags
+ * @parent_path:	if lookup succeed, return parent_path info
+ * @path:		if lookup succeed, return path info
  * @caseless:	caseless filename lookup
  *
  * Return:	0 on success, otherwise error
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index c91eac6514dd..4e82ff627d12 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -66,14 +66,14 @@ static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
 	return tmp & inode_hash_mask;
 }
 
-static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
+static struct ksmbd_inode *__ksmbd_inode_lookup(struct dentry *de)
 {
 	struct hlist_head *head = inode_hashtable +
-		inode_hash(inode->i_sb, inode->i_ino);
+		inode_hash(d_inode(de)->i_sb, (unsigned long)de);
 	struct ksmbd_inode *ci = NULL, *ret_ci = NULL;
 
 	hlist_for_each_entry(ci, head, m_hash) {
-		if (ci->m_inode == inode) {
+		if (ci->m_de == de) {
 			if (atomic_inc_not_zero(&ci->m_count))
 				ret_ci = ci;
 			break;
@@ -84,26 +84,27 @@ static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
 
 static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
 {
-	return __ksmbd_inode_lookup(file_inode(fp->filp));
+	return __ksmbd_inode_lookup(fp->filp->f_path.dentry);
 }
 
-static struct ksmbd_inode *ksmbd_inode_lookup_by_vfsinode(struct inode *inode)
+struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d)
 {
 	struct ksmbd_inode *ci;
 
 	read_lock(&inode_hash_lock);
-	ci = __ksmbd_inode_lookup(inode);
+	ci = __ksmbd_inode_lookup(d);
 	read_unlock(&inode_hash_lock);
+
 	return ci;
 }
 
-int ksmbd_query_inode_status(struct inode *inode)
+int ksmbd_query_inode_status(struct dentry *dentry)
 {
 	struct ksmbd_inode *ci;
 	int ret = KSMBD_INODE_STATUS_UNKNOWN;
 
 	read_lock(&inode_hash_lock);
-	ci = __ksmbd_inode_lookup(inode);
+	ci = __ksmbd_inode_lookup(dentry);
 	if (ci) {
 		ret = KSMBD_INODE_STATUS_OK;
 		if (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS))
@@ -143,7 +144,7 @@ void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
 static void ksmbd_inode_hash(struct ksmbd_inode *ci)
 {
 	struct hlist_head *b = inode_hashtable +
-		inode_hash(ci->m_inode->i_sb, ci->m_inode->i_ino);
+		inode_hash(d_inode(ci->m_de)->i_sb, (unsigned long)ci->m_de);
 
 	hlist_add_head(&ci->m_hash, b);
 }
@@ -157,7 +158,6 @@ static void ksmbd_inode_unhash(struct ksmbd_inode *ci)
 
 static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 {
-	ci->m_inode = file_inode(fp->filp);
 	atomic_set(&ci->m_count, 1);
 	atomic_set(&ci->op_count, 0);
 	atomic_set(&ci->sop_count, 0);
@@ -166,6 +166,7 @@ static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 	INIT_LIST_HEAD(&ci->m_fp_list);
 	INIT_LIST_HEAD(&ci->m_op_list);
 	rwlock_init(&ci->m_lock);
+	ci->m_de = fp->filp->f_path.dentry;
 	return 0;
 }
 
@@ -209,7 +210,7 @@ static void ksmbd_inode_free(struct ksmbd_inode *ci)
 	kfree(ci);
 }
 
-static void ksmbd_inode_put(struct ksmbd_inode *ci)
+void ksmbd_inode_put(struct ksmbd_inode *ci)
 {
 	if (atomic_dec_and_test(&ci->m_count))
 		ksmbd_inode_free(ci);
@@ -488,12 +489,15 @@ struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)
 	return fp;
 }
 
-struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry)
 {
 	struct ksmbd_file	*lfp;
 	struct ksmbd_inode	*ci;
+	struct inode		*inode = d_inode(dentry);
 
-	ci = ksmbd_inode_lookup_by_vfsinode(inode);
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(dentry);
+	read_unlock(&inode_hash_lock);
 	if (!ci)
 		return NULL;
 
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 03d0bf941216..a528f0cc775a 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -51,7 +51,7 @@ struct ksmbd_inode {
 	atomic_t			op_count;
 	/* opinfo count for streams */
 	atomic_t			sop_count;
-	struct inode			*m_inode;
+	struct dentry			*m_de;
 	unsigned int			m_flags;
 	struct hlist_node		m_hash;
 	struct list_head		m_fp_list;
@@ -105,6 +105,7 @@ struct ksmbd_file {
 	struct ksmbd_readdir_data	readdir_data;
 	int				dot_dotdot[2];
 	unsigned int			f_state;
+	bool				reserve_lease_break;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -138,9 +139,11 @@ struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 					u64 pid);
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
+struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d);
+void ksmbd_inode_put(struct ksmbd_inode *ci);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
-struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode);
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
 unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp);
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work);
@@ -164,7 +167,7 @@ enum KSMBD_INODE_STATUS {
 	KSMBD_INODE_STATUS_PENDING_DELETE,
 };
 
-int ksmbd_query_inode_status(struct inode *inode);
+int ksmbd_query_inode_status(struct dentry *dentry);
 bool ksmbd_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..f59fcd5b499a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -538,7 +538,7 @@ struct request_queue {
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
-#define QUEUE_FLAG_HW_WC	18	/* Write back caching supported */
+#define QUEUE_FLAG_HW_WC	13	/* Write back caching supported */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
 #define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
 #define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 45fca09b2319..528019477734 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -16,10 +16,13 @@
  * and eliminates the need for absolute relocations that require runtime
  * processing on relocatable kernels.
  */
+#define __KSYM_ALIGN		".balign 4"
 #define __KSYM_REF(sym)		".long " #sym "- ."
 #elif defined(CONFIG_64BIT)
+#define __KSYM_ALIGN		".balign 8"
 #define __KSYM_REF(sym)		".quad " #sym
 #else
+#define __KSYM_ALIGN		".balign 4"
 #define __KSYM_REF(sym)		".long " #sym
 #endif
 
@@ -42,7 +45,7 @@
 	    "	.asciz \"" ns "\""					"\n"	\
 	    "	.previous"						"\n"	\
 	    "	.section \"___ksymtab" sec "+" #name "\", \"a\""	"\n"	\
-	    "	.balign	4"						"\n"	\
+		__KSYM_ALIGN						"\n"	\
 	    "__ksymtab_" #name ":"					"\n"	\
 		__KSYM_REF(sym)						"\n"	\
 		__KSYM_REF(__kstrtab_ ##name)				"\n"	\
@@ -63,6 +66,7 @@
 
 #define SYMBOL_CRC(sym, crc, sec)   \
 	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
+	    ".balign 4"						"\n" \
 	    "__crc_" #sym ":"					"\n" \
 	    ".long " #crc					"\n" \
 	    ".previous"						"\n")
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4a40823c3c67..d08b97dacd2d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1511,24 +1511,81 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 struct timespec64 current_time(struct inode *inode);
 struct timespec64 inode_set_ctime_current(struct inode *inode);
 
-/**
- * inode_get_ctime - fetch the current ctime from the inode
- * @inode: inode from which to fetch ctime
- *
- * Grab the current ctime from the inode and return it.
- */
+static inline time64_t inode_get_atime_sec(const struct inode *inode)
+{
+	return inode->i_atime.tv_sec;
+}
+
+static inline long inode_get_atime_nsec(const struct inode *inode)
+{
+	return inode->i_atime.tv_nsec;
+}
+
+static inline struct timespec64 inode_get_atime(const struct inode *inode)
+{
+	return inode->i_atime;
+}
+
+static inline struct timespec64 inode_set_atime_to_ts(struct inode *inode,
+						      struct timespec64 ts)
+{
+	inode->i_atime = ts;
+	return ts;
+}
+
+static inline struct timespec64 inode_set_atime(struct inode *inode,
+						time64_t sec, long nsec)
+{
+	struct timespec64 ts = { .tv_sec  = sec,
+				 .tv_nsec = nsec };
+	return inode_set_atime_to_ts(inode, ts);
+}
+
+static inline time64_t inode_get_mtime_sec(const struct inode *inode)
+{
+	return inode->i_mtime.tv_sec;
+}
+
+static inline long inode_get_mtime_nsec(const struct inode *inode)
+{
+	return inode->i_mtime.tv_nsec;
+}
+
+static inline struct timespec64 inode_get_mtime(const struct inode *inode)
+{
+	return inode->i_mtime;
+}
+
+static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inode,
+						      struct timespec64 ts)
+{
+	inode->i_mtime = ts;
+	return ts;
+}
+
+static inline struct timespec64 inode_set_mtime(struct inode *inode,
+						time64_t sec, long nsec)
+{
+	struct timespec64 ts = { .tv_sec  = sec,
+				 .tv_nsec = nsec };
+	return inode_set_mtime_to_ts(inode, ts);
+}
+
+static inline time64_t inode_get_ctime_sec(const struct inode *inode)
+{
+	return inode->__i_ctime.tv_sec;
+}
+
+static inline long inode_get_ctime_nsec(const struct inode *inode)
+{
+	return inode->__i_ctime.tv_nsec;
+}
+
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 {
 	return inode->__i_ctime;
 }
 
-/**
- * inode_set_ctime_to_ts - set the ctime in the inode
- * @inode: inode in which to set the ctime
- * @ts: value to set in the ctime field
- *
- * Set the ctime in @inode to @ts
- */
 static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
@@ -1553,6 +1610,8 @@ static inline struct timespec64 inode_set_ctime(struct inode *inode,
 	return inode_set_ctime_to_ts(inode, ts);
 }
 
+struct timespec64 simple_inode_init_ts(struct inode *inode);
+
 /*
  * Snapshotting support.
  */
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index f9619ac6b71d..37e488d5b4fc 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -36,6 +36,8 @@ config KEXEC
 config KEXEC_FILE
 	bool "Enable kexec file based system call"
 	depends on ARCH_SUPPORTS_KEXEC_FILE
+	select CRYPTO
+	select CRYPTO_SHA256
 	select KEXEC_CORE
 	help
 	  This is new version of kexec system call. This system call is
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..b01ae7d36021 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1183,18 +1183,19 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 	hash->count++;
 }
 
-static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+static struct ftrace_func_entry *
+add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-		return -ENOMEM;
+		return NULL;
 
 	entry->ip = ip;
 	__add_hash_entry(hash, entry);
 
-	return 0;
+	return entry;
 }
 
 static void
@@ -1349,7 +1350,6 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *new_hash;
 	int size;
-	int ret;
 	int i;
 
 	new_hash = alloc_ftrace_hash(size_bits);
@@ -1366,8 +1366,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			ret = add_hash_entry(new_hash, entry->ip);
-			if (ret < 0)
+			if (add_hash_entry(new_hash, entry->ip) == NULL)
 				goto free_hash;
 		}
 	}
@@ -2536,7 +2535,7 @@ ftrace_find_unique_ops(struct dyn_ftrace *rec)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /* Protected by rcu_tasks for reading, and direct_mutex for writing */
-static struct ftrace_hash *direct_functions = EMPTY_HASH;
+static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
 static DEFINE_MUTEX(direct_mutex);
 int ftrace_direct_func_count;
 
@@ -2555,39 +2554,6 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 	return entry->direct;
 }
 
-static struct ftrace_func_entry*
-ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
-		      struct ftrace_hash **free_hash)
-{
-	struct ftrace_func_entry *entry;
-
-	if (ftrace_hash_empty(direct_functions) ||
-	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
-		struct ftrace_hash *new_hash;
-		int size = ftrace_hash_empty(direct_functions) ? 0 :
-			direct_functions->count + 1;
-
-		if (size < 32)
-			size = 32;
-
-		new_hash = dup_hash(direct_functions, size);
-		if (!new_hash)
-			return NULL;
-
-		*free_hash = direct_functions;
-		direct_functions = new_hash;
-	}
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return NULL;
-
-	entry->ip = ip;
-	entry->direct = addr;
-	__add_hash_entry(direct_functions, entry);
-	return entry;
-}
-
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
@@ -4223,8 +4189,8 @@ enter_record(struct ftrace_hash *hash, struct dyn_ftrace *rec, int clear_filter)
 		/* Do nothing if it exists */
 		if (entry)
 			return 0;
-
-		ret = add_hash_entry(hash, rec->ip);
+		if (add_hash_entry(hash, rec->ip) == NULL)
+			ret = -ENOMEM;
 	}
 	return ret;
 }
@@ -5266,7 +5232,8 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 		return 0;
 	}
 
-	return add_hash_entry(hash, ip);
+	entry = add_hash_entry(hash, ip);
+	return entry ? 0 :  -ENOMEM;
 }
 
 static int
@@ -5410,7 +5377,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
  */
 int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
-	struct ftrace_hash *hash, *free_hash = NULL;
+	struct ftrace_hash *hash, *new_hash = NULL, *free_hash = NULL;
 	struct ftrace_func_entry *entry, *new;
 	int err = -EBUSY, size, i;
 
@@ -5436,17 +5403,44 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		}
 	}
 
-	/* ... and insert them to direct_functions hash. */
 	err = -ENOMEM;
+
+	/* Make a copy hash to place the new and the old entries in */
+	size = hash->count + direct_functions->count;
+	if (size > 32)
+		size = 32;
+	new_hash = alloc_ftrace_hash(fls(size));
+	if (!new_hash)
+		goto out_unlock;
+
+	/* Now copy over the existing direct entries */
+	size = 1 << direct_functions->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &direct_functions->buckets[i], hlist) {
+			new = add_hash_entry(new_hash, entry->ip);
+			if (!new)
+				goto out_unlock;
+			new->direct = entry->direct;
+		}
+	}
+
+	/* ... and add the new entries */
+	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
+			new = add_hash_entry(new_hash, entry->ip);
 			if (!new)
-				goto out_remove;
+				goto out_unlock;
+			/* Update both the copy and the hash entry */
+			new->direct = addr;
 			entry->direct = addr;
 		}
 	}
 
+	free_hash = direct_functions;
+	rcu_assign_pointer(direct_functions, new_hash);
+	new_hash = NULL;
+
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
@@ -5454,17 +5448,17 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	err = register_ftrace_function_nolock(ops);
 
- out_remove:
-	if (err)
-		remove_direct_functions_hash(hash, addr);
-
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
-	if (free_hash) {
+	if (free_hash && free_hash != EMPTY_HASH) {
 		synchronize_rcu_tasks();
 		free_ftrace_hash(free_hash);
 	}
+
+	if (new_hash)
+		free_ftrace_hash(new_hash);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
@@ -6309,7 +6303,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 
 				if (entry)
 					continue;
-				if (add_hash_entry(hash, rec->ip) < 0)
+				if (add_hash_entry(hash, rec->ip) == NULL)
 					goto out;
 			} else {
 				if (entry) {
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 783a500e89c5..901a140e30fa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -881,9 +881,14 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
 	if (!nr_pages || !full)
 		return true;
 
-	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+	/*
+	 * Add one as dirty will never equal nr_pages, as the sub-buffer
+	 * that the writer is on is not counted as dirty.
+	 * This is needed if "buffer_percent" is set to 100.
+	 */
+	dirty = ring_buffer_nr_dirty_pages(buffer, cpu) + 1;
 
-	return (dirty * 100) > (full * nr_pages);
+	return (dirty * 100) >= (full * nr_pages);
 }
 
 /*
@@ -944,7 +949,8 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	/* make sure the waiters see the new index */
 	smp_wmb();
 
-	rb_wake_up_waiters(&rbwork->work);
+	/* This can be called in any context */
+	irq_work_queue(&rbwork->work);
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3664b803623..a55f7d091355 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1893,6 +1893,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 	__update_max_tr(tr, tsk, cpu);
 
 	arch_spin_unlock(&tr->max_lock);
+
+	/* Any waiters on the old snapshot buffer need to wake up */
+	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
 }
 
 /**
@@ -1944,12 +1947,23 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
+	int ret;
+
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return 0;
 
-	return ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file,
-				full);
+	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	/*
+	 * Make sure this is still the snapshot buffer, as if a snapshot were
+	 * to happen, this would now be the main buffer.
+	 */
+	if (iter->snapshot)
+		iter->array_buffer = &iter->tr->max_buffer;
+#endif
+	return ret;
 }
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
@@ -8514,7 +8528,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		wait_index = READ_ONCE(iter->wait_index);
 
-		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
+		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922..684689457d77 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5501,6 +5501,17 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 
 	mas_wr_end_piv(&wr_mas);
 	node_size = mas_wr_new_end(&wr_mas);
+
+	/* Slot store, does not require additional nodes */
+	if (node_size == wr_mas.node_end) {
+		/* reuse node */
+		if (!mt_in_rcu(mas->tree))
+			return 0;
+		/* shifting boundary */
+		if (wr_mas.offset_end - mas->offset == 1)
+			return 0;
+	}
+
 	if (node_size >= mt_slots[wr_mas.type]) {
 		/* Split, worst case for now. */
 		request = 1 + mas_mt_height(mas) * 2;
diff --git a/mm/filemap.c b/mm/filemap.c
index d40a20c9d59f..b1ef7be1205b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2666,6 +2666,15 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			goto put_folios;
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
+		/*
+		 * Pairs with a barrier in
+		 * block_write_end()->mark_buffer_dirty() or other page
+		 * dirtying routines like iomap_write_end() to ensure
+		 * changes to page contents are visible before we see
+		 * increased inode size.
+		 */
+		smp_rmb();
+
 		/*
 		 * Once we start copying data, we don't want to be touching any
 		 * cachelines that might be contended:
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4d6e43c88489..16e002e08cf8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1571,7 +1571,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(hpage))
+	if (!page_mapped(p))
 		return true;
 
 	if (PageSwapCache(p)) {
@@ -1622,10 +1622,10 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		try_to_unmap(folio, ttu);
 	}
 
-	unmap_success = !page_mapped(hpage);
+	unmap_success = !page_mapped(p);
 	if (!unmap_success)
 		pr_err("%#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(hpage));
+		       pfn, page_mapcount(p));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
@@ -1705,7 +1705,7 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 		 * mapping being torn down is communicated in siginfo, see
 		 * kill_proc()
 		 */
-		loff_t start = (index << PAGE_SHIFT) & ~(size - 1);
+		loff_t start = ((loff_t)index << PAGE_SHIFT) & ~(size - 1);
 
 		unmap_mapping_range(mapping, start, size, 0);
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 06086dc9da28..03bc2063ac87 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -405,6 +405,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	int dirty;
 	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
 	long nr = folio_nr_pages(folio);
+	long entries, i;
 
 	if (!mapping) {
 		/* Anonymous page without mapping */
@@ -442,8 +443,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 			folio_set_swapcache(newfolio);
 			newfolio->private = folio_get_private(folio);
 		}
+		entries = nr;
 	} else {
 		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
+		entries = 1;
 	}
 
 	/* Move dirty while page refs frozen and newpage not yet exposed */
@@ -453,7 +456,11 @@ int folio_migrate_mapping(struct address_space *mapping,
 		folio_set_dirty(newfolio);
 	}
 
-	xas_store(&xas, newfolio);
+	/* Swap cache still stores N entries instead of a high-order entry */
+	for (i = 0; i < entries; i++) {
+		xas_store(&xas, newfolio);
+		xas_next(&xas);
+	}
 
 	/*
 	 * Drop cache reference from old page by unfreezing
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c1527f520dce..5c003a0f0fe5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -893,6 +893,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
 	mptcp_stop_tout_timer(sk);
+	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
 }
 
@@ -1079,15 +1080,16 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool first = true;
 
-	sk_stream_moderate_sndbuf(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (first)
 			tcp_enter_memory_pressure(ssk);
 		sk_stream_moderate_sndbuf(ssk);
+
 		first = false;
 	}
+	__mptcp_sync_sndbuf(sk);
 }
 
 /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
@@ -2452,6 +2454,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
+	__mptcp_sync_sndbuf(sk);
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 
@@ -3223,7 +3226,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	mptcp_propagate_sndbuf(nsk, ssk);
+	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	bh_unlock_sock(nsk);
@@ -3394,13 +3397,16 @@ static void mptcp_release_cb(struct sock *sk)
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
 	if (unlikely(msk->cb_flags)) {
-		/* be sure to set the current sk state before tacking actions
-		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
+		/* be sure to sync the msk state before taking actions
+		 * depending on sk_state (MPTCP_ERROR_REPORT)
+		 * On sk release avoid actions depending on the first subflow
 		 */
-		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
-			__mptcp_set_connected(sk);
+		if (__test_and_clear_bit(MPTCP_SYNC_STATE, &msk->cb_flags) && msk->first)
+			__mptcp_sync_state(sk, msk->pending_state);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
+		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
+			__mptcp_sync_sndbuf(sk);
 	}
 
 	__mptcp_update_rmem(sk);
@@ -3445,6 +3451,14 @@ void mptcp_subflow_process_delegated(struct sock *ssk, long status)
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
 	}
+	if (status & BIT(MPTCP_DELEGATE_SNDBUF)) {
+		mptcp_data_lock(sk);
+		if (!sock_owned_by_user(sk))
+			__mptcp_sync_sndbuf(sk);
+		else
+			__set_bit(MPTCP_SYNC_SNDBUF, &mptcp_sk(sk)->cb_flags);
+		mptcp_data_unlock(sk);
+	}
 	if (status & BIT(MPTCP_DELEGATE_ACK))
 		schedule_3rdack_retransmission(ssk);
 }
@@ -3529,6 +3543,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		mptcp_subflow_joined(msk, ssk);
+		mptcp_propagate_sndbuf(parent, ssk);
 		return true;
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3612545fa62e..07c5ac37d092 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -122,7 +122,8 @@
 #define MPTCP_ERROR_REPORT	3
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
-#define MPTCP_CONNECTED		6
+#define MPTCP_SYNC_STATE	6
+#define MPTCP_SYNC_SNDBUF	7
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -292,6 +293,9 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
+	u8		pending_state; /* A subflow asked to set this sk_state,
+					* protected by the msk data lock
+					*/
 	u8		mpc_endpoint_id;
 	u8		recvmsg_inq:1,
 			cork:1,
@@ -447,6 +451,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 #define MPTCP_DELEGATE_SCHEDULED	0
 #define MPTCP_DELEGATE_SEND		1
 #define MPTCP_DELEGATE_ACK		2
+#define MPTCP_DELEGATE_SNDBUF		3
 
 #define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
 /* MPTCP subflow context */
@@ -520,6 +525,9 @@ struct mptcp_subflow_context {
 
 	u32	setsockopt_seq;
 	u32	stale_rcv_tstamp;
+	int     cached_sndbuf;	    /* sndbuf size when last synced with the msk sndbuf,
+				     * protected by the msk socket lock
+				     */
 
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
@@ -706,7 +714,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
-void __mptcp_set_connected(struct sock *sk);
+void __mptcp_sync_state(struct sock *sk, int state);
 void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
 
 static inline void mptcp_stop_tout_timer(struct sock *sk)
@@ -762,13 +770,52 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
-static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+static inline void __mptcp_sync_sndbuf(struct sock *sk)
 {
-	if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <= READ_ONCE(sk->sk_sndbuf))
-		return false;
+	struct mptcp_subflow_context *subflow;
+	int ssk_sndbuf, new_sndbuf;
+
+	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+		return;
+
+	new_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[0];
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		ssk_sndbuf =  READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_sndbuf);
+
+		subflow->cached_sndbuf = ssk_sndbuf;
+		new_sndbuf += ssk_sndbuf;
+	}
+
+	/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
+	WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
+}
+
+/* The called held both the msk socket and the subflow socket locks,
+ * possibly under BH
+ */
+static inline void __mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	if (READ_ONCE(ssk->sk_sndbuf) != subflow->cached_sndbuf)
+		__mptcp_sync_sndbuf(sk);
+}
+
+/* the caller held only the subflow socket lock, either in process or
+ * BH context. Additionally this can be called under the msk data lock,
+ * so we can't acquire such lock here: let the delegate action acquires
+ * the needed locks in suitable order.
+ */
+static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	if (likely(READ_ONCE(ssk->sk_sndbuf) == subflow->cached_sndbuf))
+		return;
 
-	WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
-	return true;
+	local_bh_disable();
+	mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_SNDBUF);
+	local_bh_enable();
 }
 
 static inline void mptcp_write_space(struct sock *sk)
@@ -1057,7 +1104,7 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	return sk->sk_state == TCP_ESTABLISHED &&
+	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_FIN_WAIT1) &&
 	       is_active_ssk(subflow) &&
 	       !subflow->conn_finished;
 }
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 7539b9c8c2fb..116e3008231b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -95,6 +95,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		case SO_SNDBUFFORCE:
 			ssk->sk_userlocks |= SOCK_SNDBUF_LOCK;
 			WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
 			break;
 		case SO_RCVBUF:
 		case SO_RCVBUFFORCE:
@@ -1418,8 +1419,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-		if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+		if (sk->sk_userlocks & SOCK_SNDBUF_LOCK) {
 			WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
+		}
 		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9c1f8d1d63d2..f3a1e4aa0e5e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -419,21 +419,28 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 	return inet_sk(sk)->inet_dport != inet_sk((struct sock *)msk)->inet_dport;
 }
 
-void __mptcp_set_connected(struct sock *sk)
+void __mptcp_sync_state(struct sock *sk, int state)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	__mptcp_propagate_sndbuf(sk, msk->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
-		inet_sk_state_store(sk, TCP_ESTABLISHED);
+		inet_sk_state_store(sk, state);
 		sk->sk_state_change(sk);
 	}
 }
 
-static void mptcp_set_connected(struct sock *sk)
+static void mptcp_propagate_state(struct sock *sk, struct sock *ssk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
 	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk))
-		__mptcp_set_connected(sk);
-	else
-		__set_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->cb_flags);
+	if (!sock_owned_by_user(sk)) {
+		__mptcp_sync_state(sk, ssk->sk_state);
+	} else {
+		msk->pending_state = ssk->sk_state;
+		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
+	}
 	mptcp_data_unlock(sk);
 }
 
@@ -472,7 +479,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		return;
 
 	msk = mptcp_sk(parent);
-	mptcp_propagate_sndbuf(parent, sk);
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
@@ -496,7 +502,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow_set_remote_key(msk, subflow, &mp_opt);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
-		mptcp_set_connected(parent);
+		mptcp_propagate_state(parent, sk);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 
@@ -540,7 +546,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
 		mptcp_rcv_space_init(msk, sk);
-		mptcp_set_connected(parent);
+		mptcp_propagate_state(parent, sk);
 	}
 	return;
 
@@ -1728,12 +1734,11 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		mptcp_propagate_sndbuf(parent, sk);
 		mptcp_do_fallback(sk);
 		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
-		mptcp_set_connected(parent);
+		mptcp_propagate_state(parent, sk);
 	}
 
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fb5c62aa8d9c..5a14e1ab0b13 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9849,7 +9849,7 @@ static void nft_set_commit_update(struct list_head *set_update_list)
 	list_for_each_entry_safe(set, next, set_update_list, pending_update) {
 		list_del_init(&set->pending_update);
 
-		if (!set->ops->commit)
+		if (!set->ops->commit || set->dead)
 			continue;
 
 		set->ops->commit(set);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index e536c0b615a0..f0a3a2317638 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -299,6 +299,7 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
+	bool use_range_api;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[] __counted_by(n_rssi_thresholds);
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 931a03f4549c..0b0dfecedc50 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12824,10 +12824,6 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int i, n, low_index;
 	int err;
 
-	/* RSSI reporting disabled? */
-	if (!cqm_config)
-		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
-
 	/*
 	 * Obtain current RSSI value if possible, if not and no RSSI threshold
 	 * event has been received yet, we should receive an event after a
@@ -12902,18 +12898,6 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
-	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
-		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
-			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
-
-		return rdev_set_cqm_rssi_config(rdev, dev,
-						thresholds[0], hysteresis);
-	}
-
-	if (!wiphy_ext_feature_isset(&rdev->wiphy,
-				     NL80211_EXT_FEATURE_CQM_RSSI_LIST))
-		return -EOPNOTSUPP;
-
 	if (n_thresholds == 1 && thresholds[0] == 0) /* Disabling */
 		n_thresholds = 0;
 
@@ -12921,6 +12905,26 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	old = rcu_dereference_protected(wdev->cqm_config,
 					lockdep_is_held(&wdev->mtx));
 
+	/* if already disabled just succeed */
+	if (!n_thresholds && !old) {
+		err = 0;
+		goto unlock;
+	}
+
+	if (n_thresholds > 1) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
+		    !rdev->ops->set_cqm_rssi_range_config) {
+			err = -EOPNOTSUPP;
+			goto unlock;
+		}
+	} else {
+		if (!rdev->ops->set_cqm_rssi_config) {
+			err = -EOPNOTSUPP;
+			goto unlock;
+		}
+	}
+
 	if (n_thresholds) {
 		cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
 						 n_thresholds),
@@ -12935,13 +12939,26 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		memcpy(cqm_config->rssi_thresholds, thresholds,
 		       flex_array_size(cqm_config, rssi_thresholds,
 				       n_thresholds));
+		cqm_config->use_range_api = n_thresholds > 1 ||
+					    !rdev->ops->set_cqm_rssi_config;
 
 		rcu_assign_pointer(wdev->cqm_config, cqm_config);
+
+		if (cqm_config->use_range_api)
+			err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
+		else
+			err = rdev_set_cqm_rssi_config(rdev, dev,
+						       thresholds[0],
+						       hysteresis);
 	} else {
 		RCU_INIT_POINTER(wdev->cqm_config, NULL);
+		/* if enabled as range also disable via range */
+		if (old->use_range_api)
+			err = rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
+		else
+			err = rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
 	}
 
-	err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
 	if (err) {
 		rcu_assign_pointer(wdev->cqm_config, old);
 		kfree_rcu(cqm_config, rcu_head);
@@ -19131,10 +19148,11 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work *work)
 	wdev_lock(wdev);
 	cqm_config = rcu_dereference_protected(wdev->cqm_config,
 					       lockdep_is_held(&wdev->mtx));
-	if (!wdev->cqm_config)
+	if (!cqm_config)
 		goto unlock;
 
-	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
+	if (cqm_config->use_range_api)
+		cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
 
 	rssi_level = cqm_config->last_rssi_event_value;
 	rssi_event = cqm_config->last_rssi_event_type;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index e5da1cad70ba..76a8990bb14e 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35538,7 +35538,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1);
+	MT_BUG_ON(mt, allocated != 0);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 957b9e18c729..9b298f6a04b3 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -62,6 +62,9 @@ static void test_mlock_limit(int fd)
 	char *mem;
 
 	len = mlock_limit_cur;
+	if (len % page_size != 0)
+		len = (len/page_size) * page_size;
+
 	mem = mmap(NULL, len, prot, mode, fd, 0);
 	if (mem == MAP_FAILED) {
 		fail("unable to mmap secret memory\n");

