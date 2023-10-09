Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E81F7BDA37
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbjJILpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjJILpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:45:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02C99D;
        Mon,  9 Oct 2023 04:45:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AC5C433C7;
        Mon,  9 Oct 2023 11:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696851921;
        bh=WPdXTwjWi190AVE7Dk2PtRgMTnRydiLjuDujX9IPRlY=;
        h=From:To:Cc:Subject:Date:From;
        b=ai0LMv0jndIxr74+Cv+/UrlGO49b6EjSb+8UZLRPyYzEo+KtoUy/dqukddZAmC8cu
         wdv1f4MxogpmA+ZXlmir/GcfUNom7OeY5hzMHHmQxMpQx2Co7g3B3d7tiTa7tlhJ8n
         7edLkDFEv53N4171JXEv1f24Wyg/aGxLWu4SkbVTReqtujppTeARwRuyr+zvRdReeU
         ifZGfwJCsoYvK7snnXmvlVWNxU57prBba4usMqW/XA6c0jMCHjGmquZuAucGRuYTzn
         mqoG546KIhFxWEh6hvKqIM+mIemrupeRyQfDbDkJMsvutcq2zxrYjhAEEpcTUOTFlk
         pD1yCbFSz/CRw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: imx8: build base support for scu clk
Date:   Mon,  9 Oct 2023 13:44:55 +0200
Message-Id: <20231009114514.120130-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is now a dependency on a function from the clk.c file, so
this also needs to be built:

aarch64-linux-ld: Unexpected GOT/PLT entries detected!
aarch64-linux-ld: Unexpected run-time procedure linkages detected!
aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function `imx8_acm_clk_probe':
clk-imx8-acm.c:(.text+0xbf0): undefined reference to `imx_check_clk_hws'

Fixes: d3a0946d7ac9a ("clk: imx: imx8: add audio clock mux driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db3bca5f4ec9c..c6d3fda330341 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -6,6 +6,7 @@ config MXC_CLK
 
 config MXC_CLK_SCU
 	tristate
+	select MXC_CLK
 
 config CLK_IMX1
 	def_bool SOC_IMX1
-- 
2.39.2

