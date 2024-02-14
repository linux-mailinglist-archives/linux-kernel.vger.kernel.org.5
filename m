Return-Path: <linux-kernel+bounces-65580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C30854EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F0EB30F72
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EC60272;
	Wed, 14 Feb 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="j4s6hQsP"
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678371E4BA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929101; cv=none; b=B9u13K2D1E2pzUrysatuzna8Q2pBHK7zJab6BIugQUjEbWR+Eg6ORTc1tz3I1GPwbfjC30zNNv4DCqV1sgrdppnF5cY98V23u1MaILwyvpzu8pj08snN6ixSq4Q6FrMVu8h5Uftd/pM0X4y69jJni/oOZf3Z+TpzD2OK4sI+laI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929101; c=relaxed/simple;
	bh=xpXeVFpeRc9fFmYw+RR4mMkZhaMRqoZpjfRtqMsipqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVFsm7cdiD0wO3M7w9zA4XLsznv2JsEBpAjYlzaAzZUeBoW72jrU3xuDwZ6C9uLmrvAvKELEstilWFtgcTR4FPZHQWRoB1S3JaqgVY504Lg+76IYLHVPt/0u8au6XxFDnObaqJbAVfktOapYAbaRRS4OpEx2E86cbmQwAmLopLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=j4s6hQsP; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TZgMx0vFTzX2h;
	Wed, 14 Feb 2024 15:20:45 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TZgMw0dPcz4nH;
	Wed, 14 Feb 2024 15:20:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1707920445;
	bh=xpXeVFpeRc9fFmYw+RR4mMkZhaMRqoZpjfRtqMsipqs=;
	h=From:To:Cc:Subject:Date:From;
	b=j4s6hQsPAW5igZA4nNKz7CPtW7Kw09VvgfZ6JrixWP01oVuVoXdPnNO/VN4QN884y
	 2WXWy8weM3/LGzcqDatCUgF5AiVxZKz6L+u83l0Veu6fu+G51Z+P+xTq7x1c33o7pK
	 0uvs/u264nEz2f054QuwwQ4jVo+2R2Txd1S0bhk8=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Hu Yadi <hu.yadi@h3c.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fixes for v6.8-rc5
Date: Wed, 14 Feb 2024 15:20:26 +0100
Message-ID: <20240214142026.2401046-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR fixes build issues for tests, and improve test compatibility.

Please pull these changes for v6.8-rc5.  These 3 commits merged cleanly with
your master branch.  The kernel code has been tested in the latest linux-next
releases for a few weeks.

Regards,
 Mickaël

--
The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc5

for you to fetch changes up to bb6f4dbe2639d5b8a9fde4bfb6fefecfd3f18df3:

  selftests/landlock: Fix capability for net_test (2024-02-02 10:32:09 +0100)

----------------------------------------------------------------
Landlock fixes for v6.8-rc5

----------------------------------------------------------------
Hu Yadi (2):
      selftests/landlock: Fix net_test build with old libc
      selftests/landlock: Fix fs_test build with old libc

Mickaël Salaün (1):
      selftests/landlock: Fix capability for net_test

 tools/testing/selftests/landlock/common.h   | 48 ++++++++++++++++++++++++-----
 tools/testing/selftests/landlock/fs_test.c  | 11 +++++--
 tools/testing/selftests/landlock/net_test.c | 13 ++++++--
 3 files changed, 59 insertions(+), 13 deletions(-)

