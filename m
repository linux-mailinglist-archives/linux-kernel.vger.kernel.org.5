Return-Path: <linux-kernel+bounces-121570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E71988E9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29648284D70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9256132819;
	Wed, 27 Mar 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJaykR9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45F1327FC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554506; cv=none; b=mr4/aYVb2Jj51wkLmFfHkLDYEwSuBRbVQL+EpqCSPYqYJ58UgFpuLuPHNbpKfHZ2dGQ964tE5xx0JNbm0ojvQPqmyx8tLXj+b+ifXPSQ88aErSvXKBJNYFINHU+REKdKVCprCRQCZR5sLspv+XNHJW6E7sULbQGWZviuM/bR6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554506; c=relaxed/simple;
	bh=G8Du/nKE3EQGqBI4paXDN1AIdNVl4glAliWu+H6P45c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8GrVma+9ZlVg7+CztTI4+kpsChSFvIZYAh0sXQMDSwRHO3sHKkw7VowYrrrP56+7Zh1gcrPhymfLOCwd+KEO0iYqFKFQZuPqz03DSbqzGMfW0vmy86XaF/Xx4TugFAH/rJ1VSCLG4f6kVRochJ54MjUqQhPS7rscrYs4SWD7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJaykR9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D24C433F1;
	Wed, 27 Mar 2024 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554505;
	bh=G8Du/nKE3EQGqBI4paXDN1AIdNVl4glAliWu+H6P45c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJaykR9+OUNmZr8FxTeTlU3uWMWDqdwYbp3icdv9jf2Q6hJMBgQDEBGpikt5hRtAf
	 6La3dI3Nq+RMa6s+5yvwewnzw/JWkIbLhukmqq88cKYBgWA56MFnJxYJhIzMCCsrT2
	 tdnL14om1dRM4/C9RQxh1xS4SJzqci0pX/fYmssovPrdEpAZMqbn7/lp2XLV1/dygo
	 EysNPjAnNgZK+erhl7WXhr0hfGBWQCY+0wU14BCX9wAa3Y4YXsYbJ/pLBU+c6/WDy1
	 /xyzq1sIy9qXQAFVpd4QGDCQC3F/7gyOAzQzskObCZ25XfFaGsPFxoSm6YPYymed7k
	 Blh/EcdKYg7og==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clocksource/drivers/timer-clint: Add set_state_oneshot_stopped
Date: Wed, 27 Mar 2024 23:35:02 +0800
Message-ID: <20240327153502.2133-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327153502.2133-1-jszhang@kernel.org>
References: <20240327153502.2133-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid spurious timer interrupts when KTIME_MAX is used, we need to
configure set_state_oneshot_stopped(). Although implementing this is
optional, it still affects things like power management for the extra
timer interrupt.

Check commit 8fff52fd5093 ("clockevents: Introduce
CLOCK_EVT_STATE_ONESHOT_STOPPED state") for more information.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/clocksource/timer-clint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 56cf6c672e6d..f5c04520d6b1 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -134,6 +134,7 @@ static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
 	.rating				= 100,
 	.set_next_event			= clint_clock_next_event,
 	.set_state_shutdown		= clint_clock_shutdown,
+	.set_state_oneshot_stopped	= clint_clock_shutdown,
 };
 
 static int clint_timer_starting_cpu(unsigned int cpu)
-- 
2.43.0


