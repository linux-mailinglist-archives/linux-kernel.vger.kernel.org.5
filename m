Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C23475B5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGTRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGTRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:46:59 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197E1726
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:46:57 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403a72df0a6so8188261cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689875217; x=1690480017;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PTH7Prt/pfWwGYiTl5+rTN2hsFZvF/29kSRnDb2688=;
        b=DFCv5uuhflgC21zhEPekgbavRuDkr3IVmUsh+LH26iUvYKgqWF3IcFmpU2NVi/2Y7U
         ae2+dUIQrv7yeUPD+oZLfZ3cf4gNh+2JNlmXJgEshBPWmVDkZQjF38ln6kDJZJf0NBP3
         crXWx2U26X9slVd2QOkH7+TSHX61ylKX9p8Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689875217; x=1690480017;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PTH7Prt/pfWwGYiTl5+rTN2hsFZvF/29kSRnDb2688=;
        b=l0VrHdOHvVnUhAFvLEccdzOjmPtpynRVqnh+G65bZwwgEh8ptTcpvmXaWiVHgoIM/H
         N+Afz4yzDBJpTPk1VK0+D9qckq4+tUM4kcJA5LB/9Ejk3DxhGYHTg3blEZQGA8VJtHZ8
         F65CHzIovCzVmN0vFKJuvRRny6NA23Mg3JHCEj45dE2KpiH2wEbPKJ2V3pX/jZZDHTz9
         ReKtBO1of9aEl+nePyx75Mlqd86WFG/NwFqU/h6JMs+dCBRFHP5DI5/3+oUOo9x8vP7z
         78PWQRa14Qds6PzseBNcrSomzPUTbFZfWrz3MnHlaXJy+xgW6E6o1Tay5AKq2++OTe44
         PUbw==
X-Gm-Message-State: ABy/qLYoDgkG9X8XQDaKyjcvOeYPRrVsQS9KdTKjAwGMxwp0xPYZMqPP
        PYlSiBJ6gAeAzZgZ1gfrESy8+w==
X-Google-Smtp-Source: APBJJlEVMo/NGK/95ZTtHbNgvmc8a1OWDJmbgcJkwnbMqn2USypsgzzjfB9WZKQzjcZfPMUWQ9sqzQ==
X-Received: by 2002:a05:622a:174f:b0:403:ab02:e827 with SMTP id l15-20020a05622a174f00b00403ab02e827mr6699364qtk.62.1689875217009;
        Thu, 20 Jul 2023 10:46:57 -0700 (PDT)
Received: from denia.c.googlers.com (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
        by smtp.gmail.com with ESMTPSA id b20-20020ac85414000000b0040541a8bd66sm574379qtq.60.2023.07.20.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 10:46:56 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 20 Jul 2023 17:46:54 +0000
Subject: [PATCH v2] media: uvcvideo: Fix OOB read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-uvc-oob-v2-1-c7745a8d5847@chromium.org>
X-B4-Tracking: v=1; b=H4sIAA1zuWQC/2WNwQ7CIBBEf6Xh7BqgmKon/8P0wNJt4dBiFks0T
 f9d6NXjm3mZ2UQiDpTEvdkEUw4pxKWAPjXCebtMBGEoLLTUrexUB2t2ECOCQanM1UppVCeKjTY
 RINvF+epXhckOtXoxjeFznDz7wj6kd+Tv8ZlVTf/nswIF4wVvaCzaFs3DeY5zWOdz5En0+77/A
 Mhoyne8AAAA
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@kernel.org, Zubin Mithra <zsm@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the index provided by the user is bigger than the mask size, we might do an
out of bound read.

CC: stable@kernel.org
Fixes: 40140eda661e ("media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU")
Reported-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Avoid reading index >= 31
---
Changes in v2:
- Use BITS_PER_TYPE instead of 32 (thanks Sergey).
- Add Reported-by tag.
- Link to v1: https://lore.kernel.org/r/20230717-uvc-oob-v1-1-f5b9b4aba3b4@chromium.org
---
 drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5e9d3da862dd..e59a463c2761 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1402,6 +1402,9 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 	query_menu->id = id;
 	query_menu->index = index;
 
+	if (index >= BITS_PER_TYPE(mapping->menu_mask))
+		return -EINVAL;
+
 	ret = mutex_lock_interruptible(&chain->ctrl_mutex);
 	if (ret < 0)
 		return -ERESTARTSYS;

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230717-uvc-oob-4b0148a00417

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

