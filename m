Return-Path: <linux-kernel+bounces-119650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46988CB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9EA1C3EB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A33127B6A;
	Tue, 26 Mar 2024 18:06:14 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B0127B47;
	Tue, 26 Mar 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476374; cv=none; b=RYiUQigJhjcj7NmsnWtIKTuS6JHHTx0RFuKmcdxr662r2hZZZHqGAUfZfvms5CsRziIPGi9bvxVhPaBwiLaKOFcBoeGMyXoxQhvL5KugXCrGM1c8aiWobuXtyKeps4EAIu/rBQtt6X+swooqmiCG/rhiRFvoe9tdZOt36eUCLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476374; c=relaxed/simple;
	bh=1NprXnNucG4gNP4X723OkYkF5c9zIbC5pkXNXKegHoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fW0Lc46usJeGrA82pnOMMJw2XdRf3CS7ozCDqu2sPBCQn9rO9XYp+veHRwtr7rkcSCQiJPBLtFnV6CKP9IeR/dHtAglfNp99Qcm5xSxw3YSiRGHswqUtb0QTfLEIiOnwKVdV+QBJ3zmkeH2ASATEBMKn6rewkjom3+NlXjMFX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=56066 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rpAuy-0000Uc-4G;
	Tue, 26 Mar 2024 20:49:00 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1rpAuy-002Nej-0h;
	Tue, 26 Mar 2024 20:49:00 +0300
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
Subject: [PATCH] rcu-tasks: Update show_rcu_tasks_trace_gp_kthread buffer size
Date: Tue, 26 Mar 2024 20:48:39 +0300
Message-Id: <20240326174839.487582-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

There is a possibility of buffer overflow in
show_rcu_tasks_trace_gp_kthread() if counters, passed
to sprintf() are huge. Counter numbers, needed for this
are unrealistically high, but buffer overflow is still
possible.

Update used buffer size for maximum needed size for
current format string.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 147b5945d67a..13ac514489c0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1992,7 +1992,7 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 #if !defined(CONFIG_TINY_RCU)
 void show_rcu_tasks_trace_gp_kthread(void)
 {
-	char buf[64];
+	char buf[87];
 
 	sprintf(buf, "N%lu h:%lu/%lu/%lu",
 		data_race(n_trc_holdouts),
-- 
2.34.1


