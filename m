Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97887726F9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjHGOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjHGOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:02:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABF6844B2;
        Mon,  7 Aug 2023 07:01:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65EA1D75;
        Mon,  7 Aug 2023 07:01:57 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E58743F64C;
        Mon,  7 Aug 2023 07:01:12 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:00:59 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
Message-ID: <ZND5CL6Kl9RnDdhL@e126311.manchester.arm.com>
References: <5712331.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5712331.DvuYhMxLoT@kreacher>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Thu, Aug 03, 2023 at 10:57:04PM +0200, Rafael J. Wysocki wrote:
> Hi Folks,
> 
> This is the second iteration of:
> 
> https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> 
> with an additional patch.
> 
> There are some small modifications of patch [1/3] and the new
> patch causes governor statistics to play a role in deciding whether
> or not to stop the scheduler tick.
> 
> Testing would be much appreciated!
> 
> Thanks!
> 

My test results including the v2 are below.

1. Geekbench 6

+---------------------------+---------------+-----------------+-------------------+----------------------+
|          metric           |      teo      |     teo_tick    |    teo_tick_rfc   |    teo_tick_rfc_v2   |
+---------------------------+---------------+-----------------+-------------------+----------------------+
|      multicore_score      | 3320.9 (0.0%) | 3303.3 (-0.53%) |  3293.6 (-0.82%)  |   3302.3 (-0.56%)    |
|           score           | 1415.7 (0.0%) | 1417.7 (0.14%)  |  1423.4 (0.54%)   |    1425.8 (0.71%)    |
|      CPU_total_power      | 2421.3 (0.0%) | 2429.3 (0.33%)  |  2442.2 (0.86%)   |    2461.9 (1.67%)    |
|  latency (AsyncTask #1)   | 49.41μ (0.0%) | 51.07μ (3.36%)  |   50.1μ (1.4%)    |    50.76μ (2.73%)    |
| latency (labs.geekbench6) | 65.63μ (0.0%) | 77.47μ (18.03%) | 55.82μ (-14.95%)  |    66.12μ (0.75%)    |
| latency (surfaceflinger)  | 39.46μ (0.0%) | 36.94μ (-6.39%) |  35.79μ (-9.28%)  |    40.36μ (2.3%)     |
+---------------------------+---------------+-----------------+-------------------+----------------------+

+----------------------+-------------+------------+
|         tag          |    type     | count_perc |
+----------------------+-------------+------------+
|         teo          |  too deep   |   2.034    |
|       teo_tick       |  too deep   |    2.16    |
|     teo_tick_rfc     |  too deep   |   2.071    |
|    teo_tick_rfc_v2   |  too deep   |   2.548    |
|         teo          | too shallow |   15.791   |
|       teo_tick       | too shallow |   20.881   |
|     teo_tick_rfc     | too shallow |   20.337   |
|    teo_tick_rfc_v2   | too shallow |   19.886   |
+----------------------+-------------+------------+


2. JetNews

+-----------------+---------------+----------------+-----------------+-----------------+
|     metric      |      teo      |    teo_tick    |  teo_tick_rfc   | teo_tick_rfc_v2 |
+-----------------+---------------+----------------+-----------------+-----------------+
|       fps       |  86.2 (0.0%)  |  86.4 (0.16%)  |  86.0 (-0.28%)  |  86.6 (0.41%)   |
|    janks_pc     |  0.8 (0.0%)   |  0.8 (-0.66%)  |  0.8 (-1.37%)   |  0.7 (-11.37%)  |
| CPU_total_power | 185.2 (0.0%)  | 178.2 (-3.76%) |  182.2 (-1.6%)  | 169.4 (-8.53%)  | <- very interesting
+-----------------+---------------+----------------+-----------------+-----------------+

+----------------------+-------------+--------------------+
|         tag          |    type     |     count_perc     |
+----------------------+-------------+--------------------+
|         teo          |  too deep   |       0.992        |
|       teo_tick       |  too deep   |       0.945        |
|     teo_tick_rfc     |  too deep   |       1.035        |
|    teo_tick_rfc_v2   |  too deep   |       1.127        |
|         teo          | too shallow |       17.085       |
|       teo_tick       | too shallow |       15.236       |
|     teo_tick_rfc     | too shallow |       15.379       |
|    teo_tick_rfc_v2   | too shallow |       15.34        |
+----------------------+-------------+--------------------+

All in all looks pretty good. Unfortunately there's a slightly larger
percentage of too deep sleeps with the v2 (which is probably where the
increase in GB6 power usage comes from) but the lower jank percentage +
substantially lower power usage for the UI workload are very promising.

Since we don't care about GB6 power usage as much as UI power usage, I'd
say that the patchset looks good :)

Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
