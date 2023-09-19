Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3F7A5DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjISJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjISJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:23:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AF3DA;
        Tue, 19 Sep 2023 02:23:45 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81B0F6607033;
        Tue, 19 Sep 2023 10:23:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695115424;
        bh=zr0JHbMPGnoB7W9Ga+/W4aCptT35gdUdHKTnbXaS1ao=;
        h=From:To:Cc:Subject:Date:From;
        b=gNu8uZ5h9bSSKMbkyuwIc++hFOXW8AthBtEaGp3olqat7QhHQQV1yuUtznTL1opyi
         6q0B7NFlvHsusyAPXPORN3XaXbLKZmXO1j/E7uzxgJ2V0GE8Nz1yvy9gnMnbc3NvFG
         Vtb2kKQLtGwLlFiBELpiW94r74dHWzR3WxMfZy6Qc99xsrT8lshAUErJPPF56y+stf
         qTMarH6dNKpDv/yrvG0m9i/VvI0N7+bDPI3c0FtZFOr0wACFERn/tqjFW+ftkSoO4R
         ZSAMMZ/Si1RGBHYK9sSf+/u0r5MxmIW2kfsqDOuXESccspqQ3uyAUdkMI7KaYbODCz
         0fEralOeKOMnQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mathieu.poirier@linaro.org
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tinghan.shen@mediatek.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH] remoteproc: mediatek: Refactor single core check and fix retrocompatibility
Date:   Tue, 19 Sep 2023 11:23:36 +0200
Message-ID: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In older devicetrees we had the ChromeOS EC in a node called "cros-ec"
instead of the newer "cros-ec-rpmsg", but this driver is now checking
only for the latter, breaking compatibility with those.

Besides, we can check if the SCP is single or dual core by simply
walking through the children of the main SCP node and checking if
if there's more than one "mediatek,scp-core" compatible node.

Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index ea227b566c54..a35409eda0cf 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1144,29 +1144,25 @@ static int scp_add_multi_core(struct platform_device *pdev,
 	return ret;
 }
 
-static int scp_is_single_core(struct platform_device *pdev)
+static bool scp_is_single_core(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev_of_node(dev);
 	struct device_node *child;
+	int num_cores = 0;
 
-	child = of_get_next_available_child(np, NULL);
-	if (!child)
-		return dev_err_probe(dev, -ENODEV, "No child node\n");
+	for_each_child_of_node(np, child)
+		if (of_device_is_compatible(child, "mediatek,scp-core"))
+			num_cores++;
 
-	of_node_put(child);
-	return of_node_name_eq(child, "cros-ec-rpmsg");
+	return num_cores < 2;
 }
 
 static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_cluster *scp_cluster)
 {
 	int ret;
 
-	ret = scp_is_single_core(pdev);
-	if (ret < 0)
-		return ret;
-
-	if (ret)
+	if (scp_is_single_core(pdev))
 		ret = scp_add_single_core(pdev, scp_cluster);
 	else
 		ret = scp_add_multi_core(pdev, scp_cluster);
-- 
2.42.0

