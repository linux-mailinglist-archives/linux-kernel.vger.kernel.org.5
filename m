Return-Path: <linux-kernel+bounces-22558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C0829FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661011C209BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17EB4D589;
	Wed, 10 Jan 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0zJ8OjV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989604D136;
	Wed, 10 Jan 2024 17:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C6FC433F1;
	Wed, 10 Jan 2024 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704908831;
	bh=kWTWVslC0us6v/fH5wzxwOq1KN7xgk4s6wJtON4hs/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0zJ8OjVwS6UWY4P9H3b8N4CuYs+tpkK/IMU6bEpEBvyI1qwbBTN68Q6wQpLUIOEn
	 33VIamGqRzbSWX+SBKsh84aJnDsnC3qFimTJkEQBVSIhT3aUu6Fb7y21a1csHYcNiJ
	 pPWxZ8ckHALu1Ppai1GYZ47PV0atL/Fa2RDg3mJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.11
Date: Wed, 10 Jan 2024 18:46:59 +0100
Message-ID: <2024011058-legal-name-9626@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024011058-sheep-thrower-d2f8@gregkh>
References: <2024011058-sheep-thrower-d2f8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 50a862316e15..43edafa7f262 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index cb63921232a6..6ec3445f3c72 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -807,12 +807,12 @@ static int __init sunxi_mc_smp_init(void)
 			break;
 	}
 
-	is_a83t = sunxi_mc_smp_data[i].is_a83t;
-
 	of_node_put(node);
 	if (ret)
 		return -ENODEV;
 
+	is_a83t = sunxi_mc_smp_data[i].is_a83t;
+
 	if (!sunxi_mc_smp_cpu_table_init())
 		return -EINVAL;
 
diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index b1f25bac280b..71d52a670d95 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -385,11 +385,15 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 	 * same fault IRQ is not freed by the OS before.
 	 */
 	mutex_lock(&vas_pseries_mutex);
-	if (migration_in_progress)
+	if (migration_in_progress) {
 		rc = -EBUSY;
-	else
+	} else {
 		rc = allocate_setup_window(txwin, (u64 *)&domain[0],
 				   cop_feat_caps->win_type);
+		if (!rc)
+			caps->nr_open_wins_progress++;
+	}
+
 	mutex_unlock(&vas_pseries_mutex);
 	if (rc)
 		goto out;
@@ -404,8 +408,17 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 		goto out_free;
 
 	txwin->win_type = cop_feat_caps->win_type;
-	mutex_lock(&vas_pseries_mutex);
+
 	/*
+	 * The migration SUSPEND thread sets migration_in_progress and
+	 * closes all open windows from the list. But the window is
+	 * added to the list after open and modify HCALLs. So possible
+	 * that migration_in_progress is set before modify HCALL which
+	 * may cause some windows are still open when the hypervisor
+	 * initiates the migration.
+	 * So checks the migration_in_progress flag again and close all
+	 * open windows.
+	 *
 	 * Possible to lose the acquired credit with DLPAR core
 	 * removal after the window is opened. So if there are any
 	 * closed windows (means with lost credits), do not give new
@@ -413,9 +426,11 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 	 * after the existing windows are reopened when credits are
 	 * available.
 	 */
