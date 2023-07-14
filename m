Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D67753E47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjGNPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGNPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:01:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3462A1BD4;
        Fri, 14 Jul 2023 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689346867; x=1720882867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DN8pikLzA6BKGJFJ0/ddibdPiHnym8Soac7IJbLzzqU=;
  b=prv0eMPfsOLNntJG8DE8ZwzQql9zxYnM1dINU+SBSaLo7Cv2YgtZIIVN
   KSy7VLc7V+tGf1s8y1S/2JlKstqF/6VjlywvvTwZjjvrP6M8j0kpVveTh
   Q4XezrHxnFaxyY0u6ubaNpcvS1av8hXXOATIthLcOOky7HIdWu0lt52/t
   TAfnjDG6rcoqTgAIDn8BzOqI/4xXVzTiud62tnRE82hpV2tF0kP+1bZsm
   N3Wui9HFTXOpZ1D6yxiN2yxTZXQvU6JGlUL69UhGG8D/uvwTudp/LX1i/
   i/XSAdycLR1HgAQ0PgTWuyA0GC5FzFdyAbleAWfnqcU1SFpII79QGJuMi
   g==;
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="161388909"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2023 08:01:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 14 Jul 2023 08:01:04 -0700
Received: from marius-VM.mshome.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 14 Jul 2023 08:01:02 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v2 0/2]  Adding support for Microchip MCP3564 ADC family
Date:   Fri, 14 Jul 2023 18:00:49 +0300
Message-ID: <20230714150051.637952-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
Delta-Sigma ADCs with an SPI interface. This driver covers the following part
numbers:
 - MCP3561, MCP3562, MCP3564, MCP3561R, MCP3562R, MCP3564R,
 - MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R and MCP3464R.

Differences related to previous patch:

v2:
- fix review comments:
  - change the device tree bindings
  - change the ADC channel creation (starting from DT)
  - use defines, masks and FIELD_PREP() instead of hardcoded values
  - mode the PGA from Hardware Gain to scale
  - add a current output channel from burnout current
  - fix coding style issues
  - use self explanatory naming to drop the comment
- renumbered the versioning (start with v1 instead of v0)

v1:
- first version comitted to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding MCP3564 ADC
  iio: adc: adding support for MCP3564 ADC

 .../ABI/testing/sysfs-bus-iio-adc-mcp3564     |   53 +
 .../bindings/iio/adc/microchip,mcp3564.yaml   |  197 +++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/mcp3564.c                     | 1485 +++++++++++++++++
 6 files changed, 1756 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
 create mode 100644 drivers/iio/adc/mcp3564.c


base-commit: 9e66fb52449538406cea43e9f3889c391350e76e
-- 
2.34.1

