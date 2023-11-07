Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08A87E4562
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbjKGQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbjKGQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:04:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80746B1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:55:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507ad511315so8432591e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699372544; x=1699977344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dwIY2rn/dEbSPVpdhU2+f4uOVwzcygzYY5LLYZc61cU=;
        b=lb1Z3uYhdRyz+ZQZdcQkp/JsP7erLsukxm7K8ttXw7a4MDTx7nAjWilC6/ykwBsSiz
         9ah6PDdkJFggacY5pjPL/Dq9458r7WcbRlWSuHNZrawPl+jMNbPcocRSU9L1BsGC77GW
         FW9k5tqQQ8MZmTjtZWEEPfP74P6wO0N2OKZ/SjGTjTtmLjx4/x06Z09vLqa4MJhaPx5E
         NPoDdY6iEM7EFGmVlMzlAOqj5jw/Flee7uU1q+yourjDzxHunDhuyLDrpCDqGQMDdHmr
         3IJKP8KAXqO/2agU9twgDZHpNndk2Uxwycnu60orLpYw6bUYHcN//VsfEJVr2kBmC6qu
         h1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372544; x=1699977344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwIY2rn/dEbSPVpdhU2+f4uOVwzcygzYY5LLYZc61cU=;
        b=vASCi/GmKQbTJYIfBSLWbyFWolug1JDcICq4ouLTq98kAJZ9+4Sa4kUzv5Dc876Qmr
         SJWSoWBNoybJ0teInf0un15JQwHfWFz2QmO305NoDnTvSOEgWMWTb9eSOgVKZ5jiDU23
         MAlwF1MfGqPG753F5qh12hVc+S7I+w3uzqKMqLzCYL6WmxFy4rksTp2vm+OYwreUCzBj
         7D2TwuVDoI1BB4rq5jDYkxkYnAIdLXHVLQwRGRLfAwBjkySStIigyt9dqElNOIKPex4a
         Rc3Q4B90h0yA3/KjcpIn/kjZcK1I8BVxT5UchX4meUp9JZ9pbNeobMHcemQZJ0NAfOOd
         BXXA==
X-Gm-Message-State: AOJu0YwAGoc4GbGDjonV2pMevrqYX26cUy2pZnzuTtfi33FPX3FLaNDI
        UvK86snr4LJu1GFkpyepmx0GAg==
X-Google-Smtp-Source: AGHT+IEW/M54tsfmWAXd/ApYtb7f8HXdpcpbgcYJR/UxDO6jor1uWlDWpgFp9h1Fwj1h6vqEmi/WOg==
X-Received: by 2002:ac2:430a:0:b0:503:257a:7f5d with SMTP id l10-20020ac2430a000000b00503257a7f5dmr21683796lfh.31.1699372544418;
        Tue, 07 Nov 2023 07:55:44 -0800 (PST)
Received: from arnold.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f6-20020a05600c4e8600b003fefb94ccc9sm16579085wmq.11.2023.11.07.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:55:43 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/6] crypto: rockchip: add support for rk3588/rk3568
Date:   Tue,  7 Nov 2023 15:55:26 +0000
Message-Id: <20231107155532.3747113-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patch serie add support for the new crypto rockchip IP found on
rk3568 and rk3588.
It was tested with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y

I would like to thanks all people which helped to test this driver

Regards

Corentin Labbe (6):
  dt-bindings: crypto: add support for rockchip,crypto-rk3588
  MAINTAINERS: add new dt-binding doc to the right entry
  ARM64: dts: rk3588: add crypto node
  ARM64: dts: rk356x: add crypto node
  reset: rockchip: secure reset must be used by SCMI
  crypto: rockchip: add rk3588 driver

 .../crypto/rockchip,rk3588-crypto.yaml        |  65 ++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  12 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  12 +
 drivers/clk/rockchip/rst-rk3588.c             |  42 -
 drivers/crypto/Kconfig                        |  29 +
 drivers/crypto/rockchip/Makefile              |   5 +
 drivers/crypto/rockchip/rk2_crypto.c          | 739 ++++++++++++++++++
 drivers/crypto/rockchip/rk2_crypto.h          | 246 ++++++
 drivers/crypto/rockchip/rk2_crypto_ahash.c    | 344 ++++++++
 drivers/crypto/rockchip/rk2_crypto_skcipher.c | 576 ++++++++++++++
 .../dt-bindings/reset/rockchip,rk3588-cru.h   |  68 +-
 12 files changed, 2063 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml
 create mode 100644 drivers/crypto/rockchip/rk2_crypto.c
 create mode 100644 drivers/crypto/rockchip/rk2_crypto.h
 create mode 100644 drivers/crypto/rockchip/rk2_crypto_ahash.c
 create mode 100644 drivers/crypto/rockchip/rk2_crypto_skcipher.c

-- 
2.41.0

