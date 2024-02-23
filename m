Return-Path: <linux-kernel+bounces-78121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1C860F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257FF1C23920
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9000E5C8FC;
	Fri, 23 Feb 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/oHKXo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F495CDD5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683937; cv=none; b=LiSDnekWVaU2g1LL1n+Z8fGGW74jUqFh3T+IZJbPSMLSFh/M/oHPsiE7SpUkP/ud4vPuwHdCIQ0ZS/j9d9aZnAiRXcXlOeifbMaxqfNwhF5bKx/NID2VmuWo4nyRoXXQCYo2B0Mvf1GdG7a8Bx+Z5vS7Hit47emN514MApgG5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683937; c=relaxed/simple;
	bh=7yeW9jYEYimEdMiBYK8mFKP1brze9Qc84CjUxoUftoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jvXffTxMt4hDF8h7g+bVHVScQRFfxtKSZo/UPCl4VGSFVH+yOCaN68CGgpnCvSuA7aUA8MxeVlWiV/5/1K/BkmYGxehZOP3RYKVENDkyO+oZk1mWrYz9iU0uuRz7G0fktrPCcOS0b+HtmjoIu98BvJEZrtvSZEOf7G/ZeRpKyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/oHKXo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB7FC433C7;
	Fri, 23 Feb 2024 10:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683937;
	bh=7yeW9jYEYimEdMiBYK8mFKP1brze9Qc84CjUxoUftoU=;
	h=Date:From:To:Cc:Subject:From;
	b=k/oHKXo2MMf8n8BQLJwqGq10e+mBy7XBv4otVvWKeB4RbPtfOFQh7EDAKkeB4JK/t
	 hWetBYs/aHX20fhpHF6Ren5rBjOXHteM4K1TlWLg/tWB8msT0PDhEiX0Pqbp6ESdGR
	 egK4GFrUYgTot0sktIITDRYE73CVlh2Bx1LJkV7fO/wgNGsfqVrWK4uZ8SdDDvBUC8
	 BcMfSsQ6Sk8B7+EgMuureh6RPFiidUWNjnvavCF/kNS/GB1Jj4pOPK2jjSzfaHcsX5
	 +rcTxH12B+WiTgcyhLOPaNOVZkysnvFwPqPRKJ7wHrDAtQTrRPhFUhQozj0tPRvkU+
	 Uh0HSoCMu2HTA==
Date: Fri, 23 Feb 2024 10:25:32 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc6
Message-ID: <20240223102531.GB10274@willie-the-truck>
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

Please pull this weekly batch of arm64 fixes for -rc6. The summary is in
the tag, but it's a simple fix to a definition in the CXL PMU driver, a
couple of patches to restore SME control registers on the resume path
(since Arm's fast model now clears them) and a revert for our jump label
asm constraints after Geert noticed they broke the build with GCC 5.5.

There was then the ensuing discussion about raising the minimum GCC (and
corresponding binutils) versions at [1], but for now we'll keep things
working as they were until that goes ahead.

Cheers,

Will

[1] https://lore.kernel.org/lkml/CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com/

--->8

The following changes since commit 2813926261e436d33bc74486b51cce60b76edf78:

  arm64/sve: Lower the maximum allocation for the SVE ptrace regset (2024-02-15 11:48:00 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to d7b77a0d565b048cb0808fa8a4fb031352b22a01:

  arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend (2024-02-20 12:19:16 +0000)

----------------------------------------------------------------
arm64 fixes for -rc6

- Revert fix to jump label asm constraints, as it regresses the build
  with some GCC 5.5 toolchains.

- Restore SME control registers when resuming from suspend

- Fix incorrect filter definition in CXL PMU driver

----------------------------------------------------------------
Hojin Nam (1):
      perf: CXL: fix CPMU filter value mask length

Mark Brown (2):
      arm64/sme: Restore SME registers on exit from suspend
      arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend

Will Deacon (1):
      Revert "arm64: jump_label: use constraints "Si" instead of "i""

 arch/arm64/include/asm/fpsimd.h     |  2 ++
 arch/arm64/include/asm/jump_label.h | 12 ++++--------
 arch/arm64/kernel/fpsimd.c          | 16 ++++++++++++++++
 arch/arm64/kernel/suspend.c         |  3 +++
 drivers/perf/cxl_pmu.c              | 10 +++++-----
 5 files changed, 30 insertions(+), 13 deletions(-)

