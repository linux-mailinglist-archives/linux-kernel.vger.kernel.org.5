Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36775759665
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjGSNSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGSNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:17:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57BAC172A;
        Wed, 19 Jul 2023 06:17:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3486B2F4;
        Wed, 19 Jul 2023 06:18:34 -0700 (PDT)
Received: from [10.57.31.26] (unknown [10.57.31.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3C2A3F6C4;
        Wed, 19 Jul 2023 06:17:47 -0700 (PDT)
Message-ID: <42118979-5f86-75df-72a5-e5fc8592eb82@arm.com>
Date:   Wed, 19 Jul 2023 14:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND][PATCH v2 1/3] sched/tp: Add new tracepoint to track
 uclamp set from user-space
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com,
        Qais Yousef <qyousef@layalina.io>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-2-lukasz.luba@arm.com>
 <20230531182629.nztie5rwhjl53v3d@airbuntu>
 <20230706111443.GH2833176@hirez.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230706111443.GH2833176@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/23 12:14, Peter Zijlstra wrote:
> On Wed, May 31, 2023 at 07:26:29PM +0100, Qais Yousef wrote:
>> On 05/22/23 15:57, Lukasz Luba wrote:
>>> The user-space can set uclamp value for a given task. It impacts task
>>> placement decisions made by the scheduler. This is very useful information
>>> and helps to understand the system behavior or track improvements in
>>> middleware and applications which start using uclamp mechanisms and report
>>> better performance in tests.
>>
>> Do you mind adding a generic one instead please? And explain why we can't just
>> attach to the syscall via kprobes? I think you want to bypass the permission
>> checks, so maybe a generic tracepoint after that might be justifiable?
>> Then anyone can use it to track how userspace has changed any attributes for
>> a task, not just uclamp.
> 
> Yeah, so I'm leaning towards the same, if you want to put a tracepoint
> in __sched_setscheduler(), just trace the whole attr and leave it at
> that:
> 
> 	trace_update_sched_attr_tp(p, attr);
> 
> or somesuch.
> 

OK, fair enough, I'll do that. Thanks Peter!
(I'm sorry for the delay, I was on vacation)

Lukasz
