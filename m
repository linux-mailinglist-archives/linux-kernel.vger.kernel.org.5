Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6468C7E4A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbjKGUq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjKGUqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:46:22 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F210CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:46:20 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1ef9f1640a5so3564985fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699389980; x=1699994780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i41FF+96jxQO4vU9afEGpgkE+iKipgdZiL7y6ifmJls=;
        b=UDuhrvu0UI1ueoWgWJuOtaOoZTb7tQLGgVh4moYTDhh6Ujm/I4sJZ7WtXpB/emeIjY
         VOrZW4HT3xIIw8q/Nt10TBHBxQX9cph7Aias3sR8jN0ON1wZM+8FXTxWHOo/rDHLsXRn
         EvkjA9zDsV+2IQgjdNsT/XAWXHl8Wf1Esh6wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389980; x=1699994780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i41FF+96jxQO4vU9afEGpgkE+iKipgdZiL7y6ifmJls=;
        b=j28W45zurjDVvT7UByL/DKaKu9Pq3xUwylpbKzhIvYvZQ60kLN0ePYrzR09mraw4RP
         JwxTIyaPX7rk6igzGGWR45e1zpcZ5Sy19HIM9/M34Kvwww4bVAR62Ce8tQCXL7Sj/yGi
         bNAOr5Je4rJU5cY118Q5gfuY2/enzIt7cUNMuS4kJ7uqsPdbbexDOVoJLb89YGjYaiHF
         dWoOVqHb30KgpbecfHzeg+Jnr1C+rxnl+qutUwpLxlNcv8sfasN5avA+NkBVP7xfOZUK
         j5aq68Cac7LsW2KfMY1hLGY6G6b3uOaISEI4VhLgLSiThu/yoj31HADS56+y8VQj6ji8
         BcLQ==
X-Gm-Message-State: AOJu0YxNpOVeiB+fCR2vLrL2oNZzV778mllu2RH68RPf+w75CFFEkWUX
        agh1SPuNg0mnX495cX/YNvv/zg==
X-Google-Smtp-Source: AGHT+IEOYtRda4YV3C9U3Tghr/ogU7feGJsqqa94Akf8g04V9mLzXLDXBiz0ZBVMNFxEnBunA5AcfA==
X-Received: by 2002:a05:6870:4c85:b0:1ea:131f:5fb7 with SMTP id pi5-20020a0568704c8500b001ea131f5fb7mr4815336oab.26.1699389979943;
        Tue, 07 Nov 2023 12:46:19 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id e7-20020a630f07000000b005ab46970aaasm1750211pgl.17.2023.11.07.12.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:46:19 -0800 (PST)
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
Subject: [PATCH v6 2/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name
Date:   Tue,  7 Nov 2023 12:41:52 -0800
Message-ID: <20231107204611.3082200-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107204611.3082200-1-hsinyi@chromium.org>
References: <20231107204611.3082200-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename AUO 0x235c B116XTN02 to B116XTN02.3 according to decoding edid.

Fixes: 3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,836X2, NV116WHM-N49 V8.0")
Cc: stable@vger.kernel.org
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v5->v6: split to 2 patches.
---
 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2fba7c1f49ce..d41d205f7f5b 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1871,7 +1871,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
-- 
2.42.0.869.gea05f2083d-goog

