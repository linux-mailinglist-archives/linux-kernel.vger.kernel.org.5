Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6175742C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGRG3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjGRG3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:29:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F4E1A2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:29:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so4972438f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689661757; x=1692253757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAeQ4NbbgGFcD9JBeX4FN3v1hTlLMoB8w+Nqk5+LPgc=;
        b=oXYdl1zeFawWhaCKCD55sg0CO8eoGAlf2XrJ4xXa7co+QihGkf1be5/MvFCYYngI9y
         XnF2+gY4yBfTmjwFRlgH7IN/EX515PHyvhMVWQX1LYAfizcJ5PM1+LhzAPam8cdabBjU
         ZeOLfzWH8dafKL5Laau/Yz9ZdIyAtW3QYSSafMgdSlQJv5Wmny53ow+YW7ND+bNoBNBH
         atx+t65K6KtM4l/LVRQBmYBqAiG3saFyzvxdN0oQBKO9VkoGSlHkvAOiFjbsQyFo2xIp
         lkajyAmXSqpYwJLGmjESW/FP2vdfpvDlRD3z6YwxiM9/Cc+OP+jFyhRKtw7iockhWp/E
         IpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689661757; x=1692253757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAeQ4NbbgGFcD9JBeX4FN3v1hTlLMoB8w+Nqk5+LPgc=;
        b=bxsJIPw5NkML4UPk59d2hXIItnY/WPSsUjA7iMcMlh0hL8pvWWUdjUGZPWd8FUkfDj
         lqeijDN96LVxQvfUXV5TZT/ZzGCXTg+nZbhsUmrXacZ7RLrqdUCsuf1MAzQ1h/nGwKBb
         6cCAaKrls3jpvONPPybyisW94sRgKet8ABuCJvGN+Fe2msZkI7+JLbE4WVi+2XB44mT9
         x0Sx73laH3zA8YRes7C0hL3W7XgDs08KE9rIEcy5qQfaNBi9oZSaczMqNmI82KPah9ti
         OcLuZRMu2g+BAGAeAwmm3D7WKOD55gIxkms4YBphL6Z74szsp0PHg7zZtlyziRNmXNYj
         A3Tg==
X-Gm-Message-State: ABy/qLZ5TDcz4tBSZs3c5O2gmWHLDoWgrh2AIBaI4/E01OipTTHQrs5K
        6Qte3Rd7m8zqPbTWQzJW+LU2cEIV4u/tgxnnNTI=
X-Google-Smtp-Source: APBJJlEPLcwDYofG6fDLbjqHRa7a8NK49KAn6Exd15b3+OITzR2XGhiWxrfcRQGOTX0sSrk4er0z+Q==
X-Received: by 2002:a5d:46c9:0:b0:314:14ea:e2db with SMTP id g9-20020a5d46c9000000b0031414eae2dbmr10077513wrs.0.1689661756708;
        Mon, 17 Jul 2023 23:29:16 -0700 (PDT)
Received: from neptune.lan ([188.27.131.236])
        by smtp.gmail.com with ESMTPSA id v12-20020adfedcc000000b00314315071bbsm1383651wro.38.2023.07.17.23.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:29:16 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     architt@codeaurora.org, bogdan.togorean@analog.com,
        nuno.sa@analog.com, daniel@ffwll.ch, airlied@gmail.com,
        jonas@kwiboo.se, Laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, festevam@gmail.com
Subject: [PATCH V2] drm: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Tue, 18 Jul 2023 09:28:54 +0300
Message-ID: <20230718062854.29875-1-alex@shruggie.ro>
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
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---

Changelog v1 -> v2:
* https://lore.kernel.org/dri-devel/20190716131005.761-1-bogdan.togorean@analog.com/
* added Fixes: tag
* added Reviewed-by: tag for Nuno

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index ddceafa7b637..09290a377957 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+			0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+			0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
-- 
2.41.0

