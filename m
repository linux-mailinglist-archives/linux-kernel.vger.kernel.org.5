Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8E7FD95C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjK2O3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjK2O3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:29:08 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4FF197;
        Wed, 29 Nov 2023 06:29:14 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9F0DFF806;
        Wed, 29 Nov 2023 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701268153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FBe4Dzvbp9G6y5FdkNNaW8c1rBGR1yDYU7Bf04zl9co=;
        b=D3+fsK8PuCZ+x5Brl5D2kD+/MRaCPqjrL47+jeHSJzpbBIOcDEWwr9G8KQYnH8KlIno5E3
        IP2/s10jfrs+LW38zVGmGjjwkn5cnm7uBNWoRcumD8tISBsbA74JXM6AG6I6DD53wr7AHq
        lmrgE2NUAcBqdQ+Xf5xNqb8KRaYkz4qQra7tueBpZGSEjhp9RLN9B1o+oy9dEqQgb1vJPR
        0A0ovsicJanfwhodeSyPAT4l7eE7DNs30pYAF+RL3ovfIpbEQesQF14WjLO9JM/U/8vghF
        1XTRJLRZYmCwRc8xU9Ku40fXIWZlRMlDoAZlgVxbhacdvDSVO0GRw9xFFMhNFg==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        luca.ceresoli@bootlin.com, paul.kocialkowski@bootlin.com,
        dri-devel@lists.freedesktop.org, geert@linux-m68k.org,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH 0/2] drm/tiny: Add driver for the sharp LS027B7DH01 Memory LCD
Date:   Wed, 29 Nov 2023 15:29:08 +0100
Message-ID: <cover.1701267411.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a DRM driver for the sharp LS027B7DH01 memory display:
a 2.7" 400x240 monochrome 1 bit per pixel display SPI device.

This controller uses SPI both for control and for pixel data. Pixel data can be
sent either as one line per SPI frame or multiple lines (up to the entire picture)
in a single SPI frame. This driver implements the latter.

The Sharp Memory LCD requires an alternating signal to prevent the buildup of
a DC bias that would result in a Display that no longer can be updated. Two
modes for the generation of this signal are supported:

- Software, EXTMODE = Low: toggling the BIT(1) of the Command and writing it at
  least once a second to the display.

- Hardware, EXTMODE = High: the alternating signal should be supplied on the
  EXTCOMIN pin.

the Hardware mode is implemented with a PWM signal.

The driver announces the commonly supported XRGB8888 to userspace and
uses the drm_fb_xrgb8888_to_mono() function to convert the format.

Mehdi Djait (2):
  dt-bindings: display: Add Sharp LS027B7DH01 Memory LCD
  drm/tiny: Add driver for the sharp LS027B7DH01 Memory LCD

 .../bindings/display/sharp,ls027b7dh01.yaml   |  71 +++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/tiny/Kconfig                  |   8 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/sharp-ls027b7dh01.c      | 411 ++++++++++++++++++
 5 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls027b7dh01.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-ls027b7dh01.c

-- 
2.41.0

