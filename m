Return-Path: <linux-kernel+bounces-125542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68278927FC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD37283F88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725613E401;
	Fri, 29 Mar 2024 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz2rWwEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F8196
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756719; cv=none; b=MyqDEyp7Nfzge3i/m8s5iYg/dicOTj+MepiGVD1qVMh0YfLBEz/nuB1um365V7xUiuKf93rRt7tkNXsuZiMv6Is6w13q/ZHG4Q2ifJPFd43vsHLHFHRCmOUJJ2YiFJBBvbWpIKg3LJ6bZHspBi01uyIc0I4msCthmFo9Et+FAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756719; c=relaxed/simple;
	bh=cJaitjfY5WidVNtM7vvFrtqfN1QF2TDI+z/3GVbG1Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6Zv/pfWliBHyhVwf25dAp1W168h+lCWSb91HFF4pgJSQSbhyXCtfiex89Z5dq+P9eseDMehzbzEUurPf7x+kPHhaaFQaWJKFKYsyrErInixVtHpcY4jTHBubSKi9RmcdlbSBF7MYiHDpYmpUeMsh34NJ29SVRQ++4Rk97gdvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz2rWwEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899BAC433C7;
	Fri, 29 Mar 2024 23:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711756719;
	bh=cJaitjfY5WidVNtM7vvFrtqfN1QF2TDI+z/3GVbG1Pc=;
	h=From:To:Cc:Subject:Date:From;
	b=Xz2rWwEN+IOqbdKxzgSXLM9KdAddMeiT8mmdctMG1jwnJnh5RIlo5uRvd2xabkvkk
	 t+lLJ2oVJbllMXzyvHjH6XCEVVsdw4J2UxXWIreF2AVn3opvpO5JIUUIQhYzIMxh/q
	 z736jv9QxyU3a0C2iYTjEsJ7+8vPDnJjolDQ+Mc5S09ERJIMO9pe1dJsbrG/xVvtID
	 TyOA2CQU5uOyUHSPrNajwWS6vEKOLvuuH44fbpLeNfo4F5pe3stXoyUdhglfyiAi/F
	 xBvpoOEdjjNePjk6IvGXpqyKZJxu/YY6PSf1zZsgmVKEL8t7gZqvelzx7NaM5uJMmI
	 haj2ce8D2Rq4g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] perf: Fix leaked events when sigtrap = 1
Date: Sat, 30 Mar 2024 00:58:08 +0100
Message-ID: <20240329235812.18917-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking at task_work users I just noticed that perf doesn't flush
its own upon event exiting. This looks especially problematic with child
events. Please have a thourough look at the last patch, I may easily
have missed something within the maze.

Frederic Weisbecker (4):
  task_work: s/task_work_cancel()/task_work_cancel_func()/
  task_work: Introduce task_work_cancel() again
  perf: Fix event leak upon exit
  perf: Fix event leak upon exec and file release

 include/linux/perf_event.h |  1 +
 include/linux/task_work.h  |  3 ++-
 kernel/events/core.c       | 40 +++++++++++++++++++++++++++++++-------
 kernel/irq/manage.c        |  2 +-
 kernel/task_work.c         | 34 +++++++++++++++++++++++++++-----
 security/keys/keyctl.c     |  2 +-
 6 files changed, 67 insertions(+), 15 deletions(-)

-- 
2.44.0


