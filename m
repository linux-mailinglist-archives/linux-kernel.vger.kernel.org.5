Return-Path: <linux-kernel+bounces-7257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059381A3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCABA284EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183A34A98E;
	Wed, 20 Dec 2023 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFrw2kIN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD54A997;
	Wed, 20 Dec 2023 16:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DFEC433C7;
	Wed, 20 Dec 2023 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088514;
	bh=8l4mDSB30iNuwVbHDfmfuZENs72l10TDDTgO20hBhI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFrw2kINrZk3DEwi+T4uX90tKaoXpErsovitmzPll9yyisQO1/VN2n8vu5ckRaFfK
	 T8V9Qk9ZD3bAJMbQcGuqhNoYgbUO87Ey9RlAV+cmGq0spzyUr8/JBu3uHt1f2qVQHA
	 cg98AUZ6M4DYXvo5EgcNGlSez7fCYrZL4lueShf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.303
Date: Wed, 20 Dec 2023 17:08:23 +0100
Message-ID: <2023122022-neon-earthling-33ef@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023122022-shifting-blasphemy-15a4@gregkh>
References: <2023122022-shifting-blasphemy-15a4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index acd4be908046..dbfb41f4d203 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 302
+SUBLEVEL = 303
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 71a73ca1e2b0..045591a9539b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -595,6 +595,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
+	/*
+	 * If we end up clearing hw dirtiness for a sw-dirty PTE, set hardware
+	 * dirtiness again.
+	 */
+	if (pte_sw_dirty(pte))
+		pte = pte_mkdirty(pte);
 	return pte;
 }
 
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 32476a6e4e9c..6802cc2592d5 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -40,6 +40,9 @@ _GLOBAL(ftrace_regs_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0,LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1,-SWITCH_FRAME_SIZE(r1)
 
@@ -56,7 +59,7 @@ _GLOBAL(ftrace_regs_caller)
 	SAVE_10GPRS(22, r1)
 
 	/* Save previous stack pointer (r1) */
-	addi	r8, r1, SWITCH_FRAME_SIZE
+	addi	r8, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	std	r8, GPR1(r1)
 
 	/* Load special regs for save below */
@@ -69,6 +72,8 @@ _GLOBAL(ftrace_regs_caller)
 	mflr	r7
 	/* Save it as pt_regs->nip */
 	std     r7, _NIP(r1)
+	/* Also save it in B's stackframe header for proper unwind */
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 	/* Save the read LR in pt_regs->link */
 	std     r0, _LINK(r1)
 
@@ -125,7 +130,7 @@ ftrace_regs_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi r1, r1, SWITCH_FRAME_SIZE
+	addi r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 #ifdef CONFIG_LIVEPATCH
         /* Based on the cmpd above, if the NIP was altered handle livepatch */
@@ -149,7 +154,7 @@ ftrace_no_trace:
 	mflr	r3
 	mtctr	r3
 	REST_GPR(3, r1)
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	mtlr	r0
 	bctr
 
@@ -157,6 +162,9 @@ _GLOBAL(ftrace_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0, LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1, -SWITCH_FRAME_SIZE(r1)
 
@@ -170,6 +178,7 @@ _GLOBAL(ftrace_caller)
 	/* Get the _mcount() call site out of LR */
 	mflr	r7
 	std     r7, _NIP(r1)
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, 24(r1)
@@ -204,7 +213,7 @@ ftrace_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 	/* Reload original LR */
 	ld	r0, LRSAVE(r1)
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 853b1770df36..e58c03c504c1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1383,6 +1383,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1410,6 +1411,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 17283018269f..60fd48f23c6d 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -458,9 +458,9 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	struct sk_buff *skb;
 	unsigned int len;
 
-	spin_lock(&card->cli_queue_lock);
+	spin_lock_bh(&card->cli_queue_lock);
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
-	spin_unlock(&card->cli_queue_lock);
+	spin_unlock_bh(&card->cli_queue_lock);
 	if(skb == NULL)
 		return sprintf(buf, "No data.\n");
 
@@ -968,14 +968,14 @@ static void pclose(struct atm_vcc *vcc)
 	struct pkt_hdr *header;
 
 	/* Remove any yet-to-be-transmitted packets from the pending queue */
-	spin_lock(&card->tx_queue_lock);
+	spin_lock_bh(&card->tx_queue_lock);
 	skb_queue_walk_safe(&card->tx_queue[port], skb, tmpskb) {
 		if (SKB_CB(skb)->vcc == vcc) {
 			skb_unlink(skb, &card->tx_queue[port]);
 			solos_pop(vcc, skb);
 		}
 	}
-	spin_unlock(&card->tx_queue_lock);
+	spin_unlock_bh(&card->tx_queue_lock);
 
 	skb = alloc_skb(sizeof(*header), GFP_KERNEL);
 	if (!skb) {
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 4dddf3ce32d7..0842d7bdcbc7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -252,7 +252,7 @@ static int asus_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
-static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size)
+static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
 	unsigned char *dmabuf;
 	int ret;
@@ -271,7 +271,7 @@ static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size
 
 static int asus_kbd_init(struct hid_device *hdev)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
 		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	int ret;
 
@@ -285,7 +285,7 @@ static int asus_kbd_init(struct hid_device *hdev)
 static int asus_kbd_get_functions(struct hid_device *hdev,
 				  unsigned char *kbd_func)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
 	u8 *readbuf;
 	int ret;
 
@@ -614,6 +614,24 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
+static int __maybe_unused asus_resume(struct hid_device *hdev) {
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret = 0;
+
+	if (drvdata->kbd_backlight) {
+		const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4,
+				drvdata->kbd_backlight->cdev.brightness };
+		ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
+		if (ret < 0) {
+			hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
+			goto asus_resume_err;
+		}
+	}
+
+asus_resume_err:
+	return ret;
+}
+
 static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -831,6 +849,7 @@ static struct hid_driver asus_driver = {
 	.input_configured       = asus_input_configured,
 #ifdef CONFIG_PM
 	.reset_resume           = asus_reset_resume,
+	.resume					= asus_resume,
 #endif
 	.raw_event		= asus_raw_event
 };
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6411ee12c7a3..14dc5ec9edc6 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1981,6 +1981,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_HANVON_ALT,
 			USB_DEVICE_ID_HANVON_ALT_MULTITOUCH) },
 
