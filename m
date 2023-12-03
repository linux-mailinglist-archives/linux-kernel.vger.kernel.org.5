Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6080215F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjLCGvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjLCGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:51:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE8102
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:51:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2DCC433C9;
        Sun,  3 Dec 2023 06:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701586292;
        bh=otg3DcJ4QXaLqmkfntVQnHtqufDAkguMOcBn3E6RdF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11bLGKgq+P/3UEkAA3sl/R7GIS05PjcnaSsU609OK5DRZn3+vhX6cyyHBy68ygXmJ
         5COzjdeWD3TOuQppIUz//onTY05oGkK5M25Vgf8WTrb6jG26rb+k4assplGF3P42SX
         np6z4aZldTkxFPI3T/yc7NsRGTtRLZMwN6Vvx2f0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.141
Date:   Sun,  3 Dec 2023 07:51:22 +0100
Message-ID: <2023120322-robbing-unbolted-9b9e@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023120321-identify-connected-5156@gregkh>
References: <2023120321-identify-connected-5156@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 90d878daaba6..63c79319d769 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 140
+SUBLEVEL = 141
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 27277d6bbfa5..59de416c61a3 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -359,7 +359,8 @@ static int __init xen_guest_init(void)
 	 * for secondary CPUs as they are brought up.
 	 * For uniformity we use VCPUOP_register_vcpu_info even on cpu0.
 	 */
-	xen_vcpu_info = alloc_percpu(struct vcpu_info);
+	xen_vcpu_info = __alloc_percpu(sizeof(struct vcpu_info),
+				       1 << fls(sizeof(struct vcpu_info) - 1));
 	if (xen_vcpu_info == NULL)
 		return -ENOMEM;
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 1bfd1b501d82..72b524945227 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -593,7 +593,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int srcu_idx, err;
 	kvm_pfn_t pfn;
-	pte_t *ptep, entry, old_pte;
+	pte_t *ptep, entry;
 	bool writeable;
 	unsigned long prot_bits;
 	unsigned long mmu_seq;
@@ -665,7 +665,6 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	entry = pfn_pte(pfn, __pgprot(prot_bits));
 
 	/* Write the PTE */
-	old_pte = *ptep;
 	set_pte(ptep, entry);
 
 	err = 0;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index fa91ca32b9af..503fb973faa5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -439,6 +439,13 @@ static const struct dmi_system_id lenovo_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1402CVA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
