Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD53078A283
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjH0WL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjH0WLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:11:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C5FFB6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:11:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853462F4;
        Sun, 27 Aug 2023 15:11:59 -0700 (PDT)
Received: from [10.57.3.66] (unknown [10.57.3.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D2083F738;
        Sun, 27 Aug 2023 15:11:17 -0700 (PDT)
Message-ID: <311d0ecf-dddf-dcf5-9545-3f8a51634a9a@arm.com>
Date:   Sun, 27 Aug 2023 23:11:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V5 0/4] coresight: trbe: Enable ACPI based devices
To:     Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        kernel-team@android.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, yangyicong@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
 <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
 <f8f13510-ec6a-b18b-d9ff-9247b250bc03@arm.com>
 <20230821112851.GC19469@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230821112851.GC19469@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 12:28, Will Deacon wrote:
> On Sat, Aug 19, 2023 at 08:36:28AM +0100, Suzuki K Poulose wrote:
>> On 18/08/2023 19:04, Will Deacon wrote:
>>> On Thu, 17 Aug 2023 11:24:01 +0530, Anshuman Khandual wrote:
>>>> This series enables detection of ACPI based TRBE devices via a stand alone
>>>> purpose built representative platform device. But as a pre-requisite this
>>>> changes coresight_platform_data structure assignment for the TRBE device.
>>>>
>>>> This series is based on v6.5-rc5 kernel, is also dependent on the following
>>>> EDK2 changes posted earlier by Sami.
>>>>
>>>> [...]
>>>
>>> Applied to will (for-next/perf), thanks!
>>>
>>> [1/4] arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
>>>         https://git.kernel.org/will/c/81e5ee471609
>>> [2/4] arm_pmu: acpi: Add a representative platform device for TRBE
>>>         https://git.kernel.org/will/c/1aa3d0274a4a
>>> [3/4] coresight: trbe: Add a representative coresight_platform_data for TRBE
>>>         https://git.kernel.org/will/c/e926b8e9eb40
>>
>> This will conflict with what I have (already) sent to Greg for
>> coresight/next. Please let me know how you would like handle it
> 
> Hmm, the rationale behind your change to make the pdata allocation
> per-device in ("coresight: trbe: Allocate platform data per device")
> confuses me: with Anshuman's change to allocate the pdata using
> devm_kzalloc(), there shouldn't be any connections for the coresight
> core to trip over, should there?

Anshuman's patch is working around the problem of "TRBE platform
device with ACPI doesn't have a valid companion device" - this is a 
problem for the acpi_get_coresight_platform_data(). The work
around is to move the "allocation" from coresight_get_platform_data()
to the driver (given we don't need anything else from the ACPI except
the IRQ). That doesn't change *how* it is allocated.
Also please note that, the TRBE driver creates a TRBE coresight_device 
per-CPU and the platform data is shared by all of these devices, which
the coresight core driver doesn't cope with. The other option is to
move the releasing of these platform-data to the individual drivers,
which is quite an invasive change. Or, make the core driver tolerate
a NULL platform data, which is also again invasive. So the merged fix
is correct and is still valid after this patch.

> 
> It would've been nice to know about the conflict earlier, but since I
> think you're away this week and we're likely to hit the merge window
> next week, I'm going to drop the coresight patches for now.

Apologies, I was expecting to queue the changes via coresight tree,
given how it was affecting the tree and was awaiting your Ack. However
I didn't confirm it on the list, which is my mistake.

The other problem was reported and the fix eventually had to
conflict with Anshuman's series, which he was made aware of.
Given, your Ack was missing I hoping that Anshuman could respin
the series with your Ack on top of the fix and eventually queue
that via my tree.

Suzuki

> 
> Will

