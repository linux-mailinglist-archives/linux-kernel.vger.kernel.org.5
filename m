Return-Path: <linux-kernel+bounces-20672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C8828352
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F2F289E65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA93526E;
	Tue,  9 Jan 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5CEw3PVj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EAF225CA;
	Tue,  9 Jan 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704793021;
	bh=8539QZnZ5psCXVDmlUrFIIdW4I4hQ5+9tYDUSRsKNzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=5CEw3PVjnmZQG2LEF4m5E6jWpdulsR1/KGfX0V/Ntr3zfXjFjhWNJxiSaXVi93CZ4
	 5S8LAsmya6LxvSgT/UhPLDN6L8yZ4yHeVBk0n4+t4VHwXReoNzUMnrMRXI8o5aLfVH
	 0o1SOVnSmNymINraeGKkJJ7NT9azoVZaLU+zC5dFZeUgXODuc3e5V473RKK0sPmIcH
	 FqU2FoIJrR0BVSi5gUUiAM71UWW5+FZ4/6PsaUsUts5cRvsQvAegy5H/1FJ172n1BQ
	 SbDSd8XwURdXw0PC2wLgQlhNSHfdW/BAAdkS1Xj5ho25OWrZioFLzgiPnAag4qiGff
	 OFoqm2LIM8E6w==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1C82E378104C;
	Tue,  9 Jan 2024 09:37:01 +0000 (UTC)
Message-ID: <5f85456c-4ee4-4ea2-be74-f35e6ac95a09@collabora.com>
Date: Tue, 9 Jan 2024 10:37:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/8] Add DELETE_BUF ioctl
To: hverkuil@xs4all.nl, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20231215090813.15610-1-benjamin.gaignard@collabora.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20231215090813.15610-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 15/12/2023 à 10:08, Benjamin Gaignard a écrit :
> Unlike when resolution change on keyframes, dynamic resolution change
> on inter frames doesn't allow to do a stream off/on sequence because
> it is need to keep all previous references alive to decode inter frames.
> This constraint have two main problems:
> - more memory consumption.
> - more buffers in use.
> To solve these issue this series introduce DELETE_BUFS ioctl and remove
> the 32 buffers limit per queue.
>
> VP9 conformance tests using fluster give a score of 210/305.
> The 23 of the 24 resize inter tests (vp90-2-21-resize_inter_* files) are ok
> but require to use postprocessor.
>
> Kernel branch is available here:
> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v16
>
> GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
> change is here:
> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc
>
> changes in version 16:
> - The 50 patches related to add helpers for queue num_bufefrs have already been merged.
> - 'min_queued_buffers' patch has been merged too.
> - Add 'min_reqbufs_allocation' field in vb2_queue structure.
> - Take care of 'min_queued_buffers' when deleting buffers
> - Add more check about buffers range limit when deleting buffers.

A little ping after the holidays about this series.

Thanks,
Benjamin

>
> changes in version 15:
> - Check that PLANE_INDEX_BITS value match with VIDEO_MAX_PLANES.
> - Add a check on vb->vb2_queue in vb2_queue_add_buffer()
> - Fix the remarks done by Hans, Thomasz and Andrzej. Thanks for the time
>    they spend (again) on the review.
>
> changes in version 14:
> - Add max_num_buffers fields in v4l2_create_buffers32 structure and copy
>    it from/to user data.
> - Fix patch 44 commit header.
> - Fix v4l_print_create_buffers() log.
>
> Benjamin Gaignard (8):
>    videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
>    media: test-drivers: Set REQBUFS minimum number of buffers
>    media: core: Rework how create_buf index returned value is computed
>    media: core: Add bitmap manage bufs array entries
>    media: core: Free range of buffers
>    media: v4l2: Add DELETE_BUFS ioctl
>    media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
>    media: test-drivers: Use helper for DELETE_BUFS ioctl
>
>   .../userspace-api/media/v4l/user-func.rst     |   1 +
>   .../media/v4l/vidioc-delete-bufs.rst          |  79 ++++++++
>   .../media/v4l/vidioc-reqbufs.rst              |   1 +
>   .../media/common/videobuf2/videobuf2-core.c   | 171 +++++++++++++-----
>   .../media/common/videobuf2/videobuf2-v4l2.c   |  40 +++-
>   .../media/platform/verisilicon/hantro_drv.c   |   1 +
>   .../media/platform/verisilicon/hantro_v4l2.c  |   1 +
>   .../media/test-drivers/vicodec/vicodec-core.c |   2 +
>   drivers/media/test-drivers/vim2m.c            |   2 +
>   .../media/test-drivers/vimc/vimc-capture.c    |   4 +-
>   drivers/media/test-drivers/visl/visl-video.c  |   2 +
>   drivers/media/test-drivers/vivid/vivid-core.c |  17 +-
>   drivers/media/v4l2-core/v4l2-dev.c            |   1 +
>   drivers/media/v4l2-core/v4l2-ioctl.c          |  19 ++
>   drivers/media/v4l2-core/v4l2-mem2mem.c        |  20 ++
>   include/media/v4l2-ioctl.h                    |   4 +
>   include/media/v4l2-mem2mem.h                  |  12 ++
>   include/media/videobuf2-core.h                |  47 ++++-
>   include/media/videobuf2-v4l2.h                |  13 ++
>   include/uapi/linux/videodev2.h                |  17 ++
>   20 files changed, 386 insertions(+), 68 deletions(-)
>   create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
>

