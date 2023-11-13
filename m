Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2519E7E9E97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjKMO1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjKMO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:27:06 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB3D59;
        Mon, 13 Nov 2023 06:27:00 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 266C41C0007;
        Mon, 13 Nov 2023 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699885619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x/vcYfbmrCl2/iFXdAu/GqVZlYhoqhCpshthYgoXXWU=;
        b=nVdhVCULSDjsp9z6AP86jPhGmku9Exz1YuO7aUG5D3bxAV25trNO7UbUIbIKjLn6pO58XU
        Q015wDW7S3B0ZH3aBMk9IapaqSZlEXp1739X3DOxLDOz5gslxGoiYuaQUSVv3bWXIbmexe
        VtFWOO0LHDRhnZs9BgPdle3PY4YhpQiQWrLQNyGJx0Agj55WcsMkebHipDAZQBh63BlyoR
        /7cV2M/iPQVdaKK/4yLPqPdN48PV26RhPHUGeStoxTKY6ncKcF8Rpnu3n4SPzVtR+9lei4
        fLfaKloIVo9coEMojXoaYv6oxwe7Zmji7dUYDUdeqAYGzxCoF/M4lhyOneahWA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/6] usb: cdns: fix suspend on J7200 by assuming reset on
 resume
Date:   Mon, 13 Nov 2023 15:26:55 +0100
Message-Id: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC8yUmUC/x3MPQqAMAxA4atIZgNNLCheRRz8STUOVRoUQby7x
 fEb3nvAJKkYtMUDSS413WMGlQVM6xAXQZ2zgR1XRFThVrNzeNqIdtohcUYefB2YGxLnIXdHkqD
 3/+z69/0Alpv3dmMAAAA=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Suspend on the TI J7200 platform is broken currently. There are two
components that need to be patched so that they assume reset on
resume: (1) the TI wrapper cdns3-ti & (2) the HOST role of the
controller.

Both only did their hardware configuration at probe time. We are talking
about suspend-to-RAM but also suspend-to-idle; we have power-domains
that turn off the controller in the second case which explains why
s2idle doesn't work either.

For cdns3-ti, we implement suspend & resume procedures only targeting
our newly created compatible (ti,j7200-usb). The goal is to avoid
breaking other platforms; it's unclear to me if power-domains are
toggling at s2idle on those as well. About S2R I don't think it's
targeted for those platforms.

For the HOST role, we add a quirk flag which gets passed as auxiliary
data by our wrapper TI driver. That avoids touching the behavior of
other platforms; again I'm unsure what is expected and I wouldn't want
to break stuff by re-initializing the role.

Those patches have been tested on the TI J7200 EVM GP. No need to
mention that other patches are required for S2R to work, but those will
be sent later down the road. Those USB patches are rather standalone.

Thanks,
Théo

--
Théo Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (6):
      dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb compatible
      usb: cdns3-ti: move reg writes from probe into an init_hw helper
      usb: cdns3-ti: add suspend/resume procedures for J7200
      usb: cdns3: support power-off of controller when in host role
      usb: cdns3-ti: notify cdns core that hardware resets across suspend on J7200
      arm64: dts: ti: k3-j7200: use J7200-specific USB compatible

 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   1 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   2 +-
 drivers/usb/cdns3/cdns3-ti.c                       | 141 +++++++++++++++------
 drivers/usb/cdns3/core.h                           |   1 +
 drivers/usb/cdns3/host.c                           |  20 +++
 5 files changed, 127 insertions(+), 38 deletions(-)
---
base-commit: 1d42d5c8f1ca11106579dcaadef4161fee03419e
change-id: 20231113-j7200-usb-suspend-2a47f2281e04

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>

