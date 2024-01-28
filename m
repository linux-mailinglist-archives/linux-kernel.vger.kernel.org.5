Return-Path: <linux-kernel+bounces-41498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951983F2D5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA3A1F22635
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207AB8BE5;
	Sun, 28 Jan 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TOl5Yi3i"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9320FD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706407946; cv=none; b=Xiqa/k3VUY79xRJRnj5151zt/hxeijjqFA2Bu9j+QOdKnQqjLZejHQ+Q2NIv2DbLhUlI+JmwuIUHfPBMjdNCKsfTAPESQkffTw1JHI6pucGSjw2dPjiuZh8ASB9KoBTTLqAXvptx9tZ9gic5W0bhbLyxxFpKCY0d1+ATVIby5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706407946; c=relaxed/simple;
	bh=xPQ0PXiX5n2Y4YbHy5UWYmPUAytuGPVlH6TYVkRD8Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxLOJIWmYny4zJsin41K7ScGw7Yf0iSJf79dvXklJGhZic7kdHCgO/cY/oE77xIvSSeN56ICtL5SBmvj4AC5Krmwn4GOS10ALbH8Uc9568n+S47grqNoasUdafqBmxHyyxOM2srO5TN38yhb8fdZeHz0GpzDSyatAimx4zNmrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TOl5Yi3i; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7838af983c1so137949685a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 18:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706407943; x=1707012743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOgHCV5E3Be30rwf2RnaiPl5JJ07/Dl6Wk4WLvGCkYA=;
        b=TOl5Yi3ireZIuU/4W8N2tVF37x0lJnkVK6+cBxzEwFoeJKEWLk3xFo/ZUSUB8AXT1g
         R4GwkA75X2ka2hFlEywOIwux7IQTu9YlagmtqhphyNSHuADNM/QEGgEByecQo2YwhgZS
         FjbQbfnlRAjAaPU3C2XBUKYfPwnWHiYwLeTeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706407943; x=1707012743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOgHCV5E3Be30rwf2RnaiPl5JJ07/Dl6Wk4WLvGCkYA=;
        b=EmcNHOrC7zanJfc8AErqDdNLf7hlbO9E9v90SGnqgr4960EAdU70rReSVR/Qn7UstI
         mlP/5cP2BQdxLU6q9OypCShQBF7W+4j9BT5HDzhMICr6peILLaxWYn1vqMeBPYmMb6iR
         zQMOLsyoGCY2AzKOGT8UZGJ/ErdKnx4DFhn0icr6q0s3f+bZhtfPBf8+fWiFtLldpxlx
         yIeUS4R4arnbymzE8GUTVr3GWEeU071b9fyCzdG27xkRKlAD2JqiJuWwFkQqvwmwlX6+
         bE98WwsyhPQfp3CR3ogttg7wHZfLa18RsaBV08hH4xEH4G37oV4UzJgO7l1gfje49M6b
         juXw==
X-Gm-Message-State: AOJu0Yzja3CeEvuo8miu1PqM0JP6rNOuU2Gbcee1qmDKibdZWYV1lRVE
	kQoFeKDi8z/cW0ePM46+i9tBvD0XveQ970isbQ+uhajESQW1QB7RXI7go6vtAg==
X-Google-Smtp-Source: AGHT+IH+hk6gNAofiPiYjbeJjVjSll9nP6JGaxAuvO6ry6PkFSYfUZKlxlGVvj4dQrSmFMmS8hX13Q==
X-Received: by 2002:ac8:5b84:0:b0:42a:9aa8:776d with SMTP id a4-20020ac85b84000000b0042a9aa8776dmr1203101qta.130.1706407943512;
        Sat, 27 Jan 2024 18:12:23 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id ka23-20020a05622a441700b0042a98bf0117sm568061qtb.78.2024.01.27.18.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 18:12:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 28 Jan 2024 02:12:21 +0000
