Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF37F4389
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbjKVKTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjKVKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:19:50 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17483
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:19:46 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77a453eb01cso421001685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700648385; x=1701253185; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVFvadoxSzf5SYQeJTY3QitzXTVI0S9cDNwIlxh29lY=;
        b=Jq+rojviM/AIfUjgTh5hQAUMnXPJxoq4U8F5h8j2S9+8nn2ubpWbRaM+KheJLVl0tH
         FVd7+/SugWj500/v1bFsdRh2goRd2sKnvR6pEVpcup/bLNC7KLT40OuVZ6wqqRsL58LD
         J9Ih06xisAtHcM5kAAhEY1AHzBpzPeP0PqBxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648385; x=1701253185;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVFvadoxSzf5SYQeJTY3QitzXTVI0S9cDNwIlxh29lY=;
        b=rfoa80Gh9t/rpUJ7fHHwzIeQ3x3kidBcXWJeIi2LwUpcqoqoQDsC4coHSYdwwSRH/Y
         QfsvUyjAi2P5agpQTdlJXdadLDLVKqyFqZw2cU1iRL/yumw0Twt2XUyc3bJiF9Ty5652
         JzxRhQ3LjhR0hvaDfd/opNAdxfkRFuhFiLXLkWs3NXkNcrB9wfC2Be8vbZ9kiHd3xwc9
         4ffKqIp9zSmgD6IcYQOjok+yOjOlc6CAt3FiQQvLerpbo2OKTFUxUe2EXRDf/XffAQek
         /bAA/U0SVDA5PgWxmaeU91zaJ2kf/ToUaRhx61V3wcTKZwBk5TFciVIFCiQbCi2tLOEi
         1LSg==
X-Gm-Message-State: AOJu0YxwjlkkTSetb5IeNyvgcwSJtU0wQgzzXhLs8YM6LDxw2cSIJgGE
        vmAEEe+2EUTQ3XmyfDviSI52dg==
X-Google-Smtp-Source: AGHT+IFK25yqYBsb8Rnd58NSQl61BGOexDH0O6LKARDslBijt86Yp+E6Ptm0ac9NlgtmXONUDZS3SQ==
X-Received: by 2002:a0c:f40b:0:b0:679:d238:8ca6 with SMTP id h11-20020a0cf40b000000b00679d2388ca6mr1576891qvl.65.1700648385476;
        Wed, 22 Nov 2023 02:19:45 -0800 (PST)
Received: from denia.c.googlers.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id di6-20020ad458e6000000b0066d1d2242desm4739352qvb.120.2023.11.22.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:19:45 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/3] uvcvideo: Attempt N to land UVC race conditions
 fixes
Date:   Wed, 22 Nov 2023 10:19:33 +0000
Message-Id: <20231122-guenter-mini-v4-0-3d94e1e34dc1@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALXVXWUC/33NwQqDMAwG4FeRntfRtLXTnfYeY4dqoxa0QquFI
 b77wg47yLZT+BO+PxtLGD0mdi02FjH75OdAQZ8K1g429Mi9o8ykkEooUfN+xbBg5JMPnld1ZaA
 RlcYOGJHGJuRNtKEdCIV1HGk5+LTM8fl+kYHG/UdbBi64kRcHou0M1ubWDnGe/Dqd59izB3Vl+
 c9L8mg0CFfWwmn1xauPB5Bw8Iq8q2yJFukum4Pf9/0FBgd7szABAAA=
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in 2020 Guenter published a set of patches to fix some race
conditions on UVC.
https://lore.kernel.org/all/20200917022547.198090-5-linux@roeck-us.net/

That kind of race conditions are not only seen on UVC, but are a common
sin on almost all the kernel, so this is what it was decided back then
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

Which will make obsolete a lot of (all?) of the video_is_registered() checks on
Guenter's patches.

Besides those checks, there were some other valid races fixed on his
patches.

This series is just a rebase of what I think is missing on UVC even
if we fixed v4l2/core with all the video_is_register() checks removed.

I have tested the series with lockdep and a loop of authorize/de-authorize
while steaming.

Thanks!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v4 Thanks Sergey!:
- Reorder patches
- Improve commit messages
- Do not process async work on exit.
- Link to v3: https://lore.kernel.org/r/20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org

Changes in v3:
- Introduce media: uvcvideo: Do not halt the device after disconnect
- Introduce media: uvcvideo: Always use uvc_status_stop()
- Link to v2: https://lore.kernel.org/r/20230309-guenter-mini-v2-0-e6410d590d43@chromium.org

Changes in v2:
- Actually send the series to the ML an not only to individuals.
- Link to v1: https://lore.kernel.org/r/20230309-guenter-mini-v1-0-627d10cf6e96@chromium.org

---
Guenter Roeck (1):
      media: uvcvideo: Lock video streams and queues while unregistering

Ricardo Ribalda (2):
      media: uvcvideo: Always use uvc_status_stop()
      media: uvcvideo: Do not use usb_* functions after .disconnect

 drivers/media/usb/uvc/uvc_ctrl.c   |  4 ----
 drivers/media/usb/uvc/uvc_driver.c | 13 ++++++++++-
 drivers/media/usb/uvc/uvc_status.c |  8 +++----
 drivers/media/usb/uvc/uvc_v4l2.c   |  2 +-
 drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
 drivers/media/usb/uvc/uvcvideo.h   |  4 +++-
 6 files changed, 48 insertions(+), 28 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20230309-guenter-mini-89861b084ef1

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

