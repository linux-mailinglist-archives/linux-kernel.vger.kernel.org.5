Return-Path: <linux-kernel+bounces-54387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6D84AEA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587C2286BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE585128810;
	Tue,  6 Feb 2024 07:08:21 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7103D54A;
	Tue,  6 Feb 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203301; cv=none; b=PUKrIhzOJ1BjXI1K+yn01n0eOCrvkMNEwMTJE4UF7kIPzoKko32UnVZIHKP8xsifTSlC8LUA8bGNPiIaHKrCxy49oalDTTKoiSvRbKBMQyAm5mmgU0pPsZRHXZz/4GIzkEZ+QcHFy4Z28ILZd/L050uKNarqwHMfPCX7yC8YoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203301; c=relaxed/simple;
	bh=KeJ3vcGqkmCvMmwLJUf3uRoKdTBLPLdb/ZTxMTh81cw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BPrvfJpQ6Kt4U3xnoBz74e0P+U5HHyUIQ/4IaGMmRl1B82G2ZlJFKY8yLnvaxfDcBGWQ0SxixU73MGsBV/+Pwo3FiJqF84qpORXw/hKlY84e2aViRyQYsmqI9jxMel3wNUdLjBrwzpaABDuHZH2syzHIfxEbyCaKlJVLQdjUaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTZ7D2XPHz1xnJK;
	Tue,  6 Feb 2024 15:07:04 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BE3A18001A;
	Tue,  6 Feb 2024 15:08:10 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 15:08:09 +0800
Subject: Re: [PATCH 2/5] perf sched: Fix memory leak in perf_sched__map()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240205104616.132417-1-yangjihong1@huawei.com>
 <20240205104616.132417-3-yangjihong1@huawei.com> <ZcEv5BBvNEye4ZYf@x1>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <9909979e-3123-60a0-05e7-e770c705416e@huawei.com>
Date: Tue, 6 Feb 2024 15:08:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcEv5BBvNEye4ZYf@x1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Hello,

On 2024/2/6 2:58, Arnaldo Carvalho de Melo wrote:
> On Mon, Feb 05, 2024 at 10:46:13AM +0000, Yang Jihong wrote:
>> +++ b/tools/perf/builtin-sched.c
>> @@ -3267,20 +3264,34 @@ static int setup_color_cpus(struct perf_sched *sched)
>>   
>>   static int perf_sched__map(struct perf_sched *sched)
>>   {
>> +	int rc = -1;
>> +
>>   	if (setup_map_cpus(sched))
>> -		return -1;
>> +		return rc;
>>   
>>   	if (setup_color_pids(sched))
>> -		return -1;
>> +		goto out_free_map_cpus;
> 
> I think renaming the goto labels to what they will do, dropping a
> refcount, is more clear, i.e.:
> 
> 		goto out_put_map_cpus;
OK, will modify in v2.
> 
>>   
>>   	if (setup_color_cpus(sched))
>> -		return -1;
>> +		goto out_free_color_pids;
>>   
>>   	setup_pager();
>>   	if (perf_sched__read_events(sched))
>> -		return -1;
>> +		goto out_free_color_cpus;
>> +
>> +	rc = 0;
>>   	print_bad_events(sched);
>> -	return 0;
>> +
>> +out_free_color_cpus:
>> +	perf_cpu_map__put(sched->map.color_cpus);
>> +
>> +out_free_color_pids:
>> +	perf_thread_map__put(sched->map.color_pids);
>> +
>> +out_free_map_cpus:
>> +	free(sched->map.comp_cpus);
> 
> Please use:
> 
> 	zfree(&sched->map.comp_cpus);
> 
OK, will change to use zfree in the next version.
Other patches where uses free will also be changed to zfree.

Thanks,
Yang

