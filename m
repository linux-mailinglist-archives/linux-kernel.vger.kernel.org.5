Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67839769029
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGaIaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGaI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5612D;
        Mon, 31 Jul 2023 01:29:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Tfim048177;
        Mon, 31 Jul 2023 03:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792181;
        bh=UOzPrpvrAan+2YOZvNNDCtx6iMkW9nNmhwzPh28ka0M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KE19ul9QnbuUMfcPTqHx+NCjybrcZjnFS0M52oQT8YI2p2keIOrd8onMfVDdStTS2
         nzOzeI4K2B0I5TkScCVdLVLzNgA+UfLe7s6i3X33R9+lrKL+xU72m4g25pmPhA0V8d
         mo9enh4a493GQ3/yrvGeMYI2rwEQfphlasHMt/iM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8TfOM011942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TeAt084043;
        Mon, 31 Jul 2023 03:29:41 -0500
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
Subject: [PATCH v8 06/16] media: cadence: csi2rx: Cleanup media entity properly
Date:   Mon, 31 Jul 2023 13:59:24 +0530
Message-ID: <20230731-upstream_csi-v8-6-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=UZ5eyfvSIzx+FQ/gGLzq2vP4ZopnTLmh1IJ7xWs2U20=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xoegS/F2QsddEvnqMpxz/degD+RhScslhFK
 3SM1fe3S6iJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsaAAKCRBD3pH5JJpx
 RQG6D/9cucLIG7FRt1HoAr6w943bkf63JWUlSXh5s6itR0Y9RxYwsA+S5t1axrfJuBJTMzwEMgH
 5ry8h4K2ZY5yJ6iNdQcfilFgzHP+g0Wn9bzjZKER+jtBRZdToltgZomwU49vw07vOzkSKhPkarG
 +Vt7Vu0zzKSV8DU4DLJKLYJLQIlpsOZQhPQmU4PbwCl86WaIRO2i45dm8yF9HraDnuZZYJjl8SZ
 9afRp/3Xfv1XsZDy/HFdnNr9akLtpZuwrqQZjAfhvrw/oI8s9alVpyWHSH8M3Op3mmiAjKe66Ly
 22ag/oZbC0v5bNyDpRndMR0cYvpQv+9UelIFjsoKicUU7L/uQyLKBJjEUK/hbv9G9WBMyary9XP
 utdvl1vsSg5Vv/SPCw8sTOBJ6/DZXKNk1i8FkmRH9CKop0M+7hH5CksQ9Zz4ZfSSYldXjnjZDgZ
 xbjQxuLEOpDUEBRzxqm84X16NwntnFet/fJdnqztFxtYlDc4lvDOVlRvKSUXO7i0ah0gAsjCgWV
 8MZ9ITbiCAy6XrRJvMztkOQNe+7PU7MLTSw5DGpdd9a7s2wZU4+RimpPScqj+p82CB+SCbtHF0R
 ssETAvW9CPqU1hGhLXT0Q4KLFEUhlbg+pr5WPbNOJy30PdQ/AF/0a85Ame7xtgy5Teld7EHrTyu
 HkzJs6SU8l8zt7w==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v7->v8: No change

 drivers/media/platform/cadence/cdns-csi2rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index fd6f2e04e77f..83d1fadd592b 100644
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
