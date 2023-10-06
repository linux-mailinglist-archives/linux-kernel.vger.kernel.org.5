Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01267BBC9F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjJFQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJFQZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:25:38 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AABCA6;
        Fri,  6 Oct 2023 09:25:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CC2DC0002;
        Fri,  6 Oct 2023 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696609535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BowLHmdlVABG/3EmDMqrUsVIT6KePTdYJjpAj3z+AVE=;
        b=W/90crlZ5TJKN4GF5wx3iLWq9E+fsOVSXwOW0UoC4sTMAD4vyD+MH+jmnztH146Uix8PmT
        uVOVSS+Wh9Hi1m7Z9hQElkYXFIyL2YvalA3DNi62EPICtHaghJRbbG6pZRTqTP7M+48vk7
        o0a5MlOsx/nhWWXMR9SPvqxdT0RpImT8ZBlEpWyLc2VQUJjTPKqE7H1DK80hwEerNrpfjq
        rmPh6Iq9uKrOTq8UHexE95h/3TWzCbgQrwwHxq6YOIFw1AqXky/Fh3M61b9wdvPCpNBSll
        0J0I4+8uV6ZVDP6hrjXM7SKNvo/vjE2G+3v49bzNQf/g+/7ikyDkf4QhGKD0jw==
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
Subject: [PATCH v6 0/3] media: i2c: Introduce driver for the TW9900 video decoder
Date:   Fri,  6 Oct 2023 18:25:27 +0200
Message-ID: <cover.1696608809.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This series is based on the fifth iteration of the series introducing the
tw9900 driver: sent 29 Dec 2020 [1]

This is the version 6 of the series adding support for the Techwell
TW9900 multi standard decoder. It's a pretty simple decoder compared to
the TW9910, since it doesn't have a built-in scaler/crop engine.

Changes v5 => v6:
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

 .../bindings/media/i2c/techwell,tw9900.yaml   |  61 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/media/i2c/Kconfig                     |  12 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/tw9900.c                    | 651 ++++++++++++++++++
 6 files changed, 733 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
 create mode 100644 drivers/media/i2c/tw9900.c

-- 
2.41.0