Subject: [PATCH 2/3] media: usb: pvrusb2: Fix Wcast-function-type-strict
 warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-fix-clang-warnings-v1-2-1d946013a421@chromium.org>
References: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
In-Reply-To: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Mike Isely <isely@pobox.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

Building with LLVM=1 throws the following warning:
drivers/media/usb/pvrusb2/pvrusb2-context.c:110:6: warning: cast from 'void (*)(struct pvr2_context *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
drivers/media/usb/pvrusb2/pvrusb2-v4l2.c:1070:30: warning: cast from 'void (*)(struct pvr2_v4l2_fh *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict] drivers/media/usb/pvrusb2/pvrusb2-dvb.c:152:6: warning: cast from 'void (*)(struct pvr2_dvb_adapter *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 5 +++--
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c     | 7 ++++---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c    | 7 ++++---
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98b..16edabda191c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -90,8 +90,9 @@ static void pvr2_context_destroy(struct pvr2_context *mp)
 }
 
 
-static void pvr2_context_notify(struct pvr2_context *mp)
+static void pvr2_context_notify(void *data)
 {
+	struct pvr2_context *mp = data;
 	pvr2_context_set_notify(mp,!0);
 }
 
@@ -107,7 +108,7 @@ static void pvr2_context_check(struct pvr2_context *mp)
 			   "pvr2_context %p (initialize)", mp);
 		/* Finish hardware initialization */
 		if (pvr2_hdw_initialize(mp->hdw,
-					(void (*)(void *))pvr2_context_notify,
+					pvr2_context_notify,
 					mp)) {
 			mp->video_stream.stream =
 				pvr2_hdw_get_video_stream(mp->hdw);
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
index 26811efe0fb5..8b9f1a09bd53 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
@@ -88,8 +88,9 @@ static int pvr2_dvb_feed_thread(void *data)
 	return stat;
 }
 
-static void pvr2_dvb_notify(struct pvr2_dvb_adapter *adap)
+static void pvr2_dvb_notify(void *data)
 {
+	struct pvr2_dvb_adapter *adap = data;
 	wake_up(&adap->buffer_wait_data);
 }
 
@@ -148,8 +149,8 @@ static int pvr2_dvb_stream_do_start(struct pvr2_dvb_adapter *adap)
 		if (!(adap->buffer_storage[idx])) return -ENOMEM;
 	}
 
-	pvr2_stream_set_callback(pvr->video_stream.stream,
-				 (pvr2_stream_callback) pvr2_dvb_notify, adap);
+	pvr2_stream_set_callback(pvr->video_stream.stream, pvr2_dvb_notify,
+				 adap);
 
 	ret = pvr2_stream_set_buffer_count(stream, PVR2_DVB_BUFFER_COUNT);
 	if (ret < 0) return ret;
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index c04ab7258d64..590f80949bbf 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1032,9 +1032,10 @@ static int pvr2_v4l2_open(struct file *file)
 	return 0;
 }
 
-
-static void pvr2_v4l2_notify(struct pvr2_v4l2_fh *fhp)
+static void pvr2_v4l2_notify(void *data)
 {
+	struct pvr2_v4l2_fh *fhp = data;
+
 	wake_up(&fhp->wait_data);
 }
 
@@ -1067,7 +1068,7 @@ static int pvr2_v4l2_iosetup(struct pvr2_v4l2_fh *fh)
 
 	hdw = fh->channel.mc_head->hdw;
 	sp = fh->pdi->stream->stream;
-	pvr2_stream_set_callback(sp,(pvr2_stream_callback)pvr2_v4l2_notify,fh);
+	pvr2_stream_set_callback(sp, pvr2_v4l2_notify, fh);
 	pvr2_hdw_set_stream_type(hdw,fh->pdi->config);
 	if ((ret = pvr2_hdw_set_streaming(hdw,!0)) < 0) return ret;
 	return pvr2_ioread_set_enabled(fh->rhp,!0);

-- 
2.43.0.429.g432eaa2c6b-goog


