Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73FC7671E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjG1QgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjG1Qf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:35:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BB4446A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:35:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F714D75;
        Fri, 28 Jul 2023 09:36:23 -0700 (PDT)
Received: from [10.1.27.148] (e125956.cambridge.arm.com [10.1.27.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6CBB3F67D;
        Fri, 28 Jul 2023 09:35:35 -0700 (PDT)
Message-ID: <8cee8203-1bce-3e71-d8df-2a3fcde43967@arm.com>
Date:   Fri, 28 Jul 2023 17:35:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v4 06/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
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
 <20230525180209.19497-7-james.morse@arm.com>
 <caa21966-967c-77c0-c2ca-8747677e186a@intel.com>
Content-Language: en-US
In-Reply-To: <caa21966-967c-77c0-c2ca-8747677e186a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/15/23 23:08, Reinette Chatre wrote:
> On 5/25/2023 11:01 AM, James Morse wrote:
>> @@ -420,6 +438,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>   		rmid_limbo_count++;
>>   	else
>>   		list_add_tail(&entry->list, &rmid_free_lru);
>> +
>> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +		closid_num_dirty_rmid[entry->closid]++;
   
> Wouldn't this always increment the counter, whether the entry is
> dirty or not? (Although ... the later change where entries are
> always dirty may make this correct ... although I would still
> expect the if statement that precedes it to change).

True, I was expecting add_rmid_to_limbo() to always transiently add CLOSID to limbo,
hence this is unconditional, but you're right its optional - and this could cause everything
to pile up in the list when the limbo handler isn't running.
I'll add a check on entry->busy, and move this into the above if case.


Thanks,

James
