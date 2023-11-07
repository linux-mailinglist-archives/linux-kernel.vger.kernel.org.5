Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC797E4003
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjKGNYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjKGNYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:24:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76721DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:24:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A18C433C7;
        Tue,  7 Nov 2023 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699363475;
        bh=Wwu09Vw/ArIsP/HHzHRbx8Yu0jge/F2zpraSv4eNjyA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pNA8R4BHLc8NbJPskkLtaMVmC6npuy2EkQWGeU4wdaKRR8O2vcgMWGiQVjhNO2jxK
         7/ks6IaMI+eqktOGVyKMMTHbU1fZ2O55+5clrY41pmBKZEaoRQcsXOkjqPGIvG957g
         yFghxErxDIRO8oTL7azvmHRq25PeMzi0h8225DMZsdHsHEnzhfiU35iIRw25feeIxz
         XlUvzpcEerS2VoJGHY/FKsbuezWkKv0K6P662CexkdNujTAlAUgEZp/Gq2WYXqXim0
         6XLHRxef2BXdbK9+LZTS+y8icmXZBZ47emPQhYw7C9MzMwznb9Qvr8jflVTF9AkAkB
         xDlaj3EeUQnlw==
Message-ID: <51ed888b-591a-40aa-9de4-29cf4a84dd69@kernel.org>
Date:   Tue, 7 Nov 2023 14:24:28 +0100
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
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
 <20231107123818.GV8262@noisy.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231107123818.GV8262@noisy.programming.kicks-ass.net>
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

On 11/7/23 13:38, Peter Zijlstra wrote:
> On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
>> Add an interface for fair server setup on debugfs.
>>
>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>
>>  - fair_server_runtime: set runtime in ns
>>  - fair_server_period: set period in ns
>>  - fair_server_defer: on/off for the defer mechanism
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> ---
> 
> I did the below, that gives us:
> 
> /debug/sched/fair_server/cpuX/{runtime,period,defer}

right!

> I wanted to also add:
> 
> /debug/sched/fair_server/{runtime,period,defer}
> 
> to more easily set all CPUs to the same value, but then figured
> userspace will just have to loop.

I thought about that too... and had the same conclusion... let 'em loop.

-- Daniel

