Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313987CAA95
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJPN6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjJPN6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:58:41 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655F83;
        Mon, 16 Oct 2023 06:58:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 299112000A;
        Mon, 16 Oct 2023 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697464717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LjC20cQKng/R+Q/l/dKpdLvOogebKCPRxhG1ikRdJtc=;
        b=o6VabpAWz2+wg8d3dGWmOoqLvw/RUoeUGOa5rM94VAEgda6koJggczhmzjUziov0bN6vqP
        eBbesdbpiIq+0cFhNrlCQ9DSgN+kC3Gf4Fc9WodC76yDcZnI8HbnRHNN5aNt1bZZXcOh63
        SfEjQdIVuIwc91OuN6s16Ud4QzBug+NBHfzLNj/uXsBxIFmAlZ4sYqVTcNrRqeR1gvRsjp
        Qe+R5IqI2KC3K5EYJteisxHCKV1Wii3HmzQu6Fv4r8mUSzfVTXIFadOBB5yNH1MFuePU+7
        toUbEGXqMdKACHTJB8UZAK5wR7K/TG9cJpDWozJ8iwLovsTlu+C03TRZ1E1Dwg==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, laurent.pinchart@ideasonboard.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v7 0/3] media: i2c: Introduce driver for the TW9900 video decoder
Date:   Mon, 16 Oct 2023 15:58:30 +0200
Message-ID: <cover.1697463708.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

V7 of the series adding support for the Techwell TW9900 multi standard decoder.
It's a pretty simple decoder compared to the TW9910, since it doesn't have a 
built-in scaler/crop engine.

The v6 is based on the fifth iteration of the series introducing the
tw9900 driver: sent 01 Apr 2021 [1]

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

media_tree, base-commit: 2c1bae27df787c9535e48cc27bbd11c3c3e0a235

[1] https://lore.kernel.org/linux-media/20210401070802.1685823-1-maxime.chevallier@bootlin.com/


Mehdi Djait (3):
  dt-bindings: vendor-prefixes: Add techwell vendor prefix
  media: dt-bindings: media: i2c: Add bindings for TW9900
  media: i2c: Introduce a driver for the Techwell TW9900 decoder

 .../bindings/media/i2c/techwell,tw9900.yaml   |  82 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/media/i2c/Kconfig                     |  12 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/tw9900.c                    | 648 ++++++++++++++++++
 6 files changed, 751 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
 create mode 100644 drivers/media/i2c/tw9900.c

-- 
2.41.0

