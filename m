Return-Path: <linux-kernel+bounces-112300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B621887817
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B722826D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61E1756B;
	Sat, 23 Mar 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I/RVtlEE"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767510957
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711190887; cv=none; b=Al2O+V4ZJ0kTxPOAmyRsd6TYfYChptLwFluaFdVq+5EOaFUy7Sv5gS/lA2gqcgTIKuqfSkSZQ15BccDa0SSR34xVK8oB/uZE3tLpyu6ceXmJINIbVRHtajTmzfPghhyS/njzhJcTI9wiEutbtujriCWFpINLLxrF+JVVD4byb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711190887; c=relaxed/simple;
	bh=fZ2GQcWR2LSMXAN8SEJsWJKslJaKG8mYIhWGpRex+ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjDK3VWGaqxXgkMEjX/GIzCITbhqAxgSrNKx2bnkHQh1MsabYBGzX7fnJxoXoqoaxHkk4vLaxlo/6QMyaWswX+1/sENjx1dCGvLz+oSX7AuKWRcRU2oD/NqXiSggochcQhf4mWhJPZbs/BrcfP1jLAlRFdkLhMqsWShFwm7dn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I/RVtlEE; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c38f4e18eeso1955575b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711190885; x=1711795685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rOIv4CmAvjMOXxj/CZ4nA7LTVnSWjKxFSJBQW0WDf0=;
        b=I/RVtlEE7KcpYWXk/ly+yjH1LyWEZytJz6ZzWL/KSuWNMrveoTjY3shbzA5ef7fjcJ
         ASHOlvn4tP0s/MjcsScWZOjFHqnNQ2GBQ18RSEMN/wszKivbvGnifUK5G7jMMZkmrEh1
         dQJzgEO+clhqc7OUQoKqtWoE5DgEOrrq89S6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711190885; x=1711795685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rOIv4CmAvjMOXxj/CZ4nA7LTVnSWjKxFSJBQW0WDf0=;
        b=EyeXcVUHYP7kV9z16cs6vW4xmc15+HHqHYwzW23O4dg/bm0v8LQaJ0VwmdVR9VTLWn
         PAd62bpRL4AAhz63vimSjaVpJ4SGpGOJ6Yy6iI4KmB1iVrcMKc5DRYQ/xrNOfA9XWTTx
         fWEG4QP5DGFvgky3ZOXI4p6YSTBEjb3m3TOn0Ky0wn/2/i8gLbPJhiJbWfTDYATgWFQa
         BNdAcA0WXiOwpOjBL5P6aZifNUArFqUnZ3arD3HzTLPmVJGhlIitLugRfYPWtGI23yGC
         N6Q9ymX+1neeYN0ygFJoH/+nseK5iuhQyMUyYSjpX2Wgi78zSzVKeUqTPnFdFTpIkWkm
         719A==
X-Forwarded-Encrypted: i=1; AJvYcCXoL9XKIPxBp0o0+hMmlg3M4nqWcgLxGdQYS4tbeak/BVxVKyTz+5CS9p1lcDmct7AsImxD+Y5CAWROjBI0LD5ig4fO88mW+L/I/N2f
X-Gm-Message-State: AOJu0YwGrTbo+2NQK8IFt03r4PyVuaF/GJg5RcxpE+QjV5ABq97TJhUD
	hGdkeM8//K2Mem3S6ZasyOqc6DNjPaJ/2NfHGhU1BKsOZvoud+QX4P7DMhjGFA==
X-Google-Smtp-Source: AGHT+IFHVD3iGO7zv2eF/zkpjXdnmLd1Nn01+NLdP4u67gj8MyA5X2280/g/bL806nn2PrWh7I11Kw==
X-Received: by 2002:a05:6808:128f:b0:3c3:ba62:9f14 with SMTP id a15-20020a056808128f00b003c3ba629f14mr2706069oiw.27.1711190884774;
        Sat, 23 Mar 2024 03:48:04 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id gd14-20020a05622a5c0e00b0042f21fe66f7sm697213qtb.73.2024.03.23.03.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 03:48:04 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 23 Mar 2024 10:48:02 +0000
Subject: [PATCH v10 1/6] media: uvcvideo: Support timestamp lists of any
 size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-resend-hwtimestamp-v10-1-b08e590d97c7@chromium.org>
References: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
In-Reply-To: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.12.4

The tail of the list lives at the position before the head. This is
mathematically noted as:
```
(head-1) mod size.
```
Unfortunately C, does not have a modulus operator, but a remainder
operator (%).
The reminder operation has a different result than the modulus if
(head -1) is a negative number and size is not a power of two.

Adding size to (head-1) allows the code to run with any value of size.

This does not change the current behaviour of the driver, as the size is
always a power of two, but avoid tedious debugging if we ever change its
size.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 7cbf4692bd875..659c9e9880a99 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -732,7 +732,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		goto done;
 
 	first = &clock->samples[clock->head];
-	last = &clock->samples[(clock->head - 1) % clock->size];
+	last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
 
 	/* First step, PTS to SOF conversion. */
 	delta_stc = buf->pts - (1UL << 31);

-- 
2.44.0.396.g6e790dbe36-goog


