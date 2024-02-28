Return-Path: <linux-kernel+bounces-85533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4886B72B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2E02874FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D34086C;
	Wed, 28 Feb 2024 18:29:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101379B70;
	Wed, 28 Feb 2024 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144949; cv=none; b=RSP7M9hjLtM19QF/D7qIhLz4eHmPNvmGINDy9driOq6NinjtLoxSFidm7W6Wram/dat24z6QxBtW1G7xMWe8Fg14w/I0C1OmsPdfUy5Xf9GPdnhkx1qC73ZBAWp86mP4VwOK8Dc0xkCO67m16QPs90Zh0Tbi6qaSIxjCYQvu7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144949; c=relaxed/simple;
	bh=l6NUBU5KkQ847zlqdjeMmAFbuAfUQOX5eiXn+JSxIOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dkfF/ANGmovNv5743zhHBaTKRGjMRD2lZ2Okp8Pbc3d0ciyJSlfqcx5e415VrFW+cOoCrS2OKBGLq/FOow8qcg8oYXDvrlk48J4+qakVwxLomFhfgQa8vbnZC7L2sAjt4xqt46ldVq6mUTNfTf3R9MkZSdAsWsZjTEITrQnVuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AF5C43390;
	Wed, 28 Feb 2024 18:29:07 +0000 (UTC)
Date: Wed, 28 Feb 2024 13:31:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] tracepoints: Use WARN() and not WARN_ON() for warnings
Message-ID: <20240228133112.0d64fb1b@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There are two WARN_ON*() warnings in tracepoint.h that deal with RCU
usage. But when they trigger, especially from using a TRACE_EVENT()
macro, the information is not very helpful and is confusing:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 0 at include/trace/events/lock.h:24 lock_acquire+0x2b2/0x2d0

Where the above warning takes you to:

 TRACE_EVENT(lock_acquire,  <<<--- line 24 in lock.h

	TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
		int trylock, int read, int check,
		struct lockdep_map *next_lock, unsigned long ip),
	[..]

Change the WARN_ON_ONCE() to WARN_ONCE() and add a string that allows
someone to search for exactly where the bug happened.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 88c0ba623ee6..689b6d71590e 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -199,7 +199,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (!(cond))						\
 			return;						\
 									\
-		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
+		if (WARN_ONCE(RCUIDLE_COND(rcuidle),			\
+			      "Bad RCU usage for tracepoint"))		\
 			return;						\
 									\
 		/* keep srcu and sched-rcu usage consistent */		\
@@ -259,7 +260,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 0);			\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
-			WARN_ON_ONCE(!rcu_is_watching());		\
+			WARN_ONCE(!rcu_is_watching(),			\
+				  "RCU not watching for tracepoint");	\
 		}							\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-- 
2.43.0


