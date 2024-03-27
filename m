Return-Path: <linux-kernel+bounces-120528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB0988D8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE39295A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836836AEE;
	Wed, 27 Mar 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ehGslJHm"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBC52E851
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527893; cv=none; b=iK6Hwlzcc8YG6b032B3by1RPiG7H5DRADON6QxTIYIkl6LGFqBVVRtCNNyANUK5haUr8/hfrRszhwoNC+RUp5S8IudNE5+T8zStkz5pbcjFdAFQ8hBYaIYezWqWB0UPIXmgu5tKlT6Mbpb4iRx4F5QfMhpfWmQOyke4Zyc0cvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527893; c=relaxed/simple;
	bh=nahiOHPE8IkoaUj7w2mRwbmhYqYPACwR6bZojjKSo5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIy1NWpYazBm3y/iVttAYHk9tmx56A/z+fRIu8eZz7tojONUxAspMfkYVA7tvGqqtrwfmoKCs91pOQ9O8jUAvCiopi/F1s/+HDiFlnY2gYhO3uRjuvEYSluat51uQ5UQFQCzXGPlSee9+SGKibBUwNgbCZOTEL8nNAyce0xgfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ehGslJHm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430c41f3f89so5710511cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711527891; x=1712132691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkLI9A62H1Ggh1TCkrNUBd+w+3o29QTz44nWNnN5YQA=;
        b=ehGslJHm5IXl9yQVuCJylonirPcnS3eQBD4CvC4/vwO8y2nejVQkF3w6ZimSMZ0oMO
         +gf0y63rkdhVn3FEwPusmdNhaLsd40Lba/bm14gwviaV0lHD1NtairyLJHIyCzzdhsyh
         yjN5cj2/3W1lWN3J09vjJvfLG4K051G/4DD8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527891; x=1712132691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkLI9A62H1Ggh1TCkrNUBd+w+3o29QTz44nWNnN5YQA=;
        b=kTQabWgNzUBA2z1/6n06TtADyfLPvVSRjsYnPfM2FpB4LVhzf+38x9xQjCelE3rlIj
         vln8sgGd21ht+Dw3vc0F5VRIhF+rl18FmeW6LbXCYVi0SyDjjHDn3Crfj6PZTa9bhzGC
         Si3ig+1aG3bpx41Qyzdal7Awi5peHVe+HdesnA3UW1yUFmEuZFpn7xfy3eHZYGlqkFU6
         9Km4dJSb9uW6SA//r+gU6til9lp0FMsJAsYEcF5SkXuaiCYmPf42AzzUxdPk9dXZ//NU
         T6kjFps2qA+OO3jK1/K7yUTBzoBORNB9SgssHAeGXK8G6Vsr2abghwCPuMwKEokTVNyR
         3hlA==
X-Forwarded-Encrypted: i=1; AJvYcCW4yi69abncTaox/MeReluyFaUQA5lBgNuuSOoVOepQa3UIhkxs9AV/LhzwjuRTDgT0ZfdUSm+hYm/ld6HNBmnQs/lWXYmygft7e6qE
X-Gm-Message-State: AOJu0YwtjR1Dt3JhiKNCqnRyo0b4Lpw/vREP/2U7wK6aq+mlTbR9K7wL
	ixBjmeIGt9GFtTos8PD3GXZNE7u1IvHCnx3uZWHIx3zi+hU1JUvO9WvTESH78g==
X-Google-Smtp-Source: AGHT+IGNUblwo/JlwehDtdXHQDYBlalI2e9kD1Y2cVhoODvGCnn0vyY+nubC8YlGQFiQ/qJcUAgU9w==
X-Received: by 2002:a05:622a:40a:b0:431:503e:4139 with SMTP id n10-20020a05622a040a00b00431503e4139mr6285588qtx.14.1711527891164;
        Wed, 27 Mar 2024 01:24:51 -0700 (PDT)
Received: from denia.c.googlers.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ca9-20020a05622a1f0900b00430ea220b32sm4581691qtb.71.2024.03.27.01.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:24:50 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Mar 2024 08:24:46 +0000
Subject: [PATCH v4 3/4] media: uvcvideo: Avoid race condition during
 unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-guenter-mini-v4-3-49955c198eae@chromium.org>
References: <20240327-guenter-mini-v4-0-49955c198eae@chromium.org>
In-Reply-To: <20240327-guenter-mini-v4-0-49955c198eae@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Max Staudt <mstaudt@chromium.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.12.4

The control events are handled asynchronously by the driver. Once the
control event are handled, the urb is re-submitted.

If we simply kill the urb, there is a chance that a control event is
waiting to be processed, which will re-submit the urb after the device is
disconnected.

uvc_status_suspend() flushes the async controls and stops the urb in a
correct manner.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 375a95dd30110..8fd8250110e2f 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -294,7 +294,7 @@ int uvc_status_init(struct uvc_device *dev)
 
 void uvc_status_unregister(struct uvc_device *dev)
 {
-	usb_kill_urb(dev->int_urb);
+	uvc_status_suspend(dev);
 	uvc_input_unregister(dev);
 }
 

-- 
2.44.0.396.g6e790dbe36-goog


