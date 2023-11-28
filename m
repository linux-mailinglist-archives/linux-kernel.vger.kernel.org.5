Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858277FC255
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346853AbjK1Pfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346879AbjK1Pfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:35:44 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C989A92;
        Tue, 28 Nov 2023 07:35:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28365FF803;
        Tue, 28 Nov 2023 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701185746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wheDqiE2a9OZr8JN6HhD16I1O5hsDNL5yX5S9DFZ7RQ=;
        b=jW5PFFRFM3QHLzqGw2eP/vuhSY/2H2WnsX80le7uM3aFzdaPasOGKMZgaXRnRpg6HxF9KS
        dPnktG+RUba8i95BML29r6+xhH9dY/rgmO7IINtPJsklbQgDHXKmN7VoQQEuA8j/fe+Qun
        k18ByByEdOzlQSvn9h/HWKFQgYQdr3GZu/bAX/Ma/UHmffHAvdqOx3Ng5N00Lrgd1npuem
        ZJoWIKv12Ep8Iqqb7Ob8Q8pUrvTKaoWWm0rm0344ox0KT3OnkjwNdY0kC4b7XVpbrgAH39
        PUPjFOugk3XfkPz6GGUD7xSoe7vm4eUO+zKHdkbDnb7L41h/dv6TlJbu06YBbA==
From:   Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/3] pinctrl: pinctrl-single: fix suspend/resume on j7200
Date:   Tue, 28 Nov 2023 16:34:58 +0100
Message-Id: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKIIZmUC/x3N0QrCMAyF4VcZuTbQRobWVxEv2iy6iNSRiAhj7
 77Wy+/Az1nBxVQcLsMKJl91fdeGeBiA51wfgjo1AwU6xkhnfJ4oBFy08sde6GSYRi6J45hyEmh
 dyS5YLFeee9nZ58Xkrr//1fW2bTsVmSuPegAAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, theo.lebrun@bootlin.com,
        u-kumar1@ti.com, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On j7200, during suspend to ram the SoC is powered-off. So the pinctrl
contexts are lost.
The flag PCS_CONTEXT_LOSS_OFF shall be set to restore the pinctrl
contexts.

A new compatible (ti,j7200-padconf) was created to enable this flag only
for j7200.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (3):
      dt-bindings: pinctrl: pinctrl-single: add ti,j7200-padconf compatible
      pinctrl: pinctrl-single: add ti,j7200-padconf compatible
      arm64: dts: ti: k3-j7200: use ti,j7200-padconf compatible

 .../devicetree/bindings/pinctrl/pinctrl-single.yaml          |  1 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                    |  8 ++++----
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi              | 12 ++++++------
 drivers/pinctrl/pinctrl-single.c                             |  5 +++++
 4 files changed, 16 insertions(+), 10 deletions(-)
---
base-commit: 2a20795e4274c0d94c14fcb8309f72699e404d99
change-id: 20231128-j7200-pinctrl-s2r-95cb9c159a9e

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