+		},
+	},
 	{
 		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
 		.matches = {
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 43bb224430d3..8892931ea867 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -82,6 +82,9 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 	if (pnp_port_valid(idev, 1)) {
 		ctl_addr = devm_ioport_map(&idev->dev,
 					   pnp_port_start(idev, 1), 1);
+		if (!ctl_addr)
+			return -ENOMEM;
+
 		ap->ioaddr.altstatus_addr = ctl_addr;
 		ap->ioaddr.ctl_addr = ctl_addr;
 		ap->ops = &isapnp_port_ops;
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index db9d0b86d542..9e518213a54f 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -36,6 +36,7 @@ struct panel_desc {
 	const struct panel_init_cmd *init_cmds;
 	unsigned int lanes;
 	bool discharge_on_disable;
+	bool lp11_before_reset;
 };
 
 struct boe_panel {
@@ -551,6 +552,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
 
 	usleep_range(5000, 10000);
 
+	if (boe->desc->lp11_before_reset) {
+		mipi_dsi_dcs_nop(boe->dsi);
+		usleep_range(1000, 2000);
+	}
 	gpiod_set_value(boe->enable_gpio, 1);
 	usleep_range(1000, 2000);
 	gpiod_set_value(boe->enable_gpio, 0);
@@ -692,6 +697,7 @@ static const struct panel_desc auo_b101uan08_3_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.init_cmds = auo_b101uan08_3_init_cmd,
+	.lp11_before_reset = true,
 };
 
 static const struct drm_display_mode boe_tv105wum_nw0_default_mode = {
@@ -719,6 +725,7 @@ static const struct panel_desc boe_tv105wum_nw0_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.init_cmds = boe_init_cmd,
+	.lp11_before_reset = true,
 };
 
 static int boe_panel_get_modes(struct drm_panel *panel,
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e58eb93e9bc9..d9f1675c348e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2532,13 +2532,13 @@ static const struct panel_desc innolux_g070y2_l01 = {
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
 
@@ -2555,6 +2555,7 @@ static const struct panel_desc innolux_g101ice_l01 = {
 		.disable = 200,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index e53b1ecbd7bc..c7106f116546 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -249,14 +249,22 @@ static inline void vop_cfg_done(struct vop *vop)
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
@@ -998,7 +1006,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
 	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
 
-	rb_swap = has_rb_swapped(fb->format->format);
+	rb_swap = has_rb_swapped(vop->data->version, fb->format->format);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
 	/*
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d941023c5628..7b76405df8c4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -702,15 +702,22 @@ static void hid_close_report(struct hid_device *device)
  * Free a device structure, all reports, and all fields.
  */
 
-static void hid_device_release(struct device *dev)
+void hiddev_free(struct kref *ref)
 {
-	struct hid_device *hid = to_hid_device(dev);
+	struct hid_device *hid = container_of(ref, struct hid_device, ref);
 
 	hid_close_report(hid);
 	kfree(hid->dev_rdesc);
 	kfree(hid);
 }
 
+static void hid_device_release(struct device *dev)
+{
+	struct hid_device *hid = to_hid_device(dev);
+
+	kref_put(&hid->ref, hiddev_free);
+}
+
 /*
  * Fetch a report description item from the data stream. We support long
  * items, though they are not used yet.
@@ -2442,10 +2449,12 @@ int hid_add_device(struct hid_device *hdev)
 			hid_warn(hdev, "bad device descriptor (%d)\n", ret);
 	}
 
+	hdev->id = atomic_inc_return(&id);
+
 	/* XXX hack, any other cleaner solution after the driver core
 	 * is converted to allow more than 20 bytes as the device name? */
 	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
-		     hdev->vendor, hdev->product, atomic_inc_return(&id));
+		     hdev->vendor, hdev->product, hdev->id);
 
 	hid_debug_register(hdev, dev_name(&hdev->dev));
 	ret = device_add(&hdev->dev);
@@ -2488,6 +2497,7 @@ struct hid_device *hid_allocate_device(void)
 	spin_lock_init(&hdev->debug_list_lock);
 	sema_init(&hdev->driver_input_lock, 1);
 	mutex_init(&hdev->ll_open_lock);
+	kref_init(&hdev->ref);
 
 	return hdev;
 }
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 03da865e423c..b8274bdd7d27 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1096,6 +1096,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
+	kref_get(&list->hdev->ref);
 	file->private_data = list;
 	mutex_init(&list->read_mutex);
 
@@ -1188,6 +1189,8 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
 	list_del(&list->node);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
 	kfifo_free(&list->hid_debug_fifo);
+
+	kref_put(&list->hdev->ref, hiddev_free);
 	kfree(list);
 
 	return 0;
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 88097d1892ac..efef92dc7858 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1342,7 +1342,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	memset(new_nodes, 0, sizeof(new_nodes));
 	closure_init_stack(&cl);
 
-	while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
+	while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
 		keys += r[nodes++].keys;
 
 	blocks = btree_default_blocks(b->c) * 2 / 3;
@@ -1506,6 +1506,8 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 		return 0;
 
 	n = btree_node_alloc_replacement(replace, NULL);
+	if (IS_ERR(n))
+		return 0;
 
 	/* recheck reserve after allocating replacement node */
 	if (btree_check_reserve(b, NULL)) {
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 05ac1d6fbbf3..fa146012003d 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -1099,7 +1099,7 @@ SHOW(__bch_cache)
 			sum += INITIAL_PRIO - cached[i];
 
 		if (n)
-			do_div(sum, n);
+			sum = div64_u64(sum, n);
 
 		for (i = 0; i < ARRAY_SIZE(q); i++)
 			q[i] = INITIAL_PRIO - cached[n * (i + 1) /
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 4dcbaf9a2149..3bc29ed633cb 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -967,24 +967,35 @@ static int bch_btre_dirty_init_thread_nr(void)
 void bch_sectors_dirty_init(struct bcache_device *d)
 {
 	int i;
+	struct btree *b = NULL;
 	struct bkey *k = NULL;
 	struct btree_iter iter;
 	struct sectors_dirty_init op;
 	struct cache_set *c = d->c;
 	struct bch_dirty_init_state state;
 
+retry_lock:
+	b = c->root;
+	rw_lock(0, b, b->level);
+	if (b != c->root) {
+		rw_unlock(0, b);
+		goto retry_lock;
+	}
+
 	/* Just count root keys if no leaf node */
-	rw_lock(0, c->root, c->root->level);
 	if (c->root->level == 0) {
 		bch_btree_op_init(&op.op, -1);
 		op.inode = d->id;
 		op.count = 0;
 
 		for_each_key_filter(&c->root->keys,
-				    k, &iter, bch_ptr_invalid)
+				    k, &iter, bch_ptr_invalid) {
+			if (KEY_INODE(k) != op.inode)
+				continue;
 			sectors_dirty_init_fn(&op.op, c->root, k);
+		}
 
-		rw_unlock(0, c->root);
+		rw_unlock(0, b);
 		return;
 	}
 
@@ -1004,23 +1015,24 @@ void bch_sectors_dirty_init(struct bcache_device *d)
 		if (atomic_read(&state.enough))
 			break;
 
+		atomic_inc(&state.started);
 		state.infos[i].state = &state;
 		state.infos[i].thread =
 			kthread_run(bch_dirty_init_thread, &state.infos[i],
 				    "bch_dirtcnt[%d]", i);
 		if (IS_ERR(state.infos[i].thread)) {
 			pr_err("fails to run thread bch_dirty_init[%d]\n", i);
+			atomic_dec(&state.started);
 			for (--i; i >= 0; i--)
 				kthread_stop(state.infos[i].thread);
 			goto out;
 		}
-		atomic_inc(&state.started);
 	}
 
 out:
 	/* Must wait for all threads to stop. */
 	wait_event(state.wait, atomic_read(&state.started) == 0);
-	rw_unlock(0, c->root);
+	rw_unlock(0, b);
 }
 
 void bch_cached_dev_writeback_init(struct cached_dev *dc)
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 59e51d285b0e..238028056d0c 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -30,7 +30,7 @@ struct delay_c {
 	struct workqueue_struct *kdelayd_wq;
 	struct work_struct flush_expired_bios;
 	struct list_head delayed_bios;
-	atomic_t may_delay;
+	bool may_delay;
 
 	struct delay_class read;
 	struct delay_class write;
@@ -191,7 +191,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
 	INIT_LIST_HEAD(&dc->delayed_bios);
 	mutex_init(&dc->timer_lock);
-	atomic_set(&dc->may_delay, 1);
+	dc->may_delay = true;
 	dc->argc = argc;
 
 	ret = delay_class_ctr(ti, &dc->read, argv);
@@ -245,7 +245,7 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	struct dm_delay_info *delayed;
 	unsigned long expires = 0;
 
-	if (!c->delay || !atomic_read(&dc->may_delay))
+	if (!c->delay)
 		return DM_MAPIO_REMAPPED;
 
 	delayed = dm_per_bio_data(bio, sizeof(struct dm_delay_info));
@@ -254,6 +254,10 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	delayed->expires = expires = jiffies + msecs_to_jiffies(c->delay);
 
 	mutex_lock(&delayed_bios_lock);
+	if (unlikely(!dc->may_delay)) {
+		mutex_unlock(&delayed_bios_lock);
+		return DM_MAPIO_REMAPPED;
+	}
 	c->ops++;
 	list_add_tail(&delayed->list, &dc->delayed_bios);
 	mutex_unlock(&delayed_bios_lock);
@@ -267,7 +271,10 @@ static void delay_presuspend(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	atomic_set(&dc->may_delay, 0);
+	mutex_lock(&delayed_bios_lock);
+	dc->may_delay = false;
+	mutex_unlock(&delayed_bios_lock);
+
 	del_timer_sync(&dc->delay_timer);
 	flush_bios(flush_delayed_bios(dc, 1));
 }
@@ -276,7 +283,7 @@ static void delay_resume(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	atomic_set(&dc->may_delay, 1);
+	dc->may_delay = true;
 }
 
 static int delay_map(struct dm_target *ti, struct bio *bio)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b585b642a076..a2d985636595 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8627,7 +8627,8 @@ static void md_end_io_acct(struct bio *bio)
 	struct md_io_acct *md_io_acct = bio->bi_private;
 	struct bio *orig_bio = md_io_acct->orig_bio;
 
-	orig_bio->bi_status = bio->bi_status;
+	if (bio->bi_status && !orig_bio->bi_status)
+		orig_bio->bi_status = bio->bi_status;
 
 	bio_end_io_acct(orig_bio, md_io_acct->start_time);
 	bio_put(bio);
diff --git a/drivers/media/platform/qcom/camss/camss-csid-170.c b/drivers/media/platform/qcom/camss/camss-csid-170.c
index 82f59933ad7b..f7839e994bda 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-170.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-170.c
@@ -327,13 +327,14 @@ static const struct csid_format csid_formats[] = {
 	},
 };
 
-static void csid_configure_stream(struct csid_device *csid, u8 enable)
+static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 {
 	struct csid_testgen_config *tg = &csid->testgen;
 	u32 val;
 	u32 phy_sel = 0;
 	u8 lane_cnt = csid->phy.lane_cnt;
-	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_SRC];
+	/* Source pads matching RDI channels on hardware. Pad 1 -> RDI0, Pad 2 -> RDI1, etc. */
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
 	const struct csid_format *format = csid_get_fmt_entry(csid->formats, csid->nformats,
 							      input_format->code);
 
@@ -344,13 +345,9 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 		phy_sel = csid->phy.csiphy_id;
 
 	if (enable) {
-		u8 vc = 0; /* Virtual Channel 0 */
-		u8 dt_id = vc * 4;
+		u8 dt_id = vc;
 
 		if (tg->enabled) {
-			/* Config Test Generator */
-			vc = 0xa;
-
 			/* configure one DT, infinite frames */
 			val = vc << TPG_VC_CFG0_VC_NUM;
 			val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
@@ -363,14 +360,14 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 
 			writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
 
-			val = input_format->height & 0x1fff << TPG_DT_n_CFG_0_FRAME_HEIGHT;
-			val |= input_format->width & 0x1fff << TPG_DT_n_CFG_0_FRAME_WIDTH;
+			val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
+			val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
 
 			val = format->data_type << TPG_DT_n_CFG_1_DATA_TYPE;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_1(0));
 
-			val = tg->mode << TPG_DT_n_CFG_2_PAYLOAD_MODE;
+			val = (tg->mode - 1) << TPG_DT_n_CFG_2_PAYLOAD_MODE;
 			val |= 0xBE << TPG_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
 			val |= format->decode_format << TPG_DT_n_CFG_2_ENCODE_FORMAT;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_2(0));
@@ -388,42 +385,42 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 		val |= format->data_type << RDI_CFG0_DATA_TYPE;
 		val |= vc << RDI_CFG0_VIRTUAL_CHANNEL;
 		val |= dt_id << RDI_CFG0_DT_ID;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG0(0));
+		writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
 
 		/* CSID_TIMESTAMP_STB_POST_IRQ */
 		val = 2 << RDI_CFG1_TIMESTAMP_STB_SEL;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG1(0));
+		writel_relaxed(val, csid->base + CSID_RDI_CFG1(vc));
 
 		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(0));
+		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(vc));
 
 		val = 0;
-		writel_relaxed(0, csid->base + CSID_RDI_FRM_DROP_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PATTERN(vc));
 
 		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(0));
+		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
 
 		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PERIOD(0));
