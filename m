Return-Path: <linux-kernel+bounces-31338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB99832CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5055F28879B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331D54BF3;
	Fri, 19 Jan 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqAGzaJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750452F61
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680334; cv=none; b=Ga4JTfFsVeIQz+UPd9uCKQI59s/Nod8gAb47cpdJLZ/UFlQ7p1wzcWJnu6+l1oW/N6jVszO4hbI7LYSoipM2GZS7qhT/dfc+VAPS+FF9jSI88pKXxe5Ie5a1APOqfpQeJ0q8oo9+l+nbEeg/hrZ6idQ/5gIAF4D8kxB9S6HvcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680334; c=relaxed/simple;
	bh=0vsHCEB7uarmRqxKL7SMqn2/4sulPPxduy3Gu7w9gBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=POftR1ycKvNrLqHFes7cGydZPMbmavCU54bLbSO+LVGWRh6E44sqpN7bqZ7PhEu+pEjVyOBezA6rcbS3F3+VyBKlHA5PM4qDT3hifnukFN/DE3mJRgPBSX6xViF44cFKPcnL9suqjEf41/AfgF/9sJm/gcSy2Qq8HpafwrbFNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqAGzaJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80513C433F1;
	Fri, 19 Jan 2024 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705680333;
	bh=0vsHCEB7uarmRqxKL7SMqn2/4sulPPxduy3Gu7w9gBY=;
	h=Date:From:To:Cc:Subject:From;
	b=cqAGzaJDT85GFYQboa5RY7etRf5pZD3PUJvf670EaTTN6cL+Rl/tgkEIjqB5U//Lt
	 5Xnf7HcZ9nowHWIfmwbnoqb/5hZ5iGCBUYUtcRtoi/1XZQFbqU5HKOytORJgvEwZZk
	 HJmb4PNAq9QRgm6dQJ2ioPFc1qladJCzSUYr65zmeJdSTB9xKjqTZ41nPp/zpS8VBZ
	 tFLQRv/V5ePy0r2qFLi5l/37Ub2J1CSfD32OqWM4wfJSksYy07MvN82ua2zBiPxNB/
	 z6+jPfpKGH2CcFb/YInEyPp07iY1YdZt1W3/vtt5m6qQ+lI5+4XBSs2B7KZVUnVXMU
	 xYjS+RtRWU9gw==
Date: Fri, 19 Jan 2024 16:05:28 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20240119160528.GA5336@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull these arm64 fixes for -rc1. I think the main one is fixing
the dynamic SCS patching when full LTO is enabled (clang was silently
getting this horribly wrong), but it's all good stuff. Rob just pointed
out that the fix to the workaround for erratum #2966298 might not be
necessary, but in the worst case it's harmless and since the official
description leaves a little to be desired here, I've left it in.

Cheers,

Will

--->8

The following changes since commit db32cf8e280b46726065c518e90761bb0229bacf:

  Merge branch 'for-next/fixes' into for-next/core (2024-01-04 12:32:33 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 1b20d0486a602417defb5bf33320d31b2a7a47f8:

  arm64: Fix silcon-errata.rst formatting (2024-01-18 11:15:43 +0000)

----------------------------------------------------------------
arm64 fixes for -rc1

- Fix shadow call stack patching with LTO=full

- Fix voluntary preemption of the FPSIMD registers from assembly code

- Fix workaround for A520 CPU erratum #2966298 and extend to A510

- Fix SME issues that resulted in corruption of the register state

- Minor fixes (missing includes, formatting)

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: scs: Work around full LTO issue with dynamic SCS
      arm64: fpsimd: Bring cond_yield asm macro in line with new rules

Mark Brown (3):
      arm64/ptrace: Don't flush ZA/ZT storage when writing ZA via ptrace
      arm64/fpsimd: Remove spurious check for SVE support
      arm64/sme: Always exit sme_alloc() early with existing storage

Mark Rutland (2):
      arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
      arm64: entry: simplify kernel_exit logic

Rob Herring (2):
      arm64: Rename ARM64_WORKAROUND_2966298
      arm64: errata: Add Cortex-A510 speculative unprivileged load workaround

Robin Murphy (1):
      arm64: Fix silcon-errata.rst formatting

Tudor Ambarus (1):
      arm64: irq: include <linux/cpumask.h>

 Documentation/arch/arm64/silicon-errata.rst |  4 ++--
 arch/arm64/Kconfig                          | 18 ++++++++++++++++++
 arch/arm64/include/asm/assembler.h          | 25 +++++++++----------------
 arch/arm64/include/asm/irq.h                |  2 ++
 arch/arm64/kernel/Makefile                  |  8 +++++++-
 arch/arm64/kernel/asm-offsets.c             |  2 --
 arch/arm64/kernel/cpu_errata.c              | 21 +++++++++++++++++----
 arch/arm64/kernel/entry.S                   | 25 ++++++++++++++-----------
 arch/arm64/kernel/fpsimd.c                  | 12 ++++++------
 arch/arm64/kernel/ptrace.c                  | 13 +++++++------
 arch/arm64/tools/cpucaps                    |  2 +-
 11 files changed, 83 insertions(+), 49 deletions(-)

