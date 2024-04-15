Return-Path: <linux-kernel+bounces-145094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201868A4F77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D8E28317F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F50B71739;
	Mon, 15 Apr 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ba5gLAks"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B470CAD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185297; cv=none; b=nuZaHW2ITjkuE5w++673TxicvQR6MsHWXw/Q9+XP44WX1jYHSl6BxUQyJ2QgCNeddjAceEA02cz0HKGx5pT6J7K+Lc1mutVSdS8tpcx4RWqpDbS4IBZtP07A5fqqTir40NYLjK5mFAzRTOBF4NOWDhh6ln8snu0Qe64Dkk7TpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185297; c=relaxed/simple;
	bh=GiAL7AQwqxatMiC1wtqf96rwk/+L3Y723maHiKd24mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IJh5MQV0ojEjoWHSt5EmB/DUkFzWTDSASNB5YYwMI2X9bWGRVnnrFNpseB2se/tBvylHkVvWVdYT6Rsda/3GmxfSNtxcu2EIWwZelRUoH2m4DCw5t7C8Cg9m+tWY3Cug6JYTqoEnK/Vu0dUAsFgt4DrsQYaYltNIbRJrSsK4lfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ba5gLAks; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78d5e7998a0so254025185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713185295; x=1713790095; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dve//qsVqFoPISv+fNeUNTT8BnSMNPQ+ikVvv/LniyI=;
        b=Ba5gLAksCKmOFwSd5OnV1XD7iR8iESQDmFpJ3FzifOo6xZd/8U14sdUrM2GVnMLBDC
         oS/uH60ybiujgm5ssoa5dxToFP6LZ8VVAaaQgvvPtdveW6vhWia2tcA0TIZlooGoR9xO
         O/kj1AufiyoYa6fl8mXzLRcJom2CZ48e3ItIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185295; x=1713790095;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dve//qsVqFoPISv+fNeUNTT8BnSMNPQ+ikVvv/LniyI=;
        b=CZUezbM91pg5rYqAu/cfB/kns1jonZcnfYPUQaAaAjgi+gqQsuyRf/dntj8RyaDqX6
         uhz8jirvYGlnQed5LgyyPRROm+dBT1SO9moa5L0BeVo7tip22L3I0Gk7IgPAIdSEQh/A
         cHdPxsbySoL89PuWetczHWL6y3xJBJCLFia7V6RPRpSeW8ENyM2pv9vbyXn7d005jOqy
         zXRAqqFwsKVC1J/6BLloXXBfL3vonze91+de9TU3H68BW4eNNd5D+U9g7euYay6WvWmH
         ENURt8Y1iYzrUT2xbszBW/l6jUpZv5izGEfFIQLpB1uu6m+vUH/kLX7ux1AisElAXUUg
         VdJw==
X-Forwarded-Encrypted: i=1; AJvYcCU56fMLBC/NAZDVBOxlD+8nolKGoY8OEUvX0mks+u/GuUD/T/WBL+kEpQ7yFos23xuyCJOBO/JaxhxrQPQ3NL8ygTeLKGLsFdnLy8Cb
X-Gm-Message-State: AOJu0YwkK1UwBle9F2n5IKjkBmpB9wRcFg5ezzASeCKJP5KdlDS7pChP
	rL15FrOUIu0ZEW5ARns7r0UoiV/RZdOCbZKvjgYyCbLJbIfhfZqOQtRcSZsV6w==
X-Google-Smtp-Source: AGHT+IGGMVMgU9pcekBy2o8Q4hRzW7aGYI9W6mUPy3Ru/xUnvMaPLLrOjste8+2tlkKDnbLOSF+kuA==
X-Received: by 2002:a05:620a:31a7:b0:78e:f058:66ef with SMTP id bi39-20020a05620a31a700b0078ef05866efmr642944qkb.77.1713185295008;
        Mon, 15 Apr 2024 05:48:15 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id ye2-20020a05620a3b8200b0078a54c25ea6sm6243453qkn.56.2024.04.15.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:48:14 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 12:48:13 +0000
Subject: [PATCH v4] media: usb: siano: Fix allocation of urbs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-smatch-v4-1-8dce3d80b64a@chromium.org>
X-B4-Tracking: v=1; b=H4sIAAwiHWYC/22OzQ6CMBAGX4X0bE1/WGg9+R7GA9KF9gA1LTYaw
 rtbOBijHOfLzmRnEjE4jORUzCRgctH5MUN5KEhrm7FH6kxmIpgoWckZjUMztZaqTkgwwGqQhuT
 je8DOPbfQ5ZrZujj58Nq6ia/rXyJxymitwDCmGwXidm5t8IN7DEcferJWkvg24WMKymkFgoOWl
 ZFa7Zhy35TZRCPz9502gPhjLsvyBoFEkfATAQAA
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
Changes in v4:
- Remove unneeded label free_urbs
- Link to v3: https://lore.kernel.org/r/20240415-smatch-v3-1-ed3f23f9d5ee@chromium.org

Changes in v3: Thanks Hans
- Remove unneeded NULL assignment
- Use the proper variable :)
- Link to v2: https://lore.kernel.org/r/20240415-smatch-v2-1-65215936d398@chromium.org

Changes in v2: Thanks Hans
- Only leave 1/6, the other ones are in another PR
- Fix the return tag and NULLify the urbs on return
- Link to v1: https://lore.kernel.org/r/20240410-smatch-v1-0-785d009a852b@chromium.org
---
 drivers/media/usb/siano/smsusb.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 723510520d09..2c8179a84991 100644
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
@@ -463,7 +468,9 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	/* initialize urbs */
 	for (i = 0; i < MAX_URBS; i++) {
 		dev->surbs[i].dev = dev;
-		usb_init_urb(&dev->surbs[i].urb);
+		dev->surbs[i].urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!dev->surbs[i].urb)
+			goto err_unregister_device;
 	}
 
 	pr_debug("smsusb_start_streaming(...).\n");
@@ -486,6 +493,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	return rc;
 
 err_unregister_device:
+	/* smsusb_term_device() frees any allocated urb. */
 	smsusb_term_device(intf);
 #ifdef CONFIG_MEDIA_CONTROLLER_DVB
 	media_device_unregister(mdev);

---
base-commit: 34d7bf1c8e59f5fbf438ee32c96389ebe41ca2e8
change-id: 20240410-smatch-8f235d50753d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


