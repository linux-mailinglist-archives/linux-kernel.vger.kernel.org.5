Return-Path: <linux-kernel+bounces-661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C9081442D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E361C228C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B51805D;
	Fri, 15 Dec 2023 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n364d2to"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643918C1D;
	Fri, 15 Dec 2023 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702631302;
	bh=t5c8Yp0R+c2ZKXr8l56iXkxZRPmCr8rL28xDgq+jsdk=;
	h=From:To:Cc:Subject:Date:From;
	b=n364d2to0Cy4X4PP5s0nMfdgWFxyA681JVRytxCl7ql4wgvyCR57r4WKLOJ+2NZc3
	 AzRB5PcUBrwoOTTFbBS5yKZujNO6HeinCmS7z1jGVo/SBV/ozBMCzoFUBGYfuGYsaV
	 EJR3AULVG1EBGg7NdLdaBbh48MMxsPg+U2WEJdJFnasmUEY1sWBUas8gvuhxaQTnc4
	 SL/3DNSF/Dx8X1SEAUo1q3fiZkstBI54BIEdY/3pOTvZEufnjSK+RZrR8Q76dE355c
	 E/dIVTMHHHIKSwt7WqxhvW2rZ3YyQ5K+kSTm/swmJ7O00yKpSWZifaNB8z9ho6s+HG
	 lK9mOqLwN78Ug==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2230437813DA;
	Fri, 15 Dec 2023 09:08:22 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v16 0/8] Add DELETE_BUF ioctl
Date: Fri, 15 Dec 2023 10:08:05 +0100
Message-Id: <20231215090813.15610-1-benjamin.gaignard@collabora.com>
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
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v16

GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
change is here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc

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

changes in version 14:
- Add max_num_buffers fields in v4l2_create_buffers32 structure and copy
  it from/to user data.
- Fix patch 44 commit header.
- Fix v4l_print_create_buffers() log.

Benjamin Gaignard (8):
  videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
  media: test-drivers: Set REQBUFS minimum number of buffers
  media: core: Rework how create_buf index returned value is computed
  media: core: Add bitmap manage bufs array entries
  media: core: Free range of buffers
  media: v4l2: Add DELETE_BUFS ioctl
  media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
  media: test-drivers: Use helper for DELETE_BUFS ioctl

 .../userspace-api/media/v4l/user-func.rst     |   1 +
 .../media/v4l/vidioc-delete-bufs.rst          |  79 ++++++++
 .../media/v4l/vidioc-reqbufs.rst              |   1 +
 .../media/common/videobuf2/videobuf2-core.c   | 171 +++++++++++++-----
 .../media/common/videobuf2/videobuf2-v4l2.c   |  40 +++-
 .../media/platform/verisilicon/hantro_drv.c   |   1 +
 .../media/platform/verisilicon/hantro_v4l2.c  |   1 +
 .../media/test-drivers/vicodec/vicodec-core.c |   2 +
 drivers/media/test-drivers/vim2m.c            |   2 +
 .../media/test-drivers/vimc/vimc-capture.c    |   4 +-
 drivers/media/test-drivers/visl/visl-video.c  |   2 +
 drivers/media/test-drivers/vivid/vivid-core.c |  17 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  19 ++
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  20 ++
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |  12 ++
 include/media/videobuf2-core.h                |  47 ++++-
 include/media/videobuf2-v4l2.h                |  13 ++
 include/uapi/linux/videodev2.h                |  17 ++
 20 files changed, 386 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst

-- 
2.40.1


