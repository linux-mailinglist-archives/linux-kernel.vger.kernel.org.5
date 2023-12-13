Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FA28113D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjLMN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbjLMN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:56:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC1D73AB5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:55:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D486BC15;
        Wed, 13 Dec 2023 05:55:17 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A66F73F738;
        Wed, 13 Dec 2023 05:54:30 -0800 (PST)
Message-ID: <3c7665ff-b2e2-f10d-a78a-4ddc1791926f@arm.com>
Date:   Wed, 13 Dec 2023 13:54:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/8] coresight: Fix issue where a source device's helpers
 aren't disabled
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231212155407.1429121-1-james.clark@arm.com>
 <20231212155407.1429121-2-james.clark@arm.com>
 <a1ab2481-0ec0-4e29-b6af-bcce4cf0b57d@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <a1ab2481-0ec0-4e29-b6af-bcce4cf0b57d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2023 17:44, Suzuki K Poulose wrote:
> Hi James
> 
> On 12/12/2023 15:53, James Clark wrote:
>> The linked commit reverts the change that accidentally used some sysfs
>> enable/disable functions from Perf which broke the refcounting, but it
>> also removes the fact that the sysfs disable function disabled the
>> helpers.
> 
> 
>>
>> Add a new wrapper function that does both which is used by both Perf and
>> sysfs, and label the sysfs disable function appropriately. The naming of
>> all of the functions will be tidied up later to avoid this happening
>> again.
>>
>> Fixes: 287e82cf69aa ("coresight: Fix crash when Perf and sysfs modes
>> are used concurrently")
> 
> But we still don't "enable" the helpers from perf mode with this patch.
> i.e., we use source_ops()->enable directly. So, I guess this patch
> doesn't fix a bug as such. But that said, it would be good to
> enable/disable helpers for sources, in perf mode.
> 
> Suzuki

We do, it happens in coresight_enable_path() which Perf uses. I added
the comment below about that.

 [...]

>>   +/*
>> + * Helper function to call source_ops(csdev)->disable and also
>> disable the
>> + * helpers.
>> + *
>> + * There is an imbalance between coresight_enable_path() and
>> + * coresight_disable_path(). Enabling also enables the source's
>> helpers as part
>> + * of the path, but disabling always skips the first item in the path
>> (which is
>> + * the source), so sources and their helpers don't get disabled as
>> part of that
>> + * function and we need the extra step here.
>> + */

The reason coresight_disable_path() skips the first item is because it's
used after errors where a path is only partially enabled and it unwinds,
skipping the last item, because the last item didn't enable.

It seemed a bit more intrusive to change that, and it's already working.
