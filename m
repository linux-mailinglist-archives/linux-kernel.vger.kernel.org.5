Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F07C92FE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjJNGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjJNGfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:35:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298ACC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 23:35:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so3577170e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697265349; x=1697870149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJyWt/G9UgfvUHmmjADyY97GEgcUxAnVJZD4ohf6ujU=;
        b=YhK9+WKLhXYSQCY7XBlzQBKrNfE0FIf6lwovTgQMjoj7m1HFZEK3MF/mTP1Ysj+4Sn
         znYL/tGI8BoQJMz839/JWvFkw00/g5Bo0G7p/cih1mbiQwF1mXYa5DL7YOHW1sDKDIbL
         Ww1fFr7ti37PmzckERUNSPG64IBD83v8KknzqLfJ2muWg3d7ZbJRawzFDJS0C1ZrLrkV
         HEaId6jRgJtX2bxCKUzCxMnKn4epu28GIoC1iXui+ZGcp2xtqlpYk/+/5HDKJv1cJaMS
         wcep6DRTBHMeABpCWC9qiDAeUzWhHFSvGrkmaddddYP77nZ4/5U2/F7Nja8YHBREJujL
         MRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697265349; x=1697870149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJyWt/G9UgfvUHmmjADyY97GEgcUxAnVJZD4ohf6ujU=;
        b=Z+N1prq2d6Nl4svQFkA+FVxjr/NVIqULLv6zel6ejDolgdmGpvu5y3YG3UkA3Z/CKn
         nHrOmTFUcepUTtoBb0ThjQ/6Fk+qBg031gkaI33TCZWDWMtQHlyeeIEZg36BZgfKhvQZ
         h3ajlhHpwMf4rkPySwpBrcTfMDf78+6XnZMsJYzr0lRsqUkbTKRiCBjlRVOYeC+ibs1X
         VyMfBBL50oxD9c/8c42Or/JgRww7Ow1ehet6ber3Tg/ApeSyIChNmaZHwimESGll2Z9X
         Z7yQ9p7m+XkhGmQkQ3VcebyihAmH4womH48BTwoPxnk+9pAtAueTeQJ14Jf2ayYmyriI
         3zuA==
X-Gm-Message-State: AOJu0Yyo/DXTjuWKEK8AVzkPW6mykdz66vBL1g9TCqmfB8nbmtZr71/p
        Qjx+uEvMFU6yJoVBfbFvjqE=
X-Google-Smtp-Source: AGHT+IEy1YVM+k76/k7sHjrEvJ2I9VtPmniChxu10UiPmEh5XOEZX1I4i/sNqFMuzVTFUlqoFOy4rQ==
X-Received: by 2002:ac2:4199:0:b0:506:8d2a:e31f with SMTP id z25-20020ac24199000000b005068d2ae31fmr14219474lfh.46.1697265348575;
        Fri, 13 Oct 2023 23:35:48 -0700 (PDT)
Received: from flex1911-laptop.. ([85.172.95.194])
        by smtp.googlemail.com with ESMTPSA id x9-20020a056512078900b00507a0098424sm302560lfr.109.2023.10.13.23.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 23:35:48 -0700 (PDT)
From:   Artem Borisov <dedsa2002@gmail.com>
Cc:     perex@perex.cz, Artem Borisov <dedsa2002@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS ROG GU603ZV
Date:   Sat, 14 Oct 2023 09:34:46 +0300
Message-ID: <20231014063458.13474-1-dedsa2002@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the SPI-connected Cirrus amp and the required pins
for headset mic detection.

As of BIOS version 313 it is still necessary to modify the
ACPI table to add the related _DSD properties:
  https://gist.github.com/Flex1911/1bce378645fc95a5743671bd5deabfc8

Signed-off-by: Artem Borisov <dedsa2002@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3eeecf67c..29c267ea3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9787,6 +9787,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1463, "Asus GA402X", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZV", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", ALC285_FIXUP_ASUS_HEADSET_MIC),
-- 
2.41.0

