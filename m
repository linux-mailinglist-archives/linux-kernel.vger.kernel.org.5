Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE09175E8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjGXBqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjGXBoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F0E40;
        Sun, 23 Jul 2023 18:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E3261004;
        Mon, 24 Jul 2023 01:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68117C433CA;
        Mon, 24 Jul 2023 01:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162449;
        bh=a18K2LEprRpTzPvGFGPzJoVCY6l1dgQyL+ze+Oep0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9cCEZ58vIeNHIqJQHOoW4zkRd5px4k8QcY+hGl11Pz30Vw3hJ3sBM5GfClE+Yws+
         t64mGuJE1CD5ZI4y0dMaZKBYCogHqjUtEMhzJu1+rojx22GLQ34ptPpD6x/zRzGz3K
         9UOunwG/W9V1mp036fLyd9fvkMWfSJi5erX2bAeTSwHXW0g0XRGh9lMOVzAn/5ICPn
         L85kFdC5iLKV2HBtpHebfXOYVX+gUKFGiPI3eXI2WPm5ZvHM47nsnahcp62jcdTW2H
         /J24/suMmM+x1az3Jxvc6yXv59LcM7AMGQ2HiI4DNQzTwmWEI0pKZVwzWxz8YClUjv
         9WtHcv5jb0lRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Yang <xu.yang_2@nxp.com>, Li Jun <jun.li@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/16] usb: chipidea: imx: don't request QoS for imx8ulp
Date:   Sun, 23 Jul 2023 21:33:49 -0400
Message-Id: <20230724013401.2333159-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013401.2333159-1-sashal@kernel.org>
References: <20230724013401.2333159-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
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
index f798455942844..4d47fe89864d9 100644
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

