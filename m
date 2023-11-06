Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435137E31CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjKGAAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjKGAAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:00:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A513134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:00:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-280cc5f3fdcso4785739a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 16:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315230; x=1699920030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdzwYBIp8oE+FGXK79RX2ZgMcbwotMlBVaAFWxWkmk4=;
        b=k4fre46UY1d1meVEfgtvl2+wDsrXHTGOeBmF7H5V8zILOV8La/R4kIN3QB4EOxkUc+
         bK+9IKorSuhtVf2mYAtB/zuVJahEtQGykzzZHlZRek4NTIX7ODMegNbQR5prCynlNH/f
         C86Lb6bJsewRHM/0RtG/b6wvdoVeJM38nRlZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315230; x=1699920030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdzwYBIp8oE+FGXK79RX2ZgMcbwotMlBVaAFWxWkmk4=;
        b=kU5FB5SNzpWihqJcE1uqpIaRRPHeLLOMlE4kWQvHvQJ90RO9uGcqvHt5lYEkgkhBhJ
         nWmATA6fibyU6AnRz2V+aVfNyEbIlYt5jwR9KY5m6By4ovKpKns8JQxx+dkNbQCwsaBs
         0nC1ao3fSUqf46sBP0nUUtJZGQ35luxUdU15pD1AwZujofoGipiszkizYH8XaTFiPGTC
         qMhjRcOqZ4crRDAX0TkoIIec1mznargIl8wFNbH70Au4xc7RYh7EcNUwISqqm6SvjZe0
         28/O+o1Cs71kjMtLdkffdqyvFgZ2Lx6nFPrl38eHq2o0QFfEx0CziB5m2YCxTRkYkdeM
         3T8A==
X-Gm-Message-State: AOJu0YxDt3ru30Dke7dC3ikNWW7eWUIejSMrJB/edjBlMNQxtP0d27aW
        AdJzhSZfmG57x+8xw3b0ORd6Bg==
X-Google-Smtp-Source: AGHT+IGzUaRjR1xfzqURuaVGH3yiuFXLHvoIPG6NQb7hsf2OOZ1zGUrQiOB43Utv8HEaOorrvEYc/g==
X-Received: by 2002:a17:90b:e14:b0:27e:31a:2ab2 with SMTP id ge20-20020a17090b0e1400b0027e031a2ab2mr24488613pjb.34.1699315229679;
        Mon, 06 Nov 2023 16:00:29 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id fw11-20020a17090b128b00b00268b439a0cbsm5852866pjb.23.2023.11.06.16.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:00:29 -0800 (PST)
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
Subject: [PATCH v5 1/4] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02, B116XAK01 name and timing
Date:   Mon,  6 Nov 2023 15:51:32 -0800
Message-ID: <20231107000023.2928195-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107000023.2928195-1-hsinyi@chromium.org>
References: <20231107000023.2928195-1-hsinyi@chromium.org>
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

According to decoding edid and datahseet:
- Rename AUO 0x235c B116XTN02 to B116XTN02.3
- Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
auo_b116xak01: T3=200, T12=500, T7_max = 50.

Fixes: 3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,836X2, NV116WHM-N49 V8.0")
Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v4->v5: separate fixes patch.
---
 drivers/gpu/drm/panel/panel-edp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9dce4c702414..d41d205f7f5b 100644
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
 
@@ -1869,8 +1871,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.42.0.869.gea05f2083d-goog

