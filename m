Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18737F36F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjKUTx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUTxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:53:55 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9434618E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:53:51 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d0760cd20so1242916d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700596430; x=1701201230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4cUkquHttLevpn1Zu3e8taH/wWhZO4i4ER9BhBxxuE=;
        b=OASpZEkK5i0Ec1YlOkRW3KmMB8LXhpmI7gxu7QVFEMrhcYIG57h5DokEVm2AGBUt6u
         qM24e/8Ih5SxB72Ct/idJQNZrk6/0B7ejMPS39baqUKzBRnmcAra5M9c8DYb4JBmhyO+
         gWC765frNhgC9ov1OVcNjPgAIRbHti+4Sx1Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596430; x=1701201230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4cUkquHttLevpn1Zu3e8taH/wWhZO4i4ER9BhBxxuE=;
        b=DojC4ZKq5WV0Yt3T+VnKFIpWZvWC5S8nOX5pPesH1NI5kIRwrTFdI/81TlzxqdN+do
         Wc5hbNDTXQXcZPjBRRTA6wpuJIe7bdS24Bn4Hxca1f+xVxX5ad9Jhw6g4cyyOKYO80kK
         GyBQmPdV3dIwcHIXNUJ7NIQAIjDIkPPHerZbWWBk35IG4vu6Ug/UOLE1RACd8AA4AZeh
         uo+kGZt/olRDWM3E5V6BINrDGoFVWaXWU7UyObcqxXBX8wtyHZl27M+zyFxG8ppPd8o2
         Sls6Fn7GPYbQSKCrpFBSLRkQOZFHIBuGgu1SR5WMoaf0Sp0jLA8VpRp8nredkWh+bH7Y
         BoWw==
X-Gm-Message-State: AOJu0YyH22B38sGI/JIgTV0vULNXlyTHM1ehbpyrfDv1AxUaLPKm15zu
        DmJQAwrAtozh7IdWqajGKpnDGg==
X-Google-Smtp-Source: AGHT+IFj/O3cq9Lke/5x+0zBGtvTtLId9cT43ggEJaexUSQdujZlLxKmUTurLy6MG/da4zmsRoEalw==
X-Received: by 2002:a05:6214:3015:b0:677:9248:5a1c with SMTP id ke21-20020a056214301500b0067792485a1cmr729244qvb.3.1700596430741;
        Tue, 21 Nov 2023 11:53:50 -0800 (PST)
Received: from denia.c.googlers.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ct2-20020a056214178200b0065b0d9b4ee7sm4199409qvb.20.2023.11.21.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 11:53:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/3] uvcvideo: Attempt N to land UVC race conditions
 fixes
Date:   Tue, 21 Nov 2023 19:53:47 +0000
Message-Id: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMsKXWUC/33NQQrDIBAF0KsE17WMmtrYVe9Rukh0EgcSBU2EE
 nL3SpeFdjX8D+/PzjImwsxuzc4SFsoUQw3q1DDr+zAhJ1czkyAVKDB82jCsmPhCgXhnOi0G6Fo
 cBatk6DPyIfXB+orCNs+19JTXmF6fF0XU8/ixVgQHruXVCbCjRqPv1qe40LacY5rYs24V+c/L6
 lG3AtzFgGvVlz+O4w2dFeAM8AAAAA==
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Thanks!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
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
      media: uvcvideo: Do not halt the device after disconnect

 drivers/media/usb/uvc/uvc_ctrl.c   |  4 ----
 drivers/media/usb/uvc/uvc_driver.c | 11 ++++++++++
 drivers/media/usb/uvc/uvc_status.c |  2 +-
 drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
 drivers/media/usb/uvc/uvcvideo.h   |  2 ++
 5 files changed, 42 insertions(+), 22 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20230309-guenter-mini-89861b084ef1

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

