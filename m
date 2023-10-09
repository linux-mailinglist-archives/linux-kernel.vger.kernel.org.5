Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F1D7BDD80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376825AbjJINKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376783AbjJINKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8197199;
        Mon,  9 Oct 2023 06:10:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9fAO043916;
        Mon, 9 Oct 2023 08:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856981;
        bh=fQWs9VXs/EFMa81HFqVvQ7AcwzMScQmDpt9Y1YYRhMk=;
        h=From:To:CC:Subject:Date;
        b=p/mGhrW7POCb77CvH8cZsQhUrKdh7HKGTG3+YKHCnLtZtL/W+t84WHU1wokMd488d
         XOnI76lBWLXTbSnS78fWKCQjhLXiJJiH7R6jX0KZOjNwMfWrRohz+lpN/4PmF48SfE
         KNB/5l5OUwg7+4S+4N8C1cnT0rMeVmHBQDZJM8jk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9ftS071449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9eRs096867;
        Mon, 9 Oct 2023 08:09:40 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v10 00/13] CSI2RX support on J721E and AM62
Date:   Mon, 9 Oct 2023 18:39:26 +0530
Message-ID: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3391; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=6YGZtFyLIzU9xYOZ/JJLwmb/7XGFfjk+RveyXJjS2nw=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/skdArrfMKehbiPmcy636DiM4e+idllKz77B
 sSNd5JRpRaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7JAAKCRBD3pH5JJpx
 RfPuD/9QLFpHfGxt3gFLdDGUQLLc92KraeVRH+cB8LdHpysbP99Rni3apobEqrlecbl0GkxUlRc
 VXI2Ssy+nHjaPPepEo1vUkLdgL4qNxIGax7GpezITmf2NCzv0tbpX6h2zlgSDpgWAnKWV96BG8P
 uC3H6EJTNbr3LstBbMoyGSxwDL241fCjw33vSJ/LaVblt1E8VgLh06BqzntLaOW4TvBda0ufCBw
 hVxNsjU+G5rjDlBX2T5YvkFDQpg118KF2oSn7BBzX7iBsMsli6+P6mjfxco1ADqxOqmQ8ZkB/Zv
 93sHjLOFIqQRZoMZ0gqBAu3inGNqV/FZ3+sD1SHUgQuB0fEhtXrhv+v0QojbQOaFdlvi82Ejtin
 nFpG7VeV/G0Bp5e8+qtEyEI4AFcFZJ3YYqMUJ44FpILHrSsPP6DiCGozdQKADOaJN678Wct+tkU
 oU0mrsaKyTEDmh0Nr6z8YObqgZqhMX8+nGt0G9/5Q/nbY+3xA7IrYMSpUxbX1tcyjhKhbSHpTNc
 rnexX7IJUG1Jf9G2xX6dajXr1H65ftoJi2BFd9fknHbCqogfx6Ex7QjLRn2aT3MIB5D58iHDE9X
 nx4+VBPVcj2JAHE8XIFwYRVxPFBMpN+YFGIP+3PlbU6n2E503nVBJaYo5A560baW37pIl3BFQbo
 YwF0bNj3PJblriA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

Hi,

This series adds support for CSI2 capture on J721E. It includes some
fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper driver.

J721E CSI2RX driver can also be extended to support multi-stream
capture, filtering different CSI Virtual Channels (VC) or Data Types
(DT) to different DMA channels. A WIP series based on v7 is available
for reference at https://github.com/jailuthra/linux/commits/csi_multi_wip

I will rebase the multi-stream patches on the current series (v10) and
post them after this series is merged.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---

Changes in v10:
===============

Range-diff: https://gist.github.com/jailuthra/dab73c3949a6271cf3d0fd3d3b111c5b

For [05/13] media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
- Remove redundant checks in set_fmt() as we ensure pad is SINK

For [13/13] media: ti: Add CSI2RX support for J721E
- Fix bug around YUV422 pixel ordering in setup_shim(). Now we
  passthrough the incoming order of pixels over MIPI (U->Y->V->Y etc.)
  when storing in memory
- Only allocate 32KiB of memory for the drain buffer, which is the upper
  bound of the PSI-L endpoint's internal FIFO storage (2048 x 128-bits)
- Allocate drain buffer in probe() instead of start_streaming()
- Set other colorspace/encoding properties in the initial device format
- Make the module compilable with COMPILE_TEST if Cadence dependencies
  are missing
- Address Laurent's review comments around naming and other minor
  comments
- Address Tomi's comments around better explaining the scenarios where
  DMA drain is required
- Change module/patch authorship to myself
- Link to v9: https://lore.kernel.org/r/20230811-upstream_csi-v9-0-8943f7a68a81@ti.com

---
Jai Luthra (2):
      media: dt-bindings: cadence-csi2rx: Add TI compatible string
      media: ti: Add CSI2RX support for J721E

Pratyush Yadav (11):
      media: dt-bindings: Make sure items in data-lanes are unique
      media: cadence: csi2rx: Unregister v4l2 async notifier
      media: cadence: csi2rx: Cleanup media entity properly
      media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
      media: cadence: csi2rx: Configure DPHY using link freq
      media: cadence: csi2rx: Soft reset the streams before starting capture
      media: cadence: csi2rx: Set the STOP bit when stopping a stream
      media: cadence: csi2rx: Fix stream data configuration
      media: cadence: csi2rx: Populate subdev devnode
      media: cadence: csi2rx: Add link validation
      media: dt-bindings: Add TI J721E CSI2RX

 .../devicetree/bindings/media/cdns,csi2rx.yaml     |    1 +
 .../bindings/media/ti,j721e-csi2rx-shim.yaml       |  100 ++
 .../bindings/media/video-interfaces.yaml           |    1 +
 MAINTAINERS                                        |    7 +
 drivers/media/platform/cadence/cdns-csi2rx.c       |  176 ++-
 drivers/media/platform/ti/Kconfig                  |   12 +
 drivers/media/platform/ti/Makefile                 |    1 +
 drivers/media/platform/ti/j721e-csi2rx/Makefile    |    2 +
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 1159 ++++++++++++++++++++
 9 files changed, 1452 insertions(+), 7 deletions(-)
---
base-commit: 2a860505b617cf8fda4ebff6cf05d3f774145440
change-id: 20230727-upstream_csi-acbeabe038d8

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>
