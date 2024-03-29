Return-Path: <linux-kernel+bounces-124073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334888911D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EBC28A63D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9FC381BB;
	Fri, 29 Mar 2024 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WX3C1GeV"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1338F82
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681360; cv=none; b=NzBI83s5w+LvcIKoSmcmpSMgvDjrPxP8U7yZSnskW6DtQwuOdiASIV95boLJzTG2GS8++cEAWDz4RsydidXj+zvDOBxGb4HHVIyHxwl1regZTFy+M60YDhcHlSjviktHiXL5ommO55YV6dUq3aro0wfu+9j4zHIkir+SaTRoMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681360; c=relaxed/simple;
	bh=AVLiTWMVC+4Q2njoACpxaoXX6UMM4Sch999y4awMC74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyW/YwLmsNV3aXNshhHVMcG4g4DILOqX1R2mwWoVniYTE5TB4ZcT4AffH4p18Em+oPDMpqOV+N9QPNhMCUunW9JRCKueVqk6GUlJxjrtewGr557ApS/1GnTi7pBVnI9OCNXWeQikCGTVGriptiportaBWIhNdDCjOMLHSpYkvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WX3C1GeV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1121169a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711681358; x=1712286158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8LIgarHXGmSLHXoyWS+pqzvYLXPMse1ux2PzNUEQYk=;
        b=WX3C1GeVl7D8DPbU/mFwbGv3c/G+WTNny4V3rQmSwBeFaUVJJhXsdWnXaP1fhFMiQ4
         vee+ofIse7rxwLhbixtj2NFpgfkDvunam8PvS5wonbdbxNyjTndTSFzeWF+GjY0c132Z
         iz5xa1krPtVEJdwOSaDYdF5JiKa3ZvvcuhshPmHRx1S/+6FUWQcYa9Fuy/06r3mIM87E
         JlITHhzbyB2cIGE9CkZka9sgecBQNKdQ4OzArGBzzJjEr954BJ52U/JuxsaxOO//qIB0
         45I+Ikbt2MhSC3oQyvMASpDCgroMp1RD4uMlyIEFz10GgXNtd2KSMnKzynzPhVSyrLf/
         Kx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711681358; x=1712286158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8LIgarHXGmSLHXoyWS+pqzvYLXPMse1ux2PzNUEQYk=;
        b=ban9ShKP+0WpwUpYOvSt/UBGGjuDR+mvU+7r8sAN55IsDZPnrI5mP323Dg7tgpAa/r
         FZHQE956eqOTNZpK20v3hPFHbH46khBHBMjyVn3N2an9ym+gnP47vj9NJqJGy65A7/mJ
         TH1RDFybBSujDQdfzC8voNxkVDPzd02jxZSCXNfugVHB7qdSOv+MOS7BnRCMzRilDXJp
         Qoq2iA7fDMMDv60zZ6Xh7QZToMvxv4pn8qAdukAk69xtrv/1bj6ihvENRxjov2v3wT0S
         uVnY9Oj4Gy9QuJDwp7f1Ue5U5dU9pm0lRDrNh0zfMm0iJMWSJvU/ZnOktXgeSnCNV+Kt
         Nm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTv7jpE1K/fvCH0uQ5WzifgEjziywJFoo1rdZb1NjzZJwzZI+3JVzKhlPpO9HlGhJNhYu2Ep1bVBoOpLF5W212BQ8SW5hcfve9XaGl
X-Gm-Message-State: AOJu0YxrcmHWTiGkfxJgPzFd+LlY+0JZ4okyASwc6XrsFsFmYwMpgvSr
	o8I3kXA0zNFK54kDFcUwxfmr81WpqdpVmToWI1BnH4Jz7hO7tIkuzMY1VZgTbmU=
