Return-Path: <linux-kernel+bounces-126964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE6289450A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58251F21BDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00385024E;
	Mon,  1 Apr 2024 18:55:23 +0000 (UTC)
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6154F88B;
	Mon,  1 Apr 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997723; cv=none; b=TH+lSK8Bw9WVZri7kHfMOctMdBraXvM2RFZOdnhLs01muBn5JPOea1UoPeaswoqkUECf67+A+6VcNdxfxQRVPmxm4w5ma16A9zzp2y3FYw3bh9hEmWP152WE70wgs+u/QHJU86O+3e2M1Q9p2tmj/AWzIbCQS7C1l4Mn3sGuYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997723; c=relaxed/simple;
	bh=4yV/6Rl53rOy1mtHIIWoR/s27gopoujP4rYp3U+jscQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZK8pH9LQrD/CsYqGLVLK6uuP/HLPnUf1Y74ofJfRVHz2wPcCXLgxdMIuRE6TolUNJuyotODvKeBhTSZSxiee7SRu4g3hhcIk8d7xqHF3uPsSXQMPmes4LvHxPk1q2hTaVkpNd+5PYuETp2ayDvIMo19Vv9k6w5cPKuPL6Cuv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.148] (port=64432 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rrMoE-0007tS-6T;
	Mon, 01 Apr 2024 21:55:06 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1rrMoD-009Nd0-2u;
	Mon, 01 Apr 2024 21:55:05 +0300
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
Subject: [PATCH v2] rcu: Fix buffer overlow in print_cpu_stall_info()
Date: Mon,  1 Apr 2024 21:54:54 +0300
Message-Id: <20240401185454.361291-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5a629a8e-5a70-4c7d-ab6a-f4a09e8c574c@paulmck-laptop>
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
possible buffer overflow in the case of huge jiffies
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
v2: Remove signed to unsigned print format change as
Paul E. McKenney <paulmck@kernel.org> suggested, add format
intention clarification comment
 kernel/rcu/tree_stall.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..b972fe9f07a6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -504,7 +504,8 @@ static void print_cpu_stall_info(int cpu)
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
-		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+		/* %ld is intentional, for easier bug detection */
+		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
-- 
2.34.1


