Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0163778C57
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjHKKsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjHKKsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:16 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B67FE4D;
        Fri, 11 Aug 2023 03:48:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAllgI092949;
        Fri, 11 Aug 2023 05:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750867;
        bh=wu4mIPhabpWQUEsQ8ryAHeq8wrPB4LRLYY+FAu6U0jg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kySzQiwITiENjc6RttiVeQIBt8bgeS9MEAxTL1VvntIDMR6y1YwJhVwI5kB6h8Mud
         OdHj+JCp8SvCmy8aO58OVvG/MLnCKpsRtjndNV+Ssp09wZZbEySnesaLtG1XxifA6y
         pn4ULC3JoPehOWcVYVWdTosiPl4SHqgHWYIvvED8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlkg0001694
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:47 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAljPr019848;
        Fri, 11 Aug 2023 05:47:45 -0500
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
Subject: [PATCH v9 04/13] media: cadence: csi2rx: Cleanup media entity properly
Date:   Fri, 11 Aug 2023 16:17:26 +0530
Message-ID: <20230811-upstream_csi-v9-4-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=DvjvK2SdAonp0bWpuPHBdc0xp9+g0VNlxfau8dBHAtE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g76iCqh5O5qjcG544RHftdpT05uipncjxcX2
 OEB1RdWvSyJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYO+gAKCRBD3pH5JJpx
 Rb4XD/4/rco3bOVyNYLf7yWynnKFjBzar3jmCKXVOT7/re/vkY7kh3T999mjm9IU4IXQp7zJNs0
 xROS1w1ueuMQBtFOzatAdzD8gFSqIRdX2QjayoOefYui6588zLDd3jAkYMFr4re6eCyH6abnMQO
 UiiCU4k1LcCpH37Pi6qLF5/A3Jz/jpgENga537yEk8A3+GgHpgQb67qZwxYBbKyAi7DYaaYZSfC
 NB8PQ7PkuTQRplUzKkJqdysAFN/HlsPlHvZgTyBYzxza/oGpvBUvDrfqsnjGFwhu/cY5+sR6ElF
 XU47Jl8fZihX+zQSS2OuIdz7s4yR//DAeIB40+B0ONTRB4omE7JsSBTvL3eu7sZJlzrM0CZvR1m
 T+3faxKwN/WMlHtsIuEQoJzuB1X5NSEtj4n0BKOtOLLToPsog5FOak2csc9kXbx4BbdcTCrgkIT
 ZZT/0m3vjUHTa6vLbUOUEtAiBb9vFmr6jxY+FQBV09l8qp0VDgJvvAWELH4hGR9MmJKqovRDqzl
 xSrUPkTiTjWn8b1TWJn6xphZxsAx/QZBnpKvnIhkmwy7bUEoJeHSvOjy3Z68DsPD2VMpp3I3cv9
 GEEH9WkMzoZbwBCnOElyOiC0TUBobxmq4MMI36XKv+gW4Dm5pUjAVIuajvSPAPKtSQgHIACA5BC
 DQ/RHaOHEEp8Wrw==
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

Call media_entity_cleanup() in probe error path and remove to make sure
the media entity is cleaned up properly.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 9231ee7e9b3a..9de3240e261c 100644
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
2.41.0
