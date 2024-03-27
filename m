Return-Path: <linux-kernel+bounces-121647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D688EB94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43B12A3151
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E895414D293;
	Wed, 27 Mar 2024 16:46:37 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E2129E81;
	Wed, 27 Mar 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557997; cv=none; b=a2ds+7kVsys9q+EpXm5/pWcKzmt3wvAx10r9w6Cbu7LvpHQ+6Ionxwmj/F7nCWssXNDDg4APDBaDI9JJqOrT6/MNzBg/NKvc5HnMzoqRlQnn400JlK2i+vomGUQnkYNUxZx8ymTUkv5dOcjqvxhfJt7XQmWC3h6ML9h1EpBS4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557997; c=relaxed/simple;
	bh=tAFq/BzAW41RZG6c+Gm/2k78SjLKUSAXpNi+W+f4MRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6nm+kWYB1REE9qf95XirFejJZKIw/BsD47kSN5F6e1pDkZ+1uaAEnpZ0vlOcvKA0avmS4caYx2ApUBCx45D7pGuDUIPIstdslLd6xHhKLYZblcFXPWQRMbzRceF5RbI3HS2JCd/CmFWuHu1MdPg/xUJNWc/HJrbPOLXz3cCvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.149] (port=6700 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rpWPy-0004wZ-40;
	Wed, 27 Mar 2024 19:46:26 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1102.mail.hosting.nic.ru (Exim 5.55)
	with id 1rpWPy-005QOn-0Q;
	Wed, 27 Mar 2024 19:46:26 +0300
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
Subject: [PATCH v3] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
Date: Wed, 27 Mar 2024 19:46:13 +0300
Message-Id: <20240327164613.606851-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327163657.606414-1-kiryushin@ancud.ru>
References: 
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

Use snprintf() with buffer size instead of sprintf().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
v3: Fixed commit message
v2: Use snprintf() as
Steven Rostedt <rostedt@goodmis.org> suggested.
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 147b5945d67a..963ecae3c8e6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1994,7 +1994,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%lu h:%lu/%lu/%lu",
+	snprintf(buf, ARRAY_SIZE(buf), "N%lu h:%lu/%lu/%lu",
 		data_race(n_trc_holdouts),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
-- 
2.34.1


