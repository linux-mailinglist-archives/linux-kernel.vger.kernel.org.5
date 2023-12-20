Return-Path: <linux-kernel+bounces-6308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57903819706
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BBBB25A40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A4FBE1;
	Wed, 20 Dec 2023 02:59:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxde.zte.com.cn (mxde.zte.com.cn [209.9.37.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E1CA41
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4Svyvq0fhlz68Jxc
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:59:35 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Svyvf0vg8z4xPYr;
	Wed, 20 Dec 2023 10:59:26 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 3BK2x8Rl080444;
	Wed, 20 Dec 2023 10:59:08 +0800 (+08)
	(envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 20 Dec 2023 10:59:10 +0800 (CST)
Date: Wed, 20 Dec 2023 10:59:10 +0800 (CST)
X-Zmail-TransId: 2afb6582587effffffffa43-f1f6a
X-Mailer: Zmail v1.0
Message-ID: <202312201059100522230@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.guang5@zte.com.cn>
To: <lee@kernel.org>
Cc: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBtZmQ6IHdtODk5NDogU3dpdGNoIHRvIHVzZSBkZXZfZXJyX3Byb2JlKCkgaGVscGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3BK2x8Rl080444
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65825895.000/4Svyvq0fhlz68Jxc

From: Yang Guang <yang.guang5@zte.com.cn>

dev_err() can be replace with dev_err_probe() which will
check if error code is -EPROBE_DEFER.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 drivers/mfd/wm8994-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index d5ac066f9db4..c43273527425 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -378,10 +378,8 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 	 */
 	ret = regulator_bulk_get(wm8994->dev, wm8994->num_supplies,
 				 wm8994->supplies);
-	if (ret != 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(wm8994->dev, "Failed to get supplies: %d\n",
-				ret);
+	if (ret != 0) {
+		dev_err_probe(wm8994->dev, ret, "Failed to get supplies\n");
 		goto err;
 	}

-- 
2.25.1

