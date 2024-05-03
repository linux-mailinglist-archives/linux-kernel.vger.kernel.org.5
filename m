Return-Path: <linux-kernel+bounces-167548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C208BAB25
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895301C2221E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC6E152519;
	Fri,  3 May 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ViuqFlyT"
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304861514D5;
	Fri,  3 May 2024 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733916; cv=none; b=krDegRzwg+QW4Whx+ezg4DBu5evzGB8UgRA7itg3BBMqGDe3i0LkJ0w+jweLSGhSdVwDd4sHEmrgefIuyNc7OTbMl1JhUMHNToQIdGwGI8GKLqsXYlMJ46+F1/3hWj4gyqyI9DKEQXT7lDN/aJEgdg2VeOnkK4wXxwj8BRjSACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733916; c=relaxed/simple;
	bh=fdS7g9OZWSVyYiFzvx5Vjx/iMPNyksye/pOut54QdLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gnw2guh2CRxLH7cB9tVyb7XJbe+x0tW6S2nZ3xiXVYVMYJ3z48oXIqaK7OSJlehq01XgV2mtN044f7oZ50Faom7MlhEhOzKIDdDUmzMoBNJzu8klL9M9NoLN/budAcIILxfu3ypUJmxTIxtkDTyJxjKQXn/qu68VIjZsi1oVlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ViuqFlyT; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VW7870Cg8z3j0;
	Fri,  3 May 2024 12:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714733910;
	bh=fdS7g9OZWSVyYiFzvx5Vjx/iMPNyksye/pOut54QdLw=;
	h=From:To:Cc:Subject:Date:From;
	b=ViuqFlyT6F0/nXHVXXY4zPieTYIyYqudSQ5VPCUi1FOX7dhb3F8Wz0ckvP+mX6QjE
	 boQ4yyv1n/KEau6gcg7J1BjEJR/Jm+ariUYom6vNO+T1gIXSxE4T8AnBAxi+vslLZI
	 xqIh+ae8jpIikO37aptyiLwq2XU/AFzn+Ht8LIJs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VW7860V4rzYJW;
	Fri,  3 May 2024 12:58:30 +0200 (CEST)
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
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 00/10] Fix Kselftest's vfork() side effects
Date: Fri,  3 May 2024 12:58:10 +0200
Message-ID: <20240503105820.300927-1-mic@digikod.net>
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

This fifth series fixes _metadata reset and fixes the last patch to
handle code set with direct calls to _exit().

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
fork/clone/clone3, and KVM_ONE_VCPU_TEST) with this series:
- kvm:fix_hypercall_test
- kvm:sync_regs_test
- kvm:userspace_msr_exit_test
- kvm:vmx_pmu_caps_test
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
v4: https://lore.kernel.org/r/20240502210926.145539-1-mic@digikod.net

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
  selftests/harness: Handle TEST_F()'s explicit exit codes

 tools/testing/selftests/kselftest_harness.h   | 122 +++++++++++++-----
 tools/testing/selftests/landlock/fs_test.c    |  83 +++++++-----
 tools/testing/selftests/pidfd/config          |   2 +
 .../selftests/pidfd/pidfd_setns_test.c        |   2 +-
 4 files changed, 143 insertions(+), 66 deletions(-)


base-commit: e67572cd2204894179d89bd7b984072f19313b03
-- 
2.45.0


