Return-Path: <linux-kernel+bounces-162347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7CD8B59A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7038A28583A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7486D54908;
	Mon, 29 Apr 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vd/U/wPA"
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC853E08
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396548; cv=none; b=YyZJXspcV2H/qMRnXT9+vFf5ZacRLcC9doPBLTV29dWAirutsEOh7KFhpmyk2ZbeLeAvEKeX3IZiL1FPr7GXJ494sGgg7GKEzO7KtJ0Rk3K/FjCXtsaYlXz+00WDfZId2peNSVp42OG8n8Z2UGIXz4n7NuegH7/LhklwqI3uwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396548; c=relaxed/simple;
	bh=+mGGfv+rNyQbPZbgK4ev9Hsh3jIoZFvo3k1FnAnnDJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KI0zzRyG1YvJhGpnKrW4lzuwFf36j1cB5dcyrryDicVLQ6GPS3xf0xgGJ0EMQzM4e/mzZbin2MAQ8i4Py5tyLkl7FX/8nzZMNoMTq5bwACp0uMNtBL9Ygnq2SMb48IOTkuBTRfuLUawR7YnYaMh/ckz6MtP9ahYDQtWUTOO+HkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vd/U/wPA; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSkFF53VWzLTD;
	Mon, 29 Apr 2024 15:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714396177;
	bh=+mGGfv+rNyQbPZbgK4ev9Hsh3jIoZFvo3k1FnAnnDJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=vd/U/wPAQJbV8RNav7swjB+xojeIfqXA8MfCiEX9qgLcgqFEfB0gogoIoMLGFtrOt
	 ezZVXEpQ4Js1Ktt1iU0YGGT6TknNJTv7TD8qJMp4wuqDmLnqrKdhYInwrWK49L9Ygb
	 TPwxWGPpcnCFN5AIsVusx2TKST1TyEkFvI+xBYOo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSkFD3SZczdD1;
	Mon, 29 Apr 2024 15:09:36 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/5] Fix Kselftest's vfork() side effects
Date: Mon, 29 Apr 2024 15:09:22 +0200
Message-ID: <20240429130931.2394118-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

As reported by Kernel Test Robot [1], some pidfd tests fail.  This is
due to the use of vfork() which introduced some side effects.
Similarly, while making it more generic, a previous commit made some
Landlock file system tests flaky, and subject to the host's file system
mount configuration.

This series fixes all these side effects by replacing vfork() with
clone3() and CLONE_VFORK, which is cleaner (no arbitrary shared memory)
and makes the Kselftest framework more robust.

I tried different approaches and I found this one to be the cleaner and
less invasive for current test cases.

This second series split the latest patch into 5 patches.

I successfully ran the following tests (using TEST_F and
fork/clone/clone3) with this series:
- landlock:fs_test
- landlock:net_test
- landlock:ptrace_test
- move_mount_set_group:move_mount_set_group_test
- net/af_unix:scm_pidfd
- perf_events:remove_on_exec
- pidfd:pidfd_getfd_test
- pidfd:pidfd_setns_test
- seccomp:seccomp_bpf
- user_events:abi_test

[1] https://lore.kernel.org/oe-lkp/202403291015.1fcfa957-oliver.sang@intel.com

Previous version:
v1: https://lore.kernel.org/r/20240426172252.1862930-1-mic@digikod.net

Regards,

Mickaël Salaün (9):
  selftests/pidfd: Fix config for pidfd_setns_test
  selftests/landlock: Fix FS tests when run on a private mount point
  selftests/harness: Fix fixture teardown
  selftests/harness: Fix interleaved scheduling leading to race
    conditions
  selftests/landlock: Do not allocate memory in fixture data
  selftests/harness: Constify fixture variants
  selftests/pidfd: Fix wrong expectation
  selftests/harness: Share _metadata between forked processes
  selftests/harness: Fix vfork() side effects

 tools/testing/selftests/kselftest_harness.h   | 113 +++++++++++++-----
 tools/testing/selftests/landlock/fs_test.c    |  83 ++++++++-----
 tools/testing/selftests/pidfd/config          |   2 +
 .../selftests/pidfd/pidfd_setns_test.c        |   2 +-
 4 files changed, 135 insertions(+), 65 deletions(-)


base-commit: e67572cd2204894179d89bd7b984072f19313b03
-- 
2.44.0


