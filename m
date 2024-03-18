Return-Path: <linux-kernel+bounces-106838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742587F44E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1B1C21A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8860254;
	Mon, 18 Mar 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EVd9vVLB"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937825FBB1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806138; cv=none; b=aJeFwsZCU9zn4KMIM0V6b8HHLBq8ql8iBftkA/rbtyWMHq/558n2j06gJFbcaErk3ub2UWiq62WY1X0OvCMP2WoGrdS+8iEBka9RwXWS0d6YkhG+v03Bl+Tf2hVRNHlkbHM5t4B0HPcCDx2t+Mfw7KWhxeQNWcJGQ7JgJ80J8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806138; c=relaxed/simple;
	bh=RsdInsKRFjFPeria6YprFZPQUFBlBulfguGTv/hRZ1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQ58AsjHJyA7Scf8piq+T7IV5KSe6PpkqxaO5xLR5Kidhajwsm0KDCiFSjkoJWo3k5mAGm7rJCPvJ6FgnIeyHdEDxptnc1yT6ce4rTNESh5xCc6hmyWlT45Fh+wtoxykixozUl02GzkJX0+PFwrIgCxtZvmIvaU5LU+jBdPVuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EVd9vVLB; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e67cf739d0so2131531a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710806135; x=1711410935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp7PBpqLGtiHuxscR4MF6KkBApKCYsHGzqcNSer1N74=;
        b=EVd9vVLB2cENY3Pesh2lL4O+CK66/vBx6go/d5Zr+120DXmGAxj4lfBqbntQlZo7QE
         hh31GXxK99TCPMk5H9nAL9ZP2wETMSlsHbjlFcxu+tK+sLPSSDIm6t7dLweaJ6V2i9i9
         2tjDbb1JroiyuAOu+afR0h8ZwTf7ujH3YU+7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806135; x=1711410935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zp7PBpqLGtiHuxscR4MF6KkBApKCYsHGzqcNSer1N74=;
        b=pM8B5IRHhch3BENuKVcU1Pu+PAr+7l8RExrLui3J2CfH5oVGkKdqBpBZdR57y72SbH
         CfVB3DxT/px+lB3fFlFyK6XpO5shkaSbbVfIPSiDBCA7/1KIv2UG1BJ4jO0WM2gjOk0Y
         CglkJtw0PFV6UCiBI5GEU7+k5Uy5w1UrPK//1COjwzlqXkfT9xU3814xw2dssoAuPiKt
         x8e7/IgUCxgEyaB7IUFYaKSb8qmCw3j+VgvKkor9R/g9gPxg1Ft+Bq4tz36y3o8tDsO2
         j199Lm4dFU8N6gX/9fJq4fYXZXZjuFhlnslzVVHzc1L8nwrew9+XCViUk05kIN5bKyKh
         K2aw==
X-Forwarded-Encrypted: i=1; AJvYcCUxANlRA2BbUlaltCKUNpG3S4/BnaJkmAPe71F9VXAmvMMUyvz87vvvvEEPqzfkN4i+n+0CCx3uYiaQdVP1xv1eSYYWYVYoSpxbw9Lk
X-Gm-Message-State: AOJu0YxiS9qM/IZaAEu5EYl+t+758W7cYASLMxkHd5u9hMVNq1QuwCf7
	D6oX7qgZ0zwujB3LeFXTN0glJvjPnd9KwgAgCRQ4zqDAg3j8nSG2+kJW9ATlQx8yH4Ejsv8UpU7
	6vg==
X-Google-Smtp-Source: AGHT+IGrUiFb9DP1hUk66/tEb1lXZjM4msiRZHH9Q61RHuQ1IhIkA3/IUKJ/6Fgiej0iK+12KRDq3w==
X-Received: by 2002:a9d:68c7:0:b0:6e6:7b62:3028 with SMTP id i7-20020a9d68c7000000b006e67b623028mr10352580oto.36.1710806135001;
        Mon, 18 Mar 2024 16:55:35 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id h15-20020ae9ec0f000000b00787930320b6sm4991690qkg.70.2024.03.18.16.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:55:34 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Mar 2024 23:55:26 +0000
Subject: [PATCH 4/5] media: uvcvideo: Cleanup version-specific mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-billion-v1-4-2f7bc0ee2030@chromium.org>
References: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
In-Reply-To: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

We do not have more version specific mappings. Let's remove this code
for now. It can be easily reverted later if needed.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9a0b81aca30d1..41578ded1174e 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -851,14 +851,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	},
 };
 
-static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc11[] = {
-	NULL, /* Sentinel */
-};
-
-static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc15[] = {
-	NULL, /* Sentinel */
-};
-
 /* ------------------------------------------------------------------------
  * Utility functions
  */
@@ -2660,7 +2652,6 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
 static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 			       struct uvc_control *ctrl)
 {
-	const struct uvc_control_mapping **mappings;
 	unsigned int i;
 
 	/*
@@ -2726,18 +2717,6 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 		    ctrl->info.selector == mapping->selector)
 			__uvc_ctrl_add_custom_mapping(chain, ctrl, mapping);
 	}
-
-	/* Finally process version-specific mappings. */
-	mappings = chain->dev->uvc_version < 0x0150
-		 ? uvc_ctrl_mappings_uvc11 : uvc_ctrl_mappings_uvc15;
-
-	for (i = 0; mappings[i]; ++i) {
-		const struct uvc_control_mapping *mapping = mappings[i];
-
-		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
-		    ctrl->info.selector == mapping->selector)
-			__uvc_ctrl_add_custom_mapping(chain, ctrl, mapping);
-	}
 }
 
 /*

-- 
2.44.0.291.gc1ea87d7ee-goog