X-Google-Smtp-Source: AGHT+IGHoYNfZbCBVG7PgWNIFZQrRb/CeyOLMx44grXw1IR4U9Ffs88bDVeL3pqpVUKoN+EVskMBbA==
X-Received: by 2002:a05:6a20:12ca:b0:1a5:6cc3:8fc9 with SMTP id v10-20020a056a2012ca00b001a56cc38fc9mr1088026pzg.43.1711681358140;
        Thu, 28 Mar 2024 20:02:38 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001dda32430b3sm2401890plg.89.2024.03.28.20.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 20:02:37 -0700 (PDT)
Message-ID: <2e44ae50-d4af-4788-9274-aaf345bac066@bytedance.com>
Date: Fri, 29 Mar 2024 11:02:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 1/2] perf sched timehist: Fix
 -g/--call-graph option failure
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328055857.383180-1-yangjihong@bytedance.com>
 <CAP-5=fXms1noWT8PXqBu89QogcwVsvAGpxq3Q_bNUYOYL7PpKA@mail.gmail.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <CAP-5=fXms1noWT8PXqBu89QogcwVsvAGpxq3Q_bNUYOYL7PpKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Sorry, due to the new email settings, the last reply email was in html 
format, resend it now.

On 3/29/24 00:02, Ian Rogers wrote:
> On Wed, Mar 27, 2024 at 10:59 PM Yang Jihong <yangjihong@bytedance.com> wrote:
>>
>> When perf-sched enables the call-graph recording, sample_type of dummy
>> event does not have PERF_SAMPLE_CALLCHAIN, timehist_check_attr() checks
>> that the evsel does not have a callchain, and set show_callchain to 0.
>>
>> Currently perf sched timehist only saves callchain when processing
>> sched:sched_switch event, timehist_check_attr() only needs to determine
>> whether the event has PERF_SAMPLE_CALLCHAIN.
>>
>> Before:
>>    # perf sched record -g true
>>    [ perf record: Woken up 0 times to write data ]
>>    [ perf record: Captured and wrote 4.153 MB perf.data (7536 samples) ]
>>    # perf sched timehist
>>    Samples do not have callchains.
>>               time    cpu  task name                       wait time  sch delay   run time
>>                            [tid/pid]                          (msec)     (msec)     (msec)
>>    --------------- ------  ------------------------------  ---------  ---------  ---------
>>      147851.826019 [0000]  perf[285035]                        0.000      0.000      0.000
>>      147851.826029 [0000]  migration/0[15]                     0.000      0.003      0.009
>>      147851.826063 [0001]  perf[285035]                        0.000      0.000      0.000
>>      147851.826069 [0001]  migration/1[21]                     0.000      0.003      0.006
>>    <SNIP>
>>
>> After:
>>    # perf sched record -g true
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 2.572 MB perf.data (822 samples) ]
>>    # perf sched timehist
>>               time    cpu  task name                       wait time  sch delay   run time
>>                            [tid/pid]                          (msec)     (msec)     (msec)
>>    --------------- ------  ------------------------------  ---------  ---------  ---------
>>      144193.035164 [0000]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
>>      144193.035174 [0000]  migration/0[15]                     0.000      0.003      0.009    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
>>      144193.035207 [0001]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
>>      144193.035214 [0001]  migration/1[21]                     0.000      0.003      0.007    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
>> <SNIP>
> 
> This looks good, should there be a Fixes tag for the sake of backports?
> 
The direct cause is commit 9c95e4ef0657 ("perf evlist: Add 
evlist__findnew_tracking_event() helper"). perf-record uses 
evlist__add_aux_dummy() to replace evlist__add_dummy() to add a dummy 
event. The difference is that evlist__add_aux_dummy() sets 
no_aux_samples to true (this is expected behavior, for dummy event, no 
need to sample aux data), resulting in evsel__config() not adding the 
PERF_SAMPLE_CALLCHAIN bit to dummy's sample_type.

In summary, the direct cause is the problem introduced by commit 
9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event() 
helper"), but the root cause is the timehist_check_attr() logic problem, 
The dummy event itself does not need to have PERF_SAMPLE_CALLCHAIN, so 
there is no need to check it.


So, maybe add fixes-tag:

Fixes: 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event() 
helper")

If it is ok, I will send v2 version with this fixes-tag.

Thanks,
Yang

