Return-Path: <linux-kernel+bounces-75039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D785E20C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027A71F24B78
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBFD8172A;
	Wed, 21 Feb 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XdK9Upwd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EA811F2;
	Wed, 21 Feb 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530885; cv=none; b=rGn9jBul8XJFGH2hDOYqdCdf/dcEq/qPA6XjDKrVxdW0tC73GrSsEvg7m2A/sYQJdgnmVhV9hxbfGiSW/+LHhu+44rCvQWozB05JtgKhDrTkadlBH5qnTqrS+zsttcNwZnZ/AOSn+e5u1Qzy9rkaVvCPoiEWk40Zo0FW0oXhVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530885; c=relaxed/simple;
	bh=jZucdOOz96VmEUErUF9LuSg3JBuTnd+d9rTWdPQVjys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uy9NtvO82A00NdNVXcJlt9p5e5gOCghgHmZnG00Je+7Md+FmLS8sszbWALJATsKsABx5c156sXMlIfpdE46NNHxZDbErxhgQwGsAMeM52Viw2HYdq/RRIDge06ych5XTstU5mXBHiXgH+FfsYGFYJDKXeMuZ5zqhZPQrsHq3Pio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XdK9Upwd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708530882;
	bh=jZucdOOz96VmEUErUF9LuSg3JBuTnd+d9rTWdPQVjys=;
	h=From:To:Cc:Subject:Date:From;
	b=XdK9UpwdeSelZb3MRsym1ENgeiTNQl8l2QnihXqg49Q0eVhrS+qEw5B5xiCQSEAbn
	 dgcbZY/aEipnZhmZTgPgliBMvNJzUCRPIkt7BC6bLrKpgQ+dgPjT/NGQmKpYaudMil
	 zDfYD/jknvqPUcOPN69/AUzInDY6R8JFiZo1MJJRE5SkO7Goe/4knzGsdilyzuJhtp
	 Bju+MHr+Qrg2VfsB+t2xvmM9AaFzW31BcYrqXKCin+UD4M1aWJmI9EHS+BW6l5zEVU
	 zQyRnMrCko/U2AxHnn5K+xntHBTxMJT34RvA7zUnl2I4MkMkSIMnztFiSRv24SyWBf
	 ppj0V6b528wPw==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5C1F83780629;
	Wed, 21 Feb 2024 15:54:41 +0000 (UTC)
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
Subject: [PATCH v20 0/9] Add REMOVE_BUF ioctl
Date: Wed, 21 Feb 2024 16:54:26 +0100
Message-Id: <20240221155435.100093-1-benjamin.gaignard@collabora.com>
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
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v20

GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
change is here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc

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
 .../media/v4l/vidioc-remove-bufs.rst          |  82 +++++++
 .../media/v4l/vidioc-reqbufs.rst              |   1 +
 .../media/common/videobuf2/videobuf2-core.c   | 223 ++++++++++++------
 .../media/common/videobuf2/videobuf2-v4l2.c   |  28 ++-
 .../media/platform/verisilicon/hantro_v4l2.c  |   1 +
 .../media/test-drivers/vicodec/vicodec-core.c |   1 +
 drivers/media/test-drivers/vim2m.c            |   1 +
 .../media/test-drivers/vimc/vimc-capture.c    |   3 +-
 drivers/media/test-drivers/visl/visl-video.c  |   1 +
 drivers/media/test-drivers/vivid/vivid-core.c |   5 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   3 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  32 +++
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  10 +
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |   2 +
 include/media/videobuf2-core.h                |  52 +++-
 include/media/videobuf2-v4l2.h                |   2 +
 include/uapi/linux/videodev2.h                |  17 ++
 19 files changed, 383 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-remove-bufs.rst

-- 
2.40.1


