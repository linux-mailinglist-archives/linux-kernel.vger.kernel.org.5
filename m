Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31F97BFB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjJJM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjJJM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:29:50 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 015B1B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BY3yD
        GeIefIcA+vHv8W2LLY7z7fayTNU7z5yohmsntw=; b=LWoGh2C/IearcCMUiW1Y7
        dJcrvRz3AOju/9s45pzB4qHJT5Y2TMPFycHwpbUi/RCv3l9WPW+IZopRflnawPke
        zOg+jbFmQ4qFRiYpbOfTI72d9yQiGB5vQ7xeIBiny4xTqnCHXqccFvOGu+q/sZPh
        8AVccGaxgBAxA5XeFOcMWo=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wBnTtWdQyVlOE+vAA--.52111S4;
        Tue, 10 Oct 2023 20:29:30 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH v3] ata: sata_mv: aspeed: fix value check in mv_platform_probe()
Date:   Tue, 10 Oct 2023 20:29:16 +0800
Message-Id: <20231010122916.4080132-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnTtWdQyVlOE+vAA--.52111S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rAw4fGw18tFy5tr17Awb_yoWftFgEya
        yxu39rWr429FnFy3s8Xr15ArWxKFWvvFnYvas2yw1ayFy7Xw43JryDXwn8uwsrWw4kuFy0
        yr1UC3y3Cry5JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRthFxDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivhQFC1ZcjDjUDwAAsB
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
 drivers/ata/sata_mv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 45e48d653c60..e82786c63fbd 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4123,10 +4123,13 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->base -= SATAHC0_REG_BASE;
 
 	hpriv->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(hpriv->clk))
+	if (IS_ERR(hpriv->clk)) {
 		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
-	else
-		clk_prepare_enable(hpriv->clk);
+	} else {
+		rc = clk_prepare_enable(hpriv->clk);
+		if (rc)
+			goto err;
+	}
 
 	for (port = 0; port < n_ports; port++) {
 		char port_number[16];
-- 
2.37.2