+	/* HONOR GLO-GXXX panel */
+	{ .driver_data = MT_CLS_VTL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			0x347d, 0x7853) },
+
 	/* Ilitek dual touch panel */
 	{  .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 0b85f95810b3..2e1b95f73c64 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -35,6 +35,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AMI, USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ANSI), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM), HID_QUIRK_NOGET },
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index e81d78310984..d0311e3065ca 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -265,6 +265,7 @@ struct bcache_device {
 #define BCACHE_DEV_WB_RUNNING		3
 #define BCACHE_DEV_RATE_DW_RUNNING	4
 	int			nr_stripes;
+#define BCH_MIN_STRIPE_SZ		((4 << 20) >> SECTOR_SHIFT)
 	unsigned int		stripe_size;
 	atomic_t		*stripe_sectors_dirty;
 	unsigned long		*full_dirty_stripes;
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 3518088d7ff1..de1eb7961fe6 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1008,6 +1008,9 @@ static struct btree *mca_alloc(struct cache_set *c, struct btree_op *op,
  *
  * The btree node will have either a read or a write lock held, depending on
  * level and op->lock.
+ *
+ * Note: Only error code or btree pointer will be returned, it is unncessary
+ *       for callers to check NULL pointer.
  */
 struct btree *bch_btree_node_get(struct cache_set *c, struct btree_op *op,
 				 struct bkey *k, int level, bool write,
@@ -1120,6 +1123,10 @@ static void btree_node_free(struct btree *b)
 	mutex_unlock(&b->c->bucket_lock);
 }
 
+/*
+ * Only error code or btree pointer will be returned, it is unncessary for
+ * callers to check NULL pointer.
+ */
 struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
 				     int level, bool wait,
 				     struct btree *parent)
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4b076f7f184b..70f0f3096bee 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -807,6 +807,8 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 
 	if (!d->stripe_size)
 		d->stripe_size = 1 << 31;
+	else if (d->stripe_size < BCH_MIN_STRIPE_SZ)
+		d->stripe_size = roundup(BCH_MIN_STRIPE_SZ, d->stripe_size);
 
 	d->nr_stripes = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
 
@@ -1844,7 +1846,7 @@ static int run_cache_set(struct cache_set *c)
 		c->root = bch_btree_node_get(c, NULL, k,
 					     j->btree_level,
 					     true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		list_del_init(&c->root->list);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3c299417c4ab..3399e8c477b9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -573,6 +573,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
+	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, true);
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index c2187fc6dcba..2ed47f800126 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -448,8 +448,8 @@ int mmc_switch_status(struct mmc_card *card)
 	return __mmc_switch_status(card, true);
 }
 
