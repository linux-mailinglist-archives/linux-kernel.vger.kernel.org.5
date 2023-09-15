Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A067A24F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjIORit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjIORi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:38:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D746F2134
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:37:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B90F01FB;
        Fri, 15 Sep 2023 10:38:21 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A752D3F5A1;
        Fri, 15 Sep 2023 10:37:41 -0700 (PDT)
Message-ID: <acd712b8-748b-e9f5-0bf3-9cfadca34c95@arm.com>
Date:   Fri, 15 Sep 2023 18:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
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
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-16-james.morse@arm.com>
 <d5dc4710-6036-88f3-1081-0759aa956624@intel.com>
 <8ba79ccf-a1e0-d486-178c-5dfb6553a400@arm.com>
 <4f7facea-ffc4-63c3-b960-fa92eb03b04c@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <4f7facea-ffc4-63c3-b960-fa92eb03b04c@intel.com>
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

Hi Reinette,

On 25/08/2023 00:04, Reinette Chatre wrote:
> On 8/24/2023 9:56 AM, James Morse wrote:
>> On 09/08/2023 23:37, Reinette Chatre wrote:
>>> On 7/28/2023 9:42 AM, James Morse wrote:
>>>> Depending on the number of monitors available, Arm's MPAM may need to
>>>> allocate a monitor prior to reading the counter value. Allocating a
>>>> contended resource may involve sleeping.
>>>>
>>>> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
>>>> the allocation should be valid for all domains.
>>>>
>>>> __check_limbo() and mon_event_count() each make multiple calls to
>>>> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
>>>> the allocation should be valid for multiple invocations of
>>>> resctrl_arch_rmid_read().
>>>>
>>>> Add arch hooks for this allocation, which need calling before
>>>> resctrl_arch_rmid_read(). The allocated monitor is passed to
>>>> resctrl_arch_rmid_read(), then freed again afterwards. The helper
>>>> can be called on any CPU, and can sleep.
>>
>>> Looking at the error paths all the errors are silent failures.
>>
>> Yeah, I don't really expect this to ever fail. The memory arm64 needs to allocate is
>> smaller than a pointer - if that fails, I think there are bigger problems. The hardware
>> resource is something the call will wait for.
>>
>> As you note, it's hard to propagate an unlikely error back from here.
>>
>>
>>> On the 
>>> failure in mon_event_read() this could potentially be handled by setting
>>> the "err" field in struct rmid_read ... at least then the caller can print
>>> an error instead of displaying a zero count to the user.
>>
>> Sure, that covers the one a human being might see.
> 
> Right.
> 
>>> The other failures are harder to handle though.
>>
>> I don't think the silent failure is such a bad thing. For the limbo handler, no RMID moves
>> between the lists until the handler is able to make progress.
> 
> ok, so it needs to ensure that the handler is still rescheduled
> when such a failure is encountered.

Yup, the silent error occurs in __check_limbo(), and cqm_handle_limbo() will still
reschedule the worker. Similarly, for mbm_update(), mbm_handle_overflow() will still
reschedule the work.


>> For the overflow handler, its possible an overflow will get missed (I still have an
>> overflow interrupt I can use here). But I don't think this will be the biggest problem on
>> a machine that is struggling to allocate 4 bytes.
> 
> As I now (I think) better understand for MPAM it is 4 bytes of memory as well as
> reservation of a hardware resource. Could something go wrong attempting to find an
> available hardware resource that as you state later is indeed scarce? I wonder if
> it would not be helpful to at least have resctrl log an error from the
> places where it is not possible to propagate the error.

If it can't allocate a monitor, it should block until one becomes available. Errors should
never occur during normal use.

I'll add pr_warn_ratelimited() for errors returned on this path.


>>> Considering that these contexts are allocated and
>>> freed so often, why not allocate them once (perhaps in struct rdt_hw_domain?)
>>> on driver load with clear error handling?
>>
>> Because the resource they represent is scarce. You may have 100 control or monitor groups,
>> but only 10 hardware monitors. The hardware monitor has to be allocated and programmed
>> before it can be read.
> 
> I think I misunderstood what "context" is when I wrote the above. I
> was thinking about memory allocation that can be done early and
> neglected to connect the "context" to be an actual hardware resource.

Let me know if there is a better name. Obviously I had to avoid 'resource'!



Thanks,

James
