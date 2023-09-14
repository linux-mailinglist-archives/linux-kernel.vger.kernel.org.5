Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA07A0F33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjINUqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjINUqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:46:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 019212120;
        Thu, 14 Sep 2023 13:46:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9C881FB;
        Thu, 14 Sep 2023 13:46:38 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1F0D3F738;
        Thu, 14 Sep 2023 13:45:57 -0700 (PDT)
Message-ID: <be527eb1-d253-b9fe-ecc9-4c7b04da9efd@arm.com>
Date:   Thu, 14 Sep 2023 22:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] sched: consolidate and cleanup access to CPU's max
 compute capacity
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230901130312.247719-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 15:03, Vincent Guittot wrote:
> Remove struct rq cpu_capacity_orig field and use arch_scale_cpu_capacity()
> instead.
> 
> Scheduler uses 3 methods to get access to the CPU's max compute capacity:
> - arch_scale_cpu_capacity(cpu) which is the default way to get CPU's capacity.
> - cpu_capacity_orig field which is periodically updated with
>   arch_scale_cpu_capacity().
> - capacity_orig_of(cpu) which encapsulates rq->cpu_capacity_orig
> 
> There is no real need to save the value returned by arch_scale_cpu_capacity()
> in struct rq. arch_scale_cpu_capacity() returns:
> - either a per_cpu variable.
> - or a const value for systems which have only one capacity.
> 
> Remove cpu_capacity_orig and use arch_scale_cpu_capacity() everywhere.
> 
> No functional changes.
> 
> some tests of Arm64:
> small SMP device (hikey): no noticeable changes
> HMP device (RB5): hackbench shows minor improvement (1-2%)
> large smp (thx2): hackbench and tbench shows minor improvement (1%)
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Next to util_fits_cpu() which uses capacity_orig as a local variable
(which is fine) there is sis() referring to capacity_orig in a comment.

Documentation/scheduler/sched-capacity.rst uses the term `capacity_orig`
in chapter 1.2 to explain the difference between CPU's maximum
(attainable) capacity and capacity as the former reduced by pressure.

Not sure if you want to change those refs as well with this patch?
People might get confused about the term `capacity_orig` pretty soon.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
