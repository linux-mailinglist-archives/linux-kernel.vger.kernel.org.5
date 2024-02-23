Return-Path: <linux-kernel+bounces-77571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F288A8607A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5182A2866BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8053BE;
	Fri, 23 Feb 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmI/c/Mi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D70C370;
	Fri, 23 Feb 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647989; cv=none; b=D4XwvoS07DwQCZ4eOJeuaT+IN34KSA/wgDE2Gv0HZ+NSla8ltUgbnopaqNxN9ohS9mx7d2vKVUxbz4pupUw2WnvX0s9oTBV1mpXYPjA6JoOIrtR9wuAyiZOd854wc27/Q35hf1iK7GNMBF85TH5rkHnclwVSj+gZTfOiu/dgu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647989; c=relaxed/simple;
	bh=2zq8t2w/MxvWtYHu7VdFtzRLQDoWQp7+hxBDYINDmR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzMuE7QhoUQlSihOXlqb+Gg+CNj+k52zpaoNSXhxVT/I+xJUm8LvDo/VLT4wTelP7n4VVs6u1zwberx1tAyL8FzjeCMwMC5vc6m7d9ZYjXezAPMXMCeiBuw4wVi+osJ5YAL2idrAsde22Yq07n+I6l7sFDu7XGx6/t+8YGFptnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmI/c/Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6720AC433B1;
	Fri, 23 Feb 2024 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647989;
	bh=2zq8t2w/MxvWtYHu7VdFtzRLQDoWQp7+hxBDYINDmR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmI/c/Miowmr1UpqRQQQoGics2HxdOzd8fXDF8ISzUC5IjbnXBd1ZybjLuCp1iIba
	 4gU8Kshs121y8K7jCR7609eYif/bP7zqwCjA9oFYDsTG11FcwOyCft7EXNc3vn4paq
	 8ID9r2qnpCHUdfeAMHBmn/7iA3AnRVbcHDBWEaKHRFjY3EVezdeu//7oP5Gvd+PIwn
	 NBJfvHnT8Myev0TpkaX+Dcl66MVB5JYOz7MVJwWZapPIBSenFEDzRRdloVw0Yxq2d1
	 nz1+q0vP3hAbBC3mRLQRSfhC/QJWOBI5pUvoWEglHQ62CkWRD5BPjwUxDJVLGHc8jJ
	 1j1KmkuV50YNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0140ECE0DD4; Thu, 22 Feb 2024 16:26:28 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH rcu 4/4] tracing: Select new NEED_TASKS_RCU Kconfig option
Date: Thu, 22 Feb 2024 16:26:27 -0800
Message-Id: <20240223002627.1987886-4-paulmck@kernel.org>
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
A new NEED_TASKS_RCU Kconfig option has been created to allow this
enablement logic to be in one place in kernel/rcu/Kconfig.

Therefore, select the new NEED_TASKS_RCU Kconfig option instead of the
old TASKS_RCU option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 kernel/trace/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596d..6cdc5ff919b09 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -163,7 +163,7 @@ config TRACING
 	select BINARY_PRINTF
 	select EVENT_TRACING
 	select TRACE_CLOCK
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 
 config GENERIC_TRACER
 	bool
@@ -204,7 +204,7 @@ config FUNCTION_TRACER
 	select GENERIC_TRACER
 	select CONTEXT_SWITCH_TRACER
 	select GLOB
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	select TASKS_RUDE_RCU
 	help
 	  Enable the kernel to trace every kernel function. This is done
-- 
2.40.1


