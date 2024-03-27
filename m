Return-Path: <linux-kernel+bounces-120525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA5788D8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8836D1F2AFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6A2E631;
	Wed, 27 Mar 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZwpXnrn"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81C2D047
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527890; cv=none; b=aYXGiC9dhXZk5cFew1bnzVpqqrPDvVSnoOHG5iprsm3fIRPOvCIa4GCRE7UM1vhrZ68h7RXFWDEGS99dsGOGeBGSqtdpxzINuefkQ/ozYzyoMNd3V1010BOLTAjqga/R2wSsxH3bibvyGKlCOrAO92YqoC8gEhLyVDjYb0+0HVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527890; c=relaxed/simple;
	bh=BegXE8sLVNcwTpCe7jZ+eaVUMxllzxROFRcqDXEIZDM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VApwwi3Vt4/If9+C1FxTWYlug+YgQJh6HZjyp+PEdLDR35GdV4jyjycTUUIwwnOJfXQziHJMceZ2hMLg+F5zrlnMyP4fUSI6FzWU1cinQAASTBAB4YzzRIQ/rM26oh5Oe2Uocp1M2isLJci+IGtFcyiOzZt7Mj8oFzwyQnA9wSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WZwpXnrn; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db3a09e96daso6028688276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711527888; x=1712132688; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNHk/QSKn10+8bs1SGPKjve797iLuqSHL7hGaF6HKqA=;
        b=WZwpXnrn7rWjqpY8Va4KDHp9xBcGHjVFi/osYZqn8VefaLmYRWKg6Z5YhC+/NXSrlN
         zvy9lcFeUvdFdPD17dbfLcsAy3nDIdZryJYydx/CpbM5DxlGNZulXXD0s+XRjlhhJCUY
         Wc5cgckKG753olHr4fwMN1PZ1QdFWQ7tn6l+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527888; x=1712132688;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNHk/QSKn10+8bs1SGPKjve797iLuqSHL7hGaF6HKqA=;
        b=U4hbyfluIcM5jyc3uAqARdoezhve7/0+texGBEALD2BTyqe2J2hQ2KhHOQDlOYX3kk
         KzyFfKHSdteIAaoLJKg0hfikLasqeZ/8Ku4chj/4zBffypEt/utc6LSPWx4vXlcTh1xC
         qgKSJv/q+sy0RcEnKvs6CIslkeZ9N9gqFqLWoSpjhaPj4bRdJYgjL37GCFQuNJcH1zAC
         vo64Xagw10jBKVOty++rQ5h5pKLjJhGUzxbjG2xzthFpCXB0nPEYPq3XjWXCGZi+GPgX
         84bUOjsPVx4FmzYf8mrTIAwYqNXopCnMICdhKUQxUR882oIlz/64Q+8kxYLO4RtOGgwZ
         kKLw==
X-Forwarded-Encrypted: i=1; AJvYcCVcAjyJ82Ryt4IuODVbeaGTTLKjF4WDd0jScQ8ZNbLgf4XCeXzK40hQ7zrWXgR7BYq+MD1W9V0kddcKQrZY4oV9CL7nlbcHNp4kiTEe
X-Gm-Message-State: AOJu0Yx11FkFK6R3YL6BM/6SUb/1/IOtv4bAKozhAFEZ3GLcotjC3pAi
	S8yAT/bogTuu8b7EJG9r3rctdxNedU8Qk2kuC5ueP6tzB0O2/+JNWcIGhnT1wQ==
X-Google-Smtp-Source: AGHT+IHYJMhTTILA1XQm0TfZIy/D0hzbLb7DDeZvqaFzIcoSlcxYufZ4lB36F6wl8gAgyrI24sMlKg==
X-Received: by 2002:a25:9706:0:b0:dc7:42b8:2561 with SMTP id d6-20020a259706000000b00dc742b82561mr341749ybo.34.1711527888016;
        Wed, 27 Mar 2024 01:24:48 -0700 (PDT)
Received: from denia.c.googlers.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ca9-20020a05622a1f0900b00430ea220b32sm4581691qtb.71.2024.03.27.01.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:24:47 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/4] uvcvideo: Attempt N to land UVC race conditions
 fixes
Date: Wed, 27 Mar 2024 08:24:43 +0000
Message-Id: <20240327-guenter-mini-v4-0-49955c198eae@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMvXA2YC/33PTQqDMBAF4KtI1k2Z/JhqV71H6UKTUQOaQKJCE
 e/eodCNtF0Nb+B7w2wsY/KY2bXYWMLVZx8DBX0qmB2a0CP3jjKTIBUoqHm/YJgx8ckHz6u6MqK
 FSmMnGJG2ycjb1AQ7EArLONJy8HmO6fk+sQoa9x9tq+DAjbw4AbYzWJubHVKc/DKdY+rZg7pW+
 c9L8mi0AFfW4LT64tXHa1CyPHhF3urWGuHoJTj6fd9ff/Z58TABAAA=
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

Back in 2020 Guenter published a set of patches to fix some race
conditions in UVC:
https://lore.kernel.org/all/20200917022547.198090-5-linux@roeck-us.net/

That kind of race conditions are not only seen in UVC, but are a common
seen in almost all the kernel, so this is what it was decided back then
that we should try to fix them at higher levels.

After that. A lot of video_is_registered() were added to the core:

```
ribalda@alco:~/work/linux$ git grep is_registered drivers/media/v4l2-core/
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:  if (!video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev)) {
drivers/media/v4l2-core/v4l2-dev.c:             if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (!video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (vdev == NULL || !video_is_registered(vdev)) {
drivers/media/v4l2-core/v4l2-dev.c:             if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (!vdev || !video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-ioctl.c:   if (!video_is_registered(vfd)) {
drivers/media/v4l2-core/v4l2-subdev.c:  if (video_is_registered(vdev)) {
```

And recently Sakari is trying to land:
https://lore.kernel.org/linux-media/20230201214535.347075-1-sakari.ailus@linux.intel.com/

Which will make obsolete a lot off (all?) of the video_is_registered() checks in
Guenter's patches.

Besides those checks, there were some other valid races fixed in his
patches.

This patchset tries to fix the races still present in our code.

Thanks!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v4: Thanks Sergey and Guenter
- Fix typos
- Move location of mutex_init
- Split patch to make the suspend change explicit
- Link to v3: https://lore.kernel.org/r/20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org

Changes in v3: Thanks Hans!
- Stop streaming during uvc_unregister()
- Refactor the uvc_status code
- Link to v2: https://lore.kernel.org/r/20230309-guenter-mini-v2-0-e6410d590d43@chromium.org

Changes in v2:
- Actually send the series to the ML an not only to individuals.
- Link to v1: https://lore.kernel.org/r/20230309-guenter-mini-v1-0-627d10cf6e96@chromium.org

---
Ricardo Ribalda (4):
      media: uvcvideo: stop stream during unregister
      media: uvcvideo: Refactor the status irq API
      media: uvcvideo: Avoid race condition during unregister
      media: uvcvideo: Exit early if there is not int_urb

 drivers/media/usb/uvc/uvc_driver.c | 24 ++++++++-------
 drivers/media/usb/uvc/uvc_status.c | 62 +++++++++++++++++++++++++++++++++++---
 drivers/media/usb/uvc/uvc_v4l2.c   | 22 ++++----------
 drivers/media/usb/uvc/uvcvideo.h   | 10 +++---
 4 files changed, 83 insertions(+), 35 deletions(-)
---
base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
change-id: 20230309-guenter-mini-89861b084ef1

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


