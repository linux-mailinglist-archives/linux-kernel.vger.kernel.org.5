Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDD27BDCD0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376613AbjJIMug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376584AbjJIMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:50:27 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89D3A8E;
        Mon,  9 Oct 2023 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KXXre
        BVQdXZOPq21+dI2Ub8P0pQKFmcLRcl/V0uA8iQ=; b=mF2TVrA4nV5zi2oqQhR8a
        cSiUNotrGUBi0vUv7sjG6fK38SJwumPdkJPf/VGvYoOg/Dg3O60BnZRodrZ0j0EN
        htK6bnKWFnYgI4vjchlkGVIpHQBJG5YXXl8gpJcMg3msFxq1stQ1ySrXTrHJOPgl
        rJfwG3gpca6gt1DFuFJ1d0=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wDnD9D09iNlFqBXAA--.35653S4;
        Mon, 09 Oct 2023 20:50:03 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH v2] ata: sata_mv: aspeed: fix value check in mv_platform_probe()
Date:   Mon,  9 Oct 2023 20:49:55 +0800
Message-Id: <20231009124955.4046988-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnD9D09iNlFqBXAA--.35653S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rAw4fGw18tFy5tr17Awb_yoWfGwcEka
        y7urW7Wr429r4Dtw15Jw1ayrZ7KF4vvrsYvas2yw1ayr17Xw43XrWDXwnxu3yDWw48XFy0
        yr4UC3y3Cry5GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtoGHUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyB0EC1p7MEUB+QAAs2
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mv_platform_probe(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/ata/sata_mv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 45e48d653c60..df3a02e7a50b 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4125,8 +4125,10 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hpriv->clk))
 		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
-	else
-		clk_prepare_enable(hpriv->clk);
+	else {
+		rc = clk_prepare_enable(hpriv->clk);
+		goto err;
+	}
 
 	for (port = 0; port < n_ports; port++) {
 		char port_number[16];
-- 
2.37.2

