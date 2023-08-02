Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE05276D240
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjHBPjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjHBPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:38:51 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3A2D7E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:38:05 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34770dd0b4eso3790095ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690990685; x=1691595485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohwe7sWJuQOwFnTKjN2+GTRcxF1Lf9US/VSNkGV+XaY=;
        b=inTzu8txCgciAR8I65Y61N8CeBtLfEsPEIKUD1xFOqdAVHPvfDx6sPYaThHOMv5dQG
         ub/4WuCHvkqHu5kQe9cmg2ANWPoUJOuN7aKrApEMDDhk6NNQUnRdu43Es0/GPviE8GBp
         zeMjzFV8Vh1VVL8mBR3I77coXxgxO6Xm5dnp8gzA7/paYNqIzkbAfPUiHx8BScbkRxKD
         lXnNRRvsJDuliSPsXxZvKu5jBlidd7IKJfbA0Ar27lQfvXvk57pokot6iKGIgs3+8/qT
         CGvTh9tnJxU/3BJoqhgBsVhqOzHFJ6vyWOJXiXUfk3aT55cQi00lY5/K/9QZao3SmPfu
         OBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990685; x=1691595485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohwe7sWJuQOwFnTKjN2+GTRcxF1Lf9US/VSNkGV+XaY=;
        b=cebYTdzE8Kt3N1Ly1m53DeCoPYMd8oBkQ4OmYrbmPG9iTHIPH94kzxN9qefldwHeh1
         0aAbJ/Ju6+8QeGPGVjTNA6sSVfh6fUvkvYic+jgEXdgksflkkfA1Sf1HG0f9+mbN5/e/
         Q9CK58W4bZSjMAAvSIj2jbKCW96j70TJU6L2Imrt/6JljpyOklTYv1wxZHYkcMVCIODU
         GXJSkuVFgHgTXbvg6eJX6mRVTc8bNEV90s8LPyv84mWgjFioNOvUgQ+W3Zed975mV5Dw
         kenUM6BeBmwNZYhLzpE24Q/Os+ky7XiWli6r85QE31JQfSRbUalyNeYVurDxAR7y2ziT
         Pfew==
X-Gm-Message-State: ABy/qLZU7bg+BoaKMmGZ0WXKuw+/mhCl4KRN6qTtY1hHMT3whW9klPvG
        R9hOGp+eGr5MTmmtecm2oDc=
X-Google-Smtp-Source: APBJJlH3/2Y8SBqCWEYPY2K1H4/Hbk2M+hOQ5vmajs5vp3cF83mW1qldpSF1BaFqrM3C6rEA0E8BjA==
X-Received: by 2002:a6b:5d02:0:b0:783:6ec1:65f6 with SMTP id r2-20020a6b5d02000000b007836ec165f6mr13164371iob.1.1690990685237;
        Wed, 02 Aug 2023 08:38:05 -0700 (PDT)
Received: from localhost.localdomain ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id g8-20020a6b7608000000b00786f50d6bf5sm4556830iom.19.2023.08.02.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:38:04 -0700 (PDT)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH 2/2] ALSA: hda/realtek: Add headphone quirk for Aya Neo 2
Date:   Wed,  2 Aug 2023 10:37:30 -0500
Message-ID: <20230802153730.39273-3-ruinairas1992@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802153730.39273-1-ruinairas1992@gmail.com>
References: <20230802153730.39273-1-ruinairas1992@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the headphones on the Aya Neo 2 handheld.
Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 33f9beec8179..5d31cbe5d40b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7030,6 +7030,7 @@ enum {
 	ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET,
+	ALC269_FIXUP_HEADSET_AYA_2,
 	ALC269_FIXUP_HEADSET_AYA_GEEK,
 	ALC269_FIXUP_HEADSET_MODE,
 	ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC,
@@ -8455,6 +8456,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC269_FIXUP_HEADSET_AYA_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_headphone_volume,
+	},
 	[ALC269_FIXUP_HEADSET_AYA_GEEK] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_headphone_volume,
@@ -9953,6 +9958,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1f66, 0x0101, "AYANEO 2", ALC269_FIXUP_HEADSET_AYA_2),
 	SND_PCI_QUIRK(0x1f66, 0x0101, "GEEK", ALC269_FIXUP_HEADSET_AYA_GEEK),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
-- 
2.41.0