+		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PERIOD(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PATTERN(vc));
 
 		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PERIOD(0));
+		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PERIOD(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PATTERN(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_CTRL(0));
+		writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
 
-		val = readl_relaxed(csid->base + CSID_RDI_CFG0(0));
+		val = readl_relaxed(csid->base + CSID_RDI_CFG0(vc));
 		val |=  1 << RDI_CFG0_ENABLE;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG0(0));
+		writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
 	}
 
 	if (tg->enabled) {
@@ -442,6 +439,8 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
 
 	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
+	if (vc > 3)
+		val |= 1 << CSI2_RX_CFG1_VC_MODE;
 	val |= 1 << CSI2_RX_CFG1_MISR_EN;
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1); // csi2_vc_mode_shift_val ?
 
@@ -449,7 +448,16 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 		val = HALT_CMD_RESUME_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
 	else
 		val = HALT_CMD_HALT_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
-	writel_relaxed(val, csid->base + CSID_RDI_CTRL(0));
+	writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
+}
+
+static void csid_configure_stream(struct csid_device *csid, u8 enable)
+{
+	u8 i;
+	/* Loop through all enabled VCs and configure stream for each */
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
+		if (csid->phy.en_vc & BIT(i))
+			__csid_configure_stream(csid, enable, i);
 }
 
 static int csid_configure_testgen_pattern(struct csid_device *csid, s32 val)
@@ -495,6 +503,7 @@ static irqreturn_t csid_isr(int irq, void *dev)
 	struct csid_device *csid = dev;
 	u32 val;
 	u8 reset_done;
+	int i;
 
 	val = readl_relaxed(csid->base + CSID_TOP_IRQ_STATUS);
 	writel_relaxed(val, csid->base + CSID_TOP_IRQ_CLEAR);
@@ -503,8 +512,12 @@ static irqreturn_t csid_isr(int irq, void *dev)
 	val = readl_relaxed(csid->base + CSID_CSI2_RX_IRQ_STATUS);
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_IRQ_CLEAR);
 
-	val = readl_relaxed(csid->base + CSID_CSI2_RDIN_IRQ_STATUS(0));
-	writel_relaxed(val, csid->base + CSID_CSI2_RDIN_IRQ_CLEAR(0));
+	/* Read and clear IRQ status for each enabled RDI channel */
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
+		if (csid->phy.en_vc & BIT(i)) {
+			val = readl_relaxed(csid->base + CSID_CSI2_RDIN_IRQ_STATUS(i));
+			writel_relaxed(val, csid->base + CSID_CSI2_RDIN_IRQ_CLEAR(i));
+		}
 
 	val = 1 << IRQ_CMD_CLEAR;
 	writel_relaxed(val, csid->base + CSID_IRQ_CMD);
diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index a1637b78568b..2a294587ec9d 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -180,6 +180,8 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 			return ret;
 		}
 
+		csid->phy.need_vc_update = true;
+
 		enable_irq(csid->irq);
 
 		ret = csid->ops->reset(csid);
@@ -229,7 +231,10 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
 			return -ENOLINK;
 	}
 
-	csid->ops->configure_stream(csid, enable);
+	if (csid->phy.need_vc_update) {
+		csid->ops->configure_stream(csid, enable);
+		csid->phy.need_vc_update = false;
+	}
 
 	return 0;
 }
