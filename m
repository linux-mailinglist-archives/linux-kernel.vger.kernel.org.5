Return-Path: <linux-kernel+bounces-145066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC778A4F05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDAFB216C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D56E6BFBB;
	Mon, 15 Apr 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SnX9GWE4"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40D679E2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184179; cv=none; b=lcUgpRa4swdznfO/ejoQfBWh3o5jXEuIOSSrabBBHdSOXCZdQKhjQcqsyBBVsygBzXD7IBwl1LnTUmq0mxOhmJ9iGD3xhhrrSuEGuy7I+kSp9qgLkhPoBFjArYt5Nz+TqFImvJ6ySgsSgAEx9XAx+vJa1Zx+Ma77wZNIN4NXAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184179; c=relaxed/simple;
	bh=5lhRyrzca4TjFgF2+b3ZcdjsSA8YOHY7wePS8t1m6qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PedcIOtQiZp4cwugpBbqnaC/ARYcIyjRNNLsx/dAXpjojg1VfMQwmCailiEaIvvBuf0vLUU2BAOb+3C/rDWkqUwDzYuWHZzVDyS4NWfJ31ha/KG5F6zCBddakf4mMqO3hKb2ysoqGTZJB3lbUkx9Y7AGqvP0CLG0m0LxY7XbeAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SnX9GWE4; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb7ef71c03so446870a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713184175; x=1713788975; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BECndX+48cQN13aMuuHQd3FSCd8ubmNe5lelLwKHJ9Q=;
        b=SnX9GWE48rZPD9JjKU+6DXAN4GRLlBjQPhDPZQNq5T0KRT0B59zTtSWkAiJGBECKsY
         9uMXxuRR2BHEFfNHI1eL94BwuHWTIS/UPLlCICFwmn53Z9vTIQZ7On/6TS4U3jLOYhst
         8buVbGjBitBVcnaRM6if9ce7kbcMosEJU0R/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713184175; x=1713788975;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BECndX+48cQN13aMuuHQd3FSCd8ubmNe5lelLwKHJ9Q=;
        b=G+PkGE4MsYDTexA+Wp/50QjOLVkT83zmmnbtfhah6EM3x5eET/w3u2QOsGtMOhNcFd
         0QA8uDZzGGVTlzxu67SlXerT6JmscUHtK0EJnhMhXB7Gn8/EWT6LPi58V40vYkmQYFiZ
         xdC8bHJmVponhFpCsiJWMjZxf6Fi1q/T6WBqjyeEsf9lzIvQk5ajtKrlahdoQ6+0XaNh
         lEyOfOZjXjnWfRC8k4IPo0a7S3A16+mXYd/f+Ozn3Xh/5iluS9BoB6//Jw0M11NKZFbK
         3lgpkIv/ib0vt8ohWPWAiWuKeaPgMmGTTjEwsaKKe3KYRtBBFxeKIqB51lMv7cM/RgEq
         4ypg==
X-Forwarded-Encrypted: i=1; AJvYcCVc7aHZQpFEn3NG9OI+ZRYS2cy+67HowtQUFs0rD0jg067hLkikwBSxAB7bXErLOyHFv1gxUhsU8gV0v/LyYpc/C4xlCg9Ixof+kAZ+
X-Gm-Message-State: AOJu0YwixjPNOxU1Fn0McG8ggA1qld88yEg5oQb1yJowe5BUXpIZ80ix
	O8eKtcoUm8WYSBoWR2RTsV1k4M8S+2udnZwiP9p29OMp9SO/NnywbxQnACvmCw==
X-Google-Smtp-Source: AGHT+IFnzlmu0VuyTMTpmtRA1ipPdRGFpT7uNoJdSzFeilp7/o7vx5AB3UWUyblkfMXQZpGZY0vYPA==
X-Received: by 2002:a05:6871:3389:b0:21e:f03b:8836 with SMTP id ng9-20020a056871338900b0021ef03b8836mr10892530oac.52.1713184175612;
        Mon, 15 Apr 2024 05:29:35 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a145600b0078d68b23254sm6270244qkl.107.2024.04.15.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:29:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 12:29:34 +0000
Subject: [PATCH v3] media: usb: siano: Fix allocation of urbs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-smatch-v3-1-ed3f23f9d5ee@chromium.org>
X-B4-Tracking: v=1; b=H4sIAK0dHWYC/2WMyw6CMBBFf4XM2jF9MFBc+R/GBdJCu4CaFhsN4
 d8tLIzR5bm55ywQTXAmwqlYIJjkovNTBnkooLPtNBh0OjMIJkpWcoZxbOfOouqFJE2sJqkhn+/
 B9O65hy7XzNbF2YfX3k18W/8SiSPDWpFmrGkVidu5s8GP7jEefRhgqyTxbdLHFMixIsGpkZWWj
 fox13V9A2jvzBPZAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>, 
 Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

USB urbs must be allocated with usb_alloc_urb. Quoting the manual

