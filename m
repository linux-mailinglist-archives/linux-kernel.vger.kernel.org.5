Return-Path: <linux-kernel+bounces-106835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFCA87F448
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2172A1F2372F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C3A5FBAA;
	Mon, 18 Mar 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eqgB+gtF"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0C5F876
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806135; cv=none; b=WhmxKzOkz7uf4HizuQniul9v9lfBbxD8Z9m22p65SawszFD8+Oi5mmUAUflo1qxF1tuM/mB/kuGoy4HXK01Xz5iB/6TYO9azrVbaZgzfbNvF6+3QBtW1Ezn3Ey9MB1HXysuVI3POahZqldDFzQLr1gFYsWHGtZKPOB81FB5/Xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806135; c=relaxed/simple;
	bh=rowtwgwTzTc2/qlsuivkpFe9gApODrL9SLk4LA5CMVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7RGLlJ5vYhFJAmgb6A91zBR/KffRXt2M1UXPx55WnWeCMdwYAwMOp4qHLQ9sF2wpWbwxr5zxcM1l4ICDHdJYC2PDr3r8QjNeSE6GbRmsvwG+mW4Vch+GYLmDTt6S8aw9johYRUH9EeQepl34ScMB0yMEkPyzj7b7/Bs5PXRIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eqgB+gtF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a0ab10316so83589585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710806132; x=1711410932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jncCK9aTJnH9oQYheR4m1KC9owq0XH6MuF35O7AIQjE=;
        b=eqgB+gtFFx2gq3JHR2O9FZIj0vY7Mc3Km8Ef8slS7Z9afMVY5v2n10DtT5DqPiNTXn
         tm6oKKrA1QeDouE4ashrSGohrZXik2bnEcQi5HNDtxjV+HWTMhzsCTXyyU09uWh5Kdts
         2u/JqHQ5ueWDw22hi9lWtWGJXub/fp767zq7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806132; x=1711410932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jncCK9aTJnH9oQYheR4m1KC9owq0XH6MuF35O7AIQjE=;
        b=xKMoBK88ovR3nrVD2U1HJ6gFQolnPGnYpTO7UGQLH2KaI4SASD8nVfU3NMgckewW+j
         9UMcDBmkPDHSAW8FIBGW6gZBWYwYR3B45Zcj2HZwl54hgTs5MlAAYUtg25HaYkaeB1Bv
         SKQ3Kyt7SVKCA6XTBMYphanlculUI3Vm7wXS3Rs4jC0EHi4J5DCKWZYqOXv2eNhGv0Fn
         /kTFTBi9d5r1sT+zQRikUGF3twq2GIRs1AZwXXqy+PAol7FXlEo8evPYIKIOuhANR5dT
         mUWkSfBUNA9rHYsxusPIlSfHK5htbpiYTcs0B1BUK0x0roSRLC2XgeNO1TqyK8/8kj72
         XjsA==
X-Forwarded-Encrypted: i=1; AJvYcCWi/ghP7GTPzF2023f6ljv0E9CBM/Ru2qJRSWybDFN8H35/8ahwf1OQo2FTeiKcQV7AOGG6S1NnZVZ/c5mBCWMEslb3Zd3vEv1WMQDw
X-Gm-Message-State: AOJu0YxfwjGLqdNRU6Mm+OEhb33DKGk13yD0b41o8K8HzR0Qe2Cqojsv
	vRGAJ2OA6/33kd/Hq0KYycxqjsa5hmkopuRlGiRNfrl3ahb4d00g7yYpXxNiD98Wm4qfpZ0ecm9
	cXg==
X-Google-Smtp-Source: AGHT+IHeJjk+X8VL/kQzFnMLRimmoKUCR3xzZLlpLovHDemxVv6glcUkJy2psvzsXL54QGoJkWlqRg==
X-Received: by 2002:a05:620a:2714:b0:787:4148:f6e3 with SMTP id b20-20020a05620a271400b007874148f6e3mr1868765qkp.37.1710806132048;
        Mon, 18 Mar 2024 16:55:32 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id h15-20020ae9ec0f000000b00787930320b6sm4991690qkg.70.2024.03.18.16.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:55:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Mar 2024 23:55:23 +0000
