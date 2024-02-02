Return-Path: <linux-kernel+bounces-49734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EAD846EB5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A545B1C21FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483F13BEA7;
	Fri,  2 Feb 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtnIzsER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB77995B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872273; cv=none; b=cKeDJJycYQ0jdjx5A/DJ3NcJNI8siaFGEaUWuPrvlBIY+HhIapH7pgCAGInnVMotDKtYZVnvtCaRSBZV/XvtiIuEcFjikIU0XnDsjBdc73SxvhIcZzFJYEY/yj31A8YGLp1dXq2KvsJQFF0LN/jvRtwqxRZpYfLrH7Xjp0wmMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872273; c=relaxed/simple;
	bh=BWnnoJzAz/cnuBdAWCRAWciB7rQLgAwAsk/VcL56AJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rl8WCoePVIdNBt1LvwFYp5eHTstCdtT/QU3m7grefLNBCEYJX293DK9oR2/2yJrW1EterLSA6kBY6iOyFnbpC18ChaE6vXSiVdHvkhuqbU+gij/B/dDMJxifTtA0L79gIpka1SOB5hOsLTaAwpjCWoP0AQzpiWj8dsTJOujrwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtnIzsER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AECC433C7;
	Fri,  2 Feb 2024 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706872273;
	bh=BWnnoJzAz/cnuBdAWCRAWciB7rQLgAwAsk/VcL56AJ4=;
	h=Date:From:To:Cc:Subject:From;
	b=ZtnIzsERZa+Nn4qmf3quaBvAzEiNXRWuPyD2jVJgAGt/PgxL2Rhi8jYQ/eL1qoH6/
	 /CcVZ3PlgpUAoFLMj+UUmAzJLrxlblRbDA2wIVlnqtT6R+jbrDKYPGTwZa3xno38cu
	 LxE7eK1A06RCrWjkQgzO24538jOo14EGOzvrBQ5116uAaJAm+6Yp8/tBXtvOn7UHCp
	 HUaTEjdVPhz8Gd5oDgHjJGTtdTnWep+aWJHjA2v50YgHLYRlMX2sBo/qQcTPFvgqcI
	 B9yqIdCbd0NUtG7eLko81O0dLFxrUeGsqu39HRe9RVMhILTvOTHF909uuvy3Z2+KMp
	 W50H7AJ0qVPuQ==
Date: Fri, 2 Feb 2024 11:11:08 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20240202111107.GA16598@willie-the-truck>
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

Please pull these two small fixes for -rc3. The first one is an
alternative fix for the SCS patching problem we thought we'd fixed in
-rc1; it turned out not to be robust with all toolchains/configs, so
this is a revert+retry which has seen some more testing.

The other one simply removes an unused header file, but I couldn't
resist the negative diffstat.

There's a crop of fpsimd/SVE/SME fixes pending which I'll probably send
next week once they've been reviewed.

Cheers,

Will

--->8

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to c7767f5c43df2c453af4651d1f58f489e3eb4ac1:

  arm64: vdso32: Remove unused vdso32-offsets.h (2024-01-30 11:59:17 +0000)

----------------------------------------------------------------
arm64 fixes for -rc3

- Really fix shadow call stack patching with LTO=full

- Remove unused (empty) header file generated from the compat vDSO

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: Revert "scs: Work around full LTO issue with dynamic SCS"
      arm64: scs: Disable LTO for SCS patching code

Kevin Brodsky (1):
      arm64: vdso32: Remove unused vdso32-offsets.h

 arch/arm64/Makefile               | 2 +-
 arch/arm64/include/asm/vdso.h     | 3 ---
 arch/arm64/kernel/Makefile        | 6 +++---
 arch/arm64/kernel/vdso32/Makefile | 9 ---------
 4 files changed, 4 insertions(+), 16 deletions(-)


