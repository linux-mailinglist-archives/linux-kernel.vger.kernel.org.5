Return-Path: <linux-kernel+bounces-30970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D07A8326F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09FE1F2311D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22E3C48A;
	Fri, 19 Jan 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5RAJ7rmy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493C3C6BA;
	Fri, 19 Jan 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657794; cv=none; b=mX/xt4oytZ9FVyBFwk0ZVOpfBZzZti8fJaazonljPzbDluC7GNzKWYAiZTZ2mbc0dKJVdiBqoKPCXyBiQv8IVHgteXDoaXI6CpGWqCyNpeCkP8MuGwe2pbgd6ytFClDikSzVW1XunckCZDE1+VAbKcHGdiw2OM8jZb+pyct0kCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657794; c=relaxed/simple;
	bh=d8pc7d+5bVJ+1CKyc9rJxHNauc4Q5Sm7tNJYT45ZHr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IIiaQid5yZB+lYvwqKyYyqV8IVFdALQmn0qG8IxUjQ7B1G/IeLE3KpE5fY0C+ysdKt3l5nlsqTD+IhuXj4MfJkthyq0Rc0oqACp44Vw9rf5W1t8QJbW9lFPl5hIGnbYzcjW6JtbmXlEP1Eprq8s/vQU/YgT0G78t6ArmlWCuVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5RAJ7rmy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705657790;
	bh=d8pc7d+5bVJ+1CKyc9rJxHNauc4Q5Sm7tNJYT45ZHr4=;
	h=From:To:Cc:Subject:Date:From;
	b=5RAJ7rmyFAh6syb9LXX8rNegaU8XZ7GEuZ9KkXQuFOuNCWprvWZq3BxY562QyRJ/4
	 eWoy48xRvLxjqsR69poIvJT42Jg619C0a2Fgywz7/xssBjJexmZ+JSoBTfJPdlkitX
	 AOnURUcJBizGH51pxPeJY2r3DNq/G/2QjhGBxbQiyIPeokC7OCI7BpOc3lWgrygbS/
	 CUpe/6Ulg7R2xd81j+10lDlJw/RAenCXOkM3wbfuHRqK2FeGMB2onFwm9hu3lWw6K5
	 Wum3c4UluAfwBfJfyhx5NpmY78ejEcFlPjxkv4/qB7pNQ9F8zXVod9aPsk+35Ba9o9
	 ZFhz1iJID6x/Q==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5EFAC37811F4;
	Fri, 19 Jan 2024 09:49:50 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v17 0/8] Add DELETE_BUF ioctl
Date: Fri, 19 Jan 2024 10:49:36 +0100
Message-Id: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
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
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v1

GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
change is here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc

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

changes in version 15:
- Check that PLANE_INDEX_BITS value match with VIDEO_MAX_PLANES.
- Add a check on vb->vb2_queue in vb2_queue_add_buffer()
- Fix the remarks done by Hans, Thomasz and Andrzej. Thanks for the time
  they spend (again) on the review.


Benjamin Gaignard (8):
  videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
  media: test-drivers: Set REQBUFS minimum number of buffers
  media: core: Rework how create_buf index returned value is computed
  media: core: Add bitmap manage bufs array entries
  media: core: Free range of buffers
  media: v4l2: Add DELETE_BUFS ioctl
  media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
  media: verisilicon: Support deleting buffers on capture queue

 .../userspace-api/media/v4l/user-func.rst     |   1 +
 .../media/v4l/vidioc-delete-bufs.rst          |  80 +++++++
 .../media/v4l/vidioc-reqbufs.rst              |   1 +
 .../media/common/videobuf2/videobuf2-core.c   | 222 ++++++++++++------
 .../media/common/videobuf2/videobuf2-v4l2.c   |  34 ++-
 .../media/platform/verisilicon/hantro_drv.c   |   1 +
 .../media/platform/verisilicon/hantro_v4l2.c  |   1 +
 .../media/test-drivers/vicodec/vicodec-core.c |   2 +
 drivers/media/test-drivers/vim2m.c            |   2 +
 .../media/test-drivers/vimc/vimc-capture.c    |   4 +-
 drivers/media/test-drivers/visl/visl-video.c  |   2 +
 drivers/media/test-drivers/vivid/vivid-core.c |  17 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  20 ++
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  15 ++
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |   2 +
 include/media/videobuf2-core.h                |  50 +++-
 include/media/videobuf2-v4l2.h                |  13 +
 include/uapi/linux/videodev2.h                |  17 ++
 20 files changed, 402 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst

-- 
2.40.1


