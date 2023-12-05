Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB18057BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345693AbjLEOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjLEOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:47:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06CDFCA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:48:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52A5B139F;
        Tue,  5 Dec 2023 06:48:49 -0800 (PST)
Received: from [10.1.31.59] (e133649.arm.com [10.1.31.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96F113F6C4;
        Tue,  5 Dec 2023 06:48:00 -0800 (PST)
Message-ID: <2677b01d-899d-4f64-b17c-85033386a4d3@arm.com>
Date:   Tue, 5 Dec 2023 14:47:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] sched/uclamp: Simulate PELT decay in
 util_avg_uclamp
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <d73fc3e9a02f047902fdd5e4c07402452d6e0590.1696345700.git.Hongyan.Xia2@arm.com>
 <CAKfTPtAoTB_1RM+COXFYTc7_YUUQ12we_2bqsy_ygpiT1RSViA@mail.gmail.com>
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAKfTPtAoTB_1RM+COXFYTc7_YUUQ12we_2bqsy_ygpiT1RSViA@mail.gmail.com>
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

On 04/12/2023 16:07, Vincent Guittot wrote:
> On Wed, 4 Oct 2023 at 11:05, Hongyan Xia <Hongyan.Xia2@arm.com> wrote:
>>
>> From: Hongyan Xia <hongyan.xia2@arm.com>
>>
>> Because util_avg_uclamp is not directly managed by PELT, it lacks the
>> nice property of slowly decaying to a lower value, resulting in
>> performance degredation due to premature frequency drops.
> 
> That a very good reason for not doing this

This is not much different from util_guest and the "additive uclamp" 
proposal in LPC 2023. The major difference is that I introduce a new 
signal right beside util_avg (which then needs to have PELT behavior) 
and they introduce signals in a way like util_est.

Now that I think about it, maybe my way is indeed too drastic, and maybe 
the util_est way is better.

>>
>> Add functions to decay root cfs utilization and tasks that are not on
>> the rq. This way, we get the benefits of PELT while still maintaining
>> uclamp. The rules are simple:
> 
> Nack. This just highlights that you are mixing different things and
> then trying to make it work.
> 
> Please keep PELT out of uclamp_min/max

Well, like in my previous comment I think PELT is already a mixed signal 
anyway, and treating it like it's not mixed with uclamp has already 
shown many problems which need corner case code like 0 spare capacity 
and uclamp filtering to make things work properly, and the code to fix 
uclamp is still growing.

I will see if I can rework this series in a util_est style, and will 
probably converge with the other two proposals, but fundamentally the 
idea is that we don't have a pure PELT signal anyway. Achieving a PELT 
value of X doesn't mean much if we don't know under what uclamp values 
was it achieved, and having a clamped(X) on the side can be a very good 
hint.

Hongyan
