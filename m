Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C37E45E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjKGQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjKGQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:20:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514744784
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:55:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso41031915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699372549; x=1699977349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkfSHGrIpem8wzkvHrBk/3Gkd85Ebnq+lcLBg87ITvo=;
        b=dpY4L3eWa4flhXLc67MqZnrpxEIJMf0+wX5MqxWeKAUCPWoN9bdiHmuoqlI28BOFlz
         M/xTcEG33KRQWa05Aaz1bQxE7r3zmBXQc0Zda+6xnqZyCv+FkTuc4As+A5um5WV6kPsa
         +gyZZt67wq/aEP1WbvF8YjmsQD4NkMg+otY3rNyS94ruLbBrvZA6mkgFyxqZA6AZPzlh
         nsSquFgJHHl8vYze7deTu1VaC4jR0jEXHhE07z+3i2s+BMN/pCdVYDMf7hwfRNHJPo2H
         DeFnEj5yK6Lzdr4MlN/sh//IbQzUsmh5XW3tm/OkXmfBP8uj8yb4vUYK8FGSFIHBtj42
         7lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372549; x=1699977349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkfSHGrIpem8wzkvHrBk/3Gkd85Ebnq+lcLBg87ITvo=;
        b=pdd2aRcZ18f8Ht0yvmrFLj9Yi95DjxW8nNCBZxRwbbLg9JftKLepimWZ22UIOBxzQM
         WwmHvYnQS+S6722xw/UfsOqsw9eWLFuPxIy+BjNJfmmoe70TgU+SQqVL0Z4MkWvl4rFh
         R7sdIlG1hMfx2qJNQEPPEEkonyRUXeZToWN0qQH91ODCl/47IYGm2z4BOcS8xJM4YUgy
         6aeuzwEt5yw4WMh9LV/iokfIdsJ62qdNhassXY0GhNtjoYJ5c5DArSSLsnwkzObz/pS/
         hkyIsJX/vFTC5zqahQ/rSj//5MRWyE6iNgHEXyvoUs6Vn3ACp5M7josknMk4RzBdT5Ru
         7R0w==
X-Gm-Message-State: AOJu0YzWejwKagfh3vUbf32QWwIafw/3QlpgXD2pe2nGWnQCcvsXTGo2
        RlDul4DZ3ScUn8IyUZQBPfVp6g==
X-Google-Smtp-Source: AGHT+IHpnyjFtHnxiqNRaHl8atDMuhe0j+p3O/OrAQ+Bopbx3/CIOAepx72DV4yXbiUhAx69OJKUiw==
X-Received: by 2002:a05:600c:1913:b0:408:3cdf:32c with SMTP id j19-20020a05600c191300b004083cdf032cmr3353377wmq.41.1699372548745;
        Tue, 07 Nov 2023 07:55:48 -0800 (PST)
Received: from arnold.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f6-20020a05600c4e8600b003fefb94ccc9sm16579085wmq.11.2023.11.07.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:55:47 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/6] MAINTAINERS: add new dt-binding doc to the right entry
Date:   Tue,  7 Nov 2023 15:55:28 +0000
Message-Id: <20231107155532.3747113-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107155532.3747113-1-clabbe@baylibre.com>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip crypto driver have a new file to be added.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a43b16aecaa..f9ae35a13e70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18697,6 +18697,7 @@ M:	Corentin Labbe <clabbe@baylibre.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+F:	Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml
 F:	drivers/crypto/rockchip/
 
 ROCKCHIP I2S TDM DRIVER
-- 
2.41.0