-	if (!caps->nr_close_wins) {
+	mutex_lock(&vas_pseries_mutex);
+	if (!caps->nr_close_wins && !migration_in_progress) {
 		list_add(&txwin->win_list, &caps->list);
 		caps->nr_open_windows++;
+		caps->nr_open_wins_progress--;
 		mutex_unlock(&vas_pseries_mutex);
 		vas_user_win_add_mm_context(&txwin->vas_win.task_ref);
 		return &txwin->vas_win;
@@ -433,6 +448,12 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 	 */
 	free_irq_setup(txwin);
 	h_deallocate_vas_window(txwin->vas_win.winid);
+	/*
+	 * Hold mutex and reduce nr_open_wins_progress counter.
+	 */
+	mutex_lock(&vas_pseries_mutex);
+	caps->nr_open_wins_progress--;
+	mutex_unlock(&vas_pseries_mutex);
 out:
 	atomic_dec(&cop_feat_caps->nr_used_credits);
 	kfree(txwin);
@@ -937,14 +958,14 @@ int vas_migration_handler(int action)
 	struct vas_caps *vcaps;
 	int i, rc = 0;
 
+	pr_info("VAS migration event %d\n", action);
+
 	/*
 	 * NX-GZIP is not enabled. Nothing to do for migration.
 	 */
 	if (!copypaste_feat)
 		return rc;
 
-	mutex_lock(&vas_pseries_mutex);
-
 	if (action == VAS_SUSPEND)
 		migration_in_progress = true;
 	else
@@ -990,12 +1011,27 @@ int vas_migration_handler(int action)
 
 		switch (action) {
 		case VAS_SUSPEND:
+			mutex_lock(&vas_pseries_mutex);
 			rc = reconfig_close_windows(vcaps, vcaps->nr_open_windows,
 							true);
+			/*
+			 * Windows are included in the list after successful
+			 * open. So wait for closing these in-progress open
+			 * windows in vas_allocate_window() which will be
+			 * done if the migration_in_progress is set.
+			 */
+			while (vcaps->nr_open_wins_progress) {
+				mutex_unlock(&vas_pseries_mutex);
+				msleep(10);
+				mutex_lock(&vas_pseries_mutex);
+			}
+			mutex_unlock(&vas_pseries_mutex);
 			break;
 		case VAS_RESUME:
+			mutex_lock(&vas_pseries_mutex);
 			atomic_set(&caps->nr_total_credits, new_nr_creds);
 			rc = reconfig_open_windows(vcaps, new_nr_creds, true);
+			mutex_unlock(&vas_pseries_mutex);
 			break;
 		default:
 			/* should not happen */
@@ -1011,8 +1047,9 @@ int vas_migration_handler(int action)
 			goto out;
 	}
 
+	pr_info("VAS migration event (%d) successful\n", action);
+
 out:
-	mutex_unlock(&vas_pseries_mutex);
 	return rc;
 }
 
diff --git a/arch/powerpc/platforms/pseries/vas.h b/arch/powerpc/platforms/pseries/vas.h
index 7115043ec488..45567cd13178 100644
--- a/arch/powerpc/platforms/pseries/vas.h
+++ b/arch/powerpc/platforms/pseries/vas.h
@@ -91,6 +91,8 @@ struct vas_cop_feat_caps {
 struct vas_caps {
 	struct vas_cop_feat_caps caps;
 	struct list_head list;	/* List of open windows */
+	int nr_open_wins_progress;	/* Number of open windows in */
+					/* progress. Used in migration */
 	int nr_close_wins;	/* closed windows in the hypervisor for DLPAR */
 	int nr_open_windows;	/* Number of successful open windows */
 	u8 feat;		/* Feature type */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..e12cd22755c7 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -568,6 +568,10 @@ void check_unaligned_access(int cpu)
 	void *src;
 	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
 
+	/* We are already set since the last check */
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+		return;
+
 	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
 	if (!page) {
 		pr_warn("Can't alloc pages to measure memcpy performance");
diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 6cf23b8adb71..e808723a85f1 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -55,6 +55,7 @@ struct imsic {
 	/* IMSIC SW-file */
 	struct imsic_mrif *swfile;
 	phys_addr_t swfile_pa;
+	spinlock_t swfile_extirq_lock;
 };
 
 #define imsic_vs_csr_read(__c)			\
@@ -613,12 +614,23 @@ static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
 {
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
 	struct imsic_mrif *mrif = imsic->swfile;
+	unsigned long flags;
+
+	/*
+	 * The critical section is necessary during external interrupt
+	 * updates to avoid the risk of losing interrupts due to potential
+	 * interruptions between reading topei and updating pending status.
+	 */
+
+	spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
 
 	if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
 	    imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
 		kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
 	else
 		kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
+
+	spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
 }
 
 static void imsic_swfile_read(struct kvm_vcpu *vcpu, bool clear,
@@ -1039,6 +1051,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu)
 	}
 	imsic->swfile = page_to_virt(swfile_page);
 	imsic->swfile_pa = page_to_phys(swfile_page);
+	spin_lock_init(&imsic->swfile_extirq_lock);
 
 	/* Setup IO device */
 	kvm_iodevice_init(&imsic->iodev, &imsic_iodoev_ops);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 61499293c2ac..e55f489e1fb7 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -587,10 +587,6 @@ void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, unsigned long start,
 
 	if (!gmap_is_shadow(gmap))
 		return;
-	if (start >= 1UL << 31)
-		/* We are only interested in prefix pages */
-		return;
-
 	/*
 	 * Only new shadow blocks are added to the list during runtime,
 	 * therefore we can safely reference them all the time.
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fa355d3658a6..bc4fcf0d9405 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4062,12 +4062,17 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
 	int global_ctrl, pebs_enable;
 
+	/*
+	 * In addition to obeying exclude_guest/exclude_host, remove bits being
+	 * used for PEBS when running a guest, because PEBS writes to virtual
+	 * addresses (not physical addresses).
+	 */
 	*nr = 0;
 	global_ctrl = (*nr)++;
 	arr[global_ctrl] = (struct perf_guest_switch_msr){
 		.msr = MSR_CORE_PERF_GLOBAL_CTRL,
 		.host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
-		.guest = intel_ctrl & (~cpuc->intel_ctrl_host_mask | ~pebs_mask),
+		.guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
 	};
 
 	if (!x86_pmu.pebs)
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index e8babebad7b8..a0ce46c0a2d8 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -576,7 +576,8 @@ static void kprobe_emulate_call_indirect(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
 
-	int3_emulate_call(regs, regs_get_register(regs, offs));
+	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + p->ainsn.size);
+	int3_emulate_jmp(regs, regs_get_register(regs, offs));
 }
 NOKPROBE_SYMBOL(kprobe_emulate_call_indirect);
 
diff --git a/crypto/xts.c b/crypto/xts.c
index 548b302c6c6a..038f60dd512d 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -28,7 +28,7 @@ struct xts_tfm_ctx {
 
 struct xts_instance_ctx {
 	struct crypto_skcipher_spawn spawn;
-	char name[CRYPTO_MAX_ALG_NAME];
+	struct crypto_cipher_spawn tweak_spawn;
 };
 
 struct xts_request_ctx {
@@ -306,7 +306,7 @@ static int xts_init_tfm(struct crypto_skcipher *tfm)
 
 	ctx->child = child;
 
-	tweak = crypto_alloc_cipher(ictx->name, 0, 0);
+	tweak = crypto_spawn_cipher(&ictx->tweak_spawn);
 	if (IS_ERR(tweak)) {
 		crypto_free_skcipher(ctx->child);
 		return PTR_ERR(tweak);
@@ -333,11 +333,13 @@ static void xts_free_instance(struct skcipher_instance *inst)
 	struct xts_instance_ctx *ictx = skcipher_instance_ctx(inst);
 
 	crypto_drop_skcipher(&ictx->spawn);
+	crypto_drop_cipher(&ictx->tweak_spawn);
 	kfree(inst);
 }
 
 static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 {
+	char name[CRYPTO_MAX_ALG_NAME];
 	struct skcipher_instance *inst;
 	struct xts_instance_ctx *ctx;
 	struct skcipher_alg *alg;
@@ -363,13 +365,13 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 				   cipher_name, 0, mask);
 	if (err == -ENOENT) {
 		err = -ENAMETOOLONG;
-		if (snprintf(ctx->name, CRYPTO_MAX_ALG_NAME, "ecb(%s)",
+		if (snprintf(name, CRYPTO_MAX_ALG_NAME, "ecb(%s)",
 			     cipher_name) >= CRYPTO_MAX_ALG_NAME)
 			goto err_free_inst;
 
 		err = crypto_grab_skcipher(&ctx->spawn,
 					   skcipher_crypto_instance(inst),
-					   ctx->name, 0, mask);
+					   name, 0, mask);
 	}
 
 	if (err)
@@ -398,23 +400,28 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (!strncmp(cipher_name, "ecb(", 4)) {
 		int len;
 
-		len = strscpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
+		len = strscpy(name, cipher_name + 4, sizeof(name));
 		if (len < 2)
 			goto err_free_inst;
 
-		if (ctx->name[len - 1] != ')')
+		if (name[len - 1] != ')')
 			goto err_free_inst;
 
-		ctx->name[len - 1] = 0;
+		name[len - 1] = 0;
 
 		if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
-			     "xts(%s)", ctx->name) >= CRYPTO_MAX_ALG_NAME) {
+			     "xts(%s)", name) >= CRYPTO_MAX_ALG_NAME) {
 			err = -ENAMETOOLONG;
 			goto err_free_inst;
 		}
 	} else
 		goto err_free_inst;
 
+	err = crypto_grab_cipher(&ctx->tweak_spawn,
+				 skcipher_crypto_instance(inst), name, 0, mask);
+	if (err)
+		goto err_free_inst;
+
 	inst->alg.base.cra_priority = alg->base.cra_priority;
 	inst->alg.base.cra_blocksize = XTS_BLOCK_SIZE;
 	inst->alg.base.cra_alignmask = alg->base.cra_alignmask |
diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 5036e58e7235..1405623b03e4 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -404,8 +404,21 @@ static struct mhi_controller_config aic100_config = {
 
 static int mhi_read_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr, u32 *out)
 {
-	u32 tmp = readl_relaxed(addr);
+	u32 tmp;
 
+	/*
+	 * SOC_HW_VERSION quirk
+	 * The SOC_HW_VERSION register (offset 0x224) is not reliable and
+	 * may contain uninitialized values, including 0xFFFFFFFF. This could
+	 * cause a false positive link down error.  Instead, intercept any
+	 * reads and provide the correct value of the register.
+	 */
+	if (addr - mhi_cntrl->regs == 0x224) {
+		*out = 0x60110200;
+		return 0;
+	}
+
+	tmp = readl_relaxed(addr);
 	if (tmp == U32_MAX)
 		return -EIO;
 
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index f4b06792c6f1..ed1a5af434f2 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -766,7 +766,6 @@ struct drm_gem_object *qaic_gem_prime_import(struct drm_device *dev, struct dma_
 	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
 	struct qaic_bo *bo;
-	size_t size;
 	int ret;
 
 	bo = qaic_alloc_init_bo();
@@ -784,13 +783,12 @@ struct drm_gem_object *qaic_gem_prime_import(struct drm_device *dev, struct dma_
 		goto attach_fail;
 	}
 
-	size = PAGE_ALIGN(attach->dmabuf->size);
-	if (size == 0) {
+	if (!attach->dmabuf->size) {
 		ret = -EINVAL;
 		goto size_align_fail;
 	}
 
-	drm_gem_private_object_init(dev, obj, size);
+	drm_gem_private_object_init(dev, obj, attach->dmabuf->size);
 	/*
 	 * skipping dma_buf_map_attachment() as we do not know the direction
 	 * just yet. Once the direction is known in the subsequent IOCTL to
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 312730f8272e..8263508415a8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -778,9 +778,9 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
+	thermal_zone_device_disable(tz->thermal_zone);
 	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
-	kfree(tz->trip_table);
 	tz->thermal_zone = NULL;
 }
 
@@ -985,7 +985,7 @@ static void acpi_thermal_remove(struct acpi_device *device)
 
 	flush_workqueue(acpi_thermal_pm_queue);
 	acpi_thermal_unregister_thermal_zone(tz);
-
+	kfree(tz->trip_table);
 	kfree(tz);
 }
 
diff --git a/drivers/clk/clk-si521xx.c b/drivers/clk/clk-si521xx.c
index ef4ba467e747..5886bc54aa0e 100644
--- a/drivers/clk/clk-si521xx.c
+++ b/drivers/clk/clk-si521xx.c
@@ -282,7 +282,7 @@ static int si521xx_probe(struct i2c_client *client)
 	const u16 chip_info = (u16)(uintptr_t)device_get_match_data(&client->dev);
 	const struct clk_parent_data clk_parent_data = { .index = 0 };
 	const u8 data[3] = { SI521XX_REG_BC, 1, 1 };
-	unsigned char name[6] = "DIFF0";
+	unsigned char name[16] = "DIFF0";
 	struct clk_init_data init = {};
 	struct si521xx *si;
 	int i, ret;
@@ -316,7 +316,7 @@ static int si521xx_probe(struct i2c_client *client)
 	/* Register clock */
 	for (i = 0; i < hweight16(chip_info); i++) {
 		memset(&init, 0, sizeof(init));
-		snprintf(name, 6, "DIFF%d", i);
+		snprintf(name, sizeof(name), "DIFF%d", i);
 		init.name = name;
 		init.ops = &si521xx_diff_clk_ops;
 		init.parent_data = &clk_parent_data;
diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index aa53797dbfc1..22e752236030 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -138,7 +138,7 @@ PNAME(mux_pll_src_5plls_p)	= { "cpll", "gpll", "gpll_div2", "gpll_div3", "usb480
 PNAME(mux_pll_src_4plls_p)	= { "cpll", "gpll", "gpll_div2", "usb480m" };
 PNAME(mux_pll_src_3plls_p)	= { "cpll", "gpll", "gpll_div2" };
 
-PNAME(mux_aclk_peri_src_p)	= { "gpll_peri", "cpll_peri", "gpll_div2_peri", "gpll_div3_peri" };
+PNAME(mux_clk_peri_src_p)	= { "gpll", "cpll", "gpll_div2", "gpll_div3" };
 PNAME(mux_mmc_src_p)		= { "cpll", "gpll", "gpll_div2", "xin24m" };
 PNAME(mux_clk_cif_out_src_p)		= { "clk_cif_src", "xin24m" };
 PNAME(mux_sclk_vop_src_p)	= { "cpll", "gpll", "gpll_div2", "gpll_div3" };
@@ -275,23 +275,17 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 11, GFLAGS),
 
 	/* PD_PERI */
-	GATE(0, "gpll_peri", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "clk_peri_src", mux_clk_peri_src_p, 0,
+			RK2928_CLKSEL_CON(10), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "cpll_peri", "cpll", CLK_IGNORE_UNUSED,
-			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "gpll_div2_peri", "gpll_div2", CLK_IGNORE_UNUSED,
-			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "gpll_div3_peri", "gpll_div3", CLK_IGNORE_UNUSED,
-			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	COMPOSITE_NOGATE(0, "aclk_peri_src", mux_aclk_peri_src_p, 0,
-			RK2928_CLKSEL_CON(10), 14, 2, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", 0,
+
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "clk_peri_src", 0,
 			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 3, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "clk_peri_src", 0,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", 0,
+	GATE(ACLK_PERI, "aclk_peri", "clk_peri_src", 0,
 			RK2928_CLKGATE_CON(2), 1, GFLAGS),
 
 	GATE(SCLK_TIMER0, "sclk_timer0", "xin24m", 0,
@@ -316,7 +310,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(SCLK_MIPI_24M, "clk_mipi_24m", "xin24m", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(2), 15, GFLAGS),
 
-	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
+	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc", mux_mmc_src_p, 0,
 			RK2928_CLKSEL_CON(11), 6, 2, MFLAGS, 0, 6, DFLAGS,
 			RK2928_CLKGATE_CON(2), 11, GFLAGS),
 
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 193b0b3a77cd..f1589eb3b46a 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -855,47 +855,15 @@ static void qm_poll_req_cb(struct hisi_qp *qp)
 	qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ, qp->qp_status.cq_head, 1);
 }
 
-static int qm_get_complete_eqe_num(struct hisi_qm_poll_data *poll_data)
-{
-	struct hisi_qm *qm = poll_data->qm;
-	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
-	u16 eq_depth = qm->eq_depth;
-	int eqe_num = 0;
-	u16 cqn;
-
-	while (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
-		cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
-		poll_data->qp_finish_id[eqe_num] = cqn;
-		eqe_num++;
-
-		if (qm->status.eq_head == eq_depth - 1) {
-			qm->status.eqc_phase = !qm->status.eqc_phase;
-			eqe = qm->eqe;
-			qm->status.eq_head = 0;
-		} else {
-			eqe++;
-			qm->status.eq_head++;
-		}
-
-		if (eqe_num == (eq_depth >> 1) - 1)
-			break;
-	}
-
-	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
-
-	return eqe_num;
-}
-
 static void qm_work_process(struct work_struct *work)
 {
 	struct hisi_qm_poll_data *poll_data =
 		container_of(work, struct hisi_qm_poll_data, work);
 	struct hisi_qm *qm = poll_data->qm;
+	u16 eqe_num = poll_data->eqe_num;
 	struct hisi_qp *qp;
-	int eqe_num, i;
+	int i;
 
-	/* Get qp id of completed tasks and re-enable the interrupt. */
-	eqe_num = qm_get_complete_eqe_num(poll_data);
 	for (i = eqe_num - 1; i >= 0; i--) {
 		qp = &qm->qp_array[poll_data->qp_finish_id[i]];
 		if (unlikely(atomic_read(&qp->qp_status.flags) == QP_STOP))
@@ -911,39 +879,55 @@ static void qm_work_process(struct work_struct *work)
 	}
 }
 
-static bool do_qm_eq_irq(struct hisi_qm *qm)
+static void qm_get_complete_eqe_num(struct hisi_qm *qm)
 {
 	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
-	struct hisi_qm_poll_data *poll_data;
-	u16 cqn;
+	struct hisi_qm_poll_data *poll_data = NULL;
+	u16 eq_depth = qm->eq_depth;
+	u16 cqn, eqe_num = 0;
 
-	if (!readl(qm->io_base + QM_VF_EQ_INT_SOURCE))
-		return false;
+	if (QM_EQE_PHASE(eqe) != qm->status.eqc_phase) {
+		atomic64_inc(&qm->debug.dfx.err_irq_cnt);
+		qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+		return;
+	}
 
-	if (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
+	cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
+	if (unlikely(cqn >= qm->qp_num))
+		return;
+	poll_data = &qm->poll_data[cqn];
+
+	while (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
 		cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
-		poll_data = &qm->poll_data[cqn];
-		queue_work(qm->wq, &poll_data->work);
+		poll_data->qp_finish_id[eqe_num] = cqn;
+		eqe_num++;
+
+		if (qm->status.eq_head == eq_depth - 1) {
+			qm->status.eqc_phase = !qm->status.eqc_phase;
+			eqe = qm->eqe;
+			qm->status.eq_head = 0;
+		} else {
+			eqe++;
+			qm->status.eq_head++;
+		}
 
-		return true;
+		if (eqe_num == (eq_depth >> 1) - 1)
+			break;
 	}
 
-	return false;
+	poll_data->eqe_num = eqe_num;
+	queue_work(qm->wq, &poll_data->work);
+	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
 }
 
 static irqreturn_t qm_eq_irq(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
-	bool ret;
-
-	ret = do_qm_eq_irq(qm);
-	if (ret)
-		return IRQ_HANDLED;
 
-	atomic64_inc(&qm->debug.dfx.err_irq_cnt);
-	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+	/* Get qp id of completed tasks and re-enable the interrupt */
+	qm_get_complete_eqe_num(qm);
 
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t qm_mb_cmd_irq(int irq, void *data)
@@ -1025,6 +1009,8 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 	u16 aeq_depth = qm->aeq_depth;
 	u32 type, qp_id;
 
+	atomic64_inc(&qm->debug.dfx.aeq_irq_cnt);
+
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
 		type = le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT;
 		qp_id = le32_to_cpu(aeqe->dw0) & QM_AEQE_CQN_MASK;
@@ -1062,17 +1048,6 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t qm_aeq_irq(int irq, void *data)
-{
-	struct hisi_qm *qm = data;
-
-	atomic64_inc(&qm->debug.dfx.aeq_irq_cnt);
-	if (!readl(qm->io_base + QM_VF_AEQ_INT_SOURCE))
-		return IRQ_NONE;
-
-	return IRQ_WAKE_THREAD;
-}
-
 static void qm_init_qp_status(struct hisi_qp *qp)
 {
 	struct hisi_qp_status *qp_status = &qp->qp_status;
@@ -5012,8 +4987,8 @@ static int qm_register_aeq_irq(struct hisi_qm *qm)
 		return 0;
 
 	irq_vector = val & QM_IRQ_VECTOR_MASK;
-	ret = request_threaded_irq(pci_irq_vector(pdev, irq_vector), qm_aeq_irq,
-						   qm_aeq_thread, 0, qm->dev_name, qm);
+	ret = request_threaded_irq(pci_irq_vector(pdev, irq_vector), NULL,
+						   qm_aeq_thread, IRQF_ONESHOT, qm->dev_name, qm);
 	if (ret)
 		dev_err(&pdev->dev, "failed to request eq irq, ret = %d", ret);
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
index 04af32a2811c..a39e70bd4b21 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -92,7 +92,8 @@ static void adf_device_reset_worker(struct work_struct *work)
 	if (adf_dev_restart(accel_dev)) {
 		/* The device hanged and we can't restart it so stop here */
 		dev_err(&GET_DEV(accel_dev), "Restart device failed\n");
-		kfree(reset_data);
+		if (reset_data->mode == ADF_DEV_RESET_ASYNC)
+			kfree(reset_data);
 		WARN(1, "QAT: device restart failed. Device is unusable\n");
 		return;
 	}
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 22829267ccd8..90664659d5fa 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -634,10 +634,11 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
 
-	if (port->commit_end + 1 != id) {
+	if (cxl_num_decoders_committed(port) != id) {
 		dev_dbg(&port->dev,
 			"%s: out of order commit, expected decoder%d.%d\n",
-			dev_name(&cxld->dev), port->id, port->commit_end + 1);
+			dev_name(&cxld->dev), port->id,
+			cxl_num_decoders_committed(port));
 		return -EBUSY;
 	}
 
@@ -847,7 +848,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
-		if (cxld->id != port->commit_end + 1) {
+
+		guard(rwsem_write)(&cxl_region_rwsem);
+		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
 				 port->id, cxld->id);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b91bb9886991..b12986b968da 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1200,7 +1200,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
 	 */
-	if (endpoint && endpoint->commit_end == -1)
+	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
 		rc = __cxl_mem_sanitize(mds, cmd);
 	else
 		rc = -EBUSY;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index fed9573cf355..2f43d368ba07 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -227,11 +227,17 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	rc = down_read_interruptible(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
-	if (port->commit_end == -1) {
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
+	if (cxl_num_decoders_committed(port) == 0) {
 		/* No regions mapped to this memdev */
 		rc = cxl_get_poison_by_memdev(cxlmd);
 	} else {
@@ -239,6 +245,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 		rc =  cxl_get_poison_by_endpoint(port);
 	}
 	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -282,7 +289,7 @@ static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 		.dpa = dpa,
 	};
 	port = cxlmd->endpoint;
-	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
+	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
 	return ctx.cxlr;
@@ -324,10 +331,16 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	rc = down_read_interruptible(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
 		goto out;
@@ -355,6 +368,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
 out:
 	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -372,10 +386,16 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	rc = down_read_interruptible(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
 		goto out;
@@ -412,6 +432,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
 out:
 	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
index 7684c843e5a5..5d8e06b0ba6e 100644
--- a/drivers/cxl/core/pmu.c
+++ b/drivers/cxl/core/pmu.c
@@ -23,7 +23,7 @@ const struct device_type cxl_pmu_type = {
 
 static void remove_dev(void *dev)
 {
-	device_del(dev);
+	device_unregister(dev);
 }
 
 int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1e0558d18b96..f430280fa6bd 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -37,6 +37,13 @@ DECLARE_RWSEM(cxl_region_rwsem);
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+int cxl_num_decoders_committed(struct cxl_port *port)
+{
+	lockdep_assert_held(&cxl_region_rwsem);
+
+	return port->commit_end + 1;
+}
+
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9d60020c5cb3..e7206367ec66 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2467,10 +2467,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 	struct cxl_poison_context ctx;
 	int rc = 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-
 	ctx = (struct cxl_poison_context) {
 		.port = port
 	};
@@ -2480,7 +2476,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
 					     &ctx);
 
-	up_read(&cxl_region_rwsem);
 	return rc;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b5b015b661ea..6c6afda0e4c6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -679,6 +679,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 	return port->uport_dev == port->dev.parent;
 }
 
+int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
 struct pci_bus;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 8c4ed7012e23..00cb70aca34a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -400,9 +400,8 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 		link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
 					     DL_FLAG_PM_RUNTIME |
 					     DL_FLAG_RPM_ACTIVE);
-		if (IS_ERR(link)) {
-			dev_err(dev, "Failed to add device_link to %d: %ld\n", i,
-				PTR_ERR(link));
+		if (!link) {
+			dev_err(dev, "Failed to add device_link to %d\n", i);
 			return -EINVAL;
 		}
 
@@ -640,6 +639,8 @@ static int fsl_edma_suspend_late(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(!fsl_chan->idle)) {
@@ -664,13 +665,16 @@ static int fsl_edma_resume_early(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->slave_id != 0)
 			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
 	}
 
-	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
+	if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
+		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
 	return 0;
 }
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index c01db23e3333..3f922518e3a5 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -182,13 +182,6 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 
 	portal = idxd_wq_portal_addr(wq);
 
-	/*
-	 * The wmb() flushes writes to coherent DMA data before
-	 * possibly triggering a DMA read. The wmb() is necessary
-	 * even on UP because the recipient is a device.
-	 */
-	wmb();
-
 	/*
 	 * Pending the descriptor to the lockless list for the irq_entry
 	 * that we designated the descriptor to.
@@ -199,6 +192,13 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 		llist_add(&desc->llnode, &ie->pending_llist);
 	}
 
+	/*
+	 * The wmb() flushes writes to coherent DMA data before
+	 * possibly triggering a DMA read. The wmb() is necessary
+	 * even on UP because the recipient is a device.
+	 */
+	wmb();
+
 	if (wq_dedicated(wq)) {
 		iosubmit_cmds512(portal, desc->hw, 1);
 	} else {
diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
index 2b6fd6e37c61..1272b1541f61 100644
--- a/drivers/dma/ti/k3-psil-am62.c
+++ b/drivers/dma/ti/k3-psil-am62.c
@@ -74,7 +74,9 @@ static struct psil_ep am62_src_ep_map[] = {
 	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
 	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
 	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
-	/* PDMA_MAIN0 - SPI0-3 */
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0x4300),
+	PSIL_PDMA_XY_PKT(0x4301),
 	PSIL_PDMA_XY_PKT(0x4302),
 	PSIL_PDMA_XY_PKT(0x4303),
 	PSIL_PDMA_XY_PKT(0x4304),
@@ -85,8 +87,6 @@ static struct psil_ep am62_src_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0x4309),
 	PSIL_PDMA_XY_PKT(0x430a),
 	PSIL_PDMA_XY_PKT(0x430b),
-	PSIL_PDMA_XY_PKT(0x430c),
-	PSIL_PDMA_XY_PKT(0x430d),
 	/* PDMA_MAIN1 - UART0-6 */
 	PSIL_PDMA_XY_PKT(0x4400),
 	PSIL_PDMA_XY_PKT(0x4401),
@@ -141,7 +141,9 @@ static struct psil_ep am62_dst_ep_map[] = {
 	/* SAUL */
 	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
 	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
-	/* PDMA_MAIN0 - SPI0-3 */
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0xc300),
+	PSIL_PDMA_XY_PKT(0xc301),
 	PSIL_PDMA_XY_PKT(0xc302),
 	PSIL_PDMA_XY_PKT(0xc303),
 	PSIL_PDMA_XY_PKT(0xc304),
@@ -152,8 +154,6 @@ static struct psil_ep am62_dst_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0xc309),
 	PSIL_PDMA_XY_PKT(0xc30a),
 	PSIL_PDMA_XY_PKT(0xc30b),
-	PSIL_PDMA_XY_PKT(0xc30c),
-	PSIL_PDMA_XY_PKT(0xc30d),
 	/* PDMA_MAIN1 - UART0-6 */
 	PSIL_PDMA_XY_PKT(0xc400),
 	PSIL_PDMA_XY_PKT(0xc401),
diff --git a/drivers/dma/ti/k3-psil-am62a.c b/drivers/dma/ti/k3-psil-am62a.c
index ca9d71f91422..4cf9123b0e93 100644
--- a/drivers/dma/ti/k3-psil-am62a.c
+++ b/drivers/dma/ti/k3-psil-am62a.c
@@ -84,7 +84,9 @@ static struct psil_ep am62a_src_ep_map[] = {
 	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
 	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
 	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
-	/* PDMA_MAIN0 - SPI0-3 */
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0x4300),
+	PSIL_PDMA_XY_PKT(0x4301),
 	PSIL_PDMA_XY_PKT(0x4302),
 	PSIL_PDMA_XY_PKT(0x4303),
 	PSIL_PDMA_XY_PKT(0x4304),
@@ -95,8 +97,6 @@ static struct psil_ep am62a_src_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0x4309),
 	PSIL_PDMA_XY_PKT(0x430a),
 	PSIL_PDMA_XY_PKT(0x430b),
-	PSIL_PDMA_XY_PKT(0x430c),
-	PSIL_PDMA_XY_PKT(0x430d),
 	/* PDMA_MAIN1 - UART0-6 */
 	PSIL_PDMA_XY_PKT(0x4400),
 	PSIL_PDMA_XY_PKT(0x4401),
@@ -151,7 +151,9 @@ static struct psil_ep am62a_dst_ep_map[] = {
 	/* SAUL */
 	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
 	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
-	/* PDMA_MAIN0 - SPI0-3 */
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0xc300),
+	PSIL_PDMA_XY_PKT(0xc301),
 	PSIL_PDMA_XY_PKT(0xc302),
 	PSIL_PDMA_XY_PKT(0xc303),
 	PSIL_PDMA_XY_PKT(0xc304),
@@ -162,8 +164,6 @@ static struct psil_ep am62a_dst_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0xc309),
 	PSIL_PDMA_XY_PKT(0xc30a),
 	PSIL_PDMA_XY_PKT(0xc30b),
-	PSIL_PDMA_XY_PKT(0xc30c),
-	PSIL_PDMA_XY_PKT(0xc30d),
 	/* PDMA_MAIN1 - UART0-6 */
 	PSIL_PDMA_XY_PKT(0xc400),
 	PSIL_PDMA_XY_PKT(0xc401),
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 7e88fd489741..9db9290c3269 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -279,6 +279,51 @@ static char ohci_driver_name[] = KBUILD_MODNAME;
 #define QUIRK_TI_SLLZ059		0x20
 #define QUIRK_IR_WAKE			0x40
 
+// On PCI Express Root Complex in any type of AMD Ryzen machine, VIA VT6306/6307/6308 with Asmedia
+// ASM1083/1085 brings an inconvenience that the read accesses to 'Isochronous Cycle Timer' register
+// (at offset 0xf0 in PCI I/O space) often causes unexpected system reboot. The mechanism is not
+// clear, since the read access to the other registers is enough safe; e.g. 'Node ID' register,
+// while it is probable due to detection of any type of PCIe error.
+#define QUIRK_REBOOT_BY_CYCLE_TIMER_READ	0x80000000
+
+#if IS_ENABLED(CONFIG_X86)
+
+static bool has_reboot_by_cycle_timer_read_quirk(const struct fw_ohci *ohci)
+{
+	return !!(ohci->quirks & QUIRK_REBOOT_BY_CYCLE_TIMER_READ);
+}
+
+#define PCI_DEVICE_ID_ASMEDIA_ASM108X	0x1080
+
+static bool detect_vt630x_with_asm1083_on_amd_ryzen_machine(const struct pci_dev *pdev)
+{
+	const struct pci_dev *pcie_to_pci_bridge;
+
+	// Detect any type of AMD Ryzen machine.
+	if (!static_cpu_has(X86_FEATURE_ZEN))
+		return false;
+
+	// Detect VIA VT6306/6307/6308.
+	if (pdev->vendor != PCI_VENDOR_ID_VIA)
+		return false;
+	if (pdev->device != PCI_DEVICE_ID_VIA_VT630X)
+		return false;
+
+	// Detect Asmedia ASM1083/1085.
+	pcie_to_pci_bridge = pdev->bus->self;
+	if (pcie_to_pci_bridge->vendor != PCI_VENDOR_ID_ASMEDIA)
+		return false;
+	if (pcie_to_pci_bridge->device != PCI_DEVICE_ID_ASMEDIA_ASM108X)
+		return false;
+
+	return true;
+}
+
+#else
+#define has_reboot_by_cycle_timer_read_quirk(ohci) false
+#define detect_vt630x_with_asm1083_on_amd_ryzen_machine(pdev)	false
+#endif
+
 /* In case of multiple matches in ohci_quirks[], only the first one is used. */
 static const struct {
 	unsigned short vendor, device, revision, flags;
@@ -1724,6 +1769,9 @@ static u32 get_cycle_time(struct fw_ohci *ohci)
 	s32 diff01, diff12;
 	int i;
 
+	if (has_reboot_by_cycle_timer_read_quirk(ohci))
+		return 0;
+
 	c2 = reg_read(ohci, OHCI1394_IsochronousCycleTimer);
 
 	if (ohci->quirks & QUIRK_CYCLE_TIMER) {
@@ -3630,6 +3678,9 @@ static int pci_probe(struct pci_dev *dev,
 	if (param_quirks)
 		ohci->quirks = param_quirks;
 
+	if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev))
+		ohci->quirks |= QUIRK_REBOOT_BY_CYCLE_TIMER_READ;
+
 	/*
 	 * Because dma_alloc_coherent() allocates at least one page,
 	 * we save space by using a common buffer for the AR request/
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 94e91516952c..56d99ffbba2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1896,15 +1896,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 
 	adev->firmware.gpu_info_fw = NULL;
 
-	if (adev->mman.discovery_bin) {
-		/*
-		 * FIXME: The bounding box is still needed by Navi12, so
-		 * temporarily read it from gpu_info firmware. Should be dropped
-		 * when DAL no longer needs it.
-		 */
-		if (adev->asic_type != CHIP_NAVI12)
-			return 0;
-	}
+	if (adev->mman.discovery_bin)
+		return 0;
 
 	switch (adev->asic_type) {
 	default:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d63360127834..5084833e3608 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6139,8 +6139,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
-
-	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
+	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+			 stream->signal == SIGNAL_TYPE_EDP) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6156,8 +6157,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
-		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
+		if (stream->link->psr_settings.psr_feature_enabled)
+			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 	}
 finish:
 	dc_sink_release(sink);
@@ -6868,8 +6870,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	if (IS_ERR(mst_state))
 		return PTR_ERR(mst_state);
 
-	if (!mst_state->pbn_div)
-		mst_state->pbn_div = dm_mst_get_pbn_divider(aconnector->mst_root->dc_link);
+	mst_state->pbn_div = dm_mst_get_pbn_divider(aconnector->mst_root->dc_link);
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 77cf5545c94c..c206812dc689 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -61,8 +61,12 @@ endif
 endif
 
 ifneq ($(CONFIG_FRAME_WARN),0)
+ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+frame_warn_flag := -Wframe-larger-than=3072
+else
 frame_warn_flag := -Wframe-larger-than=2048
 endif
+endif
 
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
index 2cbdd75429ff..6e669a2c5b2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
@@ -36,7 +36,7 @@
  * Define the maximum amount of states supported by the ASIC. Every ASIC has a
  * specific number of states; this macro defines the maximum number of states.
  */
-#define DC__VOLTAGE_STATES 20
+#define DC__VOLTAGE_STATES 40
 #define DC__NUM_DPP__4 1
 #define DC__NUM_DPP__0_PRESENT 1
 #define DC__NUM_DPP__1_PRESENT 1
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index f2de0c758494..8a5a038fd855 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -438,7 +438,115 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
 	.use_urgent_burst_bw = 0
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { 0 };
+struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = {
+	.clock_limits = {
+		{
+			.state = 0,
+			.dcfclk_mhz = 560.0,
+			.fabricclk_mhz = 560.0,
+			.dispclk_mhz = 513.0,
+			.dppclk_mhz = 513.0,
+			.phyclk_mhz = 540.0,
+			.socclk_mhz = 560.0,
+			.dscclk_mhz = 171.0,
+			.dram_speed_mts = 1069.0,
+		},
+		{
+			.state = 1,
+			.dcfclk_mhz = 694.0,
+			.fabricclk_mhz = 694.0,
+			.dispclk_mhz = 642.0,
+			.dppclk_mhz = 642.0,
+			.phyclk_mhz = 600.0,
+			.socclk_mhz = 694.0,
+			.dscclk_mhz = 214.0,
+			.dram_speed_mts = 1324.0,
+		},
+		{
+			.state = 2,
+			.dcfclk_mhz = 875.0,
+			.fabricclk_mhz = 875.0,
+			.dispclk_mhz = 734.0,
+			.dppclk_mhz = 734.0,
+			.phyclk_mhz = 810.0,
+			.socclk_mhz = 875.0,
+			.dscclk_mhz = 245.0,
+			.dram_speed_mts = 1670.0,
+		},
+		{
+			.state = 3,
+			.dcfclk_mhz = 1000.0,
+			.fabricclk_mhz = 1000.0,
+			.dispclk_mhz = 1100.0,
+			.dppclk_mhz = 1100.0,
+			.phyclk_mhz = 810.0,
+			.socclk_mhz = 1000.0,
+			.dscclk_mhz = 367.0,
+			.dram_speed_mts = 2000.0,
+		},
+		{
+			.state = 4,
+			.dcfclk_mhz = 1200.0,
+			.fabricclk_mhz = 1200.0,
+			.dispclk_mhz = 1284.0,
+			.dppclk_mhz = 1284.0,
+			.phyclk_mhz = 810.0,
+			.socclk_mhz = 1200.0,
+			.dscclk_mhz = 428.0,
+			.dram_speed_mts = 2000.0,
+		},
+		{
+			.state = 5,
+			.dcfclk_mhz = 1200.0,
+			.fabricclk_mhz = 1200.0,
+			.dispclk_mhz = 1284.0,
+			.dppclk_mhz = 1284.0,
+			.phyclk_mhz = 810.0,
+			.socclk_mhz = 1200.0,
+			.dscclk_mhz = 428.0,
+			.dram_speed_mts = 2000.0,
+		},
+	},
+
+	.num_states = 5,
+	.sr_exit_time_us = 1.9,
+	.sr_enter_plus_exit_time_us = 4.4,
+	.urgent_latency_us = 3.0,
+	.urgent_latency_pixel_data_only_us = 4.0,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+	.urgent_latency_vm_data_only_us = 4.0,
+	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 40.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 40.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
+	.max_avg_sdp_bw_use_normal_percent = 40.0,
+	.max_avg_dram_bw_use_normal_percent = 40.0,
+	.writeback_latency_us = 12.0,
+	.ideal_dram_bw_after_urgent_percent = 40.0,
+	.max_request_size_bytes = 256,
+	.dram_channel_width_bytes = 16,
+	.fabric_datapath_to_dcn_data_return_bytes = 64,
+	.dcn_downspread_percent = 0.5,
+	.downspread_percent = 0.5,
+	.dram_page_open_time_ns = 50.0,
+	.dram_rw_turnaround_time_ns = 17.5,
+	.dram_return_buffer_per_channel_bytes = 8192,
+	.round_trip_ping_latency_dcfclk_cycles = 131,
+	.urgent_out_of_order_return_per_channel_bytes = 4096,
+	.channel_interleave_bytes = 256,
+	.num_banks = 8,
+	.num_chans = 16,
+	.vmm_page_size_bytes = 4096,
+	.dram_clock_change_latency_us = 45.0,
+	.writeback_dram_clock_change_latency_us = 23.0,
+	.return_bus_width_bytes = 64,
+	.dispclk_dppclk_vco_speed_mhz = 3850,
+	.xfc_bus_transport_time_us = 20,
+	.xfc_xbuf_latency_tolerance_us = 50,
+	.use_urgent_burst_bw = 0,
+};
 
 struct _vcs_dpi_ip_params_st dcn2_1_ip = {
 	.odm_capable = 1,
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 84f9b412a4f1..738ee763f24a 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 
 	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
-	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-		vsc_packet_revision = vsc_packet_rev4;
-	else if (stream->link->replay_settings.config.replay_supported)
+	if (stream->link->psr_settings.psr_feature_enabled) {
+		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+			vsc_packet_revision = vsc_packet_rev4;
+		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
+			vsc_packet_revision = vsc_packet_rev2;
+	}
+
+	if (stream->link->replay_settings.config.replay_supported)
 		vsc_packet_revision = vsc_packet_rev4;
-	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
-		vsc_packet_revision = vsc_packet_rev2;
 
 	/* Update to revision 5 for extended colorimetry support */
 	if (stream->use_vsc_sdp_for_colorimetry)
diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8161b1a1a4b1..541e4f5afc4c 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -210,7 +210,7 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 	struct ps8640 *ps_bridge = aux_to_ps8640(aux);
 	struct regmap *map = ps_bridge->regmap[PAGE0_DP_CNTL];
 	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
-	unsigned int len = msg->size;
+	size_t len = msg->size;
 	unsigned int data;
 	unsigned int base;
 	int ret;
@@ -330,11 +330,12 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 				return ret;
 			}
 
-			buf[i] = data;
+			if (i < msg->size)
+				buf[i] = data;
 		}
 	}
 
-	return len;
+	return min(len, msg->size);
 }
 
 static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 84148a79414b..3309c01fa715 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -527,6 +527,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	u32 request_val = AUX_CMD_REQ(msg->request);
 	u8 *buf = msg->buffer;
 	unsigned int len = msg->size;
+	unsigned int short_len;
 	unsigned int val;
 	int ret;
 	u8 addr_len[SN_AUX_LENGTH_REG + 1 - SN_AUX_ADDR_19_16_REG];
@@ -600,7 +601,8 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	}
 
 	if (val & AUX_IRQ_STATUS_AUX_SHORT) {
-		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &len);
+		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &short_len);
+		len = min(len, short_len);
 		if (ret)
 			goto exit;
 	} else if (val & AUX_IRQ_STATUS_NAT_I2C_FAIL) {
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 2e0daad23aa6..a072fbb9872a 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6670,10 +6670,11 @@ static void intel_commit_modeset_disables(struct intel_atomic_state *state)
 		if (!intel_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+		intel_pre_plane_update(state, crtc);
+
 		if (!old_crtc_state->hw.active)
 			continue;
 
-		intel_pre_plane_update(state, crtc);
 		intel_crtc_disable_planes(state, crtc);
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index b4fb7ce39d06..18ee4f2a87f9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3987,7 +3987,7 @@ static void intel_dp_process_phy_request(struct intel_dp *intel_dp,
 			  intel_dp->train_set, crtc_state->lane_count);
 
 	drm_dp_set_phy_test_pattern(&intel_dp->aux, data,
-				    link_status[DP_DPCD_REV]);
+				    intel_dp->dpcd[DP_DPCD_REV]);
 }
 
 static u8 intel_dp_autotest_phy_pattern(struct intel_dp *intel_dp)
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 109135fcfca2..8f4a25d2cfc2 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -785,10 +785,6 @@ static int gen8_append_oa_reports(struct i915_perf_stream *stream,
 		 * The reason field includes flags identifying what
 		 * triggered this specific report (mostly timer
 		 * triggered or e.g. due to a context switch).
-		 *
-		 * In MMIO triggered reports, some platforms do not set the
-		 * reason bit in this field and it is valid to have a reason
-		 * field of zero.
 		 */
 		reason = oa_report_reason(stream, report);
 		ctx_id = oa_context_id(stream, report32);
@@ -800,8 +796,41 @@ static int gen8_append_oa_reports(struct i915_perf_stream *stream,
 		 *
 		 * Note: that we don't clear the valid_ctx_bit so userspace can
 		 * understand that the ID has been squashed by the kernel.
+		 *
+		 * Update:
+		 *
+		 * On XEHP platforms the behavior of context id valid bit has
+		 * changed compared to prior platforms. To describe this, we
+		 * define a few terms:
+		 *
+		 * context-switch-report: This is a report with the reason type
+		 * being context-switch. It is generated when a context switches
+		 * out.
+		 *
+		 * context-valid-bit: A bit that is set in the report ID field
+		 * to indicate that a valid context has been loaded.
+		 *
+		 * gpu-idle: A condition characterized by a
+		 * context-switch-report with context-valid-bit set to 0.
+		 *
+		 * On prior platforms, context-id-valid bit is set to 0 only
+		 * when GPU goes idle. In all other reports, it is set to 1.
+		 *
+		 * On XEHP platforms, context-valid-bit is set to 1 in a context
+		 * switch report if a new context switched in. For all other
+		 * reports it is set to 0.
+		 *
+		 * This change in behavior causes an issue with MMIO triggered
+		 * reports. MMIO triggered reports have the markers in the
+		 * context ID field and the context-valid-bit is 0. The logic
+		 * below to squash the context ID would render the report
+		 * useless since the user will not be able to find it in the OA
+		 * buffer. Since MMIO triggered reports exist only on XEHP,
+		 * we should avoid squashing these for XEHP platforms.
 		 */
-		if (oa_report_ctx_invalid(stream, report)) {
+
+		if (oa_report_ctx_invalid(stream, report) &&
+		    GRAPHICS_VER_FULL(stream->engine->i915) < IP_VER(12, 50)) {
 			ctx_id = INVALID_CTX_ID;
 			oa_context_id_squash(stream, report32);
 		}
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index 57c7edcab602..765e49fd8911 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -392,6 +392,11 @@ void mgag200_primary_plane_helper_atomic_disable(struct drm_plane *plane,
 	.destroy = drm_plane_cleanup, \
 	DRM_GEM_SHADOW_PLANE_FUNCS
 
+void mgag200_crtc_set_gamma_linear(struct mga_device *mdev, const struct drm_format_info *format);
+void mgag200_crtc_set_gamma(struct mga_device *mdev,
+			    const struct drm_format_info *format,
+			    struct drm_color_lut *lut);
+
 enum drm_mode_status mgag200_crtc_helper_mode_valid(struct drm_crtc *crtc,
 						    const struct drm_display_mode *mode);
 int mgag200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *new_state);
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c b/drivers/gpu/drm/mgag200/mgag200_g200er.c
index bce267e0f7de..8d4538b71047 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
@@ -202,6 +202,11 @@ static void mgag200_g200er_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 
 	mgag200_g200er_reset_tagfifo(mdev);
 
+	if (crtc_state->gamma_lut)
+		mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut->data);
+	else
+		mgag200_crtc_set_gamma_linear(mdev, format);
+
 	mgag200_enable_display(mdev);
 
 	if (funcs->enable_vidrst)
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
index ac957f42abe1..56e6f986bff3 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
@@ -203,6 +203,11 @@ static void mgag200_g200ev_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 
 	mgag200_g200ev_set_hiprilvl(mdev);
 
+	if (crtc_state->gamma_lut)
+		mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut->data);
+	else
+		mgag200_crtc_set_gamma_linear(mdev, format);
+
 	mgag200_enable_display(mdev);
 
 	if (funcs->enable_vidrst)
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
index bd6e573c9a1a..ff2b3c6622e7 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
@@ -334,6 +334,11 @@ static void mgag200_g200se_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 
 	mgag200_g200se_set_hiprilvl(mdev, adjusted_mode, format);
 
+	if (crtc_state->gamma_lut)
+		mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut->data);
+	else
+		mgag200_crtc_set_gamma_linear(mdev, format);
+
 	mgag200_enable_display(mdev);
 
 	if (funcs->enable_vidrst)
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index af3ce5a6a636..0f0d59938c3a 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -28,8 +28,8 @@
  * This file contains setup code for the CRTC.
  */
 
