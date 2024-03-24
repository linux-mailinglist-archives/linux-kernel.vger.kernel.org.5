Return-Path: <linux-kernel+bounces-116279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD090889DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9D32C429C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C043CA31A;
	Mon, 25 Mar 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f34PB06n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC731802D0;
	Sun, 24 Mar 2024 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324123; cv=none; b=Y2dnn2ZeMPFSbcMbPlrwwXUbyX5b+26IC2ij0YuDp/+GeAmEyH4pDl0OJ6CBeHxN19BtU3SQoXS+24TpAeYgWYPCjyfvWI5gnd1f1SuxXvkglnlcjMfYh5ry/bDoFdyH5xS4tZqnnCHpTsPu+MSQG0oTVUBkRiMaLac6QFAaO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324123; c=relaxed/simple;
	bh=PgC/I/hLPi2WpnNE4b1Sm1HzySEZEC/xq+NE+iPiQkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXbElKcv2Bp/vg+Ev/X67SdptRTP6fMeaPRZ5bL+JO9u8DL5tAVJgFcTVfV+urb/Scfgv24ug43T2TzqYF2vCUVAIw6uDDQW1+fTwl74Wi7StpokbIHhvyMLafGu5BQU2UameDl6WN1XgoT2U/FpHwE695IN6N6oA4QdFQ8z1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f34PB06n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B58C43390;
	Sun, 24 Mar 2024 23:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324122;
	bh=PgC/I/hLPi2WpnNE4b1Sm1HzySEZEC/xq+NE+iPiQkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f34PB06nMZmEPFXxZ22v/Fj1QFoa6f2pc3b5j2hcpgliLFRQxfjfi17hY5bInm+vo
	 wqkpX19S5SWziNNF8R3tUfMsV1PtcHrZL8DOrHX8NBH2s8BEFsrRf1tou6ngsOMUmG
	 IWcuFT64qsdyRl6xIWwX2O6/Iq6SjscB+1f6eubI5xIdZnJaO+Jh0gKj4Fg4z6fr8E
	 kH2ZEsUao74g8AQSdzyUrAXAVibiROuRD2oYHIdQak14qGMY2sCqA/wq+5Bq/bMkXt
	 BljkDk+pBUmFVZ3wW2hrn4Tc9igxuk2KDA/mPkzn8XhaYmgYRXtfQqKJHjZJp8FTZN
	 bEOuPUBnhuOmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 120/183] media: pvrusb2: fix pvr2_stream_callback casts
Date: Sun, 24 Mar 2024 19:45:33 -0400
Message-ID: <20240324234638.1355609-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 6954584526a32..1b768e7466721 100644
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
index d79b4083c9d4a..f8da501689c32 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1037,8 +1037,10 @@ static int pvr2_v4l2_open(struct file *file)
 }
 
 
-static void pvr2_v4l2_notify(struct pvr2_v4l2_fh *fhp)
+static void pvr2_v4l2_notify(void *ptr)
 {
+	struct pvr2_v4l2_fh *fhp = ptr;
+
 	wake_up(&fhp->wait_data);
 }
 
@@ -1071,7 +1073,7 @@ static int pvr2_v4l2_iosetup(struct pvr2_v4l2_fh *fh)
 
 	hdw = fh->channel.mc_head->hdw;
 	sp = fh->pdi->stream->stream;
-	pvr2_stream_set_callback(sp,(pvr2_stream_callback)pvr2_v4l2_notify,fh);
+	pvr2_stream_set_callback(sp, pvr2_v4l2_notify, fh);
 	pvr2_hdw_set_stream_type(hdw,fh->pdi->config);
 	if ((ret = pvr2_hdw_set_streaming(hdw,!0)) < 0) return ret;
 	return pvr2_ioread_set_enabled(fh->rhp,!0);
-- 
2.43.0


