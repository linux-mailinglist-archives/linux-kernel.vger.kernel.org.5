Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683967FEF89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbjK3Mwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjK3Mw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:52:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE4DBD7F;
        Thu, 30 Nov 2023 04:52:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E1621042;
        Thu, 30 Nov 2023 04:53:22 -0800 (PST)
Received: from [10.57.5.51] (unknown [10.57.5.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65BF3F5A1;
        Thu, 30 Nov 2023 04:52:31 -0800 (PST)
Message-ID: <f20c8c30-1379-4706-b980-73d2f7e5912a@arm.com>
Date:   Thu, 30 Nov 2023 12:53:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Simplify Util_est
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     hongyan.xia2@arm.com, mingo@redhat.com, alexs@kernel.org,
        linux-kernel@vger.kernel.org, vschneid@redhat.com,
        bristot@redhat.com, bsegall@google.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, peterz@infradead.org,
        juri.lelli@redhat.com, mgorman@suse.de, corbet@lwn.net,
        siyanteng@loongson.cn, qyousef@layalina.io,
        linux-doc@vger.kernel.org
References: <20231127143238.1216582-1-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231127143238.1216582-1-vincent.guittot@linaro.org>
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

Hi Vincent,

On 11/27/23 14:32, Vincent Guittot wrote:
> Following comment in [1], I prepared a patch to remove UTIL_EST_FASTUP.
> This enables us to simplify util_est behavior as proposed in patch 2.
> 
> [1] https://lore.kernel.org/lkml/CAKfTPtCAZWp7tRgTpwJmyEAkyN65acmYrfu9naEUpBZVWNTcQA@mail.gmail.com/
> 
> Vincent Guittot (2):
>    sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
>    sched/fair: Simplify util_est
> 
>   Documentation/scheduler/schedutil.rst |  7 +--
>   include/linux/sched.h                 | 35 ++----------
>   kernel/sched/debug.c                  |  7 +--
>   kernel/sched/fair.c                   | 81 ++++++++++-----------------
>   kernel/sched/features.h               |  1 -
>   kernel/sched/pelt.h                   |  4 +-
>   6 files changed, 43 insertions(+), 92 deletions(-)
> 

I recovered my pixel6 and applied these changes.
No power regression in Jankbench. No performance regression in GB5.
Better score in Chrome running Speedometer +3..5%.

The code looks much more clean, without the 'struct util_est'
(we will have to adjust our trace events to that change but it's worth).

Also, I was a bit surprised that the UTIL_EST_FASTUP wasn't helping
that much comparing to that new 'runnable' signal for the
underestimation corner case...

Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>
