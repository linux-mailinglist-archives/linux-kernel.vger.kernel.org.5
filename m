Return-Path: <linux-kernel+bounces-133911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B899989AA9C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905791C20EAE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020D2C6AD;
	Sat,  6 Apr 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD0O65Wk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384B2B9D5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403321; cv=none; b=rND/vCbjOR9aEFDTYKtXZ9ipenDaWpxxpco6puN0rKiFLEbWMN/KqW/cMt9hkHRzrrDMqBhkVsdIVUEMnr20dS+VQHggZWw6lHK3MDtj08B1KIC8/374kEeLyS7ARZMsxoSgaGXOu1Q6ni7eSNiTsxMTWrA6Nq62/bUdMb5d7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403321; c=relaxed/simple;
	bh=4HEh5WRadPdje54XUg02xBIGtsPiwVv0rVvT7xJfEk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhld6DISg8AIhIWguWfxiIXujXc3MuwbMHvO0TzRg3GL4nfHPlEShQ7UAmyCvC6I0bv7PZGE56fjji0TKlVTbzIa8KraG6G25i/Vd+tW0trCK0uEfzzQEPCFHqg3BsgxlPncktdTU0xjdiqour7Sr7TvYX9PQh26gpK6Y6qbiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD0O65Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3CFC433C7;
	Sat,  6 Apr 2024 11:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712403320;
	bh=4HEh5WRadPdje54XUg02xBIGtsPiwVv0rVvT7xJfEk0=;
	h=From:To:Cc:Subject:Date:From;
	b=uD0O65Wk9uJH8AXJ2ZmiqCtPoxCXg/KzCbxCB0QyR+OPe0U8JUsf7b+ZcA2KDIU9e
	 jS69HJe/aT2pALTTIov1Fn6CL4IPzU+PQNKzRa+5+qqIeXHj0ijqENHdNlz1uX9GsY
	 0r90y3yk6X9wiBp48G3owAIkbB1aohKHufqoHrkmG4Q908ALgcdwkXLVgEz82odRl8
	 m4PUpJfIOdM/jqW1z2/LLODExoPFYbQRWqy2UbhLlxiI4bReShyONl0k/XeUUr3f8v
	 yY2hQzYZcQYSdjjZIa4sxFZmo8+yqTMeEuptJvAMfmhVb6rawEQXJMk55+eZsO3IUB
	 gok77/w7a1KPA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] riscv: improve nommu and timer-clint
Date: Sat,  6 Apr 2024 19:21:56 +0800
Message-ID: <20240406112159.1634-1-jszhang@kernel.org>
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

As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer: add a
quirk for lacking mtime register") of opensbi:
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
So the second patch adds an option CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME
for this purpose.

The last patch adds T-Head C9xxx clint support to timer-clint driver.

Since v1:
  - fix c900_clint_timer_init_dt() defined but not used build warning
  - add option CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME instead of removing
    mtime usage for all platforms, since not all platforms implement the
    time CSR in HW in M mode.
  - rebase on the timer-clint improvement series
https://lore.kernel.org/linux-riscv/20240406111757.1597-1-jszhang@kernel.org/T/#t

Jisheng Zhang (3):
  riscv: nommu: remove PAGE_OFFSET hardcoding
  clocksource/drivers/timer-clint: Add option to use CSR instead of
    mtime
  clocksource/drivers/timer-clint: Add T-Head C9xx clint

 arch/riscv/Kconfig                |  8 +++++++-
 arch/riscv/include/asm/timex.h    |  6 +++---
 drivers/clocksource/Kconfig       |  9 +++++++++
 drivers/clocksource/timer-clint.c | 31 +++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.43.0


