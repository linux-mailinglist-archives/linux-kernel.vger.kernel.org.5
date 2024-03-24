Return-Path: <linux-kernel+bounces-113400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C4888406
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DD5285CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22701A437A;
	Sun, 24 Mar 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD/nE7s2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F171A435E;
	Sun, 24 Mar 2024 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320202; cv=none; b=IExBSY+7Gf8IOk273MiTS0j7Pw1/BiWN+sYU1JU+kS7aAEvigKxN7XTOjUkAr011VXo3OKXPUhtED1Mstqm8JMEdgY6TnW0DgKzh38GEPGXTN0RTqQC7WDnPtdZiNxGiwklx5JDNzrt7OBxA++DHNBtNrEwPFID8EfbQfKiwfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320202; c=relaxed/simple;
	bh=7OARqTesKM/jiOLpZPeVkEL/uYEhr73hABYHiTOiYjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifBgOBmtDyTVVbzkfyPb3g4ZbbJG5Q3jra68y57bY7w8CxCTZ0GVsq6itsJTpmy4IFkTAjAMTv0e4i8bNJWC/8bdFynowqXrErVJ3ymuBOcBCJVLcar/vC1lUejjM7C44aq84U/xBfolBvpiGrr2G7VrhOF/CzVC/gJ1XwpHFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD/nE7s2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F8DC433C7;
	Sun, 24 Mar 2024 22:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320201;
	bh=7OARqTesKM/jiOLpZPeVkEL/uYEhr73hABYHiTOiYjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lD/nE7s2XVKmOWcb+ulcNeFf9hRMCnFP+g1vAomI/2byBZDPZXBUgL68fxKDofmiz
	 uivDiZuaZVCX14fZ+o2nDyQCZx/L7axv9hUC/IjV6UlWq5EJFbNIhYUduKdnesQV8Z
	 k3UH6C5a236gE/8eQ7csUmQjlx0XTf3e+UPCpnznn1f4tITO2X3lX5uZlzY5uPjNy5
	 JqVE4rpExwStKBeiOikXLXkBbPv0jijCEAdQBN1OVnu6KzSo5xNwPd5pzfE7cZKQrd
	 semg7yg6qfq60N9XtFSg0/LZS1qsVjoSISDS2gHPRjcZkEpW0oMORiwTacxvVLTteC
	 MY3LCebU+1ICA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 509/715] media: usbtv: Remove useless locks in usbtv_video_free()
Date: Sun, 24 Mar 2024 18:31:28 -0400
Message-ID: <20240324223455.1342824-510-sashal@kernel.org>
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

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ Upstream commit 65e6a2773d655172143cc0b927cdc89549842895 ]

Remove locks calls in usbtv_video_free() because
are useless and may led to a deadlock as reported here:
https://syzkaller.appspot.com/x/bisect.txt?x=166dc872180000
Also remove usbtv_stop() call since it will be called when
unregistering the device.

Before 'c838530d230b' this issue would only be noticed if you
disconnect while streaming and now it is noticeable even when
disconnecting while not streaming.

Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")
Fixes: f3d27f34fdd7 ("[media] usbtv: Add driver for Fushicai USBTV007 video frame grabber")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil: fix minor spelling mistake in log message]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/usbtv/usbtv-video.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 62a583040cd48..702f1c8bd2ab3 100644
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
2.43.0


