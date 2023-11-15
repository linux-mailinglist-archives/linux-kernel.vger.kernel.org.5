Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933087EC405
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbjKONqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344058AbjKONqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:46:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE331FA;
        Wed, 15 Nov 2023 05:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700055958; x=1731591958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eiHhnwxmDdZ6uny+ZcBXgoWY+2o1D01iokPBwa8lAqY=;
  b=QBT/K71t52GzIeVl+byh/5EVkQl3AymLPmObR231p3lUoIDRfWcTbdZP
   OsQGxVzVFHMTOQM+XKzKz5Yj9mUHHhuudBGKOiqcfReevLWFMH1AahOsZ
   v4KF7xi85pDShePB4xySO7uoWtsSxQM3A3utWM/lc/FQbnS7Oup/58FV8
   aF/uXZJviaYhGMV9z82HMckvR3gNKONRg1qxpIQeR3dhjX5WPXuQRh+mL
   GHNrBhUHlPvMdLeCPTjOCrC7nk15q+LUM5FQzXqdExTt+VCcrRKpfR2qz
   eP5jjL50uJrkEpB3NRXGthXumqrjj2drSXkMz1eVJ5ULn0TDm552XrJHQ
   Q==;
X-CSE-ConnectionGUID: LgQt6nmvRtWORLzOkR+vzg==
X-CSE-MsgGUID: xozfofjNR0uC+f6mWO+Xjw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12423813"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2023 06:45:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Nov 2023 06:44:59 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 15 Nov 2023 06:44:55 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v3 0/2] adding support for Microchip PAC193X Power Monitor
Date:   Wed, 15 Nov 2023 15:44:51 +0200
Message-ID: <20231115134453.6656-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip PAC193X series of Power Monitor with
Accumulator chip family. This driver covers the following part numbers:
 - PAC1931, PAC1932, PAC1933 and PAC1934

  This device is at the boundary between IIO and HWMON (if you are
looking just at the "shunt resistors, vsense, power, energy"). The
device also has ADC internally that can measure voltages (up to 4
channels) and also currents (up to 4 channels). The current is measured as
voltage across the shunt_resistor.

  I have started with a simple driver (this one that is more appropriate to be a
HWMON) and willing to add more functionality later (like data buffering that is quite
important for example if someone wants to profile power consumption of the
processor itself, or a peripheral device, or a battery, this kind of functionality
was requested by our customers).


Differences related to previous patch:

v3:
- this version was sent also to HWMON list
- fix review comments:
  - drop redundant description from device tree bindings
  - reorder "patternProperties:" to follow "properties:" in device tree bindings
  - update comments to proper describe code
  - use numbers instead of defines for clarity in some part of the code
  - use the new "guard(mutex)"
  - use "clamp()" instead of duplicating code
  - remove extra layer of checking in some switch cases
  - use "i2c_get_match_data()"
  - replace while with for loops for the code to look cleaner
  - reverse the logic to reduce indent.
  - add comment related to channels numbering
  - remove memory duplicate when creating dynamic channels
  - add "devm_add_action_or_reset" to handle the "cancel_delayed_work_sync"
  - remove "pac1934_remove()" function

v2:
- fix review comments:
  - change the device tree bindings
  - use label property
  - fix coding style issues
  - remove unused headers
  - use get_unaligned_bexx instead of own functions
  - change to use a system work queue
  - use probe_new instead of old probe

v1:
- first version committed to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding support for PAC193X
  iio: adc: adding support for PAC193x

 .../ABI/testing/sysfs-bus-iio-adc-pac1934     |   15 +
 .../bindings/iio/adc/microchip,pac1934.yaml   |  137 ++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1934.c                     | 1673 +++++++++++++++++
 6 files changed, 1845 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 create mode 100644 drivers/iio/adc/pac1934.c


base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec
-- 
2.34.1

