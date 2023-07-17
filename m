Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1185F755F96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGQJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGQJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:41:50 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E9E10DC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:41:46 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a1ebb79579so3022072b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689586905; x=1692178905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eACxarP/Tz50bZdt1UYA7RtQle4Cj1TLAGxzPu+b6bE=;
        b=lwcxwdV1qqG+OnALMSzou1U7LZ18ObpTE1C8pSyUafrhZaNVsHzPqXkf8bd3ITIek/
         ab9qiC4gckqblt5fQN1v4hT0cYiT5b6MBIr1UqLZ7gH1KPlEm0NHsOzYT4u057LV/jN3
         bOjipoZ96OCmFkBQ4cbLDRiNA+0AxOaL2mlq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586905; x=1692178905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eACxarP/Tz50bZdt1UYA7RtQle4Cj1TLAGxzPu+b6bE=;
        b=DcC4kRqA0qPsP+A2+v+1h0HFDzxOQSakWoMWDXpprJq8aY+7+L1xwfW5y7qrWhYIoi
         +yNWBKRS0z2FVKsqtTSsx8YMn77cywr7pf3rWfMaTwXmUYMYEhBWPsOlgrLn3EZpZs2S
         cpcZaaupOvBGz7XFmN+tzQhSp2akKbJrHT7GoUHXKls+HPURPGQcmYGE+Kgo1AFnf5bU
         /RS50RNAumqQSa4RLbe2YU0lb4ABJI7C0OSRJx9rYs5ZQbKpMcM5PVtmrumcSsSY1hUI
         LdvknKKz8GLAjcsfFJOzENqiaj1HI8IY+UdIey0oCNNykrT+LRQ59wfOa07zW3U23KQ2
         u9/A==
X-Gm-Message-State: ABy/qLaDVTKDRSF0a37XEy1qXs+wayGQuTFPEkram7IfsJxi2MaIKJda
        aYiPhl1jAtY2SK4D509gViwsAw==
X-Google-Smtp-Source: APBJJlGQ0dazNafWC6OVxhnPwuHO2FhT0UEBiopaW/BPiSyYadCvu3ahtbePpnr/7in8YVNdTA+07w==
X-Received: by 2002:aca:ded5:0:b0:39c:9173:31f1 with SMTP id v204-20020acaded5000000b0039c917331f1mr9883790oig.28.1689586905306;
        Mon, 17 Jul 2023 02:41:45 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:9f69:907c:a335:1193])
        by smtp.gmail.com with UTF8SMTPSA id i130-20020a639d88000000b0055b44a901absm12545408pgd.70.2023.07.17.02.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:41:44 -0700 (PDT)
From:   Yu-Che Cheng <giver@chromium.org>
To:     James Lo <james.lo@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yu-Che Cheng <giver@chromium.org>, Fei Shao <fshao@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] spmi: mediatek: Fix UAF on device remove
Date:   Mon, 17 Jul 2023 17:39:35 +0800
Message-ID: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmif driver data that contains the clocks is allocated along with
spmi_controller.
On device remove, spmi_controller will be freed first, and then devres
, including the clocks, will be cleanup.
This leads to UAF because putting the clocks will access the clocks in
the pmif driver data, which is already freed along with spmi_controller.

This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
building the kernel with KASAN.

Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
clocks before freeing spmi_controller.

Reported-by: Fei Shao <fshao@chromium.org>
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
---

 drivers/spmi/spmi-mtk-pmif.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index b3c991e1ea40..74b73f9bc222 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -465,7 +465,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	for (i = 0; i < arb->nclks; i++)
 		arb->clks[i].id = pmif_clock_names[i];
 
-	err = devm_clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
+	err = clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
 		goto err_put_ctrl;
@@ -474,7 +474,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	err = clk_bulk_prepare_enable(arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable clocks: %d\n", err);
-		goto err_put_ctrl;
+		goto err_put_clks;
 	}
 
 	ctrl->cmd = pmif_arb_cmd;
@@ -498,6 +498,8 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 
 err_domain_remove:
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+err_put_clks:
+	clk_bulk_put(arb->nclks, arb->clks);
 err_put_ctrl:
 	spmi_controller_put(ctrl);
 	return err;
@@ -509,6 +511,7 @@ static void mtk_spmi_remove(struct platform_device *pdev)
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+	clk_bulk_put(arb->nclks, arb->clks);
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
 }
-- 
2.41.0.255.g8b1d071c50-goog

