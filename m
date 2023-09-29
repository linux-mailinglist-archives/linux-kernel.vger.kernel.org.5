Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA57B2DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjI2Ibk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjI2Ibf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:31:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B20FD1A8;
        Fri, 29 Sep 2023 01:31:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACBBA1FB;
        Fri, 29 Sep 2023 01:32:10 -0700 (PDT)
Received: from [10.57.93.169] (unknown [10.57.93.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 149023F5A1;
        Fri, 29 Sep 2023 01:31:29 -0700 (PDT)
Message-ID: <8a9a0d27-b714-a884-ae32-728cde21dddd@arm.com>
Date:   Fri, 29 Sep 2023 09:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 03/18] PM: EM: Find first CPU online while updating OPP
 efficiency
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-4-lukasz.luba@arm.com>
 <CAJZ5v0h6AsQCrtJ1b5VoWD_=yTKC=Y0e5KqSHy5GsFt-H7NFXA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0h6AsQCrtJ1b5VoWD_=yTKC=Y0e5KqSHy5GsFt-H7NFXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Thank you having reviewing those patches!

On 9/26/23 19:32, Rafael J. Wysocki wrote:
> On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Energy Model might be updated at runtime and the energy efficiency
>> for each OPP may change. Thus, there is a need to update also the
>> cpufreq framework and make it aligned to the new values. In order to
>> do that, use a first online CPU from the Performance Domain.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/power/energy_model.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 42486674b834..3dafdd7731c4 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>>          struct em_perf_domain *pd = dev->em_pd;
>>          struct cpufreq_policy *policy;
>>          int found = 0;
>> -       int i;
>> +       int i, cpu;
>>
>>          if (!_is_cpu_device(dev) || !pd)
>>                  return;
>>
>> -       policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
>> +       /* Try to get a CPU which is online and in this PD */
>> +       cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
> 
> The comment talks about "online" and cpu_active_mask is used.  Isn't
> it a bit inconsistent?

good point, I'll change the word to 'active'

> 
>> +       if (cpu >= nr_cpu_ids) {
>> +               dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
>> +               return;
>> +       }
>> +
>> +       policy = cpufreq_cpu_get(cpu);
>>          if (!policy) {
>>                  dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
>>                  return;
>> --
>> 2.25.1
>>
