Return-Path: <linux-kernel+bounces-130476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A7E8978C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8EEB25ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D81154448;
	Wed,  3 Apr 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx+7Z9Vg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024171A5AC;
	Wed,  3 Apr 2024 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170395; cv=none; b=OGV89bETpIr+cPsEoZXxgs5o/07oqNl7y9SVzvVFbtrEXwwuxQqwmb4z12758yZSHwpluNaY46APNV+EqYyqOm/5mxU/fEsm6Y6QCzJ2R69DY6LDl87C1HXKc8QSFohLjAN3060MbdRWTvCzgrry+gprKSlkOAlIU0ZRofwQWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170395; c=relaxed/simple;
	bh=LZLoBx1FU+I9eSqFIXpb6gxTsx2CaE+4KzYX9KyagFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EslFKyOQzjlhwBfINcwdgM6JtkZ7Yg/A6s+ak0TM2B2GiQuQa9PJI6bb1X1rRItHkfFxf5UCH+CgeuXxJWwx9vuvAaegL0pq/nNBgpoWHrpeSO8+b0Ql9Y9KdWwqweGGW8fSbOTOQ8NQkhLV55XbTJsOIGJyMy6BC8h3BQjUzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx+7Z9Vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7454BC433C7;
	Wed,  3 Apr 2024 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712170394;
	bh=LZLoBx1FU+I9eSqFIXpb6gxTsx2CaE+4KzYX9KyagFE=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=Dx+7Z9Vg5hvLU+jMN0LJqQuSQhaH8NQZG+/PwBme8f25Wx4aeqe03JHWr6DbYPYwM
	 ljpdxfhMwXJzEiV4wZYhk84PpzWRWexIqtaE+/CzQ0lqcjPGbDUznwiPDHjUhS1vNU
	 FBjsKG/nip+ZqQgNqVDeEFLL0Lht+iXHWl3Fm5OcLeg8yqDKL3LeLCjI6Y8thKy33v
	 /uyo1hIk8oklUSpTKYbFlTL6wMvuFZx3y48+0yPvlkEFGxc6CTBiituoK51jIYo3zT
	 Ut0Iu5TtvZUfvWSMVBAT3iUYKcGTW5TGdId0nYcpDLtd8YAIgyKATXB7gmhgSHSQMr
	 4ihJ/72Zzl6OQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 13991CE0D85; Wed,  3 Apr 2024 11:53:14 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:53:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Chris Mason <clm@fb.com>
Subject: [PATCH RFC ftrace] Asynchronous grace period for
 register_ftrace_direct()
Message-ID: <7ed089be-c0c6-43b5-849a-05599cb32cfd@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Note that the immediate pressure for this patch should be relieved by the
NAPI patch series [1], but this sort of problem could easily arise again.
So would this change make sense?

When running heavy test workloads with KASAN enabled, RCU Tasks grace
periods can extend for many tens of seconds, significantly slowing
trace registration.  Therefore, make the registration-side RCU Tasks
grace period be asynchronous via call_rcu_tasks().

Reported-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <linux-trace-kernel@vger.kernel.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698b..6d21e4e97ed48 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5366,6 +5366,13 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
 	}
 }
 
+static void register_ftrace_direct_cb(struct rcu_head *rhp)
+{
+	struct ftrace_hash *fhp = container_of(rhp, struct ftrace_hash, rcu);
+
+	free_ftrace_hash(fhp);
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
@@ -5464,10 +5471,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
-	if (free_hash && free_hash != EMPTY_HASH) {
-		synchronize_rcu_tasks();
-		free_ftrace_hash(free_hash);
-	}
+	if (free_hash && free_hash != EMPTY_HASH)
+		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
 
 	if (new_hash)
 		free_ftrace_hash(new_hash);

