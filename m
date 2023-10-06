Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BF7BC16C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjJFVoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjJFVn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:43:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF73CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:43:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D394AC433CB;
        Fri,  6 Oct 2023 21:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628638;
        bh=A9EK5qf4E+GvhcHWqqYNDqcdaWlBVaP7GwgiYFQn6KY=;
        h=From:To:Cc:Subject:Date:From;
        b=BYVl3Mue9GyJiGJZ82boPI0tqIYhO823qcDCjCfS8lryC8XiBeN98qqEG+4lEp+h3
         AeAlNz5oocIkQuwJdqAwa82PTcp39DgcOdQYfAlgFX9YzMLTjkCo0jD3iJSiIdapqT
         xfev52xLt+lseR+Zbaw/7rFjX5IxMBY5j3ow9zkX4lWoMi2iuNWa+ngTC8p66iUx9l
         UlM37ZfPOUBtuzqyTUJB+jFM4jjBRguIvdq1atEU23mcRcqLQtoEbCZ1cjtXJVV2rw
         KuiAi2mX0gtelZA7cwaJuxv/D5q9AgBSA8EzY4cODqP3cONyRFXRVtMuflUWMwVP8h
         Mr5qu6WwhAxjA==
Received: (nullmailer pid 338978 invoked by uid 1000);
        Fri, 06 Oct 2023 21:43:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: imx-weim: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:43:52 -0500
Message-Id: <20231006214352.338851-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/imx-weim.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 42c9386a7b42..6b5da73c8541 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -11,7 +11,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/regmap.h>
@@ -202,9 +205,7 @@ static int weim_timing_setup(struct device *dev, struct device_node *np,
 
 static int weim_parse_dt(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id = of_match_device(weim_id_table,
-							   &pdev->dev);
-	const struct imx_weim_devtype *devtype = of_id->data;
+	const struct imx_weim_devtype *devtype = device_get_match_data(&pdev->dev);
 	int ret = 0, have_child = 0;
 	struct device_node *child;
 	struct weim_priv *priv;
-- 
2.40.1

