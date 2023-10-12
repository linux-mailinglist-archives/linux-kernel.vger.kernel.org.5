Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DAC7C6710
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378050AbjJLHkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347174AbjJLHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:40:45 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B635BB8;
        Thu, 12 Oct 2023 00:40:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 939D31BF213;
        Thu, 12 Oct 2023 07:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697096441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=heuK9wS/h1/ViEMBxRuLhXkO1DWVAWnfvQ+18TvSWvU=;
        b=DFFu+kfmRACXK4mcSTUWdCR7dGinlz6lcaC8WodAR0tD9NKtS2iXvKT1Q215rD7xb/fDV4
        1bFbVbFcOgHnxxY2vBRz5r6L7vAH898733+QMOTSadBZ2kNud0z01azXLs2zZHvN5xmBZF
        3oavn2NHYi+bcpq8G0CGbP0nvt7OJgQNQiV0VXkqYYeAASZwLQMT34oLPuAz2Qj4tbT6Y2
        9HJyvnVfsEIR+g1p2Qe/p2LkYjwyoevVUe0G6vkVTJfv+vKYg3H5yR5VfHpH4o7Gyx4iDv
        iUBCiIdY10PhmKrXfoYm20dkotoqkX5Bb4k7Z3xG7oT7fU/ro2EEnlzcKD771g==
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v3 0/3] Input: Add TouchNetix axiom touchscreen driver 
Date:   Thu, 12 Oct 2023 09:40:31 +0200
Message-Id: <20231012074034.1090436-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for the TouchNetix's axiom family of
touchscreen controller. This driver only support i2c
and can be later adapted for SPI and USB support.

---
Changes in v2:
 - Add device tree binding documentation
 - Move core functions in axiom_i2c as we only care about i2c support now
 - Use static function when required
 - Use syntax dev_err_probe()
 - Add an hardware based reset

Changes in v3:
 - Remove irq-gpios property in dt-binding
 - Use a generic node name
 - Fix issues reported in https://lore.kernel.org/oe-kbuild-all/202310100300.oAC2M62R-lkp@intel.com/

Kamel Bouhara (3):
  dt-bindings: vendor-prefixes: Add TouchNetix AS
  dt-bindings: input: Add TouchNetix axiom touchscreen
  Input: Add TouchNetix axiom i2c touchscreen driver

 .../touchscreen/touchnetix,axiom-ax54a.yaml   |  47 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/input/touchscreen/Kconfig             |  13 +
 drivers/input/touchscreen/Makefile            |   1 +
 .../input/touchscreen/touchnetix_axiom_i2c.c  | 740 ++++++++++++++++++
 6 files changed, 810 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,axiom-ax54a.yaml
 create mode 100644 drivers/input/touchscreen/touchnetix_axiom_i2c.c

-- 
2.25.1

