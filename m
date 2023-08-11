Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E76778C54
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjHKKsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjHKKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4767EE53;
        Fri, 11 Aug 2023 03:48:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlsJY088947;
        Fri, 11 Aug 2023 05:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750874;
        bh=nPQpmhNAXW1LLTA0fwWZZgXRKUR2pBfrHqGeSLZDgv0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WbNtdYl/Umv1lR2HOnz2W0WJ3IhBhcvQOiA840zV/8LyjYKZp5wSUuuy8EBq52ycg
         /FpVnrTC0wnAeeSPj57QyG7wRTDmlJEtuOgRnUHO7ZNMWQM0HqHWcBREbv3HAg3gfM
         YD/ErpiFF6YVmFZ6KptX34upkS+esH9UUdYjnpZ4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlsfS014243
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:54 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlrVi060441;
        Fri, 11 Aug 2023 05:47:54 -0500
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
Subject: [PATCH v9 10/13] media: cadence: csi2rx: Populate subdev devnode
Date:   Fri, 11 Aug 2023 16:17:32 +0530
Message-ID: <20230811-upstream_csi-v9-10-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=b203Ekoz40FxqbxpktukhK/Sg/vekYHMnhpda+3LVRw=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g8HxPqkCyZReRH1HE9/cqvE7aD6AuMoBhzye
 UXjCdMcJO2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYPBwAKCRBD3pH5JJpx
 RdxEEACiH1MKgnmqWyEZWM5u3Do86SFGaJ4ZHzCY16lNThS71JkrXaFTGMvbztN4+v8kVjM6zIg
 483Hei7vC4N6XxyWN7+C7A7frJs8JZ9Ko3xKn9k/vsTOltmvLLGp/SnOD+J2P4WAglHMsPCaRRt
 JwxFtg88fcRV13ZOnOJ5YLTa0hLiGV04xPXk7hA9vRvTcxmTRtJMFOfpP8kVcSQnCGO3zPnvxE8
 dg823nrU2Y33V8TFRb2qGX+6mz3KUzK8lQ3j0Y6i4UZWtK2Hjb1BgWY50cQrKwaEj7wYU++DkXJ
 rItUE1x6/VZpE8vDNU2KCJsmtbONMMeEwg1KT3hBqtdNk2YLN0nTE7ibL0mDLSQdXN1S2jA9vjG
 4266P9OiZs4+7ePSJmt3XAwW9u4ZOS1sNR8Fnba047s5xEMu1iEEbi0geQT2T1Kmwnh+wcrZLuo
 +57JLv7gwF26x20Sokt1/yYhgWgDkPxcD2S/l8+te5Yrf1AicJqu9GIox3z6RfIp1+8xU5Ea8g2
 b6wa+e1DTuAPK6gLi1h+u7q+Fw9fjO8BcqSumE+wzO3teQmV9JCpQ0tAzpkMs76nvKv3yJ8qtQy
 CUPgKKGnF7g/La92HFL0Z1/irj3rwy/jrSsKtw21D8OQaO8XJ96+SVMVgn2rRXkCyVLCsCMFJzw
 S9ShLwothYx0gew==
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

The devnode can be used by media-ctl and other userspace tools to
perform configurations on the subdev. Without it, media-ctl returns
ENOENT when setting format on the sensor subdev.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 46effbbe580d..0947b112a573 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -673,6 +673,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	csi2rx->pads[CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
+	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
 				     csi2rx->pads);

-- 
2.41.0
