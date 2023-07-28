Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC67671DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjG1Qee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjG1Qe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:34:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6FCD4202
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:34:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EC17D75;
        Fri, 28 Jul 2023 09:35:09 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1033C3F67D;
        Fri, 28 Jul 2023 09:34:22 -0700 (PDT)
Message-ID: <b53da670-c2b3-124a-e315-a0a9d5936eb1@arm.com>
Date:   Fri, 28 Jul 2023 17:34:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 24/24] x86/resctrl: Separate arch and fs resctrl locks
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
        dfustini@baylibre.com
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-25-james.morse@arm.com>
 <09751242-365d-bf0a-a031-d636e34e08d0@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <09751242-365d-bf0a-a031-d636e34e08d0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/06/2023 23:26, Reinette Chatre wrote:
> On 5/25/2023 11:02 AM, James Morse wrote:
>> resctrl has one mutex that is taken by the architecture specific code,
>> and the filesystem parts. The two interact via cpuhp, where the
>> architecture code updates the domain list. Filesystem handlers that
>> walk the domains list should not run concurrently with the cpuhp
>> callback modifying the list.
>>
>> Exposing a lock from the filesystem code means the interface is not
>> cleanly defined, and creates the possibility of cross-architecture
>> lock ordering headaches. The interaction only exists so that certain
>> filesystem paths are serialised against cpu hotplug. The cpu hotplug
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
>> lock prevents concurrent writers. rdt_bit_usage_show() can

> This does not sound right to me. The domain list belongs to resctrl,
> the filesystem,

I'd argue the list belongs to the arch code, as only the arch code writes to it.


> having an architecture specific lock protect it does
> not seem like the right thing to do. Could this instead be a resctrl
> owned lock that is hidden behind helpers for the architecture
> code to add domains?

resctrl should never be writing to the domain list, so it never needs to know how
concurrent-writers are avoided.

The memory is allocated and added to the list by the architecture code.
This new domain-list-lock API would only ever be called by the arch code, and there is no
resctrl call that needs to be made with that lock held. I don't see any reason for this to
be visible to the filesystem code.

I'm trying to keep the number of functions exposed by resctrl to the arch code as small as
possible. After all this they are:
resctrl_online_domain()
resctrl_offline_domain()
resctrl_online_cpu()
resctrl_offline_cpu()
resctrl_init()
resctrl_exit()

The weird one is resctrl_get_domain_from_cpu(), which is used by both architecture and
filesystem code, because I wanted to avoid duplicating it. It ends up inlined from a
header file.

Part of this is to explore making resctrl a loadable module in the future, which I think
fits with Tony Luck's aims.


Thanks,

James
