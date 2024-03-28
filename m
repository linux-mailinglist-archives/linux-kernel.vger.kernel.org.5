Return-Path: <linux-kernel+bounces-123409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFFA890828
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB057299FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CCC12F5B1;
	Thu, 28 Mar 2024 18:19:54 +0000 (UTC)
Received: from relay164.nicmail.ru (relay164.nicmail.ru [91.189.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709B1879;
	Thu, 28 Mar 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649993; cv=none; b=dUy5oMO5YFvV6C4rRPekf3naXWfH0lt2RNLurq13k58Ic0CCCycj1//2xIQXeXbQKwuTC/8XdO1UuitV7Wcc6M6k4Z7PYdRlyw6OS/FpL8wvJX0bw+Iy6MyA2xh2YT48hh+Mb02MqwSHi2kLTqdlBeCnqkD/9XcXh2ZwlWKVWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649993; c=relaxed/simple;
	bh=/0iYGmx0+L/9J0BF+wBfl+vJ657RoLBgKRvZRDBFOQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDUZcuyF2Wlvhnq26a6ibYd2DfOJggRLjlutMeCXjk/R3cF3wGIaPjyT23Vhfy/f3xT/tUTeWMLUriuHtunvg97kiKZpAWcStV2PxLZ+4I61AK6a76Ve2rETqm9R7gEioBHFHi86zMtntHVUGtmL9Dt4byUX5gf/r/muD9IlJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.149] (port=41536 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rpuLh-0004jl-D2;
	Thu, 28 Mar 2024 21:19:37 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1102.mail.hosting.nic.ru (Exim 5.55)
	with id 1rpuLg-00BqTj-30;
	Thu, 28 Mar 2024 21:19:37 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] rcu: Fix buffer overlow in print_cpu_stall_info()
Date: Thu, 28 Mar 2024 21:19:14 +0300
Message-Id: <20240328181914.869332-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

rcuc info output in print_cpu_stall_info() contains
posiible buffer overflow in the case of huge jiffies
difference. The situation seems improbable, but, buffer
overflow, still. Also, unsigned jiffies difference printed
as (signed) %ld (which can be a bad format, if the values
are huge).

Change sprintf to snprintf and change %ld to %lu in format.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 245a62982502 ("rcu: Dump rcuc kthread status for CPUs not reporting quiescent state")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 kernel/rcu/tree_stall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..d4542c6e7c60 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -504,7 +504,7 @@ static void print_cpu_stall_info(int cpu)
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
-		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+		snprintf(buf, sizeof(buf), " rcuc=%lu jiffies(starved)", j);
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
-- 
2.34.1


