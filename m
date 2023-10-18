Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138C17CEC78
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjJSAAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSAAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:00:17 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE67FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:00:15 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a66bbb6c1dso54199739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697673615; x=1698278415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1HJODpBcMbzB2tUXUZxawzk68qAf00Djnx9IKBN0d8=;
        b=X2gC2r7UGG5y4Sc+EB+khOWcAme3Evcmh7hybtMMjds4baAKWqOTuGYOxkwMyo6YuV
         X1+FoNnzIuP7LbNcRsdDKJUMUpYuznFYROGwsXaLO6nkLpKU8KXJxa1A4kbrOtTwvv7o
         HK+weMKR4tTmMG+x90lG9C0nbAhxYSYvmhVys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697673615; x=1698278415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1HJODpBcMbzB2tUXUZxawzk68qAf00Djnx9IKBN0d8=;
        b=P8jnMV50oYwQz7hE9VApO/rRAnvtf3dR85PPX+oWbEU7x3B1l742SKZqKpryzZro2Z
         0dVKWzWOvDknBwpSS1cAcxcycVyDvND2cAsnuZd7fbK1F3jvb4gSays/QEz72RTuBeBQ
         i+bp9eMbPmZtX+LnhhBiXG/GKmiN5WHJi58MQm6frPAx6S2o1wFc06QfwC8mHdOzlfSF
         Y8KWUm/ivTqoxIWH+AzibdRqPaCv38xrFkgamXQqAR9Rz8SDbYu/rUQQWIpnjaYaZh5l
         b9HfC37eCKsqot5I58kqo2Ap13wdMwtR2PG7RHFDrAsrU3AdQt7Y+I9qDAN7pvBny6xM
         Bbog==
X-Gm-Message-State: AOJu0YyrBFQWsX1Ur9ImkeFlgtR7JiXmG1ypCjHsMUCD6q1r9bQw+uxg
        K6jIflkchEz8/0TaxNC9Q2lzoiXx8suCwvN1BDQ=
X-Google-Smtp-Source: AGHT+IGb7/9XyHJU8tJSJRr+AOTGRuQiAjyMLpKpxv6aUrSVC/zA8mgpnLR6nLEsyXT+SILta4xVUA==
X-Received: by 2002:a05:6e02:2146:b0:351:e6e:7723 with SMTP id d6-20020a056e02214600b003510e6e7723mr1072598ilv.25.1697673614869;
        Wed, 18 Oct 2023 17:00:14 -0700 (PDT)
Received: from markhas1.lan (71-218-45-6.hlrn.qwest.net. [71.218.45.6])
        by smtp.gmail.com with ESMTPSA id z15-20020a92da0f000000b003512c3e8809sm1425870ilm.71.2023.10.18.17.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:00:08 -0700 (PDT)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Mark Hasemeyer <markhas@chromium.org>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brady Norander <bradynorander@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v1] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
Date:   Wed, 18 Oct 2023 17:59:31 -0600
Message-ID: <20231018235944.1860717-1-markhas@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Jasperlake Chromebooks overwrite the system vendor DMI value to the
name of the OEM that manufactured the device. This breaks Chromebook
quirk detection as it expects the system vendor to be "Google".

Add another quirk detection entry that looks for "Google" in the BIOS
version.

Cc: stable@vger.kernel.org
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 sound/hda/intel-dsp-config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 24a948baf1bc..756fa0aa69bb 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -336,6 +336,12 @@ static const struct config_entry config_table[] = {
 					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
 				}
 			},
+			{
+				.ident = "Google firmware",
+				.matches = {
+					DMI_MATCH(DMI_BIOS_VERSION, "Google"),
+				}
+			},
 			{}
 		}
 	},
-- 
2.42.0.655.g421f12c284-goog

