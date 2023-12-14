Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09D5812FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572924AbjLNMHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572909AbjLNMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:07:10 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D38A10A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:07:16 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4SrWLW1GSYz5B101;
        Thu, 14 Dec 2023 20:07:15 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 3BEC4ubP040973;
        Thu, 14 Dec 2023 20:04:57 +0800 (+08)
        (envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 14 Dec 2023 20:04:59 +0800 (CST)
Date:   Thu, 14 Dec 2023 20:04:59 +0800 (CST)
X-Zmail-TransId: 2afa657aef6bffffffffc11-bc2b8
X-Mailer: Zmail v1.0
Message-ID: <202312142004599156569@zte.com.cn>
Mime-Version: 1.0
From:   <yang.guang5@zte.com.cn>
To:     <lee@kernel.org>
Cc:     <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>,
        <cgel.zte@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1mZDogd204OTk0OiBTd2l0Y2ggdG8gdXNlIGRldl9lcnJfcHJvYmUoKSBoZWxwZXI=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3BEC4ubP040973
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 657AEFF3.000/4SrWLW1GSYz5B101
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

dev_err() can be replace with dev_err_probe() which will
check if error code is -EPROBE_DEFER.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 drivers/mfd/wm8994-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index d5ac066f9db4..8a4196dd927b 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -379,9 +379,7 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 	ret = regulator_bulk_get(wm8994->dev, wm8994->num_supplies,
 				 wm8994->supplies);
 	if (ret != 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(wm8994->dev, "Failed to get supplies: %d\n",
-				ret);
+		dev_err_probe(wm8994->dev, ret, "Failed to get supplies: %d\n");
 		goto err;
 	}

-- 
2.25.1
