Return-Path: <linux-kernel+bounces-22545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66339829F73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D911F2809E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873964D12B;
	Wed, 10 Jan 2024 17:41:49 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF24D102;
	Wed, 10 Jan 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 10 Jan
 2024 20:40:06 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 10 Jan
 2024 20:40:06 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: em28xx: return error on media_device_register() failure
Date: Wed, 10 Jan 2024 09:39:58 -0800
Message-ID: <20240110173958.4544-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

In an unlikely case of failure in media_device_register(), release
resources and return the erroneous value. Otherwise, possible issues
with registering the device will continue to be ignored.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 37ecc7b1278f ("[media] em28xx: add media controller support")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 4d037c92af7c..dae731dfc569 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -4095,6 +4095,8 @@ static int em28xx_usb_probe(struct usb_interface *intf,
 	 */
 #ifdef CONFIG_MEDIA_CONTROLLER
 	retval = media_device_register(dev->media_dev);
+	if (retval)
+		goto err_free;
 #endif
 
 	return 0;

