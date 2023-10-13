Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128347C7F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJMIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:03:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CAAE83;
        Fri, 13 Oct 2023 01:03:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6F8E11FB;
        Fri, 13 Oct 2023 01:03:51 -0700 (PDT)
Received: from [10.57.80.116] (unknown [10.57.80.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C6C93F7A6;
        Fri, 13 Oct 2023 01:03:10 -0700 (PDT)
Message-ID: <ac2696c0-d4f5-4222-9b54-f574ec2049f4@arm.com>
Date:   Fri, 13 Oct 2023 09:03:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal/core: Hardening the self-encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
 <a6b51de7-4f56-4db9-a7dd-60555ac6c37f@arm.com>
 <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/23 14:14, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 12/10/2023 14:01, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> On 10/12/23 11:26, Daniel Lezcano wrote:
>>> The thermal private header has leaked all around the drivers which
>>> interacted with the core internals. The thermal zone structure which
>>> was part of the exported header led also to a leakage of the fields
>>> into the different drivers, making very difficult to improve the core
>>> code without having to change the drivers.
>>>
>>> Now we mostly fixed how the thermal drivers were interacting with the
>>> thermal zones (actually fixed how they should not interact). The
>>> thermal zone structure will be moved to the private thermal core
>>> header. This header has been removed from the different drivers and
>>> must belong to the core code only. In order to prevent this private
>>> header to be included again in the drivers, make explicit only the
>>> core code can include this header by defining a THERMAL_CORE_SUBSYS
>>> macro. The private header will contain a check against this macro.
>>>
>>> The Tegra SoCtherm driver needs to access thermal_core.h to have the
>>> get_thermal_instance() function definition. It is the only one
>>> remaining driver which need to access the thermal_core.h header, so
>>> the check will emit a warning at compilation time.
>>>
>>> Thierry Reding is reworking the driver to get rid of this function [1]
>>> and thus when the changes will be merged, the compilation warning will
>>> be converted to a compilation error, closing definitively the door to
>>> the drivers willing to play with the thermal zone device internals.
>>
>> That looks like a good idea. Although, shouldn't we avoid the
>> compilation warnings and just first merge the fixes for drivers?
> 
> Yes, we should but there is the series for nvidia (pointed in the 
> changelog) which need a slight refresh for the bindings AFAIR. That 
> series is since March 2023 and Thierry seems busy [1]. I'm holding the 
> hardening since then.
> 
> So I don't know how to make progress on this? I was assuming we can 
> merge this series and let the compiler recall what has to be fixed.
> 
> [1] https://lore.kernel.org/all/ZK14edZUih1kH_sZ@orome/
> 
> and as soon as it is fixed, we convert the WARNING to ERROR :P
> 
> 
> 
> 

OK, so that should be good for possible distro configs IMO.
The chicken egg problem should be addressed and we can start from
this patch approach.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
