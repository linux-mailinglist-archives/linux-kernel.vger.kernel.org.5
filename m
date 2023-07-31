Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4D76902A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjGaIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGaI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F0127;
        Mon, 31 Jul 2023 01:29:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Tetc038392;
        Mon, 31 Jul 2023 03:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792180;
        bh=XCLhxGIh0JMo06o/BSCav3HQdiHa7RMxdoLTIchqhEM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fVCyuHRUuCHk3JvHH59qrMM46e3S6FPn0KPSIeii3/qWyn711v/1+2Ih3FNGJ4Zu9
         wbGJBTpHkqwj2E92VLDvXpvaNrgPs6LC1H9/HFRJVOQAmcK7iGcW6M7hZ1njg6xNqV
         JYCusBFLmGLOKjKQBlBctFvrycRhGrMVmn9Ip9jY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8TeP2087116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Tcll041877;
        Mon, 31 Jul 2023 03:29:39 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 05/16] media: cadence: csi2rx: Unregister v4l2 async notifier
Date:   Mon, 31 Jul 2023 13:59:23 +0530
Message-ID: <20230731-upstream_csi-v8-5-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=+YOzaFzKohVYP5/t2gn60sO0ibX33jElyGn3hPBpAhI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xn/UaZtrwZ4+2f3CzegNcUSOS6sBYFG007b
 a77xSczFEaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsZwAKCRBD3pH5JJpx
 Ra5jD/0TqyaKA+b83CHJ1HPeha7SDdH5GpICOomliq/F3IURrIFM2MwsaWLIO4URUuHEpxcp7oS
 p5+gxHzGCwsdBgy6hH+UV50X2hnLOWnJAlP0CBUZKl5VDohglN9F64A7Mk6QvGHn/Wn7hh2GbO6
 0XcwvenndaxhVlw8LC9EAbcHcvQWCW6ZSFql7MZjDoXtJwdYFQNCB1eYEp1sFm+Fvj5+Fiql76a
 hLSHXAoOHYxAolvUvZLjOttNUd3kzfql7T/NOOduFDVJtFar/R6qxh2CnOJARSQa2XyCC6PRlA9
 vLc0/q40lfT23sx31fe7vrnJ7JJ4qb+cGTod7HAveMkLpmQewfVh3+QbeIsaBl4E5FiM0Kr5VHa
 461m9x8TmyKiQYW6g9KIBlQdaPt+i4DLg4IkcVLYoeCHV83eflDfu81OypknogiY8beA7lEekym
 BQ/2kmq98mlPbJsJD2Jso0frx/7DVU6SFEn9aAzVzc0wR7ChikNQYUGoHhKxZbrbW+efKCRWQuJ
 maqZ2I4XIpOObVwlRuljqdQ/bWrK0FdlARmfSoyBuErjLwp5sCUIZYqaaafXwi2FCRadUVhX+p1
 LPUW2eDpxpOPpn98xng91g1ACG8ONDOsSkHCV3H8JQM/bhavyLBbg6o50bmuyAwAprkH6sclTus
 8H5z0E++kLY/bvw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

The notifier is added to the global notifier list when registered. When
the module is removed, the struct csi2rx_priv in which the notifier is
embedded, is destroyed. As a result the notifier list has a reference to
a notifier that no longer exists. This causes invalid memory accesses
when the list is iterated over. Similar for when the probe fails.
Unregister and clean up the notifier to avoid this.

Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v7->v8: No change

 drivers/media/platform/cadence/cdns-csi2rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index b087583d636f..fd6f2e04e77f 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -479,8 +479,10 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
 	asd = v4l2_async_nf_add_fwnode_remote(&csi2rx->notifier, fwh,
 					      struct v4l2_async_connection);
 	of_node_put(ep);
-	if (IS_ERR(asd))
+	if (IS_ERR(asd)) {
+		v4l2_async_nf_cleanup(&csi2rx->notifier);
 		return PTR_ERR(asd);
+	}
 
 	csi2rx->notifier.ops = &csi2rx_notifier_ops;
 
@@ -543,6 +545,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	return 0;
 
 err_cleanup:
+	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
 err_free_priv:
 	kfree(csi2rx);
@@ -553,6 +556,8 @@ static void csi2rx_remove(struct platform_device *pdev)
 {
 	struct csi2rx_priv *csi2rx = platform_get_drvdata(pdev);
 
+	v4l2_async_nf_unregister(&csi2rx->notifier);
+	v4l2_async_nf_cleanup(&csi2rx->notifier);
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
 	kfree(csi2rx);
 }

-- 
2.41.0