@@ -440,6 +445,7 @@ static int csid_set_format(struct v4l2_subdev *sd,
 {
 	struct csid_device *csid = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_framefmt *format;
+	int i;
 
 	format = __csid_get_format(csid, sd_state, fmt->pad, fmt->which);
 	if (format == NULL)
@@ -448,14 +454,14 @@ static int csid_set_format(struct v4l2_subdev *sd,
 	csid_try_format(csid, sd_state, fmt->pad, &fmt->format, fmt->which);
 	*format = fmt->format;
 
-	/* Propagate the format from sink to source */
+	/* Propagate the format from sink to source pads */
 	if (fmt->pad == MSM_CSID_PAD_SINK) {
-		format = __csid_get_format(csid, sd_state, MSM_CSID_PAD_SRC,
-					   fmt->which);
+		for (i = MSM_CSID_PAD_FIRST_SRC; i < MSM_CSID_PADS_NUM; ++i) {
+			format = __csid_get_format(csid, sd_state, i, fmt->which);
 
-		*format = fmt->format;
-		csid_try_format(csid, sd_state, MSM_CSID_PAD_SRC, format,
-				fmt->which);
+			*format = fmt->format;
+			csid_try_format(csid, sd_state, i, format, fmt->which);
+		}
 	}
 
 	return 0;
@@ -695,7 +701,6 @@ static int csid_link_setup(struct media_entity *entity,
 		struct csid_device *csid;
 		struct csiphy_device *csiphy;
 		struct csiphy_lanes_cfg *lane_cfg;
-		struct v4l2_subdev_format format = { 0 };
 
 		sd = media_entity_to_v4l2_subdev(entity);
 		csid = v4l2_get_subdevdata(sd);
@@ -718,11 +723,22 @@ static int csid_link_setup(struct media_entity *entity,
 		lane_cfg = &csiphy->cfg.csi2->lane_cfg;
 		csid->phy.lane_cnt = lane_cfg->num_data;
 		csid->phy.lane_assign = csid_get_lane_assign(lane_cfg);
+	}
+	/* Decide which virtual channels to enable based on which source pads are enabled */
+	if (local->flags & MEDIA_PAD_FL_SOURCE) {
+		struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
+		struct csid_device *csid = v4l2_get_subdevdata(sd);
+		struct device *dev = csid->camss->dev;
+
+		if (flags & MEDIA_LNK_FL_ENABLED)
+			csid->phy.en_vc |= BIT(local->index - 1);
+		else
+			csid->phy.en_vc &= ~BIT(local->index - 1);
 
-		/* Reset format on source pad to sink pad format */
-		format.pad = MSM_CSID_PAD_SRC;
-		format.which = V4L2_SUBDEV_FORMAT_ACTIVE;
-		csid_set_format(&csid->subdev, NULL, &format);
+		csid->phy.need_vc_update = true;
+
+		dev_dbg(dev, "%s: Enabled CSID virtual channels mask 0x%x\n",
+			__func__, csid->phy.en_vc);
 	}
 
 	return 0;
@@ -773,6 +789,7 @@ int msm_csid_register_entity(struct csid_device *csid,
 	struct v4l2_subdev *sd = &csid->subdev;
 	struct media_pad *pads = csid->pads;
 	struct device *dev = csid->camss->dev;
+	int i;
 	int ret;
 
 	v4l2_subdev_init(sd, &csid_v4l2_ops);
@@ -809,7 +826,8 @@ int msm_csid_register_entity(struct csid_device *csid,
 	}
 
 	pads[MSM_CSID_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
-	pads[MSM_CSID_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+	for (i = MSM_CSID_PAD_FIRST_SRC; i < MSM_CSID_PADS_NUM; ++i)
+		pads[i].flags = MEDIA_PAD_FL_SOURCE;
 
 	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 	sd->entity.ops = &csid_media_ops;
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index 814ebc7c29d6..6b5485fe1833 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -19,8 +19,13 @@
 #include <media/v4l2-subdev.h>
 
 #define MSM_CSID_PAD_SINK 0
-#define MSM_CSID_PAD_SRC 1
-#define MSM_CSID_PADS_NUM 2
+#define MSM_CSID_PAD_FIRST_SRC 1
+#define MSM_CSID_PADS_NUM 5
+
+#define MSM_CSID_PAD_SRC (MSM_CSID_PAD_FIRST_SRC)
+
+/* CSID hardware can demultiplex up to 4 outputs */
+#define MSM_CSID_MAX_SRC_STREAMS	4
 
 #define DATA_TYPE_EMBEDDED_DATA_8BIT	0x12
 #define DATA_TYPE_YUV420_8BIT		0x18
@@ -81,6 +86,8 @@ struct csid_phy_config {
 	u8 csiphy_id;
 	u8 lane_cnt;
 	u32 lane_assign;
+	u32 en_vc;
+	u8 need_vc_update;
 };
 
 struct csid_device;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 555db1871ec9..8d823bc14700 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -682,10 +682,24 @@ static void xgbe_service(struct work_struct *work)
 static void xgbe_service_timer(struct timer_list *t)
 {
 	struct xgbe_prv_data *pdata = from_timer(pdata, t, service_timer);
+	struct xgbe_channel *channel;
+	unsigned int i;
 
 	queue_work(pdata->dev_workqueue, &pdata->service_work);
 
 	mod_timer(&pdata->service_timer, jiffies + HZ);
+
+	if (!pdata->tx_usecs)
+		return;
+
+	for (i = 0; i < pdata->channel_count; i++) {
+		channel = pdata->channel[i];
+		if (!channel->tx_ring || channel->tx_timer_active)
+			break;
+		channel->tx_timer_active = 1;
+		mod_timer(&channel->tx_timer,
+			  jiffies + usecs_to_jiffies(pdata->tx_usecs));
+	}
 }
 
 static void xgbe_init_timers(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index bafc51c34e0b..5bb7b2210b81 100644
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
index ca7372369b3e..60be836b294b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1178,7 +1178,19 @@ static int xgbe_phy_config_fixed(struct xgbe_prv_data *pdata)
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 483f660cebc4..c3e5ebc41667 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -1002,6 +1002,7 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	struct ethhdr *eth_hdr;
 	bool new = false;
 	int err = 0;
+	u64 vf_num;
 	u32 ring;
 
 	if (!flow_cfg->max_flows) {
@@ -1014,7 +1015,21 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
 		return -ENOMEM;
 
-	if (ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
+	/* Number of queues on a VF can be greater or less than
+	 * the PF's queue. Hence no need to check for the
+	 * queue count. Hence no need to check queue count if PF
+	 * is installing for its VF. Below is the expected vf_num value
+	 * based on the ethtool commands.
+	 *
+	 * e.g.
+	 * 1. ethtool -U <netdev> ... action -1  ==> vf_num:255
+	 * 2. ethtool -U <netdev> ... action <queue_num>  ==> vf_num:0
+	 * 3. ethtool -U <netdev> ... vf <vf_idx> queue <queue_num>  ==>
+	 *    vf_num:vf_idx+1
+	 */
+	vf_num = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
+	if (!is_otx2_vf(pfvf->pcifunc) && !vf_num &&
+	    ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
 		return -EINVAL;
 
 	if (fsp->location >= otx2_get_maxflows(flow_cfg))
@@ -1096,6 +1111,9 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 		flow_cfg->nr_flows++;
 	}
 
+	if (flow->is_vf)
+		netdev_info(pfvf->netdev,
+			    "Make sure that VF's queue number is within its queue limit\n");
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a718d42daeb5..8cb4b16ffad7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1838,6 +1838,8 @@ int otx2_stop(struct net_device *netdev)
 	/* Clear RSS enable flag */
 	rss = &pf->hw.rss_info;
 	rss->enable = false;
+	if (!netif_is_rxfh_configured(netdev))
+		kfree(rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP]);
 
 	/* Cleanup Queue IRQ */
 	vec = pci_irq_vector(pf->pdev,
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index e7f6c29b8dd8..63f33126d02f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -763,7 +763,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
 			/* Tx Full Checksum Offload Enabled */
 			cur_p->app0 |= 2;
-		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
 			csum_start_off = skb_transport_offset(skb);
 			csum_index_off = csum_start_off + skb->csum_offset;
 			/* Tx Partial Checksum Offload Enabled */
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ec622e909a68..ce1b299c89f5 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2227,9 +2227,6 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
-
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
@@ -2336,16 +2333,18 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 
 	}
 
-	/* Fallback path to check synthetic vf with
-	 * help of mac addr
+	/* Fallback path to check synthetic vf with help of mac addr.
+	 * Because this function can be called before vf_netdev is
+	 * initialized (NETDEV_POST_INIT) when its perm_addr has not been copied
+	 * from dev_addr, also try to match to its dev_addr.
+	 * Note: On Hyper-V and Azure, it's not possible to set a MAC address
+	 * on a VF that matches to the MAC of a unrelated NETVSC device.
 	 */
 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
 		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
-		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
-			netdev_notice(vf_netdev,
-				      "falling back to mac addr based matching\n");
+		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
+		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))
 			return ndev;
-		}
 	}
 
 	netdev_notice(vf_netdev,
@@ -2353,6 +2352,19 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	return NULL;
 }
 
+static int netvsc_prepare_bonding(struct net_device *vf_netdev)
+{
+	struct net_device *ndev;
+
+	ndev = get_netvsc_byslot(vf_netdev);
+	if (!ndev)
+		return NOTIFY_DONE;
+
+	/* set slave flag before open to prevent IPv6 addrconf */
+	vf_netdev->flags |= IFF_SLAVE;
+	return NOTIFY_DONE;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
@@ -2772,6 +2784,8 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
+		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:
@@ -2807,12 +2821,17 @@ static int __init netvsc_drv_init(void)
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
 
+	register_netdevice_notifier(&netvsc_netdev_notifier);
+
 	ret = vmbus_driver_register(&netvsc_drv);
 	if (ret)
-		return ret;
+		goto err_vmbus_reg;
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
+
+err_vmbus_reg:
+	unregister_netdevice_notifier(&netvsc_netdev_notifier);
+	return ret;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 0a2c3860179e..c419baf47813 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1700,11 +1700,11 @@ static int ax88179_reset(struct usbnet *dev)
 
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
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 5eaef79c06e1..e5e344af3423 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -193,7 +193,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
 	 */
 	while (skb_queue_len(&peer->staged_packet_queue) > MAX_STAGED_PACKETS) {
 		dev_kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
-		++dev->stats.tx_dropped;
+		DEV_STATS_INC(dev, tx_dropped);
 	}
 	skb_queue_splice_tail(&packets, &peer->staged_packet_queue);
 	spin_unlock_bh(&peer->staged_packet_queue.lock);
@@ -211,7 +211,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
 	else if (skb->protocol == htons(ETH_P_IPV6))
 		icmpv6_ndo_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0);
 err:
-	++dev->stats.tx_errors;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 	return ret;
 }
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index f500aaf67837..d38b24339a1f 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -423,20 +423,20 @@ static void wg_packet_consume_data_done(struct wg_peer *peer,
 	net_dbg_skb_ratelimited("%s: Packet has unallowed src IP (%pISc) from peer %llu (%pISpfsc)\n",
 				dev->name, skb, peer->internal_id,
 				&peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_frame_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_frame_errors);
 	goto packet_processed;
 dishonest_packet_type:
 	net_dbg_ratelimited("%s: Packet is neither ipv4 nor ipv6 from peer %llu (%pISpfsc)\n",
 			    dev->name, peer->internal_id, &peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_frame_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_frame_errors);
 	goto packet_processed;
 dishonest_packet_size:
 	net_dbg_ratelimited("%s: Packet has incorrect size from peer %llu (%pISpfsc)\n",
 			    dev->name, peer->internal_id, &peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_length_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_length_errors);
 	goto packet_processed;
 packet_processed:
 	dev_kfree_skb(skb);
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 95c853b59e1d..0d48e0f4a1ba 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -333,7 +333,8 @@ static void wg_packet_create_data(struct wg_peer *peer, struct sk_buff *first)
 void wg_packet_purge_staged_packets(struct wg_peer *peer)
 {
 	spin_lock_bh(&peer->staged_packet_queue.lock);
-	peer->device->dev->stats.tx_dropped += peer->staged_packet_queue.qlen;
+	DEV_STATS_ADD(peer->device->dev, tx_dropped,
+		      peer->staged_packet_queue.qlen);
 	__skb_queue_purge(&peer->staged_packet_queue);
 	spin_unlock_bh(&peer->staged_packet_queue.lock);
 }
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0454cee920..e5ee3d3ce164 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -206,6 +206,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
+	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status)
@@ -263,6 +265,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
+	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
 				   le16_to_cpu(d->cntlid), req);
 	if (!ctrl) {
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 0c6ab288201e..dc73b20e7424 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -697,18 +697,20 @@ static void dasd_profile_start(struct dasd_block *block,
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
 
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index b23e543b3a3d..8a2cc0405a4a 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -1522,6 +1522,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
 	unsigned long flags;
 	int counter = 0;
 
+	local_bh_disable();
 	spin_lock_irqsave(&pdev->lock, flags);
 
 	if (pdev->cdnsp_state & (CDNSP_STATE_HALTED | CDNSP_STATE_DYING)) {
@@ -1534,6 +1535,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
 			cdnsp_died(pdev);
 
 		spin_unlock_irqrestore(&pdev->lock, flags);
+		local_bh_enable();
 		return IRQ_HANDLED;
 	}
 
@@ -1550,6 +1552,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
 	cdnsp_update_erst_dequeue(pdev, event_ring_deq, 1);
 
 	spin_unlock_irqrestore(&pdev->lock, flags);
+	local_bh_enable();
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index d5f4ec1b73b1..08e2792cb732 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -2045,15 +2045,17 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 {
 	struct dwc2_qtd *qtd;
 	struct dwc2_host_chan *chan;
-	u32 hcint, hcintmsk;
+	u32 hcint, hcintraw, hcintmsk;
 
 	chan = hsotg->hc_ptr_array[chnum];
 
-	hcint = dwc2_readl(hsotg, HCINT(chnum));
+	hcintraw = dwc2_readl(hsotg, HCINT(chnum));
 	hcintmsk = dwc2_readl(hsotg, HCINTMSK(chnum));
+	hcint = hcintraw & hcintmsk;
+	dwc2_writel(hsotg, hcint, HCINT(chnum));
+
 	if (!chan) {
 		dev_err(hsotg->dev, "## hc_ptr_array for channel is NULL ##\n");
-		dwc2_writel(hsotg, hcint, HCINT(chnum));
 		return;
 	}
 
@@ -2062,11 +2064,9 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 			 chnum);
 		dev_vdbg(hsotg->dev,
 			 "  hcint 0x%08x, hcintmsk 0x%08x, hcint&hcintmsk 0x%08x\n",
-			 hcint, hcintmsk, hcint & hcintmsk);
+			 hcintraw, hcintmsk, hcint);
 	}
 
-	dwc2_writel(hsotg, hcint, HCINT(chnum));
-
 	/*
 	 * If we got an interrupt after someone called
 	 * dwc2_hcd_endpoint_disable() we don't want to crash below
@@ -2076,8 +2076,7 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 		return;
 	}
 
-	chan->hcint = hcint;
-	hcint &= hcintmsk;
+	chan->hcint = hcintraw;
 
 	/*
 	 * If the channel was halted due to a dequeue, the qtd list might
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 820ffd86e6e1..9e42023e2962 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1701,6 +1701,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err5:
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 81ff21bd405a..ba37bc72a220 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -545,6 +545,7 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 		dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
 		mode = DWC3_GCTL_PRTCAP_DEVICE;
 	}
+	dwc3_set_mode(dwc, mode);
 
 	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
 	dwc3_role_switch.set = dwc3_usb_role_switch_set;
@@ -554,7 +555,6 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 	if (IS_ERR(dwc->role_sw))
 		return PTR_ERR(dwc->role_sw);
 
-	dwc3_set_mode(dwc, mode);
 	return 0;
 }
 #else
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 0180350a2c95..41ca893d2d46 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -492,7 +492,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
@@ -507,7 +507,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 DP_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
@@ -522,7 +522,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 DM_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
@@ -537,7 +537,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 SS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
@@ -695,6 +695,7 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 	if (!qcom->dwc3) {
 		ret = -ENODEV;
 		dev_err(dev, "failed to get dwc3 platform device\n");
+		of_platform_depopulate(dev);
 	}
 
 node_put:
@@ -703,9 +704,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_device *
-dwc3_qcom_create_urs_usb_platdev(struct device *dev)
+static struct platform_device *dwc3_qcom_create_urs_usb_platdev(struct device *dev)
 {
+	struct platform_device *urs_usb = NULL;
 	struct fwnode_handle *fwh;
 	struct acpi_device *adev;
 	char name[8];
@@ -725,9 +726,26 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
 
 	adev = to_acpi_device_node(fwh);
 	if (!adev)
-		return NULL;
+		goto err_put_handle;
+
+	urs_usb = acpi_create_platform_device(adev, NULL);
+	if (IS_ERR_OR_NULL(urs_usb))
+		goto err_put_handle;
+
+	return urs_usb;
 
-	return acpi_create_platform_device(adev, NULL);
+err_put_handle:
+	fwnode_handle_put(fwh);
+
+	return urs_usb;
+}
+
+static void dwc3_qcom_destroy_urs_usb_platdev(struct platform_device *urs_usb)
+{
+	struct fwnode_handle *fwh = urs_usb->dev.fwnode;
+
+	platform_device_unregister(urs_usb);
+	fwnode_handle_put(fwh);
 }
 
 static int dwc3_qcom_probe(struct platform_device *pdev)
@@ -811,13 +829,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	qcom->qscratch_base = devm_ioremap_resource(dev, parent_res);
 	if (IS_ERR(qcom->qscratch_base)) {
 		ret = PTR_ERR(qcom->qscratch_base);
-		goto clk_disable;
+		goto free_urs;
 	}
 
 	ret = dwc3_qcom_setup_irq(pdev);
 	if (ret) {
 		dev_err(dev, "failed to setup IRQs, err=%d\n", ret);
-		goto clk_disable;
+		goto free_urs;
 	}
 
 	/*
@@ -836,7 +854,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to register DWC3 Core, err=%d\n", ret);
-		goto depopulate;
+		goto free_urs;
 	}
 
 	ret = dwc3_qcom_interconnect_init(qcom);
@@ -865,10 +883,16 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 interconnect_exit:
 	dwc3_qcom_interconnect_exit(qcom);
 depopulate:
-	if (np)
+	if (np) {
 		of_platform_depopulate(&pdev->dev);
-	else
-		platform_device_put(pdev);
+	} else {
+		device_remove_software_node(&qcom->dwc3->dev);
+		platform_device_del(qcom->dwc3);
+	}
+	platform_device_put(qcom->dwc3);
+free_urs:
+	if (qcom->urs_usb)
+		dwc3_qcom_destroy_urs_usb_platdev(qcom->urs_usb);
 clk_disable:
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
@@ -887,11 +911,16 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i;
 
-	device_remove_software_node(&qcom->dwc3->dev);
-	if (np)
+	if (np) {
 		of_platform_depopulate(&pdev->dev);
-	else
-		platform_device_put(pdev);
+	} else {
+		device_remove_software_node(&qcom->dwc3->dev);
+		platform_device_del(qcom->dwc3);
+	}
+	platform_device_put(qcom->dwc3);
+
+	if (qcom->urs_usb)
+		dwc3_qcom_destroy_urs_usb_platdev(qcom->urs_usb);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index b9dd714a3ae6..7f2aa72d52e6 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,8 +203,8 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
-#define DELL_PRODUCT_FM101R			0x8213
-#define DELL_PRODUCT_FM101R_ESIM		0x8215
+#define DELL_PRODUCT_FM101R_ESIM		0x8213
+#define DELL_PRODUCT_FM101R			0x8215
 
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
@@ -609,6 +609,8 @@ static void option_instat_callback(struct urb *urb);
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+/* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
+#define LUAT_PRODUCT_AIR720U			0x4e00
 
 /* Device flags */
 
@@ -1546,7 +1548,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0165, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0167, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0191, 0xff, 0xff, 0xff), /* ZTE EuFi890 */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0196, 0xff, 0xff, 0xff) },
@@ -2249,6 +2252,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1782, 0x4d11, 0xff) },			/* Fibocom L610 (ECM/RNDIS mode) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0001, 0xff, 0xff, 0xff) },	/* Fibocom L716-EU (ECM/RNDIS mode) */
 	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