-static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			bool send_status, bool retry_crc_err)
+int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+		      bool send_status, bool retry_crc_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -502,6 +502,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mmc_poll_for_busy);
 
 /**
  *	__mmc_switch - modify EXT_CSD register
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 018a5e3f66d6..daf7ab867f0e 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -35,6 +35,8 @@ int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card);
 int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
+int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+		      bool send_status, bool retry_crc_err);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool use_busy_signal, bool send_status,	bool retry_crc_err);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 734462f8d881..88232a6a4584 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1024,6 +1024,7 @@ static void qed_ilt_shadow_free(struct qed_hwfn *p_hwfn)
 		p_dma->p_virt = NULL;
 	}
 	kfree(p_mngr->ilt_shadow);
+	p_mngr->ilt_shadow = NULL;
 }
 
 static int qed_ilt_blk_alloc(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
index 51d89c86e60f..b650b6a5e871 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -30,6 +30,8 @@
 
 #define QCASPI_MAX_REGS 0x20
 
+#define QCASPI_RX_MAX_FRAMES 4
+
 static const u16 qcaspi_spi_regs[] = {
 	SPI_REG_BFR_SIZE,
 	SPI_REG_WRBUF_SPC_AVA,
@@ -266,31 +268,30 @@ qcaspi_get_ringparam(struct net_device *dev, struct ethtool_ringparam *ring)
 {
 	struct qcaspi *qca = netdev_priv(dev);
 
-	ring->rx_max_pending = 4;
+	ring->rx_max_pending = QCASPI_RX_MAX_FRAMES;
 	ring->tx_max_pending = TX_RING_MAX_LEN;
-	ring->rx_pending = 4;
+	ring->rx_pending = QCASPI_RX_MAX_FRAMES;
 	ring->tx_pending = qca->txr.count;
 }
 
 static int
 qcaspi_set_ringparam(struct net_device *dev, struct ethtool_ringparam *ring)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct qcaspi *qca = netdev_priv(dev);
 
-	if ((ring->rx_pending) ||
+	if (ring->rx_pending != QCASPI_RX_MAX_FRAMES ||
 	    (ring->rx_mini_pending) ||
 	    (ring->rx_jumbo_pending))
 		return -EINVAL;
 
-	if (netif_running(dev))
-		ops->ndo_stop(dev);
+	if (qca->spi_thread)
+		kthread_park(qca->spi_thread);
 
 	qca->txr.count = max_t(u32, ring->tx_pending, TX_RING_MIN_LEN);
 	qca->txr.count = min_t(u16, qca->txr.count, TX_RING_MAX_LEN);
 
-	if (netif_running(dev))
-		ops->ndo_open(dev);
+	if (qca->spi_thread)
+		kthread_unpark(qca->spi_thread);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 3e6095f0cb5f..c4a826176f3a 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -552,6 +552,18 @@ qcaspi_spi_thread(void *data)
 	netdev_info(qca->net_dev, "SPI thread created\n");
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_park()) {
+			netif_tx_disable(qca->net_dev);
+			netif_carrier_off(qca->net_dev);
+			qcaspi_flush_tx_ring(qca);
+			kthread_parkme();
+			if (qca->sync == QCASPI_SYNC_READY) {
+				netif_carrier_on(qca->net_dev);
+				netif_wake_queue(qca->net_dev);
+			}
+			continue;
+		}
+
 		if ((qca->intr_req == qca->intr_svc) &&
 		    !qca->txr.skb[qca->txr.head])
 			schedule();
@@ -580,11 +592,17 @@ qcaspi_spi_thread(void *data)
 			if (intr_cause & SPI_INT_CPU_ON) {
 				qcaspi_qca7k_sync(qca, QCASPI_EVENT_CPUON);
 
+				/* Frame decoding in progress */
+				if (qca->frm_handle.state != qca->frm_handle.init)
+					qca->net_dev->stats.rx_dropped++;
+
+				qcafrm_fsm_init_spi(&qca->frm_handle);
+				qca->stats.device_reset++;
+
 				/* not synced. */
 				if (qca->sync != QCASPI_SYNC_READY)
 					continue;
 
