Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2F75E971
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGXCBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGXCBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2E72707;
        Sun, 23 Jul 2023 18:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C17460FD1;
        Mon, 24 Jul 2023 01:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C9CC433CB;
        Mon, 24 Jul 2023 01:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162367;
        bh=5SmmEGHfrZpuLd/DCKZNq391SJbmZqSPRMwsRqx3UYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIQoRwq//YTMI6vY6b6jDEsmIbkNIxdzksCyNjA6hJ+yxGwpBu6UASGNiwCh4MGoO
         7ZJXHqoRhc3L/0GNaNzlxlmRv40sQ3di81rcHau4YPc0XkpTl+wwg1K7UGQbgElvbn
         7r0ruhvrACSR4lF0k98FKwahGsdohXFoI0l/8J5VP7UYP4K9xo78wVpSY8RLFTthl8
         0arluwVDrjsq/XOQGrTmoyRzsKfqvla64IhnD4CW1LaMG77lyzdX3FUvPuHgth/Kq4
         oJxoAWga2IfplBp+fjaM9xybH79XHvH26EMtFOfuZDWdNBvfHtA1ezxnP12E5ovOQd
         tbeDZIkO++Xsg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Avichal Rakesh <arakesh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        laurent.pinchart@ideasonboard.com, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/34] usb: gadget: uvc: queue empty isoc requests if no video buffer is available
Date:   Sun, 23 Jul 2023 21:32:09 -0400
Message-Id: <20230724013238.2329166-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avichal Rakesh <arakesh@google.com>

[ Upstream commit c3ff12a92bd7072170978b8b41c2fa41b038139a ]

ISOC transfers expect a certain cadence of requests being queued. Not
keeping up with the expected rate of requests results in missed ISOC
transfers (EXDEV). The application layer may or may not produce video
frames to match this expectation, so uvc gadget driver must handle cases
where the application is not queuing up buffers fast enough to fulfill
ISOC requirements.

Currently, uvc gadget driver waits for new video buffer to become available
before queuing up usb requests. With this patch the gadget driver queues up
0 length usb requests whenever there are no video buffers available. The
USB controller's complete callback is used as the limiter for how quickly
the 0 length packets will be queued. Video buffers are still queued as
soon as they become available.

Link: https://lore.kernel.org/CAMHf4WKbi6KBPQztj9FA4kPvESc1fVKrC8G73-cs6tTeQby9=w@mail.gmail.com/
Signed-off-by: Avichal Rakesh <arakesh@google.com>
Link: https://lore.kernel.org/r/20230508231103.1621375-1-arakesh@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_video.c | 32 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index dd1c6b2ca7c6f..e81865978299c 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -386,6 +386,9 @@ static void uvcg_video_pump(struct work_struct *work)
 	struct uvc_buffer *buf;
 	unsigned long flags;
 	int ret;
+	bool buf_int;
+	/* video->max_payload_size is only set when using bulk transfer */
+	bool is_bulk = video->max_payload_size;
 
 	while (video->ep->enabled) {
 		/*
@@ -408,20 +411,35 @@ static void uvcg_video_pump(struct work_struct *work)
 		 */
 		spin_lock_irqsave(&queue->irqlock, flags);
 		buf = uvcg_queue_head(queue);
-		if (buf == NULL) {
+
+		if (buf != NULL) {
+			video->encode(req, video, buf);
+			/* Always interrupt for the last request of a video buffer */
+			buf_int = buf->state == UVC_BUF_STATE_DONE;
+		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
+			/*
+			 * No video buffer available; the queue is still connected and
+			 * we're traferring over ISOC. Queue a 0 length request to
+			 * prevent missed ISOC transfers.
+			 */
+			req->length = 0;
+			buf_int = false;
+		} else {
+			/*
+			 * Either queue has been disconnected or no video buffer
+			 * available to bulk transfer. Either way, stop processing
+			 * further.
+			 */
 			spin_unlock_irqrestore(&queue->irqlock, flags);
 			break;
 		}
 
-		video->encode(req, video, buf);
-
 		/*
 		 * With usb3 we have more requests. This will decrease the
 		 * interrupt load to a quarter but also catches the corner
 		 * cases, which needs to be handled.
 		 */
-		if (list_empty(&video->req_free) ||
-		    buf->state == UVC_BUF_STATE_DONE ||
+		if (list_empty(&video->req_free) || buf_int ||
 		    !(video->req_int_count %
 		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
 			video->req_int_count = 0;
@@ -441,8 +459,7 @@ static void uvcg_video_pump(struct work_struct *work)
 
 		/* Endpoint now owns the request */
 		req = NULL;
-		if (buf->state != UVC_BUF_STATE_DONE)
-			video->req_int_count++;
+		video->req_int_count++;
 	}
 
 	if (!req)
@@ -527,4 +544,3 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 			V4L2_BUF_TYPE_VIDEO_OUTPUT, &video->mutex);
 	return 0;
 }
-
-- 
2.39.2

