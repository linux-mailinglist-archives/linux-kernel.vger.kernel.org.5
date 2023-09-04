Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDCF791794
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbjIDMxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjIDMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:53:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA98189
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:53:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso1873424a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693831994; x=1694436794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT/Nsm0+xhrnJ3oLep6HRqQXVpm9RtDxMX2PP4BVgnA=;
        b=QGHVfZZ9JFkuDA1sj0VvnBh6xkXDomJVp8/IaYRq44df7rdSu+GFjMyayz46fDqCbK
         Qh7BlsmV154EVgHLXaCqABbWeQGtC7bLAbe8O6oKvR8R0hg1LeckNKiD/Syg+LBv/hdA
         3fr8LQyIsb7GzEUS+TaPiaPAY/34dsGmW1vOamR66ER8FOTKIHYujrvMpIEgcoPRexvP
         xXLVKNSDeTDg/8vsYfot0EINi06CsJ72k9ekv51Qx85SFlA5QeftHIs37Xc0bC9821CL
         bonuxNj5AnLFwbyerD+FwMy2O6SDJKXACCHJgzI759/+xMvjmH66gqoj+9z8dqAUJ0bx
         ZVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693831994; x=1694436794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nT/Nsm0+xhrnJ3oLep6HRqQXVpm9RtDxMX2PP4BVgnA=;
        b=ARMvrSVwD1d2gghzGkaoqqoD3RjBj/REud202vVXoTWpnjcLs7pysMjWsg0UiF1Q3V
         JFEHREjU432n3bxAauQiiZXzqtuRgtFX0eHozPaXW13AvgJpgeOLl67TLBzCAFFgbX2U
         duYcf1Qmb3yD2gnQBT3ACaTJlWtXSCk/SQJiHoRFo68ayyEnJJ0Towl41umHaLoFrr2V
         q5QM5m3wkt/tTZdRPUjK8Y6vCwtn+/FA0/SGzeCzyrLpjvGY24kyizVoDWZY+0gWVOS2
         qPM9BPDy/L6ylyel4J6PFIWCzBcUo0LPwYfKeu20/9Zq99MFl3ppMLYaGLNqru4lTEwl
         M67A==
X-Gm-Message-State: AOJu0Yz6B0jRrnHHR8lIGJknMGdw2gW0Yq7qzWSPR3S9ykHGoCoLFyKE
        53ygPy0IzBTQg9jMConLNJAYgQ==
X-Google-Smtp-Source: AGHT+IHnB7mmvYoAltpY3Nq7Rp02IggESKr6lMKP3eXswf6fDDpABlrG61QCjRJqkfOiUEboGtGyMA==
X-Received: by 2002:a50:fb19:0:b0:523:41e1:705e with SMTP id d25-20020a50fb19000000b0052341e1705emr6472621edq.21.1693831993961;
        Mon, 04 Sep 2023 05:53:13 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id r14-20020a056402034e00b00523d2a1626esm5836842edw.6.2023.09.04.05.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 05:53:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     wangweidong.a@awinic.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ASoC: aw88395: drop undocumented, fake fade-enable property
Date:   Mon,  4 Sep 2023 14:53:08 +0200
Message-Id: <20230904125309.43350-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
References: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Devicetree fade-enable property was never accepted and is not
allowed by bindings.  It is not used by any upstream user, thus
considering that it was never documented, should be dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/aw88395/aw88395_device.c | 44 -----------------------
 1 file changed, 44 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395_device.c b/sound/soc/codecs/aw88395/aw88395_device.c
index 33eda3741464..19422fc9017d 100644
--- a/sound/soc/codecs/aw88395/aw88395_device.c
+++ b/sound/soc/codecs/aw88395/aw88395_device.c
@@ -290,30 +290,6 @@ void aw88395_dev_set_volume(struct aw_device *aw_dev, unsigned short set_vol)
 }
 EXPORT_SYMBOL_GPL(aw88395_dev_set_volume);
 
-static void aw_dev_fade_in(struct aw_device *aw_dev)
-{
-	struct aw_volume_desc *desc = &aw_dev->volume_desc;
-	u16 fade_in_vol = desc->ctl_volume;
-	int fade_step = aw_dev->fade_step;
-	int i;
-
-	if (!aw_dev->fade_en)
-		return;
-
-	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
-		aw_dev_set_volume(aw_dev, fade_in_vol);
-		return;
-	}
-
-	for (i = AW88395_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
-		aw_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_in_time, aw_dev->fade_in_time + 10);
-	}
-
-	if (i != fade_in_vol)
-		aw_dev_set_volume(aw_dev, fade_in_vol);
-}
-
 static void aw_dev_fade_out(struct aw_device *aw_dev)
 {
 	struct aw_volume_desc *desc = &aw_dev->volume_desc;
@@ -567,7 +543,6 @@ void aw88395_dev_mute(struct aw_device *aw_dev, bool is_mute)
 	} else {
 		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
 				~AW88395_HMUTE_MASK, AW88395_HMUTE_DISABLE_VALUE);
-		aw_dev_fade_in(aw_dev);
 	}
 
 	if (ret)
@@ -1607,24 +1582,6 @@ static void aw88395_parse_channel_dt(struct aw_device *aw_dev)
 	aw_dev->channel = channel_value;
 }
 
-static void aw88395_parse_fade_enable_dt(struct aw_device *aw_dev)
-{
-	struct device_node *np = aw_dev->dev->of_node;
-	u32 fade_en;
-	int ret;
-
-	ret = of_property_read_u32(np, "fade-enable", &fade_en);
-	if (ret) {
-		dev_dbg(aw_dev->dev,
-			"read fade-enable failed, close fade_in_out");
-		fade_en = AW88395_FADE_IN_OUT_DEFAULT;
-	}
-
-	dev_dbg(aw_dev->dev, "read fade-enable value is: %d", fade_en);
-
-	aw_dev->fade_en = fade_en;
-}
-
 static int aw_dev_init(struct aw_device *aw_dev)
 {
 	aw_dev->chip_id = AW88395_CHIP_ID;
@@ -1639,7 +1596,6 @@ static int aw_dev_init(struct aw_device *aw_dev)
 	aw_dev->fade_step = AW88395_VOLUME_STEP_DB;
 	aw_dev->volume_desc.ctl_volume = AW88395_VOL_DEFAULT_VALUE;
 	aw88395_parse_channel_dt(aw_dev);
-	aw88395_parse_fade_enable_dt(aw_dev);
 
 	return 0;
 }
-- 
2.34.1

