Return-Path: <linux-kernel+bounces-167776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC98BAF07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FA71F21A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14058836;
	Fri,  3 May 2024 14:31:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877576FB8;
	Fri,  3 May 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746697; cv=none; b=e/EvlKw0bJ9txgS1So3HcXb8fFn/1TyaHJwhXkzOdK/DDwOEmE5VASNT7zNiJO94SdLl6rPkN+aaHM2r0esjKBodf/ASXRqLkeGbSerqZwfBebXO8mzwcUbVRTt5AILphyMlG5MwiP7fKpjmGspOU5+77NZ5RNHr7cgr+tpVbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746697; c=relaxed/simple;
	bh=pdlDifNfOWVyf0LbavLtSHKGdmUjQ1u1E01Vx1fRvKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6WHsHS/t1xFXOBzcHKN2CXPNm4LXoqK55JMQdlt7BGT7hDvSM90+5o3oF43RKLXzx5h/e8OFHuehf9YKD2crnBiY/Io0G9HGIzeAQRIZuKQANMcEdXgrxY93LWJpCMuGk4S05eNu7v36WjAaY5lNGEXXZC+KcqidCMk2Oh2WiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D57313D5;
	Fri,  3 May 2024 07:32:00 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B0B43F73F;
	Fri,  3 May 2024 07:31:31 -0700 (PDT)
Message-ID: <f40bd864-1c3d-49ab-b552-e9cd6ba92b3c@arm.com>
Date: Fri, 3 May 2024 15:31:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] coresight: Use per-sink trace ID maps for Perf
 sessions
To: Mike Leach <mike.leach@linaro.org>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
 scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
 suzuki.poulose@arm.com,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-16-james.clark@arm.com>
 <CAJ9a7VicoyFAh1m+0wcEdKan_whfXP6cb7GBZvBXCukfyugjgg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7VicoyFAh1m+0wcEdKan_whfXP6cb7GBZvBXCukfyugjgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/05/2024 10:43, Mike Leach wrote:
