Return-Path: <linux-kernel+bounces-146029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C31F8A5F10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DC12836BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0E1E889;
	Tue, 16 Apr 2024 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="t3B185cF"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484515C0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225673; cv=none; b=Ri3++0Zno+w2IP0d15p43hmhk1CjdMG/1Gddh4VT/6ZRqJLKdhT1Agzjkra+jAtWJtsOb/ioKqlSH3sJmtgbK2lTRjORy6SoMtzdB7I+ed6mPAJ9tPt5u+to5lWgxtUGwFp/5i4uEC7MYlUR8WCBFIZr2B51VF6PNvu9pgs79mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225673; c=relaxed/simple;
	bh=5Pp+F26gUDUlbYuvQXzqlnuD1JxVTMq7zHueoLJOxbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnXDpIv+9/jZNKIW/uSA67rSKZnU7oZ2Uao3dPRqxrFbraT4QIhJPsM/ITcUfAUetY/NEolIdrELo0UURSC8EGq7j0M/ApWAn4/1MmJj0Vfj6riy4y0J4BfopzlOCzyUv4R/a9SnGb+M15ivOuw1d+vHS3p257Id0YjnCKbyLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=t3B185cF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d3907ff128so3055442a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713225671; x=1713830471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QB/Dlp+16K3ZTXeDMUHYiEk7otVsqSQx6ZlIKlzO1rU=;
        b=t3B185cFl5kIlwx5sglnZggt4ffo89BR+1S+rY9DZQXW6KCKMvyqy5DJidSTn4cntN
         8tT0I7MumKaTrXkqifsP+ljIB3rkPwAq9Vyp/7OJ2jwDmbOPWjEJBuoFohpjOKUFfs4T
         bqMXhptFXvcpWXTpvC6soF+7KBZymXmfonu0pEiBvUGhp6wFIe2FUoOMwlFNaNC8y6m7
         jNHRmtqRRLUZtaiBEA+4RZGr3eFSQT4l6ABj1h6o9OgTFhYf7fi+fZdF3Yd2B6QjUCTu
         BCoVJgvQVfRLfE0mGSDSCGcsC7ZwprkFd1ffr9xd8LR4Gk9/5qxB0G3R7dRbvHYujmVD
         ThIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713225671; x=1713830471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB/Dlp+16K3ZTXeDMUHYiEk7otVsqSQx6ZlIKlzO1rU=;
        b=Y8z2Wpm5WpT7IjOMm4v/HHZyajxtxLiw9aRIRgUDyZtNxm38rjKXiCHkvB6DO8nwF7
         mAM8Bz5C9gYt8aCrCKLsqSwU9ca2v8VIrpl2Vk6yshyVasXvfiq/UiTaD8vuIgLYRg5G
         a1KxXG3OLXB9rWwk28wPotsbQc2d4/wPodMC8b8aWJpZACcWA4kRoKu2vD46LDpVQuMm
         B4hHIZcfsas+iRaa9E7gZCNTtrcgjDei0LAZ18BD4++wxLnCZoawDsh9pCcqwtquOeeo
         uS655lxGHAOZfJkcBtEhRfk+EWcN6MyQBzmaT9WeSmJK9qyx8tuxUBypVA4p8xGQgyh2
         3XdA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Bf8g7ZUe5NoglA6r+IjfA5vqTsLAUqt6ayykCDpscepdNpN11XU91GqaUQJ6dxh9qAas5moaJWxK2a/KK5aL8OoGFpVgmC44gzSQ
X-Gm-Message-State: AOJu0YzzcCWcpbQ4l4J9KeHOmHxtFCsQAS5TKv6lwwvBfWXT7qo3C6DF
	a3YFhCrBFt6jcRmNI1Fq0vrfqEtYiYfMZ8D24clhLTLqfY8n61yJLSRMBwKbdiw=
X-Google-Smtp-Source: AGHT+IGhWTAkbV2FOVo1NbLZ0mVHcb3xv0J4DIYSqCL1XKTaYxUG/JyiWjuVXe6d3jRJ2NV6oNL8EQ==
X-Received: by 2002:a05:6a20:12c3:b0:1a9:40a1:a4e9 with SMTP id v3-20020a056a2012c300b001a940a1a4e9mr17127835pzg.3.1713225670904;
        Mon, 15 Apr 2024 17:01:10 -0700 (PDT)
Received: from [172.16.0.33] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id jm2-20020a17090304c200b001e7b7a7934bsm690419plb.107.2024.04.15.17.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 17:01:10 -0700 (PDT)
Message-ID: <a4c4c9f2-9fe1-4c22-a99c-1667481ddd6b@rivosinc.com>
Date: Mon, 15 Apr 2024 17:01:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Samuel Holland <samuel.holland@sifive.com>,
 Atish Patra <atishp@atishpatra.org>
Cc: Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240103165438.633054-1-samuel.holland@sifive.com>
 <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
 <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com>
