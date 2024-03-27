Return-Path: <linux-kernel+bounces-121566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A0188EAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820FAB2D690
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4B130E3C;
	Wed, 27 Mar 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg8dExgq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C3130AF0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554499; cv=none; b=IH04Nbrg/iLNvsJliD8cvR2+ASi1InZu5OnFzY6RStANOpB+UTSMmPUTpb8IlYVHfpPlY/mDvnNjy77lt8RiB3Culk/g3mz4cajfwswyI+l5x791sKueqIQgbKTyLiDLoEMYkRnzyzm3NrAH6htOXt7GpID9a9G10SI3MbZXG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554499; c=relaxed/simple;
	bh=go4I6kAm2xNWlWjSFNfYVEqDcGhAdyxTeUu+DcP2luQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDihs6yzTFxHsoKLBwLvdW86GfCk0kzj4tnpaqjZl/T3CzGUL/5hze3qU6g4L9blkZ9HsgVE02+GXOfxu6AblNzjDIuHBKCyixDGAl6yIl4QdB1zM6qS3v1I+J3NOP2MfVq4Sh2m1Fd7DjYJEMwaHIwhz/PpI2Khz5Idw4EyXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg8dExgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0039C433F1;
	Wed, 27 Mar 2024 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554498;
	bh=go4I6kAm2xNWlWjSFNfYVEqDcGhAdyxTeUu+DcP2luQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Yg8dExgqMQWKS9zGTfLXFKZ44ip7t4QXO9iQH59tWPRZms7ITLpIJsRb1geCP/n4F
	 cR1xEdgmToPdqBB/rg//HuSUJt34947vliqgVJS5YvK7cpK1nhHwV5zk2nhli/p29F
	 fXytaasWJ5e+EHkfcLxtGfXO7ugCUYe8/qUyiU8oNefgH/fNYroPBHDtyiJJunJD/7
	 iM08xMFKfPfFKPVNBqzHTjHI2tOLjtiAQMTAbb3StbkapKBaGwKBMS3YQgmccGZ+KP
	 d/C6Z14x7IEF4b673oMwBn2vcGIBa6DjztuC4DOJ2vRBaMLM5UM0wv3OB64SZNn+yD
	 u9DVh1GR835iQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clocksouce/timer-clint|riscv: some improvements
Date: Wed, 27 Mar 2024 23:34:59 +0800
Message-ID: <20240327153502.2133-1-jszhang@kernel.org>
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

Jisheng Zhang (3):
  clocksource/drivers/timer-riscv: Add set_state_oneshot_stopped
  clocksource/drivers/timer-clint: Add set_state_shutdown
  clocksource/drivers/timer-clint: Add set_state_oneshot_stopped

 drivers/clocksource/timer-clint.c | 19 +++++++++++++++----
 drivers/clocksource/timer-riscv.c | 11 ++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.43.0


