Return-Path: <linux-kernel+bounces-166913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8FA8BA1D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFCD2838D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207118132E;
	Thu,  2 May 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YmtamxYc"
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89D1635DB
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684180; cv=none; b=NkEpuGyaHc+C5dPzw4GlKZ3gBksuTJj3jmOF1aKbJL5adJQ4rEksTHyzTq643O+iaj/XYq8MNp9ZI6FS2dshO6KlFaOAFSCm5A/net/bbgK2Y/v4CCQCmAqlUcI4gMcOFoq+OpBPJYFgVf5GVpLCiAtHWx6bUyi1RrS2T3gedRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684180; c=relaxed/simple;
	bh=xg2yiemt7g0L//ersE+e1X8N3O4VM6PY1gF/lS4OZEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMsANHZU44yETBrJ1KS+yBi9DUVdRlEdN/gkp3BLiRr4I+v/8WTBW7RzneunsvfZnQBOwZ1rEfUh7ubZCHIWCKYy3nNehnHu11wyZSUZE7yVRZHynMzMeyP76GhiyckB9LAcO1wU97BMIhOUc9ugVhEBt+SpnZreubep36Cq+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YmtamxYc; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VVmlZ597czMTy;
	Thu,  2 May 2024 23:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714684170;
	bh=xg2yiemt7g0L//ersE+e1X8N3O4VM6PY1gF/lS4OZEc=;
	h=From:To:Cc:Subject:Date:From;
	b=YmtamxYcpWPtf1+c+J3FBMhnK2mbzUuwYj9TsAJeD1nMJcyiVVySKdGXEuU2boBpb
	 es/PYh3z83nFhb0o0L01pxiH3bZ6KtHtlrW9vNGjZUUH06vqEwKVu+SRTUDsqQmTgs
	 IndezI+4cCtQhql+ZEBEa3lVxijK90cuVA81rmfI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VVmlY6dYvzVY0;
	Thu,  2 May 2024 23:09:29 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 00/10] Fix Kselftest's vfork() side effects
Date: Thu,  2 May 2024 23:09:16 +0200
Message-ID: <20240502210926.145539-1-mic@digikod.net>
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

This fourth series add a patch from Sean Christopherson that fixes KVM
tests.

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

Previous versions:
v1: https://lore.kernel.org/r/20240426172252.1862930-1-mic@digikod.net
v2: https://lore.kernel.org/r/20240429130931.2394118-1-mic@digikod.net
v3: https://lore.kernel.org/r/20240429191911.2552580-1-mic@digikod.net

Regards,

Mickaël Salaün (10):
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
  selftests/harness: Fix TEST_F()'s exit codes

 tools/testing/selftests/kselftest_harness.h   | 123 +++++++++++++-----
 tools/testing/selftests/landlock/fs_test.c    |  83 +++++++-----
 tools/testing/selftests/pidfd/config          |   2 +
 .../selftests/pidfd/pidfd_setns_test.c        |   2 +-
 4 files changed, 141 insertions(+), 69 deletions(-)


base-commit: e67572cd2204894179d89bd7b984072f19313b03
-- 
2.45.0


