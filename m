Return-Path: <linux-kernel+bounces-148329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B29E8A8101
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A63EB225A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1913C3EA;
	Wed, 17 Apr 2024 10:32:21 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 45A9813173A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349940; cv=none; b=U/n2DSRfOSq2IOvImFKVMpSA095T92OihupdlMafMkgb3FDp50PaHLALfHnGtfrf4HHNENTg4AmiHTqd76xEFC+VL8A+7S433b5AKHLc/WT/PagoN/DapEjmh5MREAOb6FHbDpCqCOeUqTFM7yZlQ7iZgWyYEqiYZqyu4SWcD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349940; c=relaxed/simple;
	bh=hH1V+AE+YWCRoqcKWjtd8ekK6h5iWxEK1lCPmP0C6lQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P2NDFbFkQe7amK+9n9l3U6NId3KAk8TKsdA26xBQWTd4ymWwTjqu1UAjaUtX9vBhSU9/V6PpyDr6mb/7L1amVbxMFa3p0msxMXLXPs5a8Xzm1ZvmFw+itqI3HQIEylLrRJn66bXailwhDF1BN6qYlgOvnqz+UuqBQa3s3xiwqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 5EAD3183A913F8;
	Wed, 17 Apr 2024 18:29:06 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 18:29:06 +0800
Date: Wed, 17 Apr 2024 18:29:00 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: Tio Zhang <tiozhang@didiglobal.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<mathieu.desnoyers@efficios.com>, <tiozhang@didiglobal.com>,
	<zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>
Subject: [PATCH 1/1] tracing/sched: sched_switch: place prev_comm and
 next_comm in right order
Message-ID: <20240417102840.GA6614@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: rostedt@goodmis.org, mhiramat@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, zyhtheonly@gmail.com,
	zyhtheonly@yeah.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

Switch the order of prev_comm and next_comm in sched_switch's code to
align with its printing order.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 include/trace/events/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..a4bd4330db4c 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -239,11 +239,11 @@ TRACE_EVENT(sched_switch,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
-		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
-- 
2.17.1


