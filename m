Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48BB7549BC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGOPVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:21:11 -0400
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C830C0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689434465;
        bh=W7iCPMXVvM0W4+0MsTwVQBdrbYddZb1Nron0gUmlUqY=;
        h=From:To:Cc:Subject:Date;
        b=PsUTVVBoWizUSdezXmDH8Tk5D2w0lu4VMsFZzri8cCCVaQ7aBFt0HgtBvPMFEh3jI
         jn3TAZ874zoRhWDFlaAvCjiCcm3Lgxe/JTZhmFvxLlqrc2DQkG1N5VJ9ifqGM6jEFf
         XgMUxNecG4Tf+m2cZyoSC9TB+XDrXHRyPcnuUlRI=
Received: from KernelDevBox.byted.org ([180.184.51.142])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 543290EF; Sat, 15 Jul 2023 23:21:03 +0800
X-QQ-mid: xmsmtpt1689434463tb1zp4ofy
Message-ID: <tencent_0ED0DF5CD5426F55806D79D028F8A10E490A@qq.com>
X-QQ-XMAILINFO: NZN9EEjpM45GyvqN93mR8kTBo520cZoxm5Wh3CvGMXyNcg0Qu70UMAqq/fydgW
         KELvv6ozAm/NXxLPY2eHzSgQ8LRDmh+fb5c3d7lkPqapzeteq/Pb9dXGw0T18CipIhHpJlNiGCtN
         f25TkPRzEqgtTNPGxVCucR0Kn5WKVfFh/07igF88jRL4OQeiiSmBi893Kqhdhz9VWNy632doPdKg
         bbYZBzWR6648EaURtivC8XTPERkQmwoC3QwmmZoU7uwFNwT8KUvwrbwcB/fqxXCjLEEbLEbIDJY0
         MmutDd891ZnFT1YSt6IiFBxhZjLU/XiosS1V/0RjxJKMyKoVEhPhkPdj1YVLnhcNDh67BJt3h3Xg
         DXiStErzCn+YjvZbt5WnZo405NuxpSKtBQAfbVjP15ZYYtj6ZFrrPUuqiejidaGaenZ1WJsDCrb3
         8TkQXBG61RugRMFS9FZ40Wx/4VDQQ/YlNMKoPG4jxrihTCPrW7ExcQfApEZmxSPosNM7odEKZ3HJ
         b3OPWTsUp1XEFzKPqqeyk8Ezu4bbpxhrR5mmrI+2RY2QTRcTahLnJS3b71x1L+lYWc14mloMmrZm
         fK1RpX8dJKj0I0tDrxrhwrHst118tThiu5cWsenpZARoox/76jQM7V50XMmiFUREnVvQZ/Q+81Hy
         VcQIRHy8ahTsVmpWXAjJ7RwU1qW5c1tj8zEOihrZ1A9i5UisSJd2f5ENJVUFup15At+MmE5XKGXH
         oXbdWjaiWSbRSz+rsIwENUUkv7Cmoofqo9v7wGO9tEIjw492OQ4c67M0mTaZfi9sBHZB9NQd7+ZA
         MWv1J3v55DhCJuIch9w+AkjhIwE3lnJwa8Hr0heVj2FtkdY+2KuXMr8zEsOFqVQRsWpUxQvsMMUa
         3VK2bYObd+Tj2saQT9UmwjvAdd+nf/G8c0oy6zERMbnq7n7dMFSIs1+T4wyQZYJvQUvNwpxaiy/8
         5lvygyuFYK70HqCpOQ70ZQqSHGg/D/sh6/so6nw1IwIqfQEK9P0TqAzHbB3j0MqWJYL9go/hps63
         fmTQBx+g==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] bus: imx-weim: fix to avoid potential NULL pointer dereference
Date:   Sat, 15 Jul 2023 23:21:01 +0800
X-OQ-MSGID: <20230715152101.2248072-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device() may fail and returns a NULL pointer.

Fix this by checking the return value of of_match_device.

Fixes: 3f98b6baad63 ("drivers: bus: imx-weim: Add support for i.MX1/21/25/27/31/35/50/51/53")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/bus/imx-weim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 52a5d0447390..65402bb60c18 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -202,15 +202,19 @@ static int weim_timing_setup(struct device *dev, struct device_node *np,
 
 static int weim_parse_dt(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id = of_match_device(weim_id_table,
-							   &pdev->dev);
-	const struct imx_weim_devtype *devtype = of_id->data;
+	const struct of_device_id *of_id;
+	const struct imx_weim_devtype *devtype;
 	int ret = 0, have_child = 0;
 	struct device_node *child;
 	struct weim_priv *priv;
 	void __iomem *base;
 	u32 reg;
 
+	of_id = of_match_device(weim_id_table, &pdev->dev);
+	if (!of_id)
+		return -EINVAL;
+
+	devtype = of_id->data;
 	if (devtype == &imx50_weim_devtype) {
 		ret = imx_weim_gpr_setup(pdev);
 		if (ret)
-- 
2.30.2