Content-Language: en-US
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/24 18:40, Samuel Holland wrote:
> Hi Atish,
> 
> On 2024-03-18 2:44 PM, Atish Patra wrote:
>> On Wed, Jan 3, 2024 at 8:54 AM Samuel Holland <samuel.holland@sifive.com> wrote:
>>>
>>> The RISC-V SBI PMU specification defines several standard hardware and
>>> cache events. Currently, all of these events appear in the `perf list`
>>> output, even if they are not actually implemented. Add logic to check
>>> which events are supported by the hardware (i.e. can be mapped to some
>>> counter), so only usable events are reported to userspace.
>>>
>>
>> Thanks for the patch.
>> This adds tons of SBI calls at every boot for a use case which is at
>> best confusing for a subset of users who actually wants to run perf.
> 
> I should have been clearer in the patch description. This is not just a cosmetic
> change; because perf sees these as valid events, it tries to use them in
> commands like `perf stat`. When the error from SBI_EXT_PMU_COUNTER_CFG_MATCH
> causes the ->add() callback to fail, this prevents any other events from being
> scheduled on that same CPU (search can_add_hw in kernel/events/core.c). That is
> why the dTLB/iTLB miss counts are missing in the "before" example below.
> 

Thanks for explaining the problem. I can reproduce it in qemu as well if 
enough number of invalid events given on the command line and the 
workload is short enough.

>> This probing can be done at runtime by invoking the
>> pmu_sbi_check_event from pmu_sbi_event_map.
>> We can update the event map after that so that it doesn't need to
>> invoke pmu_sbi_check_event next time.
> 
> I tried to implement this suggestion, but it did not work. The SBI interface
> does not distinguish between "none of the counters can monitor the specified
> event [because the event is unsupported]" and "none of the counters can monitor
> the specified event [because the counters are busy]". It is not sufficient for
> the kernel to verify that at least one counter is available before performing
> the check, because certain events may only be usable on a subset of counters
> (per riscv,event-to-mhpmcounters), and the kernel does not know that mapping.
> 

Yeah. My suggestion was to fix the perf list issue which is different 
than the issue reported now.

> As a result, checking for event support is only reliable when none of the
> counters are in use. So the check can be asynchronous/deferred to later in the
> boot process, but I believe it still needs to be performed for all events before
> userspace starts using the counters.
> 

We should defer it a work queue for sure. We can also look at improving 
SBI PMU extension to support bulk matching behavior as well.

However, I think a better solution would be to just rely on the json 
file mappings instead of making SBI calls. We are going to have the 
event encoding and mappings in the json in the future.

I had added it only for platforms with counter delegation[1] but I think 
this can be generalized for platforms with SBI PMU as well.

I had some hacks to specify the legacy event encodings but Ian rogers 
improved with a generic support by preferring sysfs/json event encodings 
over fixed ones. I am yet to rebase and try Ian's series on top of the 
counter delegation though. Thoughts ?

[1] 
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
[2] 
https://lore.kernel.org/bpf/20240415063626.453987-2-irogers@google.com/T/


