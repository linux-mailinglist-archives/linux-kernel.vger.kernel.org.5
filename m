Return-Path: <linux-kernel+bounces-139637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D993F8A059F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AE71C21632
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF160EC4;
	Thu, 11 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AlCUHoXY"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9428A320A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799627; cv=none; b=CbCz4fb7J+9fhGK1l9DMdLVVamu57n/W1Ks3tx3piCPtlyxxFD7XgEOR+Bgy7ef0Mb6y+knuDN3GnDmEPsK4AYhWY+Xa3VhFbB0hHq8P2coqYc/HTyJ6Q4VD678AaGjUN0tOZp2ygR+qugAxWiIRTAPTWja6BSsm+Byd//dPuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799627; c=relaxed/simple;
	bh=CPvCuTTA+acFRUsF2SHU83j4/+48UB2scVd8NBPBDZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KY+l6qgsnNFtShBY5QLaOz9FNPssk85VIYb5KyKHsF4ZPXnGaGluKeRzSJHBv6yFXxxGndJROk7LSUNQJqZ13xZJOWQl4igF5CfSMTby1Vb2iSXTb3oxqymf0LCLT64dxsIDHTUw2Q9Hj5UYiwq2FDZa3npz2L2Lm6PaPMHboIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AlCUHoXY; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6eabc1a7188so205209a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712799624; x=1713404424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXawy+afG4tJcP6uNM20MfnE3I+g3sphoIZHs/w8KSI=;
        b=AlCUHoXYpBI4Y45+j5/ay+AGqRZKRQeeOY7bh6KcTTMPu7IEO3pa1v1Wk4L2nALYHs
         KhZuUdqq7CmP/OpojTWOAmmgs13yoorsAWPmDI4UyFCt5Q+81sPHr6+ricMPjvCRgPt/
         BUZ1zmQU2ops5no72a7h/VOSDLTvPrTuhXMyMy+Yy3v+L126ZEp8xmrQPIExylCX660D
         TdceISqeEWjSoM536lmJHeK33Wnst6Cx/ZrKMXwB+dcgbKN+deVr5aUtTrYuslQFF8FR
         CTsaEObZF4pEgeiEzbfzr1Rm59FALf5VBZuTF8ov3uaatIJGoQA5DmpgMhiG8Ck5+N4O
         hgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712799624; x=1713404424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXawy+afG4tJcP6uNM20MfnE3I+g3sphoIZHs/w8KSI=;
        b=ivpS/Pgf+vGtGyJ3tb3p84/g3P1Qyfxh5ANb9lP/W1Cs/bZuDQF+gUniii0GezMZZy
         jnyPv+swlyVoylhRpHgd6u88zjwv6QprRUNYovN1BhKctK2yqJWlyA6gz4tckUf+cShp
         Lp2j9EeCjp5laN+BQKDEhl4XYO7VhZLU9W+D+BhG96CTfaum4lYDI1e9Suuw1Kfh/KdW
         /E6Ta1X1CUI1CTz+h+8K5Uw83oyceNoZs/NZk+Vy0u4SZY0WANczMPiXuJgujRqHhORg
         6JSl3NaeakWezr5kz2xWdz+jkVwPcjo0X533vH/vj55T7Of5xgdrDKrHCnyok0qV2GYI
         nFWg==
X-Forwarded-Encrypted: i=1; AJvYcCVQfci/DeiFxK/Ybo1WOSMrsDZO2YefRqWNPII5BXJFJgfSZ11XpXM82shzD6rxo3yVLQyh+lbz0sc7L/eCHRZxPUaSc4cDaCEuE9Qy
X-Gm-Message-State: AOJu0Ywc4uoLAQ1dM7uZ+jvfl9J11FrsF4/tdV5hoN2ianKr+XzfH+b/
	J5jX7GlNMLz3r++iQG2gErAFGWG8Dr7xY+i0kB0SGMOyybJy+nHAzyY2zU0vi4Q=
X-Google-Smtp-Source: AGHT+IFjNeVcDrnc4Qh78kmyJ5maYwHJWrOpdoUULOAa9qOLasAKru129S2LAI2XQbMQoqjVHYAGGw==
X-Received: by 2002:a9d:6216:0:b0:6ea:1205:2dc6 with SMTP id g22-20020a9d6216000000b006ea12052dc6mr3867509otj.34.1712799624485;
        Wed, 10 Apr 2024 18:40:24 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.167])
        by smtp.gmail.com with ESMTPSA id d13-20020a9d4f0d000000b006ea208300bcsm116643otl.55.2024.04.10.18.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 18:40:24 -0700 (PDT)
