Return-Path: <linux-kernel+bounces-149530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E028A927F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10F8B2228F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850E56462;
	Thu, 18 Apr 2024 05:38:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE5C4F8A3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418707; cv=none; b=gSYOko6ackBjJjx/mbWHAKsClzYIYqb2CMPe4ovnHl26nfx3cFySTkrlb6Vgh2W3ujfEOsKAT74ondjvvzVoKKXV30bea6qP/PqBTmZ3hxEpWCIrJHuMcC2jpVtRUtNAZlO6mpHOaI7j0NEX2WbbQy1o9hh71XJOWx0rmmCJRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418707; c=relaxed/simple;
	bh=gDSXEJclSLPUkmucAi4YvSV5HLcUGxSq8okWA1JWTHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AgToE7EuvUvaDxwEEaLKzo2ZwHRf2gubypHr4Jx/R1uqh+3iiL1qrszZOyK5opQP+kNTzBGq5xop2b0RRIzFvxGUjapHOzIVU6EmrLExWuOWPpwO2qvSKWBq8ZW1N1ReVo4OD3HB15qXR/ZjnaZgZO50x3yWV2l11eAhdZJENck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51CE4339;
	Wed, 17 Apr 2024 22:38:46 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.60.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 042623F792;
	Wed, 17 Apr 2024 22:38:13 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: Drop ID_AA64PFR0_EL1_ELx_[64BIT_ONLY|32BIT_64BIT]
Date: Thu, 18 Apr 2024 11:08:02 +0530
Message-Id: <20240418053804.2573071-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces custom macros usage for ID_AA64PFR0_EL1_ELx_64BIT_ONLY
and ID_AA64PFR0_EL1_ELx_32BIT_64BIT fields, thus finally just dropping them
off completely. This series applies on v6.9-rc4.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  KVM: arm64: Replace custom macros with fields from ID_AA64PFR0_EL1
  arm64/cpufeature: Replace custom macros with fields from ID_AA64PFR0_EL1

 arch/arm64/include/asm/cpufeature.h            | 4 ++--
 arch/arm64/include/asm/sysreg.h                | 4 ----
 arch/arm64/kernel/cpufeature.c                 | 4 ++--
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 8 ++++----
 arch/arm64/kvm/hyp/nvhe/pkvm.c                 | 4 ++--
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             | 2 +-
 6 files changed, 11 insertions(+), 15 deletions(-)

-- 
2.25.1


