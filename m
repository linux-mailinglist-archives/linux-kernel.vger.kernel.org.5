Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929477DF8D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjKBRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjKBRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:37:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B01D184
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:37:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 389A72F4;
        Thu,  2 Nov 2023 10:38:19 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B2D23F738;
        Thu,  2 Nov 2023 10:37:34 -0700 (PDT)
Message-ID: <ad78436f-43c3-4b4b-9cb5-28dffd43468a@arm.com>
Date:   Thu, 2 Nov 2023 18:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] sched/fair: Rewrite util_fits_cpu()
Content-Language: en-US
To:     Hongyan Xia <Hongyan.Xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <d8371d0764b595ab496b4fb744fdcba0a82bf41d.1696345700.git.Hongyan.Xia2@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <d8371d0764b595ab496b4fb744fdcba0a82bf41d.1696345700.git.Hongyan.Xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 11:04, Hongyan Xia wrote:
> From: Hongyan Xia <hongyan.xia2@arm.com>
> 
> Currently, there's no way to distinguish the difference between 1) a CPU
> that is actually maxed out at its highest frequency, or 2) one that is
> throttled because of UCLAMP_MAX, since both present util_avg values of
> 1024. This is problematic because when we try to pick a CPU for a task
> to run, we would like to give 2) a chance, or at least prefer 2) to 1).
> 
> Current upstream gives neither a chance because the spare capacity is 0
> for either case. There are patches to fix this problem by considering 0
> capacities [1], but this might still be inefficient because this ends
> up treating 1) and 2) equally, and will always pick the same one because
> we don't change how we iterate through all CPUs. If we end up putting
> many tasks on 1), then this creates a seriously unbalanced load for the
> two CPUs.
> 
> Fix by using util_avg_uclamp for util_fits_cpu(). This way, case 1) will
> still keep its utilization at 1024 whereas 2) shows spare capacities if
> the sum of util_avg_uclamp values is still under the CPU capacity.
> Note that this is roughly what the sum aggregation does in the Android
> kernel [2] (although we clamp UCLAMP_MIN as well in this patch, which
> may need some discussions), which shows superior energy savings because
> there's more chance that a task can get scheduled on 2) instead of
> finding a big CPU to run on.
> 
> Under sum aggregation, checking whether a task fits a CPU becomes much
> simpler. We simply do fits_capacity() and there does not need to be code
> checking all corner cases for uclamp. This means util_fits_cpu() returns
> to true and false instead of tri-state, simplifying a significant amount
> of code.

You could remove util_fits_cpu() and task_fits_cpu() and call
fits_capacity() directly. We should try to keep the zoo of util-related
functions as small as possible.

[...]

