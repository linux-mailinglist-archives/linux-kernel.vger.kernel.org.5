Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA21812EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444042AbjLNLiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444027AbjLNLiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:38:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FE5CB7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:38:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B35ECC15;
        Thu, 14 Dec 2023 03:38:58 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7581F3F738;
        Thu, 14 Dec 2023 03:38:10 -0800 (PST)
Message-ID: <bf7c1a04-0a55-6d02-7c5d-5db3293b0e78@arm.com>
Date:   Thu, 14 Dec 2023 11:38:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 16/24] x86/resctrl: Make resctrl_mounted checks
 explicit
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
 <20231025180345.28061-17-james.morse@arm.com>
 <7e611640-9e7a-42a1-b0d7-f8b76999e9b2@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <7e611640-9e7a-42a1-b0d7-f8b76999e9b2@amd.com>
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
>> The rdt_enable_key is switched when resctrl is mounted, and used to
>> prevent a second mount of the filesystem. It also enables the
>> architecture's context switch code.
>>
>> This requires another architecture to have the same set of static-keys,
>> as resctrl depends on them too. The existing users of these static-keys
>> are implicitly also checking if the filesystem is mounted.
>>
>> Make the resctrl_mounted checks explicit: resctrl can keep track of
>> whether it has been mounted once. This doesn't need to be combined with
>> whether the arch code is context switching the CLOSID.
>>
>> rdt_mon_enable_key is never used just to test that resctrl is mounted,
>> but does also have this implication. Add a resctrl_mounted to all uses
>> of rdt_mon_enable_key. This will allow rdt_mon_enable_key to be swapped
>> with a helper in a subsequent patch.
>>
>> This will allow the static-key changing to be moved behind resctrl_arch_
>> calls.

> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!


James
