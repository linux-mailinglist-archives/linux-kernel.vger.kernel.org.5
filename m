Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59C97EBC09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjKODft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjKODfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:35:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5912C114;
        Tue, 14 Nov 2023 19:35:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6163BC433C7;
        Wed, 15 Nov 2023 03:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019331;
        bh=HhzkQt73VBzuy/O8xvSbdBIFPmyGIMSt+uwy1sehaCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yx2JWcuqM6mDAeN2HWszlLJyB+cIcUDtSLtsDMnIwNiIPDG869SNA94UhUB67MStL
         G1cQdyukTyOLFSikXlUd1tSivG7glEFb/d+Ob7BmrS0bsLxJgxLuKsEjK/RBeBrRSi
         zOg3827vRlwV0h33KfSFyyNXC+e/p/etCBRj51G3WW/MTX07LhlKWQu11AvvfC/4d0
         kcpxczgPcw+moYK+NAfDO7K4WYSZQ1xyZjCCgopwxFAh6VW2QsRaNuJ2JVnpz4/I9M
         +GZH/uDwNhAyeyRWqcztBfzaG+k2XSoqqv3KjYXTsUY/HhIK7/00gT/BHpVnsb64f7
         TBUVCLY2zdL7Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Spataru <alex_spataru@outlook.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        luke@ljones.dev, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, shenghao-ding@ti.com, l.guzenko@web.de,
        ruinairas1992@gmail.com, yangyuchi66@gmail.com,
        vitalyr@opensource.cirrus.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 3/6] ALSA: hda/realtek: Add quirk for ASUS UX7602ZM
Date:   Tue, 14 Nov 2023 22:34:47 -0500
Message-ID: <20231115033459.1228900-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115033459.1228900-1-sashal@kernel.org>
References: <20231115033459.1228900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.11
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

From: Alex Spataru <alex_spataru@outlook.com>

[ Upstream commit 26fd31ef9c02a5e91cdb8eea127b056bd7cf0b3b ]

Enables the SPI-connected CSC35L41 audio amplifier for this
laptop model.

As of BIOS version 303 it's still necessary to
modify the ACPI table to add the related _DSD properties:
https://github.com/alex-spataru/asus_zenbook_ux7602zm_sound/

Signed-off-by: Alex Spataru <alex_spataru@outlook.com>
Link: https://lore.kernel.org/r/DS7PR07MB7621BB5BB14F5473D181624CE3A4A@DS7PR07MB7621.namprd07.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c2fbf484b1104..26ef0bc8190fb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9772,6 +9772,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
-- 
2.42.0

