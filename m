Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6CA7E0400
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377636AbjKCNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjKCNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:50:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D405D59
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:50:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE6E2F4;
        Fri,  3 Nov 2023 06:51:22 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 133BF3F64C;
        Fri,  3 Nov 2023 06:50:37 -0700 (PDT)
Message-ID: <66e62c6f-b585-47a7-a519-9a8feea7176c@arm.com>
Date:   Fri, 3 Nov 2023 14:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] sched/uclamp: Remove all uclamp bucket logic
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
 <48fcea0a9bb2d2212c575032e64ab717756dc0fa.1696345700.git.Hongyan.Xia2@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <48fcea0a9bb2d2212c575032e64ab717756dc0fa.1696345700.git.Hongyan.Xia2@arm.com>
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
> Also rewrite uclamp_update_active() so that the effective uclamp values
> are updated every time we change task group properties, change system
> defaults or a request is issued from userspace.

Tested it with

# cgcreate -g cpu:/A
# echo $$ > /sys/fs/cgroup/cpu/A/tasks

(1) per-task

# uclampset --pid $$  -m 256 -M 768

(2) per taskgroup

# echo 25.0 > /sys/fs/cgroup/cpu/A/cpu.uclamp.min
# echo 75.0 > /sys/fs/cgroup/cpu/A/cpu.uclamp.max

(3) system-wide

# echo 256 > /proc/sys/kernel/sched_util_clamp_min
# echo 768 > /proc/sys/kernel/sched_util_clamp_max

uclamp_update_active() -> uclamp_update_active_nolock() is called in all
cases.

[...]

uclamp_eff_get()'s function header still mentions `clamp bucket index`.

> @@ -1542,196 +1485,24 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>  
>  unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> -	struct uclamp_se uc_eff;
> -
> -	/* Task currently refcounted: use back-annotated (effective) value */
> -	if (p->uclamp[clamp_id].active)
> -		return (unsigned long)p->uclamp[clamp_id].value;
> -
> -	uc_eff = uclamp_eff_get(p, clamp_id);
> -
> -	return (unsigned long)uc_eff.value;
> -}

[...]

