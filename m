Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08347F3F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjKVHwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjKVHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:52:41 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56210E;
        Tue, 21 Nov 2023 23:52:34 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AM7eWqH015195;
        Wed, 22 Nov 2023 08:52:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=fPjoVWK
        AOHk+Zx85zrTcGB3/yrl3T4i+z4waWY9BkaY=; b=TrsM7SfFoMO0rFWCIBrD63K
        jtBb3YpN0SSqZ/F+4iCghP43GF2K0xmuMsoWrLOkLRbXbFRnFceWVIXaWC04REXw
        HDb/iHn7cRS+AGyqvdQeX7qsxBFy4b+q30rtTv/H1evej2EIQNOkSw7OJLGCYpcm
        QtkZPZABNJhI8RRuKtq80nrG7PxIq0I9rj+UW7taTUtcFvCPtf5deLEE3IfT0Tft
        ZJCMd8wsTAB1zcGCSggtNJHoGTKNskQjU8Q02uMpWKUfOvgmOkdjqE5MPVuW3zno
        ziJb6GhnEqQwethHVyT7nntKpc1JNDO6E9+iypmIdLb+KUxcK+tB77AdNcdUagg=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uf7q5hpbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 08:52:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B30810002A;
        Wed, 22 Nov 2023 08:52:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 426E62128AF;
        Wed, 22 Nov 2023 08:52:22 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 22 Nov
 2023 08:52:22 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Pavel Machek <pavel@ucw.cz>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Rob Herring <robh@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/3] media: i2c: gc2145: GC2145 sensor support
Date:   Wed, 22 Nov 2023 08:51:46 +0100
Message-ID: <20231122075154.789431-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds support for the GalaxyCore GC2145 sensor.
Initialization is based on scripts provided by GalaxyCore,
allowing 3 fixed configurations supported for the time being.

Minimum controls have been added in order to allow it to
be successfully used with libcamera and dcmipp driver (under
review) on STM32MP13 platform.

The sensor also supports Bayer formats which will be added
later on.

v5: - serie rebased on top of master branch of tree sailus/media_tree.git
      in order to use v4l2_subdev_state_* functions

v4: - bindings: add link-frequencies & correct description
    - driver: add link-frequency ctrl and fix pixelrate
      and check for link-frequency dt properties
    - driver: correct wording / email / add datasheet link

v3: - fix copyright year
    - add more gc2145_ func or variable prefixes
    - removal of colorspace within struct gc2145_format
    - use 1X16 formats since driver is supporting CSI-2 interface only
    - use msleep instead of usleep_range
    - add pm_runtime_ last_busy & autosuspend handling
    - only start streaming AFTER applying ctrls
    - correct RGB565 format to generate _LE instead of _BE
    - perform pm_runtime configuration prior to v4l2_async_register_subdev_sensor
    - remove frame_interval handling and expose HBLANK/VBLANK ctrls
      instead

v2: - split vendor-prefixes update into a separate commit
    - correction into dt-bindings (description, const i2c address,
      lowcase of supplies, node naming
    - correct KConfig (avoid VIDEO_V4L2_SUBDEV_API, V4L2_FWNODE and add
      V4L2_CCI_I2C)
    - usage of v4l2-cci framework for accessing to device registers
    - correction in power-on / power-off sequences and update
      usleep_range delay
    - detail MIPI configuration and stop register access to stop
      streaming
    - removal of SYSTEM_SLEEP_PM_OPS (and streaming variable)
    - various small fixes, typo, oneline functions
    - removal of useless HBLANK control considereing that RAW isn't
      supported for the time being
    - removal of RAW parts
    - usage of dev_err_probe

Alain Volmat (3):
  dt-bindings: vendor-prefixes: Add prefix for GalaxyCore Inc.
  dt-bindings: media: i2c: add galaxycore,gc2145 dt-bindings
  media: i2c: gc2145: Galaxy Core GC2145 sensor support

 .../bindings/media/i2c/galaxycore,gc2145.yaml |  113 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc2145.c                    | 1446 +++++++++++++++++
 6 files changed, 1580 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
 create mode 100644 drivers/media/i2c/gc2145.c

-- 
2.25.1

