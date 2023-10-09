Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39C7BDD92
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376921AbjJINKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376788AbjJINKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:12 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E137DC6;
        Mon,  9 Oct 2023 06:10:09 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9wB3067976;
        Mon, 9 Oct 2023 08:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856998;
        bh=07dWCB21kyjDiChID1v5HFl8K/TwWhxZIuKPCitG0vg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BGuXCaK51VjDHP+GrftwE208jXP/YXXokTN3CL5Nv0OA+ByloTrnkragHLsYzJKDp
         oQWn1+VwYApYxSt69aqEmKu6Eq4JhImCu7l4AoD41z+wH/Orn3prUtFEMJbiNwfNm+
         IPzh4pQ0t4qxLGzIepgLroSmmGoAaCD/x+LX3/xg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9weH071560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:58 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:58 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9vHh055692;
        Mon, 9 Oct 2023 08:09:58 -0500
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
Subject: [PATCH v10 11/13] media: cadence: csi2rx: Add link validation
Date:   Mon, 9 Oct 2023 18:39:37 +0530
Message-ID: <20231009-upstream_csi-v10-11-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=zo2hhYXbGio5ee2AnO4qGHe/0axDO9Ru33qV+Q96O/g=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/sujDKPDTZgS8DjBKPkV3nZaRwdBaRViIeP5
 xP8SJiUx7OJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7LgAKCRBD3pH5JJpx
 RXWAEAC0/lEKXqIXdPmkqGm2QKz7hgG6egceWWJTskc/AhBUncWgdWa1OPpu/WUq1gj2ZIahjqq
 9Igkyu7Skk5cwW5nCdRn4PuADw4AX0Yt4gJ6WiOPh2knVYbavEjRalWfIkfb+I1DoQd4JvIxYUE
 Wwr4Y6eOi8dtYR4cOJuWRZ0uhq+XpO4i7ipEjYhUcfKFkY8K3RhvmBvkp+15AiMOlezbAgZeNcw
 fhR1859Gtv0ppmK7qISpVVDj4pjjgkMYr708y67uyz0RRpTLCQ60Fcge5pXpGCmaHIMUx9MZAih
 Nh5qAoQtv3kHmXsUswMvhtaGK/C7IzD1kza8b0ZguOWqtPnRKWgA5oYLXOQjEwGV8yd4PIzwVuy
 IaamnFjJVsushLfEFrPDuPcRpYS0Ai73SE0n2Iul0wnz6y2X19+j8QvXpPX3mODBUAILXtBXQRD
 opRpKrsRl56Rdv1nDdI1/xXfY82/DGefzjVdR6l9wEp/v/0KSc8U2y5SEabe8FatILDnPDGdQcR
 1bj47PpVA67K8S7FW0wY8WiKZ9jKJ0yXPdY8Gpp64Z6/0aLIn55pkxEvfOVX0IvTGN3wvLsTkET
 wTUCNQ8PQ8/rZOBbC6CKZCVUq7MUMIy9BP9Zsl5QS4dpcJmrImUhrwhwVNNC3eJOgQtMZ97lq56
 KRtvmIFgHqiVIJg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

Add media link validation to make sure incorrectly configured pipelines
are caught.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index d0c2a5b3d0d5..889f4fbbafb3 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -453,6 +453,10 @@ static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.pad		= &csi2rx_pad_ops,
 };
 
+static const struct media_entity_operations csi2rx_media_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
 			      struct v4l2_subdev *s_subdev,
 			      struct v4l2_async_connection *asd)
@@ -669,6 +673,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
 	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	csi2rx->subdev.entity.ops = &csi2rx_media_ops;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
 				     csi2rx->pads);

-- 
2.42.0
