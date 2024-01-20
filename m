Return-Path: <linux-kernel+bounces-31732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED54833316
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F82AB239CF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D765420FA;
	Sat, 20 Jan 2024 07:22:01 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BC5382;
	Sat, 20 Jan 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705735321; cv=none; b=jTRQwIObpPyxrnCDtszMegH1S+0UsmpwMfkckvelo7fjtFNfFUDoRa1RALM4FFK1zeyj+eQUYoxMt/gcfvKSYaFyRIvwQlJlNNIVaSk2MmYIn8mjhO4VWIKkQFzXRSfPXkh9gMPLESDjfeaIuL5jPt3RyojzrJWl1Mx7k0yN68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705735321; c=relaxed/simple;
	bh=/eBJiGEkA3mSsiCm5z/VMhJ9OA0Bpw+Qa9HPDflTNtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tT19aYXeMIvvkRGisqb3SP9SkMdVa1qSLUBI9RgfOriZft/fjVgJQB+BggvbuYZbxPEmQjn7AAz1HSgAZ1LxtSQC/pu2ZonQaHRJ1fOyv+/yqz3OSk9XYhW36V+PybPICoRTlLdHbdPDSYGTrMkeHKADSy8Z/e+pAG29GINo1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TH7DG0XBVz1gxct;
	Sat, 20 Jan 2024 15:20:14 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (unknown [7.185.36.180])
	by mail.maildlp.com (Postfix) with ESMTPS id 8695A1400D3;
	Sat, 20 Jan 2024 15:21:54 +0800 (CST)
Received: from [10.67.108.244] (10.67.108.244) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Jan 2024 15:21:54 +0800
Message-ID: <cc68c4f2-564a-4c42-942f-d45e71f3ef7f@huawei.com>
Date: Sat, 20 Jan 2024 15:21:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix small negative period being ignored
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>
References: <20240116083915.2859302-1-luogengkun2@huawei.com>
 <66cdc5f9-a09a-4841-8fca-252b7c78114b@intel.com>
From: Luo Gengkun <luogengkun2@huawei.com>
In-Reply-To: <66cdc5f9-a09a-4841-8fca-252b7c78114b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500019.china.huawei.com (7.185.36.180)



在 2024/1/19 15:36, Adrian Hunter 写道:
> On 16/01/24 10:39, Luo Gengkun wrote:
>> In perf_adjust_period, we will first calculate period, and then use
>> this period to calculate delta. However, when delta is less than 0,
>> there will be a deviation compared to when delta is greater than or
>> equal to 0. For example, when delta is in the range of [-14,-1], the
>> range of delta = delta + 7 is between [-7,6], so the final value of
>> delta/8 is 0. Therefore, the impact of -1 and -2 will be ignored.
>> This is unacceptable when the target period is very short, because
>> we will lose a lot of samples.
>>
>> Here are some tests and analyzes:
>> before:
>>    # perf record -e cs -F 1000  ./a.out
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.022 MB perf.data (518 samples) ]
>>
>>    # perf script
>>    ...
>>    a.out     396   257.956048:         23 cs:  ffffffff81f4eeec schedul>
>>    a.out     396   257.957891:         23 cs:  ffffffff81f4eeec schedul>
>>    a.out     396   257.959730:         23 cs:  ffffffff81f4eeec schedul>
>>    a.out     396   257.961545:         23 cs:  ffffffff81f4eeec schedul>
>>    a.out     396   257.963355:         23 cs:  ffffffff81f4eeec schedul>
>>    a.out     396   257.965163:         23 cs:  ffffffff81f4eeec schedul>
>>    a.out     396   257.966973:         23 cs:  ffffffff81f4eeec schedul>
>>    a.out     396   257.968785:         23 cs:  ffffffff81f4eeec schedul>
>>    a.out     396   257.970593:         23 cs:  ffffffff81f4eeec schedul>
>>    ...
>>
>> after:
>>    # perf record -e cs -F 1000  ./a.out
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.058 MB perf.data (1466 samples) ]
>>
>>    # perf script
>>    ...
>>    a.out     395    59.338813:         11 cs:  ffffffff81f4eeec schedul>
>>    a.out     395    59.339707:         12 cs:  ffffffff81f4eeec schedul>
>>    a.out     395    59.340682:         13 cs:  ffffffff81f4eeec schedul>
>>    a.out     395    59.341751:         13 cs:  ffffffff81f4eeec schedul>
>>    a.out     395    59.342799:         12 cs:  ffffffff81f4eeec schedul>
>>    a.out     395    59.343765:         11 cs:  ffffffff81f4eeec schedul>
>>    a.out     395    59.344651:         11 cs:  ffffffff81f4eeec schedul>
>>    a.out     395    59.345539:         12 cs:  ffffffff81f4eeec schedul>
>>    a.out     395    59.346502:         13 cs:  ffffffff81f4eeec schedul>
>>    ...
>>
>> test.c
>>
>> int main() {
>>          for (int i = 0; i < 20000; i++)
>>                  usleep(10);
>>
>>          return 0;
>> }
>>
>>    # time ./a.out
>>    real    0m1.583s
>>    user    0m0.040s
>>    sys     0m0.298s
>>
>> The above results were tested on x86-64 qemu with KVM enabled using
>> test.c as test program. Ideally, we should have around 1500 samples,
>> but the previous algorithm had only about 500, whereas the modified
>> algorithm now has about 1400. Further more, the new version shows 1
>> sample per 0.001s, while the previous one is 1 sample per 0.002s.This
>> indicates that the new algorithm is more sensitive to small negative
>> values compared to old algorithm.
>>
>> Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
>> Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
> 
> It seems better, and the maths makes sense, so:
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> 
> But the test case still seems to give unexpected results. Usually:
> 
>    # time taskset --cpu 1 ./test
>    real    0m 1.25s
>    user    0m 0.03s
>    sys     0m 0.00
>    # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.051 MB perf.data (1290 samples) ]
> 
> But occasionally:
> 
>    # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.010 MB perf.data (204 samples) ]
>    # perf script
>    ...
>    test   865   265.377846:         16 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.378900:         15 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.379845:         14 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.380770:         14 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.381647:         15 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.382638:         16 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.383647:         16 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.384704:         15 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.385649:         14 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.386578:        152 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.396383:        154 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.406183:        154 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.415839:        154 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.425445:        154 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.435052:        154 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.444708:        154 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.454314:        154 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.463970:        154 cs:  ffffffff832e927b schedule+0x2b
>    test   865   265.473577:        154 cs:  ffffffff832e927b schedule+0x2b
>    ...
> 
> 
> 
It seems that the unexpected results is caused by Timer Interrupts not 
coming every TICK_NSEC.

