Return-Path: <linux-kernel+bounces-103497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332087C047
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B141F20F45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE171B58;
	Thu, 14 Mar 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y7qCtJO9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F671741;
	Thu, 14 Mar 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430356; cv=none; b=FZa1WuaYtKqbOTmvf39pr6I32k3wZS+p38FmZgNrOHw7JLzCCytgqhlJ2PKGHFJ7Tyq7hJQfMmFMj6wyGO+CCaVbTthVD8egrNM5J/JCVbyNsHEFIbala+GrVJimm/bJ0fDfUXmnCMVWX/5SoXjFGEVVbvWH9NHxAfLB/sUJG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430356; c=relaxed/simple;
	bh=3jxN6/gz20RUpRFzNpsbUnuOlYvOsZD7I007u9bVKlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OYJPhWcEthEEncGq6SVV0m9uk8o1mQ63kvXrsfhmB5jlG6kpWNTgTqyTSTEWTr93t9bNPG8sYp7QUcMxZ0M0t5PhHQFavfhuDY2GXLp97DD35Ejzz3DC2DyIvUJ5voso74lu81JgDAVc71MnKeBszTo9fr6rfMPwnP5GdIhjU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y7qCtJO9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710430353;
	bh=3jxN6/gz20RUpRFzNpsbUnuOlYvOsZD7I007u9bVKlc=;
	h=From:To:Cc:Subject:Date:From;
	b=Y7qCtJO9CCkvmdjA4z4qZo2OSAdadgDm3lVFwivYN0wjz+v4a6BrzUzBiHhz+jefZ
	 MPQonYWfyo9M+fmlCYNhyKAb1oI6mJndJjUnUqbBElmsWvmOiO/HfViItRL+t7BU1v
	 7/1Gbm86vOUDSeithRgraHRJPvPWQ8bnGP7u9XIDUTh5rSbQk/eV0R9bUU2YcXFRZK
	 O6LWkluQw+BkfS9EaEZ5nI++ZrnKC5F02JxhRzHW4QyTPhPKZjJAaNJR+ZxqFBS7Nc
	 /jzSHXgPt+b+LZY+7W36ewqbyc08v3iFHzYrfXuyd/NkvQs+9g/xhJEeQmZ/ZaeHBi
	 9cOvm7vB7F2/A==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8AADA378209A;
	Thu, 14 Mar 2024 15:32:32 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: mchehab@kernel.org,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v21 0/9] Add REMOVE_BUF ioctl
Date: Thu, 14 Mar 2024 16:32:17 +0100
Message-Id: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
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
To solve these issue this series introduce REMOVE_BUFS ioctl.

VP9 conformance tests using fluster give a score of 210/305.
The 24 of the 24 resize inter tests (vp90-2-21-resize_inter_* files) are ok
but require to use postprocessor.

Kernel branch is available here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v21

GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
change is here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc

changes in version 21:
- Be more careful about checking remove_bufs type field vs queue type.
- Add documentation about type checking error.
- Always set capabilities flags field.
- Do not set vidioc_remove_bufs for vim2m driver.

changes in version 20:
- Rename DELETE_BUFS into REMOVE_BUFS
- Change documention, structure and variables name to use 'remove'

changes in version 19:
- Fix typo in commit message.
- Fix ioctl domentation
- Rework q->is_busy patch following Hans's comments
- Change where DELETE_BUFS is enabled

Benjamin Gaignard (9):
  media: videobuf2: Update vb2_is_busy() logic
  videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
  media: test-drivers: Set REQBUFS minimum number of buffers
  media: core: Rework how create_buf index returned value is computed
  media: core: Add bitmap manage bufs array entries
  media: core: Free range of buffers
  media: v4l2: Add REMOVE_BUFS ioctl
  media: v4l2: Add mem2mem helpers for REMOVE_BUFS ioctl
  media: verisilicon: Support removing buffers on capture queue

 .../userspace-api/media/v4l/user-func.rst     |   1 +
 .../media/v4l/vidioc-remove-bufs.rst          |  85 +++++++
 .../media/v4l/vidioc-reqbufs.rst              |   1 +
 .../media/common/videobuf2/videobuf2-core.c   | 223 ++++++++++++------
 .../media/common/videobuf2/videobuf2-v4l2.c   |  34 ++-
 .../media/platform/verisilicon/hantro_v4l2.c  |   1 +
 .../media/test-drivers/vicodec/vicodec-core.c |   1 +
 .../media/test-drivers/vimc/vimc-capture.c    |   3 +-
 drivers/media/test-drivers/visl/visl-video.c  |   1 +
 drivers/media/test-drivers/vivid/vivid-core.c |   5 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   3 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  30 +++
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  15 ++
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |   2 +
 include/media/videobuf2-core.h                |  52 +++-
 include/media/videobuf2-v4l2.h                |   2 +
 include/uapi/linux/videodev2.h                |  17 ++
 18 files changed, 394 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-remove-bufs.rst

-- 
2.40.1


