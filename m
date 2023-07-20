Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A875B261
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjGTPWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGTPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:22:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CFB1132
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:22:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CE9E2F4;
        Thu, 20 Jul 2023 08:23:19 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 861C03F738;
        Thu, 20 Jul 2023 08:22:32 -0700 (PDT)
Message-ID: <96efae1a-37f6-c8da-5cdb-07b460307d6b@arm.com>
Date:   Thu, 20 Jul 2023 17:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell> <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
 <20230719132914.GA91858@ziqianlu-dell>
 <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
 <20230720144233.GA185317@ziqianlu-dell>
 <CAKfTPtANqtEQjv2UThb5s0TPCS2adhC_14Gfv5ayAOva9Mib8g@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtANqtEQjv2UThb5s0TPCS2adhC_14Gfv5ayAOva9Mib8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 17:02, Vincent Guittot wrote:
> On Thu, 20 Jul 2023 at 16:42, Aaron Lu <aaron.lu@intel.com> wrote:
>>
>> On Thu, Jul 20, 2023 at 03:10:30PM +0200, Vincent Guittot wrote:
>>> On Wed, 19 Jul 2023 at 15:29, Aaron Lu <aaron.lu@intel.com> wrote:
>>>>
>>>> On Wed, Jul 19, 2023 at 11:47:06AM +0200, Vincent Guittot wrote:
>>>>> On Wed, 19 Jul 2023 at 10:01, Aaron Lu <aaron.lu@intel.com> wrote:
>>>>>>
>>>>>> On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:

[...]

> What was wrong with your proposal to limit the update inside
> update_tg_load_avg()  ? except maybe s/1000000/NSEC_PER_MSEC/ and
> computing delta after testing the time since last update
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..e48fd0e6982d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3665,6 +3665,7 @@ static inline bool cfs_rq_is_decayed(struct
> cfs_rq *cfs_rq)
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
>         long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> +       u64 now = cfs_rq_clock_pelt(cfs_rq);

Could this be `u64 now = sched_clock_cpu()` like in
migrate_se_pelt_lag() or newidle_balance() to avoid the time morphing
due to PELT's frequency and uArch invariance?
> 
>         /*
>          * No need to update load_avg for root_task_group as it is not used.

[...]

