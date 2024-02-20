Return-Path: <linux-kernel+bounces-72510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D94E85B476
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65961F212F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046265C908;
	Tue, 20 Feb 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VCkDb/nb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B295CDC5;
	Tue, 20 Feb 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416397; cv=none; b=jtfvB6t3GCNyOTh1Ti2XwovYb+MHsIQEyv/vYvD20TCwP90Yo0m/cNOtM/OpVsrbNb7xmLS3v9BGUfg46/c7zZhFIoF+GbeOQR12gUW9JZOCNYwu8DRCc0CIVEyafq4t5/pxyaElyaE78S3/wgQECfos91h/VNALXleWQdrawrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416397; c=relaxed/simple;
	bh=ui8eSZdVdgjumnpd/xojksq52lstAHrGG9UQ2pkhy5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1KPen7qXxDgmViP2iEN/Tg97PIwRoGdA6/pmWD4kZ7Ec1x751x8zQQ4P7b90a0Uqfx77Ns3CSAdCtAeY8+bpckooLRtdMl5feFklepC2+AcdLvvqBnaMoagrEUB7cOSqnd1FmXEysvUNp3GtUDW9g1TeJuozPlA4T/9pO577iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VCkDb/nb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708416394;
	bh=ui8eSZdVdgjumnpd/xojksq52lstAHrGG9UQ2pkhy5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=VCkDb/nb8Pg/lZSkR5XWI6gB/3S/z4/Wm1nHhSUQsSEBsZnFMEsdoOhLhi8upSQxM
	 9sjHBlfLQ3gsWtS1drMRAu9urUYXW/qQl3UGUA6839AnBlY28YYqHkTzIBI0Q+vQ3Y
	 cJiqGfUa6PMvi1K0fUQ2iHc652s8fINlVrECWxfNlJnAlbTMWkbb6dG9LNrNJVzKIp
	 Q5tK6XEfy22HcQjhgQinhqrdJ3WIoQOGZnYBk4xTJE7CFxeFTjghiIM3Hhre8EbINs
	 VKIdLoTG3PxgN1njK5URHGn7aO9FWqKGdUb/ZsQ5+qB0R/WVKPiPAxdGd7vLezxWNy
	 WxZfoW2YVJ+Vw==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 93C0B37813CB;
	Tue, 20 Feb 2024 08:06:33 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	tfiga@chromium.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: usbtv: Remove useless locks in usbtv_video_free()
Date: Tue, 20 Feb 2024 09:06:28 +0100
Message-Id: <20240220080628.13141-1-benjamin.gaignard@collabora.com>
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

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")
---
 drivers/media/usb/usbtv/usbtv-video.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 62a583040cd4..96276358d116 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -963,15 +963,9 @@ int usbtv_video_init(struct usbtv *usbtv)
 
 void usbtv_video_free(struct usbtv *usbtv)
 {
-	mutex_lock(&usbtv->vb2q_lock);
-	mutex_lock(&usbtv->v4l2_lock);
-
 	usbtv_stop(usbtv);
 	vb2_video_unregister_device(&usbtv->vdev);
 	v4l2_device_disconnect(&usbtv->v4l2_dev);
 
-	mutex_unlock(&usbtv->v4l2_lock);
-	mutex_unlock(&usbtv->vb2q_lock);
-
 	v4l2_device_put(&usbtv->v4l2_dev);
 }
-- 
2.40.1