@@ -2271,6 +2275,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d917b133d2a5..359c9bd7848f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5350,6 +5350,15 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 	if (port->bist_request == BDO_MODE_TESTDATA && port->tcpc->set_bist_data)
 		port->tcpc->set_bist_data(port->tcpc, false);
 
+	switch (port->state) {
+	case ERROR_RECOVERY:
+	case PORT_RESET:
+	case PORT_RESET_WAIT_OFF:
+		return;
+	default:
+		break;
+	}
+
 	if (port->ams != NONE_AMS)
 		port->ams = NONE_AMS;
 	if (port->hard_reset_count < PD_N_HARD_RESET_COUNT)
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index cbdff8979980..86bcf329ebfb 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -564,4 +564,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.get_sgtable = dma_common_get_sgtable,
 	.alloc_pages = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
+	.max_mapping_size = swiotlb_max_mapping_size,
 };
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index db832cc931c8..b35c6081dbfe 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -131,8 +131,8 @@ static int afs_probe_cell_name(struct dentry *dentry)
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
 			NULL, NULL, false);
-	if (ret == -ENODATA)
-		ret = -EDESTADDRREQ;
+	if (ret == -ENODATA || ret == -ENOKEY)
+		ret = -ENOENT;
 	return ret;
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 567e61b553f5..183200c6ce20 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -556,6 +556,7 @@ struct afs_server_entry {
 };
 
 struct afs_server_list {
+	struct rcu_head		rcu;
 	afs_volid_t		vids[AFS_MAXTYPES]; /* Volume IDs */
 	refcount_t		usage;
 	unsigned char		nr_servers;
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index ed9056703505..b59896b1de0a 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -17,7 +17,7 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 		for (i = 0; i < slist->nr_servers; i++)
 			afs_unuse_server(net, slist->servers[i].server,
 					 afs_server_trace_put_slist);
-		kfree(slist);
+		kfree_rcu(slist, rcu);
 	}
 }
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 34c68724c98b..910e73bb5a08 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -406,6 +406,8 @@ static int afs_validate_fc(struct fs_context *fc)
 			return PTR_ERR(volume);
 
 		ctx->volume = volume;
