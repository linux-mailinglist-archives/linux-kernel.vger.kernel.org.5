Return-Path: <linux-kernel+bounces-54458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56884AF7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBC31C23151
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0317A12B15D;
	Tue,  6 Feb 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a78RhLpi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D912AAD3;
	Tue,  6 Feb 2024 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206555; cv=none; b=hPRMCioVTPPGesx4yNUbJri63IEqzh3s58Zb8iyziwbksBFX9MYegcVwKD66Y7xEFD6hJU0Qgrox5oJ3NgpPMHdx5hkXyReH6asmGP+/UfzjKmHxvjbOqNMAS1KuQRbQCseIDFpFx8BGb6tMlIEUCRTsLOD2bCiNww+1sQHuCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206555; c=relaxed/simple;
	bh=+l8/EjbsSDKBZxu0xBjL+HgBDGvONuZhvfABUHiMgVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=miMSsdZwMG2m/blFiDz6u67bJJf7FN63029HTCeweJbsi6URTL0xXLb7BJjNGsAIKcC+jyg9EeFoVyZ4zojp7iNIH4zWoCv54xTfFd00g0J/S0oVKklIH8cvsvIJEwWJxfbxxUmjyesX0aNY8rLf7dau+N+D1+Xc1f0hKhrfdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a78RhLpi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707206545;
	bh=+l8/EjbsSDKBZxu0xBjL+HgBDGvONuZhvfABUHiMgVk=;
	h=From:To:Cc:Subject:Date:From;
	b=a78RhLpi4FufLvNxwnzJThKHnCF4fEMA2PwzAX38CQ+lYAztnchPLr2pVcUTmmFN6
	 cIL/XCDTIuB6bEYeS9uZ2ybQVJY2qZQ3NNQYdOs74G+KkFgFt2tG+ODmZSUUfwCVVr
	 0tmXI9rnHtG0jElHnU0/md6jgk0Xi9d9mxXTA6070r0T/w2iaeoMw8c0BZY98TP1Fz
	 K6/gvqPKP6YHSxjG+u3zeeF4n/UAWIFg94tOy9/uPXZI75/DP+jaq1PGLgonMWF5Gq
	 fL02YDW5OnyK50qdAUClR+MsNIM6IOUwnuMvM7qr7R96m6g6zR5UGw7j8I2x7aTf5G
	 xoJOtfkQzGYPg==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1A6D537803EE;
	Tue,  6 Feb 2024 08:02:25 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v19 0/9] Add DELETE_BUF ioctl
Date: Tue,  6 Feb 2024 09:02:10 +0100
Message-Id: <20240206080219.11951-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike when resolution change on keyframes, dynamic resolution change
on inter frames doesn't allow to do a stream off/on sequence because
it is need to keep all previous references alive to decode inter frames.
This constraint have two main problems:
- more memory consumption.
- more buffers in use.
To solve these issue this series introduce DELETE_BUFS ioctl and remove
the 32 buffers limit per queue.

VP9 conformance tests using fluster give a score of 210/305.
The 23 of the 24 resize inter tests (vp90-2-21-resize_inter_* files) are ok
but require to use postprocessor.

Kernel branch is available here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v19

GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
change is here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc

changes in version 19:
- Fix typo in commit message.
- Fix ioctl domentation
- Rework q->is_busy patch following Hans's comments
- Change where DELETE_BUFS is enabled

changes in version 18:
- rebased on top of:
  https://patchwork.linuxtv.org/project/linux-media/patch/20240118121452.29151-1-benjamin.gaignard@collabora.com/
  https://patchwork.linuxtv.org/project/linux-media/patch/92975c06-d6e1-4ba6-8d03-b2ef0b199c21@xs4all.nl/
- Add a patch to update vb2_is_busy() logic.
- fix __vb2_queue_alloc() parameters descriptions.
- rework bitmap free range finding loop
- remove per queue capability flag.
- rework v4l_delete_bufs() to check if VIDIOC_CREATE_BUFS is enabled
  and if vidioc_delete_bufs pointer is valid.
- update documentation.
- Direclty use vb2_core_delete_bufs() in v4l2_m2m_ioctl_delete_bufs().
  Remove useless static functions.

changes in version 17:
- rebased on top of:
  https://patchwork.linuxtv.org/project/linux-media/patch/20240118121452.29151-1-benjamin.gaignard@collabora.com/
  https://patchwork.linuxtv.org/project/linux-media/patch/92975c06-d6e1-4ba6-8d03-b2ef0b199c21@xs4all.nl/
- rewrite min_reqbufs_allocation field documentation.
- rewrite vb2_core_create_bufs() first_index parameter documentation.
- rework bitmap allocation usage in __vb2_queue_alloc().
- remove useless i < q->max_num_buffers checks.
- rework DELETE_BUFS documentation.
- change split between patch 7 and patch 8
- v4l2_m2m_delete_bufs() is now a static function.

 
Benjamin Gaignard (9):
  media: videobuf2: Update vb2_is_busy() logic
  videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
  media: test-drivers: Set REQBUFS minimum number of buffers
  media: core: Rework how create_buf index returned value is computed
  media: core: Add bitmap manage bufs array entries
  media: core: Free range of buffers
  media: v4l2: Add DELETE_BUFS ioctl
  media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
  media: verisilicon: Support deleting buffers on capture queue

 .../userspace-api/media/v4l/user-func.rst     |   1 +
 .../media/v4l/vidioc-delete-bufs.rst          |  79 +++++++
 .../media/common/videobuf2/videobuf2-core.c   | 223 ++++++++++++------
 .../media/common/videobuf2/videobuf2-v4l2.c   |  26 +-
 .../media/platform/verisilicon/hantro_v4l2.c  |   1 +
 .../media/test-drivers/vicodec/vicodec-core.c |   1 +
 drivers/media/test-drivers/vim2m.c            |   1 +
 .../media/test-drivers/vimc/vimc-capture.c    |   3 +-
 drivers/media/test-drivers/visl/visl-video.c  |   1 +
 drivers/media/test-drivers/vivid/vivid-core.c |   5 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   3 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  24 ++
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  10 +
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |   2 +
 include/media/videobuf2-core.h                |  52 +++-
 include/media/videobuf2-v4l2.h                |   2 +
 include/uapi/linux/videodev2.h                |  16 ++
 18 files changed, 369 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst

-- 
2.40.1