> Regards,
> Samuel
> 
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>> Before this patch:
>>> $ perf list hw
>>>
>>> List of pre-defined events (to be used in -e or -M):
>>>
>>>    branch-instructions OR branches                    [Hardware event]
>>>    branch-misses                                      [Hardware event]
>>>    bus-cycles                                         [Hardware event]
>>>    cache-misses                                       [Hardware event]
>>>    cache-references                                   [Hardware event]
>>>    cpu-cycles OR cycles                               [Hardware event]
>>>    instructions                                       [Hardware event]
>>>    ref-cycles                                         [Hardware event]
>>>    stalled-cycles-backend OR idle-cycles-backend      [Hardware event]
>>>    stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]
>>>
>>> $ perf stat -ddd true
>>>
>>>   Performance counter stats for 'true':
>>>
>>>                4.36 msec task-clock                       #    0.744 CPUs utilized
>>>                   1      context-switches                 #  229.325 /sec
>>>                   0      cpu-migrations                   #    0.000 /sec
>>>                  38      page-faults                      #    8.714 K/sec
>>>           4,375,694      cycles                           #    1.003 GHz                         (60.64%)
>>>             728,945      instructions                     #    0.17  insn per cycle
>>>              79,199      branches                         #   18.162 M/sec
>>>              17,709      branch-misses                    #   22.36% of all branches
>>>             181,734      L1-dcache-loads                  #   41.676 M/sec
>>>               5,547      L1-dcache-load-misses            #    3.05% of all L1-dcache accesses
>>>       <not counted>      LLC-loads                                                               (0.00%)
>>>       <not counted>      LLC-load-misses                                                         (0.00%)
>>>       <not counted>      L1-icache-loads                                                         (0.00%)
>>>       <not counted>      L1-icache-load-misses                                                   (0.00%)
>>>       <not counted>      dTLB-loads                                                              (0.00%)
>>>       <not counted>      dTLB-load-misses                                                        (0.00%)
>>>       <not counted>      iTLB-loads                                                              (0.00%)
>>>       <not counted>      iTLB-load-misses                                                        (0.00%)
>>>       <not counted>      L1-dcache-prefetches                                                    (0.00%)
>>>       <not counted>      L1-dcache-prefetch-misses                                               (0.00%)
>>>
>>>         0.005860375 seconds time elapsed
>>>
>>>         0.000000000 seconds user
>>>         0.010383000 seconds sys
>>>
>>> After this patch:
>>> $ perf list hw
>>>
>>> List of pre-defined events (to be used in -e or -M):
>>>
>>>    branch-instructions OR branches                    [Hardware event]
>>>    branch-misses                                      [Hardware event]
>>>    cache-misses                                       [Hardware event]
>>>    cache-references                                   [Hardware event]
>>>    cpu-cycles OR cycles                               [Hardware event]
>>>    instructions                                       [Hardware event]
>>>
>>> $ perf stat -ddd true
>>>
>>>   Performance counter stats for 'true':
>>>
>>>                5.16 msec task-clock                       #    0.848 CPUs utilized
>>>                   1      context-switches                 #  193.817 /sec
>>>                   0      cpu-migrations                   #    0.000 /sec
>>>                  37      page-faults                      #    7.171 K/sec
>>>           5,183,625      cycles                           #    1.005 GHz
>>>             961,696      instructions                     #    0.19  insn per cycle
>>>              85,853      branches                         #   16.640 M/sec
>>>              20,462      branch-misses                    #   23.83% of all branches
>>>             243,545      L1-dcache-loads                  #   47.203 M/sec
>>>               5,974      L1-dcache-load-misses            #    2.45% of all L1-dcache accesses
>>>     <not supported>      LLC-loads
>>>     <not supported>      LLC-load-misses
>>>     <not supported>      L1-icache-loads
>>>     <not supported>      L1-icache-load-misses
>>>     <not supported>      dTLB-loads
>>>              19,619      dTLB-load-misses
>>>     <not supported>      iTLB-loads
>>>               6,831      iTLB-load-misses
>>>     <not supported>      L1-dcache-prefetches
>>>     <not supported>      L1-dcache-prefetch-misses
>>>
>>>         0.006085625 seconds time elapsed
>>>
>>>         0.000000000 seconds user
>>>         0.013022000 seconds sys
>>>
>>>
>>>   drivers/perf/riscv_pmu_sbi.c | 37 ++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 35 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>>> index 16acd4dcdb96..b58a70ee8317 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -86,7 +86,7 @@ struct sbi_pmu_event_data {
>>>          };
>>>   };
>>>
>>> -static const struct sbi_pmu_event_data pmu_hw_event_map[] = {
>>> +static struct sbi_pmu_event_data pmu_hw_event_map[] = {
>>>          [PERF_COUNT_HW_CPU_CYCLES]              = {.hw_gen_event = {
>>>                                                          SBI_PMU_HW_CPU_CYCLES,
>>>                                                          SBI_PMU_EVENT_TYPE_HW, 0}},
>>> @@ -120,7 +120,7 @@ static const struct sbi_pmu_event_data pmu_hw_event_map[] = {
>>>   };
>>>
>>>   #define C(x) PERF_COUNT_HW_CACHE_##x
>>> -static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
>>> +static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
>>>   [PERF_COUNT_HW_CACHE_OP_MAX]
>>>   [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
>>>          [C(L1D)] = {
>>> @@ -265,6 +265,36 @@ static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_M
>>>          },
>>>   };
>>>
>>> +static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
>>> +{
>>> +       struct sbiret ret;
>>> +
>>> +       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
>>> +                       0, cmask, 0, edata->event_idx, 0, 0);
>>> +       if (!ret.error) {
>>> +               sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
>>> +                         ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>>> +       } else if (ret.error == SBI_ERR_NOT_SUPPORTED) {
>>> +               /* This event cannot be monitored by any counter */
>>> +               edata->event_idx = -EINVAL;
>>> +       }
>>> +}
>>> +
>>> +static void pmu_sbi_update_events(void)
>>> +{
>>> +       /* Ensure events are not already mapped to a counter */
>>> +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
>>> +                 0, cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>>> +
>>> +       for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
>>> +               pmu_sbi_check_event(&pmu_hw_event_map[i]);
>>> +
>>> +       for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
>>> +               for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++)
>>> +                       for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
>>> +                               pmu_sbi_check_event(&pmu_cache_event_map[i][j][k]);
>>> +}
>>> +
>>>   static int pmu_sbi_ctr_get_width(int idx)
>>>   {
>>>          return pmu_ctr_list[idx].width;
>>> @@ -1046,6 +1076,9 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>>          if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
>>>                  goto out_free;
>>>
>>> +       /* Check which standard events are available */
>>> +       pmu_sbi_update_events();
>>> +
>>>          ret = pmu_sbi_setup_irqs(pmu, pdev);
>>>          if (ret < 0) {
>>>                  pr_info("Perf sampling/filtering is not supported as sscof extension is not available\n");
>>> --
>>> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