+		if (volume->type != AFSVL_RWVOL)
+			ctx->flock_mode = afs_flock_mode_local;
 	}
 
 	return 0;
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 488e58490b16..eb415ce56360 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -58,6 +58,12 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 		}
 
 		/* Status load is ordered after lookup counter load */
+		if (cell->dns_status == DNS_LOOKUP_GOT_NOT_FOUND) {
+			pr_warn("No record of cell %s\n", cell->name);
+			vc->error = -ENOENT;
+			return false;
+		}
+
 		if (cell->dns_source == DNS_RECORD_UNAVAILABLE) {
 			vc->error = -EDESTADDRREQ;
 			return false;
@@ -285,6 +291,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
  */
 static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 {
+	struct afs_cell *cell = vc->cell;
 	static int count;
 	int i;
 
@@ -294,6 +301,9 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 
 	rcu_read_lock();
 	pr_notice("EDESTADDR occurred\n");
+	pr_notice("CELL: %s err=%d\n", cell->name, cell->error);
+	pr_notice("DNS: src=%u st=%u lc=%x\n",
+		  cell->dns_source, cell->dns_status, cell->dns_lookup_count);
 	pr_notice("VC: ut=%lx ix=%u ni=%hu fl=%hx err=%hd\n",
 		  vc->untried, vc->index, vc->nr_iterations, vc->flags, vc->error);
 
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7806adcc41a7..cccbdfd49a86 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -144,14 +144,17 @@
 static struct kmem_cache *ext4_es_cachep;
 static struct kmem_cache *ext4_pending_cachep;
 
-static int __es_insert_extent(struct inode *inode, struct extent_status *newes);
+static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
+			      struct extent_status *prealloc);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved);
+			      ext4_lblk_t end, int *reserved,
+			      struct extent_status *prealloc);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 		       struct ext4_inode_info *locked_ei);
-static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
-			     ext4_lblk_t len);
+static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
+			    ext4_lblk_t len,
+			    struct pending_reservation **prealloc);
 
 int __init ext4_init_es(void)
 {
@@ -448,22 +451,49 @@ static void ext4_es_list_del(struct inode *inode)
 	spin_unlock(&sbi->s_es_lock);
 }
 
