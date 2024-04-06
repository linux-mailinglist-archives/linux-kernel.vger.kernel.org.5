Return-Path: <linux-kernel+bounces-133907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E627089AA98
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30DEEB212BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178D2C6AD;
	Sat,  6 Apr 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpfwm09N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE87210E6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403079; cv=none; b=TnGLxozDDoig3itHPp2ruxLQ0KkkDF94tcS4GwP9rSZDtXkP9w0wrI5YZynTvuVz1r/2ibndHt2tAvdkKzXFjNs59pf+yt0gT+Mjszf869mhrB/6KzrMaR8g/6PbwZrsUpdKz+dExaJuSoeTqbuS/f6qdvo1hHZ6Ppw33MI5Gsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403079; c=relaxed/simple;
	bh=wDFzllJt1FJE4FDnlfzRpGVgIYeyXYPkTcLYBaCpQUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptzYNqcst7dn0e/bojHilsaANNLLBqTkPh2INBmrxQ+93lmHOD7vODsIVFjVpGS+wFNujHaJO5CYMVBJVmBnUFaMQlwWquVCXFn22S8upYEhn2w+ZouENvSkhLi+3/5xN7VWBmYvR0xZA+bEdCvJ3j1TPd1IJ9wwMU6gAqdNXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpfwm09N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5397C433F1;
	Sat,  6 Apr 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712403078;
	bh=wDFzllJt1FJE4FDnlfzRpGVgIYeyXYPkTcLYBaCpQUs=;
	h=From:To:Cc:Subject:Date:From;
	b=lpfwm09N/5GYWxiWujDnkZ6d5Y73y17ztqEJ5hXW5+qBrE3LU62E8KzTsu0zrY1/h
	 YjmZAIKyezHMC1RxE7nvnmneX2NPHWQNh9PvlwR2+Jm64I/mMBZ8q/TNSiDXi8MdKG
	 /0nrrcKujf6n6LDftB9eB4i8nBVe87hI5z/qFb5Ajf7HxEHgaJgILj/DP86Bx5B3aH
	 1DbEkGAszFspl4aCiQ1RgP1P/4dyHB8iH/zsh6YtZ7TCxC67lXQDUxofGfpgIWEDEE
	 t4oMaq7zMwHnA2nNlVMPmCnE1ktm7IaUvmxim+Ko88FyqVj0pXIXaPDLsOQpu0ko2D
	 qwWUeErgcvfow==
From: Jisheng Zhang <jszhang@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] clocksouce/timer-clint|riscv: some improvements
Date: Sat,  6 Apr 2024 19:17:54 +0800
Message-ID: <20240406111757.1597-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a simple improvement for timer-clint and timer-riscv:

Add set_state_shutdown for timer-clint, this hook is used when
switching clockevent from timer-clint to another timer.

Add set_state_oneshot_stopped for both timer-clint and timer-riscv,
this hook is to avoid spurious timer interrupts when KTIME_MAX is
usd. Check commit 8fff52fd5093 ("clockevents: Introduce
CLOCK_EVT_STATE_ONESHOT_STOPPED state") for more information.

Since v1:
  - use U64_MAX instead of ULONG_MAX in clint_clock_shutdown, this is
    to  "produce a 64-bit value on riscv32" as pointed out by Samuel

Jisheng Zhang (3):
  clocksource/drivers/timer-riscv: Add set_state_oneshot_stopped
  clocksource/drivers/timer-clint: Add set_state_shutdown
  clocksource/drivers/timer-clint: Add set_state_oneshot_stopped

 drivers/clocksource/timer-clint.c | 19 +++++++++++++++----
 drivers/clocksource/timer-riscv.c | 11 ++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.43.0


