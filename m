Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7007E7F82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjKJRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjKJRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:26 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165D53A223;
        Fri, 10 Nov 2023 07:07:45 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso29238731fa.1;
        Fri, 10 Nov 2023 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699628863; x=1700233663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUYUCcdtTvLVENF71fNoj/iwjtIo/19Ig1fuze9y2zQ=;
        b=erK0ZRlSbBpHNXPD31Wbg069kySyLAJk5fd2xq6ZZwiGMdpkODGmzV5mObCHdc+cC3
         I/07xkOfTW3hIKKO4rjh4eRPGYpOFplr1irTdGXYuzxFY5vjFOFT/eIGZho8etyy1q03
         vHGAmnTKna+Z0eEIAmJJkySCclrlntYpCmFgOwTTCK44i0HGanPSDl5a+OwoB0RcMeuB
         VNT/fgH4aOFz+qQ4kJyspxxhi4zBc0sJdk486/s9ukkJJOpMPUU5OS0Eurc2T3fSO8A3
         v7VMz5XjqwsuM/b+ackk25pPrdo3QKxonu/f4LjgTof9CETGxsnZNwSFhZhy3jkv1Z4w
         V2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699628863; x=1700233663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUYUCcdtTvLVENF71fNoj/iwjtIo/19Ig1fuze9y2zQ=;
        b=Unf2G5PoFfUmk670Ghysf+oPMD4N9MBDN97R1+8Om4fLGec//FV8O3Vs4rZpObQ+1v
         F03NPfkXEUBYdj6PJVO/NQIeDICqRhsxtIFrSV3S+CsydvVw7kAjW0TJZirC7ztOMelw
         /eC6aS/ZCR1oQKwdLzJuupmiVVRmtLWcPDwabyfx04CMHhq2ci+/qqHavnRJoJtlWsEF
         uS7Zivud0vnMycf4L2NnTib5VJ2brvl9ILR0Xg6HmSEwvjykZoL1hXSEVq2WqBizE7EA
         /TM/9i+5NI+Y6IlLUs6BvdNHyL0aqTtVFyuKWvPbNjsItR2T8Z46RrXtnPJ/J7PGGVSh
         GQ8Q==
X-Gm-Message-State: AOJu0YxFPyCEb+MD9dyyiu5qV+0ZgstU3ZbaGGfjS3CXK5oh1xm3gPN3
        MvjG/ORuwtkEf51/MX7rWpg=
X-Google-Smtp-Source: AGHT+IHcYTTwQnBVR0JOTyt+yoUrnZIm91B/VqhEYppHkYrKc6ewD1oU+hohyhmom061chzMLDRwpQ==
X-Received: by 2002:a2e:bd02:0:b0:2bf:e596:36f9 with SMTP id n2-20020a2ebd02000000b002bfe59636f9mr7978407ljq.13.1699628863059;
        Fri, 10 Nov 2023 07:07:43 -0800 (PST)
Received: from localhost.localdomain ([176.40.228.182])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c4a1500b004095874f6d3sm5300372wmp.28.2023.11.10.07.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 07:07:42 -0800 (PST)
From:   Eymen Yigit <eymenyg01@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eymen Yigit <eymenyg01@gmail.com>, Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP 255 G8
Date:   Fri, 10 Nov 2023 18:07:15 +0300
Message-ID: <20231110150715.5141-1-eymenyg01@gmail.com>
X-Mailer: git-send-email 2.42.1
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

This HP Notebook uses ALC236 codec with COEF 0x07 idx 1 controlling
the mute LED. Enable already existing quirk for this device.

Signed-off-by: Eymen Yigit <eymenyg01@gmail.com>
Cc: Luka Guzenko <l.guzenko@web.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 58006c8bc..efe8935af 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9801,6 +9801,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896d, "HP ZBook Firefly 16 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896e, "HP EliteBook x360 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.42.1