-static struct extent_status *
-ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
-		     ext4_fsblk_t pblk)
+static inline struct pending_reservation *__alloc_pending(bool nofail)
+{
+	if (!nofail)
+		return kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
+
+	return kmem_cache_zalloc(ext4_pending_cachep, GFP_KERNEL | __GFP_NOFAIL);
+}
+
+static inline void __free_pending(struct pending_reservation *pr)
+{
+	kmem_cache_free(ext4_pending_cachep, pr);
+}
+
+/*
+ * Returns true if we cannot fail to allocate memory for this extent_status
+ * entry and cannot reclaim it until its status changes.
+ */
+static inline bool ext4_es_must_keep(struct extent_status *es)
+{
+	/* fiemap, bigalloc, and seek_data/hole need to use it. */
+	if (ext4_es_is_delayed(es))
+		return true;
+
+	return false;
+}
+
+static inline struct extent_status *__es_alloc_extent(bool nofail)
+{
+	if (!nofail)
+		return kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
+
+	return kmem_cache_zalloc(ext4_es_cachep, GFP_KERNEL | __GFP_NOFAIL);
+}
+
+static void ext4_es_init_extent(struct inode *inode, struct extent_status *es,
+		ext4_lblk_t lblk, ext4_lblk_t len, ext4_fsblk_t pblk)
 {
-	struct extent_status *es;
-	es = kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
-	if (es == NULL)
-		return NULL;
 	es->es_lblk = lblk;
 	es->es_len = len;
 	es->es_pblk = pblk;
 
-	/*
-	 * We don't count delayed extent because we never try to reclaim them
-	 */
-	if (!ext4_es_is_delayed(es)) {
+	/* We never try to reclaim a must kept extent, so we don't count it. */
+	if (!ext4_es_must_keep(es)) {
 		if (!EXT4_I(inode)->i_es_shk_nr++)
 			ext4_es_list_add(inode);
 		percpu_counter_inc(&EXT4_SB(inode->i_sb)->
@@ -472,8 +502,11 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 
 	EXT4_I(inode)->i_es_all_nr++;
 	percpu_counter_inc(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
+}
 
-	return es;
+static inline void __es_free_extent(struct extent_status *es)
+{
+	kmem_cache_free(ext4_es_cachep, es);
 }
 
 static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
@@ -481,8 +514,8 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
 	EXT4_I(inode)->i_es_all_nr--;
 	percpu_counter_dec(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
 
-	/* Decrease the shrink counter when this es is not delayed */
-	if (!ext4_es_is_delayed(es)) {
+	/* Decrease the shrink counter when we can reclaim the extent. */
+	if (!ext4_es_must_keep(es)) {
 		BUG_ON(EXT4_I(inode)->i_es_shk_nr == 0);
 		if (!--EXT4_I(inode)->i_es_shk_nr)
 			ext4_es_list_del(inode);
@@ -490,7 +523,7 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
 					s_es_stats.es_stats_shk_cnt);
 	}
 
-	kmem_cache_free(ext4_es_cachep, es);
+	__es_free_extent(es);
 }
 
 /*
@@ -752,7 +785,8 @@ static inline void ext4_es_insert_extent_check(struct inode *inode,
 }
 #endif
 
-static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
+static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
+			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node **p = &tree->root.rb_node;
@@ -792,10 +826,15 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 		}
 	}
 
-	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
-				  newes->es_pblk);
+	if (prealloc)
+		es = prealloc;
+	else
+		es = __es_alloc_extent(false);
 	if (!es)
 		return -ENOMEM;
+	ext4_es_init_extent(inode, es, newes->es_lblk, newes->es_len,
+			    newes->es_pblk);
+
 	rb_link_node(&es->rb_node, parent, p);
 	rb_insert_color(&es->rb_node, &tree->root);
 
@@ -816,8 +855,12 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
-	int err = 0;
+	int err1 = 0, err2 = 0, err3 = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct extent_status *es1 = NULL;
+	struct extent_status *es2 = NULL;
+	struct pending_reservation *pr = NULL;
+	bool revise_pending = false;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -845,29 +888,57 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_insert_extent_check(inode, &newes);
 
+	revise_pending = sbi->s_cluster_ratio > 1 &&
+			 test_opt(inode->i_sb, DELALLOC) &&
+			 (status & (EXTENT_STATUS_WRITTEN |
+				    EXTENT_STATUS_UNWRITTEN));
+retry:
+	if (err1 && !es1)
+		es1 = __es_alloc_extent(true);
+	if ((err1 || err2) && !es2)
+		es2 = __es_alloc_extent(true);
+	if ((err1 || err2 || err3) && revise_pending && !pr)
+		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, NULL);
-	if (err != 0)
+
+	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
+	if (err1 != 0)
 		goto error;
-retry:
-	err = __es_insert_extent(inode, &newes);
-	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
-					  128, EXT4_I(inode)))
-		goto retry;
-	if (err == -ENOMEM && !ext4_es_is_delayed(&newes))
-		err = 0;
+	/* Free preallocated extent if it didn't get used. */
+	if (es1) {
+		if (!es1->es_len)
+			__es_free_extent(es1);
+		es1 = NULL;
+	}
 
-	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
-	    (status & EXTENT_STATUS_WRITTEN ||
-	     status & EXTENT_STATUS_UNWRITTEN))
-		__revise_pending(inode, lblk, len);
+	err2 = __es_insert_extent(inode, &newes, es2);
+	if (err2 == -ENOMEM && !ext4_es_must_keep(&newes))
+		err2 = 0;
+	if (err2 != 0)
+		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es2) {
+		if (!es2->es_len)
+			__es_free_extent(es2);
+		es2 = NULL;
+	}
 
+	if (revise_pending) {
+		err3 = __revise_pending(inode, lblk, len, &pr);
+		if (err3 != 0)
+			goto error;
+		if (pr) {
+			__free_pending(pr);
+			pr = NULL;
+		}
+	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (err1 || err2 || err3)
+		goto retry;
 
 	ext4_es_print_tree(inode);
-
-	return err;
+	return 0;
 }
 
 /*
@@ -900,7 +971,7 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
 	if (!es || es->es_lblk > end)
-		__es_insert_extent(inode, &newes);
+		__es_insert_extent(inode, &newes, NULL);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
 
@@ -1271,7 +1342,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 				rc->ndelonly--;
 				node = rb_next(&pr->rb_node);
 				rb_erase(&pr->rb_node, &tree->root);
-				kmem_cache_free(ext4_pending_cachep, pr);
+				__free_pending(pr);
 				if (!node)
 					break;
 				pr = rb_entry(node, struct pending_reservation,
@@ -1290,6 +1361,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * @lblk - first block in range
  * @end - last block in range
  * @reserved - number of cluster reservations released
+ * @prealloc - pre-allocated es to avoid memory allocation failures
  *
  * If @reserved is not NULL and delayed allocation is enabled, counts
  * block/cluster reservations freed by removing range and if bigalloc
@@ -1297,7 +1369,8 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * error code on failure.
  */
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved)
+			      ext4_lblk_t end, int *reserved,
+			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node *node;
@@ -1305,14 +1378,12 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status orig_es;
 	ext4_lblk_t len1, len2;
 	ext4_fsblk_t block;
-	int err;
+	int err = 0;
 	bool count_reserved = true;
 	struct rsvd_count rc;
 
 	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
 		count_reserved = false;
-retry:
-	err = 0;
 
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
@@ -1346,14 +1417,13 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 					orig_es.es_len - len2;
 			ext4_es_store_pblock_status(&newes, block,
 						    ext4_es_status(&orig_es));
-			err = __es_insert_extent(inode, &newes);
+			err = __es_insert_extent(inode, &newes, prealloc);
 			if (err) {
+				if (!ext4_es_must_keep(&newes))
+					return 0;
+
 				es->es_lblk = orig_es.es_lblk;
 				es->es_len = orig_es.es_len;
-				if ((err == -ENOMEM) &&
-				    __es_shrink(EXT4_SB(inode->i_sb),
-							128, EXT4_I(inode)))
-					goto retry;
 				goto out;
 			}
 		} else {
@@ -1433,6 +1503,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t end;
 	int err = 0;
 	int reserved = 0;
+	struct extent_status *es = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -1447,17 +1518,29 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	end = lblk + len - 1;
 	BUG_ON(end < lblk);
 
+retry:
+	if (err && !es)
+		es = __es_alloc_extent(true);
 	/*
 	 * ext4_clear_inode() depends on us taking i_es_lock unconditionally
 	 * so that we are sure __es_shrink() is done with the inode before it
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved);
+	err = __es_remove_extent(inode, lblk, end, &reserved, es);
+	/* Free preallocated extent if it didn't get used. */
+	if (es) {
+		if (!es->es_len)
+			__es_free_extent(es);
+		es = NULL;
+	}
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (err)
+		goto retry;
+
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
-	return err;
+	return 0;
 }
 
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
@@ -1704,11 +1787,8 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
 
 		(*nr_to_scan)--;
 		node = rb_next(&es->rb_node);
-		/*
-		 * We can't reclaim delayed extent from status tree because
-		 * fiemap, bigallic, and seek_data/hole need to use it.
-		 */
-		if (ext4_es_is_delayed(es))
+
+		if (ext4_es_must_keep(es))
 			goto next;
 		if (ext4_es_is_referenced(es)) {
 			ext4_es_clear_referenced(es);
@@ -1772,7 +1852,7 @@ void ext4_clear_inode_es(struct inode *inode)
 	while (node) {
 		es = rb_entry(node, struct extent_status, rb_node);
 		node = rb_next(node);
-		if (!ext4_es_is_delayed(es)) {
+		if (!ext4_es_must_keep(es)) {
 			rb_erase(&es->rb_node, &tree->root);
 			ext4_es_free_extent(inode, es);
 		}
@@ -1859,11 +1939,13 @@ static struct pending_reservation *__get_pending(struct inode *inode,
  *
  * @inode - file containing the cluster
  * @lblk - logical block in the cluster to be added
+ * @prealloc - preallocated pending entry
  *
  * Returns 0 on successful insertion and -ENOMEM on failure.  If the
  * pending reservation is already in the set, returns successfully.
  */
-static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
+static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
+			    struct pending_reservation **prealloc)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_pending_tree *tree = &EXT4_I(inode)->i_pending_tree;
@@ -1889,10 +1971,15 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	pr = kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
-	if (pr == NULL) {
-		ret = -ENOMEM;
-		goto out;
+	if (likely(*prealloc == NULL)) {
+		pr = __alloc_pending(false);
+		if (!pr) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else {
+		pr = *prealloc;
+		*prealloc = NULL;
 	}
 	pr->lclu = lclu;
 
@@ -1922,7 +2009,7 @@ static void __remove_pending(struct inode *inode, ext4_lblk_t lblk)
 	if (pr != NULL) {
 		tree = &EXT4_I(inode)->i_pending_tree;
 		rb_erase(&pr->rb_node, &tree->root);
-		kmem_cache_free(ext4_pending_cachep, pr);
+		__free_pending(pr);
 	}
 }
 
@@ -1983,7 +2070,10 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 				 bool allocated)
 {
 	struct extent_status newes;
-	int err = 0;
+	int err1 = 0, err2 = 0, err3 = 0;
+	struct extent_status *es1 = NULL;
+	struct extent_status *es2 = NULL;
+	struct pending_reservation *pr = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -1998,29 +2088,52 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_insert_extent_check(inode, &newes);
 
+retry:
+	if (err1 && !es1)
+		es1 = __es_alloc_extent(true);
+	if ((err1 || err2) && !es2)
+		es2 = __es_alloc_extent(true);
+	if ((err1 || err2 || err3) && allocated && !pr)
+		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err = __es_remove_extent(inode, lblk, lblk, NULL);
-	if (err != 0)
-		goto error;
-retry:
-	err = __es_insert_extent(inode, &newes);
-	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
-					  128, EXT4_I(inode)))
-		goto retry;
-	if (err != 0)
+	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
+	if (err1 != 0)
 		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es1) {
+		if (!es1->es_len)
+			__es_free_extent(es1);
+		es1 = NULL;
+	}
 
-	if (allocated)
-		__insert_pending(inode, lblk);
+	err2 = __es_insert_extent(inode, &newes, es2);
+	if (err2 != 0)
+		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es2) {
+		if (!es2->es_len)
+			__es_free_extent(es2);
+		es2 = NULL;
+	}
 
