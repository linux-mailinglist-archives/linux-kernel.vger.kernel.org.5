Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2D7E29BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjKFQaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKFQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:29:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51FF4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:29:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC74C433C8;
        Mon,  6 Nov 2023 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699288194;
        bh=Am+PVPrUwLAGoDv2qBi3sFoGiy6NZ955i06iPxaiaOA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L23jUDrB8Mav93Fm9EA4+JtO5wcbJ4uxFiPh2YwS2mRBqkkznISmXw/rqePNCoF9I
         3UWlvS8ikp0reHVCrqmGrrQ39dFkELOsKR+C0yeRxxu9dwOd2XC662t96khucUvodM
         d8rSu1n4/ivCudpCvPinFeRFSA+YNk8KWRfytf13OcSkgtMmDSvsj1wnjLlGzJYnTz
         p12tR1H5IlSl6Mw/XiMTEdVO/emvzt2odOgzCzkLqHqa0VG393eXQIL+wu0HmdntQZ
         /ChfYzeQSH7JUJx/jQ+9742S/KMM/agIfmfYbhd9Ec6fdr76YHrpH6BZFgDxFPoozp
         JTyljuCuS08TA==
Message-ID: <9a7222ed-88f8-4a3f-9d83-09b7fb977c27@kernel.org>
Date:   Mon, 6 Nov 2023 17:29:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US, pt-BR, it-IT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <20231106154042.GH3818@noisy.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231106154042.GH3818@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 16:40, Peter Zijlstra wrote:
> On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
>> Add an interface for fair server setup on debugfs.
>>
>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>
>>  - fair_server_runtime: set runtime in ns
>>  - fair_server_period: set period in ns
>>  - fair_server_defer: on/off for the defer mechanism
>>
> 
> This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to be the
> total available bandwidth control, right?

right, but thinking aloud... given that the per-cpu files are already allocating the
bandwidth on the dl_rq, the spare time for fair scheduler is granted.

Still, we can have them there as a safeguard to not overloading the deadline
scheduler... (thinking aloud 2) as long as global is a thing... as we get away
from it, that global limitation will make less sense - still better to have a form
of limitation so people are aware of bandwidth until there.

> But then shouldn've we also rip out the throttle thingy right quick?
> 

I was thinking about moving the entire throttling machinery inside CONFIG_RT_GROUP_SCHED
for now, because GROUP_SCHED depends on it, no?

With the next step on moving the dl server as the base for the hierarchical scheduling...
That will rip out the CONFIG_RT_GROUP_SCHED... with a thing with a per-cpu interface.

Does it make sense?


