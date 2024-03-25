Return-Path: <linux-kernel+bounces-117514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933488AC22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACDF322164
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9674A29;
	Mon, 25 Mar 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNkwfSJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2531C36
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385617; cv=none; b=tpxeWXEFE4YszgtmMFQdU4cc1JpbDl4wnRtTSg8PRM/z9ozKHINDS83PgoXZ/pTY0oT6m0ZklarAT0Kc3GGY9Orwy85mXyx0r9z57nO9qOId6ezf1Zf1fQrYfes0hBimAju3cw32hhCSppw6tfbdeAWYhd+BhzES9fXGaT/oNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385617; c=relaxed/simple;
	bh=WannNMe3KRyek8xiVd2Lz4G8sK7Q+T+16cLq3DmwwLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+h1N2vQ3VrtvmP4ZsaWITZFruIsDCRAOs6MtRpH7D0I8QkLJfCQgACtWH725eEnis7cyxmE0CPnYxd5C0GFyiHHR3CkxL1dpsKopiBql43YgDI3S8uXSuPw/KDDS1gQfHUKaRveIUN5Cikc0hHL4Xc4bmfvhW1xX4qiXci4Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNkwfSJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14753C433C7;
	Mon, 25 Mar 2024 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385616;
	bh=WannNMe3KRyek8xiVd2Lz4G8sK7Q+T+16cLq3DmwwLY=;
	h=From:To:Cc:Subject:Date:From;
	b=NNkwfSJEyxR2lSdn0xvBDIKqvHePa4ALFOJx27WKPZ18OXsNUL15K1RStdQpEqjnn
	 dqh8zQjpyHZCvtc/xHKm8uAUDMpKy5TuN9/sZ8Q1lyb9YdXlwq6hKHEHTDhAm1tDfX
	 ijOcSX1Up+8aRWTh7vneNw+makOWEqX5gTnmbpA7lS2oBXiKBNbGkiQakSgPHsiWfL
	 P2Jv01ZU+1/bLblzTvNrJHvVOU1wMD4BNRpJxCGt1AQajCplrb976zH4Uv598uMAEA
	 +zYd9bndRQ37zcSBlmohp48Ops3f96nIKv/M1xwpJTr4C0tM3oMr6GqcwnLBR5FjNM
	 EtYlFF5Un9RRQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] riscv: improve nommu and timer-clint
Date: Tue, 26 Mar 2024 00:40:16 +0800
Message-ID: <20240325164021.3229-1-jszhang@kernel.org>
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

The following patches try to improve the get_cycles and timer-clint
by always using TIME CSR, because Per the riscv privileged spec,
"The time CSR is a read-only shadow of the memory-mapped mtime
register", "On RV32I the timeh CSR is a read-only shadow of the upper
32 bits of the memory-mapped mtime register, while time shadows only 
the lower 32 bits of mtime.".

The last patch adds T-Head C9xxx clint support to timer-clint driver.

Jisheng Zhang (5):
  riscv: nommu: remove PAGE_OFFSET hardcoding
  riscv: nommu: use CSR_TIME* for get_cycles* implementation
  clocksource/drivers/timer-clint: Remove clint_time_val
  clocksource/drivers/timer-clint: Use get_cycles()
  clocksource/drivers/timer-clint: Add T-Head C9xx clint support

 arch/riscv/Kconfig                |  8 +++-
 arch/riscv/include/asm/clint.h    | 26 ------------
 arch/riscv/include/asm/timex.h    | 40 -------------------
 drivers/clocksource/timer-clint.c | 66 ++++++++++++-------------------
 4 files changed, 32 insertions(+), 108 deletions(-)
 delete mode 100644 arch/riscv/include/asm/clint.h

-- 
2.43.0