Subject: [PATCH 1/5] media: uvcvideo: Allow custom control mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-billion-v1-1-2f7bc0ee2030@chromium.org>
References: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
In-Reply-To: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Some advanced controls might not be completely implemented by vendors.

If the controls are a enumeration, UVC does not gives a way to probe
what is implemented and what is not.

Lets create a new callback function where heuristics can be implemented
to detect what is implemented and what not.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 15 ++++++++--
 drivers/media/usb/uvc/uvcvideo.h | 59 +++++++++++++++++++++-------------------
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e59a463c27618..3e939b4fbaaaf 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2434,6 +2434,14 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 	return -ENOMEM;
 }
 
+static int __uvc_ctrl_add_custom_mapping(struct uvc_video_chain *chain,
+	struct uvc_control *ctrl, const struct uvc_control_mapping *mapping)
+{
+	if (mapping && mapping->add_mapping)
+		return mapping->add_mapping(chain, ctrl, mapping);
+	return __uvc_ctrl_add_mapping(chain, ctrl, mapping);
+}
+
 int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 	const struct uvc_control_mapping *mapping)
 {
@@ -2637,7 +2645,8 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 
 			if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
 			    ctrl->info.selector == mapping->selector) {
-				__uvc_ctrl_add_mapping(chain, ctrl, mapping);
+				__uvc_ctrl_add_custom_mapping(chain, ctrl,
+							      mapping);
 				custom = true;
 			}
 		}
@@ -2652,7 +2661,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 
 		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
 		    ctrl->info.selector == mapping->selector)
-			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
+			__uvc_ctrl_add_custom_mapping(chain, ctrl, mapping);
 	}
 
 	/* Finally process version-specific mappings. */
@@ -2664,7 +2673,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 
 		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
 		    ctrl->info.selector == mapping->selector)
-			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
+			__uvc_ctrl_add_custom_mapping(chain, ctrl, mapping);
 	}
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6fb0a78b1b009..611350a82c37f 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -101,34 +101,6 @@ struct uvc_control_info {
 	u32 flags;
 };
 
-struct uvc_control_mapping {
-	struct list_head list;
-	struct list_head ev_subs;
-
-	u32 id;
-	char *name;
-	u8 entity[16];
-	u8 selector;
-
-	u8 size;
-	u8 offset;
-	enum v4l2_ctrl_type v4l2_type;
-	u32 data_type;
-
-	const u32 *menu_mapping;
-	const char (*menu_names)[UVC_MENU_NAME_LEN];
-	unsigned long menu_mask;
-
-	u32 master_id;
-	s32 master_manual;
-	u32 slave_ids[2];
-
-	s32 (*get)(struct uvc_control_mapping *mapping, u8 query,
-		   const u8 *data);
-	void (*set)(struct uvc_control_mapping *mapping, s32 value,
-		    u8 *data);
-};
-
 struct uvc_control {
 	struct uvc_entity *entity;
 	struct uvc_control_info info;
@@ -336,6 +308,37 @@ struct uvc_video_chain {
 	u8 ctrl_class_bitmap;			/* Bitmap of valid classes */
 };
 
+struct uvc_control_mapping {
+	struct list_head list;
+	struct list_head ev_subs;
+
+	u32 id;
+	char *name;
+	u8 entity[16];
+	u8 selector;
+
+	u8 size;
+	u8 offset;
+	enum v4l2_ctrl_type v4l2_type;
+	u32 data_type;
+
+	const u32 *menu_mapping;
+	const char (*menu_names)[UVC_MENU_NAME_LEN];
+	unsigned long menu_mask;
+
+	u32 master_id;
+	s32 master_manual;
+	u32 slave_ids[2];
+
+	int (*add_mapping)(struct uvc_video_chain *chain,
+			   struct uvc_control *ctrl,
+			   const struct uvc_control_mapping *mapping);
+	s32 (*get)(struct uvc_control_mapping *mapping, u8 query,
+		   const u8 *data);
+	void (*set)(struct uvc_control_mapping *mapping, s32 value,
+		    u8 *data);
+};
+
 struct uvc_stats_frame {
 	unsigned int size;		/* Number of bytes captured */
 	unsigned int first_data;	/* Index of the first non-empty packet */

-- 
2.44.0.291.gc1ea87d7ee-goog


