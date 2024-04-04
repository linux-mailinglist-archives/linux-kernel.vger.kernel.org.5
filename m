Return-Path: <linux-kernel+bounces-131916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C24898D89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F349B228E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F012F382;
	Thu,  4 Apr 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kVRo/NPI"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89412EBE8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253385; cv=none; b=bz+pa/sGOmFd1/KoohKBNfZ5M5820A8FAfB2kkELLqDYRM7W6MN8YDuvI39NWQiMXA8clKOpBJcLDZJ4PNk8irxid1EJLkeZdqHltqsSXESUMObokIjYDtCJRf10GFM+8MBvbdtke3LieLx9O7gfXqdHDjIOIkeEdPgpuWNqjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253385; c=relaxed/simple;
	bh=cpevCXhemU3AuNNOneQyUUUPZbMN1DTjK5rlZnT/TgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FsrfJ0Au6GkU5Ln0U7FBpUE5L3WoM/2bS4JXAeRgR1nyUimogkVdtYYmgtIUHJhXbpK2cuktgn0sbre6QdKb/POp4EWGjgyz0/NeRsHqrc1zTbVjy3nOqLeeA7xwXatU2SKf3NKJWA77oL3wi6fm+0wkg2O9xx+/jFSe8TJNZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kVRo/NPI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43456949480so3004461cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712253382; x=1712858182; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sICjXd/Iri+PbpHbTqI5EQVG9p15OT45zGLzvc441Ds=;
        b=kVRo/NPIsYEDTo7dRDjcph1d+0nfioAziBAyDwJriDnA2ie57cL4G45eARPtHUFIFn
         y8OfgNgJUgCV02krUo7/K3b1AdudaryOXsnrRaSQqQmMpiav06Gzu/AFB4lrjmw3u7JP
         IlVOCrvzBXiGnJOkD9BtBu7tLt5JLQ19gVo0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253382; x=1712858182;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sICjXd/Iri+PbpHbTqI5EQVG9p15OT45zGLzvc441Ds=;
        b=Mv8AMWhXn7f6GjdMy1mVQX7WfX4fbQcC2WcpQMxLVkzkP6h0Bv03fLH+ncBZRwcmt8
         s1tC81JPSBfCJormYayZspusgX5QmOVAjPCeE56t9ijw9D9FUu9oY07EGNFWYnEiZnII
         x2n0P3LwN+A95T2zApSzfi9sZ2VI65kXxV2zWCMscfNruprcIjs8iwSTxh598qkhiVWk
         wOW2x7qg+QVZ8iJMCktwrXQKW1UDjBIm4KFdZObn8pPdVjleA/M4wF9oRIuSWFqJ32Yc
         spUDpH3rvzsx7iGIWR8GC/1pHCMmz9y1vBtvNf41z9VAL8tRgTY+YDhl0zYLJxby/+4E
         YdCg==
X-Forwarded-Encrypted: i=1; AJvYcCX3dXEFcglaxUBRhM3zrv6Me1rPiwcLixCojuDQAyE04KPjeMUcAjVAW2OrB4dCbsN8jdHJWzQqJgk7eINwOeKq69oziuChggCGbhVm
X-Gm-Message-State: AOJu0YzdGop3ZbFJF5Nop8A+p0O5f2sCWSdDBw/doPk3kmE9wNqzlvEB
	oqIaYVLbpyfB6CsAx12TFZZNtjq+9ZkZS08sf/ZqAx7/lj7V28yR5Y9cFSxvkQ==
X-Google-Smtp-Source: AGHT+IFE+Z3rlRcNhzA+IuwKQ6WeJo2EAgoeoStIrtL8ZOFrx9Ar4+GDvQ/Pe0Azl40A50YTskqyDw==
X-Received: by 2002:ac8:5d50:0:b0:432:f6ab:a948 with SMTP id g16-20020ac85d50000000b00432f6aba948mr3850833qtx.20.1712253382412;
        Thu, 04 Apr 2024 10:56:22 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id cd15-20020a05622a418f00b00431801225d6sm7859494qtb.31.2024.04.04.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 10:56:21 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 04 Apr 2024 17:56:18 +0000
Subject: [PATCH v2] media: uvcvideo: Enforce alignment of frame and
 interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-uvc-align-v2-1-9e104b0ecfbd@chromium.org>
X-B4-Tracking: v=1; b=H4sIAMHpDmYC/22NTQ6CMBBGr0K6dkwLiMSV9zAs2jKlk0BrptJoC
 He3snb5Xr6fTSRkwiRu1SYYMyWKoUB9qoT1OkwINBYWtawbeZEK1mxBzzQF6Jwr1nT9qI0oeaM
 TgmEdrC+NsM5zkU9GR+/j4DEU9pRekT/HX1Y/+286K1Ag3VU12Jq+tc3deo4Lrcs58iSGfd+/h
 3jraboAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Struct uvc_frame and interval (u32*) are packaged together on
streaming->formats on a single contiguous allocation.

Right now they allocated right after uvc_format, without taking into
consideration their required alignment.

This is working fine because both structures have a field with a
pointer, but it will stop working when the sizeof() of any of those
structs is not a multiple of the sizeof(void*).

Enforce that alignment during the allocation.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
This is better than 3 allocations, and do not have any performance
penalty.

I have tried this patch printing the size and the address of the
pointers in the old and the new mode, and it looks the same.

[    2.235223] drivers/media/usb/uvc/uvc_driver.c:694 uvc_parse_streaming 432
[    2.235249] drivers/media/usb/uvc/uvc_driver.c:704 uvc_parse_streaming 432
[    2.235256] drivers/media/usb/uvc/uvc_driver.c:714 uvc_parse_streaming 00000000d32087cc 00000000d3803788
[    2.235265] drivers/media/usb/uvc/uvc_driver.c:720 uvc_parse_streaming 00000000d32087cc 00000000d3803788
---
Changes in v2: Thanks Laurent.
- Enforce alignment during allocation instead of using __aligned()
  macros.
- Link to v1: https://lore.kernel.org/r/20230501-uvc-align-v1-1-0f713e4b84c3@chromium.org
---
 drivers/media/usb/uvc/uvc_driver.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 7aefa76a42b31..7d9844ba3b205 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -663,16 +663,26 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 		goto error;
 	}
 
-	size = nformats * sizeof(*format) + nframes * sizeof(*frame)
-	     + nintervals * sizeof(*interval);
+	/*
+	 * Allocate memory for the formats, the frames and the intervals,
+	 * plus any required padding to guarantee that everything has the
+	 * correct alignment.
+	 */
+	size = nformats * sizeof(*format);
+	size = ALIGN(size, __alignof__(*frame)) + nframes * sizeof(*frame);
+	size = ALIGN(size, __alignof__(*interval))
+	       + nintervals * sizeof(*interval);
+
 	format = kzalloc(size, GFP_KERNEL);
-	if (format == NULL) {
+	if (!format) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	frame = (struct uvc_frame *)&format[nformats];
-	interval = (u32 *)&frame[nframes];
+	frame = (void *)format + nformats * sizeof(*format);
+	frame = PTR_ALIGN(frame, __alignof__(*frame));
+	interval = (void *)frame + nframes * sizeof(*frame);
+	interval = PTR_ALIGN(interval, __alignof__(*interval));
 
 	streaming->format = format;
 	streaming->nformats = nformats;

---
base-commit: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
change-id: 20230501-uvc-align-6ff202b68dab

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