-static void mgag200_crtc_set_gamma_linear(struct mga_device *mdev,
-					  const struct drm_format_info *format)
+void mgag200_crtc_set_gamma_linear(struct mga_device *mdev,
+				   const struct drm_format_info *format)
 {
 	int i;
 
@@ -65,9 +65,9 @@ static void mgag200_crtc_set_gamma_linear(struct mga_device *mdev,
 	}
 }
 
-static void mgag200_crtc_set_gamma(struct mga_device *mdev,
-				   const struct drm_format_info *format,
-				   struct drm_color_lut *lut)
+void mgag200_crtc_set_gamma(struct mga_device *mdev,
+			    const struct drm_format_info *format,
+			    struct drm_color_lut *lut)
 {
 	int i;
 
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 05b8b8dfa9bd..36587f38dff3 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -3,6 +3,7 @@
  * i2c-core.h - interfaces internal to the I2C framework
  */
 
+#include <linux/kconfig.h>
 #include <linux/rwsem.h>
 
 struct i2c_devinfo {
@@ -29,7 +30,8 @@ int i2c_dev_irq_from_resources(const struct resource *resources,
  */
 static inline bool i2c_in_atomic_xfer_mode(void)
 {
-	return system_state > SYSTEM_RUNNING && !preemptible();
+	return system_state > SYSTEM_RUNNING &&
+	       (IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled());
 }
 
 static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 0a9951a50210..6c81dc5bf2c7 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -63,8 +63,8 @@
 #define ADIS16475_MAX_SCAN_DATA		20
 /* spi max speed in brust mode */
 #define ADIS16475_BURST_MAX_SPEED	1000000
-#define ADIS16475_LSB_DEC_MASK		BIT(0)
-#define ADIS16475_LSB_FIR_MASK		BIT(1)
+#define ADIS16475_LSB_DEC_MASK		0
+#define ADIS16475_LSB_FIR_MASK		1
 
 enum {
 	ADIS16475_SYNC_DIRECT = 1,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8a3762d9ff58..e0629898c3c0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1026,11 +1026,13 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 		return;
 
 	mutex_lock(&dev->cache.rb_lock);
+	cancel_delayed_work(&dev->cache.remove_ent_dwork);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
 		ent->disabled = true;
 		xa_unlock_irq(&ent->mkeys);
+		cancel_delayed_work(&ent->dwork);
 	}
 	mutex_unlock(&dev->cache.rb_lock);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4c3707384bd9..744e4e6b8d72 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2204,6 +2204,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			attr |= DMA_FL_PTE_DIRTY;
 	}
 
+	domain->has_mappings = true;
+
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
 	while (nr_pages > 0) {
@@ -4309,7 +4311,8 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 		return true;
 
 	spin_lock_irqsave(&dmar_domain->lock, flags);
-	if (!domain_support_force_snooping(dmar_domain)) {
+	if (!domain_support_force_snooping(dmar_domain) ||
+	    (!dmar_domain->use_first_level && dmar_domain->has_mappings)) {
 		spin_unlock_irqrestore(&dmar_domain->lock, flags);
 		return false;
 	}
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 7dac94f62b4e..e6a3e7065616 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -592,6 +592,9 @@ struct dmar_domain {
 					 * otherwise, goes through the second
 					 * level.
 					 */
+	u8 has_mappings:1;		/* Has mappings configured through
+					 * iommu_map() interface.
+					 */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 23acc387be5f..0147cc062e1a 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -352,7 +352,19 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 		phy_sel = csid->phy.csiphy_id;
 
 	if (enable) {
-		u8 dt_id = vc;
+		/*
+		 * DT_ID is a two bit bitfield that is concatenated with
+		 * the four least significant bits of the five bit VC
+		 * bitfield to generate an internal CID value.
+		 *
+		 * CSID_RDI_CFG0(vc)
+		 * DT_ID : 28:27
+		 * VC    : 26:22
+		 * DT    : 21:16
+		 *
+		 * CID   : VC 3:0 << 2 | DT_ID 1:0
+		 */
+		u8 dt_id = vc & 0x03;
 
 		if (tg->enabled) {
 			/* configure one DT, infinite frames */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 75991d849b57..c6df862c79e3 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1538,6 +1538,20 @@ static int camss_icc_get(struct camss *camss)
 	return 0;
 }
 
+static void camss_genpd_cleanup(struct camss *camss)
+{
+	int i;
+
+	if (camss->genpd_num == 1)
+		return;
+
+	if (camss->genpd_num > camss->vfe_num)
+		device_link_del(camss->genpd_link[camss->genpd_num - 1]);
+
+	for (i = 0; i < camss->genpd_num; i++)
+		dev_pm_domain_detach(camss->genpd[i], true);
+}
+
 /*
  * camss_probe - Probe CAMSS platform device
  * @pdev: Pointer to CAMSS platform device
@@ -1617,21 +1631,21 @@ static int camss_probe(struct platform_device *pdev)
 
 	ret = camss_icc_get(camss);
 	if (ret < 0)
-		goto err_cleanup;
+		return ret;
 
 	ret = camss_configure_pd(camss);
 	if (ret < 0) {
 		dev_err(dev, "Failed to configure power domains: %d\n", ret);
-		goto err_cleanup;
+		return ret;
 	}
 
 	ret = camss_init_subdevices(camss);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_genpd_cleanup;
 
 	ret = dma_set_mask_and_coherent(dev, 0xffffffff);
 	if (ret)
-		goto err_cleanup;
+		goto err_genpd_cleanup;
 
 	camss->media_dev.dev = camss->dev;
 	strscpy(camss->media_dev.model, "Qualcomm Camera Subsystem",
@@ -1643,7 +1657,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_cleanup;
+		goto err_genpd_cleanup;
 	}
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
@@ -1651,12 +1665,12 @@ static int camss_probe(struct platform_device *pdev)
 	num_subdevs = camss_of_parse_ports(camss);
 	if (num_subdevs < 0) {
 		ret = num_subdevs;
-		goto err_cleanup;
+		goto err_v4l2_device_unregister;
 	}
 
 	ret = camss_register_entities(camss);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_v4l2_device_unregister;
 
 	if (num_subdevs) {
 		camss->notifier.ops = &camss_subdev_notifier_ops;
@@ -1690,31 +1704,22 @@ static int camss_probe(struct platform_device *pdev)
 
 err_register_subdevs:
 	camss_unregister_entities(camss);
-err_cleanup:
+err_v4l2_device_unregister:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
+err_genpd_cleanup:
+	camss_genpd_cleanup(camss);
 
 	return ret;
 }
 
 void camss_delete(struct camss *camss)
 {
-	int i;
-
 	v4l2_device_unregister(&camss->v4l2_dev);
 	media_device_unregister(&camss->media_dev);
 	media_device_cleanup(&camss->media_dev);
 
 	pm_runtime_disable(camss->dev);
-
-	if (camss->genpd_num == 1)
-		return;
-
-	if (camss->genpd_num > camss->vfe_num)
-		device_link_del(camss->genpd_link[camss->genpd_num - 1]);
-
-	for (i = 0; i < camss->genpd_num; i++)
-		dev_pm_domain_detach(camss->genpd[i], true);
 }
 
 /*
@@ -1733,6 +1738,8 @@ static void camss_remove(struct platform_device *pdev)
 
 	if (atomic_read(&camss->ref_count) == 0)
 		camss_delete(camss);
+
+	camss_genpd_cleanup(camss);
 }
 
 static const struct of_device_id camss_dt_match[] = {
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f9a5cffa64b1..134c36edb6cf 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -851,9 +851,10 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -868,9 +869,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
@@ -3145,4 +3147,3 @@ module_exit(mmc_blk_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 096093f7be00..2f51db4df1a8 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -692,6 +692,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
+	cancel_delayed_work_sync(&host->detect);
 	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }
diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 528ec8166e7c..1ed9731e77ef 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -269,7 +269,7 @@ static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
 static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
-	u32 rx_clk_phase;
+	u32 val, rx_clk_phase;
 	int ret;
 
 	meson_mx_sdhc_disable_clks(mmc);
@@ -290,27 +290,11 @@ static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
 		mmc->actual_clock = clk_get_rate(host->sd_clk);
 
 		/*
-		 * according to Amlogic the following latching points are
-		 * selected with empirical values, there is no (known) formula
-		 * to calculate these.
+		 * Phase 90 should work in most cases. For data transmission,
+		 * meson_mx_sdhc_execute_tuning() will find a accurate value
 		 */
-		if (mmc->actual_clock > 100000000) {
-			rx_clk_phase = 1;
-		} else if (mmc->actual_clock > 45000000) {
-			if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
-				rx_clk_phase = 15;
-			else
-				rx_clk_phase = 11;
-		} else if (mmc->actual_clock >= 25000000) {
-			rx_clk_phase = 15;
-		} else if (mmc->actual_clock > 5000000) {
-			rx_clk_phase = 23;
-		} else if (mmc->actual_clock > 1000000) {
-			rx_clk_phase = 55;
-		} else {
-			rx_clk_phase = 1061;
-		}
-
+		regmap_read(host->regmap, MESON_SDHC_CLKC, &val);
+		rx_clk_phase = FIELD_GET(MESON_SDHC_CLKC_CLK_DIV, val) / 4;
 		regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
 				   MESON_SDHC_CLK2_RX_CLK_PHASE,
 				   FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6b8a57e2d20f..bed57a1c64b5 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -239,15 +239,19 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 	div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
 	sdhci_enable_clk(host, div);
 
+	val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
+	mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN | SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
 	/* Enable CLK_AUTO when the clock is greater than 400K. */
 	if (clk > 400000) {
-		val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
-		mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
-			SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
 		if (mask != (val & mask)) {
 			val |= mask;
 			sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
 		}
+	} else {
+		if (val & mask) {
+			val &= ~mask;
+			sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f811d59fd71f..6039886a8544 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12073,6 +12073,8 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
 		bnxt_hwrm_exec_fwd_req(bp);
+	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
+		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 	if (test_and_clear_bit(BNXT_PERIODIC_STATS_SP_EVENT, &bp->sp_event)) {
 		bnxt_hwrm_port_qstats(bp, 0);
 		bnxt_hwrm_port_qstats_ext(bp, 0);
@@ -13052,8 +13054,6 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 			}
 		}
 	}
-	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
-		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 }
 
 #else
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 24bade875ca6..89c8ddc6565a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2132,8 +2132,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Note: if we ever change from DMA_TX_APPEND_CRC below we
 		 * will need to restore software padding of "runt" packets
 		 */
+		len_stat |= DMA_TX_APPEND_CRC;
+
 		if (!i) {
-			len_stat |= DMA_TX_APPEND_CRC | DMA_SOP;
+			len_stat |= DMA_SOP;
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
 				len_stat |= DMA_TX_DO_CSUM;
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a9f5a8a7d3f0..5b20eba93d04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -104,12 +104,18 @@ static struct workqueue_struct *i40e_wq;
 static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 				  struct net_device *netdev, int delta)
 {
+	struct netdev_hw_addr_list *ha_list;
 	struct netdev_hw_addr *ha;
 
 	if (!f || !netdev)
 		return;
 
-	netdev_for_each_mc_addr(ha, netdev) {
+	if (is_unicast_ether_addr(f->macaddr) || is_link_local_ether_addr(f->macaddr))
+		ha_list = &netdev->uc;
+	else
+		ha_list = &netdev->mc;
+
+	netdev_hw_addr_list_for_each(ha, ha_list) {
 		if (ether_addr_equal(ha->addr, f->macaddr)) {
 			ha->refcount += delta;
 			if (ha->refcount <= 0)
@@ -16479,6 +16485,9 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 		return;
 
 	i40e_reset_and_rebuild(pf, false, false);
+#ifdef CONFIG_PCI_IOV
+	i40e_restore_all_vfs_msi_state(pdev);
+#endif /* CONFIG_PCI_IOV */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4441b00297f4..a97ca2224da0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -152,6 +152,32 @@ void i40e_vc_notify_reset(struct i40e_pf *pf)
 			     (u8 *)&pfe, sizeof(struct virtchnl_pf_event));
 }
 
+#ifdef CONFIG_PCI_IOV
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
+{
+	u16 vf_id;
+	u16 pos;
+
+	/* Continue only if this is a PF */
+	if (!pdev->is_physfn)
+		return;
+
+	if (!pci_num_vf(pdev))
+		return;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos) {
+		struct pci_dev *vf_dev = NULL;
+
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
+		while ((vf_dev = pci_get_device(pdev->vendor, vf_id, vf_dev))) {
+			if (vf_dev->is_virtfn && vf_dev->physfn == pdev)
+				pci_restore_msi_state(vf_dev);
+		}
+	}
+}
+#endif /* CONFIG_PCI_IOV */
+
 /**
  * i40e_vc_notify_vf_reset
  * @vf: pointer to the VF structure
@@ -3519,16 +3545,16 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	bool found = false;
 	int bkt;
 
-	if (!tc_filter->action) {
+	if (tc_filter->action != VIRTCHNL_ACTION_TC_REDIRECT) {
 		dev_info(&pf->pdev->dev,
-			 "VF %d: Currently ADq doesn't support Drop Action\n",
-			 vf->vf_id);
+			 "VF %d: ADQ doesn't support this action (%d)\n",
+			 vf->vf_id, tc_filter->action);
 		goto err;
 	}
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > I40E_MAX_VF_VSI) {
+	    tc_filter->action_meta > vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 895b8feb2567..bda9ba668c41 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -135,6 +135,9 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
+#ifdef CONFIG_PCI_IOV
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
+#endif /* CONFIG_PCI_IOV */
 int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 		      struct ifla_vf_stats *vf_stats);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7784135160fd..d8d2aa4c0216 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2146,7 +2146,7 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 
 	/* Ensure we have media as we cannot configure a medialess port */
 	if (!(phy->link_info.link_info & ICE_AQ_MEDIA_AVAILABLE))
-		return -EPERM;
+		return -ENOMEDIUM;
 
 	ice_print_topo_conflict(vsi);
 
@@ -9173,8 +9173,14 @@ int ice_stop(struct net_device *netdev)
 		int link_err = ice_force_phys_link_state(vsi, false);
 
 		if (link_err) {
-			netdev_err(vsi->netdev, "Failed to set physical link down, VSI %d error %d\n",
-				   vsi->vsi_num, link_err);
+			if (link_err == -ENOMEDIUM)
+				netdev_info(vsi->netdev, "Skipping link reconfig - no media attached, VSI %d\n",
+					    vsi->vsi_num);
+			else
+				netdev_err(vsi->netdev, "Failed to set physical link down, VSI %d error %d\n",
+					   vsi->vsi_num, link_err);
+
+			ice_vsi_close(vsi);
 			return -EIO;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index f48f82d5e274..85cc16396506 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -568,6 +568,7 @@ struct igc_nfc_filter {
 	u16 etype;
 	__be16 vlan_etype;
 	u16 vlan_tci;
+	u16 vlan_tci_mask;
 	u8 src_addr[ETH_ALEN];
 	u8 dst_addr[ETH_ALEN];
 	u8 user_data[8];
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index dd8a9d27a167..f7284fa4324a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -957,6 +957,7 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
 }
 
 #define ETHER_TYPE_FULL_MASK ((__force __be16)~0)
+#define VLAN_TCI_FULL_MASK ((__force __be16)~0)
 static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 				    struct ethtool_rxnfc *cmd)
 {
@@ -979,10 +980,16 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 		fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
 	}
 
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) {
+		fsp->flow_type |= FLOW_EXT;
+		fsp->h_ext.vlan_etype = rule->filter.vlan_etype;
+		fsp->m_ext.vlan_etype = ETHER_TYPE_FULL_MASK;
+	}
+
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) {
 		fsp->flow_type |= FLOW_EXT;
 		fsp->h_ext.vlan_tci = htons(rule->filter.vlan_tci);
-		fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
+		fsp->m_ext.vlan_tci = htons(rule->filter.vlan_tci_mask);
 	}
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR) {
@@ -1217,6 +1224,7 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 
 	if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
 		rule->filter.vlan_tci = ntohs(fsp->h_ext.vlan_tci);
+		rule->filter.vlan_tci_mask = ntohs(fsp->m_ext.vlan_tci);
 		rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_TCI;
 	}
 
@@ -1254,11 +1262,19 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 		memcpy(rule->filter.user_mask, fsp->m_ext.data, sizeof(fsp->m_ext.data));
 	}
 
-	/* When multiple filter options or user data or vlan etype is set, use a
-	 * flex filter.
+	/* The i225/i226 has various different filters. Flex filters provide a
+	 * way to match up to the first 128 bytes of a packet. Use them for:
+	 *   a) For specific user data
+	 *   b) For VLAN EtherType
+	 *   c) For full TCI match
+	 *   d) Or in case multiple filter criteria are set
+	 *
+	 * Otherwise, use the simple MAC, VLAN PRIO or EtherType filters.
 	 */
 	if ((rule->filter.match_flags & IGC_FILTER_FLAG_USER_DATA) ||
 	    (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) ||
+	    ((rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) &&
+	     rule->filter.vlan_tci_mask == ntohs(VLAN_TCI_FULL_MASK)) ||
 	    (rule->filter.match_flags & (rule->filter.match_flags - 1)))
 		rule->flex = true;
 	else
@@ -1328,6 +1344,26 @@ static int igc_ethtool_add_nfc_rule(struct igc_adapter *adapter,
 		return -EINVAL;
 	}
 
+	/* There are two ways to match the VLAN TCI:
+	 *  1. Match on PCP field and use vlan prio filter for it
+	 *  2. Match on complete TCI field and use flex filter for it
+	 */
+	if ((fsp->flow_type & FLOW_EXT) &&
+	    fsp->m_ext.vlan_tci &&
+	    fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK) &&
+	    fsp->m_ext.vlan_tci != VLAN_TCI_FULL_MASK) {
+		netdev_dbg(netdev, "VLAN mask not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* VLAN EtherType can only be matched by full mask. */
+	if ((fsp->flow_type & FLOW_EXT) &&
+	    fsp->m_ext.vlan_etype &&
+	    fsp->m_ext.vlan_etype != ETHER_TYPE_FULL_MASK) {
+		netdev_dbg(netdev, "VLAN EtherType mask not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (fsp->location >= IGC_MAX_RXNFC_RULES) {
 		netdev_dbg(netdev, "Invalid location\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index a9c08321aca9..22cefb1eeedf 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -227,7 +227,7 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 			wr32(IGC_TQAVCC(i), tqavcc);
 
 			wr32(IGC_TQAVHC(i),
-			     0x80000000 + ring->hicredit * 0x7735);
+			     0x80000000 + ring->hicredit * 0x7736);
 		} else {
 			/* Disable any CBS for the queue */
 			txqctl &= ~(IGC_TXQCTL_QAV_SEL_MASK);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index de9fbd98dfb7..c92c3f4631d5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -520,7 +520,7 @@ struct npc_lt_def {
 	u8	ltype_mask;
 	u8	ltype_match;
 	u8	lid;
-};
+} __packed;
 
 struct npc_lt_def_ipsec {
 	u8	ltype_mask;
@@ -528,7 +528,7 @@ struct npc_lt_def_ipsec {
 	u8	lid;
 	u8	spi_offset;
 	u8	spi_nz;
-};
+} __packed;
 
 struct npc_lt_def_apad {
 	u8	ltype_mask;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index cce2806aaa50..8802961b8889 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -905,6 +905,7 @@ u32  rvu_cgx_get_fifolen(struct rvu *rvu);
 void *rvu_first_cgx_pdata(struct rvu *rvu);
 int cgxlmac_to_pf(struct rvu *rvu, int cgx_id, int lmac_id);
 int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable);
+int rvu_cgx_tx_enable(struct rvu *rvu, u16 pcifunc, bool enable);
 int rvu_cgx_prio_flow_ctrl_cfg(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause,
 			       u16 pfc_en);
 int rvu_cgx_cfg_pause_frm(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index f2b1edf1bb43..ce987ccd43e2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -465,6 +465,23 @@ int rvu_cgx_config_rxtx(struct rvu *rvu, u16 pcifunc, bool start)
 	return mac_ops->mac_rx_tx_enable(cgxd, lmac_id, start);
 }
 
+int rvu_cgx_tx_enable(struct rvu *rvu, u16 pcifunc, bool enable)
+{
+	int pf = rvu_get_pf(pcifunc);
+	struct mac_ops *mac_ops;
+	u8 cgx_id, lmac_id;
+	void *cgxd;
+
+	if (!is_cgx_config_permitted(rvu, pcifunc))
+		return LMAC_AF_ERR_PERM_DENIED;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	cgxd = rvu_cgx_pdata(cgx_id, rvu);
+	mac_ops = get_mac_ops(cgxd);
+
+	return mac_ops->mac_tx_enable(cgxd, lmac_id, enable);
+}
+
 int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable)
 {
 	struct mac_ops *mac_ops;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 4227ebb4a758..58744313f0eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4143,90 +4143,18 @@ static void nix_find_link_frs(struct rvu *rvu,
 		req->minlen = minlen;
 }
 
-static int
-nix_config_link_credits(struct rvu *rvu, int blkaddr, int link,
-			u16 pcifunc, u64 tx_credits)
-{
-	struct rvu_hwinfo *hw = rvu->hw;
-	int pf = rvu_get_pf(pcifunc);
-	u8 cgx_id = 0, lmac_id = 0;
-	unsigned long poll_tmo;
-	bool restore_tx_en = 0;
-	struct nix_hw *nix_hw;
-	u64 cfg, sw_xoff = 0;
-	u32 schq = 0;
-	u32 credits;
-	int rc;
-
-	nix_hw = get_nix_hw(rvu->hw, blkaddr);
-	if (!nix_hw)
-		return NIX_AF_ERR_INVALID_NIXBLK;
-
-	if (tx_credits == nix_hw->tx_credits[link])
-		return 0;
-
-	/* Enable cgx tx if disabled for credits to be back */
-	if (is_pf_cgxmapped(rvu, pf)) {
-		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
-		restore_tx_en = !rvu_cgx_config_tx(rvu_cgx_pdata(cgx_id, rvu),
-						    lmac_id, true);
-	}
-
-	mutex_lock(&rvu->rsrc_lock);
-	/* Disable new traffic to link */
-	if (hw->cap.nix_shaping) {
-		schq = nix_get_tx_link(rvu, pcifunc);
-		sw_xoff = rvu_read64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq));
-		rvu_write64(rvu, blkaddr,
-			    NIX_AF_TL1X_SW_XOFF(schq), BIT_ULL(0));
-	}
-
-	rc = NIX_AF_ERR_LINK_CREDITS;
-	poll_tmo = jiffies + usecs_to_jiffies(200000);
-	/* Wait for credits to return */
-	do {
-		if (time_after(jiffies, poll_tmo))
-			goto exit;
-		usleep_range(100, 200);
-
-		cfg = rvu_read64(rvu, blkaddr,
-				 NIX_AF_TX_LINKX_NORM_CREDIT(link));
-		credits = (cfg >> 12) & 0xFFFFFULL;
-	} while (credits != nix_hw->tx_credits[link]);
-
-	cfg &= ~(0xFFFFFULL << 12);
-	cfg |= (tx_credits << 12);
-	rvu_write64(rvu, blkaddr, NIX_AF_TX_LINKX_NORM_CREDIT(link), cfg);
-	rc = 0;
-
-	nix_hw->tx_credits[link] = tx_credits;
-
-exit:
-	/* Enable traffic back */
-	if (hw->cap.nix_shaping && !sw_xoff)
-		rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq), 0);
-
-	/* Restore state of cgx tx */
-	if (restore_tx_en)
-		rvu_cgx_config_tx(rvu_cgx_pdata(cgx_id, rvu), lmac_id, false);
-
-	mutex_unlock(&rvu->rsrc_lock);
-	return rc;
-}
-
 int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 				    struct msg_rsp *rsp)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
 	int pf = rvu_get_pf(pcifunc);
