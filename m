Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96E78FD18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349395AbjIAMWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjIAMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:22:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED64FCFE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:22:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E428FEC;
        Fri,  1 Sep 2023 05:23:26 -0700 (PDT)
Received: from [10.57.91.85] (unknown [10.57.91.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A653FBD2;
        Fri,  1 Sep 2023 05:22:45 -0700 (PDT)
Message-ID: <134faf1d-d662-0e26-d9db-c98645ef6243@arm.com>
Date:   Fri, 1 Sep 2023 13:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V2] coresight: tmc: Make etr buffer mode user configurable
 from sysfs
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     scclevenger@os.amperecomputing.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230818082112.554638-1-anshuman.khandual@arm.com>
 <bedcf27e-b273-075f-3d7b-eb99b07e7c91@arm.com>
 <b2cf0173-c404-d7d6-9eb8-054e160ca4e5@os.amperecomputing.com>
 <ffa90e80-c249-42d5-26f1-dc022d91e5a9@os.amperecomputing.com>
 <391951c3-7da9-3965-acf8-f3b31f822879@os.amperecomputing.com>
 <1b2a035c-489e-ace9-f851-c1ec157ff9fa@arm.com>
 <cc1b1082-2bcb-9d76-afc7-0e12edd694f0@os.amperecomputing.com>
 <f9fddb60-6976-6d99-fcc2-8011d2fadeb7@arm.com>
In-Reply-To: <f9fddb60-6976-6d99-fcc2-8011d2fadeb7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve

On 30/08/2023 17:04, Suzuki K Poulose wrote:
> Cc: Sudeep
> 
> Hi Steve
> 
> On 28/08/2023 17:35, Steve Clevenger wrote:
>>
>> Hi Suzuki,
>>
>> On 8/27/2023 2:35 PM, Suzuki K Poulose wrote:
>>> Hi Steve
>>>
>>> On 26/08/2023 01:14, Steve Clevenger wrote:
>>>>
>>>> Unfortunately, I tested with the original patch not [PATCH V2]. I've
>>>> remedied this. My results below:
>>>>
>>>> [root@sut01sys-b212 linux]# cat
>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_modes_available
>>>> auto flat catu
>>>> [root@sut01sys-b212 linux]# cat
>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>> auto
>>>> [root@sut01sys-b212 linux]# echo "catu" >
>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>> [root@sut01sys-b212 linux]# cat
>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>> catu
>>>>
>>>> As with the V1 patch, auto defaults to catu.
>>>>
>>>> I expected to see tmc-sg (former default) as an available mode, but do
>>>> not. As I recall, the buffer mode defaulted to ETR scatter-gather prior
>>>> to this patch. Must this capability now be explicitly advertised? I've
>>>> seen this done as "arm,scatter-gather" in device trees, but not used by
>>>> Ampere. Perhaps someone can enlighten me.
>>>
>>> Yes, you must add that property to the TMC-ETR node (for both DT and
>>> ACPI). In the past, almost all of the TMC-ETRs (except Juno board)
>>> locked up the system while using the SG mode (due to the interconnect
>>> issues, something to do with the transaction). Thus, we decided to
>>> add a property explicitly enabling this for a given platform.
>>>
>>> When you mentioned, it was using TMC-ETR SG mode, how did you verify
>>> this ? Please be aware that the table allocation code etc are shared
>>> by both TMC-SG and CATU.
>>>
>>
>> You might recall how this started. I had no way to test the CATU due to
>> the order the ETR modes defaulted (Flat, ETR-SG, CATU). For test
>> purposes, I programmatically swapped the ETR-SG/CATU order and could
>> then verify CATU operation by the driver calling into CATU code. This
> 
> So, were you using the DT based boot for the above runs ?
> 
>> suggests Flat mode was bypassed, and the driver defaulted to ETR-SG
>> prior to this hack. This didn't offer the user any control, hence my
>> feature request. Note that most of the early Ampere self-hosted trace
>> collection used ETR-SG. Now I can't select it.
> 
> 
>>
>> How is this property described in the ACPI? The "ACPI for CoreSight™ 1.1
>> Platform Design Document" (DEN0067) doesn't describe this.
> 
> This is not specified in the ACPI platform design document. I can get
> it fixed. Ideally we need a property describing that the scatter-gather
> mode is safe to use.

Looks like this is not straight forward copying of DT property. We are
investigating this on our side and will get back to you.

Suzuki


> 
> DT uses "arm,scatter-gather" property [0] and this is what we now expect
> in the ACPI based systems too.
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml#:~:text=71-,72,-73
> 
> Does it sound fine ?
> 
> Suzuki
> 
>>
>> Thanks,
>> Steve
>>
>>
>>> Kind regards
>>> Suzuki
>>>
>>>>
>>>> Steve C.
>>>>
>>>> On 8/23/2023 4:10 PM, Steve Clevenger wrote:
>>>>>
>>>>> Here's some quick feedback. My system shows two modes available; auto
>>>>> catu
>>>>>
>>>>> etr_buf_mode_current is writable. I expected to see tmc-sg (former
>>>>> default) listed in etr_buf_modes_available but it doesn't show up.
>>>>>
>>>>> Note that both the auto and catu etr_buf_mode_current settings default
>>>>> to catu. My understanding is auto should revert to the default 
>>>>> behavior.
>>>>> On my system the default was tmc-sg.
>>>>>
>>>>> More later.
>>>>>
>>>>> [root@sut01sys-b212 kernel]# cat
>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_modes_available
>>>>>
>>>>> auto catu
>>>>> [root@sut01sys-b212 kernel]# cat
>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>> catu
>>>>> [root@sut01sys-b212 kernel]# echo "catu" >
>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>> [root@sut01sys-b212 kernel]# cat
>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>> catu
>>>>>
>>>>> Steve C.
>>>>>
>>>>>
>>>>> On 8/21/2023 12:40 PM, Steve Clevenger wrote:
>>>>>>
>>>>>> Hi Suzuki,
>>>>>>
>>>>>> I may be able to test it this week. You've already pointed me at the
>>>>>> patch thread(s). The main holdup is I need to merge the 6.6 pending
>>>>>> platform work in order to use the Ampere ACPI. I couldn't get these
>>>>>> patches to apply directly to 6.4 last I tried.
>>>>>>
>>>>>> Steve C.
>>>>>>
>>>>>> On 8/18/2023 2:39 AM, Suzuki K Poulose wrote:
>>>>>>> Cc: Steve
>>>>>>>
>>>>>>> Steve,
>>>>>>>
>>>>>>> Are you able to test this with CATU ?
>>>>>>>
>>>>>>>
>>>>>>> On 18/08/2023 09:21, Anshuman Khandual wrote:
>>>>>>>> Currently TMC-ETR automatically selects the buffer mode from all
>>>>>>>> available
>>>>>>>> methods in the following sequentially fallback manner - also in 
>>>>>>>> that
>>>>>>>> order.
>>>>>>>>
>>>>>>>> 1. FLAT mode with or without IOMMU
>>>>>>>> 2. TMC-ETR-SG (scatter gather) mode when available
>>>>>>>> 3. CATU mode when available
>>>>>>>>
>>>>>>>> But this order might not be ideal for all situations. For 
>>>>>>>> example if
>>>>>>>> there
>>>>>>>> is a CATU connected to ETR, it may be better to use TMC-ETR scatter
>>>>>>>> gather
>>>>>>>> method, rather than CATU. But hard coding such order changes will
>>>>>>>> prevent
>>>>>>>> us from testing or using a particular mode. This change provides
>>>>>>>> following
>>>>>>>> new sysfs tunables for the user to control TMC-ETR buffer mode
>>>>>>>> explicitly,
>>>>>>>> if required. This adds following new sysfs files for buffer mode
>>>>>>>> selection
>>>>>>>> purpose explicitly in the user space.
>>>>>>>>
>>>>>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_modes_available
>>>>>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
>>>>>>>>
>>>>>>>> $ cat buf_modes_available
>>>>>>>> auto flat tmc-sg catu    ------------------> Supported TMC-ETR 
>>>>>>>> buffer
>>>>>>>> modes
>>>>>>>>
>>>>>>>> $ echo catu > buf_mode_preferred   -------> Explicit buffer mode
>>>>>>>> request
>>>>>>>>
>>>>>>>> But explicit user request has to be within supported ETR buffer 
>>>>>>>> modes
>>>>>>>> only.
>>>>>>>> These sysfs interface files are exclussive to ETR, and hence these
>>>>>>>> are
>>>>>>>> not
>>>>>>>> available for other TMC devices such as ETB or ETF etc.
>>>>>>>>
>>>>>>>> A new auto' mode (i.e ETR_MODE_AUTO) has been added to help 
>>>>>>>> fallback
>>>>>>>> to the
>>>>>>>> existing default behaviour, when user provided preferred buffer 
>>>>>>>> mode
>>>>>>>> fails.
>>>>>>>> ETR_MODE_FLAT and ETR_MODE_AUTO are always available as preferred
>>>>>>>> modes.
>>>>>>>>
>>>>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>>>>>> Cc: James Clark <james.clark@arm.com>
>>>>>>>> Cc: Leo Yan <leo.yan@linaro.org>
>>>>>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>>>>>> Cc: coresight@lists.linaro.org
>>>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>>> ---
>>>>>>>> This applies on v6.5-rc6
>>>>>>>>
>>>>>>>> Changes in V2:
>>>>>>>>
>>>>>>>> - Renamed sysfs file etr_buf_modes_available as buf_modes_available
>>>>>>>> - Renamed sysfs file buf_mode_current as buf_mode_preferred
>>>>>>>> - Renamed etr_supports_flat_mode() as etr_can_use_flat_mode()
>>>>>>>> - Renamed coresight_tmc_groups[] as coresight_etf_groups[]
>>>>>>>> - Reused coresight_tmc_group[] for trigger_cntr and buffer_size
>>>>>>>> - Fallback trying ETR_MODE_AUTO when user preferred mode fails
>>>>>>>> - Moved ETR sysfs details into coresight-tmc-etr.c
>>>>>>>> - Dropped etr_can_use_flat_mode() check while offering 
>>>>>>>> ETR_MODE_FLAT
>>>>>>>> in sysfs
>>>>>>>> - Moved struct etr_buf_hw inside coresight-tmc-etr.c
>>>>>>>> - Moved get_etr_buf_hw() and etr_can_use_flat_mode() inside
>>>>>>>> coresight-tmc-etr.c
>>>>>>>> - Updated month in
>>>>>>>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>>>>>>>
>>>>>>>> Changes in V1:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/all/20230728084837.276551-1-anshuman.khandual@arm.com/
>>>>>>>>
>>>>>>>>     .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
>>>>>>>>     .../hwtracing/coresight/coresight-tmc-core.c  |  15 ++-
>>>>>>>>     .../hwtracing/coresight/coresight-tmc-etr.c   | 111
>>>>>>>> ++++++++++++++++--
>>>>>>>>     drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
>>>>>>>>     4 files changed, 131 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>>>
>>>>>>> Looks good to me.
>>>>>>>
>>>>>>> Suzuki
>>>>>>>
>>>>>>>
>>>
> 

