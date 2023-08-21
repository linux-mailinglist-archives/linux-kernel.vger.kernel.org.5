Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140F9782E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjHUQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjHUQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:39:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31F2AED;
        Mon, 21 Aug 2023 09:39:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA6B72F4;
        Mon, 21 Aug 2023 09:40:22 -0700 (PDT)
Received: from [192.168.178.99] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56103F64C;
        Mon, 21 Aug 2023 09:39:40 -0700 (PDT)
Message-ID: <7839dd5f-e7fd-7065-934d-436d012ac9d6@arm.com>
Date:   Mon, 21 Aug 2023 18:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230820210640.585311-3-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 23:06, Qais Yousef wrote:
> DVFS headroom is applied after we calculate the effective_cpu_util()
> which is where we honour uclamp constraints. It makes more sense to
> apply the headroom there once and let all users naturally get the right
> thing without having to sprinkle the call around in various places.

uclamp is applied in effective_cpu_util(..., FREQUENCY_UTIL, ...) which
IMHO currently has 2 power callers: (1) schedutil: sugov_get_util() and
(2) EAS: eenv_pd_max_util()

> Before this fix running
> 
> 	uclampset -M 800 cat /dev/zero > /dev/null
> 
> Will cause the test system to run at max freq of 2.8GHz. After the fix
> it runs at 2.2GHz instead which is the correct value that matches the
> capacity of 800.

IMHO, a system at util = 800 (w/o uclamp) would also run at 2.8Ghz since
we would call map_util_to_perf() on 800, no matter from where we call it.

> Note that similar problem exist for uclamp_min. If util was 50, and
> uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
> constraints, we'll end up with util of 125 instead of 100. IOW, we get
> boosted twice, first time by uclamp_min, and second time by dvfs
> headroom.

I see what you want to change here but:

So far we have `util -> uclamp -> map_util_to_perf()`

which is fine when we see uclamp as an entity which constrains util, not
the util after being mapped to a capacity constraint.

[...]
