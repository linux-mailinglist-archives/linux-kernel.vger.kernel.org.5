Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9F7F194A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjKTRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKTRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:06:13 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22683C3;
        Mon, 20 Nov 2023 09:06:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7F42E0007;
        Mon, 20 Nov 2023 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700499967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aKjAeW6DFp7B02nd83OisjeUbLjvY1HO12GAUJiKoCc=;
        b=mhjkzIXRM+/4c0nyFl3tUVBQkpArc5FyhYwkOrbRepu/A8owBF2XNSnMPFRLnSSXUFUMhK
        sHmRIBfJhxcEPJhDXviq0VQ7/FvzR4i0EEDY/LKPDl1pY29y4X62DxnqF/4Hm1udF8S/Jy
        Zq/jFFiufLwWBjMAMM5idBAVi/Ru0SjciIrgONgEbIW25r6BCqhxbYq5tcRpE4qXEhmg76
        oufBkLMLh5b9NyA4Mfw4bLURXnYI6gLezUvf982Ei1gIelKEKnUQMnciiCbB2Cxl/fL5uL
        fA2q6Tfg1G9RgVjOTKeHJis1qVpo1vsb/xyQiXv4uVAVb1mD5c8C/MX1J7oWyA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 0/7] usb: cdns: fix suspend on J7200 by assuming
 reset-on-resume
Date:   Mon, 20 Nov 2023 18:06:00 +0100
Message-Id: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPiRW2UC/32NTQ6CQAxGr0K6tmZaMBBX3sOw4KdIjc6QKRAN4
 e6OHsDle8n3vg1MoorBOdsgyqqmwSfgQwbd2PiboPaJgR3nRJTjvWTncLEWbbFJfI/cFOXAXJG
 4AtJuijLo69e81olHtTnE9+9ipa/9V1sJHTY9iZRUVPmpu7QhzA/1xy48od73/QN14EZztAAAA
 A==
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
        "Thomas Petazzoni thomas.petazzoni"@bootlin.com,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

About (1): the TI wrapper only did its hardware configuration at probe
time. Update so that it is done at resume on J7200 SoC.

About (2): signal from cdns3-ti to cdns3 host to xHCI that the
controller resets on resume. This way we avoid the following warning:

   xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit

Strictly speaking (2) is not required to have working suspend on J7200;
its only goal is to silence this warning.

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
Changes in v2:
- Remove runtime PM from cdns3-ti; it brings nothing. That means our
  cdns3-ti suspend/resume patch is simpler; there is no need to handle
  runtime PM at suspend/resume.
- Do not add cdns3 host role suspend/resume callbacks; they are not
  needed as core detects reset on resume & calls cdns_drd_host_on when
  needed.
- cdns3-ti: Move usb2_refclk_rate_code assignment closer to the value
  computation.
- cdns3/host.c: do not pass XHCI_SUSPEND_RESUME_CLKS quirk to xHCI; it
  is unneeded on our platform.
- Link to v1: https://lore.kernel.org/r/20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com

---
Théo Lebrun (7):
      dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb compatible
      usb: cdns3-ti: remove runtime PM
      usb: cdns3-ti: move reg writes from probe into an init_hw helper
      usb: cdns3-ti: add suspend/resume procedures for J7200
      usb: cdns3: add quirk to platform data for reset-on-resume
      usb: cdns3-ti: signal reset-on-resume to xHCI for J7200 platform
      arm64: dts: ti: k3-j7200: use J7200-specific USB compatible

 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   4 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   2 +-
 drivers/usb/cdns3/cdns3-ti.c                       | 134 +++++++++++++--------
 drivers/usb/cdns3/core.h                           |   1 +
 drivers/usb/cdns3/host.c                           |   3 +
 5 files changed, 90 insertions(+), 54 deletions(-)
---
base-commit: 1d42d5c8f1ca11106579dcaadef4161fee03419e
change-id: 20231113-j7200-usb-suspend-2a47f2281e04

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>

