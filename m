Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F6811959
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjLMQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjLMQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:28:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 514D2B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:28:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1E6BC15;
        Wed, 13 Dec 2023 08:29:37 -0800 (PST)
Received: from [10.57.45.12] (unknown [10.57.45.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B4F33F738;
        Wed, 13 Dec 2023 08:28:50 -0800 (PST)
Message-ID: <68d6f2bb-3c18-4dce-ba32-6925955dcc35@arm.com>
Date:   Wed, 13 Dec 2023 16:28:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] coresight: Fix issue where a source device's helpers
 aren't disabled
Content-Language: en-GB
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231212155407.1429121-1-james.clark@arm.com>
 <20231212155407.1429121-2-james.clark@arm.com>
 <a1ab2481-0ec0-4e29-b6af-bcce4cf0b57d@arm.com>
 <3c7665ff-b2e2-f10d-a78a-4ddc1791926f@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <3c7665ff-b2e2-f10d-a78a-4ddc1791926f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2023 13:54, James Clark wrote:
> 
> 
> On 12/12/2023 17:44, Suzuki K Poulose wrote:
>> Hi James
>>
>> On 12/12/2023 15:53, James Clark wrote:
>>> The linked commit reverts the change that accidentally used some sysfs
>>> enable/disable functions from Perf which broke the refcounting, but it
>>> also removes the fact that the sysfs disable function disabled the
>>> helpers.
>>
>>
>>>
>>> Add a new wrapper function that does both which is used by both Perf and
>>> sysfs, and label the sysfs disable function appropriately. The naming of
>>> all of the functions will be tidied up later to avoid this happening
>>> again.
>>>
>>> Fixes: 287e82cf69aa ("coresight: Fix crash when Perf and sysfs modes
>>> are used concurrently")
>>
>> But we still don't "enable" the helpers from perf mode with this patch.
>> i.e., we use source_ops()->enable directly. So, I guess this patch
>> doesn't fix a bug as such. But that said, it would be good to
>> enable/disable helpers for sources, in perf mode.
>>
>> Suzuki
> 
> We do, it happens in coresight_enable_path() which Perf uses. I added
> the comment below about that.

Ah, I see. That indeed is a bit confusing. And I think all users of 
coresight_enable_path() enables the source right after. So, I don't
see any point in having it separate. That said, this fix makes sense
and apologies for the confusion. We could may be cleanup the 
enable_path() to enable the source too, in a separate patch.

Suzuki


> 
>   [...]
> 
>>>    +/*
>>> + * Helper function to call source_ops(csdev)->disable and also
>>> disable the
>>> + * helpers.
>>> + *
>>> + * There is an imbalance between coresight_enable_path() and
>>> + * coresight_disable_path(). Enabling also enables the source's
>>> helpers as part
>>> + * of the path, but disabling always skips the first item in the path
>>> (which is
>>> + * the source), so sources and their helpers don't get disabled as
>>> part of that
>>> + * function and we need the extra step here.
>>> + */
> 
> The reason coresight_disable_path() skips the first item is because it's
> used after errors where a path is only partially enabled and it unwinds,
> skipping the last item, because the last item didn't enable.
> 
> It seemed a bit more intrusive to change that, and it's already working.

