Return-Path: <linux-kernel+bounces-89418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5955386F010
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6891F2162B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5D12B8D;
	Sat,  2 Mar 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Au110ipC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2C13FFA;
	Sat,  2 Mar 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709375838; cv=none; b=q0e1H3pc/qftsbD+ZlH1tELDeRgVowJ+znMRZAsfY5uSrXf+ZBfmfxHRhztnRXyktM53iX3QqPR4ih5egh7WdQCQckJum5h/aOWXWNIgMbh8Ob7TJEro2OJQVxuTy1qBgKtlo2urJuTTGObYDXZIMFVFtlKDgLUYL3rOC5qOjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709375838; c=relaxed/simple;
	bh=Qt6gKGDXcfjOpQe3iL889N1ww48uc0hVYruMXDJtULw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RK1tqqUVXzBumHit+pJPsbP4MotuL2U1wqStuuEBnr3GooC4hAUmI9NL/MUVe66jWCGGs2EuN8Mr4XgiZL8D3vMyec+T3eWtIcFhNMHVV+KwEyg9c4vy//JqeBxdMUx19xg1BA/+vBpNc9Hb+qe1AuL6fDku9iSZXdqmVsusQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Au110ipC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709375834;
	bh=Qt6gKGDXcfjOpQe3iL889N1ww48uc0hVYruMXDJtULw=;
	h=From:To:Cc:Subject:Date:From;
	b=Au110ipChXtlhRcvUDqFZKOlT8CHu1DuBudblJsV+5lO4CewkduDsBtxz9yyzy5i+
	 3TbzRRD5guqme4idGtYqEseoCsqu9aW2WbSN5F5O2hY344a2FmiqCHTqadUL1hW1sB
	 AXSYAkCcD6UiMAsIB+l45ZaJMHC8sLeTCCey7hSVfbJ0btGFBEAIBKZCTL+OrOGulH
	 dKUxXWSqznrLi+j/gOD2tyDFjUq+xLHES1PHtRJ83F7DjRuWNo9tTWwbA0WTW+vEPH
	 OXuw/jXFn7WS22XWo4FHbE+VZIzkU5trhTbaRkHvBAD6+JeyKznL4es28KznCqVi20
	 mvw0+OM0ekemA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C36A37802F2;
	Sat,  2 Mar 2024 10:37:13 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	tfiga@chromium.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] media: usbtv: Remove useless locks in usbtv_video_free()
Date: Sat,  2 Mar 2024 11:37:08 +0100
Message-Id: <20240302103708.86357-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove locks calls in usbtv_video_free() because
are useless and may led to a deadlock as reported here:
https://syzkaller.appspot.com/x/bisect.txt?x=166dc872180000
Also remove usbtv_stop() call since it will be called when
unregistering the device.

Before 'c838530d230b' this issue would only be noticed if you
disconnect while streaming and now it noticable even when
disconnecting while not streaming.

Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")
Fixes: f3d27f34fdd7 ("[media] usbtv: Add driver for Fushicai USBTV007 video frame grabber")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
version 2:
- Also remove usbtv_stop() call
- Reword commit message.
- Add tags
 drivers/media/usb/usbtv/usbtv-video.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 62a583040cd4..702f1c8bd2ab 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -963,15 +963,8 @@ int usbtv_video_init(struct usbtv *usbtv)
 
 void usbtv_video_free(struct usbtv *usbtv)
 {
-	mutex_lock(&usbtv->vb2q_lock);
-	mutex_lock(&usbtv->v4l2_lock);
-
-	usbtv_stop(usbtv);
 	vb2_video_unregister_device(&usbtv->vdev);
 	v4l2_device_disconnect(&usbtv->v4l2_dev);
 
-	mutex_unlock(&usbtv->v4l2_lock);
-	mutex_unlock(&usbtv->vb2q_lock);
-
 	v4l2_device_put(&usbtv->v4l2_dev);
 }
-- 
2.40.1


