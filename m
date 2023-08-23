Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA06B7856DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjHWLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjHWLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:41:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483CDCD0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:41:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a3f0a7092so3017790b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790860; x=1693395660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Su+EU8s5DmANSaG1XE16qDS9/XMEfX9gISNXjzq27Sw=;
        b=fchnrp14aPW5vsHdbdWYZ7o0T7l0cHhD4iWuO0jpSGcX6Vdi6tjgpttzFEzPdPpXk/
         3brjhEorRO66Mp5CG4uGHRB+0mpTcdxglnBtyA+moHaqv/s4OUYU0ZHvb2TgxeCN6T51
         qbCvcqdwsfsQGPK9Rfv0neIMThfDZ+/Q2oMT8aRri21hSPVhG24aeidLGFjt5HReZDob
         aRWKJImae7+y8Lsa5/Vc380OGzTdloM1Z357Nlsq3TacgdksKLtS2+LN8CfyEGnry5bz
         XXcxjmRvDyd3OPZYh5X+YmBjLuOc2O71yGi42jomiGXss0boiDljMgu+aYk8dF164dq0
         sXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790860; x=1693395660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Su+EU8s5DmANSaG1XE16qDS9/XMEfX9gISNXjzq27Sw=;
        b=JNi3D3g0fNOZZnQ6usy4FFSydZRNFcZ39ydL3aa6gcBz8NsDNlnmQtpYMnGEi570Nj
         R2PyQgxXYs3OfGevLZYoo7HQbGJWQ8PpUmUF89WlKpwFV+m5+U1LStZ59hx3usc2bY20
         DSYLzasie8QWdIl1SjGjpQYg8mUzzPl5vUnnYvhYt8F+gvSBl+3tgqDJaRfyD8OkHgGb
         K3kkp2WaasBmQUeeFeOR7zpxOH8cVpgpkhrpVC04p7OQdNAdDts1KnFKpkKbUDwJULuu
         qeQKRt1YnixTU1jTlmQ/qSAKEeXTWHN/9j1Db1lFpTCw8ahRs1GggN2+ZlxSws4pqi0T
         O43w==
X-Gm-Message-State: AOJu0YynxUmtUIaOIH5zr2oMVrkLCewIkARuG2S0/7bK/FN3q0uIwiaH
        ScAeI8Kgv3/pvZW+qkhMuTA=
X-Google-Smtp-Source: AGHT+IHua33zuGAafhWe6RdBA0W5BIQr58Rl41OKq+EqR/CvCx1kr0fIn34fM95VoyE5EwyQpWmSVg==
X-Received: by 2002:a05:6a21:6d9b:b0:14a:b444:dcce with SMTP id wl27-20020a056a216d9b00b0014ab444dccemr2544075pzb.4.1692790859703;
        Wed, 23 Aug 2023 04:40:59 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b0068783a2dfdasm4589293pfn.104.2023.08.23.04.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:40:59 -0700 (PDT)
From:   SungHwan Jung <onenowy@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     SungHwan Jung <onenowy@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED
Date:   Wed, 23 Aug 2023 20:40:51 +0900
Message-ID: <20230823114051.3921-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This quirk enables mute LED on HP Victus 16-d1xxx (8A25) laptops, which
use ALC245 codec.

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc7b7a407..d8865f467 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4639,6 +4639,22 @@ static void alc236_fixup_hp_mute_led_coefbit2(struct hda_codec *codec,
 	}
 }
 
+static void alc245_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x0b;
+		spec->mute_led_coef.mask = 3 << 2;
+		spec->mute_led_coef.on = 2 << 2;
+		spec->mute_led_coef.off = 1 << 2;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -7231,6 +7247,7 @@ enum {
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
+	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9309,6 +9326,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
+	[ALC245_FIXUP_HP_MUTE_LED_COEFBIT] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_mute_led_coefbit,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9582,6 +9603,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.42.0

