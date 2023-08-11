Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B2778C62
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjHKKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjHKKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:22 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B1E52;
        Fri, 11 Aug 2023 03:48:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlecL078804;
        Fri, 11 Aug 2023 05:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750860;
        bh=gWdzohStJakm8fkiUaFNT/N6HgY5M+Mg9KxrYsNgKY8=;
        h=From:To:CC:Subject:Date;
        b=ygugaX7yJsQQiIP4bowxk+kvPZQbYVW2ZMiYsiwV8GNGwHD8FrUYeWf153qzay7LE
         mlFvCuf3dPYS7S1WNDd3kMLNQNu0J/VOTcQ9B8b4znNr4irT5lAmy0ktGFWmHBbj42
         13WlC4rKBWOo30ORm05sFEq2VOrw3pQChY2ozAxo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAleKb110647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:40 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:39 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlcMs008153;
        Fri, 11 Aug 2023 05:47:39 -0500
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
Subject: [PATCH v9 00/13] CSI2RX support on J721E and AM62
Date:   Fri, 11 Aug 2023 16:17:22 +0530
Message-ID: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=A6DGSRxxAnDtk2gp8ks/OfUKwbpzv+G2XLoFgp2gxyI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g7xHLBPfJIO1L8TK4tpV5NjpwwsaVKRe8JWN
 ZbAmAyw+DeJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYO8QAKCRBD3pH5JJpx
 RXnPD/9tEogxFv/j/ywArVFE09Tgdm+i1/dt6g9UiNoLvTNy/VUOg8EUurtnzzyXYblMcvRrNxY
 oF38LMa9YeiPyfEKQz46BW3bcAGl4XnV/wymPc6X7Vd2KIsmyLNKi8LRQZryKJ7eqVW/bpOp75q
 6iaYTnvxuJa+rXla8z0AQb59Y4uku31NjjuJxIzXq+Gtu7mtBndeNud2+ZCxMlj/56RHzEYJHYr
 Ux8zdpDazhI5aA02r2n7bbWwnuKzdUQf6us2j7yU/cblebSOPsZutF1Taqo/5PnPLidQLudBjNe
 kjcuXYANVl4wrkGqBOWv5UVeuO7q0yp/VqM2+4ovZkfEwySr6VwkLKNmznx7pOBQmWxbzvPYcX5
 a/vbiTq79MJde1PlJwW0bGrId9ViNv6iJMcOJQbLR82cK+gnJak5B0GhTGJXjyrU4yMPY7bpEWj
 cmA2wbOPZMQUYfJ9hSuOJoFBWddr0YF+tBIMKr3061WVPjJ6sckw7TaUFPqCPqU0QV1EVhFx7GE
 63+idltGqnnGEeS7RcS92OIypi69JUTrxKVdknHsWQSNLEAvsZwNwwM4iJR8//KzqTvDh+UsOQ9
 0akxBXW2Rdiz8mIarZ/k+6mC4JFypXNM2mqc9RU+njXp+4qgyzCYPvpSmsg+yf9FcgUh9zQi3AP
 2Xu45WN4tvWdX9Q==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

Hi,

This series adds support for CSI2 capture on J721E. It includes some
fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper driver.

This is the v9 of the below v8 series,
https://lore.kernel.org/r/20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com

Testing logs: https://gist.github.com/jailuthra/eaeb3af3c65b67e1bc0d5db28180131d

J721E CSI2RX driver can also be extended to support multi-stream
capture, filtering different CSI Virtual Channels (VC) or Data Types
(DT) to different DMA channels. A WIP series based on v7 is available
for reference at https://github.com/jailuthra/linux/commits/csi_multi_wip

I will rebase the multi-stream patches on the current series (v9) and
post them as RFC in the coming weeks.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---

Changelog from v8
=================

Range-diff: https://0x0.st/H_xh.diff

Dropped the following patches:
[v8 01/16] media: subdev: Export get_format helper for link validation
	- Using subdev's get_fmt directly instead
[v8 04/16] media: cadence: Add support for TI SoCs
	- Don't add a compatible if we are not using it in the driver
[v8 14/16] media: cadence: csi2rx: Support RAW8 and RAW10 formats
	- Squashed into a previous patch [v8 07/16]

For [05/13] media: cadence: csi2rx: Add get_fmt and set_fmt pad ops:
- Squash the patch adding RAW8 and RAW10 formats within this one
- Single line struct entries in formats[] array
- Skip specifiying redundant format.which entry in init_cfg()

For [06/13] media: cadence: csi2rx: Configure DPHY using link freq:
- Don't specify stream while calling .get_fmt()

For [07/13] media: cadence: csi2rx: Soft reset the streams before starting capture:
- Simplify reset sequence, minimizing delays

For [08/13] media: cadence: csi2rx: Set the STOP bit when stopping a stream:
- Better log message to avoid confusion between cadence streams and v4l2
  streams

For [13/13] media: ti: Add CSI2RX support for J721E:
- Allocate drain buffer at start of stream instead of doing it in the
  middle, and document why it is needed in comments
- Call subdev's get_fmt directly for link_validation()
- Cleanup height/width clamping and rounding code, document it in comments
- Return and check errors from setup_shim()
- s/subdev/source for cadence csi2rx's v4l2_subdev
- s/ti_csi2rx_init_subdev/ti_csi2rx_notifier_register
- Change copyright year/author list

---
Jai Luthra (1):
      media: dt-bindings: cadence-csi2rx: Add TI compatible string

Pratyush Yadav (12):
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
      media: ti: Add CSI2RX support for J721E

 .../devicetree/bindings/media/cdns,csi2rx.yaml     |    1 +
 .../bindings/media/ti,j721e-csi2rx-shim.yaml       |  100 ++
 .../bindings/media/video-interfaces.yaml           |    1 +
 MAINTAINERS                                        |    7 +
 drivers/media/platform/cadence/cdns-csi2rx.c       |  181 ++-
 drivers/media/platform/ti/Kconfig                  |   12 +
 drivers/media/platform/ti/Makefile                 |    1 +
 drivers/media/platform/ti/j721e-csi2rx/Makefile    |    2 +
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 1150 ++++++++++++++++++++
 9 files changed, 1448 insertions(+), 7 deletions(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230727-upstream_csi-acbeabe038d8

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>