+	if (allocated) {
+		err3 = __insert_pending(inode, lblk, &pr);
+		if (err3 != 0)
+			goto error;
+		if (pr) {
+			__free_pending(pr);
+			pr = NULL;
+		}
+	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (err1 || err2 || err3)
+		goto retry;
 
 	ext4_es_print_tree(inode);
 	ext4_print_pending_tree(inode);
-
-	return err;
+	return 0;
 }
 
 /*
@@ -2121,21 +2234,24 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
  * @inode - file containing the range
  * @lblk - logical block defining the start of range
  * @len  - length of range in blocks
+ * @prealloc - preallocated pending entry
  *
  * Used after a newly allocated extent is added to the extents status tree.
  * Requires that the extents in the range have either written or unwritten
  * status.  Must be called while holding i_es_lock.
  */
-static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
-			     ext4_lblk_t len)
+static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
+			    ext4_lblk_t len,
+			    struct pending_reservation **prealloc)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_lblk_t end = lblk + len - 1;
 	ext4_lblk_t first, last;
 	bool f_del = false, l_del = false;
+	int ret = 0;
 
 	if (len == 0)
-		return;
+		return 0;
 
 	/*
 	 * Two cases - block range within single cluster and block range
@@ -2156,7 +2272,9 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						first, lblk - 1);
 		if (f_del) {
-			__insert_pending(inode, first);
+			ret = __insert_pending(inode, first, prealloc);
+			if (ret < 0)
+				goto out;
 		} else {
 			last = EXT4_LBLK_CMASK(sbi, end) +
 			       sbi->s_cluster_ratio - 1;
@@ -2164,9 +2282,11 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 				l_del = __es_scan_range(inode,
 							&ext4_es_is_delonly,
 							end + 1, last);
-			if (l_del)
-				__insert_pending(inode, last);
-			else
+			if (l_del) {
+				ret = __insert_pending(inode, last, prealloc);
+				if (ret < 0)
+					goto out;
+			} else
 				__remove_pending(inode, last);
 		}
 	} else {
@@ -2174,18 +2294,24 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 		if (first != lblk)
 			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						first, lblk - 1);
-		if (f_del)
-			__insert_pending(inode, first);
-		else
+		if (f_del) {
+			ret = __insert_pending(inode, first, prealloc);
+			if (ret < 0)
+				goto out;
+		} else
 			__remove_pending(inode, first);
 
 		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
 		if (last != end)
 			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						end + 1, last);
-		if (l_del)
-			__insert_pending(inode, last);
-		else
+		if (l_del) {
+			ret = __insert_pending(inode, last, prealloc);
+			if (ret < 0)
+				goto out;
+		} else
 			__remove_pending(inode, last);
 	}
+out:
+	return ret;
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index caa421ba078f..4192fe6ec3da 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1780,6 +1780,13 @@ static const char *sysctl_find_alias(char *param)
 	return NULL;
 }
 
+bool sysctl_is_alias(char *param)
+{
+	const char *alias = sysctl_find_alias(param);
+
+	return alias != NULL;
+}
+
 /* Set sysctl value passed on kernel command line. */
 static int process_sysctl_arg(char *param, char *val,
 			       const char *unused, void *arg)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index c3478e396829..ad97435d8e01 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -630,8 +630,13 @@ struct hid_device {							/* device report descriptor */
 	struct list_head debug_list;
 	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
+	struct kref			ref;
+
+	unsigned int id;						/* system unique id */
 };
 
+void hiddev_free(struct kref *ref);
+
 #define to_hid_device(pdev) \
 	container_of(pdev, struct hid_device, dev)
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 47cf70c8eb93..32d79ef906e5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -210,6 +210,7 @@ extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name);
 #define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
 void do_sysctl_args(void);
+bool sysctl_is_alias(char *param);
 
 extern int pwrsw_enabled;
 extern int unaligned_enabled;
@@ -251,6 +252,11 @@ static inline void setup_sysctl_set(struct ctl_table_set *p,
 static inline void do_sysctl_args(void)
 {
 }
+
+static inline bool sysctl_is_alias(char *param)
+{
+	return false;
+}
 #endif /* CONFIG_SYSCTL */
 
 int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
diff --git a/init/main.c b/init/main.c
index 63737af8de51..5c81d7fb2fe9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -540,6 +540,10 @@ static int __init unknown_bootoption(char *param, char *val,
 {
 	size_t len = strlen(param);
 
+	/* Handle params aliased to sysctls */
+	if (sysctl_is_alias(param))
+		return 0;
+
 	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e26292d8b845..5b2dbd3dc2de 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3152,7 +3152,7 @@ static int __io_import_fixed(struct io_kiocb *req, int rw, struct iov_iter *iter
 		 */
 		const struct bio_vec *bvec = imu->bvec;
 
-		if (offset <= bvec->bv_len) {
+		if (offset < bvec->bv_len) {
 			iov_iter_advance(iter, offset);
 		} else {
 			unsigned long seg_skip;
@@ -4049,7 +4049,7 @@ static int io_linkat_prep(struct io_kiocb *req,
 	newf = u64_to_user_ptr(READ_ONCE(sqe->addr2));
 	lnk->flags = READ_ONCE(sqe->hardlink_flags);
 
-	lnk->oldpath = getname(oldf);
+	lnk->oldpath = getname_uflags(oldf, lnk->flags);
 	if (IS_ERR(lnk->oldpath))
 		return PTR_ERR(lnk->oldpath);
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e6a282bc1665..770ff5bf1487 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3416,7 +3416,8 @@ static int alloc_chain_hlocks(int req)
 		size = chain_block_size(curr);
 		if (likely(size >= req)) {
 			del_chain_block(0, size, chain_block_next(curr));
-			add_chain_block(curr + req, size - req);
+			if (size > req)
+				add_chain_block(curr + req, size - req);
 			return curr;
 		}
 	}
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ea5329cb0fce..12c59d700942 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -786,7 +786,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 			goto reject_redirect;
 	}
 
-	n = __ipv4_neigh_lookup(rt->dst.dev, new_gw);
+	n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw);
 	if (!n)
 		n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
 	if (!IS_ERR(n)) {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 49cf523a783a..8c11eb70c0f6 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -398,8 +398,12 @@ static int smcr_clnt_conf_first_link(struct smc_sock *smc)
 	struct smc_llc_qentry *qentry;
 	int rc;
 
-	/* receive CONFIRM LINK request from server over RoCE fabric */
-	qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
+	/* Receive CONFIRM LINK request from server over RoCE fabric.
+	 * Increasing the client's timeout by twice as much as the server's
+	 * timeout by default can temporarily avoid decline messages of
+	 * both sides crossing or colliding
+	 */
+	qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
 			      SMC_LLC_CONFIRM_LINK);
 	if (!qentry) {
 		struct smc_clc_msg_decline dclc;
