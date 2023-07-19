Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836C4758D60
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGSGCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGSGCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:02:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FB11BF5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:02:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso65378465e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689746531; x=1690351331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkZLqHE3iVHOICOh6iAIAdodJXBEtzaLjqYAOg31flE=;
        b=yUCW3tkG/kSrvrobap4JiXMH8bgw20XFnode3DLpSUy/YVixR82w6c6+lRxBm4iEYF
         6iBoT6Z2CIZhey3wj7kGeNAKmkonTtRpuCaeKXGBLSS1cS0kQB0+OG8SU3M8qdhB3TIv
         ripPSqSPZEQ+ztjs+G+1P3ZhyxY3hjw9IzBXbgUvLQdF6twnq56bgCVzVFyBfefEi+oV
         /povO4vBPvB9FFpaDMdbyV6sZQAA4l0hzVTXBcKlEPna4D4pftPBOhzfd2QOy5s/ETYO
         xR+/7iemVrRv0oLI7sLOX7xaV90JHETAixZ8o5W3SsNMlcV9cLFFhyiAdTBtSYvhJ3T2
         R8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689746531; x=1690351331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkZLqHE3iVHOICOh6iAIAdodJXBEtzaLjqYAOg31flE=;
        b=etsFfpLTz/tgzYLSoY8FHzWawGvbfHFZcrVq/qfzC4Uv8FEpLyT8Aaj7V1aB8EgZJw
         01iey6H82rclu/ZwfZdVrSLA4N62TWEzTTOwzy50n2BYKayrLDRXQj5x4vgbh1hnik+T
         RXo8echCflVYAOdwyo0LM98zuvQP/mn9AWNGU72Q4cJbyU1QW75zkN2MlM5PVkPP8NWc
         vQXRGrQXAf5zlZwaC5I0s7JohucGrJKyXbCZ832L2VvXwfPMDEEJFeiRyounkGkUDszN
         y5mAABVNjeDrgkdnGmehPqjZWobPFkSHKveLp7AUzYXMzslNbUF+BzZ8KsUneTfkHrCf
         HX9g==
X-Gm-Message-State: ABy/qLZ+Y4N1p6klBX0wc4cQ8c2vC+joSHbosbOh4KFeXsR5qXWOR9fc
        SNZXErhYAlFYsRAr5gjc0XuJEgl9qlnjvVW0u4E=
X-Google-Smtp-Source: APBJJlFNnbcKke5LjjHKOrAdLuk8o4o26cCL+2RmiJVUqSqhIj6KqvH+eK/zo7+p++ydqyIlDYQrbQ==
X-Received: by 2002:a05:600c:2253:b0:3fb:a937:6024 with SMTP id a19-20020a05600c225300b003fba9376024mr3604367wmm.29.1689746531235;
        Tue, 18 Jul 2023 23:02:11 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.168])
        by smtp.gmail.com with ESMTPSA id q13-20020a1ce90d000000b003fa95890484sm810119wmc.20.2023.07.18.23.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:02:10 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     bogdan.togorean@analog.com, nuno.sa@analog.com, daniel@ffwll.ch,
        airlied@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, rfoss@kernel.org,
        neil.armstrong@linaro.org, andrzej.hajda@intel.com,
        festevam@gmail.com, Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v4] drm: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Wed, 19 Jul 2023 09:01:43 +0300
Message-ID: <20230719060143.63649-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20190716131005.761-1-bogdan.togorean@analog.com>
References: <20190716131005.761-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bogdan Togorean <bogdan.togorean@analog.com>

For ADV7533 and ADV7535 low refresh rate is selected using
bits [3:2] of 0x4a main register.
So depending on ADV model write 0xfb or 0x4a register.

Fixes: 2437e7cd88e8 ("drm/bridge: adv7533: Initial support for ADV7533")
Reviewed-by: Robert Foss <rfoss@kernel.org>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index ddceafa7b637..8d6c93296503 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+				   0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+				   0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
-- 
2.41.0

