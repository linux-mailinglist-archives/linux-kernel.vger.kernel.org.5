Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F246578C8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjH2Plu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbjH2Plq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:41:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B397B7;
        Tue, 29 Aug 2023 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693323703; x=1724859703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pdr0sftGrPphXPtHMuVYdts5IRbmpNKMw4fj5ixMmVw=;
  b=X9oOeoDRrPiN5yU8XxGYI/zG2S3gTU+Gba53Dwd4hAGPHvzI8EK/AbOg
   nS3OihGhi3SPjgvI8S67MEQTsGAwTtmxAEJyryW2M0rRYZgEDsgzd8NgM
   5ku35S7csuLhfb/LRhgIJV3AQnQ3h4RyJ136Tluwf87uMyJ/4yD7oLguD
   H7HbBxSmlFSysBM9OeecdpFKGs72KSFiULqJ2yaqfoBnV+5Omo1cHtELr
   DoLoEWlb7WRBOeC6naw2p46L9NsMtu3owW4XerJ0rTI/aUHtY/3j5Wnlo
   UOqLfUcmSXFKXoH5FTKMeezHPsKsLLqdeUvEZjLkl2rX/oQ8WGu6krGHD
   A==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1836118"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 08:41:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 08:41:38 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 29 Aug 2023 08:41:36 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v5 0/2] Adding support for Microchip MCP3564 ADC family
Date:   Tue, 29 Aug 2023 18:41:31 +0300
Message-ID: <20230829154133.40716-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
v5:
- fix review comments from v4:
  -  fix coding stile
  - remove some of the _SET defines
  - flip logic to cut down on indent in some cases
  - update "mcp3564_update_8bits" function to be more clear

v4:
- fix review comments from v3:
  - adding label names for channels into the example from the
    "microchip,mcp3564.yaml" file  
  - update defines names (with _REG and _MASK)
  - code clean-up
  - flip logic to cut down on indent in some cases
  - use "spi_get_device_match_data" instead of "device_get_match_data"
  - remove some unnecessary _SET functions
- change "boost_current" attribute to "boost_current_gain". The
  attribute is a gain not an absolute value.
- change "boost_current_available" attribute to
  "boost_current_gain_available"
- update comment from v3 (to better describe the change) "fallback compatible
  in device tree to deal with some newer part number" to "stop failing to
  probe when the chip id is not recognized. In this case a fallback
  compatible has been used to support a new part number"

v3:
- fix review comments:
  - fix and update the device tree bindings
  - enable "auto_zeroing_ref_enable" attribute only
    when internal reference is used
  - remove unused headers
  - fix comments (kernel-docs)
  - remove scan_type
  - replace "extend_name" with read_label
  - print label for each channel (label could be added into the dt)
  - add comment to explain the maximum channels numbers
  - add protection around critical region
  - stop failing to probe when the chip id is not recognized. In this
    case a fallback compatible has been used to support a new part number


- Open questions:
  - whether or not to add a spi-mux type of thing to deal with the part number
    address in case there are multiple devices connected to the same chip
    select.
  - discussion related to the "custom property". Last time around a consensus
    wasn't reached.

v2:
- fix review comments:
  - change the device tree bindings
  - change the ADC channel creation (starting from DT)
  - use defines, masks and FIELD_PREP() instead of hardcoded values
  - mode the PGA from Hardware Gain to scale
  - add a current output channel from burnout current
  - fix coding style issues
  - use self-explanatory naming to drop the comment
- renumbered the versioning (start with v1 instead of v0)

v1:
- first version committed to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding MCP3564 ADC
  iio: adc: adding support for MCP3564 ADC

 .../ABI/testing/sysfs-bus-iio-adc-mcp3564     |   53 +
 .../bindings/iio/adc/microchip,mcp3564.yaml   |  205 +++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/mcp3564.c                     | 1516 +++++++++++++++++
 6 files changed, 1795 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
 create mode 100644 drivers/iio/adc/mcp3564.c


base-commit: 9e66fb52449538406cea43e9f3889c391350e76e
-- 
2.34.1

