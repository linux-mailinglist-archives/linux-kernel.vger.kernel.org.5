Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00C7D72B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjJYR56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:57:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96F53187
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:57:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7495C150C;
        Wed, 25 Oct 2023 10:58:35 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2E73F738;
        Wed, 25 Oct 2023 10:57:48 -0700 (PDT)
Message-ID: <6c969412-9190-3ec7-4de1-62edded49e83@arm.com>
Date:   Wed, 25 Oct 2023 18:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 22/24] x86/resctrl: Add cpu offline callback for
 resctrl work
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-23-james.morse@arm.com>
 <fc437191-0fb6-92fc-c5c6-5387c254e065@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <fc437191-0fb6-92fc-c5c6-5387c254e065@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 03/10/2023 22:23, Reinette Chatre wrote:
> On 9/14/2023 10:21 AM, James Morse wrote:
>> The resctrl architecture specific code may need to free a domain when
>> a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
>> Amongst other things, the resctrl filesystem code needs to clear this
>> CPU from the cpu_mask of any control and monitor groups.
>>
>> Currently this is all done in core.c and called from
>> resctrl_offline_cpu(), making the split between architecture and
>> filesystem code unclear.
>>
>> Move the filesystem work to remove the CPU from the control and monitor
>> groups into a filesystem helper called resctrl_offline_cpu(), and rename
>> the one in core.c resctrl_arch_offline_cpu().
>>
>> The rdtgroup_mutex is unlocked and locked again in the call in
>> preparation for changing the locking rules for the architecture
>> code.
> 
> This last paragraph may cause some confusion since this refactoring
> is not changing any current locking. I'll defer to you if you prefer
> to keep it.

Hmm, that is referring to an earlier version that looked funny and I felt needed
explanation. I've remove that paragraph.


>> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
>> Tested-By: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James
