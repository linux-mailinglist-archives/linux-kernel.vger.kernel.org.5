Return-Path: <linux-kernel+bounces-7251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576981A3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4461F26647
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD747A42;
	Wed, 20 Dec 2023 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IjjB69FK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15441763;
	Wed, 20 Dec 2023 16:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8B4C433C8;
	Wed, 20 Dec 2023 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088495;
	bh=uE/JHCYCsyOLvcvUKHS/auk54BxsbRSjam5MZgUuT9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjjB69FKGBzquBy1ZoM41QAjPNttrz0N73fZluCaSdxsIvaPnJJjTdfIESP/wuj2a
	 NahpzaIkNRSANs16TnvWlJzuZpKFZQP+SHcM2Py24Rtu09gVH5V9kznX02zrLeepdP
	 lJwCUGIxhE0DXV6g5dKRNy8oQa30B6nBFnkvm3T4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.205
Date: Wed, 20 Dec 2023 17:08:07 +0100
Message-ID: <2023122006-storable-antacid-7dca@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023122006-enroll-poison-3188@gregkh>
References: <2023122006-enroll-poison-3188@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 87886018d774..5ba86be42e7c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 204
+SUBLEVEL = 205
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4eedfd784cf6..7756a365d4c4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -744,6 +744,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
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
index f9fd5f743eba..0bc39ff53233 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -36,6 +36,9 @@ _GLOBAL(ftrace_regs_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0,LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1,-SWITCH_FRAME_SIZE(r1)
 
@@ -52,7 +55,7 @@ _GLOBAL(ftrace_regs_caller)
 	SAVE_10GPRS(22, r1)
 
 	/* Save previous stack pointer (r1) */
-	addi	r8, r1, SWITCH_FRAME_SIZE
+	addi	r8, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	std	r8, GPR1(r1)
 
 	/* Load special regs for save below */
@@ -65,6 +68,8 @@ _GLOBAL(ftrace_regs_caller)
 	mflr	r7
 	/* Save it as pt_regs->nip */
 	std     r7, _NIP(r1)
+	/* Also save it in B's stackframe header for proper unwind */
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 	/* Save the read LR in pt_regs->link */
 	std     r0, _LINK(r1)
 
@@ -121,7 +126,7 @@ ftrace_regs_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi r1, r1, SWITCH_FRAME_SIZE
+	addi r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 #ifdef CONFIG_LIVEPATCH
         /* Based on the cmpd above, if the NIP was altered handle livepatch */
@@ -145,7 +150,7 @@ ftrace_no_trace:
 	mflr	r3
 	mtctr	r3
 	REST_GPR(3, r1)
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	mtlr	r0
 	bctr
 
@@ -153,6 +158,9 @@ _GLOBAL(ftrace_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0, LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1, -SWITCH_FRAME_SIZE(r1)
 
@@ -166,6 +174,7 @@ _GLOBAL(ftrace_caller)
 	/* Get the _mcount() call site out of LR */
 	mflr	r7
 	std     r7, _NIP(r1)
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, 24(r1)
@@ -200,7 +209,7 @@ ftrace_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 	/* Reload original LR */
 	ld	r0, LRSAVE(r1)
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c526fdd0a7b9..4bf514a7bd82 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1409,6 +1409,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1436,6 +1437,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 94fbc3abe60e..d3c30a28c410 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -449,9 +449,9 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	struct sk_buff *skb;
 	unsigned int len;
 
-	spin_lock(&card->cli_queue_lock);
+	spin_lock_bh(&card->cli_queue_lock);
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
-	spin_unlock(&card->cli_queue_lock);
+	spin_unlock_bh(&card->cli_queue_lock);
 	if(skb == NULL)
 		return sprintf(buf, "No data.\n");
 
@@ -956,14 +956,14 @@ static void pclose(struct atm_vcc *vcc)
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
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index cc3cb5b63d44..1eaf513166a1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -582,6 +582,7 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 {
 	struct mtk_crtc_state *state = to_mtk_crtc_state(crtc->state);
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	unsigned long flags;
 
 	if (mtk_crtc->event && state->base.event)
 		DRM_ERROR("new event while there is still a pending event\n");
@@ -589,7 +590,11 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 	if (state->base.event) {
 		state->base.event->pipe = drm_crtc_index(crtc);
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
 		mtk_crtc->event = state->base.event;
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+
 		state->base.event = NULL;
 	}
 }
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 6865cab33cf8..b46fb92d28e5 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -336,7 +336,7 @@ static int asus_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
-static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size)
+static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
 	unsigned char *dmabuf;
 	int ret;
@@ -355,7 +355,7 @@ static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size
 
 static int asus_kbd_init(struct hid_device *hdev)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
 		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	int ret;
 
@@ -369,7 +369,7 @@ static int asus_kbd_init(struct hid_device *hdev)
 static int asus_kbd_get_functions(struct hid_device *hdev,
 				  unsigned char *kbd_func)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
 	u8 *readbuf;
 	int ret;
 
@@ -901,6 +901,24 @@ static int asus_start_multitouch(struct hid_device *hdev)
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
@@ -1177,6 +1195,7 @@ static struct hid_driver asus_driver = {
 	.input_configured       = asus_input_configured,
 #ifdef CONFIG_PM
 	.reset_resume           = asus_reset_resume,
+	.resume					= asus_resume,
 #endif
 	.event			= asus_event,
 	.raw_event		= asus_raw_event
diff --git a/drivers/hid/hid-glorious.c b/drivers/hid/hid-glorious.c
index 558eb08c19ef..281b3a7187ce 100644
--- a/drivers/hid/hid-glorious.c
+++ b/drivers/hid/hid-glorious.c
@@ -21,6 +21,10 @@ MODULE_DESCRIPTION("HID driver for Glorious PC Gaming Race mice");
  * Glorious Model O and O- specify the const flag in the consumer input
  * report descriptor, which leads to inputs being ignored. Fix this
  * by patching the descriptor.
+ *
+ * Glorious Model I incorrectly specifes the Usage Minimum for its
+ * keyboard HID report, causing keycodes to be misinterpreted.
+ * Fix this by setting Usage Minimum to 0 in that report.
  */
 static __u8 *glorious_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
@@ -32,6 +36,10 @@ static __u8 *glorious_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		rdesc[85] = rdesc[113] = rdesc[141] = \
 			HID_MAIN_ITEM_VARIABLE | HID_MAIN_ITEM_RELATIVE;
 	}
+	if (*rsize == 156 && rdesc[41] == 1) {
+		hid_info(hdev, "patching Glorious Model I keyboard report descriptor\n");
+		rdesc[41] = 0;
+	}
 	return rdesc;
 }
 
