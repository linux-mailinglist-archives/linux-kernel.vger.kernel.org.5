Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA627EF583
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbjKQPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKQPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:42:38 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FE6E6;
        Fri, 17 Nov 2023 07:42:33 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B8D61BF204;
        Fri, 17 Nov 2023 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700235752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yNqh1W+l1xyxCiKwmG3HCTekXHZkRRwcjr0CZxdvgL4=;
        b=Yb+6bvWSy9bvYwB3oTuh9ttCmd2iHinW74sbHwSeHKzbL+T5BHhSwT+nXBLUbo82l0M5vj
        xTRY2Sj8+Sp+TKAsZRpWT2Q9s66zL+ZbYX9sz8OIG3rlXfpKhMcpP+E6L5p8BoqUO5M+QH
        POxIUP1bazxDidjeESogrwg5e8GfzAdUoLFTxAfQyS3xoEI6FPe3Am7F1ZqjoPdQfUyDg7
        NGHfJugs5alDUL/aESpAoUWg0mE85UADWmKDsOhxnsOSk1S6IHfUmpk79CDmxUoWlkpdJA
        sxqOH4wWFc0d64qeRe5oXFl7TpbMb9HK3+4zDbIcSDfOBJyoWShppANZEQCoLA==
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
Subject: [PATCH v9 0/3] media: i2c: Introduce driver for the TW9900 video decoder
Date:   Fri, 17 Nov 2023 16:42:26 +0100
Message-ID: <cover.1700235276.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

V8 of the series adding support for the Techwell TW9900 multi standard decoder.
It's a pretty simple decoder compared to the TW9910, since it doesn't have a 
built-in scaler/crop engine.

v8 => v9:
- added a "depends on" GPIOLIB, PM and "select" V4L2_ASYNC to Kconfig
- reworked the locking to protect the tw9900->streaming global state
- folded power_on and power_off into runtime_resume and runtime_suspend
  callbacks
- used pm_runtime_resume_and get instead pm_runtime_get_sync

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

v5[1] => v6:
- dropped .skip_top and .field in the supported_modes
- added error handling for the i2c writes/reads
- added the colorimetry information to fill_fmt
- removed pm_runtime
- added the g_input_status callback
- dropped SECAM
- dropped the non-standard PAL/NTSC variants

Any feedback is appreciated,

Mehdi Djait

media_tree, base-commit: 3e238417254bfdcc23fe207780b59cbb08656762

[1] https://lore.kernel.org/linux-media/20210401070802.1685823-1-maxime.chevallier@bootlin.com/

Mehdi Djait (3):
  dt-bindings: vendor-prefixes: Add techwell vendor prefix
  media: dt-bindings: media: i2c: Add bindings for TW9900
  media: i2c: Introduce a driver for the Techwell TW9900 decoder

 .../bindings/media/i2c/techwell,tw9900.yaml   | 137 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/media/i2c/Kconfig                     |  15 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/tw9900.c                    | 777 ++++++++++++++++++
 6 files changed, 938 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
 create mode 100644 drivers/media/i2c/tw9900.c

-- 
2.41.0

