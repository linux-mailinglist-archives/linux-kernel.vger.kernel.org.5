Return-Path: <linux-kernel+bounces-18879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CB882647F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C52C1C20B90
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA3134BD;
	Sun,  7 Jan 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwjER7Ox"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8C134B3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 14:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027DDC433C8;
	Sun,  7 Jan 2024 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704637681;
	bh=1X8Ul3/Opyp81lNAQ1SojmK3B7nENWcPC3AhiW2tNXo=;
	h=Date:From:To:Cc:Subject:From;
	b=AwjER7OxQTN4kEGqX4G0D8NVb3CQu5oecegYAWJPwbtMJHlLm+jBnt//mv3+dEOpn
	 W2Rue0U8EcKxyrFUfuw3pqeta4+PcVj7O+K90bUuwMBqOUTaRfavGe4zigV+3mdP3H
	 ZebUw+TrTcntfmexRxDz5Rk4PsPqN+p6weYRYSTei27KIcR9VFi6mqBKQqE/vyPu3N
	 L6+oE6Vca/i4QW0G/HpH2wNKylHbnRtpOWUpTw/JulQPSIYsEo0pqvjza3/4IomHdj
	 ATCrV12lkXbKRWg7naII7wX21j5s3ycyP5iZAbxJP6LA53YHW5zsZl5+TTYkfhk/Z3
	 KmBNROPzxdP3w==
Date: Sun, 7 Jan 2024 22:27:56 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>
Subject: [GIT PULL] erofs updates for 6.8-rc1
Message-ID: <ZZq07DNl8EB/wlgK@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for 6.8-rc1?

In this cycle, we'd like to enable basic sub-page compressed data
support for Android ecosystem (for vendors to try out 16k page size
with 4k-block images in their compatibility mode) as well as container
images (so that 4k-block images can be parsed on arm64 cloud servers
using 64k page size.)

In addition, there are several bugfixes and cleanups as usual.  All
commits have been in -next for a while and no potential merge conflict
is observed.

Thanks,
Gao Xiang

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc1

for you to fetch changes up to 070aafcd2482dc31a12a3eda5d459c45496d6fb6:

  erofs: make erofs_{err,info}() support NULL sb parameter (2024-01-04 00:23:13 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add basic sub-page compressed data support;

 - Fix a memory leak on MicroLZMA and DEFLATE compression;

 - Fix a rare LZ4 inplace decompression issue on recent x86 CPUs;

 - Two syzbot fixes around crafted images;

 - Some cleanups.

----------------------------------------------------------------
Chunhai Guo (1):
      erofs: make erofs_{err,info}() support NULL sb parameter

Gao Xiang (10):
      erofs: fix memory leak on short-lived bounced pages
      erofs: fix lz4 inplace decompression
      erofs: support I/O submission for sub-page compressed blocks
      erofs: record `pclustersize` in bytes instead of pages
      erofs: fix up compacted indexes for block size < 4096
      erofs: fix ztailpacking for subpage compressed blocks
      erofs: refine z_erofs_transform_plain() for sub-page block support
      erofs: enable sub-page compressed block support
      erofs: fix inconsistent per-file compression format
      erofs: avoid debugging output for (de)compressed data

Yue Hu (1):
      erofs: allow partially filled compressed bvecs

 fs/erofs/decompressor.c         | 122 +++++++++---------
 fs/erofs/decompressor_deflate.c |   2 +-
 fs/erofs/inode.c                |   6 +-
 fs/erofs/super.c                |  10 +-
 fs/erofs/zdata.c                | 267 ++++++++++++++++++----------------------
 fs/erofs/zmap.c                 |  41 +++---
 6 files changed, 218 insertions(+), 230 deletions(-)

