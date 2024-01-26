Return-Path: <linux-kernel+bounces-40016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4490183D8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A8E1C29B90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E91C14273;
	Fri, 26 Jan 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dtTi3LEN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEE134A3;
	Fri, 26 Jan 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266910; cv=none; b=E1M4GkXCbSuVbRLRgc0OOz+pdKtfNmldP/Jy5Mq6+OYNZdDkf5jSzEdfJ/wf+RkVaXXZ/1GqdUi78gSbBEv7qusxf/kDoJr0TCW+K/hZGIR2V6Nc2rLKWuDM72okicRLFFooXjKG0qB+C4nGWfCm6JSFUQnFIy9aJbCgJL7SW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266910; c=relaxed/simple;
	bh=6x9btn33raq90zH8k4DUM/aQvJRHiFqFxpsrW9aKu6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWGdmG3aBVPP2w8DDcZroi5o9xS7+VmjY9b4oIXBlWH+v3QRV8sZmTdcp5+KfLm8ydZ7dQ5Dpxlic5+bwGAg1qQBTDp9VFZyzBTq6q+2GxF/vY++TGeNgC12CN4lhsAQOIMWeXBrFd+/1KQT6VEFcYL4lU/x7uI2Qj2EG95ogj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dtTi3LEN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706266906;
	bh=6x9btn33raq90zH8k4DUM/aQvJRHiFqFxpsrW9aKu6A=;
	h=From:To:Cc:Subject:Date:From;
	b=dtTi3LENmgcD1gn/PFvTtJ8kDCFWPudRUlyz756jXRuA/4EOrUVul1TBIh/t+WtgO
	 mpjMN+RLIo35SXMOQ7YH0KunA2wDssJaxfbWF3ny4bBhcv6I97fhnAnC5MbBteZ1OI
	 RldZNIDzzOOZ6dmQht10XEyDCGOP/kDJ7+26YDRDI1Kj8A448h9pJFGbQweN6hodF1
	 oz8d5SEIscgBRCFNUrPi3+YcJ0chlzOkBIJ5Lx0yFWo+q55EHzYKWaJsPUMCEKCqdN
	 4DVfc3wLc7Vrg77oxucEp2g1bvKp0eCvs2vGmjn4zx+Di3KWOCuaKDiu0WZ8j6TLyw
	 cMsqTPMN8BXYA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 81BA53782072;
	Fri, 26 Jan 2024 11:01:46 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v18 0/9] Add DELETE_BUF ioctl
Date: Fri, 26 Jan 2024 12:01:32 +0100
Message-Id: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
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
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v18

GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
change is here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc

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

changes in version 16:
- The 50 patches related to add helpers for queue num_bufefrs have already been merged.
- 'min_queued_buffers' patch has been merged too.
- Add 'min_reqbufs_allocation' field in vb2_queue structure.
- Take care of 'min_queued_buffers' when deleting buffers
- Add more check about buffers range limit when deleting buffers.

Benjamin

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
 .../media/v4l/vidioc-delete-bufs.rst          |  78 ++++++
 .../media/common/videobuf2/videobuf2-core.c   | 225 ++++++++++++------
 .../media/common/videobuf2/videobuf2-v4l2.c   |  26 +-
 .../media/platform/verisilicon/hantro_v4l2.c  |   1 +
 .../media/test-drivers/vicodec/vicodec-core.c |   1 +
 drivers/media/test-drivers/vim2m.c            |   1 +
 .../media/test-drivers/vimc/vimc-capture.c    |   3 +-
 drivers/media/test-drivers/visl/visl-video.c  |   1 +
 drivers/media/test-drivers/vivid/vivid-core.c |   5 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  28 +++
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  10 +
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |   2 +
 include/media/videobuf2-core.h                |  52 +++-
 include/media/videobuf2-v4l2.h                |   2 +
 include/uapi/linux/videodev2.h                |  16 ++
 18 files changed, 371 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst

-- 
2.40.1


