Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9BA7BDD8D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376684AbjJINKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376809AbjJINKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835DB6;
        Mon,  9 Oct 2023 06:10:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9lqO067927;
        Mon, 9 Oct 2023 08:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856987;
        bh=CV36wgcU/HLXBVGVMd9iVHL8DT1YkN+Xfgsfa3xX9x8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dgsaxSEcdcpN2PjibxRa5+3ngC9mQETVpIYjtI+VVe9/jWrIPo+Lr0OwWLOOmvRqX
         EpDDo6fRYFV/QywxLGfk9wM0ONP4bs9ozsxAHcaJQdoc1QF95jZeg/u1JvJrEUh7pd
         WNDeLdofh2jANhlHyx3gVuz0HGfcXPCa7N5Q8dAI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9lq9071516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:47 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9kYZ007220;
        Mon, 9 Oct 2023 08:09:47 -0500
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
Subject: [PATCH v10 04/13] media: cadence: csi2rx: Cleanup media entity properly
Date:   Mon, 9 Oct 2023 18:39:30 +0530
Message-ID: <20231009-upstream_csi-v10-4-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=H/tqA+nD3NGE1eGbYGM3sFZkNgmvZBDs5F3fkDcglS8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/soM+r1Abx3POL55vGgtgNp8ipGOuaEErKcS
 St/el2ZgeeJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7KAAKCRBD3pH5JJpx
 RQiWD/0Vi/7XZI+N67WWGCQ2/h8GgvfJLjRiLzj0TTUoBt1A6QgXcZD7scqg31TGrTbrIHPAvx8
 rHnaz6ZKE/1p9BxitVGsgVuIxEsXlZSspJA3lsGiHOCvnxkiFkrLLO68iYqcjdAcr2tvfOjrZye
 HmZW25ueDRVmFpRlfqvP5JLvMHCX6h1QKncIO0ZileirmvVsKC1bbpFz7LdVGE1uOIiH2v5o/WK
 hupzvamqUp6f1c0+3QgaIUxetYw9hr39tQNh2svBCpgbtwHPxyYPYwE7l2woM92WaWjw3JVBm5/
 wcFMdAToIGgqCVIxXUouEUrxjPhkJxyfO3f55LoidBnEsV4yT8whrjNf2YFTpfiakk+zt0mT3cR
 JGQS4vRVUw3E0ss6l/PIk83iHRmSlcXj4k3xzTJ8t1s0wyA0Cjd3cbkXSaOTRibhAskP3h3iBNW
 VZUilDN62HRBEKDYfLLRm6C0tdSgzwjHKxD4D0vkl7QGqRH5QKCy38UW/n21cx9TR5k3qSrgjrp
 ZP57OQkacsQlqJsAXf/ebltO4mvPZyWJz35/HM6T43Ixjz90SNv0zR4GrsGcUsoxONRjScw0UeD
 e/I5eBEexLppIqhII1F0tm0JgvoarWnGiJN4Aw760Rfr6mhtc0BIfaRC9vD9uvvcVKTfL9hcMIn
 subRbnDwSZS9pvQ==
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

Call media_entity_cleanup() in probe error path and remove to make sure
the media entity is cleaned up properly.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 64e472ca3594..399b2f800dc4 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -547,6 +547,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 err_cleanup:
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
+	media_entity_cleanup(&csi2rx->subdev.entity);
 err_free_priv:
 	kfree(csi2rx);
 	return ret;
@@ -559,6 +560,7 @@ static void csi2rx_remove(struct platform_device *pdev)
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
+	media_entity_cleanup(&csi2rx->subdev.entity);
 	kfree(csi2rx);
 }
 

-- 
2.42.0
