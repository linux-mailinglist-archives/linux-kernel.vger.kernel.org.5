Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56BF7A5B95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjISHuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjISHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:50:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66921FC;
        Tue, 19 Sep 2023 00:49:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448081FB;
        Tue, 19 Sep 2023 00:50:34 -0700 (PDT)
Received: from [10.57.92.124] (unknown [10.57.92.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47D083F59C;
        Tue, 19 Sep 2023 00:49:55 -0700 (PDT)
Message-ID: <e25d912a-906d-82da-5b09-f2256ebfbfe3@arm.com>
Date:   Tue, 19 Sep 2023 09:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, vschneid@redhat.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
References: <20230918112937.493352-1-pierre.gondois@arm.com>
 <ebc8f4cd-1ac6-e7c8-8e20-53bca964ce56@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ebc8f4cd-1ac6-e7c8-8e20-53bca964ce56@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/23 01:03, Dietmar Eggemann wrote:
> On 18/09/2023 13:29, Pierre Gondois wrote:
>> The Energy Aware Scheduler (EAS) relies on the schedutil governor.
>> When moving to/from the schedutil governor, sched domains must be
>> rebuilt to allow re-evaluating the enablement conditions of EAS.
>> This is done through sched_cpufreq_governor_change().
>>
>> Having a cpufreq governor assumes having a cpufreq driver running.
>> Inserting/removing a cpufreq driver should trigger a re-evaluation
>> of EAS enablement conditions, avoiding to see EAS enabled when
>> removing a running cpufreq driver.
>>
>> Add a sched_cpufreq_governor_change() call in cpufreq driver removal
>> path.
> 
> Rebuilding SDs when inserting the driver is already covered by
> 
>    cpufreq_online()
>      cpufreq_set_policy()
>        sched_cpufreq_governor_change()
>          if (old or new gov eq. schedutil)
>            schedule_work(&rebuild_sd_work)
> 
> So what's missing is only a sched_cpufreq_governor_change() call when
> removing the driver, right?

Yes exact, removing a cpufreq driver (e.g. `rmmod cppc_cpufreq.ko`) goes
through:
cpufreq_remove_dev()
\-__cpufreq_offline()

so the path you mentioned is not used in this case.

Regards,
Pierre