Only use this function (usb_init_urb) if you _really_ understand what you
are doing.

Fix the following smatch error:

drivers/media/usb/siano/smsusb.c:53:38: warning: array of flexible structures

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3: Thanks Hans
- Remove unneeded NULL assignment
- Use the proper variable :)
- Link to v2: https://lore.kernel.org/r/20240415-smatch-v2-1-65215936d398@chromium.org

Changes in v2: Thanks Hans
- Only leave 1/6, the other ones are in another PR
- Fix the return tag and NULLify the urbs on return
- Link to v1: https://lore.kernel.org/r/20240410-smatch-v1-0-785d009a852b@chromium.org
---
 drivers/media/usb/siano/smsusb.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 723510520d09..ba2c02e1070e 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -40,7 +40,7 @@ struct smsusb_urb_t {
 	struct smscore_buffer_t *cb;
 	struct smsusb_device_t *dev;
 
-	struct urb urb;
+	struct urb *urb;
 
 	/* For the bottom half */
 	struct work_struct wq;
@@ -160,7 +160,7 @@ static int smsusb_submit_urb(struct smsusb_device_t *dev,
 	}
 
 	usb_fill_bulk_urb(
-		&surb->urb,
+		surb->urb,
 		dev->udev,
 		usb_rcvbulkpipe(dev->udev, dev->in_ep),
 		surb->cb->p,
@@ -168,9 +168,9 @@ static int smsusb_submit_urb(struct smsusb_device_t *dev,
 		smsusb_onresponse,
 		surb
 	);
-	surb->urb.transfer_flags |= URB_FREE_BUFFER;
+	surb->urb->transfer_flags |= URB_FREE_BUFFER;
 
-	return usb_submit_urb(&surb->urb, GFP_ATOMIC);
+	return usb_submit_urb(surb->urb, GFP_ATOMIC);
 }
 
 static void smsusb_stop_streaming(struct smsusb_device_t *dev)
@@ -178,7 +178,7 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
 	int i;
 
 	for (i = 0; i < MAX_URBS; i++) {
-		usb_kill_urb(&dev->surbs[i].urb);
+		usb_kill_urb(dev->surbs[i].urb);
 		if (dev->surbs[i].wq.func)
 			cancel_work_sync(&dev->surbs[i].wq);
 
@@ -338,6 +338,8 @@ static void smsusb_term_device(struct usb_interface *intf)
 	struct smsusb_device_t *dev = usb_get_intfdata(intf);
 
 	if (dev) {
+		int i;
+
 		dev->state = SMSUSB_DISCONNECTED;
 
 		smsusb_stop_streaming(dev);
@@ -346,6 +348,9 @@ static void smsusb_term_device(struct usb_interface *intf)
 		if (dev->coredev)
 			smscore_unregister_device(dev->coredev);
 
+		for (i = 0; i < MAX_URBS; i++)
+			usb_free_urb(dev->surbs[i].urb);
+
 		pr_debug("device 0x%p destroyed\n", dev);
 		kfree(dev);
 	}
@@ -390,6 +395,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	void *mdev;
 	int i, rc;
 	int align = 0;
+	int n_urb = 0;
 
 	/* create device object */
 	dev = kzalloc(sizeof(struct smsusb_device_t), GFP_KERNEL);
@@ -461,16 +467,18 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	dev->coredev->is_usb_device = true;
 
 	/* initialize urbs */
-	for (i = 0; i < MAX_URBS; i++) {
-		dev->surbs[i].dev = dev;
-		usb_init_urb(&dev->surbs[i].urb);
+	for (n_urb = 0; n_urb < MAX_URBS; n_urb++) {
+		dev->surbs[n_urb].dev = dev;
+		dev->surbs[n_urb].urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!dev->surbs[n_urb].urb)
+			goto free_urbs;
 	}
 
 	pr_debug("smsusb_start_streaming(...).\n");
 	rc = smsusb_start_streaming(dev);
 	if (rc < 0) {
 		pr_err("smsusb_start_streaming(...) failed\n");
-		goto err_unregister_device;
+		goto free_urbs;
 	}
 
 	dev->state = SMSUSB_ACTIVE;
@@ -478,13 +486,19 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smscore_start_device(dev->coredev);
 	if (rc < 0) {
 		pr_err("smscore_start_device(...) failed\n");
-		goto err_unregister_device;
+		goto free_urbs;
 	}
 
 	pr_debug("device 0x%p created\n", dev);
 
 	return rc;
 
+free_urbs:
+	for (i = 0; i < n_urb; i++) {
+		usb_free_urb(dev->surbs[i].urb);
+		dev->surbs[i].urb = NULL;
+	}
+
 err_unregister_device:
 	smsusb_term_device(intf);
 #ifdef CONFIG_MEDIA_CONTROLLER_DVB

---
base-commit: 34d7bf1c8e59f5fbf438ee32c96389ebe41ca2e8
change-id: 20240410-smatch-8f235d50753d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


