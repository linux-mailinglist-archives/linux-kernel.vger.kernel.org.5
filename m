Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8437EBC26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjKODjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjKODjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:39:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC5ADB;
        Tue, 14 Nov 2023 19:39:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340CBC433C8;
        Wed, 15 Nov 2023 03:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019581;
        bh=h5UR94pZ9ogjSE192sQz3/HzgSQYJrUvXS+LwkEHxYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxJaMTKl8uvhYMxZQDMGWtKTE4EC1w0Cw09lmQg/Ok7qIbGwJxStlBENCZ35+HBtn
         BjmVUzI3JtHgEESNGzNNqoUCk3Uzfbp89bOA8GTwwT/EsXCMrbmgxbXQ1hA+41U8s3
         yZYh+imREFVHBFoXOv+WINY2g2Fv4HtBtMc16Djwj/pSXvsrEmYxK5fH9bkWXXcxXb
         K2iUo3RPmPdv+I8BqYP4FNegFPhZ7e519/hjc9nJJgI4qy79lgjujb261uNrrf4wpE
         qDUIs29AfRKzt5yMaDVLDV/fD/kyW76Phqmckzv0wLAb2JbIUYYxzASX2hW0/qp3Z4
         hyS1flN4RLrxA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Spataru <alex_spataru@outlook.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        luke@ljones.dev, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, shenghao-ding@ti.com, l.guzenko@web.de,
        ruinairas1992@gmail.com, yangyuchi66@gmail.com,
        vitalyr@opensource.cirrus.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/6] ALSA: hda/realtek: Add quirk for ASUS UX7602ZM
Date:   Tue, 14 Nov 2023 22:35:57 -0500
Message-ID: <20231115033608.1229058-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115033608.1229058-1-sashal@kernel.org>
References: <20231115033608.1229058-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.62
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
index 0163d4c7fdda8..c55b26af002a7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9749,6 +9749,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
-- 
2.42.0