-	int blkaddr, schq, link = -1;
-	struct nix_txsch *txsch;
-	u64 cfg, lmac_fifo_len;
+	int blkaddr, link = -1;
 	struct nix_hw *nix_hw;
 	struct rvu_pfvf *pfvf;
 	u8 cgx = 0, lmac = 0;
 	u16 max_mtu;
+	u64 cfg;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 	if (blkaddr < 0)
@@ -4247,25 +4175,6 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (req->update_minlen && req->minlen < NIC_HW_MIN_FRS)
 		return NIX_AF_ERR_FRS_INVALID;
 
-	/* Check if requester wants to update SMQ's */
-	if (!req->update_smq)
-		goto rx_frscfg;
-
-	/* Update min/maxlen in each of the SMQ attached to this PF/VF */
-	txsch = &nix_hw->txsch[NIX_TXSCH_LVL_SMQ];
-	mutex_lock(&rvu->rsrc_lock);
-	for (schq = 0; schq < txsch->schq.max; schq++) {
-		if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
-			continue;
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq));
-		cfg = (cfg & ~(0xFFFFULL << 8)) | ((u64)req->maxlen << 8);
-		if (req->update_minlen)
-			cfg = (cfg & ~0x7FULL) | ((u64)req->minlen & 0x7F);
-		rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq), cfg);
-	}
-	mutex_unlock(&rvu->rsrc_lock);
-
-rx_frscfg:
 	/* Check if config is for SDP link */
 	if (req->sdp_link) {
 		if (!hw->sdp_links)
@@ -4288,7 +4197,6 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (link < 0)
 		return NIX_AF_ERR_RX_LINK_INVALID;
 
-
 linkcfg:
 	nix_find_link_frs(rvu, req, pcifunc);
 
@@ -4298,19 +4206,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 		cfg = (cfg & ~0xFFFFULL) | req->minlen;
 	rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link), cfg);
 
-	if (req->sdp_link || pf == 0)
-		return 0;
-
-	/* Update transmit credits for CGX links */
-	lmac_fifo_len = rvu_cgx_get_lmac_fifolen(rvu, cgx, lmac);
-	if (!lmac_fifo_len) {
-		dev_err(rvu->dev,
-			"%s: Failed to get CGX/RPM%d:LMAC%d FIFO size\n",
-			__func__, cgx, lmac);
-		return 0;
-	}
-	return nix_config_link_credits(rvu, blkaddr, link, pcifunc,
-				       (lmac_fifo_len - req->maxlen) / 16);
+	return 0;
 }
 
 int rvu_mbox_handler_nix_set_rx_cfg(struct rvu *rvu, struct nix_rx_cfg *req,
@@ -4841,7 +4737,13 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *rvu, struct msg_req *req,
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	clear_bit(NIXLF_INITIALIZED, &pfvf->flags);
 
-	return rvu_cgx_start_stop_io(rvu, pcifunc, false);
+	err = rvu_cgx_start_stop_io(rvu, pcifunc, false);
+	if (err)
+		return err;
+
+	rvu_cgx_tx_enable(rvu, pcifunc, true);
+
+	return 0;
 }
 
 #define RX_SA_BASE  GENMASK_ULL(52, 7)
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index 0d5a41a2ae01..227d01cace3f 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -267,6 +267,13 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 		priv->stats.rx_truncate_errors++;
 	}
 
+	/* Read receive consumer index before replenish so that this routine
+	 * returns accurate return value even if packet is received into
+	 * just-replenished buffer prior to exiting this routine.
+	 */
+	rx_ci = readq(priv->base + MLXBF_GIGE_RX_CQE_PACKET_CI);
+	rx_ci_rem = rx_ci % priv->rx_q_entries;
+
 	/* Let hardware know we've replenished one buffer */
 	rx_pi++;
 
@@ -279,8 +286,6 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 	rx_pi_rem = rx_pi % priv->rx_q_entries;
 	if (rx_pi_rem == 0)
 		priv->valid_polarity ^= 1;
-	rx_ci = readq(priv->base + MLXBF_GIGE_RX_CQE_PACKET_CI);
-	rx_ci_rem = rx_ci % priv->rx_q_entries;
 
 	if (skb)
 		netif_receive_skb(skb);
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 0d57ffcedf0c..fc78bc959ded 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -2591,6 +2591,7 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 
 	if (qdev->lrg_buf_q_alloc_virt_addr == NULL) {
 		netdev_err(qdev->ndev, "lBufQ failed\n");
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 	qdev->lrg_buf_q_virt_addr = qdev->lrg_buf_q_alloc_virt_addr;
@@ -2615,6 +2616,7 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 				  qdev->lrg_buf_q_alloc_size,
 				  qdev->lrg_buf_q_alloc_virt_addr,
 				  qdev->lrg_buf_q_alloc_phy_addr);
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index bb787a52bc75..81fd31f6fac4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1211,7 +1211,7 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 {
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 10);
+	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
 static void rtl8168_driver_start(struct rtl8169_private *tp)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index bb56cf409042..3c2a6b23c202 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -66,16 +66,27 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
 	return -ETIMEDOUT;
 }
 
-static int ravb_config(struct net_device *ndev)
+static int ravb_set_opmode(struct net_device *ndev, u32 opmode)
 {
+	u32 csr_ops = 1U << (opmode & CCC_OPC);
+	u32 ccc_mask = CCC_OPC;
 	int error;
 
-	/* Set config mode */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
-	/* Check if the operating mode is changed to the config mode */
-	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
-	if (error)
-		netdev_err(ndev, "failed to switch device to config mode\n");
+	/* If gPTP active in config mode is supported it needs to be configured
+	 * along with CSEL and operating mode in the same access. This is a
+	 * hardware limitation.
+	 */
+	if (opmode & CCC_GAC)
+		ccc_mask |= CCC_GAC | CCC_CSEL;
+
+	/* Set operating mode */
+	ravb_modify(ndev, CCC, ccc_mask, opmode);
+	/* Check if the operating mode is changed to the requested one */
+	error = ravb_wait(ndev, CSR, CSR_OPS, csr_ops);
+	if (error) {
+		netdev_err(ndev, "failed to switch device to requested mode (%u)\n",
+			   opmode & CCC_OPC);
+	}
 
 	return error;
 }
@@ -673,7 +684,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 	int error;
 
 	/* Set CONFIG mode */
-	error = ravb_config(ndev);
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	if (error)
 		return error;
 
@@ -682,9 +693,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Setting the control will start the AVB-DMAC process. */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
-
-	return 0;
+	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
 }
 
 static void ravb_get_tx_tstamp(struct net_device *ndev)
@@ -1046,7 +1055,7 @@ static int ravb_stop_dma(struct net_device *ndev)
 		return error;
 
 	/* Stop AVB-DMAC process */
-	return ravb_config(ndev);
+	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
 /* E-MAC interrupt handler */
@@ -2560,21 +2569,25 @@ static int ravb_set_gti(struct net_device *ndev)
 	return 0;
 }
 
-static void ravb_set_config_mode(struct net_device *ndev)
+static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
 
 	if (info->gptp) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+		if (error)
+			return error;
 		/* Set CSEL value */
 		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
 	} else if (info->ccc_gac) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG |
-			    CCC_GAC | CCC_CSEL_HPB);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
 	} else {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	}
+
+	return error;
 }
 
 /* Set tx and rx clock internal delay modes */
@@ -2794,7 +2807,9 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_disable_gptp_clk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
@@ -2917,8 +2932,7 @@ static int ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
 	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
