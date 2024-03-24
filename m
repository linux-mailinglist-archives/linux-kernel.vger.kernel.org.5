Return-Path: <linux-kernel+bounces-115235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73A889367
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF21C2C9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D81CCE32;
	Mon, 25 Mar 2024 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVb8LdNd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDD18520B;
	Sun, 24 Mar 2024 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324332; cv=none; b=kWAE+6fpH/fdQhK9r1blQSj+ZoNQcNXgHeU1bAXZFN/VTBpJt192l8pjRqTGdnrNUGT0YRh3D7KeIwVNulJHQif2hxF4BQqErKj+xHKL3E39g2WrMFoGpoeDHGzTo06+T2yuCDYGUvkitT1uUAi0cMgw9y6xkXFVrGqFUeUhrD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324332; c=relaxed/simple;
	bh=5s0pWDmBEPFIOy02KFQp8liTlWUa2O7endpq9tizYYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHyC2iGJW/p6JrBPAoMqG4msNYRU3+sAG2ZULbVL9J+I1oprsfbxleowX/AOKEbP8bpzBvTZfS9v13swz3/+DsSLJ944nLiHoyD2S7TDWAZjG3THVeqk8+RY88DxE7apWCn3GP73jVRg00CyY5ugpLzQeY2Lf8raQpANqw5/rHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVb8LdNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D2DC43399;
	Sun, 24 Mar 2024 23:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324331;
	bh=5s0pWDmBEPFIOy02KFQp8liTlWUa2O7endpq9tizYYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVb8LdNdBn0AWBKsCziX53A81poQKGHBDIrX3OzcWcwMnvCYl9ntqCWNfyrNtWjQb
	 3lcv5qnUcdVdmCKEEQ7c+rRTNsHS8pxOCMm97PNZpidab/KX/kHZZdy1UCj4KhMWf+
	 CX0yfjR96nFrr4Rne1bMxyWsbPHX/NCZmwKfTGaz1Xp2rRXSAbOG9sdpMtivd/oZki
	 vNOr7mc2g41PPsou1x60zW7NmiR1YmvKqrOvZ8oOlclvH3bqobRTUdvVgpqUaCVeh/
	 /GMKpAxcakH5umo+dsFWy+A+DU1mXNkzNVuS8d63XEDDPDDlKpvNj0/X0ZGJZbpYuI
	 RuQitMXGGJwyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 102/148] media: pvrusb2: fix pvr2_stream_callback casts
Date: Sun, 24 Mar 2024 19:49:26 -0400
Message-ID: <20240324235012.1356413-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 9236463ba269f..28a9cfef8f9f2 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -99,8 +99,10 @@ static void pvr2_context_destroy(struct pvr2_context *mp)
 }
 
 
-static void pvr2_context_notify(struct pvr2_context *mp)
+static void pvr2_context_notify(void *ptr)
 {
+	struct pvr2_context *mp = ptr;
+
 	pvr2_context_set_notify(mp,!0);
 }
 
@@ -115,9 +117,7 @@ static void pvr2_context_check(struct pvr2_context *mp)
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
index 4b32b21411695..f326ab9a272e6 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
@@ -97,8 +97,10 @@ static int pvr2_dvb_feed_thread(void *data)
 	return stat;
 }
 
-static void pvr2_dvb_notify(struct pvr2_dvb_adapter *adap)
+static void pvr2_dvb_notify(void *ptr)
 {
+	struct pvr2_dvb_adapter *adap = ptr;
+
 	wake_up(&adap->buffer_wait_data);
 }
 
@@ -158,7 +160,7 @@ static int pvr2_dvb_stream_do_start(struct pvr2_dvb_adapter *adap)
 	}
 
 	pvr2_stream_set_callback(pvr->video_stream.stream,
-				 (pvr2_stream_callback) pvr2_dvb_notify, adap);
+				 pvr2_dvb_notify, adap);
 
 	ret = pvr2_stream_set_buffer_count(stream, PVR2_DVB_BUFFER_COUNT);
 	if (ret < 0) return ret;
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index 04d334152eae2..5e2c9aa649648 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1055,8 +1055,10 @@ static int pvr2_v4l2_open(struct file *file)
 }
 
 
-static void pvr2_v4l2_notify(struct pvr2_v4l2_fh *fhp)
+static void pvr2_v4l2_notify(void *ptr)
 {
+	struct pvr2_v4l2_fh *fhp = ptr;
+
 	wake_up(&fhp->wait_data);
 }
 
@@ -1089,7 +1091,7 @@ static int pvr2_v4l2_iosetup(struct pvr2_v4l2_fh *fh)
 
 	hdw = fh->channel.mc_head->hdw;
 	sp = fh->pdi->stream->stream;
-	pvr2_stream_set_callback(sp,(pvr2_stream_callback)pvr2_v4l2_notify,fh);
+	pvr2_stream_set_callback(sp, pvr2_v4l2_notify, fh);
 	pvr2_hdw_set_stream_type(hdw,fh->pdi->config);
 	if ((ret = pvr2_hdw_set_streaming(hdw,!0)) < 0) return ret;
 	return pvr2_ioread_set_enabled(fh->rhp,!0);
-- 
2.43.0