@@ -44,6 +52,8 @@ static void glorious_update_name(struct hid_device *hdev)
 		model = "Model O"; break;
 	case USB_DEVICE_ID_GLORIOUS_MODEL_D:
 		model = "Model D"; break;
+	case USB_DEVICE_ID_GLORIOUS_MODEL_I:
+		model = "Model I"; break;
 	}
 
 	snprintf(hdev->name, sizeof(hdev->name), "%s %s", "Glorious", model);
@@ -66,10 +76,12 @@ static int glorious_probe(struct hid_device *hdev,
 }
 
 static const struct hid_device_id glorious_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLORIOUS,
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINOWEALTH,
 		USB_DEVICE_ID_GLORIOUS_MODEL_O) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLORIOUS,
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINOWEALTH,
 		USB_DEVICE_ID_GLORIOUS_MODEL_D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LAVIEW,
+		USB_DEVICE_ID_GLORIOUS_MODEL_I) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, glorious_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7c688d7f8ccf..6273ab615af8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -471,10 +471,6 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
-#define USB_VENDOR_ID_GLORIOUS  0x258a
-#define USB_DEVICE_ID_GLORIOUS_MODEL_D 0x0033
-#define USB_DEVICE_ID_GLORIOUS_MODEL_O 0x0036
-
 #define I2C_VENDOR_ID_GOODIX		0x27c6
 #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
 
@@ -697,6 +693,9 @@
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
 
+#define USB_VENDOR_ID_LAVIEW		0x22D4
+#define USB_DEVICE_ID_GLORIOUS_MODEL_I	0x1503
+
 #define USB_VENDOR_ID_LCPOWER		0x1241
 #define USB_DEVICE_ID_LCPOWER_LC1000	0xf767
 
@@ -1068,6 +1067,10 @@
 #define USB_VENDOR_ID_SIGMATEL		0x066F
 #define USB_DEVICE_ID_SIGMATEL_STMP3780	0x3780
 
+#define USB_VENDOR_ID_SINOWEALTH  0x258a
+#define USB_DEVICE_ID_GLORIOUS_MODEL_D 0x0033
+#define USB_DEVICE_ID_GLORIOUS_MODEL_O 0x0036
+
 #define USB_VENDOR_ID_SIS_TOUCH		0x0457
 #define USB_DEVICE_ID_SIS9200_TOUCH	0x9200
 #define USB_DEVICE_ID_SIS817_TOUCH	0x0817
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 71f7b0d539df..249af8d26fe7 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -489,7 +489,8 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 		 * so set middlebutton_state to 3
 		 * to never apply workaround anymore
 		 */