@@ -3002,8 +3016,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	int ret = 0;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
-	if (priv->wol_enabled)
-		ravb_write(ndev, CCC_OPC_RESET, CCC);
+	if (priv->wol_enabled) {
+		ret = ravb_set_opmode(ndev, CCC_OPC_RESET);
+		if (ret)
+			return ret;
+	}
 
 	/* All register have been reset to default values.
 	 * Restore all registers which where setup at probe time and
@@ -3011,7 +3028,9 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	 */
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	ret = ravb_set_config_mode(ndev);
+	if (ret)
+		return ret;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index d2f35ee15eff..fac227d372db 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -823,8 +823,10 @@ int efx_probe_filters(struct efx_nic *efx)
 		}
 
 		if (!success) {
-			efx_for_each_channel(channel, efx)
+			efx_for_each_channel(channel, efx) {
 				kfree(channel->rps_flow_id);
+				channel->rps_flow_id = NULL;
+			}
 			efx->type->filter_table_remove(efx);
 			rc = -ENOMEM;
 			goto out_unlock;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 21505920136c..e078f4071dc2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -160,60 +160,6 @@ static __le32 wx_test_staterr(union wx_rx_desc *rx_desc,
 	return rx_desc->wb.upper.status_error & cpu_to_le32(stat_err_bits);
 }
 
-static bool wx_can_reuse_rx_page(struct wx_rx_buffer *rx_buffer,
-				 int rx_buffer_pgcnt)
-{
-	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
-	struct page *page = rx_buffer->page;
-
-	/* avoid re-using remote and pfmemalloc pages */
-	if (!dev_page_is_reusable(page))
-		return false;
-
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely((rx_buffer_pgcnt - pagecnt_bias) > 1))
-		return false;
-#endif
-
-	/* If we have drained the page fragment pool we need to update
-	 * the pagecnt_bias and page count so that we fully restock the
-	 * number of references the driver holds.
-	 */
-	if (unlikely(pagecnt_bias == 1)) {
-		page_ref_add(page, USHRT_MAX - 1);
-		rx_buffer->pagecnt_bias = USHRT_MAX;
-	}
-
-	return true;
-}
-
-/**
- * wx_reuse_rx_page - page flip buffer and store it back on the ring
- * @rx_ring: rx descriptor ring to store buffers on
- * @old_buff: donor buffer to have page reused
- *
- * Synchronizes page for reuse by the adapter
- **/
-static void wx_reuse_rx_page(struct wx_ring *rx_ring,
-			     struct wx_rx_buffer *old_buff)
-{
-	u16 nta = rx_ring->next_to_alloc;
-	struct wx_rx_buffer *new_buff;
-
-	new_buff = &rx_ring->rx_buffer_info[nta];
-
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* transfer page from old buffer to new buffer */
-	new_buff->page = old_buff->page;
-	new_buff->page_dma = old_buff->page_dma;
-	new_buff->page_offset = old_buff->page_offset;
-	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
-}
-
 static void wx_dma_sync_frag(struct wx_ring *rx_ring,
 			     struct wx_rx_buffer *rx_buffer)
 {
@@ -270,8 +216,6 @@ static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
 				      size,
 				      DMA_FROM_DEVICE);
 skip_sync:
-	rx_buffer->pagecnt_bias--;
-
 	return rx_buffer;
 }
 
@@ -280,19 +224,9 @@ static void wx_put_rx_buffer(struct wx_ring *rx_ring,
 			     struct sk_buff *skb,
 			     int rx_buffer_pgcnt)
 {
-	if (wx_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
-		/* hand second half of page back to the ring */
-		wx_reuse_rx_page(rx_ring, rx_buffer);
-	} else {
-		if (!IS_ERR(skb) && WX_CB(skb)->dma == rx_buffer->dma)
-			/* the page has been released from the ring */
-			WX_CB(skb)->page_released = true;
-		else
-			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
-	}
+	if (!IS_ERR(skb) && WX_CB(skb)->dma == rx_buffer->dma)
+		/* the page has been released from the ring */
+		WX_CB(skb)->page_released = true;
 
 	/* clear contents of rx_buffer */
 	rx_buffer->page = NULL;
@@ -335,11 +269,12 @@ static struct sk_buff *wx_build_skb(struct wx_ring *rx_ring,
 		if (size <= WX_RXBUFFER_256) {
 			memcpy(__skb_put(skb, size), page_addr,
 			       ALIGN(size, sizeof(long)));
-			rx_buffer->pagecnt_bias++;
-
+			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, true);
 			return skb;
 		}
 
+		skb_mark_for_recycle(skb);
+
 		if (!wx_test_staterr(rx_desc, WX_RXD_STAT_EOP))
 			WX_CB(skb)->dma = rx_buffer->dma;
 
@@ -382,8 +317,6 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 	bi->page_dma = dma;
 	bi->page = page;
 	bi->page_offset = 0;
-	page_ref_add(page, USHRT_MAX - 1);
-	bi->pagecnt_bias = USHRT_MAX;
 
 	return true;
 }
@@ -721,7 +654,6 @@ static int wx_clean_rx_irq(struct wx_q_vector *q_vector,
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
-			rx_buffer->pagecnt_bias++;
 			break;
 		}
 
@@ -2241,8 +2173,6 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 
 		/* free resources associated with mapping */
 		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
 
 		i++;
 		rx_buffer++;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c5cbd177ef62..c555af9ed51b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -759,7 +759,6 @@ struct wx_rx_buffer {
 	dma_addr_t page_dma;
 	struct page *page;
 	unsigned int page_offset;
-	u16 pagecnt_bias;
 };
 
 struct wx_queue_stats {
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 3777c7e2e6fc..e47bb125048d 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -161,7 +161,9 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8 buf[ETH_ALEN];
 	struct ax88172a_private *priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0c0be6b872c6..deb2229ab4d8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -334,7 +334,6 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
 static bool is_xdp_frame(void *ptr)
@@ -408,6 +407,17 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	return p;
 }
 
+static void virtnet_rq_free_buf(struct virtnet_info *vi,
+				struct receive_queue *rq, void *buf)
+{
+	if (vi->mergeable_rx_bufs)
+		put_page(virt_to_head_page(buf));
+	else if (vi->big_packets)
+		give_pages(rq, buf);
+	else
+		put_page(virt_to_head_page(buf));
+}
+
 static void enable_delayed_refill(struct virtnet_info *vi)
 {
 	spin_lock_bh(&vi->refill_lock);
@@ -634,17 +644,6 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	return buf;
 }
 
-static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
-{
-	void *buf;
-
-	buf = virtqueue_detach_unused_buf(rq->vq);
-	if (buf && rq->do_dma)
-		virtnet_rq_unmap(rq, buf, 0);
-
-	return buf;
-}
-
 static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 {
 	struct virtnet_rq_dma *dma;
@@ -744,6 +743,20 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	}
 }
 
+static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct receive_queue *rq;
+	int i = vq2rxq(vq);
+
+	rq = &vi->rq[i];
+
+	if (rq->do_dma)
+		virtnet_rq_unmap(rq, buf, 0);
+
+	virtnet_rq_free_buf(vi, rq, buf);
+}
+
 static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 {
 	unsigned int len;
@@ -1258,7 +1271,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	if (unlikely(len > GOOD_PACKET_LEN)) {
 		pr_debug("%s: rx error: len %u exceeds max size %d\n",
 			 dev->name, len, GOOD_PACKET_LEN);
-		dev->stats.rx_length_errors++;
+		DEV_STATS_INC(dev, rx_length_errors);
 		goto err;
 	}
 
@@ -1323,7 +1336,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers missing\n",
 				 dev->name, num_buf);
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			break;
 		}
 		u64_stats_add(&stats->bytes, len);
@@ -1432,7 +1445,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
 				 dev->name, *num_buf,
 				 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
@@ -1451,7 +1464,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			put_page(page);
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
@@ -1630,7 +1643,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (unlikely(len > truesize - room)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 			 dev->name, len, (unsigned long)(truesize - room));
-		dev->stats.rx_length_errors++;
+		DEV_STATS_INC(dev, rx_length_errors);
 		goto err_skb;
 	}
 
@@ -1662,7 +1675,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 				 dev->name, num_buf,
 				 virtio16_to_cpu(vi->vdev,
 						 hdr->num_buffers));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err_buf;
 		}
 
@@ -1676,7 +1689,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		if (unlikely(len > truesize - room)) {
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err_skb;
 		}
 
@@ -1763,8 +1776,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
-		dev->stats.rx_length_errors++;
-		virtnet_rq_free_unused_buf(rq->vq, buf);
+		DEV_STATS_INC(dev, rx_length_errors);
+		virtnet_rq_free_buf(vi, rq, buf);
 		return;
 	}
 
@@ -1803,7 +1816,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	return;
 
 frame_err:
-	dev->stats.rx_frame_errors++;
+	DEV_STATS_INC(dev, rx_frame_errors);
 	dev_kfree_skb(skb);
 }
 
@@ -2352,12 +2365,12 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* This should not happen! */
 	if (unlikely(err)) {
-		dev->stats.tx_fifo_errors++;
+		DEV_STATS_INC(dev, tx_fifo_errors);
 		if (net_ratelimit())
 			dev_warn(&dev->dev,
 				 "Unexpected TXQ (%d) queue failure: %d\n",
 				 qnum, err);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
@@ -2392,7 +2405,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (running)
 		napi_disable(&rq->napi);
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -2576,10 +2589,10 @@ static void virtnet_stats(struct net_device *dev,
 		tot->tx_errors  += terrors;
 	}
 
-	tot->tx_dropped = dev->stats.tx_dropped;
-	tot->tx_fifo_errors = dev->stats.tx_fifo_errors;
-	tot->rx_length_errors = dev->stats.rx_length_errors;
-	tot->rx_frame_errors = dev->stats.rx_frame_errors;
+	tot->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+	tot->tx_fifo_errors = DEV_STATS_READ(dev, tx_fifo_errors);
+	tot->rx_length_errors = DEV_STATS_READ(dev, rx_length_errors);
+	tot->rx_frame_errors = DEV_STATS_READ(dev, rx_frame_errors);
 }
 
 static void virtnet_ack_link_announce(struct virtnet_info *vi)
@@ -4031,19 +4044,6 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 		xdp_return_frame(ptr_to_xdp(buf));
 }
 
-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
-{
-	struct virtnet_info *vi = vq->vdev->priv;
-	int i = vq2rxq(vq);
-
-	if (vi->mergeable_rx_bufs)
-		put_page(virt_to_head_page(buf));
-	else if (vi->big_packets)
-		give_pages(&vi->rq[i], buf);
-	else
-		put_page(virt_to_head_page(buf));
-}
-
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
@@ -4057,10 +4057,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
+		struct virtqueue *vq = vi->rq[i].vq;
 
-		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
-			virtnet_rq_free_unused_buf(rq->vq, buf);
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_rq_unmap_free_buf(vq, buf);
 		cond_resched();
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 0f6493dab8cb..5602441df2b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -749,7 +749,7 @@ static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
 	}
 }
 
-void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans);
+void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq);
 
 static inline bool iwl_is_rfkill_set(struct iwl_trans *trans)
 {
@@ -796,7 +796,7 @@ static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 	return (trans->dbg.dest_tlv || iwl_trans_dbg_ini_valid(trans));
 }
 
-void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state);
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq);
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 4614acee9f7b..a9415d333490 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1785,7 +1785,7 @@ static u32 iwl_pcie_int_cause_ict(struct iwl_trans *trans)
 	return inta;
 }
 
-void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
+void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
@@ -1809,7 +1809,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
 	isr_stats->rfkill++;
 
 	if (prev != report)
-		iwl_trans_pcie_rf_kill(trans, report);
+		iwl_trans_pcie_rf_kill(trans, report, from_irq);
 	mutex_unlock(&trans_pcie->mutex);
 
 	if (hw_rfkill) {
@@ -1949,7 +1949,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 
 	/* HW RF KILL switch toggled */
 	if (inta & CSR_INT_BIT_RF_KILL) {
-		iwl_pcie_handle_rfkill_irq(trans);
+		iwl_pcie_handle_rfkill_irq(trans, true);
 		handled |= CSR_INT_BIT_RF_KILL;
 	}
 
@@ -2366,7 +2366,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	/* HW RF KILL switch toggled */
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_RF_KILL)
-		iwl_pcie_handle_rfkill_irq(trans);
+		iwl_pcie_handle_rfkill_irq(trans, true);
 
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_HW_ERR) {
 		IWL_ERR(trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2e23ccd7d793..1bc4a0089c6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1082,7 +1082,7 @@ bool iwl_pcie_check_hw_rf_kill(struct iwl_trans *trans)
 	report = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
 
 	if (prev != report)
-		iwl_trans_pcie_rf_kill(trans, report);
+		iwl_trans_pcie_rf_kill(trans, report, false);
 
 	return hw_rfkill;
 }
@@ -1236,7 +1236,7 @@ static void iwl_pcie_init_msix(struct iwl_trans_pcie *trans_pcie)
 	trans_pcie->hw_mask = trans_pcie->hw_init_mask;
 }
 
-static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
+static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool from_irq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -1263,7 +1263,8 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
-		iwl_pcie_synchronize_irqs(trans);
+		if (!from_irq)
+			iwl_pcie_synchronize_irqs(trans);
 		iwl_pcie_rx_napi_sync(trans);
 		iwl_pcie_tx_stop(trans);
 		iwl_pcie_rx_stop(trans);
@@ -1453,7 +1454,7 @@ void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
 		clear_bit(STATUS_RFKILL_OPMODE, &trans->status);
 	}
 	if (hw_rfkill != was_in_rfkill)
-		iwl_trans_pcie_rf_kill(trans, hw_rfkill);
+		iwl_trans_pcie_rf_kill(trans, hw_rfkill, false);
 }
 
 static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
@@ -1468,12 +1469,12 @@ static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	mutex_lock(&trans_pcie->mutex);
 	trans_pcie->opmode_down = true;
 	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
-	_iwl_trans_pcie_stop_device(trans);
+	_iwl_trans_pcie_stop_device(trans, false);
 	iwl_trans_pcie_handle_stop_rfkill(trans, was_in_rfkill);
 	mutex_unlock(&trans_pcie->mutex);
 }
 
-void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
 {
 	struct iwl_trans_pcie __maybe_unused *trans_pcie =
 		IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -1486,7 +1487,7 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
 		if (trans->trans_cfg->gen2)
 			_iwl_trans_pcie_gen2_stop_device(trans);
 		else
-			_iwl_trans_pcie_stop_device(trans);
+			_iwl_trans_pcie_stop_device(trans, from_irq);
 	}
 }
 
@@ -2869,7 +2870,7 @@ static ssize_t iwl_dbgfs_rfkill_write(struct file *file,
 	IWL_WARN(trans, "changing debug rfkill %d->%d\n",
 		 trans_pcie->debug_rfkill, new_value);
 	trans_pcie->debug_rfkill = new_value;
-	iwl_pcie_handle_rfkill_irq(trans);
+	iwl_pcie_handle_rfkill_irq(trans, false);
 
 	return count;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a607f277ccf1..59d6cb1a3a9d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1335,6 +1335,9 @@ static int pci_set_full_power_state(struct pci_dev *dev)
 		pci_restore_bars(dev);
 	}
 
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
 	return 0;
 }
 
@@ -1429,6 +1432,9 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
 				     pci_power_name(dev->current_state),
 				     pci_power_name(state));
 
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 39a8932dc340..5484048f457d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -566,10 +566,12 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
+void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
+static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 67b13f26ba7c..7e3b342215e5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1001,6 +1001,25 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
+/* @pdev: the root port or switch downstream port */
+void pcie_aspm_pm_state_change(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link = pdev->link_state;
+
+	if (aspm_disabled || !link)
+		return;
+	/*
+	 * Devices changed PM state, we should recheck if latency
+	 * meets all functions' requirement
+	 */
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+	pcie_update_aspm_capable(link->root);
+	pcie_config_aspm_path(link);
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+}
+
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index f021ec5a70e5..553725e1269c 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -100,7 +100,7 @@ static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
 static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long *prate)
 {
-	return clamp_val(rate, 50000000, 1600000000);
+	return clamp_val(rate, 125000000, 1600000000);
 }
 
 static const struct clk_ops mtk_mipi_tx_pll_ops = {
diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
index 0efe74ac9c6a..637a5fbae6d9 100644
--- a/drivers/phy/sunplus/phy-sunplus-usb2.c
+++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
@@ -275,7 +275,7 @@ static int sp_usb_phy_probe(struct platform_device *pdev)
 
 	phy = devm_phy_create(&pdev->dev, NULL, &sp_uphy_ops);
 	if (IS_ERR(phy)) {
-		ret = -PTR_ERR(phy);
+		ret = PTR_ERR(phy);
 		return ret;
 	}
 
diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 555b323f45da..bc847d3879f7 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -64,6 +64,7 @@ struct phy_gmii_sel_priv {
 	u32 num_ports;
 	u32 reg_offset;
 	u32 qsgmii_main_ports;
+	bool no_offset;
 };
 
 static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
@@ -402,7 +403,8 @@ static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
 		priv->num_ports = size / sizeof(u32);
 		if (!priv->num_ports)
 			return -EINVAL;
-		priv->reg_offset = __be32_to_cpu(*offset);
+		if (!priv->no_offset)
+			priv->reg_offset = __be32_to_cpu(*offset);
 	}
 
 	if_phys = devm_kcalloc(dev, priv->num_ports,
@@ -471,6 +473,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get syscon %d\n", ret);
 			return ret;
 		}
+		priv->no_offset = true;
 	}
 
 	ret = phy_gmii_sel_init_ports(priv);
diff --git a/fs/dax.c b/fs/dax.c
index 8fafecbe42b1..3380b43cb6bb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -412,23 +412,23 @@ static struct page *dax_busy_page(void *entry)
 	return NULL;
 }
 
-/*
- * dax_lock_page - Lock the DAX entry corresponding to a page
- * @page: The page whose entry we want to lock
+/**
+ * dax_lock_folio - Lock the DAX entry corresponding to a folio
+ * @folio: The folio whose entry we want to lock
  *
  * Context: Process context.
- * Return: A cookie to pass to dax_unlock_page() or 0 if the entry could
+ * Return: A cookie to pass to dax_unlock_folio() or 0 if the entry could
  * not be locked.
  */
