Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11DA7B5DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjJBXyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjJBXyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:54:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CE590
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:54:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c434c33ec0so2583655ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696290850; x=1696895650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ri2H++HoCXFAmUL0q2wpktG5mORN8GB1kk/7QHCMaos=;
        b=YZkgpR1zirPII/O6NeTEUh28T46qP5l6LA4dnLoXoae9eojCuNrf+NSqHdmX/LFf/V
         C2+mfFaO4t0x6ziL7zXT6L9BAKeUxQYKxigRvNCfwcLrK6jgLhjwpDzqMfNDGbpbGoid
         sbSR3LOTZrFtOazurohvpmzeUNE/FOSPmz/GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696290850; x=1696895650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri2H++HoCXFAmUL0q2wpktG5mORN8GB1kk/7QHCMaos=;
        b=YG3TwTdVu/9pVNHTNNanHvoPdvAY+elDv5Bhzi4TcUa0PbOUe1KWhLlc7FVjyzjDPr
         J2msC3WNBg+d6fgeem7Fw4Vhq5CLhHFLIT+EnS81Awx2xMBNo9kxAqFXf4XdHkyTYssS
         oaDxwRQ4TrK5vi1tVyyiVlJftEnO3z6gQUy7dYGi0oAPcKs+bOecTeKK9hp8t7pAwwIJ
         oby50iVZfU8pSxxTvl3IZ25j9VAkQT9NPYX9qzqOp02gVRJOUWe+Vl5BEFYgq5mejHce
         b2ULOkv6NQ44kNks/WSEp2hN5UNbASCHwEJEwvNiiVUAAlSI+c7TsMgHdxeINjFZhbtA
         aMww==
X-Gm-Message-State: AOJu0YxtNz9DTkLIttjBU0F2OAGsGkDNTcBx1ptA2dJa3xId6CQrzKZk
        prqMbevY2mCHHqjXqNj9gXlsLw==
X-Google-Smtp-Source: AGHT+IGOU6FXeF+Mqr7pHXMQjIlmKusQnIePSZpUSkDMPro+oP9wmgspqehR3tapjacP7Wamne+/hg==
X-Received: by 2002:a17:903:48c:b0:1c5:dfe9:b1f3 with SMTP id jj12-20020a170903048c00b001c5dfe9b1f3mr10596391plb.16.1696290850436;
        Mon, 02 Oct 2023 16:54:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:f676:8db:8677:aefe])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001c3ea6073e0sm32167plo.37.2023.10.02.16.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:54:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Associate DSI device lifetime with auxiliary device
Date:   Mon,  2 Oct 2023 16:54:06 -0700
Message-ID: <20231002235407.769399-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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

The kernel produces a warning splat and the DSI device fails to register
in this driver if the i2c driver probes, populates child auxiliary
devices, and then somewhere in ti_sn_bridge_probe() a function call
returns -EPROBE_DEFER. When the auxiliary driver probe defers, the dsi
device created by devm_mipi_dsi_device_register_full() is left
registered because the devm managed device used to manage the lifetime
of the DSI device is the parent i2c device, not the auxiliary device
that is being probed.

Associate the DSI device created and managed by this driver to the
lifetime of the auxiliary device, not the i2c device, so that the DSI
device is removed when the auxiliary driver unbinds. Similarly change
the device pointer used for dev_err_probe() so the deferred probe errors
are associated with the auxiliary device instead of the parent i2c
device so we can narrow down future problems faster.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index f448b903e190..84148a79414b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -692,7 +692,7 @@ static struct ti_sn65dsi86 *bridge_to_ti_sn65dsi86(struct drm_bridge *bridge)
 	return container_of(bridge, struct ti_sn65dsi86, bridge);
 }
 
-static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
+static int ti_sn_attach_host(struct auxiliary_device *adev, struct ti_sn65dsi86 *pdata)
 {
 	int val;
 	struct mipi_dsi_host *host;
@@ -707,7 +707,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
 	if (!host)
 		return -EPROBE_DEFER;
 
-	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	dsi = devm_mipi_dsi_device_register_full(&adev->dev, host, &info);
 	if (IS_ERR(dsi))
 		return PTR_ERR(dsi);
 
@@ -725,7 +725,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
 
 	pdata->dsi = dsi;
 
-	return devm_mipi_dsi_attach(dev, dsi);
+	return devm_mipi_dsi_attach(&adev->dev, dsi);
 }
 
 static int ti_sn_bridge_attach(struct drm_bridge *bridge,
@@ -1298,9 +1298,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	struct device_node *np = pdata->dev->of_node;
 	int ret;
 
-	pdata->next_bridge = devm_drm_of_get_bridge(pdata->dev, np, 1, 0);
+	pdata->next_bridge = devm_drm_of_get_bridge(&adev->dev, np, 1, 0);
 	if (IS_ERR(pdata->next_bridge))
-		return dev_err_probe(pdata->dev, PTR_ERR(pdata->next_bridge),
+		return dev_err_probe(&adev->dev, PTR_ERR(pdata->next_bridge),
 				     "failed to create panel bridge\n");
 
 	ti_sn_bridge_parse_lanes(pdata, np);
@@ -1319,9 +1319,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 
 	drm_bridge_add(&pdata->bridge);
 
-	ret = ti_sn_attach_host(pdata);
+	ret = ti_sn_attach_host(adev, pdata);
 	if (ret) {
-		dev_err_probe(pdata->dev, ret, "failed to attach dsi host\n");
+		dev_err_probe(&adev->dev, ret, "failed to attach dsi host\n");
 		goto err_remove_bridge;
 	}
 

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
https://chromeos.dev