-		if (cptkbd_data->middlebutton_state == 1 &&
+		if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD &&
+				cptkbd_data->middlebutton_state == 1 &&
 				usage->type == EV_REL &&
 				(usage->code == REL_X || usage->code == REL_Y)) {
 			cptkbd_data->middlebutton_state = 3;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 84b12599eaf6..7d43d62df240 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1962,6 +1962,11 @@ static const struct hid_device_id mt_devices[] = {
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
index 787349f2de01..1b3a83fa7616 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -33,6 +33,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AMI, USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ANSI), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM), HID_QUIRK_NOGET },
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index e8bf4f752e8b..5804a8e6e215 100644
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
index 3d6a7fbcbb15..1a1a9554474a 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -974,6 +974,9 @@ static struct btree *mca_alloc(struct cache_set *c, struct btree_op *op,
  *
  * The btree node will have either a read or a write lock held, depending on
  * level and op->lock.
+ *
+ * Note: Only error code or btree pointer will be returned, it is unncessary
+ *       for callers to check NULL pointer.
  */
 struct btree *bch_btree_node_get(struct cache_set *c, struct btree_op *op,
 				 struct bkey *k, int level, bool write,
@@ -1085,6 +1088,10 @@ static void btree_node_free(struct btree *b)
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
index e8c8077667f9..04ddaa4bbd77 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -917,6 +917,8 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 
 	if (!d->stripe_size)
 		d->stripe_size = 1 << 31;
+	else if (d->stripe_size < BCH_MIN_STRIPE_SZ)
+		d->stripe_size = roundup(BCH_MIN_STRIPE_SZ, d->stripe_size);
 
 	n = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
 	if (!n || n > max_stripes) {
@@ -2041,7 +2043,7 @@ static int run_cache_set(struct cache_set *c)
 		c->root = bch_btree_node_get(c, NULL, k,
 					     j->btree_level,
 					     true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		list_del_init(&c->root->list);
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 94e899ce3855..8e3f5f004c39 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -857,7 +857,7 @@ static int bch_dirty_init_thread(void *arg)
 	int cur_idx, prev_idx, skip_nr;
 
 	k = p = NULL;
-	cur_idx = prev_idx = 0;
+	prev_idx = 0;
 
 	bch_btree_iter_init(&c->root->keys, &iter, NULL);
 	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 032ab9f20438..3af9dbf245f2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -316,9 +316,6 @@ static int ena_com_create_and_store_tx_meta_desc(struct ena_com_io_sq *io_sq,
 	 * compare it to the stored version, just create the meta
 	 */
 	if (io_sq->disable_meta_caching) {
-		if (unlikely(!ena_tx_ctx->meta_valid))
-			return -EINVAL;
-
 		*have_meta = true;
 		return ena_com_create_meta(io_sq, ena_meta);
 	}
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 1722d4091ea3..e13ae04d2f0f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -77,6 +77,8 @@ static void ena_unmap_tx_buff(struct ena_ring *tx_ring,
 			      struct ena_tx_buffer *tx_info);
 static int ena_create_io_tx_queues_in_range(struct ena_adapter *adapter,
 					    int first_index, int count);
+static void ena_free_all_io_tx_resources_in_range(struct ena_adapter *adapter,
+						  int first_index, int count);
 
 static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
@@ -388,23 +390,22 @@ static void ena_init_all_xdp_queues(struct ena_adapter *adapter)
 
 static int ena_setup_and_create_all_xdp_queues(struct ena_adapter *adapter)
 {
+	u32 xdp_first_ring = adapter->xdp_first_ring;
+	u32 xdp_num_queues = adapter->xdp_num_queues;
 	int rc = 0;
 
-	rc = ena_setup_tx_resources_in_range(adapter, adapter->xdp_first_ring,
-					     adapter->xdp_num_queues);
+	rc = ena_setup_tx_resources_in_range(adapter, xdp_first_ring, xdp_num_queues);
 	if (rc)
 		goto setup_err;
 
-	rc = ena_create_io_tx_queues_in_range(adapter,
-					      adapter->xdp_first_ring,
-					      adapter->xdp_num_queues);
+	rc = ena_create_io_tx_queues_in_range(adapter, xdp_first_ring, xdp_num_queues);
 	if (rc)
 		goto create_err;
 
 	return 0;
 
 create_err:
-	ena_free_all_io_tx_resources(adapter);
+	ena_free_all_io_tx_resources_in_range(adapter, xdp_first_ring, xdp_num_queues);
 setup_err:
 	return rc;
 }
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e9c6f1fa0b1a..98e8997f8036 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -577,11 +577,14 @@ void aq_ring_free(struct aq_ring_s *self)
 		return;
 
 	kfree(self->buff_ring);
+	self->buff_ring = NULL;
 
-	if (self->dx_ring)
+	if (self->dx_ring) {
 		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
 				  self->size * self->dx_size, self->dx_ring,
 				  self->dx_ring_pa);
+		self->dx_ring = NULL;
+	}
 }
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 4f669e7c7558..4509a29ff73f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -1924,8 +1924,7 @@ u16 bnx2x_select_queue(struct net_device *dev, struct sk_buff *skb,
 
 		/* Skip VLAN tag if present */
 		if (ether_type == ETH_P_8021Q) {
-			struct vlan_ethhdr *vhdr =
-				(struct vlan_ethhdr *)skb->data;
+			struct vlan_ethhdr *vhdr = skb_vlan_eth_hdr(skb);
 
 			ether_type = ntohs(vhdr->h_vlan_encapsulated_proto);
 		}
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 52b399aa3213..edd4dd73b3e3 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1125,7 +1125,7 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 						  struct be_wrb_params
 						  *wrb_params)
 {
-	struct vlan_ethhdr *veh = (struct vlan_ethhdr *)skb->data;
+	struct vlan_ethhdr *veh = skb_vlan_eth_hdr(skb);
 	unsigned int eth_hdr_len;
 	struct iphdr *ip;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e18b3b72fc0d..4ce913559c91 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3266,31 +3266,26 @@ static int fec_set_features(struct net_device *netdev,
 	return 0;
 }
 
-static u16 fec_enet_get_raw_vlan_tci(struct sk_buff *skb)
-{
-	struct vlan_ethhdr *vhdr;
-	unsigned short vlan_TCI = 0;
-
-	if (skb->protocol == htons(ETH_P_ALL)) {
-		vhdr = (struct vlan_ethhdr *)(skb->data);
-		vlan_TCI = ntohs(vhdr->h_vlan_TCI);
-	}
-
-	return vlan_TCI;
-}
-
 static u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
 				 struct net_device *sb_dev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u16 vlan_tag;
+	u16 vlan_tag = 0;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_AVB))
 		return netdev_pick_tx(ndev, skb, NULL);
 
-	vlan_tag = fec_enet_get_raw_vlan_tci(skb);
-	if (!vlan_tag)
+	/* VLAN is present in the payload.*/
+	if (eth_type_vlan(skb->protocol)) {
+		struct vlan_ethhdr *vhdr = skb_vlan_eth_hdr(skb);
+
+		vlan_tag = ntohs(vhdr->h_vlan_TCI);
+	/*  VLAN is present in the skb but not yet pushed in the payload.*/
+	} else if (skb_vlan_tag_present(skb)) {
+		vlan_tag = skb->vlan_tci;
+	} else {
 		return vlan_tag;
+	}
 
 	return fec_enet_vlan_pri_to_queue[vlan_tag >> 13];
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4df5e91e86ce..a4ab3e7efa5e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1002,7 +1002,7 @@ static int hns3_handle_vtags(struct hns3_enet_ring *tx_ring,
 	if (unlikely(rc < 0))
 		return rc;
 
-	vhdr = (struct vlan_ethhdr *)skb->data;
+	vhdr = skb_vlan_eth_hdr(skb);
 	vhdr->h_vlan_TCI |= cpu_to_be16((skb->priority << VLAN_PRIO_SHIFT)
 					 & VLAN_PRIO_MASK);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 88d8f17cefd8..57667ccc28f5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2879,7 +2879,7 @@ static inline int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
 			rc = skb_cow_head(skb, 0);
 			if (rc < 0)
 				return rc;
-			vhdr = (struct vlan_ethhdr *)skb->data;
+			vhdr = skb_vlan_eth_hdr(skb);
 			vhdr->h_vlan_TCI = htons(tx_flags >>
 						 I40E_TX_FLAGS_VLAN_SHIFT);
 		} else {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2b100b7b325a..5829d81f2cb1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8707,7 +8707,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 
 			if (skb_cow_head(skb, 0))
 				goto out_drop;
-			vhdr = (struct vlan_ethhdr *)skb->data;
+			vhdr = skb_vlan_eth_hdr(skb);
 			vhdr->h_vlan_TCI = htons(tx_flags >>
 						 IXGBE_TX_FLAGS_VLAN_SHIFT);
 		} else {
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index e2046b6d65a3..2c5460083564 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -1861,7 +1861,7 @@ netxen_tso_check(struct net_device *netdev,
 
 	if (protocol == cpu_to_be16(ETH_P_8021Q)) {
 
-		vh = (struct vlan_ethhdr *)skb->data;
+		vh = skb_vlan_eth_hdr(skb);
 		protocol = vh->h_vlan_encapsulated_proto;
 		flags = FLAGS_VLAN_TAGGED;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 0a22f8ce9a2c..1c3737921b6c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -933,6 +933,7 @@ static void qed_ilt_shadow_free(struct qed_hwfn *p_hwfn)
 		p_dma->virt_addr = NULL;
 	}
 	kfree(p_mngr->ilt_shadow);
+	p_mngr->ilt_shadow = NULL;
 }
 
 static int qed_ilt_blk_alloc(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index bdf15d2a6431..7260e57d79f2 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -317,7 +317,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 
 	if (adapter->flags & QLCNIC_VLAN_FILTERING) {
 		if (protocol == ETH_P_8021Q) {
-			vh = (struct vlan_ethhdr *)skb->data;
+			vh = skb_vlan_eth_hdr(skb);
 			vlan_id = ntohs(vh->h_vlan_TCI);
 		} else if (skb_vlan_tag_present(skb)) {
 			vlan_id = skb_vlan_tag_get(skb);
@@ -467,7 +467,7 @@ static int qlcnic_tx_pkt(struct qlcnic_adapter *adapter,
 	u32 producer = tx_ring->producer;
 
 	if (protocol == ETH_P_8021Q) {
-		vh = (struct vlan_ethhdr *)skb->data;
+		vh = skb_vlan_eth_hdr(skb);
 		flags = QLCNIC_FLAGS_VLAN_TAGGED;
 		vlan_tci = ntohs(vh->h_vlan_TCI);
 		protocol = ntohs(vh->h_vlan_encapsulated_proto);
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
index 702aa217a27a..66229b300c5a 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -30,6 +30,8 @@
 
 #define QCASPI_MAX_REGS 0x20
 
+#define QCASPI_RX_MAX_FRAMES 4
+
 static const u16 qcaspi_spi_regs[] = {
 	SPI_REG_BFR_SIZE,
 	SPI_REG_WRBUF_SPC_AVA,
@@ -249,31 +251,30 @@ qcaspi_get_ringparam(struct net_device *dev, struct ethtool_ringparam *ring)
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
index 44fa959ebcaa..ffa1846f5b4c 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -573,6 +573,18 @@ qcaspi_spi_thread(void *data)
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
@@ -601,11 +613,17 @@ qcaspi_spi_thread(void *data)
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
diff --git a/drivers/net/ethernet/sfc/tx_tso.c b/drivers/net/ethernet/sfc/tx_tso.c
index 898e5c61d908..d381d8164f07 100644
--- a/drivers/net/ethernet/sfc/tx_tso.c
+++ b/drivers/net/ethernet/sfc/tx_tso.c
@@ -147,7 +147,7 @@ static __be16 efx_tso_check_protocol(struct sk_buff *skb)
 	EFX_WARN_ON_ONCE_PARANOID(((struct ethhdr *)skb->data)->h_proto !=
 				  protocol);
 	if (protocol == htons(ETH_P_8021Q)) {
-		struct vlan_ethhdr *veh = (struct vlan_ethhdr *)skb->data;
+		struct vlan_ethhdr *veh = skb_vlan_eth_hdr(skb);
 
 		protocol = veh->h_vlan_encapsulated_proto;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59a07a01e80c..8416a186cd7f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3660,13 +3660,10 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 {
-	struct vlan_ethhdr *veth;
-	__be16 vlan_proto;
+	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
+	__be16 vlan_proto = veth->h_vlan_proto;
 	u16 vlanid;
 
-	veth = (struct vlan_ethhdr *)skb->data;
-	vlan_proto = veth->h_vlan_proto;
-
 	if ((vlan_proto == htons(ETH_P_8021Q) &&
 	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
 	    (vlan_proto == htons(ETH_P_8021AD) &&
@@ -5190,9 +5187,9 @@ int stmmac_dvr_probe(struct device *device,
 		/* MDIO bus Registration */
 		ret = stmmac_mdio_register(ndev);
 		if (ret < 0) {
-			dev_err(priv->device,
-				"%s: MDIO bus (id: %d) registration failed",
-				__func__, priv->plat->bus_id);
+			dev_err_probe(priv->device, ret,
+				      "%s: MDIO bus (id: %d) registration failed\n",
+				      __func__, priv->plat->bus_id);
 			goto error_mdio_register;
 		}
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 7c1a14b256da..d9b76e1e0949 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -459,8 +459,12 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
-	if (err != 0) {
-		dev_err(dev, "Cannot register the MDIO bus\n");
+	if (err == -ENODEV) {
+		err = 0;
+		dev_info(dev, "MDIO bus is disabled\n");
+		goto bus_register_fail;
+	} else if (err) {
+		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
 	}
 
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 97a77dabed64..49d7030ddc1b 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -284,8 +284,10 @@ static int __team_options_register(struct team *team,
 	return 0;
 
 inst_rollback:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
 		__team_option_inst_del_option(team, dst_opts[i]);
+		list_del(&dst_opts[i]->list);
+	}
 
 	i = option_count;
 alloc_rollback:
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index c9c409518174..4ea02116be18 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1079,17 +1079,17 @@ static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	u16 pkt_count = 0;
 	u64 desc_hdr = 0;
 	u16 vlan_tag = 0;
-	u32 skb_len = 0;
+	u32 skb_len;
 
 	if (!skb)
 		goto err;
 
-	if (skb->len == 0)
+	skb_len = skb->len;
+	if (skb_len < sizeof(desc_hdr))
 		goto err;
 
-	skb_len = skb->len;
 	/* RX Descriptor Header */
-	skb_trim(skb, skb->len - sizeof(desc_hdr));
+	skb_trim(skb, skb_len - sizeof(desc_hdr));
 	desc_hdr = le64_to_cpup((u64 *)skb_tail_pointer(skb));
 
 	/* Check these packets */
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 5cf7f389bf4e..3d342908f57a 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1225,6 +1225,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x19d2, 0x0168, 4)},
 	{QMI_FIXED_INTF(0x19d2, 0x0176, 3)},
 	{QMI_FIXED_INTF(0x19d2, 0x0178, 3)},
+	{QMI_FIXED_INTF(0x19d2, 0x0189, 4)},    /* ZTE MF290 */
 	{QMI_FIXED_INTF(0x19d2, 0x0191, 4)},	/* ZTE EuFi890 */
 	{QMI_FIXED_INTF(0x19d2, 0x0199, 1)},	/* ZTE MF820S */
 	{QMI_FIXED_INTF(0x19d2, 0x0200, 1)},
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index e73e18a73833..8b40b45590a0 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -65,13 +65,49 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, system_bus_quirk);
 
+/*
+ * Some Loongson PCIe ports have hardware limitations on their Maximum Read
+ * Request Size. They can't handle anything larger than this.  Sane
+ * firmware will set proper MRRS at boot, so we only need no_inc_mrrs for
+ * bridges. However, some MIPS Loongson firmware doesn't set MRRS properly,
+ * so we have to enforce maximum safe MRRS, which is 256 bytes.
+ */
+#ifdef CONFIG_MIPS
+static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
+{
+	struct pci_bus *bus = pdev->bus;
+	struct pci_dev *bridge;
+	static const struct pci_device_id bridge_devids[] = {
+		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
+		{ 0, },
+	};
+
+	/* look for the matching bridge */
+	while (!pci_is_root_bus(bus)) {
+		bridge = bus->self;
+		bus = bus->parent;
+
+		if (pci_match_id(bridge_devids, bridge)) {
+			if (pcie_get_readrq(pdev) > 256) {
+				pci_info(pdev, "limiting MRRS to 256\n");
+				pcie_set_readrq(pdev, 256);
+			}
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_set_min_mrrs_quirk);
+#endif
+
 static void loongson_mrrs_quirk(struct pci_dev *pdev)
 {
-	/*
-	 * Some Loongson PCIe ports have h/w limitations of maximum read
-	 * request size. They can't handle anything larger than this. So
-	 * force this limit on any devices attached under these ports.
-	 */
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
 
 	bridge->no_inc_mrrs = 1;
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 0a37967b0a93..f031302ad401 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -503,15 +503,12 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
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
index fdf55b5d6948..e4be40f73eeb 100644
--- a/drivers/platform/x86/intel_telemetry_core.c
+++ b/drivers/platform/x86/intel_telemetry_core.c
@@ -102,7 +102,7 @@ static const struct telemetry_core_ops telm_defpltops = {
 /**
  * telemetry_update_events() - Update telemetry Configuration
  * @pss_evtconfig: PSS related config. No change if num_evts = 0.
- * @pss_evtconfig: IOSS related config. No change if num_evts = 0.
+ * @ioss_evtconfig: IOSS related config. No change if num_evts = 0.
  *
  * This API updates the IOSS & PSS Telemetry configuration. Old config
  * is overwritten. Call telemetry_reset_events when logging is over
@@ -176,7 +176,7 @@ EXPORT_SYMBOL_GPL(telemetry_reset_events);
 /**
  * telemetry_get_eventconfig() - Returns the pss and ioss events enabled
  * @pss_evtconfig: Pointer to PSS related configuration.
- * @pss_evtconfig: Pointer to IOSS related configuration.
+ * @ioss_evtconfig: Pointer to IOSS related configuration.
  * @pss_len:	   Number of u32 elements allocated for pss_evtconfig array
  * @ioss_len:	   Number of u32 elements allocated for ioss_evtconfig array
  *
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 79554d28f08a..a377c3d02c55 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -724,14 +724,15 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
  * sdw_ml_sync_bank_switch: Multilink register bank switch
  *
  * @bus: SDW bus instance
+ * @multi_link: whether this is a multi-link stream with hardware-based sync
  *
  * Caller function should free the buffers on error
  */
-static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
+static int sdw_ml_sync_bank_switch(struct sdw_bus *bus, bool multi_link)
 {
 	unsigned long time_left;
 
-	if (!bus->multi_link)
+	if (!multi_link)
 		return 0;
 
 	/* Wait for completion of transfer */
@@ -827,7 +828,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			bus->bank_switch_timeout = DEFAULT_BANK_SWITCH_TIMEOUT;
 
 		/* Check if bank switch was successful */
-		ret = sdw_ml_sync_bank_switch(bus);
+		ret = sdw_ml_sync_bank_switch(bus, multi_link);
 		if (ret < 0) {
 			dev_err(bus->dev,
 				"multi link bank switch failed: %d\n", ret);
diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index de30262c3fae..e0787647093d 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -350,7 +350,7 @@ static s32 gdm_lte_tx_nic_type(struct net_device *dev, struct sk_buff *skb)
 	/* Get ethernet protocol */
 	eth = (struct ethhdr *)skb->data;
 	if (ntohs(eth->h_proto) == ETH_P_8021Q) {
-		vlan_eth = (struct vlan_ethhdr *)skb->data;
+		vlan_eth = skb_vlan_eth_hdr(skb);
 		mac_proto = ntohs(vlan_eth->h_vlan_encapsulated_proto);
 		network_data = skb->data + VLAN_ETH_HLEN;
 		nic_type |= NIC_TYPE_F_VLAN;
@@ -436,7 +436,7 @@ static netdev_tx_t gdm_lte_tx(struct sk_buff *skb, struct net_device *dev)
 	 * driver based on the NIC mac
 	 */
 	if (nic_type & NIC_TYPE_F_VLAN) {
-		struct vlan_ethhdr *vlan_eth = (struct vlan_ethhdr *)skb->data;
+		struct vlan_ethhdr *vlan_eth = skb_vlan_eth_hdr(skb);
 
 		nic->vlan_id = ntohs(vlan_eth->h_vlan_TCI) & VLAN_VID_MASK;
 		data_buf = skb->data + (VLAN_ETH_HLEN - ETH_HLEN);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3693ad9f4521..fa49529682ce 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -235,6 +235,7 @@ struct gsm_mux {
 	struct gsm_dlci *dlci[NUM_DLCI];
 	int old_c_iflag;		/* termios c_iflag value before attach */
 	bool constipated;		/* Asked by remote to shut up */
+	bool has_devices;		/* Devices were registered */
 
 	spinlock_t tx_lock;
 	unsigned int tx_bytes;		/* TX data outstanding */
@@ -464,6 +465,68 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 	return modembits;
 }
 
+/**
+ *	gsm_register_devices	-	register all tty devices for a given mux index
+ *
+ *	@driver: the tty driver that describes the tty devices
+ *	@index:  the mux number is used to calculate the minor numbers of the
+ *	         ttys for this mux and may differ from the position in the
+ *	         mux array.
+ */
+static int gsm_register_devices(struct tty_driver *driver, unsigned int index)
+{
+	struct device *dev;
+	int i;
+	unsigned int base;
+
+	if (!driver || index >= MAX_MUX)
+		return -EINVAL;
+
+	base = index * NUM_DLCI; /* first minor for this index */
+	for (i = 1; i < NUM_DLCI; i++) {
+		/* Don't register device 0 - this is the control channel
+		 * and not a usable tty interface
+		 */
+		dev = tty_register_device(gsm_tty_driver, base + i, NULL);
+		if (IS_ERR(dev)) {
+			if (debug & 8)
+				pr_info("%s failed to register device minor %u",
+					__func__, base + i);
+			for (i--; i >= 1; i--)
+				tty_unregister_device(gsm_tty_driver, base + i);
+			return PTR_ERR(dev);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ *	gsm_unregister_devices	-	unregister all tty devices for a given mux index
+ *
+ *	@driver: the tty driver that describes the tty devices
+ *	@index:  the mux number is used to calculate the minor numbers of the
+ *	         ttys for this mux and may differ from the position in the
+ *	         mux array.
+ */
+static void gsm_unregister_devices(struct tty_driver *driver,
+				   unsigned int index)
+{
+	int i;
+	unsigned int base;
+
+	if (!driver || index >= MAX_MUX)
+		return;
+
+	base = index * NUM_DLCI; /* first minor for this index */
+	for (i = 1; i < NUM_DLCI; i++) {
+		/* Don't unregister device 0 - this is the control
+		 * channel and not a usable tty interface
+		 */
+		tty_unregister_device(gsm_tty_driver, base + i);
+	}
+}
+
 /**
  *	gsm_print_packet	-	display a frame for debug
  *	@hdr: header to print before decode
@@ -2178,6 +2241,10 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	del_timer_sync(&gsm->t2_timer);
 
 	/* Free up any link layer users and finally the control channel */
+	if (gsm->has_devices) {
+		gsm_unregister_devices(gsm_tty_driver, gsm->num);
+		gsm->has_devices = false;
+	}
 	for (i = NUM_DLCI - 1; i >= 0; i--)
 		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
@@ -2201,15 +2268,21 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 static int gsm_activate_mux(struct gsm_mux *gsm)
 {
 	struct gsm_dlci *dlci;
+	int ret;
 
 	if (gsm->encoding == 0)
 		gsm->receive = gsm0_receive;
 	else
 		gsm->receive = gsm1_receive;
 
+	ret = gsm_register_devices(gsm_tty_driver, gsm->num);
+	if (ret)
+		return ret;
+
 	dlci = gsm_dlci_alloc(gsm, 0);
 	if (dlci == NULL)
 		return -ENOMEM;
+	gsm->has_devices = true;
 	gsm->dead = false;		/* Tty opens are now permissible */
 	return 0;
 }
@@ -2475,39 +2548,14 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
  *	will need moving to an ioctl path.
  */
 
-static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
+static void gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	unsigned int base;
-	int ret, i;
-
 	gsm->tty = tty_kref_get(tty);
 	/* Turn off tty XON/XOFF handling to handle it explicitly. */
 	gsm->old_c_iflag = tty->termios.c_iflag;
 	tty->termios.c_iflag &= (IXON | IXOFF);
-	ret =  gsm_activate_mux(gsm);
-	if (ret != 0)
-		tty_kref_put(gsm->tty);
-	else {
-		/* Don't register device 0 - this is the control channel and not
-		   a usable tty interface */
-		base = mux_num_to_base(gsm); /* Base for this MUX */
-		for (i = 1; i < NUM_DLCI; i++) {
-			struct device *dev;
-
-			dev = tty_register_device(gsm_tty_driver,
-							base + i, NULL);
-			if (IS_ERR(dev)) {
-				for (i--; i >= 1; i--)
-					tty_unregister_device(gsm_tty_driver,
-								base + i);
-				return PTR_ERR(dev);
-			}
-		}
-	}
-	return ret;
 }
 
-
 /**
  *	gsmld_detach_gsm	-	stop doing 0710 mux
  *	@tty: tty attached to the mux
@@ -2518,12 +2566,7 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 
 static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	unsigned int base = mux_num_to_base(gsm); /* Base for this MUX */
-	int i;
-
 	WARN_ON(tty != gsm->tty);
-	for (i = 1; i < NUM_DLCI; i++)
-		tty_unregister_device(gsm_tty_driver, base + i);
 	/* Restore tty XON/XOFF handling. */
 	gsm->tty->termios.c_iflag = gsm->old_c_iflag;
 	tty_kref_put(gsm->tty);
@@ -2534,27 +2577,25 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			      char *fp, int count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
-	const unsigned char *dp;
-	char *f;
-	int i;
 	char flags = TTY_NORMAL;
 
 	if (debug & 4)
 		print_hex_dump_bytes("gsmld_receive: ", DUMP_PREFIX_OFFSET,
 				     cp, count);
 
-	for (i = count, dp = cp, f = fp; i; i--, dp++) {
-		if (f)
-			flags = *f++;
+	for (; count; count--, cp++) {
+		if (fp)
+			flags = *fp++;
 		switch (flags) {
 		case TTY_NORMAL:
-			gsm->receive(gsm, *dp);
+			if (gsm->receive)
+				gsm->receive(gsm, *cp);
 			break;
 		case TTY_OVERRUN:
 		case TTY_BREAK:
 		case TTY_PARITY:
 		case TTY_FRAME:
-			gsm_error(gsm, *dp, flags);
+			gsm_error(gsm, *cp, flags);
 			break;
 		default:
 			WARN_ONCE(1, "%s: unknown flag %d\n",
@@ -2619,7 +2660,6 @@ static void gsmld_close(struct tty_struct *tty)
 static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
-	int ret;
 
 	if (tty->ops->write == NULL)
 		return -EINVAL;
@@ -2635,12 +2675,11 @@ static int gsmld_open(struct tty_struct *tty)
 	/* Attach the initial passive connection */
 	gsm->encoding = 1;
 
-	ret = gsmld_attach_gsm(tty, gsm);
-	if (ret != 0) {
-		gsm_cleanup_mux(gsm, false);
-		mux_put(gsm);
-	}
-	return ret;
+	gsmld_attach_gsm(tty, gsm);
+
+	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 14d9d1ee16fc..7b3c0787d5a4 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1353,8 +1353,6 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
 			udc->driver->function);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-
 	usb_gadget_disconnect(udc->gadget);
 	if (udc->gadget->irq)
 		synchronize_irq(udc->gadget->irq);
@@ -1363,6 +1361,8 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 
 	udc->driver = NULL;
 	udc->gadget->dev.driver = NULL;
+
+	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 }
 
 /**
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 535d28b44bca..1820b53657a6 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -491,7 +491,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	if (call->async) {
 		if (cancel_work_sync(&call->async_work))
 			afs_put_call(call);
-		afs_put_call(call);
+		afs_set_call_complete(call, ret, 0);
 	}
 
 	ac->error = ret;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c9ac43f40746..3babc07ae613 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3603,6 +3603,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
 			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
 
+	/* avoid unnecessary preallocation that may trigger assertions */
+	if (start + size > EXT_MAX_BLOCKS)
+		size = EXT_MAX_BLOCKS - start;
+
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
 		size -= ar->lleft + 1 - start;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ff99ab2a3c43..2739e218df64 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1228,6 +1228,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
 	if (fc->dax) {
 		fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
 		kfree(fc->dax);
+		fc->dax = NULL;
 	}
 }
 
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 4fe7fd0fe834..d1ddbcf71791 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -41,7 +41,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
 {
-	return !atomic_read(&lock.val);
+	return !lock.val.counter;
 }
 
 /**
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..d35e4867d5cc 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -109,7 +109,7 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
  * same context as task->real_cred.
  */
 struct cred {
-	atomic_t	usage;
+	atomic_long_t	usage;
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	atomic_t	subscribers;	/* number of processes subscribed */
 	void		*put_addr;
@@ -227,7 +227,7 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
+	atomic_long_inc(&cred->usage);
 	return cred;
 }
 
@@ -259,7 +259,7 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return NULL;
-	if (!atomic_inc_not_zero(&nonconst_cred->usage))
+	if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
 	validate_creds(cred);
 	nonconst_cred->non_rcu = 0;
@@ -283,7 +283,7 @@ static inline void put_cred(const struct cred *_cred)
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		if (atomic_long_dec_and_test(&(cred)->usage))
 			__put_cred(cred);
 	}
 }
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4e7e72f3da5b..ce6714bec65f 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -60,6 +60,14 @@ static inline struct vlan_ethhdr *vlan_eth_hdr(const struct sk_buff *skb)
 	return (struct vlan_ethhdr *)skb_mac_header(skb);
 }
 
+/* Prefer this version in TX path, instead of
+ * skb_reset_mac_header() + vlan_eth_hdr()
+ */
+static inline struct vlan_ethhdr *skb_vlan_eth_hdr(const struct sk_buff *skb)
+{
+	return (struct vlan_ethhdr *)skb->data;
+}
+
 #define VLAN_PRIO_MASK		0xe000 /* Priority Code Point */
 #define VLAN_PRIO_SHIFT		13
 #define VLAN_CFI_MASK		0x1000 /* Canonical Format Indicator / Drop Eligible Indicator */
@@ -526,7 +534,7 @@ static inline void __vlan_hwaccel_put_tag(struct sk_buff *skb,
  */
 static inline int __vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 {
-	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb->data;
+	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
 
 	if (!eth_type_vlan(veth->h_vlan_proto))
 		return -EINVAL;
@@ -727,7 +735,7 @@ static inline bool skb_vlan_tagged_multi(struct sk_buff *skb)
 		if (unlikely(!pskb_may_pull(skb, VLAN_ETH_HLEN)))
 			return false;
 
-		veh = (struct vlan_ethhdr *)skb->data;
+		veh = skb_vlan_eth_hdr(skb);
 		protocol = veh->h_vlan_encapsulated_proto;
 	}
 
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index edba74a53683..4d0c4cf1d4c8 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -31,17 +31,22 @@ struct prefix_info {
 	__u8			length;
 	__u8			prefix_len;
 
+	union __packed {
+		__u8		flags;
+		struct __packed {
 #if defined(__BIG_ENDIAN_BITFIELD)
-	__u8			onlink : 1,
+			__u8	onlink : 1,
 			 	autoconf : 1,
 				reserved : 6;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8			reserved : 6,
+			__u8	reserved : 6,
 				autoconf : 1,
 				onlink : 1;
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
+		};
+	};
 	__be32			valid;
 	__be32			prefered;
 	__be32			reserved2;
@@ -49,6 +54,9 @@ struct prefix_info {
 	struct in6_addr		prefix;
 };
 
+/* rfc4861 4.6.2: IPv6 PIO is 32 bytes in size */
+static_assert(sizeof(struct prefix_info) == 32);
+
 #include <linux/ipv6.h>
 #include <linux/netdevice.h>
 #include <net/if_inet6.h>
diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index e03ba8e80781..d4d7f4d52b15 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -22,10 +22,6 @@
 #define IF_RS_SENT	0x10
 #define IF_READY	0x80000000
 
-/* prefix flags */
-#define IF_PREFIX_ONLINK	0x01
-#define IF_PREFIX_AUTOCONF	0x02
-
 enum {
 	INET6_IFADDR_STATE_PREDAD,
 	INET6_IFADDR_STATE_DAD,
diff --git a/kernel/cred.c b/kernel/cred.c
index 421b1149c651..54042ebed5d2 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -98,17 +98,17 @@ static void put_cred_rcu(struct rcu_head *rcu)
 
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
@@ -131,11 +131,11 @@ static void put_cred_rcu(struct rcu_head *rcu)
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
@@ -158,8 +158,8 @@ void exit_creds(struct task_struct *tsk)
 {
 	struct cred *cred;
 
-	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	kdebug("exit_creds(%u,%p,%p,{%ld,%d})", tsk->pid, tsk->real_cred, tsk->cred,
+	       atomic_long_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	cred = (struct cred *) tsk->real_cred;
@@ -218,7 +218,7 @@ struct cred *cred_alloc_blank(void)
 	if (!new)
 		return NULL;
 
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	new->magic = CRED_MAGIC;
 #endif
@@ -265,7 +265,7 @@ struct cred *prepare_creds(void)
 	memcpy(new, old, sizeof(struct cred));
 
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_group_info(new->group_info);
 	get_uid(new->user);
@@ -348,8 +348,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
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
@@ -439,8 +439,8 @@ int commit_creds(struct cred *new)
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
 
-	kdebug("commit_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("commit_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	BUG_ON(task->cred != old);
@@ -449,7 +449,7 @@ int commit_creds(struct cred *new)
 	validate_creds(old);
 	validate_creds(new);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(atomic_long_read(&new->usage) < 1);
 
 	get_cred(new); /* we will require a ref for the subj creds too */
 
@@ -522,14 +522,14 @@ EXPORT_SYMBOL(commit_creds);
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
@@ -545,8 +545,8 @@ const struct cred *override_creds(const struct cred *new)
 {
 	const struct cred *old = current->cred;
 
-	kdebug("override_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("override_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	validate_creds(old);
@@ -568,8 +568,8 @@ const struct cred *override_creds(const struct cred *new)
 	rcu_assign_pointer(current->cred, new);
 	alter_cred_subscribers(old, -1);
 
-	kdebug("override_creds() = %p{%d,%d}", old,
-	       atomic_read(&old->usage),
+	kdebug("override_creds() = %p{%ld,%d}", old,
+	       atomic_long_read(&old->usage),
 	       read_cred_subscribers(old));
 	return old;
 }
@@ -586,8 +586,8 @@ void revert_creds(const struct cred *old)
 {
 	const struct cred *override = current->cred;
 
-	kdebug("revert_creds(%p{%d,%d})", old,
-	       atomic_read(&old->usage),
+	kdebug("revert_creds(%p{%ld,%d})", old,
+	       atomic_long_read(&old->usage),
 	       read_cred_subscribers(old));
 
 	validate_creds(old);
@@ -699,7 +699,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 
 	*new = *old;
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_uid(new->user);
 	get_user_ns(new->user_ns);
@@ -809,8 +809,8 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
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
@@ -882,9 +882,9 @@ EXPORT_SYMBOL(__validate_process_creds);
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
index 0a6855d64803..afedd008e0af 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2039,6 +2039,16 @@ static bool perf_event_validate_size(struct perf_event *event)
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
index 7e1148aafd28..364fa91ab33e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -703,6 +703,9 @@ static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	unsigned long cnt2, top2, bottom2;
 	u64 val;
 
+	/* Any interruptions in this function should cause a failure */
+	cnt = local_read(&t->cnt);
+
 	/* The cmpxchg always fails if it interrupted an update */
 	 if (!__rb_time_read(t, &val, &cnt2))
 		 return false;
@@ -710,7 +713,6 @@ static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	 if (val != expect)
 		 return false;
 
-	 cnt = local_read(&t->cnt);
 	 if ((cnt & 3) != cnt2)
 		 return false;
 
@@ -1667,6 +1669,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
+	free_page((unsigned long)cpu_buffer->free_page);
+
 	kfree(cpu_buffer);
 }
 
@@ -2273,7 +2277,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	barrier();
 
-	if ((iter->head + length) > commit || length > BUF_MAX_DATA_SIZE)
+	if ((iter->head + length) > commit || length > BUF_PAGE_SIZE)
 		/* Writer corrupted the read? */
 		goto reset;
 
@@ -3299,7 +3303,10 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		 * absolute timestamp.
 		 * Don't bother if this is the start of a new page (w == 0).
 		 */
-		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
+		if (!w) {
+			/* Use the sub-buffer timestamp */
+			info->delta = 0;
+		} else if (unlikely(!a_ok || !b_ok || info->before != info->after)) {
 			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
@@ -3454,6 +3461,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
 		info.length += RB_LEN_TIME_EXTEND;
+		if (info.length > BUF_MAX_DATA_SIZE)
+			goto out_fail;
 	} else {
 		add_ts_default = RB_ADD_STAMP_NONE;
 	}
@@ -4834,7 +4843,8 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	if (!iter)
 		return NULL;
 
-	iter->event = kmalloc(BUF_MAX_DATA_SIZE, flags);
+	/* Holds the entire event: data and meta data */
+	iter->event = kmalloc(BUF_PAGE_SIZE, flags);
 	if (!iter->event) {
 		kfree(iter);
 		return NULL;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4e0411b19ef9..b2527624481d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5905,7 +5905,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
-	/* Do not allow tracing while resizng ring buffer */
+	/* Do not allow tracing while resizing ring buffer */
 	tracing_stop_tr(tr);
 
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
@@ -5913,7 +5913,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!tr->current_trace->use_max_tr)
+	if (!tr->allocated_snapshot)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index c94b212d8e7c..46adb8cefccf 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1811,15 +1811,14 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
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
index 838ebf0cabbf..f81f8d56f5c0 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -73,14 +73,17 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
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
 	case ATM_SETSC:
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7ac16d7b94a2..0e6d0a5e6841 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -454,7 +454,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
-		vhdr = (struct vlan_ethhdr *)skb->data;
+		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
 		if (vhdr->h_vlan_encapsulated_proto != htons(ETH_P_BATMAN))
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f8ad8465f76c..f0df14782ee0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3171,7 +3171,13 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
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
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 193e5f275733..79787a1f5ab3 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6034,11 +6034,7 @@ static int inet6_fill_prefix(struct sk_buff *skb, struct inet6_dev *idev,
 	pmsg->prefix_len = pinfo->prefix_len;
 	pmsg->prefix_type = pinfo->type;
 	pmsg->prefix_pad3 = 0;
-	pmsg->prefix_flags = 0;
-	if (pinfo->onlink)
-		pmsg->prefix_flags |= IF_PREFIX_ONLINK;
-	if (pinfo->autoconf)
-		pmsg->prefix_flags |= IF_PREFIX_AUTOCONF;
+	pmsg->prefix_flags = pinfo->flags;
 
 	if (nla_put(skb, PREFIX_ADDRESS, sizeof(pinfo->prefix), &pinfo->prefix))
 		goto nla_put_failure;
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index cb69a299f10c..c9f89f035ccf 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -214,7 +214,7 @@ static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
 
 		offset = i + priv->offset;
 		if (priv->flags & NFT_EXTHDR_F_PRESENT) {
-			*dest = 1;
+			nft_reg_store8(dest, 1);
 		} else {
 			if (priv->len % NFT_REG32_SIZE)
 				dest[priv->len / NFT_REG32_SIZE] = 0;
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index b10ce732b337..1fd4b2054e8f 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -140,11 +140,15 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
 		index = dev ? dev->ifindex : 0;
-		*dreg = (priv->flags & NFTA_FIB_F_PRESENT) ? !!index : index;
+		if (priv->flags & NFTA_FIB_F_PRESENT)
+			nft_reg_store8(dreg, !!index);
+		else
+			*dreg = index;
+
 		break;
 	case NFT_FIB_RESULT_OIFNAME:
 		if (priv->flags & NFTA_FIB_F_PRESENT)
-			*dreg = !!dev;
+			nft_reg_store8(dreg, !!dev);
 		else
 			strncpy(reg, dev ? dev->name : "", IFNAMSIZ);
 		break;
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 86c93cf1744b..b3e7a92f1ec1 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1307,9 +1307,11 @@ static int rose_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
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
index c9ee9259af48..080e8f2bf985 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -436,7 +436,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
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
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c19afe486194..86a43b955db9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1967,6 +1967,8 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8715, "HP", 1),
+	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
+	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
 	{}
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d9140630cf3d..0743fcd74707 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8986,6 +8986,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x841c, "HP Pavilion 15-CK0xx", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84ae, "HP 15-db0403ng", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),

