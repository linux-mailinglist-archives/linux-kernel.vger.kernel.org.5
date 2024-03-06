Return-Path: <linux-kernel+bounces-93368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A5872E97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038DBB22545
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B51BDCD;
	Wed,  6 Mar 2024 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2GzTKDX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FBA1BDCE;
	Wed,  6 Mar 2024 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709705405; cv=none; b=DO4MCFB6n3zfiRqk62KlrveaxAO+tJ6esNQGD+4aw0ncEd7rJuvjnpOzGMer+f36VB+CVx1ol0wjtaQoy4zx8lgRxSaWKXh0I9LjvMNEgngfD335wtcU9p9y/RyOqHyARo4wnBmDnxwNUjpUBZ4xKs/iTkqIVKlCoAVfsMIIM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709705405; c=relaxed/simple;
	bh=lSRRNskVPHhclRoV5Y6ztqZLrpHVOWF8T+IB8L5neFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgYGSVwwPr0f3iJPWfA/xR7SZ729O6BbYjlF+PgbEsMI1J9ParI/HyZZyazfwcD+GL8X4U79qKdZhpKVvHEs1IYom7EB0BJcaf7o6Bh2M6qx65nul+iDyYB7JVhLBMYrXqz85TpG1KaEgbj3C76zFoNCGyQlMNtWAgW7t2LKS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2GzTKDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E366FC433F1;
	Wed,  6 Mar 2024 06:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709705405;
	bh=lSRRNskVPHhclRoV5Y6ztqZLrpHVOWF8T+IB8L5neFM=;
	h=From:To:Cc:Subject:Date:From;
	b=N2GzTKDXkzvmqQZqFIP9B4dposW5RuAk23MxpT2SrgG/iNOcDGASuYAC7UiFa/IgS
	 gpQGZ7J1Bl6uX33NeSdJ/7qNloFEnFslI5PWN39e/x2hqABz+PfZV3uwJPNu47AAbA
	 tKEfnyNmIyDw9m8ogzaHsDerXRhAnNkQffLBIdN198FX0GiXi70NW0v2UtQhPyf9Aq
	 /lrW6kgBrIMvpLkAZNUwVLDeKjCyMLifxJ4likYyleTpKQck4gp85om2DwqiHiFcLN
	 nl1Yo2uKbvKKJOFWGlFz8RYuDKhbtJZLQ5Uw3K7rVcoHZRRK5Rz+0Z2hDmTDqfcFX2
	 CuY+xdOlyDg1g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] perf/x86: Fix out of range data
Date: Tue,  5 Mar 2024 22:10:03 -0800
Message-ID: <20240306061003.1894224-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86 each cpu_hw_events maintains a table for counter assignment but
it missed to update one for the deleted event in x86_pmu_del().  This
can make perf_clear_dirty_counters() reset used counter if it's called
before event scheduling or enabling.  Then it would return out of range
data which doesn't make sense.

The following code can reproduce the problem.

  $ cat repro.c
  #include <pthread.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <linux/perf_event.h>
  #include <sys/ioctl.h>
  #include <sys/mman.h>
  #include <sys/syscall.h>

  struct perf_event_attr attr = {
  	.type = PERF_TYPE_HARDWARE,
  	.config = PERF_COUNT_HW_CPU_CYCLES,
  	.disabled = 1,
  };

  void *worker(void *arg)
  {
  	int cpu = (long)arg;
  	int fd1 = syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0);
  	int fd2 = syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0);
  	void *p;

  	do {
  		ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
  		p = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd1, 0);
  		ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);

  		ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0);
  		munmap(p, 4096);
  		ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0);
  	} while (1);

  	return NULL;
  }

  int main(void)
  {
  	int i;
  	int n = sysconf(_SC_NPROCESSORS_ONLN);
  	pthread_t *th = calloc(n, sizeof(*th));

  	for (i = 0; i < n; i++)
  		pthread_create(&th[i], NULL, worker, (void *)(long)i);
  	for (i = 0; i < n; i++)
  		pthread_join(th[i], NULL);

  	free(th);
  	return 0;
  }

And you can see the out of range data using perf stat like this.
Probably it'd be easier to see on a large machine.

  $ gcc -o repro repro.c -pthread
  $ ./repro &
  $ sudo perf stat -A -I 1000 2>&1 | awk '{ if (length($3) > 15) print }'
       1.001028462 CPU6   196,719,295,683,763      cycles                           # 194290.996 GHz                       (71.54%)
       1.001028462 CPU3   396,077,485,787,730      branch-misses                    # 15804359784.80% of all branches      (71.07%)
       1.001028462 CPU17  197,608,350,727,877      branch-misses                    # 14594186554.56% of all branches      (71.22%)
       2.020064073 CPU4   198,372,472,612,140      cycles                           # 194681.113 GHz                       (70.95%)
       2.020064073 CPU6   199,419,277,896,696      cycles                           # 195720.007 GHz                       (70.57%)
       2.020064073 CPU20  198,147,174,025,639      cycles                           # 194474.654 GHz                       (71.03%)
       2.020064073 CPU20  198,421,240,580,145      stalled-cycles-frontend          #  100.14% frontend cycles idle        (70.93%)
       3.037443155 CPU4   197,382,689,923,416      cycles                           # 194043.065 GHz                       (71.30%)
       3.037443155 CPU20  196,324,797,879,414      cycles                           # 193003.773 GHz                       (71.69%)
       3.037443155 CPU5   197,679,956,608,205      stalled-cycles-backend           # 1315606428.66% backend cycles idle   (71.19%)
       3.037443155 CPU5   198,571,860,474,851      instructions                     # 13215422.58  insn per cycle

It should move the contents in the cpuc->assign as well.

Fixes: 5471eea5d3bf ("perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task")
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* add Kan's reviewed-by tag

 arch/x86/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 09050641ce5d..5b0dd07b1ef1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1644,6 +1644,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	while (++i < cpuc->n_events) {
 		cpuc->event_list[i-1] = cpuc->event_list[i];
 		cpuc->event_constraint[i-1] = cpuc->event_constraint[i];
+		cpuc->assign[i-1] = cpuc->assign[i];
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
-- 
2.44.0.278.ge034bb2e1d-goog


