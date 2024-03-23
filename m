Return-Path: <linux-kernel+bounces-112299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0D2887815
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A5F1C20E75
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3B168C4;
	Sat, 23 Mar 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijEkokqY"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F810A09
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711190886; cv=none; b=lpNxKd3mJCxDTDzKohYIoaQYW5HzXI1lVcXVvLLA6Ysd3f1z+LV+YHtAN7hb1v/3Pe07a8JhZ3V3AjHscGzna04o8jTCYaU4PZYyInubCdn2o1Vddn6iiDy0Ru+8J1cRdFZA1qPIqc7GrqZ5pICJToYesyv2rOpnErq2d0HeO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711190886; c=relaxed/simple;
	bh=grArgwWILGHp+XErUGWksBoUzSF7HtWzT2xoQS6GE98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DAsoBMSSzuaYs5/1xLhPZGv/BLTDkzhrBCGgY9yK6JSiohiAogvT/HO5XyiCgasder3u9bz5/d8Mmd+z1QujNQ8UDkQFk7HABaX608dQT+NZ0tYqLma6Tmt9Ss+0ugGEdmUWAbN7b2SyGTE1O+UGZMcfw/ro0eXQ08s/DzDk5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ijEkokqY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-430a25ed4e7so19859961cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711190884; x=1711795684; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCzgxime2HTFKG9qr1xUy7K/V50UG9uDOcs3OEczYac=;
        b=ijEkokqYYx3qCeKjRo/PDxngXis05i2ztwmirYPDtH/tTMZk9q1gvR2l8MIWkEB7IC
         e2B4XMYuTVwWzSkMf6+G6NqGNkrdV2fDauRjtz/I/LDw8u5+xA+BkSwE4O+cmPdE4P5f
         tPV+Fb7tTFUkNxNtlmNc3q1FpnntONdTuxo1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711190884; x=1711795684;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCzgxime2HTFKG9qr1xUy7K/V50UG9uDOcs3OEczYac=;
        b=Y65YJcqvuUlCUKZD2QHMve9Ti5UJzTeLnoNnI9YKTw+TLt/WqDUSjjIOK/Rbt+NiW9
         En3qJB31I89C7Z28LJjoI1K/rrRWsFFsYmokuLcbt0ceSrb9uiaujGIV11aq1UrtiEGL
         XLBnD0nWZYjw+EKHGDl3jZl26YOSmhS6GpaHv34+Tx3NnQ89PCDku0FI430+3MAtK4dF
         lf5x4Ab1IopcuLzsqftYSNOQzk2idC6AlSlTmrpxHPFmugyoOQ8Yrf9Csj1j2PLBIKXD
         5XCJ6sRGs1wnOU43+f4eE2vxkGibc4YVY1NmB/SOXG9KSRnvBIkksZ7uv5mgauDT/K1Q
         gE2g==
X-Forwarded-Encrypted: i=1; AJvYcCW4piFHcqVH35AFHbCBEcPaDSgzVBZe84W58DtkFsWUAEOFKKiNUDJwCoHK2k5V9ERYgfOmj20L3Py8U7iLaiYhzVb5k64OnCp1WtPa
X-Gm-Message-State: AOJu0YzoshwCW9QRbDzV5QeDizaVxElF13IjMRj+UbLSYblDJcD2GwFG
	lSm/z6tVrm+f8IL1oLTnXiTnGiWIwkw85+suX/t0K18o3Dq+9IznXKffUu21Mlejis17aVo6B2E
	=
X-Google-Smtp-Source: AGHT+IFzDyWMcwOwWEYBvtWC7gDCughw02/iq++NVtwf4NRcsaHYcFz8RLHZMrvxxh0dK7Ev2WmjDw==
X-Received: by 2002:ac8:5cc1:0:b0:430:a037:db36 with SMTP id s1-20020ac85cc1000000b00430a037db36mr2565726qta.32.1711190884055;
        Sat, 23 Mar 2024 03:48:04 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id gd14-20020a05622a5c0e00b0042f21fe66f7sm697213qtb.73.2024.03.23.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 03:48:03 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v10 0/6] uvcvideo: Fixes for hw timestamping
