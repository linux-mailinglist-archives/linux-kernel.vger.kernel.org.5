Return-Path: <linux-kernel+bounces-51450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA810848B64
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F283B23EA1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8656D7460;
	Sun,  4 Feb 2024 06:12:26 +0000 (UTC)
Received: from mail-m6017.netease.com (mail-m6017.netease.com [210.79.60.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240C6FA8;
	Sun,  4 Feb 2024 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707027146; cv=none; b=PNwVNs/t9L/nklrb3UCwxCTWQm0m54A+YPUZkXy+NTCISzLE3YMfnFgdtUvkOX9onq2Lm8kslZDH0lZlOxnY2CE+U8BsxfzbaqLBHQGoW5Q4uQLv3SxOb+GnzCAXB38blTTmvtkmLQ5HQ1+VTBzWuc14wgGUtMwoJiTe+iQ51X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707027146; c=relaxed/simple;
	bh=L7VU0mrvuL1+eMtSkEdZOhT+A1UBXWPT4kmvv04CzjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWYmxEt7MZTooh8WJF/WTPp4raO3OTKAHHPNNu2dn68gJGjSNyJnpvpO4Vm8z8MTiC6axzwqGH4kJ3N++kbNG147Z8rGtnHIYg9xmUslw29TpFZKKyoehs+yHwoLQrSF5MmJBFwxK6DV2HqTn7+htrnjKTg8pV73FIxjMM9dgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com; spf=pass smtp.mailfrom=senarytech.com; arc=none smtp.client-ip=210.79.60.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from book-ThinkStation-P328.. (unknown [61.183.143.78])
	by smtp.qiye.163.com (Hmail) with ESMTPA id A04D6900172;
	Sun,  4 Feb 2024 12:53:51 +0800 (CST)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH] ALSA: hda/conexant: Add quirk for SWS JS201D
Date: Sun,  4 Feb 2024 12:53:44 +0800
Message-Id: <20240204045344.48397-1-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUpJVkNPQ0gZSE5LT0JLGFUTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8d7277361203a9kunma04d6900172
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ni46HTo*ITMISD8#Ii0vET4W
	IzkaCxxVSlVKTEtMS0lJT0hJSklDVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBSEtKTTcG

The SWS JS201D need a different pinconfig from windows driver.
Add a quirk to use a specific pinconfig to SWS JS201D.

Signed-off-by: bo liu <bo.liu@senarytech.com>
---
 sound/pci/hda/patch_conexant.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e8819e8a9876..a0bb4d91502b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -344,6 +344,7 @@ enum {
 	CXT_FIXUP_HP_ZBOOK_MUTE_LED,
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
+	CXT_PINCFG_SWS_JS201D,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -841,6 +842,17 @@ static const struct hda_pintbl cxt_pincfg_lemote[] = {
 	{}
 };
 
+/* SuoWoSi/South-holding JS201D with sn6140 */
+static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
+	{ 0x16, 0x03211040 }, /* hp out */
+	{ 0x17, 0x91170110 }, /* SPK/Class_D */
+	{ 0x18, 0x95a70130 }, /* Internal mic */
+	{ 0x19, 0x03a11020 }, /* Headset Mic */
+	{ 0x1a, 0x40f001f0 }, /* Not used */
+	{ 0x21, 0x40f001f0 }, /* Not used */
+	{}
+};
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -996,6 +1008,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.chained = true,
 		.chain_id = CXT_FIXUP_HEADSET_MIC,
 	},
+	[CXT_PINCFG_SWS_JS201D] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_sws_js201d,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1091,6 +1107,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
+	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	{}
 };
 
@@ -1109,6 +1126,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_HP_ZBOOK_MUTE_LED, .name = "hp-zbook-mute-led" },
 	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
+	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{}
 };
 
-- 
2.34.1


