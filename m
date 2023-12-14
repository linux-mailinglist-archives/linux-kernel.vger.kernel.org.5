Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5F0812EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444015AbjLNLiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444010AbjLNLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:38:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B1C3B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:38:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E79B11FB;
        Thu, 14 Dec 2023 03:38:52 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364E33F738;
        Thu, 14 Dec 2023 03:38:04 -0800 (PST)
Message-ID: <08664556-76c3-51d9-4202-132298cf2d7b@arm.com>
Date:   Thu, 14 Dec 2023 11:38:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
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
 <20231025180345.28061-16-james.morse@arm.com>
 <876af164-c326-4b26-ab56-790f9a36902e@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <876af164-c326-4b26-ab56-790f9a36902e@amd.com>
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

On 09/11/2023 20:47, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> Depending on the number of monitors available, Arm's MPAM may need to
>> allocate a monitor prior to reading the counter value. Allocating a
>> contended resource may involve sleeping.
>>
>> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
>> the allocation should be valid for all domains.
> 
> This above sentence does not look correct after your previous patch [patch
> 14].  You removed  resctrl_arch_rmid_read() from add_rmid_to_limbo().

Ah, this was the justification for making the allocated resource global, when the patches
were in a different order. It's also simpler to make them global. I've removed this
paragraph, and replaced it with:
| The memory or hardware allocated is not specific to a domain.

(its fairly obvious from the interface, but I felt it needed calling out in the commit
message)

> Otherwise looks good.
> 
>>
>> __check_limbo() and mon_event_count() each make multiple calls to
>> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
>> the allocation should be valid for multiple invocations of
>> resctrl_arch_rmid_read().
>>
>> Add arch hooks for this allocation, which need calling before
>> resctrl_arch_rmid_read(). The allocated monitor is passed to
>> resctrl_arch_rmid_read(), then freed again afterwards. The helper
>> can be called on any CPU, and can sleep.

> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!

James
