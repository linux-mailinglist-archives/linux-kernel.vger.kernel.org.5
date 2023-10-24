Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DF7D5D27
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjJXV01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjJXV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:26:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64C98
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9daca2b85so1676655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182783; x=1698787583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XlbC1K4AxAmssnIJB6kuFR9XUGWIIZCHNO54Y+mJArc=;
        b=DVOCNnUby4RgFnNetfcSGWAzq9IqvyyVs6sSvlrQsdMZsbiaPFY0B3Ld91xbb2X1ld
         KmdLpSro1NqZ0H8IG0sp118inbNmwwclN9heDx0XfmXqHZBz4Vg10QN3nwhWBbrkL1B2
         v7IRNxRw8NXmWYGuyyS3OwDXzEDJOY2G6EhKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182783; x=1698787583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlbC1K4AxAmssnIJB6kuFR9XUGWIIZCHNO54Y+mJArc=;
        b=n9cVAh+opsoUvAAUrdPAQ1+Y2AOmQjHSjoEk9MItmvjZCyLW4e517ChhNCD/YMR88a
         oqD7nq1o31+q8KuuLySI8hbQrcO2dcuS838a9758Q3RF1yquSJqb/ZW41lW6Ojtfv6QL
         yPYEvebEu5zWXOmLUUOPDLx1/3UzbfURo7S9vQRzzYJujyBdqGpC16MgVM/xZn964qHj
         lfrTjSLI947xCZULQf54RecbydAoc4Ze1kLESH0Hd9DLMy9+KN9Kp7EGMS6DGcU7mX6x
         5UHUS30nhZWNVfbGERplNs4WXDOc8VGl/IKDjrJzCVZhNdAonE+0o0ItjF8FoscBZ1GU
         f/5Q==
X-Gm-Message-State: AOJu0YzXVyxXZ1G7X8U4dnZWeljO4z/ITaFizZIh0xVYXCrg8O3ev0ZE
        uZwK8h8t/NAhGeBfiM+EC2piJQ==
X-Google-Smtp-Source: AGHT+IH08j3uB/07Mi8ENp6fO0bST3SnZ0NK+J60maANiUoTINigRosmQBLv07Hk2ZM6aCvRKL76TQ==
X-Received: by 2002:a17:902:ec87:b0:1bd:e258:a256 with SMTP id x7-20020a170902ec8700b001bde258a256mr17679533plg.32.1698182783069;
        Tue, 24 Oct 2023 14:26:23 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b001b850c9d7b3sm7824140plf.249.2023.10.24.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:26:22 -0700 (PDT)
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
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/7] Add a few mt8183 follower boards.
Date:   Tue, 24 Oct 2023 14:22:22 -0700
Message-ID: <20231024212618.1079676-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
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

Add makomo, pico, and katsu which are mt8183 followers.

Hsin-Yi Wang (7):
  arm64: dts: mt8183: kukui: Fix underscores in node names
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-katsu
  arm64: dts: mt8183: Add kukui katsu board
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-makomo
  arm64: dts: mt8183: Add jacuzzi makomo board
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-pico
  arm64: dts: mt8183: Add jacuzzi pico/pico6 board

 .../devicetree/bindings/arm/mediatek.yaml     |  26 +++++
 arch/arm64/boot/dts/mediatek/Makefile         |   6 +
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      |  25 ++++
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      |  25 ++++
 .../mediatek/mt8183-kukui-jacuzzi-pico.dts    |  36 ++++++
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   | 110 ++++++++++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   6 +-
 .../dts/mediatek/mt8183-kukui-katsu-sku32.dts |  40 +++++++
 .../dts/mediatek/mt8183-kukui-katsu-sku38.dts |  44 +++++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  90 +++++++-------
 10 files changed, 360 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts

-- 
2.42.0.758.gaed0368e0e-goog

