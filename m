Return-Path: <linux-kernel+bounces-77572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A28607A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD550286761
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A9566D;
	Fri, 23 Feb 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCTyFMCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943637C;
	Fri, 23 Feb 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647989; cv=none; b=dkgnQcct+MYI8UnHOB0VDj5iWp4TUxXT7hiwrIGX8FqTTgsteuUhOhD0qRXVTdllZHVghe++9Ld0tHX1O4xZ1ievkeOTx1RJfF/379PysNkwx60IMEPDihrnkyN8hQWhDAhdNUM/XHa+bKqBwFTMKiekVtstJ/iVzsOCldE9arw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647989; c=relaxed/simple;
	bh=YJHlxUD/OoJ0p2sStlRJ0L83YeFXqQtRNbqzm4TpUZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xp++rKzZyeRzd4RcZoIQ6lQRrPU2QZKBg0WWTPHrlhPK/ADx66WTfxUquksHf1PgJk9agtktJqbs7vyqJN1o+aSXfWN0pza9rVM3L+4i9cgmyXtlxnH0Nm48aZaAAz8rjGB0xQZUVfKvaI6EirRVTrYiDKwl78yHkhLRLuxGKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCTyFMCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFFBC43399;
	Fri, 23 Feb 2024 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647989;
	bh=YJHlxUD/OoJ0p2sStlRJ0L83YeFXqQtRNbqzm4TpUZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCTyFMCj76ttTJk+FnrqikZSBryBEHKqLEEVxT3jCYfiKeZdIEMFa3Q9CX9Q8gMFz
	 gswhQjnjw21nIhg+FAx6eVynOcN7rkbEc5Yugf3TVgAZ9t1XgumfYX8dEvMppaBPRk
	 omD77vwUgTcQOuNxkiomgWDLSBTpjwpAnBlo13Ip4wIw4lV6Ww4sivkQy5eb4lq5yL
	 eK131CP+TipF/RH9rgd9AJiHyOIH2sTSBGArSA8QPcjTXOLcK8228QP/EBwrieZMEb
	 B0aV44xWzv2D7afRH1KfhxEOJ6uMPf02GKQxYZ9t2eBM5w1r02QhCtXGrH+AYBoGrp
	 2p/5xHutzXGcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F2CDDCE0D11; Thu, 22 Feb 2024 16:26:28 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Douglas Anderson <dianders@chromium.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH rcu 3/4] arch: Select new NEED_TASKS_RCU Kconfig option
Date: Thu, 22 Feb 2024 16:26:26 -0800
Message-Id: <20240223002627.1987886-3-paulmck@kernel.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c91917b508736..154f994547632 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -55,7 +55,7 @@ config KPROBES
 	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
@@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
 config OPTPROBES
 	def_bool y
 	depends on KPROBES && HAVE_OPTPROBES
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 
 config KPROBES_ON_FTRACE
 	def_bool y
-- 
2.40.1


