Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97B57C9359
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjJNHvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjJNHvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:51:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FCAA9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:51:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso14822651fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697269864; x=1697874664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAkNMSkQh+HvBKSoXbMlmypmzhkJRtfMqEDqxnFHt7g=;
        b=ZnFMmmVfI+g96q282K7zps8SX/y5vXIrgXBIhWYXHmTg0myLLI9wuXgY8I+Kl7a6TL
         1iaXIz7K/VU5fKYt5d2XABvljxbm84aHwN0RY1PuEyXJlYBpcz25I/yp3Q0b3KZPYunn
         eNXDdi9Cu41WC30F4z+HQxdU91sXXyrv35W9fX53xyPG6FHoKXjdKI5kPHexlxsycjqc
         P7ml+AeFs636zt0lnAbvYJ2ZsBfYy+KCrTJ7wUBj8Xfg9/ldg51VOjdE/M/HghBL7b5r
         Dqf+AoFYjl+6kPSbamzVuEBMha8709Y4dYI+74Fx2IAUaOJjMEZ5OuXD9ggY4Xgl+kwu
         au7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269864; x=1697874664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAkNMSkQh+HvBKSoXbMlmypmzhkJRtfMqEDqxnFHt7g=;
        b=S9V2fDadxKvReAXd2axyQ2sEjBJZ0Sfg89QeOcdfBr+0WSdFote9rQ/HhnKDBqAwz+
         VNC4721T1NTtfXqQGMziQloWCur4uN6bTE4KoLR/3nB2DTiCcBRBxleGIccoq3X4P7jf
         oXvuxyFD9VInjpVqh7J0xRNX3YZaIw19yaBeuMb5+GjGKvtS71Cw8nyiHTdmfZWvJPRx
         vEBdp24VR2JKpFJE90AtsnI87DvEXbUlBaiCs5aibxPI5NwqUlTdDOkoAOWLJh42aapf
         qYWfyERz6eVmQb51T+5stISm5e8kq1UaNcCoFBDU8uNbG5TmS0uTEBVTqh8MidDiZXCy
         2j7Q==
X-Gm-Message-State: AOJu0YxF3/faDsE7QIRgUiakkJDSZT2SLezZ1zVDj/hDbdIFn/+Z7VG3
        lmAkxVrI96AGSWqWQCKb9P+YH9cXBD5q0w==
X-Google-Smtp-Source: AGHT+IHsuK/Nk9iKAhUC1I31QMSbJkHYF+ZoPMbFtuPmMv9zQ3vPJUkdc7N/1Jw43iEM+nLw4Y6oYw==
X-Received: by 2002:a05:6512:b99:b0:503:2623:7cfa with SMTP id b25-20020a0565120b9900b0050326237cfamr30129817lfv.35.1697269863755;
        Sat, 14 Oct 2023 00:51:03 -0700 (PDT)
Received: from flex1911-laptop.. ([85.172.95.194])
        by smtp.googlemail.com with ESMTPSA id m12-20020a056512358c00b004fe333128c0sm467685lfr.242.2023.10.14.00.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:51:03 -0700 (PDT)
From:   Artem Borisov <dedsa2002@gmail.com>
Cc:     perex@perex.cz, Artem Borisov <dedsa2002@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for ASUS ROG GU603ZV
Date:   Sat, 14 Oct 2023 10:50:42 +0300
Message-ID: <20231014075044.17474-1-dedsa2002@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014063458.13474-1-dedsa2002@gmail.com>
References: <20231014063458.13474-1-dedsa2002@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 3eeecf67c..e92b3083a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9791,6 +9791,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
+	SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZV", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
-- 
2.41.0

