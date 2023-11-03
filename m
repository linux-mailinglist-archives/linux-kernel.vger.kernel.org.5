Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00627E0425
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377693AbjKCOBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjKCOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:01:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECED6D43
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:01:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746FAC15;
        Fri,  3 Nov 2023 07:02:15 -0700 (PDT)
Received: from [10.57.1.190] (unknown [10.57.1.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21AE3F64C;
        Fri,  3 Nov 2023 07:01:30 -0700 (PDT)
Message-ID: <ea323a83-fa26-4500-8456-987bb70c3e4d@arm.com>
Date:   Fri, 3 Nov 2023 14:01:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] sched/uclamp: Remove all uclamp bucket logic
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <48fcea0a9bb2d2212c575032e64ab717756dc0fa.1696345700.git.Hongyan.Xia2@arm.com>
 <66e62c6f-b585-47a7-a519-9a8feea7176c@arm.com>
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <66e62c6f-b585-47a7-a519-9a8feea7176c@arm.com>
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

On 03/11/2023 13:50, Dietmar Eggemann wrote:
> On 04/10/2023 11:04, Hongyan Xia wrote:
>> From: Hongyan Xia <hongyan.xia2@arm.com>
>>
>> Also rewrite uclamp_update_active() so that the effective uclamp values
>> are updated every time we change task group properties, change system
>> defaults or a request is issued from userspace.
> 
> Tested it with
> 
> # cgcreate -g cpu:/A
> # echo $$ > /sys/fs/cgroup/cpu/A/tasks
> 
> (1) per-task
> 
> # uclampset --pid $$  -m 256 -M 768
> 
> (2) per taskgroup
> 
> # echo 25.0 > /sys/fs/cgroup/cpu/A/cpu.uclamp.min
> # echo 75.0 > /sys/fs/cgroup/cpu/A/cpu.uclamp.max
> 
> (3) system-wide
> 
> # echo 256 > /proc/sys/kernel/sched_util_clamp_min
> # echo 768 > /proc/sys/kernel/sched_util_clamp_max
> 
> uclamp_update_active() -> uclamp_update_active_nolock() is called in all
> cases.
> 

Thanks for testing!

> 
> uclamp_eff_get()'s function header still mentions `clamp bucket index`.

This is indeed confusing. I have changed it from 'clamp bucket index' to 
just 'uclamp value'.

>> [...]
> 
> [...]
