Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73B17BDD82
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376849AbjJINKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376790AbjJINKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE449C;
        Mon,  9 Oct 2023 06:10:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9khl043928;
        Mon, 9 Oct 2023 08:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856986;
        bh=4FfPwCB/CMrbMGKnvI3/6dyXUCw/bzYzkHRahhDgvUM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cjnPclDTIweoFDdjSZi1ghXD2LOHszCdfNHOiHixZI6mIuSlEgfTqOmDpMiNumqGA
         r5k51QzkPQ21usrkTIikU4Lcfa4tfLDHrrzAkyA33ELrFaxvTpfv6LWFQylz3sOuIy
         hf4CsfAUIb8/MxPLChlAv/DJDxoLibPMTpks+AO0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9kNg076979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:46 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9jx9007173;
        Mon, 9 Oct 2023 08:09:45 -0500
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
Subject: [PATCH v10 03/13] media: cadence: csi2rx: Unregister v4l2 async notifier
Date:   Mon, 9 Oct 2023 18:39:29 +0530
Message-ID: <20231009-upstream_csi-v10-3-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=1dJfXJfqhjtT9EYR9IVfaCzIQ6DWNfmI/vFzK18yFgs=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/snGI5M5/tW7zk6T4eL361rRn+EcUxDcq+E2
 ncHfr0MQ8iJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7JwAKCRBD3pH5JJpx
 RaAtD/0RsVBMopQMWLwpxU4C8iJlHiA3D85TWroerbK0b/kmdaOhEW4g/yybms+LFbDYJvGhBOa
 1grZgBQT29piHIGWsMj51TSxwv0qTWNTNyEaa4zUptdvUtavo9uTT6E4uxmLY1IBtC3eZ6OAVTE
 6H9URPB8cGEIfp3OjzuPB9mb9u+DQPZtjB0upaQZiyNafyoGA0hh5BJRIU4OGkPk2hq+0pN8eju
 hdXRM/Ue3Kx5DjTOA9McoVdgJtHwWaFJz+6I7un1LGAxPhuh6DfcNOXGoA/QA4ulhhdofOZXLFg
 bXGiqxFUBrfDgWxZuGyVuRBuoSio3hvIQBDqnBzbE53/ipsOlLuT1CnqFdHGkqUbHcua9kSG3UH
 LQ8Rn31ZAuJfAHKMwxcEd/+hhg01DGgk9N97vaaZ4VFmHvkLr9FyC4Qy7A0eoWQ2E27dO+GqcTw
 nrIy+ngmtftzufeSJ1/45fRm/pxLS60rWJrVirMcP7aL8tzVQFvFJ07pgoNj0gg2z/md2pyfPhT
 ZdFJxafMXQ6jncMetjx1P1+4M+IkTxOlfCGjmlQbxuHUD9iOndpJD78OSZC2WSuEOUGVoiI+IJO
 dYgVMYwY1LH8ejGuzLYfqXxSsl4wBjPMj8zzFz4Y2q6PVPy4/wNxdExdpeRisja2BH+x+ZCyEwm
 0yh6qB7aiRFNb+Q==
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

The notifier is added to the global notifier list when registered. When
the module is removed, the struct csi2rx_priv in which the notifier is
embedded, is destroyed. As a result the notifier list has a reference to
a notifier that no longer exists. This causes invalid memory accesses
when the list is iterated over. Similar for when the probe fails.
Unregister and clean up the notifier to avoid this.

Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index b9d9058e2ce3..64e472ca3594 100644
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
2.42.0
