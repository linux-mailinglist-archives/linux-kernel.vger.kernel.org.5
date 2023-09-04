Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB879169E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352868AbjIDL6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjIDL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:58:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF5197
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:58:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qd8Dk-0003r1-RS; Mon, 04 Sep 2023 13:58:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qd8Dk-003s40-0N; Mon, 04 Sep 2023 13:58:20 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qd8Dj-005pOk-Ey; Mon, 04 Sep 2023 13:58:19 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/3] Make Rockchip IO domains dependency from other devices explicit
Date:   Mon,  4 Sep 2023 13:58:13 +0200
Message-Id: <20230904115816.1237684-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of the patch posted by Quentin Schulz here [1]

This series aims to solve a problem with Rockchip IO domains. On many
Rockchip SoCs the pins are driven by external supplies normally
controlled by regulators of a PMIC. There are multiple voltages allowed
for the regulators; additionally the chosen voltage has to be programmed
into SoC registers. There already is a driver [2] handling setting these
registers. The driver works by registering a notifier on the regulators.
Whenever a regulator is about to change its voltage then the notifier will
program the IO domain registers suitably for the new voltage.

The problem is that there is no dependency between pins and the IO
domain driver which means that it can happen that a pin is used before
the IO domain driver has been probed. In that case the pin can end up
being non functional as neither the regulator has been configured
correctly nor the SoC registers have been adjusted to the regulators
voltage.

One way to ensure correct probing order is to defer probing of devices
in the pinctrl driver until the IO domain driver has been probed. We
can't do this for all devices though, as that would introduce a cyclic
dependency when for example the I2C port needed to access the PMIC for
the regulators is part of a IO domain itself.

This series solves these problems similarly to Quentins patch. With
Quentins patch we would have to add rockchip,io-domain properties for
all pin group nodes we wish to honor the IO domain dependency for. We
could put these properties into the board dts files which would mean
that we either only add the properties to nodes which actually byte us,
or that we would have to add the properties to all possible pin groups
except the ones needed to access the PMIC. We could also put these
properties into the dtsi files, but that would mean a board has to add a
/delete-property/ rockchip,io-domain to the pin groups needed to access
the PMIC to avoid circular dependencies.

The approach chosen here is slightly different. First of all this series
doesn't change the current behaviour without board specific dts changes.
To activate the IO domain dependency handling, a board has to add a
rockchip,io-domains property to the pinctrl node. When this property is
present all pins are assumed to need the IO domain driver. Pin groups
needed to access the PMIC can then be given a rockchip,io-domain-boot-on
property. When this property is given then the IO domain is assumed to
be correctly configured by the boot loader. It should be added to all
pin groups needed to access the PMIC to avoid cyclic dependencies. Patch
3/3 contains a usage example for the Radxa Rock-3a.

Sascha

[1] https://lore.kernel.org/lkml/20220802095252.2486591-1-foss+kernel@0leil.net/
[2] drivers/soc/rockchip/io-domain.c

Sascha Hauer (3):
  pinctrl: rockchip: add support for io-domain dependency
  dt-bindings: pinctrl: rockchip: Add io domain properties
  arm64: dts: rockchip: rock-3a: add io domain properties

 .../bindings/pinctrl/rockchip,pinctrl.yaml    | 13 +++-
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 11 ++++
 drivers/pinctrl/pinctrl-rockchip.c            | 64 +++++++++++++++++++
 drivers/pinctrl/pinctrl-rockchip.h            |  3 +
 4 files changed, 90 insertions(+), 1 deletion(-)

-- 
2.39.2

