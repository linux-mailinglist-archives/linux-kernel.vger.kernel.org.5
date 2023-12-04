Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9C802A90
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjLDDgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 22:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDDgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:36:17 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7CF0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 19:36:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d075392ff6so9943545ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 19:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701660983; x=1702265783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5ibrbomcT4ATNS9nyIlTVVNkugyqaWArhiAt2NcI7E=;
        b=GOwZQPMWolQUDwI+RNcYTupF1MEBx3oijYcofmTpymLia4uirxdvBZlGcug6fxYDjI
         FbgkxF7pSykD9aHj6kDdZIotwilI9pRaeGfDwUGy8s6bzsS2e8vwPz5zV7+yHikFxp5j
         /vAVt4G9l5xoN1L8FXH1RMzjlTk7pMwmE0occ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701660983; x=1702265783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5ibrbomcT4ATNS9nyIlTVVNkugyqaWArhiAt2NcI7E=;
        b=cLoo92hxC+gd779sXxbtyOqvjz0gLfDtmmklcpfzlPNyL8EnCy8pc5junel9PqhToo
         5R8yelUAgT+1JoA4DQtfgUMOeJ1jXUTDFyAoGZUqHGcypo+7hBQ2dyLTu/GI4kMm68rp
         OkdZMC8G8hKEJrSlLk2d6z55St0/CcgrHrexUa3ITJg4RJM6GjIu0zVWOsDXToa9fvLT
         LjQBiiLElrmS4kFxtsYBSTpuWjMJC6fASWZJjRjD7nPHbmkRDyK2jPVmFaC08Sx4NMRz
         UnsCPWFOmibaLafSHlzoUc8MUOnoqEItVz9bdHcUVH7W+hxOAmCsBiqPSErrsGsIvaib
         YZwA==
X-Gm-Message-State: AOJu0YzdVBhI04QD/eueOIgiMWSm5TLYxzokJ6mqe41Id5Hr23anWdrO
        7qoMi9DU8EawV9LjhxsmLEOGZw==
X-Google-Smtp-Source: AGHT+IFZTY4dVLtssG9DSiQOUbrB/mzi7KeJYm1iIYwTC7L32KetX2MXXsk2TMWkTQqjGPuu867XrA==
X-Received: by 2002:a17:902:d50f:b0:1d0:68a:4a12 with SMTP id b15-20020a170902d50f00b001d0068a4a12mr3795878plg.15.1701660983115;
        Sun, 03 Dec 2023 19:36:23 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6084:72e2:9ac2:f115])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001d0447e7fdasm6512178plw.269.2023.12.03.19.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 19:36:22 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Move sof_of_machine_select() to core.c from sof-of-dev.c
Date:   Mon,  4 Dec 2023 11:35:47 +0800
Message-ID: <20231204033549.2020289-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
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

This reverts commit 014fdeb0d747304111cfecf93df4407c1a0c80db.

Commit 014fdeb0d747 ("ASoC: SOF: Move sof_of_machine_select() to
sof-of-dev.c from sof-audio.c") caused a circular dependency between
the snd_sof and snd_sof_of modules:

	depmod: ERROR: Cycle detected: snd_sof -> snd_sof_of -> snd_sof
	depmod: ERROR: Found 2 modules in dependency cycles!

Move the function back with sof_machine_select().

Fixes: 014fdeb0d747 ("ASoC: SOF: Move sof_of_machine_select() to sof-of-dev.c from sof-audio.c")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Not sure what the proper arrangement would be, but this gets my builds
going again.

 sound/soc/sof/core.c       | 22 ++++++++++++++++++++++
 sound/soc/sof/sof-of-dev.c | 23 -----------------------
 sound/soc/sof/sof-of-dev.h |  9 ---------
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index a2afec8f5879..425b023b03b4 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -144,6 +144,28 @@ void sof_set_fw_state(struct snd_sof_dev *sdev, enum sof_fw_state new_state)
 }
 EXPORT_SYMBOL(sof_set_fw_state);
 
+static struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *sof_pdata = sdev->pdata;
+	const struct sof_dev_desc *desc = sof_pdata->desc;
+	struct snd_sof_of_mach *mach = desc->of_machines;
+
+	if (!mach)
+		return NULL;
+
+	for (; mach->compatible; mach++) {
+		if (of_machine_is_compatible(mach->compatible)) {
+			sof_pdata->tplg_filename = mach->sof_tplg_filename;
+			if (mach->fw_filename)
+				sof_pdata->fw_filename = mach->fw_filename;
+
+			return mach;
+		}
+	}
+
+	return NULL;
+}
+
 /* SOF Driver enumeration */
 static int sof_machine_check(struct snd_sof_dev *sdev)
 {
diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index fa92da5ee9b3..b9a499e92b9a 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -41,29 +41,6 @@ static void sof_of_probe_complete(struct device *dev)
 	pm_runtime_enable(dev);
 }
 
-struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev)
-{
-	struct snd_sof_pdata *sof_pdata = sdev->pdata;
-	const struct sof_dev_desc *desc = sof_pdata->desc;
-	struct snd_sof_of_mach *mach = desc->of_machines;
-
-	if (!mach)
-		return NULL;
-
-	for (; mach->compatible; mach++) {
-		if (of_machine_is_compatible(mach->compatible)) {
-			sof_pdata->tplg_filename = mach->sof_tplg_filename;
-			if (mach->fw_filename)
-				sof_pdata->fw_filename = mach->fw_filename;
-
-			return mach;
-		}
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(sof_of_machine_select);
-
 int sof_of_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/sound/soc/sof/sof-of-dev.h b/sound/soc/sof/sof-of-dev.h
index 547e358a37e3..b6cc70595f3b 100644
--- a/sound/soc/sof/sof-of-dev.h
+++ b/sound/soc/sof/sof-of-dev.h
@@ -16,15 +16,6 @@ struct snd_sof_of_mach {
 	const char *sof_tplg_filename;
 };
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_OF_DEV)
-struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev);
-#else
-static inline struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev)
-{
-	return NULL;
-}
-#endif
-
 extern const struct dev_pm_ops sof_of_pm;
 
 int sof_of_probe(struct platform_device *pdev);
-- 
2.43.0.rc2.451.g8631bc7472-goog

