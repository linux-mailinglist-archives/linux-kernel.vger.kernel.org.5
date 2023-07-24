Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D808275E872
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjGXBlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjGXBkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:40:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1665469F;
        Sun, 23 Jul 2023 18:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A77660FD3;
        Mon, 24 Jul 2023 01:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32ADC433CB;
        Mon, 24 Jul 2023 01:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162372;
        bh=0tdMqsleSHHgOmpWXcLd8SyRl+ZCfh3g7igQtHStbNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDnp0/El6pzuJhij1ng/t1rIxjrIT3ev5I38s8M41wsm8TUColH9fFQG14xGLKkDA
         rR98eGJtDbO95lCCzoew7nsdh8mDMCYFH+t1FOyNqh/PSgdi01+filHypg3WDTs1Zx
         GpFOzqtytwAEz28JTtoErwlHnoPH8KNfGG3RydpXrEjM5WU70T/qkplPL0gv38E3DH
         cHzzZLOq4PefEDtZ8DH/WqlN4kdWg9nSiWbTRXj3ANks20nlRZXGYHlcCL3vpQAHtU
         bMxowyJbxZdJD297KKmI6znQTuUK+f2yFL4I2Qt/BNXMYZQKk9GnlZZ4FVgZbVxDe8
         D0aFjQDUSWoVw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Yang <xu.yang_2@nxp.com>, Li Jun <jun.li@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/34] usb: chipidea: imx: don't request QoS for imx8ulp
Date:   Sun, 23 Jul 2023 21:32:13 -0400
Message-Id: <20230724013238.2329166-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 9a070e8e208995a9d638b538ed7abf28bd6ea6f0 ]

Use dedicated imx8ulp usb compatible to remove QoS request
since imx8ulp has no such limitation of imx7ulp: DMA will
not work if system enters idle.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Message-ID: <20230530104007.1294702-2-xu.yang_2@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 9ffcecd3058c1..60b4de0a4f76d 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -70,6 +70,10 @@ static const struct ci_hdrc_imx_platform_flag imx7ulp_usb_data = {
 		CI_HDRC_PMQOS,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM,
+};
+
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx23-usb", .data = &imx23_usb_data},
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
@@ -80,6 +84,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-usb", .data = &imx6ul_usb_data},
 	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
 	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
+	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
-- 
2.39.2

