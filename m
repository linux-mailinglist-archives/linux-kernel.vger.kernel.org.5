Return-Path: <linux-kernel+bounces-103385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED64D87BEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D89287F78
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255F70CB9;
	Thu, 14 Mar 2024 14:21:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE96FE1E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426084; cv=none; b=gqbWosaCaB+Ipf6w2gapnKrqfJuWRDq8u6IFI8qozqGKwVbb+cW+F2FCKDVtxMuYWFeMLlmWvsL+mTguM3DGvgsDqQEkBjy5bfM1LhdMuqMgvOd+HpUF8NPtxAvcxTXbQHqIfc+MqvhiLUbQtbsYMTR+kbK3+bis3D9fRmqqxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426084; c=relaxed/simple;
	bh=4ttIfC8PYF+Gki5Csa2Sakq4v+hP+Coh+x0QO+LZc1o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=utGSJho51TBudrEZQwe0oAUCTLjJgzcCMtmSr+bsF72DY+82Be4/s5lgAU7kdpj+CH0C71SgTCcBkI7TQ6Uk0YT5WKbGkM0+pNXfoDfWQi8Eqi0kb0c/W3ud8oQdXqa2q2D+qdcTZ5QosnsI13Ng8pVJ1SIlrxyaGWXBuIae8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07634C43609;
	Thu, 14 Mar 2024 14:21:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rklzb-00000002deS-1LaB;
	Thu, 14 Mar 2024 10:23:35 -0400
Message-ID: <20240314142335.181319952@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 14 Mar 2024 10:23:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [for-next][PATCH 4/8] tracepoints: Use WARN() and not WARN_ON() for warnings
References: <20240314142301.170713485@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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

Link: https://lore.kernel.org/linux-trace-kernel/20240228133112.0d64fb1b@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Borislav Petkov <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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



