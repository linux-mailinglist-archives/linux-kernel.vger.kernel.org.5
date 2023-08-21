Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B506782E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbjHUQia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjHUQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:38:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E41E8;
        Mon, 21 Aug 2023 09:38:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88DC22F4;
        Mon, 21 Aug 2023 09:39:08 -0700 (PDT)
Received: from [192.168.178.99] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 471723F64C;
        Mon, 21 Aug 2023 09:38:26 -0700 (PDT)
Message-ID: <bc9cd8a3-6bad-3f40-735f-f54b7f3b46b9@arm.com>
Date:   Mon, 21 Aug 2023 18:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] sched: cpufreq: Rename map_util_perf to
 apply_dvfs_headroom
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
 <20230820210640.585311-2-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230820210640.585311-2-qyousef@layalina.io>
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
> We are providing headroom for the utilization to grow until the next
> decision point to pick the next frequency. Give the function a better
> name and give it some documentation. It is not really mapping anything.

Wasn't the original aim to have a counterpart to task scheduler's
fits_capacity(), i.e. implement a frequency tipping point at 80%?

  #define fits_capacity(cap, max) ((cap) * 1280 < (max) * 1024)


(util / max) = 0.8, hence 1.25 for the frequency-invariant case?

https://lkml.kernel.org/r/11678919.CQLTrQTYxG@vostro.rjw.lan

  next_freq = 1.25 * max_freq * util / max

              1,25 *            util  <-- map_util_perf()

[...]

Difference is that EAS deals with `util_cfs` and `capacity` whereas
power (CPUfreq and EM) deals with `util` and `capacity_orig`. And this
is where `capacity pressure` comes in for EAS (or fair.c).

In this regard, I'm not sure why we should rename the function?

> + * This function provides enough headroom to provide adequate performance
> + * assuming the CPU continues to be busy.
> + *
> + * At the moment it is a constant multiplication with 1.25.
> + *
> + * TODO: The headroom should be a function of the delay. 25% is too high
> + * especially on powerful systems. For example, if the delay is 500us, it makes
> + * more sense to give a small headroom as the next decision point is not far
> + * away and will follow the util if it continues to rise. On the other hand if
> + * the delay is 10ms, then we need a bigger headroom so the CPU won't struggle
> + * at a lower frequency if it never goes to idle until then.

I wouldn't add this here since this implementation is not provided.

[...]
