Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9735A778C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjHKKss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjHKKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595CCE5D;
        Fri, 11 Aug 2023 03:48:17 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlio3078824;
        Fri, 11 Aug 2023 05:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750864;
        bh=xOfFgp8W5fa2PrVW5Oxz961LyqTn+PRmPvgKBmd/s84=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=udT5D8zvGt8PyPhvY+Prccj7biKvc7ezdbenWGvjWzQcNY65QYXoJU1D/JRcmkwvc
         D6CmzrIZJmm3YPY5zSJlOQijhwJFdvzja6dxu99Qv03QuHZF/TlqfvEOzZLSfMcGG+
         jSDQhtuAV5UonUL/V1BzIbcNPOnMt0ydsD3iqGRg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAliMD001677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:44 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlh7D003039;
        Fri, 11 Aug 2023 05:47:44 -0500
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
Subject: [PATCH v9 03/13] media: cadence: csi2rx: Unregister v4l2 async notifier
Date:   Fri, 11 Aug 2023 16:17:25 +0530
Message-ID: <20230811-upstream_csi-v9-3-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=gMUqU3pgEA8SQEGG1sb5POX0tVGOuheDoKNlnkYS9JE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g74RxMBQh+RbAG6DMqbNXyxXGNMKn4M7E8Zg
 koskETnoy6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYO+AAKCRBD3pH5JJpx
 Rav3D/0ZAmAisNVb9ByYM+RfX4iS+8yBkfCvF+yHuBR27567425nrFZyIaQJ+4lHKP5JYmiWvRj
 53GgdEdvSGAza787xjO6p1G+j3W2sEe3SO/+pIwXZ0NhKkuORYeQ7qn0ADGyeiqic19Ce9jOHVu
 keUM1l/r4AroH6bfjGln3MfBKmdPAUNeX84DJSLwxbpoqQT6vLetvomD8tv+iXgGK4LeGSRLcYV
 sSsYimoR4IY2KpVfPjfq+3oz9xYjF9UWYWDBypGNFPDOA45JZHrkXy8FFgggpZyKvZrqZQgtbjr
 RYLAzFBsH0dqoJf5rDll21BTUNUaoCfOpaGDes7M2pAC5w9VBLH98qoqpNmCvx9rbaxC4xo4dCf
 kqFevY8+/tD5f7nGb6mt9ALAHERwNYcE4iAhW9Pq4kfM0fYaTPEqliZVhra8uf154T0OV2OigqY
 Pzq9TnFDHb00IaKBNlP3tOyrvhRGHbGQiskoj36H3kMvbg7UzJaNt+O344VepuNelwgaL0FxR7e
 5MsZnc99TfaPzWGod4GuOCer12e67TdVcSO6HqKbYyZ7pzV56kngHbLIMgwMEBTGZiteE8iQOab
 fJVidIwItNcHW6+uWTQEPOJ2knElE1gtJACyu40CawUtxrq+zVROYfvtzhldcZFMmJ93Jl/zCjq
 bJGWFH0sTwJBR2A==
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

The notifier is added to the global notifier list when registered. When
the module is removed, the struct csi2rx_priv in which the notifier is
embedded, is destroyed. As a result the notifier list has a reference to
a notifier that no longer exists. This causes invalid memory accesses
when the list is iterated over. Similar for when the probe fails.
Unregister and clean up the notifier to avoid this.

Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 0d879d71d818..9231ee7e9b3a 100644
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
