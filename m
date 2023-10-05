Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20A87BA01C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjJEOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjJEObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3122CAB;
        Thu,  5 Oct 2023 03:49:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22BFA660731F;
        Thu,  5 Oct 2023 11:49:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696502957;
        bh=vtwN7TZUfuKOOcpUTbUvCztJdBqkeLPF1yo8/uXzBpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3YxRc7t98bDLGOsh8Hk+Bwwp3AQiR6xwxpd3UpfwbkcqiPyyKSiTwGm68YDx8Vh+
         2TFobSL5JSEWtS6T5+ZkpZPtwt7wt3Tdile43De8AEk3w9i7r2AcYJ0bifjoD/AXCL
         qtKMpJuhxsxdrT1ME/EQ0+Iv0AvrYyLPut8kjX4527UpbUXn+0Ji5ueUHm4zMWe1HS
         yAu9oyUCBY1hsFc18+FPWXt/Ab3JmPcvnRcg+2jTPOxV0hOkKX3AdLUgwU+KfAYb+G
         E3GITamvK5Hg7AZ/N22dk2qse6r01DcQhpCOxSg/UuF4ihqeXhG3AEIhaVy579dvYN
         XERMItaZXgiIw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mchehab@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 2/2] media: platform: mtk-mdp3: Use devicetree phandle to retrieve SCP
Date:   Thu,  5 Oct 2023 12:49:05 +0200
Message-ID: <20231005104905.120544-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005104905.120544-1-angelogioacchino.delregno@collabora.com>
References: <20231005104905.120544-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of walking the entire parent node for something that has the
right compatible, use the scp_get() function provided by the MediaTek
SCP remoteproc driver to retrieve a handle to mtk_scp through the
devicetree "mediatek,scp" (phandle) property.

In case of multi-core SCP, this also allows to select a specific core.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index cc44be10fdb7..94f4ed78523b 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -208,13 +208,17 @@ static int mdp_probe(struct platform_device *pdev)
 		goto err_destroy_job_wq;
 	}
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_SCP);
-	if (WARN_ON(!mm_pdev)) {
-		dev_err(&pdev->dev, "Could not get scp device\n");
-		ret = -ENODEV;
-		goto err_destroy_clock_wq;
+	mdp->scp = scp_get(pdev);
+	if (!mdp->scp) {
+		mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_SCP);
+		if (WARN_ON(!mm_pdev)) {
+			dev_err(&pdev->dev, "Could not get scp device\n");
+			ret = -ENODEV;
+			goto err_destroy_clock_wq;
+		}
+		mdp->scp = platform_get_drvdata(mm_pdev);
 	}
-	mdp->scp = platform_get_drvdata(mm_pdev);
+
 	mdp->rproc_handle = scp_get_rproc(mdp->scp);
 	dev_dbg(&pdev->dev, "MDP rproc_handle: %pK", mdp->rproc_handle);
 
-- 
2.42.0