I guess this is due to system idleness. I tried the patch and it should 
have fixed the issue.

You can give it a try as well.

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h 
index afb028c54f33..2708f1d0692c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -265,6 +265,7 @@ struct hw_perf_event {
        * State for freq target events, see __perf_event_overflow() and
        * perf_adjust_freq_unthr_context().
        */
+    u64                freq_tick_stamp;
       u64                freq_time_stamp;
       u64                freq_count_stamp;
   #endif
diff --git a/kernel/events/core.c b/kernel/events/core.c index 
cad50d3439f1..fe0d9b470365 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4112,7 +4112,7 @@ perf_adjust_freq_unthr_context(struct
perf_event_context *ctx, bool unthrottle)
   {
       struct perf_event *event;
       struct hw_perf_event *hwc;
-    u64 now, period = TICK_NSEC;
+    u64 now, period, tick_stamp;
       s64 delta;

       /*
@@ -4151,6 +4151,10 @@ perf_adjust_freq_unthr_context(struct
perf_event_context *ctx, bool unthrottle)
            */
           event->pmu->stop(event, PERF_EF_UPDATE);

+        tick_stamp = perf_clock();
+        period = tick_stamp - hwc->freq_tick_stamp;
+        hwc->freq_tick_stamp = tick_stamp;
+
           now = local64_read(&event->count);
           delta = now - hwc->freq_count_stamp;
           hwc->freq_count_stamp = now;
@@ -4162,8 +4166,14 @@ perf_adjust_freq_unthr_context(struct
perf_event_context *ctx, bool unthrottle)
            * to perf_adjust_period() to avoid stopping it
            * twice.
            */
-        if (delta > 0)
-            perf_adjust_period(event, period, delta, false);
+        if (delta > 0) {
+            /*
+             * we skip first tick adjust period
+             */
+            if (likely(period != tick_stamp)) {
+                perf_adjust_period(event, period, delta, false);
+            }
+        }

           event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
       next:

>> ---
>>   kernel/events/core.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 683dc086ef10..cad50d3439f1 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4078,7 +4078,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>>   	period = perf_calculate_period(event, nsec, count);
>>   
>>   	delta = (s64)(period - hwc->sample_period);
>> -	delta = (delta + 7) / 8; /* low pass filter */
>> +	if (delta >= 0)
>> +		delta += 7;
>> +	else
>> +		delta -= 7;
>> +	delta /= 8; /* low pass filter */
>>   
>>   	sample_period = hwc->sample_period + delta;
>>   
> 

