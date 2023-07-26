Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87708764234
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGZWhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGZWhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:37:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D92728
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:37:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe0e201f87so339150e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690411054; x=1691015854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGSL9ovzDnY/qWwvHfekKpbaCjtrY147m2RUqDvJEJw=;
        b=S3vkQNY0jsJjcKrFvp/cfyfPBQ7ENNJyBLEhthOtYWIAs9JDxhVwdNE2GolvfkRqp5
         nN8wQcznG2FS7hiK53CGvOwIkTW14sFIs95MIGfkXWFLxKoYrkvV/HLf71XGKQTmb5He
         FoCNGjQNWUPLDCUsQ6IAlkYQT+zRTXtq/tZJYUpBFlfLd9AGXh/AhFgdArZaWN+/QPNh
         s2VmyNWqEAdWn1s1jR7I4ZSgwWedOttUgDcZLYVydKm8/DXu4AeeKfZIugkvUptEBfxx
         kfmM0aVh1je1bartJ9k1eDyyD8oDlg4LRP170XHhKXItYSEXjrawaq66z5B+kDgskmhk
         X6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690411054; x=1691015854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGSL9ovzDnY/qWwvHfekKpbaCjtrY147m2RUqDvJEJw=;
        b=XJDIhUKvGcSz/sFYGSUbdKrcMCuHWRsihDy2qqsGdrfODPzyCdunEzsEblROta8roV
         AcJyw4OWybMflZJHY7UXpZUVxlbnlkafE8AMbmcflmWyI5tC3z6HndBQcTWnFPxrp7Vo
         FoQTE8JPBoRqG5MuItzyu1vn6DKqL3uO9+kEsyzrihEotDMCdeS1EbI1zIUj513jfo+D
         +/+Ph4YHvONqsVsUgjBrVKh0EBYVOKJvfx9QtDpG7bGu4IGiXsXqZYg5l8F1bgknJna1
         nA6tTfswueuECz+1SQWqVx1O9fvVXqMLBNnyEBXVvpalO6T4EuLlyL1sFxvRyo1fCqOQ
         x7yA==
X-Gm-Message-State: ABy/qLaO8RZrb6j8ZRv2OHH3aC0d9XSFl14yFQ86dXANFu/cgYHGh9KA
        4/3hwmRaMFCLQdSyv0AWUcw=
X-Google-Smtp-Source: APBJJlF3jnov8dvwO1q1GSxtXvRFx+TC5V6cAhir8w5e68d6x63k8pm2gB2Yj+EXgIP3EoaZVBrJCw==
X-Received: by 2002:a05:6512:304b:b0:4fb:8aca:6bb4 with SMTP id b11-20020a056512304b00b004fb8aca6bb4mr113032lfb.20.1690411054343;
        Wed, 26 Jul 2023 15:37:34 -0700 (PDT)
Received: from foka.. (109-252-121-22.nat.spd-mgts.ru. [109.252.121.22])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25a19000000b004fe061269edsm17611lfn.249.2023.07.26.15.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:37:33 -0700 (PDT)
From:   Pavel Asyutchenko <svenpavel@gmail.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "Luke D . Jones" <luke@ljones.dev>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Support ASUS G713PV laptop
Date:   Thu, 27 Jul 2023 01:37:32 +0300
Message-Id: <20230726223732.20775-1-svenpavel@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This laptop has CS35L41 amp connected via I2C.

With this patch speakers begin to work if the
missing _DSD properties are added to ACPI tables.

Signed-off-by: Pavel Asyutchenko <svenpavel@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7c0f474ea3b3..dff92679ae72 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9680,6 +9680,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c9f, "ASUS G614JI", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1d1f, "ASUS ROG Strix G17 2023 (G713PV)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402", ALC245_FIXUP_CS35L41_SPI_2),
-- 
2.39.2

