Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB987E57EE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbjKHN1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKHN1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:27:20 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A71BEB;
        Wed,  8 Nov 2023 05:27:18 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 303EEC000C;
        Wed,  8 Nov 2023 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699450037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cQ6kgASMd3MviVZ9Li9dMd2dQGMlEHneHIL8ufkos2s=;
        b=Z8sp93SQxpWmSWVVZANDZjNgDJHG/dfSMcyNSgazLbN1ZDcI9Ny5VuJ/V1vYv6Jto7KeRS
        Uavf31ISwIlE06SiAlo1KSZQPc6eikUPyn1aX0jZ1KevKEXdwQWXkuWzwbJUBjpE2+x8qQ
        ED20jPY2BtkJM3l1knxS67mLhG5WZfquY+QySAGlhhKDd+tOCAuCTxPzvL7XgDIpn46CZh
        XbMucd6ZrIXA03gmVeaG5oGEmLvnjB5IumiV2zd8jD8pYdSbUDAOEMWnXsxlDWH0HAJ9mW
        9fI5RJ1/41OvQjVCnpbNE9Ref2pPXPYTYpFIJgJIeJ+Yi4LQHHqwleGh7CSNbA==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v8 0/3] media: i2c: Introduce driver for the TW9900 video decoder
Date:   Wed,  8 Nov 2023 14:27:11 +0100
Message-ID: <cover.1699449537.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

V8 of the series adding support for the Techwell TW9900 multi standard decoder.
It's a pretty simple decoder compared to the TW9910, since it doesn't have a 
built-in scaler/crop engine.

The v6 is based on the fifth iteration of the series introducing the
tw9900 driver: sent 01 Apr 2021 [1]

v7 => v8:
- fixed the number of analog input ports: it is just one.
- added endpoints of the analog input port
- added vdd-supply to the required in the dt-binding documentation
- added back pm_runtime
- added a mutex to Serialize access to hardware and current mode configuration
- split get_fmt and set_fmt callbacks 
- removed the tw9900_cancel_autodetect()

v6 => v7:
- added powerdown-gpios and input ports to dt-bindings
- added #include <linux/bitfield.h> to fix a Warning from the kernel
  robot
- removed a dev_info and replaced a dev_err by dev_err_probe

v5 => v6:
- dropped .skip_top and .field in the supported_modes
- added error handling for the i2c writes/reads
- added the colorimetry information to fill_fmt
- removed pm_runtime
- added the g_input_status callback
- dropped SECAM
- dropped the non-standard PAL/NTSC variants

Any feedback is appreciated,

Mehdi Djait

media_tree, base-commit: 94e27fbeca27d8c772fc2bc807730aaee5886055

[1] https://lore.kernel.org/linux-media/20210401070802.1685823-1-maxime.chevallier@bootlin.com/

Mehdi Djait (3):
  dt-bindings: vendor-prefixes: Add techwell vendor prefix
  media: dt-bindings: media: i2c: Add bindings for TW9900
  media: i2c: Introduce a driver for the Techwell TW9900 decoder

 .../bindings/media/i2c/techwell,tw9900.yaml   | 137 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/media/i2c/Kconfig                     |  12 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/tw9900.c                    | 771 ++++++++++++++++++
 6 files changed, 929 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
 create mode 100644 drivers/media/i2c/tw9900.c

-- 
2.41.0

