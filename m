Return-Path: <linux-kernel+bounces-2179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0739381590E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398581C2178C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C860018EB7;
	Sat, 16 Dec 2023 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIadpSFt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC018EB1;
	Sat, 16 Dec 2023 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702730569; x=1734266569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h3m09+4KjTj3d57m3tEhG5HBvKHUIukfDwoLjjYG9vk=;
  b=FIadpSFtrrNLguSDwCfMnOBE3a++Ibqi8Rjm7ETQ7LFVDxHBoxFy4p+4
   mc9xSmjQvLf8YB+ourb6rWnFm+N72ooHU8XbSygmyRYsMNHpKuAwcAT8F
   eFD7DYswHTUYuO0fBWK7yvSVh2YbGwRv6fYN6ZOIWLmjGP/HrDUrTKP/Y
   Ad6YLa6itVFz/T2kVOU72QRXVhIUM6fzblYoq82BaXi5e7sRGD+onK6xF
   fAdI8Vgv/dUBQz0CoIDBZPYf9U1AHjH34BEgYXG+lsDN1P9uQxo/DQ94t
   IsHwcM7qLVYUdewaGURJhsg8NNL06U4loqthG1vuR08oo3w70IomJGr84
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2553231"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="2553231"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 04:42:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="768306234"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="768306234"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 04:42:48 -0800
Received: from [10.209.139.210] (kliang2-mobl1.ccr.corp.intel.com [10.209.139.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id EF95A580BE1;
	Sat, 16 Dec 2023 04:42:46 -0800 (PST)
Message-ID: <ae648bc4-b32c-4b15-8dfc-9dbd481bb927@linux.intel.com>
Date: Sat, 16 Dec 2023 07:42:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Fix out of range data
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 stable@vger.kernel.org
References: <20231216072830.1009339-1-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231216072830.1009339-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-16 2:28 a.m., Namhyung Kim wrote:
> On x86 each cpu_hw_events maintains a table for counter assignment but
> it missed to update one for the deleted event in x86_pmu_del().  This
> can make perf_clear_dirty_counters() reset used counter if it's called
> before event scheduling or enabling.  Then it would return out of range
> data which doesn't make sense.
> 
> The following code can reproduce the problem.
> 
>   $ cat repro.c
>   #include <pthread.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <linux/perf_event.h>
>   #include <sys/ioctl.h>
>   #include <sys/mman.h>
>   #include <sys/syscall.h>
> 
>   struct perf_event_attr attr = {
>   	.type = PERF_TYPE_HARDWARE,
>   	.config = PERF_COUNT_HW_CPU_CYCLES,
>   	.disabled = 1,
>   };
> 
>   void *worker(void *arg)
>   {
>   	int cpu = (long)arg;
>   	int fd1 = syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0);
>   	int fd2 = syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0);
>   	void *p;
> 
>   	do {
>   		ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
>   		p = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd1, 0);
>   		ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);
> 
>   		ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0);
>   		munmap(p, 4096);
>   		ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0);
>   	} while (1);
> 
>   	return NULL;
>   }
> 
>   int main(void)
>   {
>   	int i;
>   	int n = sysconf(_SC_NPROCESSORS_ONLN);
>   	pthread_t *th = calloc(n, sizeof(*th));
> 
>   	for (i = 0; i < n; i++)
>   		pthread_create(&th[i], NULL, worker, (void *)(long)i);
>   	for (i = 0; i < n; i++)
>   		pthread_join(th[i], NULL);
> 
>   	free(th);
>   	return 0;
>   }
> 
> And you can see the out of range data using perf stat like this.
> Probably it'd be easier to see on a large machine.
> 
>   $ gcc -o repro repro.c -pthread
>   $ ./repro &
>   $ sudo perf stat -A -I 1000 2>&1 | awk '{ if (length($3) > 15) print }'
>        1.001028462 CPU6   196,719,295,683,763      cycles                           # 194290.996 GHz                       (71.54%)
>        1.001028462 CPU3   396,077,485,787,730      branch-misses                    # 15804359784.80% of all branches      (71.07%)
>        1.001028462 CPU17  197,608,350,727,877      branch-misses                    # 14594186554.56% of all branches      (71.22%)
>        2.020064073 CPU4   198,372,472,612,140      cycles                           # 194681.113 GHz                       (70.95%)
>        2.020064073 CPU6   199,419,277,896,696      cycles                           # 195720.007 GHz                       (70.57%)
>        2.020064073 CPU20  198,147,174,025,639      cycles                           # 194474.654 GHz                       (71.03%)
>        2.020064073 CPU20  198,421,240,580,145      stalled-cycles-frontend          #  100.14% frontend cycles idle        (70.93%)
>        3.037443155 CPU4   197,382,689,923,416      cycles                           # 194043.065 GHz                       (71.30%)
>        3.037443155 CPU20  196,324,797,879,414      cycles                           # 193003.773 GHz                       (71.69%)
>        3.037443155 CPU5   197,679,956,608,205      stalled-cycles-backend           # 1315606428.66% backend cycles idle   (71.19%)
>        3.037443155 CPU5   198,571,860,474,851      instructions                     # 13215422.58  insn per cycle
> 
> It should move the contents in the cpuc->assign as well.

Yes, the patch looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> 
> Fixes: 5471eea5d3bf ("perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task")
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/x86/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 09050641ce5d..5b0dd07b1ef1 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1644,6 +1644,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>  	while (++i < cpuc->n_events) {
>  		cpuc->event_list[i-1] = cpuc->event_list[i];
>  		cpuc->event_constraint[i-1] = cpuc->event_constraint[i];
> +		cpuc->assign[i-1] = cpuc->assign[i];
>  	}
>  	cpuc->event_constraint[i-1] = NULL;
>  	--cpuc->n_events;

