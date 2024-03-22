Return-Path: <linux-kernel+bounces-110812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2688643E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F2CB221A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375138B;
	Fri, 22 Mar 2024 00:09:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3F19A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066158; cv=none; b=K63gg8VarYTQL0l2e+kOaw8fpu/NWxvGbgzTeCRywj/myU6qFexcHtbHnqF3+u0EXiIKEEuWV1/EuAb7J6Wd5qBt0AYPRGO7hPi2OagBDSpnLyEAEnimP3xnwKJ98erXUE+T+n8EEQIV2aZdcP9oesmnaoch6RrsM5h7a6385QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066158; c=relaxed/simple;
	bh=5yDtrZnPxvihvRPCSxRlEksfo+ug4u8be/i/Zsu57Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y74qzaGfrlBKhv+Yr0drYTQG+xzIsUuJ/XhhDxA4DJeXEafIjh9Bvu9km2I3vX+GGXUCDMTfLw8Cl+KITZBhuhDlXZgbKhYPfbkm9HDn0R8xt3Jn+GHLVhR9A4bvl6lHw4LD44lymyxuWQgvjZuj48HZd35sswVyNGvSjT0uKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBAFC43390;
	Fri, 22 Mar 2024 00:09:16 +0000 (UTC)
Date: Fri, 22 Mar 2024 00:09:14 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.9-rc1
Message-ID: <ZfzMKqtxAfHwHY3p@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 update and perf fix below. Thanks.

The following changes since commit 1ef21fcd6a50f011680dbbd678c1bea8e3f67ab9:

  Revert "mm: add arch hook to validate mmap() prot flags" (2024-03-13 10:59:38 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 1d63d1d9e5c5cb2e7c7ca75751a5eaf67c5623a7:

  perf: starfive: fix 64-bit only COMPILE_TEST condition (2024-03-19 19:01:39 +0000)

----------------------------------------------------------------
arm64 fix/update:

- Re-instate the CPUMASK_OFFSTACK option for arm64 when NR_CPUS > 256.
  The bug that led to the initial revert was the cpufreq-dt code not
  using zalloc_cpumask_var().

- Make the STARFIVE_STARLINK_PMU config option depend on 64BIT to
  prevent compile-test failures on 32-bit architectures due to missing
  writeq().

----------------------------------------------------------------
Christoph Lameter (Ampere) (1):
      ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512

Conor Dooley (1):
      perf: starfive: fix 64-bit only COMPILE_TEST condition

 arch/arm64/Kconfig   | 3 ++-
 drivers/perf/Kconfig | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
Catalin

