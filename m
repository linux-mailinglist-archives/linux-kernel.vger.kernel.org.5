Return-Path: <linux-kernel+bounces-160497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF408B3E42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4B8287162
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5F916F26F;
	Fri, 26 Apr 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Vf88SdYh"
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCF16D4FC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152654; cv=none; b=uj0ABZLJg3FQzJt366BD5FnO1/uvqj23d81fMNW4NqyIcy+4EwqO2/ubx3KC7EWHFNVDnOvNs4G5Xppamsy0XffLSBUt1qtROAdMMdTSxmIE5rpLr2TOidDxavb9okDIrjNYwIedW3v5FNPCRt2zJMTn3OlDLMJ4vsfPtlX/6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152654; c=relaxed/simple;
	bh=T+qvLdz7Xc/vYbDxHCVT4t2BwTarjFMD5whDaioo+Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=upQuVNQg29mPh5fZj8cREWFhcMfKc6cnLUfsfXufhUzHcXjdrHbMirAfmObWw7S0Vpr2un/V5J+/LM3QQcN8P3oJ2TclAHGnXK4WyXE/pF0ZgEZ1dfTr4CghtaMhCDymJZ25YjBaYoGw7DUGjR98+qMGblg/25ue1j2x4mxTzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Vf88SdYh; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VR0134W2qz608;
	Fri, 26 Apr 2024 19:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714152183;
	bh=T+qvLdz7Xc/vYbDxHCVT4t2BwTarjFMD5whDaioo+Ag=;
	h=From:To:Cc:Subject:Date:From;
	b=Vf88SdYh/JXH5+V/CTkZpwdDnkYOazQwN+FUx+yqpnFbz1L9U1szO/Z/W+iy5pkLH
	 vuAVA2zYaVjnwP7KQwLohhcg4hzoAPFgtDm+wOP7oUmDHlnbBqQ++R851l/qXIC9u+
	 qwX8ryBkCT/DeIhjUdOC6/FD++V8/a4KOO8q1ugI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VR0120m93zcqq;
	Fri, 26 Apr 2024 19:23:02 +0200 (CEST)
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
Subject: [PATCH v1 0/5] Fix Kselftest's vfork() side effects
Date: Fri, 26 Apr 2024 19:22:47 +0200
Message-ID: <20240426172252.1862930-1-mic@digikod.net>
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

Regards,

Mickaël Salaün (5):
  selftests/pidfd: Fix config for pidfd_setns_test
  selftests/landlock: Fix FS tests when run on a private mount point
  selftests/harness: Fix fixture teardown
  selftests/harness: Fix interleaved scheduling leading to race
    conditions
  selftests/harness: Fix vfork() side effects and uncaught errors

 tools/testing/selftests/kselftest_harness.h   | 113 +++++++++++++-----
 tools/testing/selftests/landlock/fs_test.c    |  83 ++++++++-----
 tools/testing/selftests/pidfd/config          |   2 +
 .../selftests/pidfd/pidfd_setns_test.c        |   2 +-
 4 files changed, 135 insertions(+), 65 deletions(-)


base-commit: c942a0cd3603e34dd2d7237e064d9318cb7f9654
-- 
2.44.0


