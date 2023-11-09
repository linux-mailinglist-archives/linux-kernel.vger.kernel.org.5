Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474427E65FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjKIJAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjKIJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:00:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D32D78
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:00:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a55302e0so757452e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520425; x=1700125225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvmOEb1ckbbB9zBBB0o82fMDjd1uz7C5pNwKHHdJSYY=;
        b=YuVgd8Gzc41JIRQcZkvYL5Xz0gEZJjhQmxmsiqaB/LDWyNxPabWJf+TspVCUjFtRNN
         Fh8zE0xQrWrB15fLZdYYgjuJr5HuD+cLXnBHH+eJXMWaipYgViXw116e0d53CWTarS5S
         xK17cllJOwqc8GxEXdzJ74XUwj9d+/P8dXhdvQNNxJ5wLJKlXvQFgkUY8ba4Wz5h24u9
         QAaqzaGn++ggHwmrqti0amLMS6AYbZWNtaRnGYMg1t9LRQoClnK1x5stiVg4hLynb4jV
         SgT9fiBemyp5d67ssSrHgQPM4//b5bT5XsNbNkjlDUD4pfYsUfuOX8c7+/OQFICaiPtG
         YKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520425; x=1700125225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvmOEb1ckbbB9zBBB0o82fMDjd1uz7C5pNwKHHdJSYY=;
        b=cOp4G91+LUSzRbd5ISc/IzUcSxU1PzHPs9lGcbLJUrJ7P/kHVrFGD+AmZMPunGrd7R
         xUAh7Hhhm/g75nyU8Kp6nDSKIHmIEcVbk2jJ+88EXkYjpkniZqzfIImXl4FJIpKSjLO/
         EAF/B4WuL9uQfaZpd1cI/j8u46aRluyLTvOxAvd5fRaxlbpj9BtV1U6a6Opay3T/sNRR
         PRcdP3678ggPN9MDLl4Urko7dCkykMP5kcrlEW0wtbN3EpqpukWykW+F3RxeyQq2T493
         Rc1JZmxxf9IlEaXL4d3RUGcZ4KlMK4QQjfv3xZfuACCyWX5GjcrlHz0RPALnuphOfnIy
         qsLg==
X-Gm-Message-State: AOJu0Ywln5sKAFbcsTJLjjBIEwnykoN/Twr933hA56oTMlNyHodJIFy6
        YG54SK+iffgjDbCdMd2kd0tq7g==
X-Google-Smtp-Source: AGHT+IGXqF7rsRdCM+jnVRiAOt/RFNLh/BPKYViJgYib8D+5TeLhy81KbMIITHU+3iLnWSKCwHBgfg==
X-Received: by 2002:a19:7908:0:b0:509:4b04:6331 with SMTP id u8-20020a197908000000b005094b046331mr865761lfc.55.1699520424824;
        Thu, 09 Nov 2023 01:00:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b0040472ad9a3dsm1428484wmb.14.2023.11.09.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:00:24 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Nov 2023 10:00:10 +0100
Subject: [PATCH v8 09/12] drm/meson: gate px_clk when setting rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-9-81e4aeeda193@linaro.org>
References: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
In-Reply-To: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6wj78w5SzMRVYfTnHYpi/keB3/pw6jAwnhprIG9LUDw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlTJ+Z5DW4LqZNMoa3WMtTQHFwXqgZtKvOnapnqjBc
 XjY70PqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUyfmQAKCRB33NvayMhJ0b8BD/
 4qh7M6HzQXLHJtRURxnlOaG9F4oa8yHB8C3zne8wFXHXAzpEyuOgUsfQbYZdJ/W6aLUUqtjz2U69ln
 Y/l2+MK15fZaKRgdI7irQPXCvywUoXrilkjUAMJs/tRxO22tPDTfZz85GYpP5+cZps9ktRitls6wYq
 7JpWIRjMgijfbYm+J9YYYgTkjuqdyrm04HY2Kq5X8JURjowxDXuuZZ+OsPOfZVKgimlwLg9dGJhSbG
 7n29v/jdbcNnP9CK797lllMU9n9ynTMVXfGx8x0rXniM+qEjosu9w/TGJLy1TfcuY54BzVSQ/amfP6
 1pzZa/mqNKpGUmD4ehEkFAQ5RaUEtuPGvK3mrT2p2PW5PM2VPjYXVI3bUpOfDh5RbeWKK1Y7s4KK02
 03UXzUWRmzXoiUj9wN+MM99wBbF+BYndZvG7mWID3eD2Nlozxn8IqsFdFCPaNNLpQk6wmujhMtAvEK
 dHpHXrGJFfU9Pkrdasyt6L3mJu8elLjk7U9OrLJn8eHpFiTMcWpeexwqh4Scs3e3xpK5vCoC2nWQz/
 ZJqyJowaiDk04eQVFscV8y16xXAOt1Qz4RpalktRwQvCXfxHehWn6gLxNLzfhuAFtzcJWCrsd1Ag8b
 IAbS1A23BtxkuI3+WDf6pelXXBZwIqo3bvutoZVwON8abaKmoZIId0hHg3LA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the px_clk when setting the rate to recover a fully
configured and correctly reset VCLK clock tree after the rate
is set.

Fixes: 77d9e1e6b846 ("drm/meson: add support for MIPI-DSI transceiver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
index e5fe4e994f43..72abe2057ec3 100644
--- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
+++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
@@ -95,6 +95,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
+	clk_disable_unprepare(mipi_dsi->px_clk);
 	ret = clk_set_rate(mipi_dsi->px_clk, mipi_dsi->mode->clock * 1000);
 
 	if (ret) {
@@ -103,6 +104,12 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(mipi_dsi->px_clk);
+	if (ret) {
+		dev_err(mipi_dsi->dev, "Failed to enable DSI Pixel clock (ret %d)\n", ret);
+		return ret;
+	}
+
 	switch (mipi_dsi->dsi_device->format) {
 	case MIPI_DSI_FMT_RGB888:
 		dpi_data_format = DPI_COLOR_24BIT;

-- 
2.34.1

