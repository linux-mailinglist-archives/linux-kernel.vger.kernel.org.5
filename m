Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE492804060
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346141AbjLDUsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbjLDUsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:48:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20682173E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:36:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B53C433C7;
        Mon,  4 Dec 2023 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722186;
        bh=3yjYYOi8KUKaS5jWBU1u/r5BRTVdLfULwy4YOStsWBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5G6vITggKcvBgGQ7vKmcNdO/8Qz1yIQ9yX7F8Qz55yxvAQ9aUE7/D+MSoD0ztTaj
         XUepSWfLkBpuAyYTW5yEZKHHSchZw6ISLlHPiKk4Wuwzi7qpDL02ItxbjGvgG8vexQ
         xuZQVF2BndkKMvJOhyRTwNviNvCdMj/edybz+TYmNrOxR2K5MQk48qAltHVBY16DOE
         iBqp4zOTDGFje1f0tOA5/bAjn/jm7Znz+SwoI8MN+gT7IPtzVwZpWV5m7Uj6JmH0gm
         aOd8AT9zvx/LlsmZTVVTWRyQCqkyXHx7qk81i5iZhNLJpyaLEAOhK1YiYscEOYm5NL
         8fzCvD9fCLIGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasiliy Kovalev <kovalev@altlinux.org>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        sbinding@opensource.cirrus.com, luke@ljones.dev,
        andy.chi@canonical.com, shenghao-ding@ti.com,
        ruinairas1992@gmail.com, l.guzenko@web.de, yangyuchi66@gmail.com,
        vitalyr@opensource.cirrus.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/10] ALSA: hda - Fix speaker and headset mic pin config for CHUWI CoreBook XPro
Date:   Mon,  4 Dec 2023 15:35:59 -0500
Message-ID: <20231204203616.2094529-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203616.2094529-1-sashal@kernel.org>
References: <20231204203616.2094529-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.141
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
index 4ab3cbef72e80..2b77e0deb0da5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6842,6 +6842,7 @@ enum {
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
+	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -7140,6 +7141,14 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -9388,6 +9397,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-- 
2.42.0

