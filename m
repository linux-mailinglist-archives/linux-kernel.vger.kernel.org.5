Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2E752F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjGNB5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjGNB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:57:04 -0400
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8E26B6;
        Thu, 13 Jul 2023 18:56:59 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 36E1uCgC1084344; Fri, 14 Jul 2023 10:56:13 +0900
X-Iguazu-Qid: 2rWhi9UHcEbYlR9lW3
X-Iguazu-QSIG: v=2; s=0; t=1689299772; q=2rWhi9UHcEbYlR9lW3; m=43hAoOCKXSmeGj4iLauW6WIfO2gm+jCjuvAviDCTHSg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1121) id 36E1uAqr2652074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Jul 2023 10:56:10 +0900
X-SA-MID: 3648343
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Mark Brown <broonie@kernel.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Add Toshiba Visconti Video Input Interface driver
Date:   Fri, 14 Jul 2023 10:50:54 +0900
X-TSB-HOP2: ON
Message-Id: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the Video Input Interface driver
for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation,
device driver, documentation and MAINTAINER files.

A visconti VIIF driver instance exposes
1 media control device file and 3 video device files
for a VIIF hardware.
Detailed HW/SW are described in documentation directory.
The VIIF hardware has CSI2 receiver,
image signal processor and DMAC inside.
The subdevice for image signal processor provides
vendor specific V4L2 controls.

The device driver depends on two other drivers under development;
clock framework driver and IOMMU driver.
Corresponding features will be added later.

Best regards,
Yuji

Changelog v2:
- Resend v1 because a patch exceeds size limit.

Changelog v3:
- Add documentation to describe SW and HW
- Adapted to media control framework
- Introduced ISP subdevice, capture device
- Remove private IOCTLs and add vendor specific V4L2 controls
- Change function name avoiding camelcase and uppercase letters

Changelog v4:
- Split patches because a patch exceeds size limit
- fix dt-bindings document
- stop specifying ID numbers for driver instance explicitly at device tree
- use pm_runtime to trigger initialization of HW
  along with open/close of device files.
- add a entry for a header file at MAINTAINERS file

Changelog v5:
- Fix coding style problem in viif.c (patch 2/6)

Changelog v6:
- add register definition of BUS-IF and MPU in dt-bindings
- add CSI2RX subdevice (separeted from ISP subdevice)
- change directory layout (moved to media/platform/toshiba/visconti)
- change source file layout (removed hwd_xxxx.c)
- pointer to userland memory is removed from uAPI parameters
- change register access (from struct style to macro style)
- remove unused macros

Changelog v7:
- remove redundant "bindings" from header and description text
- fix multiline text of "description"
- change "compatible" to "visconti5-viif"
- explicitly define allowed properties for port::endpoint
- remove unused variables
- update kerneldoc comments
- update references to headers

Yuji Ishikawa (5):
  dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
    Input Interface
  media: platform: visconti: Add Toshiba Visconti Video Input Interface
    driver
  media: add V4L2 vendor specific control handlers
  documentation: media: add documentation for Toshiba Visconti Video
    Input Interface driver
  MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface

 .../bindings/media/toshiba,visconti-viif.yaml |  108 +
 .../driver-api/media/drivers/index.rst        |    1 +
 .../media/drivers/visconti-viif.rst           |  462 +++
 MAINTAINERS                                   |    4 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/toshiba/Kconfig        |    6 +
 drivers/media/platform/toshiba/Makefile       |    2 +
 .../media/platform/toshiba/visconti/Kconfig   |   18 +
 .../media/platform/toshiba/visconti/Makefile  |    8 +
 .../media/platform/toshiba/visconti/viif.c    |  681 ++++
 .../media/platform/toshiba/visconti/viif.h    |  375 ++
 .../platform/toshiba/visconti/viif_capture.c  | 1485 +++++++
 .../platform/toshiba/visconti/viif_capture.h  |   22 +
 .../platform/toshiba/visconti/viif_common.c   |  199 +
 .../platform/toshiba/visconti/viif_common.h   |   38 +
 .../platform/toshiba/visconti/viif_controls.c | 3407 +++++++++++++++++
 .../platform/toshiba/visconti/viif_controls.h |   18 +
 .../platform/toshiba/visconti/viif_csi2rx.c   |  684 ++++
 .../platform/toshiba/visconti/viif_csi2rx.h   |   24 +
 .../toshiba/visconti/viif_csi2rx_regs.h       |  102 +
 .../platform/toshiba/visconti/viif_isp.c      | 1258 ++++++
 .../platform/toshiba/visconti/viif_isp.h      |   24 +
 .../platform/toshiba/visconti/viif_regs.h     |  716 ++++
 include/uapi/linux/v4l2-controls.h            |    6 +
 include/uapi/linux/visconti_viif.h            | 1800 +++++++++
 26 files changed, 11450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 create mode 100644 Documentation/driver-api/media/drivers/visconti-viif.rst
 create mode 100644 drivers/media/platform/toshiba/Kconfig
 create mode 100644 drivers/media/platform/toshiba/Makefile
 create mode 100644 drivers/media/platform/toshiba/visconti/Kconfig
 create mode 100644 drivers/media/platform/toshiba/visconti/Makefile
 create mode 100644 drivers/media/platform/toshiba/visconti/viif.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_capture.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_capture.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_common.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_common.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx_regs.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_isp.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_isp.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_regs.h
 create mode 100644 include/uapi/linux/visconti_viif.h

-- 
2.25.1


