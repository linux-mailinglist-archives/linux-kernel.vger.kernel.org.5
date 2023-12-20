Return-Path: <linux-kernel+bounces-7224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4F81A36D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5596EB25EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56D46B9B;
	Wed, 20 Dec 2023 15:59:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF6745C09;
	Wed, 20 Dec 2023 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77D261FB;
	Wed, 20 Dec 2023 07:59:49 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C9C23F64C;
	Wed, 20 Dec 2023 07:59:02 -0800 (PST)
Message-ID: <e80f75ea-99e9-e4d2-6477-443e521ef90a@arm.com>
Date: Wed, 20 Dec 2023 15:59:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: James Clark <james.clark@arm.com>
Subject: Re: [PATCH RFC V3 4/4] coresight: Have a stab at support for pause /
 resume
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Yicong Yang
 <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20231208172449.35444-5-adrian.hunter@intel.com>
 <20231215064242.36251-1-adrian.hunter@intel.com>
Content-Language: en-US
In-Reply-To: <20231215064242.36251-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/12/2023 06:42, Adrian Hunter wrote:
> For discussion only, un-tested...
> 

If anyone wants to test Coresight, the diff below is required to get the
most basic use case working. It also probably needs more thought and
some edge case handling:

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 596c01e37624..bd0767356277 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -556,7 +556,8 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct etm_event_data *event_data;
 	struct list_head *path;
 
-	if (mode & PERF_EF_PAUSE && !READ_ONCE(ctxt->pr_allowed))
+	if ((mode & PERF_EF_PAUSE && !READ_ONCE(ctxt->pr_allowed)) ||
+	    event->hw.state == PERF_HES_STOPPED)
 		return;
 
 	WRITE_ONCE(ctxt->pr_allowed, 0);
@@ -573,9 +574,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	/* Clear the event_data as this ETM is stopping the trace. */
 	ctxt->event_data = NULL;
 
-	if (event->hw.state == PERF_HES_STOPPED)
-		goto out_pr_allowed;
-
 	/* We must have a valid event_data for a running event */
 	if (WARN_ON(!event_data))
 		return;
@@ -586,7 +584,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	 * nothing needs to be torn down other than outputting a
 	 * zero sized record.
 	 */
-	if (handle->event && (mode & PERF_EF_UPDATE) &&
+	if (handle->event && (mode & (PERF_EF_UPDATE | PERF_EF_PAUSE)) &&
 	    !cpumask_test_cpu(cpu, &event_data->mask)) {
 		event->hw.state = PERF_HES_STOPPED;
 		perf_aux_output_end(handle, 0);
@@ -616,7 +614,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	 * handle due to lack of buffer space), we don't
 	 * have to do anything here.
 	 */
-	if (handle->event && (mode & PERF_EF_UPDATE)) {
+	if (handle->event && (mode & (PERF_EF_UPDATE | PERF_EF_PAUSE))) {
 		if (WARN_ON_ONCE(handle->event != event))
 			return;
 
@@ -646,7 +644,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	/* Disabling the path make its elements available to other sessions */
 	coresight_disable_path(path);
 
-out_pr_allowed:
 	if (mode & PERF_EF_PAUSE)
 		WRITE_ONCE(ctxt->pr_allowed, 1);
 }
@@ -656,7 +653,7 @@ static int etm_event_add(struct perf_event *event, int mode)
 	int ret = 0;
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (mode & PERF_EF_START && !READ_ONCE(event->aux_paused)) {
+	if (mode & PERF_EF_START) {
 		etm_event_start(event, 0);
 		if (hwc->state & PERF_HES_STOPPED)
 			ret = -EINVAL;
-- 
2.34.1


