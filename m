Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B27E1E90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjKFKk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:40:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD78123
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:40:22 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso630841366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699267221; x=1699872021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbjwm+H7hl2EuKWl07XyZwpvz3KlHSIgvjF5mlsdjpY=;
        b=HzgAQoReIO7E2ynjMLhUeBp/tgKupCoSNcnxbeOi+O9/8kI+0PZNPwWGK1Nag+gc18
         I1tsN4syUu33mGGZ4/Jdsjy7Ibc8wOGvHRXgZDPgJt4LIuwlUfPbJTTK13ldn3BvH07Z
         ArqHF9AeaHWwWai8zVdxdiAshy678NmRAAz1lFU2oFzF4lITWRwD5Q3pBKy8Ej2AxedY
         0PigVGF+ju5g9qDw+DK/oGwGgEoO0Fp5x3P/sCSeK1o/wAm8FOd2ThE0kzYLnNXgQC87
         kYNTi8RXKFWNpL08R5aO20Twxhf5aW+6PRJWZMnd9XZsAjZ9koORHrWwUjhSG9qtRbY7
         IXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267221; x=1699872021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nbjwm+H7hl2EuKWl07XyZwpvz3KlHSIgvjF5mlsdjpY=;
        b=RyYcSnWyCcR9Qx2Kd6yLCX4+MoP/zFDkPvnrleH3ftKqNwKc4v4t1X3avNdDnDh8Jo
         3wC3ftiSCmcc3B1bLwVHzK+hhUPZgBCI7R62GsXdBZJZmsVS/8EB2obBTL12W8mtq8jN
         Ft1ITiS18257uxbV/AM1UEw0NoINLfhjESakPKOTQWXPVAfApEv3KYuvLJwY7VItvjD7
         NTyT6WSbGUQAyXJ4zsBDGoAaAoQn8Q+lPB62/1YXvLK+EOfL7OD6AlDu3GObpJoX7mLC
         +2XUIcQ9z0+yXnWZgtSbWTbcugjJC46S9KbCHBhqTfmFjCo6m8Gx7G6skwU1vzI0PqPb
         DdfQ==
X-Gm-Message-State: AOJu0YyA7IkQxmVFVKgFAeeoiV1kzh29zd3UWyyAoDXzpeh1gSbzR7fN
        6oAMCdxKMaeCRQZcIkxFL5hNho1hCJ5I1Q/Uq/A=
X-Google-Smtp-Source: AGHT+IFQSEFW+kjzHL4YbOTboiy3Yei2pf8q/XEntCqWzMhAJfuTxx5YjXpbFrmK/nM3l/YHOn5kig==
X-Received: by 2002:a17:906:d554:b0:9ae:5db5:13d with SMTP id cr20-20020a170906d55400b009ae5db5013dmr14948952ejc.72.1699267221002;
        Mon, 06 Nov 2023 02:40:21 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fabf:ec8c:b644:5d3])
        by smtp.googlemail.com with ESMTPSA id jg2-20020a05600ca00200b004065daba6casm11876137wmb.46.2023.11.06.02.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:40:20 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdmi-codec: register hpd callback on component probe
Date:   Mon,  6 Nov 2023 11:40:11 +0100
Message-ID: <20231106104013.704356-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI hotplug callback to the hdmi-codec is currently registered when
jack is set.

The hotplug not only serves to report the ASoC jack state but also to get
the ELD. It should be registered when the component probes instead, so it
does not depend on the card driver registering a jack for the HDMI to
properly report the ELD.

Fixes: 25ce4f2b3593 ("ASoC: hdmi-codec: Get ELD in before reporting plugged event")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 09eef6042aad..20da1eaa4f1c 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -877,18 +877,13 @@ static int hdmi_codec_set_jack(struct snd_soc_component *component,
 			       void *data)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
-	int ret = -ENOTSUPP;
 
 	if (hcp->hcd.ops->hook_plugged_cb) {
 		hcp->jack = jack;
-		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
-						    hcp->hcd.data,
-						    plugged_cb,
-						    component->dev);
-		if (ret)
-			hcp->jack = NULL;
+		return 0;
 	}
-	return ret;
+
+	return -ENOTSUPP;
 }
 
 static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
@@ -982,6 +977,21 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 	return ret;
 }
 
+static int hdmi_probe(struct snd_soc_component *component)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	if (hcp->hcd.ops->hook_plugged_cb) {
+		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
+						    hcp->hcd.data,
+						    plugged_cb,
+						    component->dev);
+	}
+
+	return ret;
+}
+
 static void hdmi_remove(struct snd_soc_component *component)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
@@ -992,6 +1002,7 @@ static void hdmi_remove(struct snd_soc_component *component)
 }
 
 static const struct snd_soc_component_driver hdmi_driver = {
+	.probe			= hdmi_probe,
 	.remove			= hdmi_remove,
 	.dapm_widgets		= hdmi_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
-- 
2.42.0

