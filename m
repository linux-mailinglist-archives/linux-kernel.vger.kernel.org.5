Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B287F7D7727
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjJYVz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:55:27 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7EB9D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:25 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-584042a01eeso160360eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698270924; x=1698875724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZjOElzQDGxoQ4pwGGKbt8PuAPhhW08ELsRr1XnGZiA=;
        b=buZquPeHKDBaUtcaP/bvBCMQrjVSUBIqMTHVvzWNuV5trQjjNF5lfGfxsdGeS79KmL
         SgnbsfxwJFBX2PTU0l9fZWb85n75Telsu+7Hcb/zB7gYoFQs8kuCnwFGiEvSN8K1LeHg
         1cmJ9+I5uBxWc3As/xm4C4Me1CXFKxAcLvqCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698270924; x=1698875724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZjOElzQDGxoQ4pwGGKbt8PuAPhhW08ELsRr1XnGZiA=;
        b=WCVZkbGXqobewBdPkt8iFELcCJbPQidb3DZNef7jqvrn3cfE32NeE40zTRIJgjDtTM
         e9HA+USRJ4LqsIK+4kzJn9otKLjdG0IT7w2xTZ1gyz5sC56ahJQpLZvkN3bt+SNmB/Ev
         dnuBURWne9E7fie9wBflw6rXS8kczkMvkir49pBTjhhJgGnzC30iHqZz5tJIXEvvySfB
         lYC2qrUCvJgaTs0BH9S45sjB6npguU1LfzCvTxBHzGa2NnSYnqfIsOYGtW3VZJTf/MT6
         C5ssbDKSGZY3m2bP+ZJZaKnzZ1qOuoyK744diKoAK0bAX2rVaif+yH8lnvjEhx+FkO4K
         xODQ==
X-Gm-Message-State: AOJu0YweKboG5mTW8AuJ72XKiNVpgqI9JKwo9I0kQn24mi1mNUi1HFY+
        HEgUJRvaUdG1C9xJe/aGBj047w==
X-Google-Smtp-Source: AGHT+IFjCZtfJhyqWwcYtvspHvC+k8qpM+nKb58t3dyqN+Hs53HrNgamjCAmgpib31dWdFQmj/AGFA==
X-Received: by 2002:a05:6358:3517:b0:168:ba46:d9dd with SMTP id m23-20020a056358351700b00168ba46d9ddmr16197803rwd.17.1698270924231;
        Wed, 25 Oct 2023 14:55:24 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id w14-20020a63160e000000b005b8ebef9fa0sm2994943pgl.83.2023.10.25.14.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:55:23 -0700 (PDT)
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
Subject: [PATCH v3 0/7] Add a few mt8183 follower boards.
Date:   Wed, 25 Oct 2023 14:48:42 -0700
Message-ID: <20231025215517.1388735-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

 .../devicetree/bindings/arm/mediatek.yaml     |  21 ++++
 arch/arm64/boot/dts/mediatek/Makefile         |   6 +
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      |  24 ++++
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      |  24 ++++
 .../mediatek/mt8183-kukui-jacuzzi-pico.dts    |  36 ++++++
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   | 110 ++++++++++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   6 +-
 .../mediatek/mt8183-kukui-kakadu-sku22.dts    |  18 +++
 .../boot/dts/mediatek/mt8183-kukui-kakadu.dts |  18 +++
 .../dts/mediatek/mt8183-kukui-kakadu.dtsi     |  15 +--
 .../dts/mediatek/mt8183-kukui-katsu-sku32.dts |  36 ++++++
 .../dts/mediatek/mt8183-kukui-katsu-sku38.dts |  40 +++++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  94 +++++++--------
 13 files changed, 384 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts

-- 
2.42.0.758.gaed0368e0e-goog

