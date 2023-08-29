Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E474378C0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjH2IoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjH2IoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:44:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43286AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:44:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305C32F4;
        Tue, 29 Aug 2023 01:44:39 -0700 (PDT)
Received: from [10.57.3.66] (unknown [10.57.3.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093D43F64C;
        Tue, 29 Aug 2023 01:43:57 -0700 (PDT)
Message-ID: <96d41d86-bfa2-f4d4-49ea-449c3471d036@arm.com>
Date:   Tue, 29 Aug 2023 09:43:56 +0100
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
 <311d0ecf-dddf-dcf5-9545-3f8a51634a9a@arm.com>
 <20230828213537.GA27629@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230828213537.GA27629@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 22:35, Will Deacon wrote:
> On Sun, Aug 27, 2023 at 11:11:16PM +0100, Suzuki K Poulose wrote:
>> On 21/08/2023 12:28, Will Deacon wrote:
>>> Hmm, the rationale behind your change to make the pdata allocation
>>> per-device in ("coresight: trbe: Allocate platform data per device")
>>> confuses me: with Anshuman's change to allocate the pdata using
>>> devm_kzalloc(), there shouldn't be any connections for the coresight
>>> core to trip over, should there?
>>
>> Anshuman's patch is working around the problem of "TRBE platform
>> device with ACPI doesn't have a valid companion device" - this is a problem
>> for the acpi_get_coresight_platform_data(). The work
>> around is to move the "allocation" from coresight_get_platform_data()
>> to the driver (given we don't need anything else from the ACPI except
>> the IRQ). That doesn't change *how* it is allocated.
>> Also please note that, the TRBE driver creates a TRBE coresight_device
>> per-CPU and the platform data is shared by all of these devices, which
>> the coresight core driver doesn't cope with. The other option is to
>> move the releasing of these platform-data to the individual drivers,
>> which is quite an invasive change. Or, make the core driver tolerate
>> a NULL platform data, which is also again invasive. So the merged fix
>> is correct and is still valid after this patch.
> 
> Ah, ok, so the problem with TRBE isn't anything to do with its connections,
> but simply because the pdata is shared?

Correct, thats an issue outside of the ACPI support. With ACPI, the 
coresight_get_platform_data() can't cope with the TRBE with missing
companion device, that is fixed by Anshuman's patch in this series.

Also, please could you confirm the plan forward for merging this
(next version of course) ?


Cheers
Suzuki

> 
> Will

