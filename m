Return-Path: <linux-kernel+bounces-117253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F047E88B0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F9AB2FD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE05158A1D;
	Mon, 25 Mar 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Ah0jZfdW"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1D136E26;
	Mon, 25 Mar 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376788; cv=none; b=k0B3tnZpVSP8H5i4hidU8xwRoPvUGWyB1VPIgFJ2wYhkjhHyrjQ+W9ydGnSImepDVYfudR/2fUW7J+OqEpX+b/lVY787BlQWyfAqOfyo3UN56pQGvwwK7rpO7w6dtxlKy/11NHH+qtumAjqYUlO3gXtLAINDNmgcECn6PCRidOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376788; c=relaxed/simple;
	bh=lTMJavNIWrnUZ0bbbF3Rx8TEQ/VmlXUb1B8yQuTFSDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZmQJNUKGoLyGhPciKl8MiBTfT19+vzEiu/+za4Ls3OabPKJZHKYYKJEx2OMg18COYKlWDQFp7hpGlzbGcG7TIlx/qhMDoLAAIfy7VDLY+cZn1kd/M2DbIk2CcKC42WqWGnWNlEN6/XOxaFWd0IoT/UrHYx86YRfta/F3DTap+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=Ah0jZfdW; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from localhost (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 670026346550;
	Mon, 25 Mar 2024 15:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1711376781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EWL9RPJbotHTugKp2e3hpY0GlUbdFdPRzf1HTQgWuFQ=;
	b=Ah0jZfdWa3W1ky5rNcCskxmzk4SobiXprUKDrzvMyuHY1U0ZERN+4Ht1vhB9+5Opp6t7ix
	sHo3HlM9x29jte6t/h9P4jGfW6vt1a57BNEUSduf8BHuWYzbOTAbfSFyIJmbX6mi+7JTuG
	kho2CwCuYCKFCHaEUzxIoLjGgBqLIHs=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"hn.chen" <hn.chen@sunplusit.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] media/uvcvideo: add quirk for invalid dev_sof in Logitech C920
Date: Mon, 25 Mar 2024 15:26:11 +0100
Message-ID: <20240325142611.15550-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Similarly to Logitech C922, C920 seems to also suffer from a firmware
bug that breaks hardware timestamping.

Add a quirk for this camera model too.

Before applying the quirk:

```
100 (4) [-] none 100 200717 B 212.919114 213.079004 33.727 fps ts mono/SoE
101 (5) [-] none 101 200889 B 213.003703 213.114996 11.822 fps ts mono/SoE
102 (6) [-] none 102 200926 B 213.035571 213.146999 31.379 fps ts mono/SoE
103 (7) [-] none 103 200839 B 213.067424 213.179003 31.394 fps ts mono/SoE
104 (0) [-] none 104 200692 B 213.293180 213.214991 4.430 fps ts mono/SoE
105 (1) [-] none 105 200937 B 213.322374 213.247001 34.254 fps ts mono/SoE
106 (2) [-] none 106 201013 B 213.352228 213.279005 33.496 fps ts mono/SoE
…
```

After applying the quirk:

```
154 (2) [-] none 154 192417 B 42.199823 42.207788 27.779 fps ts mono/SoE
155 (3) [-] none 155 192040 B 42.231834 42.239791 31.239 fps ts mono/SoE
156 (4) [-] none 156 192213 B 42.263823 42.271822 31.261 fps ts mono/SoE
157 (5) [-] none 157 191981 B 42.299824 42.303827 27.777 fps ts mono/SoE
158 (6) [-] none 158 191953 B 42.331835 42.339811 31.239 fps ts mono/SoE
159 (7) [-] none 159 191904 B 42.363824 42.371813 31.261 fps ts mono/SoE
160 (0) [-] none 160 192210 B 42.399834 42.407801 27.770 fps ts mono/SoE
```

Link: https://lore.kernel.org/lkml/5764213.DvuYhMxLoT@natalenko.name/
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 drivers/media/usb/uvc/uvc_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 723e6d5680c2e..444d7089885ea 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2573,7 +2573,8 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceClass	= USB_CLASS_VIDEO,
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT
+					       | UVC_QUIRK_INVALID_DEVICE_SOF) },
 	/* Logitech HD Pro Webcam C922 */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.44.0


