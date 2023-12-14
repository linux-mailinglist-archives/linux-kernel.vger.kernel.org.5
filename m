Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A750812EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444076AbjLNLhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444027AbjLNLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:36:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76FB411D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:36:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B69A3C15;
        Thu, 14 Dec 2023 03:37:44 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8429D3F738;
        Thu, 14 Dec 2023 03:36:56 -0800 (PST)
Message-ID: <af4ebcec-8a65-44fb-f00e-c7bbffe480e2@arm.com>
Date:   Thu, 14 Dec 2023 11:36:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
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
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-11-james.morse@arm.com>
 <acfa2d99-1bfe-48ff-9bb3-348ad27a6f60@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <acfa2d99-1bfe-48ff-9bb3-348ad27a6f60@intel.com>
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

On 09/11/2023 17:46, Reinette Chatre wrote:
> Hi James,
> 
> On 10/25/2023 11:03 AM, James Morse wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be
>> dirty, and held in limbo.
>>
>> Instead of allocating the first free CLOSID, on architectures where
>> CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
>> closid_num_dirty_rmid[] to find the cleanest CLOSID.
>>
>> The CLOSID found is returned to closid_alloc() for the free list
>> to be updated.
>>
>> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>> Changes since v4:
>>  * Dropped stale section from comment
>>
>> Changes since v5:
>>  * Renamed some variables.
>>
>> No changes since v6
> 
> I use these patch changelogs to determine if I need to look at a
> patch for which I already provided a review tag. At first this
> patch appears to not deserve a second glance because I already provided a
> review tag and the above states "No changes since v6". Unfortunately
> this is false. I counted four changes. Now I cannot trust these
> "No changes since v6" and I need to dig out v6 to diff patches I already
> reviewed to determine if I need to look at them again. False patch
> changelogs make a patch series harder to review.

Sorry, looks like I applied the changes suggested by Babu, but didn't update this bit of
text that doesn't get committed. I added this 'No changes' text to any patch that didn't
have any entries.

You should be able to rely on people dropping Reviewed-by tags if there are substantial
changes. This is the normal threshold for re-reviewing a patch.



James
