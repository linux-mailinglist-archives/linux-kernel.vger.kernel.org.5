Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E27B2CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjI2HWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjI2HWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:22:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26628199;
        Fri, 29 Sep 2023 00:22:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06DF1FB;
        Fri, 29 Sep 2023 00:23:24 -0700 (PDT)
Received: from [192.168.1.13] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07A033F6C4;
        Fri, 29 Sep 2023 00:22:43 -0700 (PDT)
Message-ID: <e028af69-5583-5378-9573-71e46314687d@arm.com>
Date:   Fri, 29 Sep 2023 09:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        vschneid@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org
References: <20230918112937.493352-1-pierre.gondois@arm.com>
 <20230928071810.hkdmuoaasrv4b2oq@vireshk-i7>
 <93262faa-7089-f2a2-3df7-058c338adfc6@arm.com>
 <20230929032743.6mjcyyx3cmjjxsix@vireshk-i7>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230929032743.6mjcyyx3cmjjxsix@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 05:27, Viresh Kumar wrote:
> On 28-09-23, 14:49, Pierre Gondois wrote:
>> Another solution would be to call sched_cpufreq_governor_change()
>> from cpufreq_schedutil's init()/exit() callbacks. This would make
>> more sense as EAS/schedutil cpufreq are tightly bound, and it would
>> allow to cover all the possible paths.
>>
>> When tried locally, it seems to cover all scenarios:
>> - insmod/rmmod a cpufreq driver
>> - changing the governor policy
>> - offlining all the CPUs of a pd
> 
> Right now it is done for all governors. We don't need that ? We just care about
> schedutil here ?
> 

Yes exact, EAS requires the schedutil governor to be used by all policies. The purpose
of this function is to re-evaluate if EAS enablement conditions are met. I.e., if one
policy changed from/to schedutil, if EAS must be [de|re]activated.
