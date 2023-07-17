Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1767569D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGQRGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGQRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:06:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6B510E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:06:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57838C15;
        Mon, 17 Jul 2023 10:07:22 -0700 (PDT)
Received: from [10.57.79.8] (unknown [10.57.79.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E67CA3F738;
        Mon, 17 Jul 2023 10:06:34 -0700 (PDT)
Message-ID: <24ebc625-bcb9-53ab-6c57-76cdad53745b@arm.com>
Date:   Mon, 17 Jul 2023 18:06:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
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
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-13-james.morse@arm.com>
 <CALPaoCj3h=ELzRwUB2FcPAFAMD7G_nq1-r=PUGOuLq38bUMr0g@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCj3h=ELzRwUB2FcPAFAMD7G_nq1-r=PUGOuLq38bUMr0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 6/8/23 09:53, Peter Newman wrote:
> On Thu, May 25, 2023 at 8:03 PM James Morse <james.morse@arm.com> wrote:
>>
>> resctrl_arch_rmid_read() could be called by resctrl in process context,
>> and then called by the PMU driver from irq context on the same CPU.
> 
> Will there be x86 PMU changes to do this or is this only ARM? I just
> want to make sure the x86 resctrl_arch_rmid_read() changes are
> actually needed.

I plan to add that as an uncore 'resctrl_pmu' that works for all architectures by calling resctrl_arch_rmid_read(). Having that be specific to arm64 isn't helpful to user-space.
Perf is the natural home for these counters, and it will make it easier to add per-architecture
(or per-soc) counters, without having to teach resctrl about them.

This patch moved to be 'this' side of the 'move to /fs/resctrl' because this can happen
without the PMU changes. If a NOHZ_FULL CPU makes a syscall to read a counter, that happens
in process context, if a CPU in another domain wants to read the same counter, it has to send
an IPI which might target the same CPU.

(I've not investigated  whether this is an existing bug)


Thanks,

James
