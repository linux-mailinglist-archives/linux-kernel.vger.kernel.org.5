Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36F2812ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444194AbjLNLj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444101AbjLNLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:39:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 484C11B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:39:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 972681576;
        Thu, 14 Dec 2023 03:40:02 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BDC83F738;
        Thu, 14 Dec 2023 03:39:14 -0800 (PST)
Message-ID: <1496407e-cf12-8192-5d58-aa02d903dafe@arm.com>
Date:   Thu, 14 Dec 2023 11:39:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 24/24] x86/resctrl: Separate arch and fs resctrl locks
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
 <20231025180345.28061-25-james.morse@arm.com>
 <9fae4348-7a1e-48ba-a5f4-c1b2ad3f0644@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <9fae4348-7a1e-48ba-a5f4-c1b2ad3f0644@amd.com>
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

On 09/11/2023 20:52, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> resctrl has one mutex that is taken by the architecture specific code,
>> and the filesystem parts. The two interact via cpuhp, where the
>> architecture code updates the domain list. Filesystem handlers that
>> walk the domains list should not run concurrently with the cpuhp
>> callback modifying the list.
>>
>> Exposing a lock from the filesystem code means the interface is not
>> cleanly defined, and creates the possibility of cross-architecture
>> lock ordering headaches. The interaction only exists so that certain
>> filesystem paths are serialised against CPU hotplug. The CPU hotplug
>> code already has a mechanism to do this using cpus_read_lock().
>>
>> MPAM's monitors have an overflow interrupt, so it needs to be possible
>> to walk the domains list in irq context. RCU is ideal for this,
>> but some paths need to be able to sleep to allocate memory.
>>
>> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
>> of a cpuhp callback, cpus_read_lock() must always be taken first.
>> rdtgroup_schemata_write() already does this.
>>
>> Most of the filesystem code's domain list walkers are currently
>> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
>> The exceptions are rdt_bit_usage_show() and the mon_config helpers
>> which take the lock directly.
>>
>> Make the domain list protected by RCU. An architecture-specific
>> lock prevents concurrent writers. rdt_bit_usage_show() could
>> walk the domain list using RCU, but to keep all the filesystem
>> operations the same, this is changed to call cpus_read_lock().
>> The mon_config helpers send multiple IPIs, take the cpus_read_lock()
>> in these cases.
>>
>> The other filesystem list walkers need to be able to sleep.
>> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
>> cpuhp callbacks can't be invoked when file system operations are
>> occurring.
>>
>> Add lockdep_assert_cpus_held() in the cases where the
>> rdtgroup_kn_lock_live() call isn't obvious.
>>
>> Resctrl's domain online/offline calls now need to take the
>> rdtgroup_mutex themselves.

> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!


James

