Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50F8812EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444037AbjLNLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444030AbjLNLhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:37:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89AEBBD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:37:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D29DAC15;
        Thu, 14 Dec 2023 03:38:09 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C25D3F738;
        Thu, 14 Dec 2023 03:37:21 -0800 (PST)
Message-ID: <9356e696-f88d-a797-c0b3-0249635902fd@arm.com>
Date:   Thu, 14 Dec 2023 11:37:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 11/24] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
Content-Language: en-GB
To:     babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-12-james.morse@arm.com>
 <9ea2218e-3f0c-4e62-97f7-1d0b1f57b46d@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <9ea2218e-3f0c-4e62-97f7-1d0b1f57b46d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 09/11/2023 20:39, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> When switching tasks, the CLOSID and RMID that the new task should
>> use are stored in struct task_struct. For x86 the CLOSID known by resctrl,
>> the value in task_struct, and the value written to the CPU register are
>> all the same thing.
>>
>> MPAM's CPU interface has two different PARTID's one for data accesses
>> the other for instruction fetch. Storing resctrl's CLOSID value in
>> struct task_struct implies the arch code knows whether resctrl is using
>> CDP.
>>
>> Move the matching and setting of the struct task_struct properties
>> to use helpers. This allows arm64 to store the hardware format of
>> the register, instead of having to convert it each time.
>>
>> __rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
>> values aren't seen as another CPU may schedule the task being moved
>> while the value is being changed. MPAM has an additional corner-case
>> here as the PMG bits extend the PARTID space. If the scheduler sees a
>> new-CLOSID but old-RMID, the task will dirty an RMID that the limbo code
>> is not watching causing an inaccurate count. x86's RMID are independent
>> values, so the limbo code will still be watching the old-RMID in this
>> circumstance.
>> To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
>> Both values must be provided together.
>>
>> Because MPAM's RMID values are not unique, the CLOSID must be provided
>> when matching the RMID.

> Reviewed-by: Babu Moger <babu.moger@amd.com>


Thanks!


James
