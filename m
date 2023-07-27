Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F6B76597F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjG0REz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjG0REy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:04:54 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4120530CF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ON2AcPEX9iUGpTeHSY
        H5yb+wOGr0V3ziHE8vRTT2zrE=; b=kU82qeCLMEIf0cFXf7j8LjusfxzgBJ1fuu
        LoemOn2TeAsi41BaUprdYkTAqMOaTDiv3xNHXZLWDbi5ulQIZjFXvjSHCTOnW/s7
        fTtBpgip/GdfhpmBuW+egk1LLHG2qrJiN302VvS4qZZWJmVkEpXQcNimeJC8WsSO
        Bztt/W2A8=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wB3vxuPo8JkzZS0BQ--.54694S4;
        Fri, 28 Jul 2023 01:04:24 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] nvmem: imx-ocotp: fix value check in imx_ocotp_probe()
Date:   Fri, 28 Jul 2023 01:04:14 +0800
Message-Id: <20230727170414.18737-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wB3vxuPo8JkzZS0BQ--.54694S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rAw4fGw18tw4DJrWxXrb_yoWkAFc_u3
        srXrs29Fyruw4vyr1UGw17XFZFyFs5ZF4j9Fyrtw1YyF9rZwsxArZ8ZwnxCayUX34ktr9x
        tr4DAFWfCryUGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNGQ6DUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiJxy55V5vE8WOYgAAss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in imx_ocotp_probe(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Fixes: c33c585f1b3a ("nvmem: imx-ocotp: reset error status on probe")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/nvmem/imx-ocotp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ab556c011f3e..c4d604256862 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -600,6 +600,7 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ocotp_priv *priv;
 	struct nvmem_device *nvmem;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -623,7 +624,9 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 
 	priv->config = &imx_ocotp_nvmem_config;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 	imx_ocotp_clr_err_if_set(priv);
 	clk_disable_unprepare(priv->clk);
 
-- 
2.17.1

