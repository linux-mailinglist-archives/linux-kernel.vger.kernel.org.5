Return-Path: <linux-kernel+bounces-79385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B78862176
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1FF1F24BFE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6044A04;
	Sat, 24 Feb 2024 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqUmigWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9817CE;
	Sat, 24 Feb 2024 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736912; cv=none; b=RMlToZ+1NzgxLvgXPkUcTvN8nsrDoJJFQGaVXvlhDbWCRg1KcGk5adaa60xHw3jc+nSuv2FEh10GEDYsKcB9nU2efkZGG8RHFmL79DtLLnAsU96kNQ0vRYQsTeyl99zIEyq1/py3mqzT5dbd7DJ7rHnsCTh/gaZk7v3VI+tMdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736912; c=relaxed/simple;
	bh=xLRikPf95cPE/kEjcFnEjRs1dxskdSaLCIBqZpg91JM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iu2qCYF0N1avrnJSvpMYltyaiKY+qbvOOERHC1hObJ7SelWPEe19md+FY7xmkbtnidE89v3MKCQcy9KNZG7z4RuvJCSGgVRZ08EjBO8npArcA6qODUj9szJVVewuUYu3wt4yRdS/N6kBkwM868sukd5DaqGaxyV1yg4uPKWOqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqUmigWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F34AC433F1;
	Sat, 24 Feb 2024 01:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708736912;
	bh=xLRikPf95cPE/kEjcFnEjRs1dxskdSaLCIBqZpg91JM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UqUmigWNe53lKylBZj42NMPluYHZqlmifwkVOGQgTDvbWS2wRNP//TPNWI1SENupQ
	 ZEDeGACDed/2lpEOStEu9WoxUt4srjJM6JD1hUckYE7c7njPmkXosSzWUDZRFmBCey
	 6YhaqUKvV9NZ6KWd6/PyMoZAK0I/yqwrhkeUe1p3XWi0O01rSQcDBhmtMwAiK1jjyc
	 TdUsv5cse7NXqnT2MsKP/1MvQuHW3mxr5RwUxYrbL+MgoZwgfLy/6T1Zw20v84TAY3
	 dY5sDexSCfBSM5Zds5QGheo5bN1yzJFzz8xgbX5ueERqTphErKPz1NYiNhplXs4WDV
	 FAY4leUfiP//w==
Date: Fri, 23 Feb 2024 17:08:31 -0800
Subject: [PATCHSET 4/6] thread_with_file: promote to lib/
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: fuyuanli <fuyuanli@didiglobal.com>, linux-xfs@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
In-Reply-To: <20240224010017.GM6226@frogsfrogsfrogs>
References: <20240224010017.GM6226@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is Kent Overstreet's series to lift the thread_with_file support
code to generic library code.  This enables the kernel to create a
pseudo file that userspace can use to read deeply structured event
information from the kernel.  kthreads are used to manage the buffers
underlying the file operations.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=twf-hoist
---
Commits in this patchset:
 * bcachefs: thread_with_stdio: eliminate double buffering
 * bcachefs: thread_with_stdio: convert to darray
 * bcachefs: thread_with_stdio: kill thread_with_stdio_done()
 * bcachefs: thread_with_stdio: fix bch2_stdio_redirect_readline()
 * bcachefs: Thread with file documentation
 * darray: lift from bcachefs
 * thread_with_file: Lift from bcachefs
 * thread_with_stdio: Mark completed in ->release()
 * kernel/hung_task.c: export sysctl_hung_task_timeout_secs
 * thread_with_stdio: suppress hung task warning
---
 MAINTAINERS                            |   16 +
 fs/bcachefs/Kconfig                    |    1 
 fs/bcachefs/Makefile                   |    2 
 fs/bcachefs/bcachefs.h                 |    2 
 fs/bcachefs/btree_types.h              |    2 
 fs/bcachefs/btree_update.c             |    2 
 fs/bcachefs/btree_write_buffer_types.h |    2 
 fs/bcachefs/chardev.c                  |   24 +-
 fs/bcachefs/error.c                    |    4 
 fs/bcachefs/fsck.c                     |    2 
 fs/bcachefs/journal_sb.c               |    2 
 fs/bcachefs/sb-downgrade.c             |    3 
 fs/bcachefs/sb-errors_types.h          |    2 
 fs/bcachefs/sb-members.h               |    2 
 fs/bcachefs/subvolume.h                |    1 
 fs/bcachefs/subvolume_types.h          |    2 
 fs/bcachefs/super.c                    |    9 -
 fs/bcachefs/thread_with_file.c         |  299 -------------------------
 fs/bcachefs/thread_with_file.h         |   41 ---
 fs/bcachefs/thread_with_file_types.h   |   16 -
 fs/bcachefs/util.h                     |   29 --
 include/linux/darray.h                 |   59 +++--
 include/linux/darray_types.h           |   22 ++
 include/linux/thread_with_file.h       |   71 ++++++
 include/linux/thread_with_file_types.h |   25 ++
 kernel/hung_task.c                     |    1 
 lib/Kconfig                            |    3 
 lib/Makefile                           |    3 
 lib/darray.c                           |   12 +
 lib/thread_with_file.c                 |  379 ++++++++++++++++++++++++++++++++
 30 files changed, 596 insertions(+), 442 deletions(-)
 delete mode 100644 fs/bcachefs/thread_with_file.c
 delete mode 100644 fs/bcachefs/thread_with_file.h
 delete mode 100644 fs/bcachefs/thread_with_file_types.h
 rename fs/bcachefs/darray.h => include/linux/darray.h (66%)
 create mode 100644 include/linux/darray_types.h
 create mode 100644 include/linux/thread_with_file.h
 create mode 100644 include/linux/thread_with_file_types.h
 rename fs/bcachefs/darray.c => lib/darray.c (56%)
 create mode 100644 lib/thread_with_file.c


