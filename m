Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C56787637
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbjHXQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242875AbjHXQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:58:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E27941BC6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:57:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CAF8D75;
        Thu, 24 Aug 2023 09:58:28 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F5113F740;
        Thu, 24 Aug 2023 09:57:45 -0700 (PDT)
Message-ID: <2a0ba79b-b085-7f9d-3cfd-bdb4feda1edd@arm.com>
Date:   Thu, 24 Aug 2023 17:57:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 19/24] x86/resctrl: Add helpers for system wide
 mon/alloc capable
Content-Language: en-GB
To:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
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
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-20-james.morse@arm.com>
 <99939c7d-3c8d-f1d4-9226-81f32925e045@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <99939c7d-3c8d-f1d4-9226-81f32925e045@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 17/08/2023 19:34, Fenghua Yu wrote:
> On 7/28/23 09:42, James Morse wrote:
>> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine
>> whether any of the resources support the corresponding features.
>> resctrl also uses the static-keys that affect the architecture's
>> context-switch code to determine the same thing.
>>
>> This forces another architecture to have the same static-keys.
>>
>> As the static-key is enabled based on the capable flag, and none of
>> the filesystem uses of these are in the scheduler path, move the
>> capable flags behind helpers, and use these in the filesystem
>> code instead of the static-key.
>>
>> After this change, only the architecture code manages and uses
>> the static-keys to ensure __resctrl_sched_in() does not need
>> runtime checks.
>>
>> This avoids multiple architectures having to define the same
>> static-keys.
>>
>> Cases where the static-key implicitly tested if the resctrl
>> filesystem was mounted all have an explicit check added by a
>> previous patch.

> Why isn't rdt_alloc_capable in get_rdt_alloc_resources() replaced by the helper?
> 
> static __init bool get_rdt_alloc_resources(void)
> {
> ...
>         if (rdt_alloc_capable)
> ...

Because its in core.c, and is only called by get_rdt_resources as part of the arch codes
resctrl_late_init(). This can stay as it is once the filesystem code is moved out to
/fs/resctrl, there was no need to touch it.


Thanks,

James
