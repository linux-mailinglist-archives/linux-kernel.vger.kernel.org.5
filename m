Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C847EBBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjKODee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjKODec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:34:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A6D5;
        Tue, 14 Nov 2023 19:34:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64116C433C7;
        Wed, 15 Nov 2023 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019268;
        bh=ewJizaPtlqc24f19smotXbwRC0t9KaAAI1Stk3dIHwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2PURsr+cTzs6AGUlwHrxCJK0KtVrCnHu1+UhpsQ881a4cXk+kkhRPW/16GfY17Ts
         EVw8y/nbvE4T/3Km/w9cRaOKJu2AyBMk1Gl0jDOsAXXHVXaoYnHTBNOnDHRaE1oYKq
         B5DZMruKt2gyZVcbtdu1+KDe1TwD8pVklvxAZA1U0yjuLO7TaGY8uFVCx7gkgWOyNj
         ZwEqkBszs/BTjsrYCmHH7MmkLAc2EVC/v+2YqWEsEjrOfWMEM8whY49Ev4Mij3LTry
         fCbdlalCmkE3cyy9YvQX37MoJ83feqTEhSUZN4HhwrY+UfRWg6r6FVMIY0SV1bva1m
         6BP4Qt1DKbDGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Spataru <alex_spataru@outlook.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        luke@ljones.dev, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, shenghao-ding@ti.com, l.guzenko@web.de,
        ruinairas1992@gmail.com, yangyuchi66@gmail.com,
        vitalyr@opensource.cirrus.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 3/6] ALSA: hda/realtek: Add quirk for ASUS UX7602ZM
Date:   Tue, 14 Nov 2023 22:33:37 -0500
Message-ID: <20231115033350.1228588-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115033350.1228588-1-sashal@kernel.org>
References: <20231115033350.1228588-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.1
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
index 9677c09cf7a98..2ed40adc8e15d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9848,6 +9848,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
-- 
2.42.0

