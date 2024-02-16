Return-Path: <linux-kernel+bounces-69382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA23D858846
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2082899B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54026146904;
	Fri, 16 Feb 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Fy/mAlLL"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520951420B8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120559; cv=none; b=J8BYL+VI95mCztrXZAEhyRPTD1WrPgxev5fNZV+0+QPVsmjnTr/zG4TMyOYYNnxygE7hbhdMJY9VrOMM4YaO3m2p2EC/itjfX8ZWxSnKdojvht9f20Py8r9Nv7jzE9L9d46EafCnQWvx0e3mBiJk0RiXMXRl0a+Fy6AV9mXZ2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120559; c=relaxed/simple;
	bh=MX75vgR6k4K8U4BRrCaF4Wpk12Wkgq/RzyxMwzDGcC8=;
	h=Date:Message-Id:Subject:MIME-Version:Content-Type:From:To:Cc; b=GkLSIu14DiR4moFV8H+30LNB6ohe3XQSlslRIMEsvPi3lF5cEXc4OEjxmrk6PRkKQQZEnQcWsKEvOEew8g/VNxx7xbS38nvGxYQTSkyZ1qMFrs1Z3y/7KTiufyvlQGndqo9g1zu1x0v0SlOYwcjHmw3L7M6yloxFMsU3iJjYAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=Fy/mAlLL; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4Tc5N2504yzBH;
	Fri, 16 Feb 2024 22:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1708120547; bh=MX75vgR6k4K8U4BRrCaF4Wpk12Wkgq/RzyxMwzDGcC8=;
	h=Date:Subject:From:To:Cc:From;
	b=Fy/mAlLL2gCGZfBrKKmnW81m53CXbRYbtvjQviBLDxkDPcvP4rckuYcrEZv6y0zcf
	 lHvQuOoy2hYoHhTxC4kuqYeOPPJMPVJ/LzUScwPEOeQIGTGtIqwskFaAhtPlKWWv4S
	 7QrIC4ghC9uLKQVEuqiK/4cyoXyrbzAKGLDx0e37XzRhC2iHqC0SHG59e3ACFIzMbp
	 87JBfVRC+Wq7/8kJ6HPxJ4HB9UK2Ju/7ux+4P4BmPcI8qC0FoSd0J9wNrh96l6s1Xg
	 DtQB9NbBXx9/irAgI5b9jEMCxyoDvE3VlvBAWAJSg1am3OBxE8cwuEKnU93qqB0b7h
	 uqcxjIRjVkezw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at mail
Date: Fri, 16 Feb 2024 22:55:46 +0100
Message-Id: <64955b50602fc64e2d3c7d4a92a1f9459e8c7ead.1708120036.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] sched/topology: loop properly when clearing flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Len Brown <len.brown@intel.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:	linux-kernel@vger.kernel.org

Fixed commit introduced sched_group::flags and a loop that was supposed
to clear groups' flags if the child sched_domain was deleted.  The
iterating part was missing.

Fixes: 16d364ba6ef2 ("sched/topology: Introduce sched_group::flags")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 kernel/sched/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..75b1a18783c2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -767,6 +767,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			 */
 			do {
 				sg->flags = 0;
+				sg = sg->next;
 			} while (sg != sd->groups);
 
 			sd->child = NULL;
-- 
2.39.2


