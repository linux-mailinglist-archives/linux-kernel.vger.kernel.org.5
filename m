Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1269E79329E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjIEXbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIEXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:31:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F288133;
        Tue,  5 Sep 2023 16:31:40 -0700 (PDT)
Received: from pyrite.hamster-moth.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CBBF3B1;
        Wed,  6 Sep 2023 01:30:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693956612;
        bh=y7wV/evml2IbKlgjDtIjPjWJ7o0VRAvqJGG6hYnSTuE=;
        h=From:To:Cc:Subject:Date:From;
        b=uTFvU6VawmuPqKS40ZjlxF6JA9+2QwNdkClz0M/ZlT3VN9gOf24WGNGtA3JZHLwGd
         NJBq2mOtRd72agvwYP91yi2PtN1pwWt0b+GfrtmspIYHjGpyp5Z2v4lHZfrJxCaDqG
         bPohtprZE337nA7QHGhOYPV8Dh9C8q5vazLoOg7s=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] media: i2c: Add driver for THine THP7312 ISP
Date:   Wed,  6 Sep 2023 08:31:15 +0900
Message-Id: <20230905233118.183140-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for a new driver for the THine THP7312
ISP. It has been tested on an OLogic Pumpkin i350, which has a Mediatek
mt8365 SoC, with the THine THSCG101 camera module.

Technically the driver itself (and its bindings) have no dependencies,
but to run/test this on the i350, a bunch of patches from Baylibre are
required. I have these organized in a branch [1], and I have another
branch on top which includes the patches from this series [2].

Patch 3 depends on the device tree for the Pumpkin board, which as far
as I know will be handled by Baylibre. I expect this patch to go in
alone, separately, and at a later date.

[1] https://git.uk.ideasonboard.com/THine/linux/src/branch/epaul/v6.5-rc1/base/thine/thp7312
[2] https://git.uk.ideasonboard.com/THine/linux/src/branch/epaul/v6.5-rc1/rc/thine/thp7312

Paul Elder (3):
  dt-bindings: media: Add THine THP7312 ISP
  media: i2c: Add driver for THine THP7312
  arm64: dts: mediatek: mt8365-pumpkin: Add overlays for thp7312 cameras

 .../bindings/media/thine,thp7312.yaml         |  170 ++
 arch/arm64/boot/dts/mediatek/Makefile         |    4 +
 .../mt8365-pumpkin-common-thp7312.dtsi        |   23 +
 .../mt8365-pumpkin-csi0-thp7312-imx258.dtso   |   73 +
 .../mt8365-pumpkin-csi1-thp7312-imx258.dtso   |   73 +
 drivers/media/i2c/Kconfig                     |    9 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/thp7312.c                   | 1674 +++++++++++++++++
 8 files changed, 2027 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/thine,thp7312.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
 create mode 100644 drivers/media/i2c/thp7312.c

-- 
2.39.2

