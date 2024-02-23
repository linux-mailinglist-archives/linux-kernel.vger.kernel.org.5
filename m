Return-Path: <linux-kernel+bounces-77573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADF78607A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E195286672
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A41567D;
	Fri, 23 Feb 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgJLx+iR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9408372;
	Fri, 23 Feb 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647989; cv=none; b=tebU2agpIq/Nd1+sdMArIW+PI1M9yIDP+64nqTqD3E3OyveBxDCEIdKBAW8D+bhD7o3eQWyc1ydmqvrXqAElp63mLlDzOwQoHwXNTIzrB5zOUYfRDven1lw5aom57UC0erSnMp2XtGcif2nTsME49FHbs6eGANYeCbOS93vb8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647989; c=relaxed/simple;
	bh=dqGOB7Gat6TFDeBuXsH+ly4XsXWkpbCooGphVwFg0Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLzYKR6ecnEt7ZD4pLgPjQtEHNn/sSTtb3HPH3TbaeQWr0q/69PEEQzx0Bs8E2AmhrDPxeadW2S5TLBTl0fiV3PPotlmnvP6gObkGoG5j1cYBc16/B3GltgrAm+6u6nfARGpTQ1Aa2MqhQQsux7WoJfPsm4heCfBcjY46tGmqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgJLx+iR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4620FC433F1;
	Fri, 23 Feb 2024 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647989;
	bh=dqGOB7Gat6TFDeBuXsH+ly4XsXWkpbCooGphVwFg0Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgJLx+iRcLoLouPIp30wP5iCKqNhjVA9MDeOFPxr3EQT5X2Im5qs+CpPm6mvHxia/
	 fT92RWI2wOPAq5Dpp2WdvHz2/7pUxqCPxAYxqdQi67JldTnLeRwOLgEBKztXtAebao
	 8IfrFnm4WxPjajnoQw6D96NC8VPXsO86bnnIU1PbQ1s6NqxbWUuS75sLp8bctoYdaO
	 ZTTyb79sfZLA/ziSTcCLe+KEFOiTNG0nKrPrze4qrgbbaOJvvFHM5ecfR1gWi6Aaow
	 YVUrcaDYgZUWZWkWbb/C2RhzRVULh1od1pXBB0r9NiITewu8jHeW67ozXcIBcjbMwL
	 p2Xbav3BHnKyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC969CE0B71; Thu, 22 Feb 2024 16:26:28 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH rcu 1/4] rcu: Create NEED_TASKS_RCU to factor out enablement logic
Date: Thu, 22 Feb 2024 16:26:24 -0800
Message-Id: <20240223002627.1987886-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>
References: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if a Kconfig option depends on TASKS_RCU, it conditionally does
"select TASKS_RCU if PREEMPTION".  This works, but requires any change in
this enablement logic to be replicated across all such "select" clauses.
This commit therefore creates a new NEED_TASKS_RCU Kconfig option so
that the default value of TASKS_RCU can depend on a combination of this
new option and any needed enablement logic, so that this logic is in
one place.

While in the area, also anticipate a likely future change by adding
PREEMPT_AUTO to that logic.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rcu/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 7dca0138260c3..3e079de0f5b43 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -85,9 +85,13 @@ config FORCE_TASKS_RCU
 	  idle, and user-mode execution as quiescent states.  Not for
 	  manual selection in most cases.
 
-config TASKS_RCU
+config NEED_TASKS_RCU
 	bool
 	default n
+
+config TASKS_RCU
+	bool
+	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU
-- 
2.40.1