-				qca->stats.device_reset++;
 				netif_wake_queue(qca->net_dev);
 				netif_carrier_on(qca->net_dev);
 			}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 093a223fe408..a81df6806e00 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -360,7 +360,11 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
-	if (err != 0) {
+	if (err == -ENODEV) {
+		err = 0;
+		dev_info(dev, "MDIO bus is disabled\n");
+		goto bus_register_fail;
+	} else if (err) {
 		dev_err(dev, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
 	}
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 08f9530fd5b1..05c3e539cb0a 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -291,8 +291,10 @@ static int __team_options_register(struct team *team,
 	return 0;
 
 inst_rollback:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
 		__team_option_inst_del_option(team, dst_opts[i]);
+		list_del(&dst_opts[i]->list);
+	}
 
 	i = option_count;
 alloc_rollback:
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index aefa57e72695..f787b9a4f9a9 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1250,6 +1250,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x19d2, 0x0168, 4)},
 	{QMI_FIXED_INTF(0x19d2, 0x0176, 3)},
 	{QMI_FIXED_INTF(0x19d2, 0x0178, 3)},
+	{QMI_FIXED_INTF(0x19d2, 0x0189, 4)},    /* ZTE MF290 */
 	{QMI_FIXED_INTF(0x19d2, 0x0191, 4)},	/* ZTE EuFi890 */
 	{QMI_FIXED_INTF(0x19d2, 0x0199, 1)},	/* ZTE MF820S */
 	{QMI_FIXED_INTF(0x19d2, 0x0200, 1)},
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 72a289d73dfc..3d8844e7090a 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -510,15 +510,12 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					if (pci_is_root_bus(bus))
-						__pci_bus_size_bridges(dev->subordinate, &add_list);
+					__pci_bus_size_bridges(dev->subordinate,
+							       &add_list);
 				}
 			}
 		}
-		if (pci_is_root_bus(bus))
-			__pci_bus_assign_resources(bus, &add_list, NULL);
-		else
-			pci_assign_unassigned_bridge_resources(bus->self);
+		__pci_bus_assign_resources(bus, &add_list, NULL);
 	}
 
 	acpiphp_sanitize_bus(bus);
diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel_telemetry_core.c
index f378621b5fe9..31bbfb5d2463 100644
--- a/drivers/platform/x86/intel_telemetry_core.c
+++ b/drivers/platform/x86/intel_telemetry_core.c
@@ -110,7 +110,7 @@ static const struct telemetry_core_ops telm_defpltops = {
 /**
  * telemetry_update_events() - Update telemetry Configuration
  * @pss_evtconfig: PSS related config. No change if num_evts = 0.
- * @pss_evtconfig: IOSS related config. No change if num_evts = 0.
+ * @ioss_evtconfig: IOSS related config. No change if num_evts = 0.
  *
  * This API updates the IOSS & PSS Telemetry configuration. Old config
  * is overwritten. Call telemetry_reset_events when logging is over
@@ -184,7 +184,7 @@ EXPORT_SYMBOL_GPL(telemetry_reset_events);
 /**
  * telemetry_get_eventconfig() - Returns the pss and ioss events enabled
  * @pss_evtconfig: Pointer to PSS related configuration.
- * @pss_evtconfig: Pointer to IOSS related configuration.
+ * @ioss_evtconfig: Pointer to IOSS related configuration.
  * @pss_len:	   Number of u32 elements allocated for pss_evtconfig array
  * @ioss_len:	   Number of u32 elements allocated for ioss_evtconfig array
  *
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fb2f255c48e8..8875fac9f958 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3181,6 +3181,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
 			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
 
+	/* avoid unnecessary preallocation that may trigger assertions */
+	if (start + size > EXT_MAX_BLOCKS)
+		size = EXT_MAX_BLOCKS - start;
+
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
 		size -= ar->lleft + 1 - start;
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 9cc457597ddf..1a688e5b8b0b 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -47,7 +47,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
 {
-	return !atomic_read(&lock.val);
+	return !lock.val.counter;
 }
 
 /**
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 4b081e4911c8..62509a19ea08 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -114,7 +114,7 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
  * same context as task->real_cred.
  */
 struct cred {
-	atomic_t	usage;
+	atomic_long_t	usage;
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	atomic_t	subscribers;	/* number of processes subscribed */
 	void		*put_addr;
@@ -231,7 +231,7 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
+	atomic_long_inc(&cred->usage);
 	return cred;
 }
 
@@ -275,7 +275,7 @@ static inline void put_cred(const struct cred *_cred)
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		if (atomic_long_dec_and_test(&(cred)->usage))
 			__put_cred(cred);
 	}
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index a9f0f8b21d8c..8c58f0f63af2 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -101,17 +101,17 @@ static void put_cred_rcu(struct rcu_head *rcu)
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	if (cred->magic != CRED_MAGIC_DEAD ||
-	    atomic_read(&cred->usage) != 0 ||
+	    atomic_long_read(&cred->usage) != 0 ||
 	    read_cred_subscribers(cred) != 0)
 		panic("CRED: put_cred_rcu() sees %p with"
-		      " mag %x, put %p, usage %d, subscr %d\n",
+		      " mag %x, put %p, usage %ld, subscr %d\n",
 		      cred, cred->magic, cred->put_addr,
-		      atomic_read(&cred->usage),
+		      atomic_long_read(&cred->usage),
 		      read_cred_subscribers(cred));
 #else
-	if (atomic_read(&cred->usage) != 0)
-		panic("CRED: put_cred_rcu() sees %p with usage %d\n",
-		      cred, atomic_read(&cred->usage));
+	if (atomic_long_read(&cred->usage) != 0)
+		panic("CRED: put_cred_rcu() sees %p with usage %ld\n",
+		      cred, atomic_long_read(&cred->usage));
 #endif
 
 	security_cred_free(cred);
