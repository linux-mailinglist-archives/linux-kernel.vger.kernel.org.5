Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0849B803F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjLDUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346046AbjLDUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:33:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0211D4B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:33:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE26C433D9;
        Mon,  4 Dec 2023 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722014;
        bh=XQbnVYfDI13f/xKWRvmhD+fRVkADSaH7DGVZa3M65ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qxf8c8dmP7g+qNyAGmlkNWkznzzIr6FYnn1a75GBY2zMJgcUywDeCFGWQQshMz/am
         H6Kef/5HoTKP6+n8Snd5yi7+qh+If6PJCUkGSoi4JxAM3XVLa9EbbUdT3ZhJgnQUCg
         Py8leyHa67cjm/q5B6oNmgyr/JMZZ7Koza4XCFsdz+ob/HQo7V7Ym+95PyIb3tqadD
         QhnLa9QJXS9TPDQQ020CNv9QzxRfTtZZ+7Iefs2bPOBZx4TxEHjFULEZvBZ/G1J9/7
         IfqBngS5x1a1S/L/Y1C8thZZkn4MJaXJ5Ojx6FpLfGpZZqDTGftIXxwAhHPUcMJMZY
         bhX2EOvQMwf/g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasiliy Kovalev <kovalev@altlinux.org>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        sbinding@opensource.cirrus.com, luke@ljones.dev,
        andy.chi@canonical.com, shenghao-ding@ti.com,
        ruinairas1992@gmail.com, l.guzenko@web.de, yangyuchi66@gmail.com,
        vitalyr@opensource.cirrus.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/32] ALSA: hda - Fix speaker and headset mic pin config for CHUWI CoreBook XPro
Date:   Mon,  4 Dec 2023 15:32:25 -0500
Message-ID: <20231204203317.2092321-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
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

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit 7c9caa299335df94ad1c58f70a22f16a540eab60 ]

This patch corrected the speaker and headset mic pin config to the more
appropriate values.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://lore.kernel.org/r/20231117170923.106822-1-kovalev@altlinux.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 87bc1d2f8a432..8e2504dbeceaf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7168,6 +7168,7 @@ enum {
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
+	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -7520,6 +7521,14 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
 	},
+	[ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x03a19020 }, /* headset mic */
+			{ 0x1b, 0x90170150 }, /* speaker */
+			{ }
+		},
+	},
 	[ALC269_FIXUP_AMIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -10163,6 +10172,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-- 
2.42.0

