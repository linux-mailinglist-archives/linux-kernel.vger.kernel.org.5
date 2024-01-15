Return-Path: <linux-kernel+bounces-26287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0D82DE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FC41F22A37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD318046;
	Mon, 15 Jan 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM57N1Ez"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DB18027
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705338097; x=1736874097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rDlcveJOd/QxYfdylxHGM+KIbu+7YyGNcC1nda6F/iw=;
  b=aM57N1Eze0zbGuhan2KsgmvcXVwyYiXCFEdnFhCw/Pax4p6I6tMC2O2O
   qWMrq5O7dA9lwuCIW1QP0QvTx3Xn0WAmdCxw0DNZVeCqejDh8U9nnsxPS
   gk8ZJOzN1CEf3P4vhIumtpglnoW1jiFhpjLf3FLA8V4fxU7pPjc8GW6Mj
   evERt0Ol69SU00KYNHsape+jIPTLN9RcW53Tozic7CNlGf95ij/dEVi3J
   2w1G9J5nyfZxlJD04uUHaPH0hDT9md5gukvYz5y5OKTs3B4Qi1QRiKpiT
   727QoUsjIIYfN1k/f/S5WcBlVyWiHceSEbsaF3vW4ij7kJ4VQuL/SEIh4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6408196"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="6408196"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="907101324"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="907101324"
Received: from mleonvig-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.223.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:01:31 -0800
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	tvrtko.ursulin@linux.intel.com
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Subject: [RFC 1/3] perf: Add new late event free callback
Date: Mon, 15 Jan 2024 17:01:18 +0000
Message-Id: <20240115170120.662220-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240115170120.662220-1-tvrtko.ursulin@linux.intel.com>
References: <20240115170120.662220-1-tvrtko.ursulin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

This allows drivers to implement a PMU with support for unbinding the
device, for example by making event->pmu reference counted on the driver
side and its lifetime matching the struct perf_event init/free.

Otherwise, if an open perf fd is kept past driver unbind, the perf code
can dereference the potentially freed struct pmu from the _free_event
steps which follow the existing destroy callback.

TODO/FIXME/QQQ:

A simpler version could be to simply move the ->destroy() callback to
later in _free_event(). However a comment there claims there are steps
which need to run after the existing destroy callbacks, hence I opted for
an initially cautious approach.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5547ba68e6e4..a567d2d98be1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -799,6 +799,7 @@ struct perf_event {
 	struct perf_event		*aux_event;
 
 	void (*destroy)(struct perf_event *);
+	void (*free)(struct perf_event *);
 	struct rcu_head			rcu_head;
 
 	struct pid_namespace		*ns;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a64165af45c1..4b62d2201ca7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5242,6 +5242,9 @@ static void _free_event(struct perf_event *event)
 	exclusive_event_destroy(event);
 	module_put(event->pmu->module);
 
+	if (event->free)
+		event->free(event);
+
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
 
@@ -11662,8 +11665,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		    event_has_any_exclude_flag(event))
 			ret = -EINVAL;
 
-		if (ret && event->destroy)
-			event->destroy(event);
+		if (ret) {
+			if (event->destroy)
+				event->destroy(event);
+			if (event->free)
+				event->free(event);
+		}
 	}
 
 	if (ret)
@@ -12090,6 +12097,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		perf_detach_cgroup(event);
 	if (event->destroy)
 		event->destroy(event);
+	if (event->free)
+		event->free(event);
 	module_put(pmu->module);
 err_ns:
 	if (event->hw.target)
-- 
2.40.1


