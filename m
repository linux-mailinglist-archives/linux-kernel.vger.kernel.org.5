Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20A810D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjLMJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjLMJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:22:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE245B7;
        Wed, 13 Dec 2023 01:22:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C812EC15;
        Wed, 13 Dec 2023 01:23:01 -0800 (PST)
Received: from [10.57.85.168] (unknown [10.57.85.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E6E73F762;
        Wed, 13 Dec 2023 01:22:13 -0800 (PST)
Message-ID: <ec8dc77f-364c-443b-a63d-35a2e37d2ccc@arm.com>
Date:   Wed, 13 Dec 2023 09:23:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <d920867d-5572-48c3-bd54-b9e989ab6bd5@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <d920867d-5572-48c3-bd54-b9e989ab6bd5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

Thank you for the review, I will go one-by-one to respond
your comments in patches as well. First comments are below.

On 12/12/23 18:48, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set adds a new feature which allows to modify Energy Model (EM)
>> power values at runtime. It will allow to better reflect power model of
>> a recent SoCs and silicon. Different characteristics of the power usage
>> can be leveraged and thus better decisions made during task placement in EAS.
>>
>> It's part of feature set know as Dynamic Energy Model. It has been presented
>> and discussed recently at OSPM2023 [3]. This patch set implements the 1st
>> improvement for the EM.
>>
>> The concepts:
>> 1. The CPU power usage can vary due to the workload that it's running or due
>> to the temperature of the SoC. The same workload can use more power when the
>> temperature of the silicon has increased (e.g. due to hot GPU or ISP).
>> In such situation the EM can be adjusted and reflect the fact of increased
>> power usage. That power increase is due to static power
>> (sometimes called simply: leakage). The CPUs in recent SoCs are different.
>> We have heterogeneous SoCs with 3 (or even 4) different microarchitectures.
>> They are also built differently with High Performance (HP) cells or
>> Low Power (LP) cells. They are affected by the temperature increase
>> differently: HP cells have bigger leakage. The SW model can leverage that
>> knowledge.
>>
>> 2. It is also possible to change the EM to better reflect the currently
>> running workload. Usually the EM is derived from some average power values
>> taken from experiments with benchmark (e.g. Dhrystone). The model derived
>> from such scenario might not represent properly the workloads usually running
>> on the device. Therefore, runtime modification of the EM allows to switch to
>> a different model, when there is a need.
>>
>> 3. The EM can be adjusted after boot, when all the modules are loaded and
>> more information about the SoC is available e.g. chip binning. This would help
>> to better reflect the silicon characteristics. Thus, this EM modification
>> API allows it now. It wasn't possible in the past and the EM had to be
>> 'set in stone'.
>>
>> More detailed explanation and background can be found in presentations
>> during LPC2022 [1][2] or in the documentation patches.
>>
>> Some test results.
>> The EM can be updated to fit better the workload type. In the case below the EM
>> has been updated for the Jankbench test on Pixel6 (running v5.18 w/ mainline backports
>> for the scheduler bits). The Jankbench was run 10 times for those two configurations,
>> to get more reliable data.
>>
>> 1. Janky frames percentage
>> +--------+-----------------+---------------------+-------+-----------+
>> | metric |    variable     |       kernel        | value | perc_diff |
>> +--------+-----------------+---------------------+-------+-----------+
>> | gmean  | jank_percentage | EM_default          |  2.0  |   0.0%    |
>> | gmean  | jank_percentage | EM_modified_runtime |  1.3  |  -35.33%  |
>> +--------+-----------------+---------------------+-------+-----------+
>>
>> 2. Avg frame render time duration
>> +--------+---------------------+---------------------+-------+-----------+
>> | metric |      variable       |       kernel        | value | perc_diff |
>> +--------+---------------------+---------------------+-------+-----------+
>> | gmean  | mean_frame_duration | EM_default          | 10.5  |   0.0%    |
>> | gmean  | mean_frame_duration | EM_modified_runtime |  9.6  |  -8.52%   |
>> +--------+---------------------+---------------------+-------+-----------+
>>
>> 3. Max frame render time duration
>> +--------+--------------------+---------------------+-------+-----------+
>> | metric |      variable      |       kernel        | value | perc_diff |
>> +--------+--------------------+---------------------+-------+-----------+
>> | gmean  | max_frame_duration | EM_default          | 251.6 |   0.0%    |
>> | gmean  | max_frame_duration | EM_modified_runtime | 115.5 |  -54.09%  |
>> +--------+--------------------+---------------------+-------+-----------+
>>
>> 4. OS overutilized state percentage (when EAS is not working)
>> +--------------+---------------------+------+------------+------------+
>> |    metric    |       wa_path       | time | total_time | percentage |
>> +--------------+---------------------+------+------------+------------+
>> | overutilized | EM_default          | 1.65 |   253.38   |    0.65    |
>> | overutilized | EM_modified_runtime | 1.4  |   277.5    |    0.51    |
>> +--------------+---------------------+------+------------+------------+
>>
>> 5. All CPUs (Little+Mid+Big) power values in mW
>> +------------+--------+---------------------+-------+-----------+
>> |  channel   | metric |       kernel        | value | perc_diff |
>> +------------+--------+---------------------+-------+-----------+
>> |    CPU     | gmean  | EM_default          | 142.1 |   0.0%    |
>> |    CPU     | gmean  | EM_modified_runtime | 131.8 |  -7.27%   |
>> +------------+--------+---------------------+-------+-----------+
>>
>> The time cost to update the EM decreased in this v5 vs v4:
>> big: 5us vs 2us -> 2.6x faster
>> mid: 9us vs 3us -> 3x faster
>> little: 16us vs 16us -> no change
> 
> I guess this is entirely due to the changes in
> em_dev_update_perf_domain()? Moving from per-OPP em_update_callback to
> switching the entire table (pd->runtime_table) inside
> em_dev_update_perf_domain()?

Yes correct, it's due to that design change.

> 
>> We still have to update the inefficiency in the cpufreq framework, thus
>> a bit of overhead will be there.
>>
>> Changelog:
>> v5:
>> - removed 2 tables design
>> - have only one table (runtime_table) used also in thermal (Wei, Rafael)
> 
> Until v4 you had 2 EM's, the static and the modifiable (runtime). Now in
> v5 this changed to only have one, the modifiable. IMHO it would be
> better to change the existing table to be modifiable rather than staring
> with two EM's and then removing the static one. I assume you end up with
> way less code changes and the patch-set will become easier to digest for
> reviewers.

The patches are structured in this way following Daniel's recommendation
I got when I was adding similar big changes to EM in 2020 (support all
devices in kernel). The approach is as follows:
0. Do some basic clean-up/refactoring if needed for a new feature, to
    re-use some code if possible in future
1. Introduce new feature next to the existing one
2. Add API and all needed infrastructure (structures, fields) for
    drivers
3. Re-wire the existing drivers/frameworks to the new feature via new
    API; ideally keep 1 patch per driver so the maintainer can easily
    grasp the changes and ACK it, because it will go via different tree
    (Rafael's tree); in case of some code clash in the driver's code
    during merge - it will be a single driver so easier to handle
4. when all drivers and frameworks are wired up with the new feature
    remove the old feature (structures, fields, APIs, etc)
5. Update the documentation with new latest state of desing

In this approach the patches are less convoluted. Because if I remove
the old feature and add new in a single patch (e.g. the main structure)
that patch will have to modify all drivers to still compile. It
would be a big messy patch for this re-design.

I can see in some later comment from Rafael that he is OK with current
patch set structure.

> 
> I would mention that 14/23 "PM: EM: Support late CPUs booting and
> capacity adjustment" is a testcase for the modifiable EM build-in into
> the code changes. This relies on the table being modifiable.
> 

Correct, that the 1st user on runtime modifiable EM, which is actually
also build-in. I could add that to the cover letter.

Regards,
Lukasz