-dax_entry_t dax_lock_page(struct page *page)
+dax_entry_t dax_lock_folio(struct folio *folio)
 {
 	XA_STATE(xas, NULL, 0);
 	void *entry;
 
-	/* Ensure page->mapping isn't freed while we look at it */
+	/* Ensure folio->mapping isn't freed while we look at it */
 	rcu_read_lock();
 	for (;;) {
-		struct address_space *mapping = READ_ONCE(page->mapping);
+		struct address_space *mapping = READ_ONCE(folio->mapping);
 
 		entry = NULL;
 		if (!mapping || !dax_mapping(mapping))
@@ -447,11 +447,11 @@ dax_entry_t dax_lock_page(struct page *page)
 
 		xas.xa = &mapping->i_pages;
 		xas_lock_irq(&xas);
-		if (mapping != page->mapping) {
+		if (mapping != folio->mapping) {
 			xas_unlock_irq(&xas);
 			continue;
 		}
-		xas_set(&xas, page->index);
+		xas_set(&xas, folio->index);
 		entry = xas_load(&xas);
 		if (dax_is_locked(entry)) {
 			rcu_read_unlock();
@@ -467,10 +467,10 @@ dax_entry_t dax_lock_page(struct page *page)
 	return (dax_entry_t)entry;
 }
 
-void dax_unlock_page(struct page *page, dax_entry_t cookie)
+void dax_unlock_folio(struct folio *folio, dax_entry_t cookie)
 {
-	struct address_space *mapping = page->mapping;
-	XA_STATE(xas, &mapping->i_pages, page->index);
+	struct address_space *mapping = folio->mapping;
+	XA_STATE(xas, &mapping->i_pages, folio->index);
 
 	if (S_ISCHR(mapping->host->i_mode))
 		return;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 4eac7dcb82f9..ec1e5e20a36b 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -993,7 +993,6 @@ release_iface(struct kref *ref)
 	struct cifs_server_iface *iface = container_of(ref,
 						       struct cifs_server_iface,
 						       refcount);
-	list_del_init(&iface->iface_head);
 	kfree(iface);
 }
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 76ccbdba5855..b82f60d6f47e 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -209,10 +209,13 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry_safe(ses, nses, &pserver->smb_ses_list, smb_ses_list) {
 		/* check if iface is still active */
-		if (!cifs_chan_is_iface_active(ses, server))
+		spin_lock(&ses->chan_lock);
+		if (!cifs_chan_is_iface_active(ses, server)) {
+			spin_unlock(&ses->chan_lock);
 			cifs_chan_update_iface(ses, server);
+			spin_lock(&ses->chan_lock);
+		}
 
-		spin_lock(&ses->chan_lock);
 		if (!mark_smb_session && cifs_chan_needs_reconnect(ses, server)) {
 			spin_unlock(&ses->chan_lock);
 			continue;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index e917eeba9c77..94e4af4128f1 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -593,16 +593,12 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	}
 
 	/*
-	 * Go through iface_list and do kref_put to remove
-	 * any unused ifaces. ifaces in use will be removed
-	 * when the last user calls a kref_put on it
+	 * Go through iface_list and mark them as inactive
 	 */
 	list_for_each_entry_safe(iface, niface, &ses->iface_list,
-				 iface_head) {
+				 iface_head)
 		iface->is_active = 0;
-		kref_put(&iface->refcount, release_iface);
-		ses->iface_count--;
-	}
+
 	spin_unlock(&ses->iface_lock);
 
 	/*
@@ -676,10 +672,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 					 iface_head) {
 			ret = iface_cmp(iface, &tmp_iface);
 			if (!ret) {
-				/* just get a ref so that it doesn't get picked/freed */
 				iface->is_active = 1;
-				kref_get(&iface->refcount);
-				ses->iface_count++;
 				spin_unlock(&ses->iface_lock);
 				goto next_iface;
 			} else if (ret < 0) {
@@ -746,6 +739,20 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	}
 
 out:
+	/*
+	 * Go through the list again and put the inactive entries
+	 */
+	spin_lock(&ses->iface_lock);
+	list_for_each_entry_safe(iface, niface, &ses->iface_list,
+				 iface_head) {
+		if (!iface->is_active) {
+			list_del(&iface->iface_head);
+			kref_put(&iface->refcount, release_iface);
+			ses->iface_count--;
+		}
+	}
+	spin_unlock(&ses->iface_lock);
+
 	return rc;
 }
 
@@ -782,9 +789,14 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_
 		goto out;
 
 	/* check if iface is still active */
+	spin_lock(&ses->chan_lock);
 	pserver = ses->chans[0].server;
-	if (pserver && !cifs_chan_is_iface_active(ses, pserver))
+	if (pserver && !cifs_chan_is_iface_active(ses, pserver)) {
+		spin_unlock(&ses->chan_lock);
 		cifs_chan_update_iface(ses, pserver);
+		spin_lock(&ses->chan_lock);
+	}
+	spin_unlock(&ses->chan_lock);
 
 out:
 	kfree(out_buf);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 22cd9902345d..b463502b16e1 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -159,8 +159,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
-dax_entry_t dax_lock_page(struct page *page);
-void dax_unlock_page(struct page *page, dax_entry_t cookie);
+dax_entry_t dax_lock_folio(struct folio *folio);
+void dax_unlock_folio(struct folio *folio, dax_entry_t cookie);
 dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
 		unsigned long index, struct page **page);
 void dax_unlock_mapping_entry(struct address_space *mapping,
@@ -182,14 +182,14 @@ static inline int dax_writeback_mapping_range(struct address_space *mapping,
 	return -EOPNOTSUPP;
 }
 
-static inline dax_entry_t dax_lock_page(struct page *page)
+static inline dax_entry_t dax_lock_folio(struct folio *folio)
 {
-	if (IS_DAX(page->mapping->host))
+	if (IS_DAX(folio->mapping->host))
 		return ~0UL;
 	return 0;
 }
 
-static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
+static inline void dax_unlock_folio(struct folio *folio, dax_entry_t cookie)
 {
 }
 
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 9da4f3f1e6d6..7262c9993c39 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -276,6 +276,7 @@ struct hisi_qm_poll_data {
 	struct hisi_qm *qm;
 	struct work_struct work;
 	u16 *qp_finish_id;
+	u16 eqe_num;
 };
 
 /**
diff --git a/include/net/netfilter/nf_tables_ipv4.h b/include/net/netfilter/nf_tables_ipv4.h
index 947973623dc7..60a7d0ce3080 100644
--- a/include/net/netfilter/nf_tables_ipv4.h
+++ b/include/net/netfilter/nf_tables_ipv4.h
@@ -30,7 +30,7 @@ static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
 		return -1;
 
 	len = iph_totlen(pkt->skb, iph);
-	thoff = iph->ihl * 4;
+	thoff = skb_network_offset(pkt->skb) + (iph->ihl * 4);
 	if (pkt->skb->len < len)
 		return -1;
 	else if (len < thoff)
diff --git a/include/net/sock.h b/include/net/sock.h
index 1b7ca8f35dd6..70a771d96467 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2152,14 +2152,14 @@ static inline bool sk_rethink_txhash(struct sock *sk)
 }
 
 static inline struct dst_entry *
-__sk_dst_get(struct sock *sk)
+__sk_dst_get(const struct sock *sk)
 {
 	return rcu_dereference_check(sk->sk_dst_cache,
 				     lockdep_sock_is_held(sk));
 }
 
 static inline struct dst_entry *
-sk_dst_get(struct sock *sk)
+sk_dst_get(const struct sock *sk)
 {
 	struct dst_entry *dst;
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index a88bf8f6db23..9cbcfb3c95da 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -723,6 +723,8 @@ static inline void tcp_fast_path_check(struct sock *sk)
 		tcp_fast_path_on(tp);
 }
 
+u32 tcp_delack_max(const struct sock *sk);
+
 /* Compute the actual rto_min value */
 static inline u32 tcp_rto_min(struct sock *sk)
 {
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 1617af380162..69b472604b86 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -14,6 +14,8 @@
 #include <linux/mm.h>
 #include <net/sock.h>
 
+#define XDP_UMEM_SG_FLAG (1 << 1)
+
 struct net_device;
 struct xsk_queue;
 struct xdp_buff;
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 98e13be411af..3d1851f82dbb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -493,6 +493,7 @@ static inline void rcu_expedite_gp(void) { }
 static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_async_hurry(void) { }
 static inline void rcu_async_relax(void) { }
+static inline bool rcu_cpu_online(int cpu) { return true; }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
@@ -502,6 +503,7 @@ void rcu_unexpedite_gp(void);
 void rcu_async_hurry(void);
 void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
+bool rcu_cpu_online(int cpu);
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8d65f7d576a3..65e000ca332c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -892,10 +892,36 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 	synchronize_rcu();
 }
 
+/* Check for quiescent states since the pregp's synchronize_rcu() */
+static bool rcu_tasks_is_holdout(struct task_struct *t)
+{
+	int cpu;
+
+	/* Has the task been seen voluntarily sleeping? */
+	if (!READ_ONCE(t->on_rq))
+		return false;
+
+	/*
+	 * Idle tasks (or idle injection) within the idle loop are RCU-tasks
+	 * quiescent states. But CPU boot code performed by the idle task
+	 * isn't a quiescent state.
+	 */
+	if (is_idle_task(t))
+		return false;
+
+	cpu = task_cpu(t);
+
+	/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
+	if (t == idle_task(cpu) && !rcu_cpu_online(cpu))
+		return false;
+
+	return true;
+}
+
 /* Per-task initial processing. */
 static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 {
-	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
+	if (t != current && rcu_tasks_is_holdout(t)) {
 		get_task_struct(t);
 		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
 		WRITE_ONCE(t->rcu_tasks_holdout, true);
@@ -944,7 +970,7 @@ static void check_holdout_task(struct task_struct *t,
 
 	if (!READ_ONCE(t->rcu_tasks_holdout) ||
 	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
-	    !READ_ONCE(t->on_rq) ||
+	    !rcu_tasks_is_holdout(t) ||
 	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
 	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
 		WRITE_ONCE(t->rcu_tasks_holdout, false);
@@ -1522,7 +1548,7 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 	} else {
 		// The task is not running, so C-language access is safe.
 		nesting = t->trc_reader_nesting;
-		WARN_ON_ONCE(ofl && task_curr(t) && !is_idle_task(t));
+		WARN_ON_ONCE(ofl && task_curr(t) && (t != idle_task(task_cpu(t))));
 		if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) && ofl)
 			n_heavy_reader_ofl_updates++;
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7b4517dc4657..9af42eae1ba3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -755,14 +755,19 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 }
 
 /*
- * Return true if the specified CPU has passed through a quiescent
- * state by virtue of being in or having passed through an dynticks
- * idle state since the last call to dyntick_save_progress_counter()
- * for this same CPU, or by virtue of having been offline.
+ * Returns positive if the specified CPU has passed through a quiescent state
+ * by virtue of being in or having passed through an dynticks idle state since
+ * the last call to dyntick_save_progress_counter() for this same CPU, or by
+ * virtue of having been offline.
+ *
+ * Returns negative if the specified CPU needs a force resched.
+ *
+ * Returns zero otherwise.
  */
 static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 {
 	unsigned long jtsq;
+	int ret = 0;
 	struct rcu_node *rnp = rdp->mynode;
 
 	/*
@@ -848,8 +853,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	    (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
 	     rcu_state.cbovld)) {
 		WRITE_ONCE(rdp->rcu_urgent_qs, true);
-		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
+		ret = -1;
 	}
 
 	/*
@@ -862,8 +867,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (time_after(jiffies, rcu_state.jiffies_resched)) {
 		if (time_after(jiffies,
 			       READ_ONCE(rdp->last_fqs_resched) + jtsq)) {
-			resched_cpu(rdp->cpu);
 			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
+			ret = -1;
 		}
 		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
@@ -892,7 +897,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
@@ -2270,15 +2275,15 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 {
 	int cpu;
 	unsigned long flags;
-	unsigned long mask;
-	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
 	rcu_state.cbovld = rcu_state.cbovldnext;
 	rcu_state.cbovldnext = false;
 	rcu_for_each_leaf_node(rnp) {
+		unsigned long mask = 0;
+		unsigned long rsmask = 0;
+
 		cond_resched_tasks_rcu_qs();
-		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rcu_state.cbovldnext |= !!rnp->cbovldmask;
 		if (rnp->qsmask == 0) {
@@ -2296,11 +2301,17 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			continue;
 		}
 		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
+			struct rcu_data *rdp;
+			int ret;
+
 			rdp = per_cpu_ptr(&rcu_data, cpu);
-			if (f(rdp)) {
+			ret = f(rdp);
+			if (ret > 0) {
 				mask |= rdp->grpmask;
 				rcu_disable_urgency_upon_qs(rdp);
 			}
+			if (ret < 0)
+				rsmask |= rdp->grpmask;
 		}
 		if (mask != 0) {
 			/* Idle/offline CPUs, report (releases rnp->lock). */
@@ -2309,6 +2320,9 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			/* Nothing to do here, so just drop the lock. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
+
+		for_each_leaf_node_cpu_mask(rnp, cpu, rsmask)
+			resched_cpu(cpu);
 	}
 }
 
@@ -4125,6 +4139,13 @@ static bool rcu_rdp_cpu_online(struct rcu_data *rdp)
 	return !!(rdp->grpmask & rcu_rnp_online_cpus(rdp->mynode));
 }
 
+bool rcu_cpu_online(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return rcu_rdp_cpu_online(rdp);
+}
+
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU)
 
 /*
diff --git a/kernel/resource.c b/kernel/resource.c
index b1763b2fd7ef..e3f5680a564c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1847,8 +1847,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
 
 	write_lock(&resource_lock);
 	for (addr = gfr_start(base, size, align, flags);
-	     gfr_continue(base, addr, size, flags);
-	     addr = gfr_next(addr, size, flags)) {
+	     gfr_continue(base, addr, align, flags);
+	     addr = gfr_next(addr, align, flags)) {
 		if (__region_intersects(base, addr, size, 0, IORES_DESC_NONE) !=
 		    REGION_DISJOINT)
 			continue;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16e002e08cf8..455093f73a70 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -595,10 +595,9 @@ struct task_struct *task_early_kill(struct task_struct *tsk, int force_early)
 /*
  * Collect processes when the error hit an anonymous page.
  */
-static void collect_procs_anon(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_anon(struct folio *folio, struct page *page,
+		struct list_head *to_kill, int force_early)
 {
-	struct folio *folio = page_folio(page);
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct anon_vma *av;
@@ -633,12 +632,12 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 /*
  * Collect processes when the error hit a file mapped page.
  */
-static void collect_procs_file(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_file(struct folio *folio, struct page *page,
+		struct list_head *to_kill, int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	pgoff_t pgoff;
 
 	i_mmap_lock_read(mapping);
@@ -704,17 +703,17 @@ static void collect_procs_fsdax(struct page *page,
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
-static void collect_procs(struct page *page, struct list_head *tokill,
-				int force_early)
+static void collect_procs(struct folio *folio, struct page *page,
+		struct list_head *tokill, int force_early)
 {
-	if (!page->mapping)
+	if (!folio->mapping)
 		return;
 	if (unlikely(PageKsm(page)))
 		collect_procs_ksm(page, tokill, force_early);
 	else if (PageAnon(page))
-		collect_procs_anon(page, tokill, force_early);
+		collect_procs_anon(folio, page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(folio, page, tokill, force_early);
 }
 
 struct hwpoison_walk {
@@ -1602,7 +1601,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * mapped in dirty form.  This has to be done before try_to_unmap,
 	 * because ttu takes the rmap data structures down.
 	 */
-	collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
+	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
 
 	if (PageHuge(hpage) && !PageAnon(hpage)) {
 		/*
@@ -1713,20 +1712,23 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
 }
 
+/*
+ * Only dev_pagemap pages get here, such as fsdax when the filesystem
+ * either do not claim or fails to claim a hwpoison event, or devdax.
+ * The fsdax pages are initialized per base page, and the devdax pages
+ * could be initialized either as base pages, or as compound pages with
+ * vmemmap optimization enabled. Devdax is simplistic in its dealing with
+ * hwpoison, such that, if a subpage of a compound page is poisoned,
+ * simply mark the compound head page is by far sufficient.
+ */
 static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
-	struct page *page = pfn_to_page(pfn);
+	struct folio *folio = pfn_folio(pfn);
 	LIST_HEAD(to_kill);
 	dax_entry_t cookie;
 	int rc = 0;
 
-	/*
-	 * Pages instantiated by device-dax (not filesystem-dax)
-	 * may be compound pages.
-	 */
-	page = compound_head(page);
-
 	/*
 	 * Prevent the inode from being freed while we are interrogating
 	 * the address_space, typically this would be handled by
@@ -1734,11 +1736,11 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * also prevents changes to the mapping of this pfn until
 	 * poison signaling is complete.
 	 */
-	cookie = dax_lock_page(page);
+	cookie = dax_lock_folio(folio);
 	if (!cookie)
 		return -EBUSY;
 
-	if (hwpoison_filter(page)) {
+	if (hwpoison_filter(&folio->page)) {
 		rc = -EOPNOTSUPP;
 		goto unlock;
 	}
@@ -1760,7 +1762,7 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * Use this flag as an indication that the dax page has been
 	 * remapped UC to prevent speculative consumption of poison.
 	 */
-	SetPageHWPoison(page);
+	SetPageHWPoison(&folio->page);
 
 	/*
 	 * Unlike System-RAM there is no possibility to swap in a
@@ -1769,11 +1771,11 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &to_kill, true);
+	collect_procs(folio, &folio->page, &to_kill, true);
 
-	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
+	unmap_and_kill(&to_kill, pfn, folio->mapping, folio->index, flags);
 unlock:
-	dax_unlock_page(page, cookie);
+	dax_unlock_folio(folio, cookie);
 	return rc;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 517221f01303..dccf9203dd53 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3565,8 +3565,8 @@ EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows)
 {
-	pgoff_t hba = holebegin >> PAGE_SHIFT;
-	pgoff_t hlen = (holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t hba = (pgoff_t)(holebegin) >> PAGE_SHIFT;
+	pgoff_t hlen = ((pgoff_t)(holelen) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Check for overflow. */
 	if (sizeof(holelen) > sizeof(hlen)) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index dcc264d3c92f..0dfb9a75dfa6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4656,6 +4656,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	int young = 0;
 	pte_t *pte = pvmw->pte;
 	unsigned long addr = pvmw->address;
+	struct vm_area_struct *vma = pvmw->vma;
 	struct folio *folio = pfn_folio(pvmw->pfn);
 	bool can_swap = !folio_is_file_lru(folio);
 	struct mem_cgroup *memcg = folio_memcg(folio);
@@ -4670,11 +4671,15 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	if (spin_is_contended(pvmw->ptl))
 		return;
 
+	/* exclude special VMAs containing anon pages from COW */
+	if (vma->vm_flags & VM_SPECIAL)
+		return;
+
 	/* avoid taking the LRU lock under the PTL when possible */
 	walk = current->reclaim_state ? current->reclaim_state->mm_walk : NULL;
 
-	start = max(addr & PMD_MASK, pvmw->vma->vm_start);
-	end = min(addr | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
+	start = max(addr & PMD_MASK, vma->vm_start);
+	end = min(addr | ~PMD_MASK, vma->vm_end - 1) + 1;
 
 	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
 		if (addr - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
@@ -4699,7 +4704,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		unsigned long pfn;
 		pte_t ptent = ptep_get(pte + i);
 
-		pfn = get_pte_pfn(ptent, pvmw->vma, addr);
+		pfn = get_pte_pfn(ptent, vma, addr);
 		if (pfn == -1)
 			continue;
 
@@ -4710,7 +4715,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		if (!folio)
 			continue;
 
-		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
+		if (!ptep_test_and_clear_young(vma, addr, pte + i))
 			VM_WARN_ON_ONCE(true);
 
 		young++;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6d204cf54c57..011d69029112 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4508,8 +4508,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
+		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = len / mss;
+		partial_segs = min(len, GSO_BY_FRAGS - 1U) / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
diff --git a/net/core/sock.c b/net/core/sock.c
index bfaf47b3f3c7..5cd21e699f2d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1718,9 +1718,16 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		lv = sizeof(v.timestamping);
-		v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
-		v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
+		/* For the later-added case SO_TIMESTAMPING_NEW: Be strict about only
+		 * returning the flags when they were set through the same option.
+		 * Don't change the beviour for the old case SO_TIMESTAMPING_OLD.
+		 */
+		if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
+			v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
+			v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
+		}
 		break;
 
 	case SO_RCVTIMEO_OLD:
@@ -2821,6 +2828,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		sockc->mark = *(u32 *)CMSG_DATA(cmsg);
 		break;
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
 			return -EINVAL;
 
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 2a6d363763a2..f18ca02aa95a 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
 static int
 dns_resolver_preparse(struct key_preparsed_payload *prep)
 {
-	const struct dns_server_list_v1_header *v1;
-	const struct dns_payload_header *bin;
 	struct user_key_payload *upayload;
 	unsigned long derrno;
 	int ret;
@@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 		return -EINVAL;
 
 	if (data[0] == 0) {
+		const struct dns_server_list_v1_header *v1;
+
 		/* It may be a server list. */
-		if (datalen <= sizeof(*bin))
+		if (datalen <= sizeof(*v1))
 			return -EINVAL;
 
-		bin = (const struct dns_payload_header *)data;
-		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
-		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
+		v1 = (const struct dns_server_list_v1_header *)data;
+		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
+		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported content type (%u)\n",
-				bin->content);
+				v1->hdr.content);
 			return -EINVAL;
 		}
 
-		if (bin->version != 1) {
+		if (v1->hdr.version != 1) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported server list version (%u)\n",
-				bin->version);
+				v1->hdr.version);
 			return -EINVAL;
 		}
 
-		v1 = (const struct dns_server_list_v1_header *)bin;
 		if ((v1->status != DNS_LOOKUP_GOOD &&
 		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
 			if (prep->expiry == TIME64_MAX)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ec46d74c2093..f124f6c63915 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3774,7 +3774,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
-	info->tcpi_ato = jiffies_to_usecs(icsk->icsk_ack.ato);
+	info->tcpi_ato = jiffies_to_usecs(min(icsk->icsk_ack.ato,
+					      tcp_delack_max(sk)));
 	info->tcpi_snd_mss = tp->mss_cache;
 	info->tcpi_rcv_mss = icsk->icsk_ack.rcv_mss;
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cab3c1162c3a..ab3b7b4b4429 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4003,6 +4003,20 @@ int tcp_connect(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_connect);
 
+u32 tcp_delack_max(const struct sock *sk)
+{
+	const struct dst_entry *dst = __sk_dst_get(sk);
+	u32 delack_max = inet_csk(sk)->icsk_delack_max;
+
+	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
+		u32 rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
+		u32 delack_from_rto_min = max_t(int, 1, rto_min - 1);
+
+		delack_max = min_t(u32, delack_max, delack_from_rto_min);
+	}
+	return delack_max;
+}
+
 /* Send out a delayed ack, the caller does the policy checking
  * to see if we should even be here.  See tcp_input.c:tcp_ack_snd_check()
  * for details.
@@ -4038,7 +4052,7 @@ void tcp_send_delayed_ack(struct sock *sk)
 		ato = min(ato, max_ato);
 	}
 
-	ato = min_t(u32, ato, inet_csk(sk)->icsk_delack_max);
+	ato = min_t(u32, ato, tcp_delack_max(sk));
 
 	/* Stay within the limit we were given */
 	timeout = jiffies + ato;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f3a1e4aa0e5e..45b8115b363b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1974,6 +1974,17 @@ static void tcp_release_cb_override(struct sock *ssk)
 	tcp_release_cb(ssk);
 }
 
+static int tcp_abort_override(struct sock *ssk, int err)
+{
+	/* closing a listener subflow requires a great deal of care.
+	 * keep it simple and just prevent such operation
+	 */
+	if (inet_sk_state_load(ssk) == TCP_LISTEN)
+		return -EINVAL;
+
+	return tcp_abort(ssk, err);
+}
+
 static struct tcp_ulp_ops subflow_ulp_ops __read_mostly = {
 	.name		= "mptcp",
 	.owner		= THIS_MODULE,
@@ -2018,6 +2029,7 @@ void __init mptcp_subflow_init(void)
 
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
+	tcp_prot_override.diag_destroy = tcp_abort_override;
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
@@ -2054,6 +2066,7 @@ void __init mptcp_subflow_init(void)
 
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
+	tcpv6_prot_override.diag_destroy = tcp_abort_override;
 #endif
 
 	mptcp_diag_subflow_init(&subflow_ulp_ops);
diff --git a/net/netfilter/nf_nat_ovs.c b/net/netfilter/nf_nat_ovs.c
index 551abd2da614..0f9a559f6207 100644
--- a/net/netfilter/nf_nat_ovs.c
+++ b/net/netfilter/nf_nat_ovs.c
@@ -75,9 +75,10 @@ static int nf_ct_nat_execute(struct sk_buff *skb, struct nf_conn *ct,
 	}
 
 	err = nf_nat_packet(ct, ctinfo, hooknum, skb);
+out:
 	if (err == NF_ACCEPT)
 		*action |= BIT(maniptype);
-out:
+
 	return err;
 }
 
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 4d0ce12221f6..711c22ab701d 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -158,7 +158,7 @@ static bool nft_payload_fast_eval(const struct nft_expr *expr,
 	else {
 		if (!(pkt->flags & NFT_PKTINFO_L4PROTO))
 			return false;
-		ptr = skb_network_header(skb) + nft_thoff(pkt);
+		ptr = skb->data + nft_thoff(pkt);
 	}
 
 	ptr += priv->offset;
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index fccb3cf7749c..6475c7abc1fe 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -78,7 +78,7 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 		case NFT_GOTO:
 			err = nf_tables_bind_chain(ctx, chain);
 			if (err < 0)
-				return err;
+				goto err1;
 			break;
 		default:
 			break;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..18be13fb9b75 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -145,6 +145,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
+	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
+	 * we hold a reference to local, we also need to hold a reference to
+	 * the device to avoid UAF.
+	 */
+	if (!nfc_get_device(local->dev->idx))
+		return NULL;
+
 	kref_get(&local->ref);
 
 	return local;
@@ -177,10 +184,18 @@ static void local_release(struct kref *ref)
 
 int nfc_llcp_local_put(struct nfc_llcp_local *local)
 {
+	struct nfc_dev *dev;
+	int ret;
+
 	if (local == NULL)
 		return 0;
 
-	return kref_put(&local->ref, local_release);
+	dev = local->dev;
+
+	ret = kref_put(&local->ref, local_release);
+	nfc_put_device(dev);
+
+	return ret;
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
@@ -959,8 +974,17 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 	}
 
 	new_sock = nfc_llcp_sock(new_sk);
-	new_sock->dev = local->dev;
+
 	new_sock->local = nfc_llcp_local_get(local);
+	if (!new_sock->local) {
+		reason = LLCP_DM_REJ;
+		sock_put(&new_sock->sk);
+		release_sock(&sock->sk);
+		sock_put(&sock->sk);
+		goto fail;
+	}
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1597,7 +1621,16 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	if (local == NULL)
 		return -ENOMEM;
 
-	local->dev = ndev;
+	/* As we are going to initialize local's refcount, we need to get the
+	 * nfc_dev to avoid UAF, otherwise there is no point in continuing.
+	 * See nfc_llcp_local_get().
+	 */
+	local->dev = nfc_get_device(ndev->idx);
+	if (!local->dev) {
+		kfree(local);
+		return -ENODEV;
+	}
+
 	INIT_LIST_HEAD(&local->list);
 	kref_init(&local->ref);
 	mutex_init(&local->sdp_lock);
diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 6f3c1fb2fb44..f176afb70559 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -97,8 +97,10 @@ static int em_text_change(struct net *net, void *data, int len,
 
 static void em_text_destroy(struct tcf_ematch *m)
 {
-	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config)
+	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
 		textsearch_destroy(EM_TEXT_PRIV(m)->config);
+		kfree(EM_TEXT_PRIV(m));
+	}
 }
 
 static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 7ff2152971a5..2c464d76b06c 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -153,8 +153,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			.lnk[0].link_id = link->link_id,
 		};
 
-		memcpy(linfo.lnk[0].ibname,
-		       smc->conn.lgr->lnk[0].smcibdev->ibdev->name,
+		memcpy(linfo.lnk[0].ibname, link->smcibdev->ibdev->name,
 		       sizeof(link->smcibdev->ibdev->name));
 		smc_gid_be16_convert(linfo.lnk[0].gid, link->gid);
 		smc_gid_be16_convert(linfo.lnk[0].peer_gid, link->peer_gid);
diff --git a/net/socket.c b/net/socket.c
index c4a6f5532955..8d83c4bb163b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -757,6 +757,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
 	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
 	struct sockaddr_storage address;
+	int save_len = msg->msg_namelen;
 	int ret;
 
 	if (msg->msg_name) {
@@ -766,6 +767,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 
 	ret = __sock_sendmsg(sock, msg);
 	msg->msg_name = save_addr;
+	msg->msg_namelen = save_len;
 
 	return ret;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3515e19852d8..774a6d1916e4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1227,7 +1227,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 
 	xs->dev = dev;
 	xs->zc = xs->umem->zc;
-	xs->sg = !!(flags & XDP_USE_SG);
+	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
 	xp_add_xsk(xs->pool, xs);
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index b3f7b310811e..49cb9f9a09be 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -170,6 +170,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		return err;
 
+	if (flags & XDP_USE_SG)
+		pool->umem->flags |= XDP_UMEM_SG_FLAG;
+
 	if (flags & XDP_USE_NEED_WAKEUP)
 		pool->uses_need_wakeup = true;
 	/* Tx needs to be explicitly woken up the first time.  Also
diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 5af00387c519..245db52bedf2 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -127,7 +127,6 @@ struct serial_port {
 /* State of each mdev device */
 struct mdev_state {
 	struct vfio_device vdev;
-	int irq_fd;
 	struct eventfd_ctx *intx_evtfd;
 	struct eventfd_ctx *msi_evtfd;
 	int irq_index;
@@ -141,6 +140,7 @@ struct mdev_state {
 	struct mutex rxtx_lock;
 	struct vfio_device_info dev_info;
 	int nr_ports;
+	u8 intx_mask:1;
 };
 
 static struct mtty_type {
@@ -166,10 +166,6 @@ static const struct file_operations vd_fops = {
 
 static const struct vfio_device_ops mtty_dev_ops;
 
-/* function prototypes */
-
-static int mtty_trigger_interrupt(struct mdev_state *mdev_state);
-
 /* Helper functions */
 
 static void dump_buffer(u8 *buf, uint32_t count)
@@ -186,6 +182,36 @@ static void dump_buffer(u8 *buf, uint32_t count)
 #endif
 }
 
+static bool is_intx(struct mdev_state *mdev_state)
+{
+	return mdev_state->irq_index == VFIO_PCI_INTX_IRQ_INDEX;
+}
+
+static bool is_msi(struct mdev_state *mdev_state)
+{
+	return mdev_state->irq_index == VFIO_PCI_MSI_IRQ_INDEX;
+}
+
+static bool is_noirq(struct mdev_state *mdev_state)
+{
+	return !is_intx(mdev_state) && !is_msi(mdev_state);
+}
+
+static void mtty_trigger_interrupt(struct mdev_state *mdev_state)
+{
+	lockdep_assert_held(&mdev_state->ops_lock);
+
+	if (is_msi(mdev_state)) {
+		if (mdev_state->msi_evtfd)
+			eventfd_signal(mdev_state->msi_evtfd, 1);
+	} else if (is_intx(mdev_state)) {
+		if (mdev_state->intx_evtfd && !mdev_state->intx_mask) {
+			eventfd_signal(mdev_state->intx_evtfd, 1);
+			mdev_state->intx_mask = true;
+		}
+	}
+}
+
 static void mtty_create_config_space(struct mdev_state *mdev_state)
 {
 	/* PCI dev ID */
@@ -921,6 +947,25 @@ static ssize_t mtty_write(struct vfio_device *vdev, const char __user *buf,
 	return -EFAULT;
 }
 
+static void mtty_disable_intx(struct mdev_state *mdev_state)
+{
+	if (mdev_state->intx_evtfd) {
+		eventfd_ctx_put(mdev_state->intx_evtfd);
+		mdev_state->intx_evtfd = NULL;
+		mdev_state->intx_mask = false;
+		mdev_state->irq_index = -1;
+	}
+}
+
+static void mtty_disable_msi(struct mdev_state *mdev_state)
+{
+	if (mdev_state->msi_evtfd) {
+		eventfd_ctx_put(mdev_state->msi_evtfd);
+		mdev_state->msi_evtfd = NULL;
+		mdev_state->irq_index = -1;
+	}
+}
+
 static int mtty_set_irqs(struct mdev_state *mdev_state, uint32_t flags,
 			 unsigned int index, unsigned int start,
 			 unsigned int count, void *data)
@@ -932,59 +977,113 @@ static int mtty_set_irqs(struct mdev_state *mdev_state, uint32_t flags,
 	case VFIO_PCI_INTX_IRQ_INDEX:
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_MASK:
+			if (!is_intx(mdev_state) || start != 0 || count != 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (flags & VFIO_IRQ_SET_DATA_NONE) {
+				mdev_state->intx_mask = true;
+			} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
+				uint8_t mask = *(uint8_t *)data;
+
+				if (mask)
+					mdev_state->intx_mask = true;
+			} else if (flags &  VFIO_IRQ_SET_DATA_EVENTFD) {
+				ret = -ENOTTY; /* No support for mask fd */
+			}
+			break;
 		case VFIO_IRQ_SET_ACTION_UNMASK:
+			if (!is_intx(mdev_state) || start != 0 || count != 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (flags & VFIO_IRQ_SET_DATA_NONE) {
+				mdev_state->intx_mask = false;
+			} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
+				uint8_t mask = *(uint8_t *)data;
+
+				if (mask)
+					mdev_state->intx_mask = false;
+			} else if (flags &  VFIO_IRQ_SET_DATA_EVENTFD) {
+				ret = -ENOTTY; /* No support for unmask fd */
+			}
 			break;
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
-		{
-			if (flags & VFIO_IRQ_SET_DATA_NONE) {
-				pr_info("%s: disable INTx\n", __func__);
-				if (mdev_state->intx_evtfd)
-					eventfd_ctx_put(mdev_state->intx_evtfd);
+			if (is_intx(mdev_state) && !count &&
+			    (flags & VFIO_IRQ_SET_DATA_NONE)) {
+				mtty_disable_intx(mdev_state);
+				break;
+			}
+
+			if (!(is_intx(mdev_state) || is_noirq(mdev_state)) ||
+			    start != 0 || count != 1) {
+				ret = -EINVAL;
 				break;
 			}
 
 			if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 				int fd = *(int *)data;
+				struct eventfd_ctx *evt;
+
+				mtty_disable_intx(mdev_state);
+
+				if (fd < 0)
+					break;
 
-				if (fd > 0) {
-					struct eventfd_ctx *evt;
-
-					evt = eventfd_ctx_fdget(fd);
-					if (IS_ERR(evt)) {
-						ret = PTR_ERR(evt);
-						break;
-					}
-					mdev_state->intx_evtfd = evt;
-					mdev_state->irq_fd = fd;
-					mdev_state->irq_index = index;
+				evt = eventfd_ctx_fdget(fd);
+				if (IS_ERR(evt)) {
+					ret = PTR_ERR(evt);
 					break;
 				}
+				mdev_state->intx_evtfd = evt;
+				mdev_state->irq_index = index;
+				break;
+			}
+
+			if (!is_intx(mdev_state)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (flags & VFIO_IRQ_SET_DATA_NONE) {
+				mtty_trigger_interrupt(mdev_state);
+			} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
+				uint8_t trigger = *(uint8_t *)data;
+
+				if (trigger)
+					mtty_trigger_interrupt(mdev_state);
 			}
 			break;
 		}
-		}
 		break;
 	case VFIO_PCI_MSI_IRQ_INDEX:
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_MASK:
 		case VFIO_IRQ_SET_ACTION_UNMASK:
+			ret = -ENOTTY;
 			break;
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
-			if (flags & VFIO_IRQ_SET_DATA_NONE) {
-				if (mdev_state->msi_evtfd)
-					eventfd_ctx_put(mdev_state->msi_evtfd);
-				pr_info("%s: disable MSI\n", __func__);
-				mdev_state->irq_index = VFIO_PCI_INTX_IRQ_INDEX;
+			if (is_msi(mdev_state) && !count &&
+			    (flags & VFIO_IRQ_SET_DATA_NONE)) {
+				mtty_disable_msi(mdev_state);
 				break;
 			}
+
+			if (!(is_msi(mdev_state) || is_noirq(mdev_state)) ||
+			    start != 0 || count != 1) {
+				ret = -EINVAL;
+				break;
+			}
+
 			if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 				int fd = *(int *)data;
 				struct eventfd_ctx *evt;
 
-				if (fd <= 0)
-					break;
+				mtty_disable_msi(mdev_state);
 
-				if (mdev_state->msi_evtfd)
+				if (fd < 0)
 					break;
 
 				evt = eventfd_ctx_fdget(fd);
@@ -993,20 +1092,37 @@ static int mtty_set_irqs(struct mdev_state *mdev_state, uint32_t flags,
 					break;
 				}
 				mdev_state->msi_evtfd = evt;
-				mdev_state->irq_fd = fd;
 				mdev_state->irq_index = index;
+				break;
+			}
+
+			if (!is_msi(mdev_state)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (flags & VFIO_IRQ_SET_DATA_NONE) {
+				mtty_trigger_interrupt(mdev_state);
+			} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
+				uint8_t trigger = *(uint8_t *)data;
+
+				if (trigger)
+					mtty_trigger_interrupt(mdev_state);
 			}
 			break;
-	}
-	break;
+		}
+		break;
 	case VFIO_PCI_MSIX_IRQ_INDEX:
-		pr_info("%s: MSIX_IRQ\n", __func__);
+		dev_dbg(mdev_state->vdev.dev, "%s: MSIX_IRQ\n", __func__);
+		ret = -ENOTTY;
 		break;
 	case VFIO_PCI_ERR_IRQ_INDEX:
-		pr_info("%s: ERR_IRQ\n", __func__);
+		dev_dbg(mdev_state->vdev.dev, "%s: ERR_IRQ\n", __func__);
+		ret = -ENOTTY;
 		break;
 	case VFIO_PCI_REQ_IRQ_INDEX:
-		pr_info("%s: REQ_IRQ\n", __func__);
+		dev_dbg(mdev_state->vdev.dev, "%s: REQ_IRQ\n", __func__);
+		ret = -ENOTTY;
 		break;
 	}
 
@@ -1014,33 +1130,6 @@ static int mtty_set_irqs(struct mdev_state *mdev_state, uint32_t flags,
 	return ret;
 }
 
-static int mtty_trigger_interrupt(struct mdev_state *mdev_state)
-{
-	int ret = -1;
-
-	if ((mdev_state->irq_index == VFIO_PCI_MSI_IRQ_INDEX) &&
-	    (!mdev_state->msi_evtfd))
-		return -EINVAL;
-	else if ((mdev_state->irq_index == VFIO_PCI_INTX_IRQ_INDEX) &&
-		 (!mdev_state->intx_evtfd)) {
-		pr_info("%s: Intr eventfd not found\n", __func__);
-		return -EINVAL;
-	}
-
-	if (mdev_state->irq_index == VFIO_PCI_MSI_IRQ_INDEX)
-		ret = eventfd_signal(mdev_state->msi_evtfd, 1);
-	else
-		ret = eventfd_signal(mdev_state->intx_evtfd, 1);
-
-#if defined(DEBUG_INTR)
-	pr_info("Intx triggered\n");
-#endif
-	if (ret != 1)
-		pr_err("%s: eventfd signal failed (%d)\n", __func__, ret);
-
-	return ret;
-}
-
 static int mtty_get_region_info(struct mdev_state *mdev_state,
 			 struct vfio_region_info *region_info,
 			 u16 *cap_type_id, void **cap_type)
@@ -1084,22 +1173,16 @@ static int mtty_get_region_info(struct mdev_state *mdev_state,
 
 static int mtty_get_irq_info(struct vfio_irq_info *irq_info)
 {
-	switch (irq_info->index) {
-	case VFIO_PCI_INTX_IRQ_INDEX:
-	case VFIO_PCI_MSI_IRQ_INDEX:
-	case VFIO_PCI_REQ_IRQ_INDEX:
-		break;
-
-	default:
+	if (irq_info->index != VFIO_PCI_INTX_IRQ_INDEX &&
+	    irq_info->index != VFIO_PCI_MSI_IRQ_INDEX)
 		return -EINVAL;
-	}
 
 	irq_info->flags = VFIO_IRQ_INFO_EVENTFD;
 	irq_info->count = 1;
 
 	if (irq_info->index == VFIO_PCI_INTX_IRQ_INDEX)
-		irq_info->flags |= (VFIO_IRQ_INFO_MASKABLE |
-				VFIO_IRQ_INFO_AUTOMASKED);
+		irq_info->flags |= VFIO_IRQ_INFO_MASKABLE |
+				   VFIO_IRQ_INFO_AUTOMASKED;
 	else
 		irq_info->flags |= VFIO_IRQ_INFO_NORESIZE;
 
@@ -1262,6 +1345,15 @@ static unsigned int mtty_get_available(struct mdev_type *mtype)
 	return atomic_read(&mdev_avail_ports) / type->nr_ports;
 }
 
+static void mtty_close(struct vfio_device *vdev)
+{
+	struct mdev_state *mdev_state =
+				container_of(vdev, struct mdev_state, vdev);
+
+	mtty_disable_intx(mdev_state);
+	mtty_disable_msi(mdev_state);
+}
+
 static const struct vfio_device_ops mtty_dev_ops = {
 	.name = "vfio-mtty",
 	.init = mtty_init_dev,
@@ -1273,6 +1365,7 @@ static const struct vfio_device_ops mtty_dev_ops = {
 	.unbind_iommufd	= vfio_iommufd_emulated_unbind,
 	.attach_ioas	= vfio_iommufd_emulated_attach_ioas,
 	.detach_ioas	= vfio_iommufd_emulated_detach_ioas,
+	.close_device	= mtty_close,
 };
 
 static struct mdev_driver mtty_driver = {
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 261cef4c622f..63ddefb6ddd1 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2364,6 +2364,7 @@ static struct aa_sfs_entry aa_sfs_entry_policy[] = {
 
 static struct aa_sfs_entry aa_sfs_entry_mount[] = {
 	AA_SFS_FILE_STRING("mask", "mount umount pivot_root"),
+	AA_SFS_FILE_STRING("move_mount", "detached"),
 	{ }
 };
 
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index f2a114e54007..cb0fdbdb82d9 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -499,6 +499,10 @@ int aa_move_mount(const struct cred *subj_cred,
 	error = -ENOMEM;
 	if (!to_buffer || !from_buffer)
 		goto out;
+
+	if (!our_mnt(from_path->mnt))
+		/* moving a mount detached from the namespace */
+		from_path = NULL;
 	error = fn_for_each_confined(label, profile,
 			match_mnt(subj_cred, profile, to_path, to_buffer,
 				  from_path, from_buffer,
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 343732c062c7..a9822d731ae0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9709,6 +9709,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
+	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
@@ -9791,6 +9792,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
@@ -9835,6 +9837,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 2fb1a7037c82..731664fc8b21 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -65,6 +65,15 @@ enum calib_data {
 	CALIB_MAX
 };
 
+struct tas2781_hda {
+	struct device *dev;
+	struct tasdevice_priv *priv;
+	struct snd_kcontrol *dsp_prog_ctl;
+	struct snd_kcontrol *dsp_conf_ctl;
+	struct snd_kcontrol *prof_ctl;
+	struct snd_kcontrol *snd_ctls[3];
+};
+
 static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
 {
 	struct tasdevice_priv *tas_priv = data;
@@ -125,26 +134,26 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 
 static void tas2781_hda_playback_hook(struct device *dev, int action)
 {
-	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 
-	dev_dbg(tas_priv->dev, "%s: action = %d\n", __func__, action);
+	dev_dbg(tas_hda->dev, "%s: action = %d\n", __func__, action);
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
 		pm_runtime_get_sync(dev);
-		mutex_lock(&tas_priv->codec_lock);
-		tasdevice_tuning_switch(tas_priv, 0);
-		mutex_unlock(&tas_priv->codec_lock);
+		mutex_lock(&tas_hda->priv->codec_lock);
+		tasdevice_tuning_switch(tas_hda->priv, 0);
+		mutex_unlock(&tas_hda->priv->codec_lock);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
-		mutex_lock(&tas_priv->codec_lock);
-		tasdevice_tuning_switch(tas_priv, 1);
-		mutex_unlock(&tas_priv->codec_lock);
+		mutex_lock(&tas_hda->priv->codec_lock);
+		tasdevice_tuning_switch(tas_hda->priv, 1);
+		mutex_unlock(&tas_hda->priv->codec_lock);
 
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 		break;
 	default:
-		dev_dbg(tas_priv->dev, "Playback action not supported: %d\n",
+		dev_dbg(tas_hda->dev, "Playback action not supported: %d\n",
 			action);
 		break;
 	}
@@ -477,9 +486,28 @@ static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
 	return 0;
 }
 
+static void tas2781_hda_remove_controls(struct tas2781_hda *tas_hda)
+{
+	struct hda_codec *codec = tas_hda->priv->codec;
+
+	if (tas_hda->dsp_prog_ctl)
+		snd_ctl_remove(codec->card, tas_hda->dsp_prog_ctl);
+
+	if (tas_hda->dsp_conf_ctl)
+		snd_ctl_remove(codec->card, tas_hda->dsp_conf_ctl);
+
+	for (int i = ARRAY_SIZE(tas_hda->snd_ctls) - 1; i >= 0; i--)
+		if (tas_hda->snd_ctls[i])
+			snd_ctl_remove(codec->card, tas_hda->snd_ctls[i]);
+
+	if (tas_hda->prof_ctl)
+		snd_ctl_remove(codec->card, tas_hda->prof_ctl);
+}
+
 static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 {
 	struct tasdevice_priv *tas_priv = context;
+	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
 	struct hda_codec *codec = tas_priv->codec;
 	int i, ret;
 
@@ -490,8 +518,8 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	if (ret)
 		goto out;
 
-	ret = snd_ctl_add(codec->card,
-		snd_ctl_new1(&tas2781_prof_ctrl, tas_priv));
+	tas_hda->prof_ctl = snd_ctl_new1(&tas2781_prof_ctrl, tas_priv);
+	ret = snd_ctl_add(codec->card, tas_hda->prof_ctl);
 	if (ret) {
 		dev_err(tas_priv->dev,
 			"Failed to add KControl %s = %d\n",
@@ -500,8 +528,9 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tas2781_snd_controls); i++) {
-		ret = snd_ctl_add(codec->card,
-			snd_ctl_new1(&tas2781_snd_controls[i], tas_priv));
+		tas_hda->snd_ctls[i] = snd_ctl_new1(&tas2781_snd_controls[i],
+			tas_priv);
+		ret = snd_ctl_add(codec->card, tas_hda->snd_ctls[i]);
 		if (ret) {
 			dev_err(tas_priv->dev,
 				"Failed to add KControl %s = %d\n",
@@ -523,8 +552,9 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 		goto out;
 	}
 
-	ret = snd_ctl_add(codec->card,
-		snd_ctl_new1(&tas2781_dsp_prog_ctrl, tas_priv));
+	tas_hda->dsp_prog_ctl = snd_ctl_new1(&tas2781_dsp_prog_ctrl,
+		tas_priv);
+	ret = snd_ctl_add(codec->card, tas_hda->dsp_prog_ctl);
 	if (ret) {
 		dev_err(tas_priv->dev,
 			"Failed to add KControl %s = %d\n",
@@ -532,8 +562,9 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 		goto out;
 	}
 
-	ret = snd_ctl_add(codec->card,
-		snd_ctl_new1(&tas2781_dsp_conf_ctrl, tas_priv));
+	tas_hda->dsp_conf_ctl = snd_ctl_new1(&tas2781_dsp_conf_ctrl,
+		tas_priv);
+	ret = snd_ctl_add(codec->card, tas_hda->dsp_conf_ctl);
 	if (ret) {
 		dev_err(tas_priv->dev,
 			"Failed to add KControl %s = %d\n",
@@ -554,27 +585,27 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tas2781_save_calibration(tas_priv);
 
 out:
-	mutex_unlock(&tas_priv->codec_lock);
+	mutex_unlock(&tas_hda->priv->codec_lock);
 	if (fmw)
 		release_firmware(fmw);
-	pm_runtime_mark_last_busy(tas_priv->dev);
-	pm_runtime_put_autosuspend(tas_priv->dev);
+	pm_runtime_mark_last_busy(tas_hda->dev);
+	pm_runtime_put_autosuspend(tas_hda->dev);
 }
 
 static int tas2781_hda_bind(struct device *dev, struct device *master,
 	void *master_data)
 {
-	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 	struct hda_component *comps = master_data;
 	struct hda_codec *codec;
 	unsigned int subid;
 	int ret;
 
-	if (!comps || tas_priv->index < 0 ||
-		tas_priv->index >= HDA_MAX_COMPONENTS)
+	if (!comps || tas_hda->priv->index < 0 ||
+		tas_hda->priv->index >= HDA_MAX_COMPONENTS)
 		return -EINVAL;
 
-	comps = &comps[tas_priv->index];
+	comps = &comps[tas_hda->priv->index];
 	if (comps->dev)
 		return -EBUSY;
 
@@ -583,10 +614,10 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
 
 	switch (subid) {
 	case 0x17aa:
-		tas_priv->catlog_id = LENOVO;
+		tas_hda->priv->catlog_id = LENOVO;
 		break;
 	default:
-		tas_priv->catlog_id = OTHERS;
+		tas_hda->priv->catlog_id = OTHERS;
 		break;
 	}
 
@@ -596,7 +627,7 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
 
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 
-	ret = tascodec_init(tas_priv, codec, tasdev_fw_ready);
+	ret = tascodec_init(tas_hda->priv, codec, tasdev_fw_ready);
 	if (!ret)
 		comps->playback_hook = tas2781_hda_playback_hook;
 
@@ -609,9 +640,9 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
 static void tas2781_hda_unbind(struct device *dev,
 	struct device *master, void *master_data)
 {
-	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 	struct hda_component *comps = master_data;
-	comps = &comps[tas_priv->index];
+	comps = &comps[tas_hda->priv->index];
 
 	if (comps->dev == dev) {
 		comps->dev = NULL;
@@ -619,10 +650,12 @@ static void tas2781_hda_unbind(struct device *dev,
 		comps->playback_hook = NULL;
 	}
 
-	tasdevice_config_info_remove(tas_priv);
-	tasdevice_dsp_remove(tas_priv);
+	tas2781_hda_remove_controls(tas_hda);
 
-	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+	tasdevice_config_info_remove(tas_hda->priv);
+	tasdevice_dsp_remove(tas_hda->priv);
+
+	tas_hda->priv->fw_state = TASDEVICE_DSP_FW_PENDING;
 }
 
 static const struct component_ops tas2781_hda_comp_ops = {
@@ -632,21 +665,21 @@ static const struct component_ops tas2781_hda_comp_ops = {
 
 static void tas2781_hda_remove(struct device *dev)
 {
-	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 
-	pm_runtime_get_sync(tas_priv->dev);
-	pm_runtime_disable(tas_priv->dev);
+	pm_runtime_get_sync(tas_hda->dev);
+	pm_runtime_disable(tas_hda->dev);
 
-	component_del(tas_priv->dev, &tas2781_hda_comp_ops);
+	component_del(tas_hda->dev, &tas2781_hda_comp_ops);
 
-	pm_runtime_put_noidle(tas_priv->dev);
+	pm_runtime_put_noidle(tas_hda->dev);
 
-	tasdevice_remove(tas_priv);
+	tasdevice_remove(tas_hda->priv);
 }
 
 static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 {
-	struct tasdevice_priv *tas_priv;
+	struct tas2781_hda *tas_hda;
 	const char *device_name;
 	int ret;
 
@@ -655,35 +688,42 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	else
 		return -ENODEV;
 
-	tas_priv = tasdevice_kzalloc(clt);
-	if (!tas_priv)
+	tas_hda = devm_kzalloc(&clt->dev, sizeof(*tas_hda), GFP_KERNEL);
+	if (!tas_hda)
 		return -ENOMEM;
 
-	tas_priv->irq_info.irq = clt->irq;
-	ret = tas2781_read_acpi(tas_priv, device_name);
+	dev_set_drvdata(&clt->dev, tas_hda);
+	tas_hda->dev = &clt->dev;
+
+	tas_hda->priv = tasdevice_kzalloc(clt);
+	if (!tas_hda->priv)
+		return -ENOMEM;
+
+	tas_hda->priv->irq_info.irq = clt->irq;
+	ret = tas2781_read_acpi(tas_hda->priv, device_name);
 	if (ret)
-		return dev_err_probe(tas_priv->dev, ret,
+		return dev_err_probe(tas_hda->dev, ret,
 			"Platform not supported\n");
 
-	ret = tasdevice_init(tas_priv);
+	ret = tasdevice_init(tas_hda->priv);
 	if (ret)
 		goto err;
 
-	pm_runtime_set_autosuspend_delay(tas_priv->dev, 3000);
-	pm_runtime_use_autosuspend(tas_priv->dev);
-	pm_runtime_mark_last_busy(tas_priv->dev);
-	pm_runtime_set_active(tas_priv->dev);
-	pm_runtime_get_noresume(tas_priv->dev);
-	pm_runtime_enable(tas_priv->dev);
+	pm_runtime_set_autosuspend_delay(tas_hda->dev, 3000);
+	pm_runtime_use_autosuspend(tas_hda->dev);
+	pm_runtime_mark_last_busy(tas_hda->dev);
+	pm_runtime_set_active(tas_hda->dev);
+	pm_runtime_get_noresume(tas_hda->dev);
+	pm_runtime_enable(tas_hda->dev);
 
-	pm_runtime_put_autosuspend(tas_priv->dev);
+	pm_runtime_put_autosuspend(tas_hda->dev);
 
-	tas2781_reset(tas_priv);
+	tas2781_reset(tas_hda->priv);
 
-	ret = component_add(tas_priv->dev, &tas2781_hda_comp_ops);
+	ret = component_add(tas_hda->dev, &tas2781_hda_comp_ops);
 	if (ret) {
-		dev_err(tas_priv->dev, "Register component failed: %d\n", ret);
-		pm_runtime_disable(tas_priv->dev);
+		dev_err(tas_hda->dev, "Register component failed: %d\n", ret);
+		pm_runtime_disable(tas_hda->dev);
 	}
 
 err:
@@ -699,81 +739,65 @@ static void tas2781_hda_i2c_remove(struct i2c_client *clt)
 
 static int tas2781_runtime_suspend(struct device *dev)
 {
-	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 	int i;
 
-	dev_dbg(tas_priv->dev, "Runtime Suspend\n");
+	dev_dbg(tas_hda->dev, "Runtime Suspend\n");
 
-	mutex_lock(&tas_priv->codec_lock);
+	mutex_lock(&tas_hda->priv->codec_lock);
 
-	if (tas_priv->playback_started) {
-		tasdevice_tuning_switch(tas_priv, 1);
-		tas_priv->playback_started = false;
+	if (tas_hda->priv->playback_started) {
+		tasdevice_tuning_switch(tas_hda->priv, 1);
+		tas_hda->priv->playback_started = false;
 	}
 
-	for (i = 0; i < tas_priv->ndev; i++) {
-		tas_priv->tasdevice[i].cur_book = -1;
-		tas_priv->tasdevice[i].cur_prog = -1;
-		tas_priv->tasdevice[i].cur_conf = -1;
+	for (i = 0; i < tas_hda->priv->ndev; i++) {
+		tas_hda->priv->tasdevice[i].cur_book = -1;
+		tas_hda->priv->tasdevice[i].cur_prog = -1;
+		tas_hda->priv->tasdevice[i].cur_conf = -1;
 	}
 
-	regcache_cache_only(tas_priv->regmap, true);
-	regcache_mark_dirty(tas_priv->regmap);
-
-	mutex_unlock(&tas_priv->codec_lock);
+	mutex_unlock(&tas_hda->priv->codec_lock);
 
 	return 0;
 }
 
 static int tas2781_runtime_resume(struct device *dev)
 {
-	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 	unsigned long calib_data_sz =
-		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
-	int ret;
-
-	dev_dbg(tas_priv->dev, "Runtime Resume\n");
+		tas_hda->priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 
-	mutex_lock(&tas_priv->codec_lock);
+	dev_dbg(tas_hda->dev, "Runtime Resume\n");
 
-	regcache_cache_only(tas_priv->regmap, false);
-	ret = regcache_sync(tas_priv->regmap);
-	if (ret) {
-		dev_err(tas_priv->dev,
-			"Failed to restore register cache: %d\n", ret);
-		goto out;
-	}
+	mutex_lock(&tas_hda->priv->codec_lock);
 
-	tasdevice_prmg_load(tas_priv, tas_priv->cur_prog);
+	tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
 
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
-	if (tas_priv->cali_data.total_sz > calib_data_sz)
-		tas2781_apply_calib(tas_priv);
+	if (tas_hda->priv->cali_data.total_sz > calib_data_sz)
+		tas2781_apply_calib(tas_hda->priv);
 
-out:
-	mutex_unlock(&tas_priv->codec_lock);
+	mutex_unlock(&tas_hda->priv->codec_lock);
 
-	return ret;
+	return 0;
 }
 
 static int tas2781_system_suspend(struct device *dev)
 {
-	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 	int ret;
 
-	dev_dbg(tas_priv->dev, "System Suspend\n");
+	dev_dbg(tas_hda->priv->dev, "System Suspend\n");
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
 
 	/* Shutdown chip before system suspend */
-	regcache_cache_only(tas_priv->regmap, false);
-	tasdevice_tuning_switch(tas_priv, 1);
-	regcache_cache_only(tas_priv->regmap, true);
-	regcache_mark_dirty(tas_priv->regmap);
+	tasdevice_tuning_switch(tas_hda->priv, 1);
 
 	/*
 	 * Reset GPIO may be shared, so cannot reset here.
@@ -784,33 +808,33 @@ static int tas2781_system_suspend(struct device *dev)
 
 static int tas2781_system_resume(struct device *dev)
 {
-	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 	unsigned long calib_data_sz =
-		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
+		tas_hda->priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 	int i, ret;
 
-	dev_dbg(tas_priv->dev, "System Resume\n");
+	dev_info(tas_hda->priv->dev, "System Resume\n");
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
-	mutex_lock(&tas_priv->codec_lock);
+	mutex_lock(&tas_hda->priv->codec_lock);
 
-	for (i = 0; i < tas_priv->ndev; i++) {
-		tas_priv->tasdevice[i].cur_book = -1;
-		tas_priv->tasdevice[i].cur_prog = -1;
-		tas_priv->tasdevice[i].cur_conf = -1;
+	for (i = 0; i < tas_hda->priv->ndev; i++) {
+		tas_hda->priv->tasdevice[i].cur_book = -1;
+		tas_hda->priv->tasdevice[i].cur_prog = -1;
+		tas_hda->priv->tasdevice[i].cur_conf = -1;
 	}
-	tas2781_reset(tas_priv);
-	tasdevice_prmg_load(tas_priv, tas_priv->cur_prog);
+	tas2781_reset(tas_hda->priv);
+	tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
 
 	/* If calibrated data occurs error, dsp will still work with default
 	 * calibrated data inside algo.
 	 */
-	if (tas_priv->cali_data.total_sz > calib_data_sz)
-		tas2781_apply_calib(tas_priv);
-	mutex_unlock(&tas_priv->codec_lock);
+	if (tas_hda->priv->cali_data.total_sz > calib_data_sz)
+		tas2781_apply_calib(tas_hda->priv);
+	mutex_unlock(&tas_hda->priv->codec_lock);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index ffb26e4a7e2f..00e35169ae49 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -39,7 +39,7 @@ static const struct regmap_range_cfg tasdevice_ranges[] = {
 static const struct regmap_config tasdevice_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_NONE,
 	.ranges = tasdevice_ranges,
 	.num_ranges = ARRAY_SIZE(tasdevice_ranges),
 	.max_register = 256 * 128,
@@ -316,8 +316,6 @@ int tasdevice_init(struct tasdevice_priv *tas_priv)
 		tas_priv->tasdevice[i].cur_conf = -1;
 	}
 
-	dev_set_drvdata(tas_priv->dev, tas_priv);
-
 	mutex_init(&tas_priv->codec_lock);
 
 out:
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 55cd5e3c23a5..917b1c15f71d 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -689,6 +689,8 @@ static int tasdevice_i2c_probe(struct i2c_client *i2c)
 	if (!tas_priv)
 		return -ENOMEM;
 
+	dev_set_drvdata(&i2c->dev, tas_priv);
+
 	if (ACPI_HANDLE(&i2c->dev)) {
 		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
 				&i2c->dev);
diff --git a/sound/soc/fsl/fsl_rpmsg.c b/sound/soc/fsl/fsl_rpmsg.c
index abe19a8a7aa7..f7180f1959dd 100644
--- a/sound/soc/fsl/fsl_rpmsg.c
+++ b/sound/soc/fsl/fsl_rpmsg.c
@@ -239,7 +239,7 @@ static int fsl_rpmsg_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
 					      &fsl_rpmsg_dai, 1);
 	if (ret)
-		return ret;
+		goto err_pm_disable;
 
 	rpmsg->card_pdev = platform_device_register_data(&pdev->dev,
 							 "imx-audio-rpmsg",
@@ -249,16 +249,22 @@ static int fsl_rpmsg_probe(struct platform_device *pdev)
 	if (IS_ERR(rpmsg->card_pdev)) {
 		dev_err(&pdev->dev, "failed to register rpmsg card\n");
 		ret = PTR_ERR(rpmsg->card_pdev);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static void fsl_rpmsg_remove(struct platform_device *pdev)
 {
 	struct fsl_rpmsg *rpmsg = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (rpmsg->card_pdev)
 		platform_device_unregister(rpmsg->card_pdev);
 }
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index 247ab8df941f..ab61e597c9a0 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -499,7 +499,7 @@ static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
 			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 	SND_SOC_DAPM_SUPPLY_S("AUD_PAD_TOP", SUPPLY_SEQ_ADDA_AUD_PAD_TOP,
-			      0, 0, 0,
+			      AFE_AUD_PAD_TOP, RG_RX_FIFO_ON_SFT, 0,
 			      mtk_adda_pad_top_event,
 			      SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_SUPPLY_S("ADDA_MTKAIF_CFG", SUPPLY_SEQ_ADDA_MTKAIF_CFG,
diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 6c4503766fdc..531bb8707a3e 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -71,6 +71,9 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, reg;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	regmap_field_read(priv->field_dat_sel, &reg);
 
@@ -101,7 +104,7 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
-	return 0;
+	return 1;
 }
 
 static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
index f7ef9aa1eed8..b92434125fac 100644
--- a/sound/soc/meson/g12a-tohdmitx.c
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -45,6 +45,9 @@ static int g12a_tohdmitx_i2s_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, changed;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	changed = snd_soc_component_test_bits(component, e->reg,
 					      CTRL0_I2S_DAT_SEL,
@@ -93,6 +96,9 @@ static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, changed;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	changed = snd_soc_component_test_bits(component, TOHDMITX_CTRL0,
 					      CTRL0_SPDIF_SEL,
@@ -112,7 +118,7 @@ static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
-	return 0;
+	return 1;
 }
 
 static SOC_ENUM_SINGLE_DECL(g12a_tohdmitx_spdif_mux_enum, TOHDMITX_CTRL0,
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2883660d6b67..882bf8e6e70e 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 									    \n\
-			s->data = (void *)%2$s__elf_bytes(&s->data_sz);	    \n\
+			s->data = %1$s__elf_bytes(&s->data_sz);		    \n\
 									    \n\
 			obj->skeleton = s;				    \n\
 			return 0;					    \n\
@@ -1218,12 +1218,12 @@ static int do_skeleton(int argc, char **argv)
 			return err;					    \n\
 		}							    \n\
 									    \n\
-		static inline const void *%2$s__elf_bytes(size_t *sz)	    \n\
+		static inline const void *%1$s__elf_bytes(size_t *sz)	    \n\
 		{							    \n\
-			*sz = %1$d;					    \n\
-			return (const void *)\"\\			    \n\
-		"
-		, file_sz, obj_name);
+			static const char data[] __attribute__((__aligned__(8))) = \"\\\n\
+		",
+		obj_name
+	);
 
 	/* embed contents of BPF object file */
 	print_hex(obj_data, file_sz);
@@ -1231,6 +1231,9 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 		\";							    \n\
+									    \n\
+			*sz = sizeof(data) - 1;				    \n\
+			return (const void *)data;			    \n\
 		}							    \n\
 									    \n\
 		#ifdef __cplusplus					    \n\
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 90f3c9802ffb..95dc58b94178 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -62,5 +62,6 @@ cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
+cxl_core-y += cxl_core_exports.o
 
 obj-m += test/
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
new file mode 100644
index 000000000000..077e6883921d
--- /dev/null
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "cxl.h"
+
+/* Exporting of cxl_core symbols that are only used by cxl_test */
+EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, CXL);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index b88546299902..f4e517a0c774 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -669,10 +669,11 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 		return 0;
 
 	dev_dbg(&port->dev, "%s commit\n", dev_name(&cxld->dev));
-	if (port->commit_end + 1 != id) {
+	if (cxl_num_decoders_committed(port) != id) {
 		dev_dbg(&port->dev,
 			"%s: out of order commit, expected decoder%d.%d\n",
-			dev_name(&cxld->dev), port->id, port->commit_end + 1);
+			dev_name(&cxld->dev), port->id,
+			cxl_num_decoders_committed(port));
 		return -EBUSY;
 	}
 
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
index 4917dbb35a44..5667febee328 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
@@ -30,16 +30,16 @@ ip netns exec server ip addr add ${server_ip4}/24 dev eth0
 
 ip netns exec client ip link add dev bond0 down type bond mode 1 \
 	miimon 100 all_slaves_active 1
-ip netns exec client ip link set dev eth0 down master bond0
+ip netns exec client ip link set dev eth0 master bond0
 ip netns exec client ip link set dev bond0 up
 ip netns exec client ip addr add ${client_ip4}/24 dev bond0
 ip netns exec client ping -c 5 $server_ip4 >/dev/null
 
-ip netns exec client ip link set dev eth0 down nomaster
+ip netns exec client ip link set dev eth0 nomaster
 ip netns exec client ip link set dev bond0 down
 ip netns exec client ip link set dev bond0 type bond mode 0 \
 	arp_interval 1000 arp_ip_target "+${server_ip4}"
-ip netns exec client ip link set dev eth0 down master bond0
+ip netns exec client ip link set dev eth0 master bond0
 ip netns exec client ip link set dev bond0 up
 ip netns exec client ping -c 5 $server_ip4 >/dev/null
 