Message-ID: <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com>
Date: Wed, 10 Apr 2024 20:40:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Atish Patra <atishp@atishpatra.org>
Cc: Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240103165438.633054-1-samuel.holland@sifive.com>
 <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Atish,

On 2024-03-18 2:44 PM, Atish Patra wrote:
> On Wed, Jan 3, 2024 at 8:54 AM Samuel Holland <samuel.holland@sifive.com> wrote:
>>
>> The RISC-V SBI PMU specification defines several standard hardware and
>> cache events. Currently, all of these events appear in the `perf list`
>> output, even if they are not actually implemented. Add logic to check
>> which events are supported by the hardware (i.e. can be mapped to some
>> counter), so only usable events are reported to userspace.
>>
> 
> Thanks for the patch.
> This adds tons of SBI calls at every boot for a use case which is at
> best confusing for a subset of users who actually wants to run perf.

I should have been clearer in the patch description. This is not just a cosmetic
change; because perf sees these as valid events, it tries to use them in
commands like `perf stat`. When the error from SBI_EXT_PMU_COUNTER_CFG_MATCH
causes the ->add() callback to fail, this prevents any other events from being
scheduled on that same CPU (search can_add_hw in kernel/events/core.c). That is
why the dTLB/iTLB miss counts are missing in the "before" example below.

> This probing can be done at runtime by invoking the
> pmu_sbi_check_event from pmu_sbi_event_map.
> We can update the event map after that so that it doesn't need to
> invoke pmu_sbi_check_event next time.

I tried to implement this suggestion, but it did not work. The SBI interface
does not distinguish between "none of the counters can monitor the specified
event [because the event is unsupported]" and "none of the counters can monitor
the specified event [because the counters are busy]". It is not sufficient for
the kernel to verify that at least one counter is available before performing
the check, because certain events may only be usable on a subset of counters
(per riscv,event-to-mhpmcounters), and the kernel does not know that mapping.

As a result, checking for event support is only reliable when none of the
counters are in use. So the check can be asynchronous/deferred to later in the
boot process, but I believe it still needs to be performed for all events before
userspace starts using the counters.

Regards,
Samuel

