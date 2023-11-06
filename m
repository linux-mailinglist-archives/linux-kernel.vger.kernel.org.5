Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B957E1F17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjKFLA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjKFLA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:00:56 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B72D69
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:00:51 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7789cb322deso282240385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 03:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699268449; x=1699873249; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8Lc9yhYdHhhQyrx1NZSXf9nwg/wEFSRP4DUBdcsGag=;
        b=FiTrByRLW/8vJfATcUPWsChwGVkH6eyJeGKrUuSrXCLrNiZghNCqKTJZ0tdkr19due
         zrYUc5KWMmXhqQ0FeAc2a79NR7NMiFqIhhlPUq20Vl1L68eEGaawpGpijncQ6YJK+Z70
         J5UOViZ+UDty4kb6liEiiR1k09mkWasmMaPxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268449; x=1699873249;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8Lc9yhYdHhhQyrx1NZSXf9nwg/wEFSRP4DUBdcsGag=;
        b=fO+G11OCUIwBh/yqabN4PfE356HfUHBr6EyHn0XC/7HYzgvVP+LzE4IB/Ay5iBDGPF
         PVi3G0JsTjKGw94TfvO1rCCNM/ADCOs7dXb1R/Tgr5/o8IrDmoyB2w/+SbDvMjCL6X6w
         Uze2NiIVVWftLUO9b6UnEhQBhQydAuHeha/PV7L+8ggFLZWaxNGDWZkSbsBGCSXT1x9W
         31lBjF9l+X+2PlVMBZuoOBMnZPykso+n/YdqfRqxvUfdfoxRh3qeziajFzOn50ksh0Ns
         OxVw5Dr48Od7Jan4VjQIvIEQTNUrkMV1bvHdtVjiRGnM/BtLDl4VfnZEKJVg9lcLtSrq
         viag==
X-Gm-Message-State: AOJu0Yws4PdJyZAKUmG76fP3kY0udGwr2EwHh7EH+P8QlKtOi2mbLn8k
        HeBftstesCNNecOPcE6zdO7Ydg==
X-Google-Smtp-Source: AGHT+IG/qsPTlEshuDlwqMcy6FG/FrxW8iH4rewTKHPzTxKQN6hMQGMOqp939jEyrOYymGJq5qcaGQ==
X-Received: by 2002:a05:620a:2908:b0:76c:e2db:42b0 with SMTP id m8-20020a05620a290800b0076ce2db42b0mr34443254qkp.64.1699268449628;
        Mon, 06 Nov 2023 03:00:49 -0800 (PST)
Received: from denia.c.googlers.com (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id e15-20020a05620a12cf00b0076eee688a95sm3208519qkl.0.2023.11.06.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 03:00:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 06 Nov 2023 11:00:30 +0000
Subject: [PATCH v3] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-uvc-event-v3-1-c2d2fdaa2e2c@chromium.org>
X-B4-Tracking: v=1; b=H4sIAE3HSGUC/22Nyw7CIBREf6VhLYZHROvK/zAueFwKSQsNtETT9
 N+l3WiMyzOZM7OgDMlDRtdmQQmKzz6GCvzQIO1k6AB7UxkxwjgljOC5aAwFwoQNN1QpZbRiFtW
 +khmwSjJoV40w930NxwTWP/eD+6Oy83mK6bX/Fbql/6YLxRRzJSWB1or2xG7apTj4eTjG1KFtq
 LCPTIn4llmVz+YCXFhiLBU/8rqubxbOayb3AAAA
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esker Wong <esker@chromium.org>
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

Add support for the frame_sync event, so user-space can become aware
earlier of new frames.

Suggested-by: Esker Wong <esker@chromium.org>
Tested-by: Esker Wong <esker@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
We have measured a latency of around 30msecs between frame sync
and dqbuf.
---
Changes in v3:
- Sent wrong patch as v2 sorry :S
- Link to v2: https://lore.kernel.org/r/20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org

Changes in v2:
- Suggested by Laurent. Split sequence++ and event init.
- Link to v1: https://lore.kernel.org/r/20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org
---
 drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
 drivers/media/usb/uvc/uvc_video.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f4988f03640a..9f3fb5fd2375 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(struct v4l2_fh *fh,
 	switch (sub->type) {
 	case V4L2_EVENT_CTRL:
 		return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl_sub_ev_ops);
+	case V4L2_EVENT_FRAME_SYNC:
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 28dde08ec6c5..6a9410133908 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1073,9 +1073,16 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	 * that discontinuous sequence numbers always indicate lost frames.
 	 */
 	if (stream->last_fid != fid) {
+		struct v4l2_event event = {
+			.type = V4L2_EVENT_FRAME_SYNC,
+		};
+
 		stream->sequence++;
 		if (stream->sequence)
 			uvc_video_stats_update(stream);
+
+		event.u.frame_sync.frame_sequence = stream->sequence;
+		v4l2_event_queue(&stream->vdev, &event);
 	}
 
 	uvc_video_clock_decode(stream, buf, data, len);

---
base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
change-id: 20231020-uvc-event-d3d1bbbdcb2f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

