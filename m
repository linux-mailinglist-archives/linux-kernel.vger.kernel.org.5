Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68137E1EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjKFKwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjKFKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:52:38 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB6CC6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:52:35 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d13ac2796so28123966d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699267954; x=1699872754; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ4NhUhZrOjrN1RWsT6V7ekYOQJfHj+sCfHy/yyUHn4=;
        b=kbeuRVoW4U1oqDn7Smk5Qg/g5FpIWIR//okTtHhFdql8FttLvijH/ewXKmH9ruXRac
         W/Cu0YNq5SJaj+MZ+sgIUWKUR/xRsWnyn+ys7YGqY52EWPupV+hI562jo1qIzwjcVU/h
         wbYMdPDjVXQzRYQzhs21K1QS4mt5+ibR9V6wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267954; x=1699872754;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQ4NhUhZrOjrN1RWsT6V7ekYOQJfHj+sCfHy/yyUHn4=;
        b=OZkUdv+jr81WUsNn5yelRQeyVFag15wPLQq4rPVAg34pyvNsv9Oht9f5SfdIMkjp3g
         Lf1cnrjVxtoIk8RuP5VQ2T1eB1NjfzqdvfhXmdBjgZIPxSzurhCENmL071B4/R1X1pgJ
         8bjqPeUwZJVyyqjs6u6oRiKxRa6XXFJxu+pvJDuO43VDjUn4Xt3+iRNNL6fMb9qdxO3F
         Os/xeIQ/7U3rovXxVG5cHoF1G23xXOqyJqLQb3BFChQvc7zA9YnnBTPZBd7bSNi8cuPN
         meAiMp6aHg0v6hDkM5jeGjsjYky/Q3/QCcVExMK+zJk/M6A7wmP58TEOhSv/XuyLfYM0
         eyxg==
X-Gm-Message-State: AOJu0Yy/DEhcVVI9z/tnX4BIyY/xqR1JHJIrQDV6wYqw/zIDcrZcXUzi
        TJx7qft88BAdOMzSTnGYtF0iiA==
X-Google-Smtp-Source: AGHT+IFjHzHUuGPiHYEV3fyH0cDvsg0lYE6QDe7ZsmTkqkboQcbWEupA0NWREIBKfp+MYZiHZsrN6w==
X-Received: by 2002:a05:6214:20e6:b0:672:96a7:4614 with SMTP id 6-20020a05621420e600b0067296a74614mr26316553qvk.17.1699267954477;
        Mon, 06 Nov 2023 02:52:34 -0800 (PST)
Received: from denia.c.googlers.com (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id z10-20020a0cfc0a000000b0066d0f35554asm3314339qvo.79.2023.11.06.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:52:34 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 06 Nov 2023 10:52:27 +0000
Subject: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
X-B4-Tracking: v=1; b=H4sIAGvFSGUC/22NTQ6DIBBGr2JYdxrAtIld9R6NCwZGmUShASU2x
 ruXuu7yvXw/u8iUmLJ4NLtIVDhzDBX0pRHWmzASsKsstNStklrCWixQobCAa51CRGdRD6Lm0WQ
 CTCZYXxthnaYq34kG3s6DV1/Zc15i+px/Rf3sv+miQEGLxkjqhnt300/rU5x5na8xjaI/juMLp
 IC7lroAAAA=
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
index 28dde08ec6c5..4f3a510ca4fe 100644
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
+		event.u.frame_sync.frame_sequence = stream->sequence,
+		v4l2_event_queue(&stream->vdev, &event);
 	}
 
 	uvc_video_clock_decode(stream, buf, data, len);

---
base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
change-id: 20231020-uvc-event-d3d1bbbdcb2f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