>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>> Before this patch:
>> $ perf list hw
>>
>> List of pre-defined events (to be used in -e or -M):
>>
>>   branch-instructions OR branches                    [Hardware event]
>>   branch-misses                                      [Hardware event]
>>   bus-cycles                                         [Hardware event]
>>   cache-misses                                       [Hardware event]
>>   cache-references                                   [Hardware event]
>>   cpu-cycles OR cycles                               [Hardware event]
>>   instructions                                       [Hardware event]
>>   ref-cycles                                         [Hardware event]
>>   stalled-cycles-backend OR idle-cycles-backend      [Hardware event]
>>   stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]
>>
>> $ perf stat -ddd true
>>
>>  Performance counter stats for 'true':
>>
>>               4.36 msec task-clock                       #    0.744 CPUs utilized
>>                  1      context-switches                 #  229.325 /sec
>>                  0      cpu-migrations                   #    0.000 /sec
>>                 38      page-faults                      #    8.714 K/sec
>>          4,375,694      cycles                           #    1.003 GHz                         (60.64%)
>>            728,945      instructions                     #    0.17  insn per cycle
>>             79,199      branches                         #   18.162 M/sec
>>             17,709      branch-misses                    #   22.36% of all branches
>>            181,734      L1-dcache-loads                  #   41.676 M/sec
>>              5,547      L1-dcache-load-misses            #    3.05% of all L1-dcache accesses
>>      <not counted>      LLC-loads                                                               (0.00%)
>>      <not counted>      LLC-load-misses                                                         (0.00%)
>>      <not counted>      L1-icache-loads                                                         (0.00%)
>>      <not counted>      L1-icache-load-misses                                                   (0.00%)
>>      <not counted>      dTLB-loads                                                              (0.00%)
>>      <not counted>      dTLB-load-misses                                                        (0.00%)
>>      <not counted>      iTLB-loads                                                              (0.00%)
>>      <not counted>      iTLB-load-misses                                                        (0.00%)
>>      <not counted>      L1-dcache-prefetches                                                    (0.00%)
>>      <not counted>      L1-dcache-prefetch-misses                                               (0.00%)
>>
>>        0.005860375 seconds time elapsed
>>
>>        0.000000000 seconds user
>>        0.010383000 seconds sys
>>
>> After this patch:
>> $ perf list hw
>>
>> List of pre-defined events (to be used in -e or -M):
>>
>>   branch-instructions OR branches                    [Hardware event]
>>   branch-misses                                      [Hardware event]
>>   cache-misses                                       [Hardware event]
>>   cache-references                                   [Hardware event]
>>   cpu-cycles OR cycles                               [Hardware event]
>>   instructions                                       [Hardware event]
>>
>> $ perf stat -ddd true
>>
>>  Performance counter stats for 'true':
>>
>>               5.16 msec task-clock                       #    0.848 CPUs utilized
>>                  1      context-switches                 #  193.817 /sec
>>                  0      cpu-migrations                   #    0.000 /sec
>>                 37      page-faults                      #    7.171 K/sec
>>          5,183,625      cycles                           #    1.005 GHz
>>            961,696      instructions                     #    0.19  insn per cycle
>>             85,853      branches                         #   16.640 M/sec
>>             20,462      branch-misses                    #   23.83% of all branches
>>            243,545      L1-dcache-loads                  #   47.203 M/sec
>>              5,974      L1-dcache-load-misses            #    2.45% of all L1-dcache accesses
>>    <not supported>      LLC-loads
>>    <not supported>      LLC-load-misses
>>    <not supported>      L1-icache-loads
>>    <not supported>      L1-icache-load-misses
>>    <not supported>      dTLB-loads
>>             19,619      dTLB-load-misses
>>    <not supported>      iTLB-loads
>>              6,831      iTLB-load-misses
>>    <not supported>      L1-dcache-prefetches
>>    <not supported>      L1-dcache-prefetch-misses
>>
>>        0.006085625 seconds time elapsed
>>
>>        0.000000000 seconds user
>>        0.013022000 seconds sys
>>
>>
>>  drivers/perf/riscv_pmu_sbi.c | 37 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 16acd4dcdb96..b58a70ee8317 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -86,7 +86,7 @@ struct sbi_pmu_event_data {
>>         };
>>  };
>>
>> -static const struct sbi_pmu_event_data pmu_hw_event_map[] = {
>> +static struct sbi_pmu_event_data pmu_hw_event_map[] = {
>>         [PERF_COUNT_HW_CPU_CYCLES]              = {.hw_gen_event = {
>>                                                         SBI_PMU_HW_CPU_CYCLES,
>>                                                         SBI_PMU_EVENT_TYPE_HW, 0}},
>> @@ -120,7 +120,7 @@ static const struct sbi_pmu_event_data pmu_hw_event_map[] = {
>>  };
>>
>>  #define C(x) PERF_COUNT_HW_CACHE_##x
>> -static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
>> +static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
>>  [PERF_COUNT_HW_CACHE_OP_MAX]
>>  [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
>>         [C(L1D)] = {
>> @@ -265,6 +265,36 @@ static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_M
>>         },
>>  };
>>
>> +static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
>> +{
>> +       struct sbiret ret;
>> +
>> +       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
>> +                       0, cmask, 0, edata->event_idx, 0, 0);
>> +       if (!ret.error) {
>> +               sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
>> +                         ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>> +       } else if (ret.error == SBI_ERR_NOT_SUPPORTED) {
>> +               /* This event cannot be monitored by any counter */
>> +               edata->event_idx = -EINVAL;
>> +       }
>> +}
>> +
>> +static void pmu_sbi_update_events(void)
>> +{
>> +       /* Ensure events are not already mapped to a counter */
>> +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
>> +                 0, cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>> +
>> +       for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
>> +               pmu_sbi_check_event(&pmu_hw_event_map[i]);
>> +
>> +       for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
>> +               for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++)
>> +                       for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
>> +                               pmu_sbi_check_event(&pmu_cache_event_map[i][j][k]);
>> +}
>> +
>>  static int pmu_sbi_ctr_get_width(int idx)
>>  {
>>         return pmu_ctr_list[idx].width;
>> @@ -1046,6 +1076,9 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>         if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
>>                 goto out_free;
>>
>> +       /* Check which standard events are available */
>> +       pmu_sbi_update_events();
>> +
>>         ret = pmu_sbi_setup_irqs(pmu, pdev);
>>         if (ret < 0) {
>>                 pr_info("Perf sampling/filtering is not supported as sscof extension is not available\n");
>> --
>> 2.42.0


