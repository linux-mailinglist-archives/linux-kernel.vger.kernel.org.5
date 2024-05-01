Return-Path: <linux-kernel+bounces-165823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6168B9210
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D06B21449
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ED1165FDF;
	Wed,  1 May 2024 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVrs0N+9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977B4D9EF;
	Wed,  1 May 2024 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605158; cv=none; b=P/71dKOmmEn+dvyQ5iep0xmuAeBYREaT5dfdnnLDqzxYLcyPROInyFbOZhSi07o6AFsth3b5shMz79LMizOpsKN9iTEeqkq9ynW03wSsyR/AKocsV+Zg0rJm3IifD/Saydy8oMUhHJu9vGf2bSId/A+dP4KPMb5bm9upnY6bAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605158; c=relaxed/simple;
	bh=do+2ZH/19azdeCdNdYYL3AHNk8uPkdkkl2JCBaU1tK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QLxDGoMrVohRxbMtIpW11iMcDG25wfJEoeS5aY7JYgLjmnlrJix1TygtKJV0Gq/Ls+y1P17BU+ED9O+oMNoYWWWU0d3o3pNY/FagpdILQtKdwcQfu7y47CLHdWv6t/u1reOkUwUN8aEizNBV+6LTAXxNocmQ483uZnFNE7gy9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVrs0N+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373BBC072AA;
	Wed,  1 May 2024 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714605158;
	bh=do+2ZH/19azdeCdNdYYL3AHNk8uPkdkkl2JCBaU1tK4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=eVrs0N+9RpHN0X1elg9X2J1RPZxT0DIywBm+io97ufQZIMtzvK6Hc3MSS1maDwsMo
	 ANz3NzQ01Xa019RNE/fKijiHbyqZAyvA5XnimJqnhYvMjuxzDvwKOCYoo96+cmKSBn
	 PvrpClzZ8X8o7WKAKl+INf1tZFL0PSQIU6Rxy1Gbnl3z4g/SxTSs4CXSPtl2RboexA
	 K/LCLjFim7eM+Lxzf90ABNi5QIsq/im7EfFsJHcOull4/+5nNWmD8DmJp9eeq0XHcd
	 PkhEpoVA3PBpEv6AcysqcAnw6Gf3TdATBlZO387QkMSbFRU/w4+cQLqpzPBw7UOKLS
	 HGTXl91GlY2Ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CF3BDCE1073; Wed,  1 May 2024 16:12:37 -0700 (PDT)
Date: Wed, 1 May 2024 16:12:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: kuba@kernel.org, ast@kernel.org, clm@fb.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Subject: [PATCH resend ftrace] Asynchronous grace period for
 register_ftrace_direct()
Message-ID: <ac05be77-2972-475b-9b57-56bef15aa00a@paulmck-laptop>
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

When running heavy test workloads with KASAN enabled, RCU Tasks grace
periods can extend for many tens of seconds, significantly slowing
trace registration.  Therefore, make the registration-side RCU Tasks
grace period be asynchronous via call_rcu_tasks().

[1] https://lore.kernel.org/all/cover.1710877680.git.yan@cloudflare.com/

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
index 6c96b30f3d63b..32ea92934268c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5365,6 +5365,13 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
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
@@ -5463,10 +5470,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
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

