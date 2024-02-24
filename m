Return-Path: <linux-kernel+bounces-79382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F8486216F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91B1B22D86
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6374416;
	Sat, 24 Feb 2024 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQGKCpn5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42E15A4;
	Sat, 24 Feb 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736865; cv=none; b=C6sMwRdqAOlP4UhKfguiEMEGbfKXrcd+ka3cfBSMBs3l9zyBhqMThuqvKzjkbrNF4jTK+MalrZHkBo9sJrvaOEUzxQBji4BA2bBv40pzCVyjfd4MYxx1wkBonFlEE59pyw/1MQSoGSLjPc57ekQa2voFVW5whhxLDYujsi95p9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736865; c=relaxed/simple;
	bh=WoZFoJDWEXQaGSjeUf5+KJsz6UfuL++KLHOFzZuC9OE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBz1ipx7d1DjqfZ7sXs9ypCRibc6kZMGjlLCzUw6EW+71kjC5Mcmy22ALGRGu60FLCcG8bP57o9gtx+YbrhAld9byDZHuy5RF9RdgrDSlxE2bAEGk5RkILhjO+2sR8rOA/w656jt8XVOraj3NJNAwkA4kO0bLZeFMQVmPGpNHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQGKCpn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A12C433C7;
	Sat, 24 Feb 2024 01:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708736865;
	bh=WoZFoJDWEXQaGSjeUf5+KJsz6UfuL++KLHOFzZuC9OE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PQGKCpn5EWJSf0I2nMRHHok36LaJQBXJdsAkO2Vz/4gXBwPYDex5wJVIM3rttRBfp
	 w9jhMkdsJVRRTH73itm0iSgxrohA3MoSy64qWV0BycFoMRMmsCjvtF620tJfWlRYP1
	 MWpE/ZOQU9O26uVN+d6K2JZdLhSX/qSgJI0z2rUtKimqfDWKUvqpwQRha4PKL0IPwN
	 wawskSC4fY/rEH2ePMFcv/CtFwTdjRjY7tRXNGKW7YYKAoN4BDlUEG9nSgEFauNPFs
	 zFTQkBMRT5HpTXdrIgKOqXhhGdUmqnUhDso9UWrk/KQCgFU6OS866SWUI5tl2lZ2k/
	 syzI1iU/2fwrQ==
Date: Fri, 23 Feb 2024 17:07:44 -0800
Subject: [PATCHSET 1/6] time_stats: promote to lib/
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
 Coly Li <colyli@suse.de>, linux-xfs@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <170873667479.1860799.16660964083961996807.stgit@frogsfrogsfrogs>
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

This is Kent Overstreet's series to lift the mean and variance
computation code, as well as the time statistics code, to become
generic library code.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=timestats-hoist
---
Commits in this patchset:
 * mean and variance: Promote to lib/math
 * eytzinger: Promote to include/linux/
 * bcachefs: bch2_time_stats_to_seq_buf()
 * time_stats: Promote to lib/
---
 MAINTAINERS                          |   22 ++
 fs/bcachefs/Kconfig                  |   10 -
 fs/bcachefs/Makefile                 |    3 
 fs/bcachefs/alloc_foreground.c       |   13 -
 fs/bcachefs/bcachefs.h               |   11 +
 fs/bcachefs/bset.c                   |    2 
 fs/bcachefs/btree_cache.c            |    2 
 fs/bcachefs/btree_gc.c               |    2 
 fs/bcachefs/btree_io.c               |    8 -
 fs/bcachefs/btree_iter.c             |    8 -
 fs/bcachefs/btree_locking.h          |    2 
 fs/bcachefs/btree_update_interior.c  |    8 -
 fs/bcachefs/io_read.c                |    4 
 fs/bcachefs/io_write.c               |    4 
 fs/bcachefs/journal.c                |    5 -
 fs/bcachefs/journal_io.c             |    9 -
 fs/bcachefs/journal_reclaim.c        |    9 -
 fs/bcachefs/journal_seq_blacklist.c  |    6 -
 fs/bcachefs/journal_types.h          |   11 -
 fs/bcachefs/nocow_locking.c          |    2 
 fs/bcachefs/replicas.c               |   19 +-
 fs/bcachefs/replicas.h               |    3 
 fs/bcachefs/super-io.h               |    2 
 fs/bcachefs/super.c                  |   14 +
 fs/bcachefs/util.c                   |  339 ++--------------------------------
 fs/bcachefs/util.h                   |   86 ---------
 include/linux/eytzinger.h            |   58 +++---
 include/linux/mean_and_variance.h    |    0 
 include/linux/time_stats.h           |  134 +++++++++++++
 lib/Kconfig                          |    4 
 lib/Kconfig.debug                    |    9 +
 lib/Makefile                         |    2 
 lib/math/Kconfig                     |    3 
 lib/math/Makefile                    |    2 
 lib/math/mean_and_variance.c         |    3 
 lib/math/mean_and_variance_test.c    |    3 
 lib/sort.c                           |   89 +++++++++
 lib/time_stats.c                     |  271 +++++++++++++++++++++++++++
 38 files changed, 662 insertions(+), 520 deletions(-)
 rename fs/bcachefs/eytzinger.h => include/linux/eytzinger.h (77%)
 rename fs/bcachefs/mean_and_variance.h => include/linux/mean_and_variance.h (100%)
 create mode 100644 include/linux/time_stats.h
 rename fs/bcachefs/mean_and_variance.c => lib/math/mean_and_variance.c (99%)
 rename fs/bcachefs/mean_and_variance_test.c => lib/math/mean_and_variance_test.c (99%)
 create mode 100644 lib/time_stats.c


