Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE047AB04D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjIVLN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjIVLNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:13:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9906AF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:13:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5A6DA7;
        Fri, 22 Sep 2023 04:14:25 -0700 (PDT)
Received: from [192.168.178.106] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43AC23F5A1;
        Fri, 22 Sep 2023 04:13:45 -0700 (PDT)
Message-ID: <2247ced8-c4f9-80a7-a0a2-0953abed135f@arm.com>
Date:   Fri, 22 Sep 2023 13:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arch_topology: Support SMT control on arm64
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     yangyicong@hisilicon.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, jonathan.cameron@huawei.com,
        prime.zeng@hisilicon.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
References: <20230919123319.23785-1-yangyicong@huawei.com>
 <130ce530-a3c1-0918-e04f-cb7d94aef57b@arm.com>
 <80b2556c-b56c-ca23-22c7-70a0a3995701@huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <80b2556c-b56c-ca23-22c7-70a0a3995701@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 10:56, Yicong Yang wrote:
> On 2023/9/21 1:08, Dietmar Eggemann wrote:
>> On 19/09/2023 14:33, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>

[...]

> If you manually disable SMT by offline each CPUs the cpu_smt_control will
> not be updated. It'll updated when using the interface like
> `/sys/devices/system/cpu/smt/control` or cmdline. By these means,
> the framework will use topology_is_primary_thread() to decide which CPU
> in the SMT will keep online:
> 
> // e.g. echo off > /sys/devices/system/cpu/smt/control
> [ kernel/cpu.c ]
> control_store()
>   __store_smt_control()
>     cpuhp_smt_disable()
>       for_each_online_cpu(cpu)
>         if (topology_is_primary_thread(cpu))
>           continue;            <---------- will skip the primary thread
>       [...]
>       cpu_smt_control = CPU_SMT_DISABLED;
> 
> topology_is_primary_thread() checking only applies to the SMT control but
> not to the CPU offline.

I see, make sense. Retested on my SMT4 Arm64 server with 256 CPUs.