> Hi James
> 
> On Mon, 29 Apr 2024 at 16:25, James Clark <james.clark@arm.com> wrote:
>>
>> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
>> as long as there are fewer than that many ETMs connected to each sink.
>>
>> Each sink owns its own trace ID map, and any Perf session connecting to
>> that sink will allocate from it, even if the sink is currently in use by
>> other users. This is similar to the existing behavior where the dynamic
>> trace IDs are constant as long as there is any concurrent Perf session
>> active. It's not completely optimal because slightly more IDs will be
>> used than necessary, but the optimal solution involves tracking the PIDs
>> of each session and allocating ID maps based on the session owner. This
>> is difficult to do with the combination of per-thread and per-cpu modes
>> and some scheduling issues. The complexity of this isn't likely to worth
>> it because even with multiple users they'd just see a difference in the
>> ordering of ID allocations rather than hitting any limits (unless the
>> hardware does have too many ETMs connected to one sink).
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-core.c     | 10 ++++++++++
>>  drivers/hwtracing/coresight/coresight-etm-perf.c | 15 ++++++++-------
>>  include/linux/coresight.h                        |  1 +
>>  3 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index 9fc6f6b863e0..d1adff467670 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -902,6 +902,7 @@ static void coresight_device_release(struct device *dev)
>>         struct coresight_device *csdev = to_coresight_device(dev);
>>
>>         fwnode_handle_put(csdev->dev.fwnode);
>> +       free_percpu(csdev->perf_id_map.cpu_map);
>>         kfree(csdev);
>>  }
>>
>> @@ -1159,6 +1160,14 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>>         csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>>         dev_set_name(&csdev->dev, "%s", desc->name);
>>
>> +       if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>> +           csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
>> +               csdev->perf_id_map.cpu_map = alloc_percpu(atomic_t);
>> +               if (!csdev->perf_id_map.cpu_map) {
>> +                       ret = -ENOMEM;
>> +                       goto err_out;
>> +               }
>> +       }
>>         /*
>>          * Make sure the device registration and the connection fixup
>>          * are synchronised, so that we don't see uninitialised devices
>> @@ -1216,6 +1225,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>>  err_out:
>>         /* Cleanup the connection information */
>>         coresight_release_platform_data(NULL, desc->dev, desc->pdata);
>> +       kfree(csdev);
>>         return ERR_PTR(ret);
>>  }
>>  EXPORT_SYMBOL_GPL(coresight_register);
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 177cecae38d9..86ca1a9d09a7 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -229,10 +229,13 @@ static void free_event_data(struct work_struct *work)
>>                 struct list_head **ppath;
>>
>>                 ppath = etm_event_cpu_path_ptr(event_data, cpu);
>> -               if (!(IS_ERR_OR_NULL(*ppath)))
>> +               if (!(IS_ERR_OR_NULL(*ppath))) {
>> +                       struct coresight_device *sink = coresight_get_sink(*ppath);
>> +
>> +                       coresight_trace_id_put_cpu_id(cpu, &sink->perf_id_map);
>>                         coresight_release_path(*ppath);
>> +               }
>>                 *ppath = NULL;
>> -               coresight_trace_id_put_cpu_id(cpu, coresight_trace_id_map_default());
>>         }
>>
>>         /* mark perf event as done for trace id allocator */
>> @@ -401,8 +404,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>                 }
>>
>>                 /* ensure we can allocate a trace ID for this CPU */
>> -               trace_id = coresight_trace_id_get_cpu_id(cpu,
>> -                                                        coresight_trace_id_map_default());
>> +               trace_id = coresight_trace_id_get_cpu_id(cpu, &sink->perf_id_map);
>>                 if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>>                         cpumask_clear_cpu(cpu, mask);
>>                         coresight_release_path(path);
>> @@ -497,7 +499,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>>
>>         /* Finally enable the tracer */
>>         if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF,
>> -                                     coresight_trace_id_map_default()))
>> +                                     &sink->perf_id_map))
>>                 goto fail_disable_path;
>>
>>         /*
>> @@ -509,8 +511,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>>                 hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
>>                                    CS_AUX_HW_ID_CURR_VERSION);
>>                 hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
>> -                                   coresight_trace_id_read_cpu_id(cpu,
>> -                                               coresight_trace_id_map_default()));
>> +                                   coresight_trace_id_read_cpu_id(cpu, &sink->perf_id_map));
>>                 perf_report_aux_output_id(event, hw_id);
>>         }
>>
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index 3a678e5425dc..8c4c1860c76b 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -290,6 +290,7 @@ struct coresight_device {
>>         bool sysfs_sink_activated;
>>         struct dev_ext_attribute *ea;
>>         struct coresight_device *def_sink;
>> +       struct coresight_trace_id_map perf_id_map;
> 
> perhaps this should be sink_id_map? At some point sysfs may use is and
> naming is sink... is more consistent with other sink attributes in the
> structure.
> 

When we implement this for sysfs I was thinking sysfs would use its own
per-sink map. One reason is that the global map might be used if the
sink is in use by a system source (which allocate their IDs on probe).
Resulting in something like this:

  struct coresight_trace_id_map perf_id_map;
  struct coresight_trace_id_map sysfs_id_map;
  struct coresight_trace_id_map *sysfs_id_map_in_use;

syfs_id_map_in_use could either be &sysfs_id_map or
coresight_trace_id_map_default()

If sysfs did share the same map as Perf, the sink would have to have
some kind of mechanism of saving and restoring the mappings depending on
who was currently using the sink. At that point just storing two
versions of the mappings is easier. I believe there are some scenarios
for concurrent sysfs and Perf sessions that don't fail immediately, but
that one will get -EBUSY when trying to use the sink, until the other
session ends, at which point the other mappings need to be ready to use
immediately.

Also sysfs might either use the per-sink map or the global map depending
on the ordering of when the IDs were allocated or if a system source is
used at the same time, which means sysfs needs to use a reference to a map.

We could also change system sources so that they only allocate IDs when
the ID is read, rather than on probe. That might remove some of the
above issues, but maybe not all of them because you can always read the
ID before enabling the sink, at which point you have no choice but to
use the global map.

>>         /* sysfs links between components */
>>         int nr_links;
>>         bool has_conns_grp;
>> --
>> 2.34.1
>>
> 
> Mike
> 

