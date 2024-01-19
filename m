Return-Path: <linux-kernel+bounces-31371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7ED832D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD391F25966
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3533E55766;
	Fri, 19 Jan 2024 16:39:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E85155785;
	Fri, 19 Jan 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682396; cv=none; b=t99A5ywsr6Qo/P8SEzzI1znxozmMDmdOVMAAXB6TDRAMfveTtY7FlAKdmKbBXGVWocnZTKwNUftCMSCZ274RpDHy4UqLYc1U7akrryEFcVAGle6fD5wKTDawzCoR9NYq8VEJOCoyMn14YyiErPdyut07G9pRYdC/yB+3IXxeol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682396; c=relaxed/simple;
	bh=lBmSUPtkwtCMjZIkdsZPZkuixbOXHdWTZ6M2mQb6yPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH2oJFuXL4kzx1N/HOuYXjF4+9hA34plqLH2p8aoElIB2z/nJZKeGtVkD1EFrdzTep//iaRwn8EXSQWyIlZqKsAMLhoeZGMKCrg9PG1sOyfJTstBVl/hbmSABhPx3yu9O6yZZdPB8q6znOkybrT/m2XauFy1JIa9WXZimleW2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC8D311FB;
	Fri, 19 Jan 2024 08:40:38 -0800 (PST)
Received: from e126817.. (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 168413F73F;
	Fri, 19 Jan 2024 08:39:49 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@arm.com,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH 1/1] perf: Support PERF_SAMPLE_READ with inherit_stat
Date: Fri, 19 Jan 2024 16:39:24 +0000
Message-ID: <20240119163924.2801678-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119163924.2801678-1-ben.gainey@arm.com>
References: <20240119163924.2801678-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows events to use PERF_SAMPLE READ with inherit
so long as both inherit_stat and PERF_SAMPLE_TID are set.

In this configuration, and event will be inherited into any
child processes / threads, allowing convenient profiling of a
multi-process or multi-threaded application, whilst allowing
profiling tools to collect per-thread samples, in particular
of groups of counters.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 kernel/events/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9efd0d7775e7c..4b603463d888f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11988,10 +11988,13 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	local64_set(&hwc->period_left, hwc->sample_period);
 
 	/*
-	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * We do not support PERF_SAMPLE_READ on inherited events unless
+	 * inherit_stat and PERF_SAMPLE_TID are also selected, which allows
+	 * inherited events to collect per-thread samples.
 	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
+	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)
+		&& !(attr->inherit_stat && (attr->sample_type & PERF_SAMPLE_TID)))
 		goto err_ns;
 
 	if (!has_branch_stack(event))
-- 
2.43.0


