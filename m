Return-Path: <linux-kernel+bounces-63302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945B852D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BFE28D9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C8225A4;
	Tue, 13 Feb 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbQSEYY6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85F17567;
	Tue, 13 Feb 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818685; cv=none; b=n0GynSJHqhGpSaisXeHoLnz16/T28ZS71f+RmJb9ZO5EyZBYJMnZqYKqnMllEjdQqp7u/F3Ss3ygARdC8Qc5Zmgxhy0V7hlqKm+FIfl2De7YEPPoxEn4b6rJk1CYfCofC0EwyWgxvOysrl8lWIjJP67WLRtDpufIB14SN9wQ3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818685; c=relaxed/simple;
	bh=Arq9qNlXARFYxt4OXAC6yP44LIX+O7ZdPI6fd3sX+wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EhdRdxMLPikxO/ED1xrpDIsQrFhqVo+iTymEtCx3fW0WzkGndH+zUH9Ra7CeuE/tjDmCQy+u+SUsufskLR9G3oGO8s6QJi4r6s1oFcwlzwfuwgK1ypu58f0E99BdTcew1VIht9/O3PTB6uaBBs+Yq7MJ20ovuaTRzi5l96b6oWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbQSEYY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E306FC433F1;
	Tue, 13 Feb 2024 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818684;
	bh=Arq9qNlXARFYxt4OXAC6yP44LIX+O7ZdPI6fd3sX+wk=;
	h=From:To:Cc:Subject:Date:From;
	b=DbQSEYY6rZjfiKueayqJ39snIfBlDkSwHPpOrc8EV58H02tMPGzYaXnnspeLDSaqq
	 SNSQeztccLKqgNa219NSBi5zUrpjgqPgucIYj1k1CbJwep9CgMsUi+raL7y2cLamsz
	 Z1igDID6WPC5nXetFlyN5S1DsdjngU4UQdMMW5u93RKxnvRGy8sCQAAiFF+aAvpKZP
	 55jPeboB3ROcrPoM6aoPPta75iNHVqU3XvPVOe9ojEM3+sD7yu23zZ9ZDwlpLQXF67
	 LUdB5SJVNfFtIEI3CvDU14aKuBxeAMNLABIauq33XMp7JoIAiqCki3miJaJsDeu8X3
	 KVGu8pxEkOqXg==
From: Arnd Bergmann <arnd@kernel.org>
To: Mike Isely <isely@pobox.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Michael Krufky <mkrufky@linuxtv.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] media: pvrusb2: fix pvr2_stream_callback casts
Date: Tue, 13 Feb 2024 11:04:27 +0100
Message-Id: <20240213100439.457403-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

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
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 8 ++++----
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c     | 6 ++++--
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c    | 6 ++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98b..58f2f3ff10ee 100644
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
index 26811efe0fb5..9a9bae21c614 100644
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
index c04ab7258d64..b305ae7ed415 100644
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
2.39.2


