Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B5787633
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbjHXQ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbjHXQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:57:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AC1A2126
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:57:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A513D75;
        Thu, 24 Aug 2023 09:57:48 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26B343F740;
        Thu, 24 Aug 2023 09:57:05 -0700 (PDT)
Message-ID: <8ba79ccf-a1e0-d486-178c-5dfb6553a400@arm.com>
Date:   Thu, 24 Aug 2023 17:56:55 +0100
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <d5dc4710-6036-88f3-1081-0759aa956624@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/08/2023 23:37, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
>> Depending on the number of monitors available, Arm's MPAM may need to
>> allocate a monitor prior to reading the counter value. Allocating a
>> contended resource may involve sleeping.
>>
>> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
>> the allocation should be valid for all domains.
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

> Looking at the error paths all the errors are silent failures.

Yeah, I don't really expect this to ever fail. The memory arm64 needs to allocate is
smaller than a pointer - if that fails, I think there are bigger problems. The hardware
resource is something the call will wait for.

As you note, it's hard to propagate an unlikely error back from here.


> On the 
> failure in mon_event_read() this could potentially be handled by setting
> the "err" field in struct rmid_read ... at least then the caller can print
> an error instead of displaying a zero count to the user.

Sure, that covers the one a human being might see.


> The other failures are harder to handle though.

I don't think the silent failure is such a bad thing. For the limbo handler, no RMID moves
between the lists until the handler is able to make progress.
For the overflow handler, its possible an overflow will get missed (I still have an
overflow interrupt I can use here). But I don't think this will be the biggest problem on
a machine that is struggling to allocate 4 bytes.


> Considering that these contexts are allocated and
> freed so often, why not allocate them once (perhaps in struct rdt_hw_domain?)
> on driver load with clear error handling?

Because the resource they represent is scarce. You may have 100 control or monitor groups,
but only 10 hardware monitors. The hardware monitor has to be allocated and programmed
before it can be read.
This works well for the llc_occupancy counter, but not for bandwidth counters, which with
the current 'free running' ABI have to all be allocated and programmed at the beginning of
time. If there are enough monitors to do that - the MPAM driver will, and these
allocate/free calls will just be looking up the pre-allocated/pre-programmed monitor.
Doing the allocation like this keeps that logic in the mpam driver, and allows concurrent
access to resctrl_arch_rmid_read(), which is something any future PMU support will need.

I don't have any numbers how many monitors any platform is going to have, but I'm
confident there are some that won't have enough for each control-group or monitor-group to
have one.


Thanks,

James
