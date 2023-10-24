Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458A7D4397
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjJXAHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjJXAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:07:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C3E10C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c87a85332bso32958555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698106050; x=1698710850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8KIyXKnp9ik2LhvuJOfiqnewO+JX1rYsLQwadh3j9eo=;
        b=aO38YOWN2ssvEbu5vgiRdSVbuuUhJbvRiIjNikAtJROAWlK3PwZad7G+OiU9aRSrjW
         y91iprZOWNXNgUDdc37tw4vIkz/klBzrvrrn4O6OYZEaRGUOOcgwhF+7ayoeZWNAJgVe
         pcd9BQfJt0I5LKc3H0hAfw4LvbqS9Yctt3iIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106050; x=1698710850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KIyXKnp9ik2LhvuJOfiqnewO+JX1rYsLQwadh3j9eo=;
        b=GHothn9CmLpUVXdPfQCXhGxPRef4xPvdM9nciIdT7VwArKbCnPkGdGiIl62j5g+aCA
         WIL+SKQCeAkqIICDSW21nO262KDYUOMIk+3lWaFNlheatE1gIRc6rzjoqW9XSSwaIPBB
         K5/qmrNHLGtZvrnPZJEzmd24eD+2asHnENeCtDWxwJfJG6moBUxLsUGbNKZwfIwX4LR+
         emFW6BaidSG1Hk4Zsx4wex5RzbTAAxelxW7i4GbXzl+pBmYIuxEYidP4AHNdSvudtDtG
         CUltkU7UpeqmRYhctdwg9GAChpBDmwARVXCuRCZYmeQt4gLQglXxewpb2bsxIBPra5w4
         fdYA==
X-Gm-Message-State: AOJu0YwFF/GsX+h5THouwZE275J3p+fmWPbXkGYD3hrSO+ibCYEBUWl0
        d97i61bWUcdHFu+EK0umxcYf5A==
X-Google-Smtp-Source: AGHT+IHiQ5fMHyiReBzHBkMvPSaaCCS/bkotYyZaskZvzm6qK4GNEDtEwtoub82tMAHIemj7mRkj9Q==
X-Received: by 2002:a17:902:d484:b0:1c9:cf1e:f907 with SMTP id c4-20020a170902d48400b001c9cf1ef907mr14511451plg.57.1698106049960;
        Mon, 23 Oct 2023 17:07:29 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001c5dea67c26sm6505510plh.233.2023.10.23.17.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:07:29 -0700 (PDT)
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
Subject: [PATCH 0/6] Add a few mt8183 follower boards.
Date:   Mon, 23 Oct 2023 17:02:23 -0700
Message-ID: <20231024000724.57714-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add makomo, pico, and katsu which are mt8183 followers.

Hsin-Yi Wang (6):
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-katsu
  arm64: dts: mt8183: Add kukui katsu board
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-makomo
  arm64: dts: mt8183: Add jacuzzi makomo board
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-pico
  arm64: dts: mt8183: Add jacuzzi pico/pico6 board

 .../devicetree/bindings/arm/mediatek.yaml     |  25 ++++
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      |  25 ++++
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      |  25 ++++
 .../mediatek/mt8183-kukui-jacuzzi-pico.dts    |  36 ++++++
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   | 110 ++++++++++++++++++
 .../dts/mediatek/mt8183-kukui-katsu-sku38.dts |  44 +++++++
 .../boot/dts/mediatek/mt8183-kukui-katsu.dts  |  40 +++++++
 7 files changed, 305 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu.dts

-- 
2.42.0.758.gaed0368e0e-goog

