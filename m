Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5D77CF75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbjHOPpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbjHOPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:44:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B010DC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:44:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6887480109bso314708b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692114288; x=1692719088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+b40dDlDBakx8+hTHp2ebRkg2RA++lkqQVSTeac6zA=;
        b=BtS41tzhfK7XY6exlpjzQzgARG+Ehge1+0PRdLnYhdOW6v1Bo7SJIi4QfUUoIKcI9x
         pbi2VdZOgXud1DEl9BDa7AbCo5HKvn/XKF10E4aOV81o3c7y81bD4TpDN0gxIjiW+o34
         PdoWIJpg8d/x3+RQWmBeMDtnW3My6yZM1rnx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114288; x=1692719088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+b40dDlDBakx8+hTHp2ebRkg2RA++lkqQVSTeac6zA=;
        b=UQyytke6Rzxoy/CsBzmtPVwhmX3iDLy/JG6GC4Jz3U1ud18d+CI48F4dD/G+VhR7HL
         hsYcTRfr+Vp15hOoU3Q9aDYqPgV4jkMO5W5Qa9qFa5x4DwGgNZC/ndX2upwWf97W1MAE
         XozTD9dgD7YLg7sz2iqyuXKC2aZOjB0t4kmR432mdOIwbpOK//JmZolJSUPHnS44CI7s
         U1JR04vRg1N6vQabvan7tONR8/JEOQEeP6q5/2DA8YpLxwpl/ezBFZKA437o0HeefkAc
         gpIm04eWei3IBkQu85PLODrjVl7RsSHa04PJlZhNxuTDWJXHVQGja5oA9REZFuf5THX2
         ZsGQ==
X-Gm-Message-State: AOJu0Yxtn3PctmOXr3V4YHoDDwVkCkQKE1LmXsyunqBIpm+rC6VcT5KJ
        FDo9Ni+HY50uApk5oa302IxrTw==
X-Google-Smtp-Source: AGHT+IGzSeQ7P7d6hIuKp8jX5Kc6bcArFd2OV1P4lsTdQ+wIT/RytQKLIYbcjxTcDvbMf4xA8ee6oA==
X-Received: by 2002:a05:6a20:3d28:b0:134:1011:8582 with SMTP id y40-20020a056a203d2800b0013410118582mr17945878pzi.47.1692114288344;
        Tue, 15 Aug 2023 08:44:48 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40cf:3807:f8c8:2d76])
        by smtp.gmail.com with ESMTPSA id n13-20020aa78a4d000000b0065e154bac6dsm9431247pfa.133.2023.08.15.08.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:44:47 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] Add a property to override the quad mode
Date:   Tue, 15 Aug 2023 23:31:51 +0800
Message-ID: <20230815154412.713846-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gigadevice gd25lq64c, the quad mode is enabled after BFPT is parsed.
According to datasheet[1], Quad enable (QE) bit needs to be set to 0 to
use write protection (WP) pin. It also recommends setting default value of
QE to 0 to avoid a potential short issue.

Add a disable-quad-mode property in devicetree that platform can use it to
override the quad mode status parsed from BFPT to use write protection.

[1]
https://www.elm-tech.com/ja/products/spi-flash-memory/gd25lq64/gd25lq64.pdf
page 13

Hsin-Yi Wang (4):
  dt-bindings: mtd: jedec,spi-nor: Add disable-quad-mode property
  mtd: spi-nor: sfdp: read disable-quad-mode property
  arm64: dts: mediatek: mt8183: disable quad mode for spi nor
  arm64: dts: qcom: sc7180: disable quad mode for spi nor

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 7 +++++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi           | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi             | 1 +
 drivers/mtd/spi-nor/core.c                               | 5 +++++
 drivers/mtd/spi-nor/core.h                               | 1 +
 drivers/mtd/spi-nor/debugfs.c                            | 1 +
 6 files changed, 16 insertions(+)

-- 
2.41.0.694.ge786442a9b-goog

