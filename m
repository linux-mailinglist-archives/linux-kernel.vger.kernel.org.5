Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB17E4A07
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjKGUqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjKGUqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:46:21 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5A3137
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:46:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b2018a11efso6250069b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699389979; x=1699994779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfxpAYOWmleR8K355O3R14aCnteWRdFE5O9l2OhvQSo=;
        b=Ijk4D8eubXCqvIJ7oCth+BKcSlqrIyOBDb+81HvzbcDSwPmwEO20vW9pLMBF3dXe3l
         ukJFoqQBVhMj31s164Qj/8vpF/sQ+O25/AgTb29uf0m9NzZMuAB6FbK92Ir1AiEbuRbo
         bhUWSbALuI05aLJejgTBnyRCFq2XlJ0UoFh5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389979; x=1699994779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfxpAYOWmleR8K355O3R14aCnteWRdFE5O9l2OhvQSo=;
        b=RcnYJ2ZmlryxCLwN1JObpq60AY9MRZq8x7T8jdXukm9DavU21Nb00X7Sbk81F0v+a3
         QRVPa3PB2spigCY1h1Tse2BgFuKzUpjVHtbL0ZsqkoJjRD3/2I2kO/Xc3PO0k4QZkqQG
         iDM5hX4InEnButSjUdvbb7cOrU5ifyWXyqbuSdlhVxgyuDJtGYwcikIJ+rjSqCSF78tu
         1KxZKHZpp9PWCwApn4DbgRAV74lYDNlxx/RQYDPm3Cc1HdyTpcioP/uisaJqCHzcn59r
         f8SsG9zc0JU0abDD9lLKTtH95fx0GS0jsnflSIc8CMlMNIsQDIMgPk2+0wgu/1CueJXd
         L1Tg==
X-Gm-Message-State: AOJu0YyQ64P/Hk5ZwEiqrROL/9gToAHOj+OdHhWtA+vUTK03bIJxyRXM
        +9XXLtuyvI7/s7FVlkMgedanfw==
X-Google-Smtp-Source: AGHT+IGsveKs3LwTQ3bVZb/XOA2HeSV60NxgDj9v7CvUPzNo+vvUKGEt1p5IB2LltiYD/vVyUmpTdQ==
X-Received: by 2002:a05:6a00:234f:b0:68a:5cf8:dac5 with SMTP id j15-20020a056a00234f00b0068a5cf8dac5mr129018pfj.22.1699389978852;
        Tue, 07 Nov 2023 12:46:18 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id e7-20020a630f07000000b005ab46970aaasm1750211pgl.17.2023.11.07.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:46:18 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v6 1/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing
Date:   Tue,  7 Nov 2023 12:41:51 -0800
Message-ID: <20231107204611.3082200-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107204611.3082200-1-hsinyi@chromium.org>
References: <20231107204611.3082200-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
auo_b116xak01: T3=200, T12=500, T7_max = 50 according to decoding edid
and datasheet.

Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
Cc: stable@vger.kernel.org
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v5->v6: split to 2 patches.
---
 drivers/gpu/drm/panel/panel-edp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9dce4c702414..2fba7c1f49ce 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -973,6 +973,8 @@ static const struct panel_desc auo_b116xak01 = {
 	},
 	.delay = {
 		.hpd_absent = 200,
+		.unprepare = 500,
+		.enable = 50,
 	},
 };
 
@@ -1870,7 +1872,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.42.0.869.gea05f2083d-goog

