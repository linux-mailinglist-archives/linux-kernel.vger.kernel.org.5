Return-Path: <linux-kernel+bounces-113333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EED88837C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441251C221FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648B196DF8;
	Sun, 24 Mar 2024 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBu56VIi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A86D1A8;
	Sun, 24 Mar 2024 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320134; cv=none; b=BHjsgYR0QGKj+jubkMu5Yi6GPz79+wxF+buu7xJ2+JVSe9TBlNDZtwEBFQourEN1SQfYzh/pg1SXAPXbY8LmrHque94rGDZJhyGBbbDzkswqvv33OqbSiyrmcaX0dF2N9XOtI/8tXQYk4ut8ClkQ1WQUNnJQimFVyAAKzuIqtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320134; c=relaxed/simple;
	bh=yYTK3GBeBJ6pb6nFTxDchYYPTvh21mQVFBwD5goDuPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk8F58cYpALXEYAbdvIpMgX2cspm1rh1oXvP2VRmHmsdL5Vy6Ybpt5HcuzrBPw8vsdg1uow5ehdDjMtbouP+z0QtxvdayuWb1298vKFd1Rp1N8BLNKJ2Uhwg29BThACoU9t8xthq7ot/NkTeSXwbwohwmCQfOu76lBWYWiWaXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBu56VIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D902C43399;
	Sun, 24 Mar 2024 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320134;
	bh=yYTK3GBeBJ6pb6nFTxDchYYPTvh21mQVFBwD5goDuPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBu56VIiTtw4NGvWbLAPbcCnWmtkJkL4ELezcR2FXnd4I2ycPGXoahy438MVmLQ8l
	 YHOGXSgVfmKtK5+ukP8BEM50mIoqrY7p73HPVGeTln9i53NxZxN4SiImqrvzKIU0fN
	 LxkRvmuRjIE0xbev7ZzqeVNiBMyszaHR7F50Pn6YiDZkhj7SYALZre5yd/hrGysZQl
	 LxWs8GJ4j19eh1R8UoyORyJBwer9M4BFr/pBcxEU19StWd/Ev2UkHFQSEvSfF8f+hT
	 1T9pEIHGr2Tbk/2PWXxXvXpuEqr3qG/7spqdWFfv5U2vE5GlVDfGI2hZtb145jhQYB
	 /w9bzcXJOx4fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 442/715] media: pvrusb2: fix pvr2_stream_callback casts
Date: Sun, 24 Mar 2024 18:30:21 -0400
Message-ID: <20240324223455.1342824-443-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 30baa4a96b23add91a87305baaeba82c4e109e1f ]

clang-16 complains about a control flow integrity (KCFI) issue in pvrusb2,
which casts three different prototypes into pvr2_stream_callback:

drivers/media/usb/pvrusb2/pvrusb2-v4l2.c:1070:30: error: cast from 'void (*)(struct pvr2_v4l2_fh *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1070 |         pvr2_stream_set_callback(sp,(pvr2_stream_callback)pvr2_v4l2_notify,fh);
      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/media/usb/pvrusb2/pvrusb2-context.c:110:6: error: cast from 'void (*)(struct pvr2_context *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  110 |                                         (void (*)(void *))pvr2_context_notify,
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/media/usb/pvrusb2/pvrusb2-dvb.c:152:6: error: cast from 'void (*)(struct pvr2_dvb_adapter *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  152 |                                  (pvr2_stream_callback) pvr2_dvb_notify, adap);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change the functions to actually take a void* argument so the cast is no longer
needed.

Fixes: bb8ce9d9143c ("V4L/DVB (7682): pvrusb2-dvb: finish up stream & buffer handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 8 ++++----
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c     | 6 ++++--
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c    | 6 ++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98bc..58f2f3ff10ee2 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -90,8 +90,10 @@ static void pvr2_context_destroy(struct pvr2_context *mp)
 }
 
 
-static void pvr2_context_notify(struct pvr2_context *mp)
+static void pvr2_context_notify(void *ptr)
 {
+	struct pvr2_context *mp = ptr;
+
 	pvr2_context_set_notify(mp,!0);
 }
 
@@ -106,9 +108,7 @@ static void pvr2_context_check(struct pvr2_context *mp)
 		pvr2_trace(PVR2_TRACE_CTXT,
 			   "pvr2_context %p (initialize)", mp);
 		/* Finish hardware initialization */
-		if (pvr2_hdw_initialize(mp->hdw,
-					(void (*)(void *))pvr2_context_notify,
-					mp)) {
+		if (pvr2_hdw_initialize(mp->hdw, pvr2_context_notify, mp)) {
 			mp->video_stream.stream =
 				pvr2_hdw_get_video_stream(mp->hdw);
 			/* Trigger interface initialization.  By doing this
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
index 26811efe0fb58..9a9bae21c6147 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
@@ -88,8 +88,10 @@ static int pvr2_dvb_feed_thread(void *data)
 	return stat;
 }
 
-static void pvr2_dvb_notify(struct pvr2_dvb_adapter *adap)
+static void pvr2_dvb_notify(void *ptr)
 {
+	struct pvr2_dvb_adapter *adap = ptr;
+
 	wake_up(&adap->buffer_wait_data);
 }
 
@@ -149,7 +151,7 @@ static int pvr2_dvb_stream_do_start(struct pvr2_dvb_adapter *adap)
 	}
 
 	pvr2_stream_set_callback(pvr->video_stream.stream,
-				 (pvr2_stream_callback) pvr2_dvb_notify, adap);
+				 pvr2_dvb_notify, adap);
 
 	ret = pvr2_stream_set_buffer_count(stream, PVR2_DVB_BUFFER_COUNT);
 	if (ret < 0) return ret;
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index d195bd6a2248b..d608b793fa847 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1033,8 +1033,10 @@ static int pvr2_v4l2_open(struct file *file)
 }
 
 
-static void pvr2_v4l2_notify(struct pvr2_v4l2_fh *fhp)
+static void pvr2_v4l2_notify(void *ptr)
 {
+	struct pvr2_v4l2_fh *fhp = ptr;
+
 	wake_up(&fhp->wait_data);
 }
 
@@ -1067,7 +1069,7 @@ static int pvr2_v4l2_iosetup(struct pvr2_v4l2_fh *fh)
 
 	hdw = fh->channel.mc_head->hdw;
 	sp = fh->pdi->stream->stream;
-	pvr2_stream_set_callback(sp,(pvr2_stream_callback)pvr2_v4l2_notify,fh);
+	pvr2_stream_set_callback(sp, pvr2_v4l2_notify, fh);
 	pvr2_hdw_set_stream_type(hdw,fh->pdi->config);
 	if ((ret = pvr2_hdw_set_streaming(hdw,!0)) < 0) return ret;
 	return pvr2_ioread_set_enabled(fh->rhp,!0);
-- 
2.43.0


