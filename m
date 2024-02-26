Return-Path: <linux-kernel+bounces-82070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FD867EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA0B2DB30
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8241C12FF65;
	Mon, 26 Feb 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GOElx2h1"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADF12F389
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968773; cv=none; b=biyUwKUHJUfsYJEcQMV8sibZSHGd+jd0Nnm1NNbOHwersdZYXrO6qswYT1uhlaE1DwJYdoxZ8yDRJMhQjnPPisJGG+QiggYr60KF4yP2QvM4AZwzVTLZHYDVExAuDSqSNBkCqoO/SJ72rFjPFAcFmQVZzLXcqq/YjJJ3Bchi5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968773; c=relaxed/simple;
	bh=dcyaGfqQ8aucX+uJmQuZcf9wqW6CMLKxh3VcDhu7drg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDMb0fMuHRNcO51tfttProJiQL3KZR9/JIpnzOmIIF83CVdocq0inHkZJdvKaJHtvjW/PKJ1HSl3t9vC/ZAegXWgAlOOiHzgg3deUqhOcqW3BIdFuZTHoK77atlen0HBfv71TO+pgBi6JD7CXSKwpzd5Bl1KXOM23VM5heFyECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GOElx2h1; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787b5c68253so235046185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708968771; x=1709573571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaYfpx4jqxqKQ4ygGfIX8XBKNx0fRub/o4Qatc3GlF4=;
        b=GOElx2h12cGPZDE1L5CsA6kWYbbHIDTJgGQ7U8/B7YVdbDdYPtHW5EOr8pBLsfdyar
         ScKJHjwsxfm8TI4fNMxjKffXLHB6OIptEn0joSP1ieMaA0P9JmfXr9we9ukr/dFfV+ZI
         jDB+aSEEhIYQPfExte4rZO+gSpMzQ3bE0YdyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968771; x=1709573571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaYfpx4jqxqKQ4ygGfIX8XBKNx0fRub/o4Qatc3GlF4=;
        b=ifY+pLlhp4VDB9B4GXm63/KnxfZ3P2mjQvcjIIWETVImzRK4oRIPaKHLwAuk0iLBXg
         KfRNafpas/oFbKbAJza5UX/BBSz4Sbax08VsgZOvquRfvKSlBUg2mLBQ45c9OMBd2776
         ZuysF78KfnA4LoVfLQEDQfIIDbmPTv1iIEWOAY8vJ4vZRMXl3yTcZaH88tO1dV3BHsrq
         3XGIwMPw9qGiHqFS4Ztiu89iQJqvpBZkE4FNEcNh+PwyfOvfhekPU5P7gaCs9oKbPGd8
         P9C4v6m4sau1kmlkTh/gghAv8ybEm+OPC6HZN+kATOkvDx64XcL3KzlMb+lALoGNoM4K
         zLgA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Fzgu1T6XwAS1MyQEHU7eUTSVMjwxwF+QhGErKcxqidk5UCJmj5FFzKXF6fINx3iF9RhULq1zBo+p9JloBCEmpFJ0Baus5am5hlWj
X-Gm-Message-State: AOJu0YyuRAByaBqzHpLfFCwhgmm8PQUZwNxtE8qly+erknMF9HBB0Q+C
	ojC21MIxV7+bUrJTDAI4bEscdyk6qUGK5E1i11nTuUrluE/aCVgDqHO2Med7yw==
X-Google-Smtp-Source: AGHT+IFPFo6h6yoUZfpwUnRcJdbbOQwMO+GXxTDc9YEiO9pMJYeFAGXUAR4HJURnNZTsUOrD6721QA==
X-Received: by 2002:a05:620a:17aa:b0:787:c71f:a55c with SMTP id ay42-20020a05620a17aa00b00787c71fa55cmr7498759qkb.59.1708968770886;
        Mon, 26 Feb 2024 09:32:50 -0800 (PST)
Received: from denia.c.googlers.com (115.25.199.35.bc.googleusercontent.com. [35.199.25.115])
        by smtp.gmail.com with ESMTPSA id b11-20020a05620a04eb00b0078725d0345dsm2672669qkh.2.2024.02.26.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:32:50 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 26 Feb 2024 17:32:45 +0000
Subject: [PATCH v2 2/3] media: usb: pvrusb2: Fix Wcast-function-type-strict
 warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-fix-clang-warnings-v2-2-fa1bc931d17e@chromium.org>
References: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org>
In-Reply-To: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Mike Isely <isely@pobox.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Building with LLVM=1 throws the following warning:
drivers/media/usb/pvrusb2/pvrusb2-context.c:110:6: warning: cast from 'void (*)(struct pvr2_context *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
drivers/media/usb/pvrusb2/pvrusb2-v4l2.c:1070:30: warning: cast from 'void (*)(struct pvr2_v4l2_fh *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict] drivers/media/usb/pvrusb2/pvrusb2-dvb.c:152:6: warning: cast from 'void (*)(struct pvr2_dvb_adapter *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 5 +++--
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c     | 7 ++++---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c    | 7 ++++---
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98bc..16edabda191c4 100644
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
index 26811efe0fb58..8b9f1a09bd53d 100644
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
index c04ab7258d645..590f80949bbfc 100644
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
2.44.0.rc0.258.g7320e95886-goog