@@ -134,11 +134,11 @@ static void put_cred_rcu(struct rcu_head *rcu)
  */
 void __put_cred(struct cred *cred)
 {
-	kdebug("__put_cred(%p{%d,%d})", cred,
-	       atomic_read(&cred->usage),
+	kdebug("__put_cred(%p{%ld,%d})", cred,
+	       atomic_long_read(&cred->usage),
 	       read_cred_subscribers(cred));
 
-	BUG_ON(atomic_read(&cred->usage) != 0);
+	BUG_ON(atomic_long_read(&cred->usage) != 0);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(cred) != 0);
 	cred->magic = CRED_MAGIC_DEAD;
@@ -161,8 +161,8 @@ void exit_creds(struct task_struct *tsk)
 {
 	struct cred *cred;
 
-	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	kdebug("exit_creds(%u,%p,%p,{%ld,%d})", tsk->pid, tsk->real_cred, tsk->cred,
+	       atomic_long_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	cred = (struct cred *) tsk->real_cred;
@@ -197,7 +197,7 @@ const struct cred *get_task_cred(struct task_struct *task)
 	do {
 		cred = __task_cred((task));
 		BUG_ON(!cred);
-	} while (!atomic_inc_not_zero(&((struct cred *)cred)->usage));
+	} while (!atomic_long_inc_not_zero(&((struct cred *)cred)->usage));
 
 	rcu_read_unlock();
 	return cred;
@@ -215,7 +215,7 @@ struct cred *cred_alloc_blank(void)
 	if (!new)
 		return NULL;
 
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	new->magic = CRED_MAGIC;
 #endif
@@ -262,7 +262,7 @@ struct cred *prepare_creds(void)
 	memcpy(new, old, sizeof(struct cred));
 
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_group_info(new->group_info);
 	get_uid(new->user);
@@ -338,8 +338,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		p->real_cred = get_cred(p->cred);
 		get_cred(p->cred);
 		alter_cred_subscribers(p->cred, 2);
-		kdebug("share_creds(%p{%d,%d})",
-		       p->cred, atomic_read(&p->cred->usage),
+		kdebug("share_creds(%p{%ld,%d})",
+		       p->cred, atomic_long_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
 		atomic_inc(&p->cred->user->processes);
 		return 0;
@@ -429,8 +429,8 @@ int commit_creds(struct cred *new)
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
 
-	kdebug("commit_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("commit_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	BUG_ON(task->cred != old);
@@ -439,7 +439,7 @@ int commit_creds(struct cred *new)
 	validate_creds(old);
 	validate_creds(new);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(atomic_long_read(&new->usage) < 1);
 
 	get_cred(new); /* we will require a ref for the subj creds too */
 
@@ -512,14 +512,14 @@ EXPORT_SYMBOL(commit_creds);
  */
 void abort_creds(struct cred *new)
 {
-	kdebug("abort_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("abort_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(new) != 0);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(atomic_long_read(&new->usage) < 1);
 	put_cred(new);
 }
 EXPORT_SYMBOL(abort_creds);
@@ -535,8 +535,8 @@ const struct cred *override_creds(const struct cred *new)
 {
 	const struct cred *old = current->cred;
 
-	kdebug("override_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("override_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	validate_creds(old);
@@ -558,8 +558,8 @@ const struct cred *override_creds(const struct cred *new)
 	rcu_assign_pointer(current->cred, new);
 	alter_cred_subscribers(old, -1);
 
-	kdebug("override_creds() = %p{%d,%d}", old,
-	       atomic_read(&old->usage),
+	kdebug("override_creds() = %p{%ld,%d}", old,
+	       atomic_long_read(&old->usage),
 	       read_cred_subscribers(old));
 	return old;
 }
@@ -576,8 +576,8 @@ void revert_creds(const struct cred *old)
 {
 	const struct cred *override = current->cred;
 
-	kdebug("revert_creds(%p{%d,%d})", old,
-	       atomic_read(&old->usage),
+	kdebug("revert_creds(%p{%ld,%d})", old,
+	       atomic_long_read(&old->usage),
 	       read_cred_subscribers(old));
 
 	validate_creds(old);
@@ -637,7 +637,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 
 	*new = *old;
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_uid(new->user);
 	get_user_ns(new->user_ns);
@@ -760,8 +760,8 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
 	       cred == tsk->cred ? "[eff]" : "");
 	printk(KERN_ERR "CRED: ->magic=%x, put_addr=%p\n",
 	       cred->magic, cred->put_addr);
-	printk(KERN_ERR "CRED: ->usage=%d, subscr=%d\n",
-	       atomic_read(&cred->usage),
+	printk(KERN_ERR "CRED: ->usage=%ld, subscr=%d\n",
+	       atomic_long_read(&cred->usage),
 	       read_cred_subscribers(cred));
 	printk(KERN_ERR "CRED: ->*uid = { %d,%d,%d,%d }\n",
 		from_kuid_munged(&init_user_ns, cred->uid),
@@ -833,9 +833,9 @@ EXPORT_SYMBOL(__validate_process_creds);
  */
 void validate_creds_for_do_exit(struct task_struct *tsk)
 {
-	kdebug("validate_creds_for_do_exit(%p,%p{%d,%d})",
+	kdebug("validate_creds_for_do_exit(%p,%p{%ld,%d})",
 	       tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       atomic_long_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	__validate_process_creds(tsk, __FILE__, __LINE__);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4182e265176d..1f215aa8f30d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1834,6 +1834,16 @@ static bool perf_event_validate_size(struct perf_event *event)
 				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	/*
+	 * When creating a new group leader, group_leader->ctx is initialized
+	 * after the size has been validated, but we cannot safely use
+	 * for_each_sibling_event() until group_leader->ctx is set. A new group
+	 * leader cannot have any siblings yet, so we can safely skip checking
+	 * the non-existent siblings.
+	 */
+	if (event == group_leader)
+		return true;
+
 	for_each_sibling_event(sibling, group_leader) {
 		if (__perf_event_read_size(sibling->attr.read_format,
 					   group_leader->nr_siblings + 1) > 16*1024)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 320aa60664dc..b627bc820540 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1344,6 +1344,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
+	free_page((unsigned long)cpu_buffer->free_page);
+
 	kfree(cpu_buffer);
 }
 
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 20ec8e7f9423..c4f1bfe6e040 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1808,15 +1808,14 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case TIOCINQ: {
-		/*
-		 * These two are safe on a single CPU system as only
-		 * user tasks fiddle here
-		 */
-		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
+		struct sk_buff *skb;
 		long amount = 0;
 
+		spin_lock_irq(&sk->sk_receive_queue.lock);
+		skb = skb_peek(&sk->sk_receive_queue);
 		if (skb)
 			amount = skb->len - sizeof(struct ddpehdr);
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		rc = put_user(amount, (int __user *)argp);
 		break;
 	}
diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 2ff0e5e470e3..38f7f164e484 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -71,14 +71,17 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 	case SIOCINQ:
 	{
 		struct sk_buff *skb;
+		int amount;
 
 		if (sock->state != SS_CONNECTED) {
 			error = -EINVAL;
 			goto done;
 		}
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		skb = skb_peek(&sk->sk_receive_queue);
-		error = put_user(skb ? skb->len : 0,
-				 (int __user *)argp) ? -EFAULT : 0;
+		amount = skb ? skb->len : 0;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
+		error = put_user(amount, (int __user *)argp) ? -EFAULT : 0;
 		goto done;
 	}
 	case SIOCGSTAMP: /* borrowed from IP */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a0875dc60e08..670804d4c169 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2890,7 +2890,13 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (skb_still_in_host_queue(sk, skb))
 		return -EBUSY;
 
+start:
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
+		if (unlikely(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
+			TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
+			TCP_SKB_CB(skb)->seq++;
+			goto start;
+		}
 		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 4edd127bb892..d32fb40650a7 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1308,9 +1308,11 @@ static int rose_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case TIOCINQ: {
 		struct sk_buff *skb;
 		long amount = 0L;
-		/* These two are safe on a single CPU system as only user tasks fiddle here */
+
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		if ((skb = skb_peek(&sk->sk_receive_queue)) != NULL)
 			amount = skb->len;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		return put_user(amount, (unsigned int __user *) argp);
 	}
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 449b5261e661..187d0f7253a6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -348,7 +348,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 7434e9ea926e..12acc70e5a7a 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
 				     CMS_NOSMIMECAP | use_keyid |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
-		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
+		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
 		    "CMS_final");
 
 #else
@@ -341,10 +341,10 @@ int main(int argc, char **argv)
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
 #ifndef USE_PKCS7
-			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
+			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) != 1,
 			    "%s", sig_file_name);
 #else
-			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
+			ERR(i2d_PKCS7_bio(b, pkcs7) != 1,
 			    "%s", sig_file_name);
 #endif
 			BIO_free(b);
@@ -374,9 +374,9 @@ int main(int argc, char **argv)
 
 	if (!raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) != 1, "%s", dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) != 1, "%s", dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -396,7 +396,7 @@ int main(int argc, char **argv)
 	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
 	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) != 1, "%s", dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)

