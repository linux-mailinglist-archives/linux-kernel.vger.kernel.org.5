Return-Path: <linux-kernel+bounces-138764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC889FA11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144541C2143B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6963916D9B2;
	Wed, 10 Apr 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7n5Jgf2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E715ADB0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759831; cv=none; b=ZITuAaBQd7GktaPU1yAEaFKxSOKB4Tu5igtLDozFJMDzH7/Gvl7gib6kEwbpZPsILb/eaccX+IOo/R/Wfg6HuSXQzctRldfbNPnsmFbdDlgbv6Dw3hjjZXbT3ZFhbHQTiJa14HTk1KFSzLpV7RkDzP3jYOzMcqPjF2DV63XaU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759831; c=relaxed/simple;
	bh=zr37AZ5P+Jsxgb/Gyxa03cQqGoKMeaJhEq3JPY4Fv7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8d6blclmO4sbzocXZfdCO+76NIyL1SO4ClTt+scH4S1iFfmRVxzMrEwUYLSkZcjtwpyc+BDTULFEgHTnU0qGF/IRw9gWIb1Jy7dLkLMGFkX9/Fkjx9xnRnB5c333PuDCisBQph3scDtXHl2IxnVyNwqcbrwxzI9N9nisxUGoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7n5Jgf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F7C43399;
	Wed, 10 Apr 2024 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712759831;
	bh=zr37AZ5P+Jsxgb/Gyxa03cQqGoKMeaJhEq3JPY4Fv7U=;
	h=From:To:Cc:Subject:Date:From;
	b=O7n5Jgf2lmc+U1ygdgCX+qRuGy1Y3+qW8hGz8Ub4A5eOdTbw00TpmssfAOwTSXy1y
	 dVa/2yAMhIWsq2bEfs9HtNnnN0uxiK/Hn3f+lIUigthhLJARcpWNoWBNV0g7Nhr815
	 I/xsOw2WJo5N/c0Bmw/O6qfCNwnKNhPRbV3XiC7iDW6j887tZ7Nl+dKaHMSyFuzZ+6
	 DkwTXzFZaHe+LL6H8LVeerY75mNvAkW9KTbELBIzTaknOHWt2pHhBqmRTlIT79LgRe
	 iIew2SZrURVtgmlyB0jqctrDZ2mzpXvVcHm7GcNVrcTLtebJsVbTSnFgtq8FvOdLMX
	 AVuM5Yl43yZvQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] riscv: improve nommu and timer-clint
Date: Wed, 10 Apr 2024 22:23:45 +0800
Message-ID: <20240410142347.964-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As is known, the sophgo CV1800B contains so called little core, which
is C906 w/o MMU, so I want to run nommu linux on it. This series is
the result of the bring up. After this series, w/ proper dts, we can
run nommu linux on milkv duo's little core.

First of all, patch1 removes the PAGE_OFFSET hardcoding by introducing
DRAM_BASE Kconfig option.

Secondly, to use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need
to take care two points:

1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
implement such support.

2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
add a quirk for lacking mtime register") of opensbi:

"T-Head developers surely have a different understanding of time CSR and
CLINT's mtime register with SiFive ones, that they did not implement
the mtime register at all -- as shown in openC906 source code, their
time CSR value is just exposed at the top of their processor IP block
and expects an external continous counter, which makes it not
overrideable, and thus mtime register is not implemented, even not for
reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
extended CSR, these systems still rely on the mtimecmp registers to
generate timer interrupts. This makes it necessary to implement T-Head
C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
reading mtime register and falls back to default code that reads time
CSR."

So, we need to fall back to read time CSR instead of mtime register.
Add riscv_csr_time_available static key for this purpose.

The second patch adds T-Head C9xxx clint support to timer-clint driver
by taking care of above two points.

Since v2:
  - drop CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME, instead we use runtime
    code patch to dynamically enable CSR TIME code path or MTIME code
    path.

Since v1:
  - fix c900_clint_timer_init_dt() defined but not used build warning
  - add option CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME instead of removing
    mtime usage for all platforms, since not all platforms implement the
    time CSR in HW in M mode.
  - rebase on the timer-clint improvement series
https://lore.kernel.org/linux-riscv/20240406111757.1597-1-jszhang@kernel.org/T/#t


Jisheng Zhang (2):
  riscv: nommu: remove PAGE_OFFSET hardcoding
  clocksource/drivers/timer-clint: Add T-Head C9xx clint

 arch/riscv/Kconfig                |  8 +++++-
 arch/riscv/include/asm/clint.h    |  2 ++
 arch/riscv/include/asm/timex.h    | 18 +++++++++---
 drivers/clocksource/timer-clint.c | 48 +++++++++++++++++++++++++++----
 4 files changed, 66 insertions(+), 10 deletions(-)

-- 
2.43.0