Date: Sat, 23 Mar 2024 10:48:01 +0000
Message-Id: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGz/mUC/4XNy2rDMBAF0F8JWldFGus1XfU/Shd6jGNBbRcpc
 Skh/16lyyKq1XAv3DM3VqlkquzldGOFjlzzvrUgxdOJxcVvZ+I5tYKBABAIgheqtCW+fF3ySvX
 i108eJgKwgOBUYm0YfCUeit/i0qbb9eOjlUuul718/346ZDtv/5qH5IITRqkCaKeEeo1L2dd8X
 Z/3cmbvTTxgrEBTkkvCSBOCkdBRprEyPZSAsyeys7Kpo6ixopriXUpRTtp5wI6ix4puijHCWIy
 GpHIdxYwV05RoPSIgUpx0R7FjxT6UWSbrQnAOZEdxY8U1RVDy0QOBD1NHwbGC3HCtvcNZmdkE+
 qPc7/cfg7dtAu0CAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.12.4

Add some fixes for fixing hw timestamp on some Logitech and SunplusIT
cameras. The issues have been previously reported to the manufacturers.

Also include a patch to fix the current hw timestamping logic for ANY
uvc 1.5 model running at under 16 fps.

@HungNien, the logic for empty_ts has slightly changed since v4, would
be great if you could test it on your end.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v10: Thanks Sergey and Laruent!
- Fix comments and style
- Link to v9: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v9-6-55a89f46f6be@chromium.org

Changes in v9:
- Fix bug on add_sample(). Sorry about that, click on send too fast :S
- Link to v8: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org

Changes in v8: Thanks Sergey!
- Move last_sof save into uvc_video_clock_add_sample().
- Improve comments on add_sample().
- Link to v7: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org

Changes in v7: Thanks Sergey!
- Fix all negative modulus, including old bug
- Improve doc for 1/4 second accuracy.
- Link to v6: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org

Changes in v6 (Thanks Sergey!):
- Rebase on top of linus/master
- Add missing host_sof assignment, ups :(. Sorry about that!
- Improve comments for empty TS quirk
- Link to v5: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org

Changes in v5: Thanks Dan
- Check for !buf on empty TS packets.
- Link to v4: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org

Changes in v4 (Thanks Laurent!):
- Rebase on top of pinchart/next/uvc
- Use heuristic for UVC_QUIRK_IGNORE_EMPTY_TS
- Link to v3: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org

Changes in v3 (Thanks Laurent!):
- Rebase on top of pinchart/uvc/next
- Fix hw timestampt handling for slow FPS
  - Improve commit message
- Quirk for invalid dev_sof in Logi C922
  - Improve commit message
- Allow hw clock updates with buffers not full
  - Fix typo and improve messages
- Refactor clock circular buffer
  - Improve commit message
- Quirk for autosuspend in Logi C910
  - Improve commit message
  - Add comments around the quirk
- Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
  - Improve comments
- Allow quirking by entity guid
   - unsinged int
- Extend documentation of uvc_video_clock_decode()
   - uvcvideo on commit message
   - Improve comment
- Link to v2: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org

Changes in v2:
- Require 1/4 sec of data before using the hw timestamps
- Add Tested-by SunplusIT
- Link to v1: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org

---
Ricardo Ribalda (6):
      media: uvcvideo: Support timestamp lists of any size
      media: uvcvideo: Ignore empty TS packets
      media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
      media: uvcvideo: Allow hw clock updates with buffers not full
      media: uvcvideo: Refactor clock circular buffer
      media: uvcvideo: Fix hw timestamp handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |   9 +++
 drivers/media/usb/uvc/uvc_video.c  | 155 ++++++++++++++++++++++++++-----------
 drivers/media/usb/uvc/uvcvideo.h   |   2 +
 3 files changed, 121 insertions(+), 45 deletions(-)
---
base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


