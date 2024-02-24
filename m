Return-Path: <linux-kernel+bounces-79383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27721862171
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEB31F2421B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E884688;
	Sat, 24 Feb 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhgCWzkF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8D15A4;
	Sat, 24 Feb 2024 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736881; cv=none; b=T9JThtXyUxi7+JR2Q3GeNvxHxyiJ2mWyO8ShCfMORxiK+cx46VNQR+vVoD+7PgxYzi2biA0np2zNd12uazi9rjD4ZWC8o6sOuvuPy9WSSt48C9OPg5Ml4M+E2P09LU791zMdkdhWXxyne91kn711JEjdV1eetw9I9ZmghHxFdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736881; c=relaxed/simple;
	bh=Qq0rzLht/1C06Vd6Y3S4Q4V/WS1/vFpfOS+XSS40jbk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmNflHhj3i733ljc/X2QWuvVKBCsaBD7m9WKOSxutHQ9E9y3TK9l8GJmwbN2ttZILbRLnoPoyYTQIePW3KPaZ2vYpMLpXWXloz+2ILw7ltGe4IcbCyRu7Yol4bF1+hg6v9lkw6iGEggbJcvUzro6H6oTnxXXpbh6bw6TpjoHR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhgCWzkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE32C433F1;
	Sat, 24 Feb 2024 01:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708736880;
	bh=Qq0rzLht/1C06Vd6Y3S4Q4V/WS1/vFpfOS+XSS40jbk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KhgCWzkFJcIUPRDjBmPCrRDuwRuGBSBsD+UQWlYZpFxeKiwqHfXbXw1N8k15zUCSz
	 7iBcGoB50xS/0elgYehemUlw/ys0Ira0hKYuAWCIO5ES5qp77o80kwZmsGTyzFE0nB
	 +YnVVFsoXQfMnuTQkaUjazRboDpTusvDU9SvqJ3eJGErRXh9GA7fifpQ2tLqscUNmd
	 E1IQjobUul4tDMcnWlqFAGZeBQf4bysB9s0zPtoIl5Ixf+VjItoRZTqJtASp0xDj3I
	 zXxEvPduaT7qtzzOpQ5U3byMgMNj0PXFeQqYPsxtrZ0iMSsMF6Bd0i5ZKlUTCfxkw4
	 mF/GxuBaGpQEA==
Date: Fri, 23 Feb 2024 17:08:00 -0800
Subject: [PATCHSET 2/6] time_stats: cleanups and fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
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

This series reduces the memory consumption of individual time_stats
objects, and adds reporting of how long each stat counter has been
making observations.  It's a prep patch for adding some counters to XFS,
for which we'll want as low overhead as possible to maximimze
shotgunning effect.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=timestats-cleanups
---
Commits in this patchset:
 * time_stats: report lifetime of the stats object
 * time_stats: split stats-with-quantiles into a separate structure
 * time_stats: fix struct layout bloat
 * time_stats: add larger units
 * time_stats: don't print any output if event count is zero
 * time_stats: allow custom epoch names
 * mean_and_variance: put struct mean_and_variance_weighted on a diet
 * time_stats: shrink time_stat_buffer for better alignment
 * time_stats: report information in json format
 * time_stats: Kill TIME_STATS_HAVE_QUANTILES
---
 fs/bcachefs/bcachefs.h            |    2 -
 fs/bcachefs/io_write.c            |    2 -
 fs/bcachefs/super.c               |   10 +--
 fs/bcachefs/sysfs.c               |    4 +
 fs/bcachefs/util.c                |   15 ++--
 include/linux/mean_and_variance.h |   14 ++--
 include/linux/time_stats.h        |   43 ++++++++++-
 lib/math/mean_and_variance.c      |   28 +++++--
 lib/math/mean_and_variance_test.c |   80 +++++++++++---------
 lib/time_stats.c                  |  148 +++++++++++++++++++++++++++++++------
 10 files changed, 248 insertions(+), 98 deletions(-)


