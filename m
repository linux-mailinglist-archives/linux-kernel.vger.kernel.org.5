Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081857D88C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjJZTNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:13:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6323C1B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1052730a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698347628; x=1698952428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch2xr7WSfAQsekJPDJjz2RgxrfMVUniFSWo5hCYQcEI=;
        b=n7qqe6gZzYCPyI195Espv7qbePfOww7A/cLc7rG09RJfNZRMuy9olQ6JAaIq826TH8
         p6iiMZKban+NjzK3t/zMQpPjNmmZwwGnTSVGo8irDbKdio7lVJTYOMWNxlGkRja5nXlI
         Sqj+nR2IRV7acB5ubVRXkdf2Lwas0yU8WD6JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347628; x=1698952428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ch2xr7WSfAQsekJPDJjz2RgxrfMVUniFSWo5hCYQcEI=;
        b=K/EaWisnPaziQ1W5b42w7D8QYI57juKqMeOxGDlb4gPvB7w2kk8cSjNVuyHifqWUM0
         jAFDz4348FraOVV9yh12hE61Jh5y2DxZ3nZ5xfPwj3k0UsmHHoGIth74l1pA8HVxtnJ4
         BeOMhdMmQDtNrJ8Nz9OdXD/Dr/lrfvBLssVXvQK3ziQVNEzUJRLD1Ugk3pHb26AaIMpQ
         /hXXD6YiGYuvMHhHb3mUtCN5Gt+Wr1T422cgyGXS+843l0vfDbn9kuDH1Ss3+wudLi6N
         Sgz887/cMHz7l+P/Lt8Abplz0LpHzJTje/b3pJH2JJAIIzC7fXEw0zFMlMFxZZw/Z8pC
         r32A==
X-Gm-Message-State: AOJu0YwyD6WQXvAqcfcV3UwyechNNGwyjOYhgrFswODQ/Fub+0cwy1Ci
        Zk8i/ymXjAbOG65IIAb+1CXelQ==
X-Google-Smtp-Source: AGHT+IHUqjqOZtBWong8vFEikEVD8olSnLJyI2zsl2FBwBwf0Fg0LjpZS1EX2gbS3zNjBHJCDytTbg==
X-Received: by 2002:a17:90a:1957:b0:280:205:9ba2 with SMTP id 23-20020a17090a195700b0028002059ba2mr448867pjh.5.1698347627814;
        Thu, 26 Oct 2023 12:13:47 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a031600b0027476c68cc3sm2183639pje.22.2023.10.26.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:13:47 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 0/7] Add a few mt8183 follower boards.
Date:   Thu, 26 Oct 2023 12:09:09 -0700
Message-ID: <20231026191343.3345279-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add makomo, pico, and katsu which are mt8183 followers.

v4: based on https://lore.kernel.org/all/20231025093816.44327-1-angelogioacchino.delregno@collabora.com/

Hsin-Yi Wang (7):
  arm64: dts: mt8183: kukui: Fix underscores in node names
  dt-bindings: arm64: mediatek: Add mt8183-kukui-katsu
  arm64: dts: mt8183: Add kukui katsu board
  dt-bindings: arm64: mediatek: Add mt8183-kukui-jacuzzi-makomo
  arm64: dts: mt8183: Add jacuzzi makomo board
  dt-bindings: arm64: mediatek: Add mt8183-kukui-jacuzzi-pico
  arm64: dts: mt8183: Add jacuzzi pico/pico6 board

 .../devicetree/bindings/arm/mediatek.yaml     |  21 ++++
 arch/arm64/boot/dts/mediatek/Makefile         |   6 +
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      |  24 ++++
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      |  24 ++++
 .../mediatek/mt8183-kukui-jacuzzi-pico.dts    |  36 ++++++
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   | 110 ++++++++++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   6 +-
 .../mediatek/mt8183-kukui-kakadu-sku22.dts    |  18 +++
 .../boot/dts/mediatek/mt8183-kukui-kakadu.dts |  18 +++
 .../dts/mediatek/mt8183-kukui-kakadu.dtsi     |  14 +--
 .../dts/mediatek/mt8183-kukui-katsu-sku32.dts |  36 ++++++
 .../dts/mediatek/mt8183-kukui-katsu-sku38.dts |  40 +++++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  94 +++++++--------
 13 files changed, 384 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts

-- 
2.42.0.820.g83a721a137-goog

