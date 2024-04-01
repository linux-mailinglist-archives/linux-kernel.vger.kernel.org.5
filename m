Return-Path: <linux-kernel+bounces-127002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A78945A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3B81C2162E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99A353378;
	Mon,  1 Apr 2024 19:43:29 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9217552;
	Mon,  1 Apr 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000609; cv=none; b=SyRQJnEkIO3cCOkSBxV7q6KSI4aF77o1mRRTL1DqHFe2sZBmAxWU3Mhk9jmFUQafq4Nocsbr6OkFrKScr6KvCcNjCq2X7nzWpMGvtfI/NMjPDEF0EY66OZzT6zC7272/EJljNYz79iyxaaK3GdpluAvAIji4ru5mKg0Mo4qPTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000609; c=relaxed/simple;
	bh=1hhXYXzpBlVTWwZr+xCZLOOAx+sHm9NyPBQON64e5yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CyRnEX193EPNHBDhY9ksBQLoC9+iM1FDlKSjJJP/5JjZaksz8WuRGHYLrFcBRdjiqrztI8XCUXpWsx0e0s8EVS6V68UOtJ2dOvN0ifaQtJtw2fLrAQgNjLQER2glUKTILiZmQj1J16BbdMyC3stDbLLSfAx+WD9LnP0boSfHBiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.151] (port=35640 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rrNYs-0004ov-5a;
	Mon, 01 Apr 2024 22:43:19 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1103.mail.hosting.nic.ru (Exim 5.55)
	with id 1rrNYs-00FCtG-20;
	Mon, 01 Apr 2024 22:43:18 +0300
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
Subject: [PATCH v3] rcu: Fix buffer overlow in print_cpu_stall_info()
Date: Mon,  1 Apr 2024 22:43:15 +0300
Message-Id: <20240401194315.362090-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401150540.6dab14fc@gandalf.local.home>
References: 
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
overflow, still.

Also, unsigned jiffies difference printed as (signed)
%ld. This is intentional for debugging purposes, but
it is not obvious from the code.

Change sprintf to snprintf and add clarifying comment
about intention of %ld format.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 245a62982502 ("rcu: Dump rcuc kthread status for CPUs not reporting quiescent state")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
v3: Change intention comment wording as
Steven Rostedt <rostedt@goodmis.org> suggested
v2: Remove signed to unsigned print format change as
Paul E. McKenney <paulmck@kernel.org> suggested, add format
intention clarification comment
 kernel/rcu/tree_stall.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..320440b8384e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -504,7 +504,8 @@ static void print_cpu_stall_info(int cpu)
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
-		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+		/* Print signed value, as negative means it is likely a bug */
+		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
-- 
2.34.1


