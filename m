Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E4B78C8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjH2Phb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjH2PhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:37:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45704193
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:37:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A2472F4;
        Tue, 29 Aug 2023 08:37:45 -0700 (PDT)
Received: from [10.1.34.35] (010265703453.arm.com [10.1.34.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A68AF3F738;
        Tue, 29 Aug 2023 08:37:04 -0700 (PDT)
Message-ID: <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
Date:   Tue, 29 Aug 2023 16:37:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in struct
 io_pgtable_cfg
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, jgg@nvidia.com, joro@8bytes.org,
        jean-philippe@linaro.org, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
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

On 2023-08-22 17:42, Nicolin Chen wrote:
> On Tue, Aug 22, 2023 at 10:19:21AM +0100, Robin Murphy wrote:
> 
>>>    out_free_data:
>>> @@ -1071,6 +1073,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>>>                                          ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
>>>        if (cfg->coherent_walk)
>>>                cfg->arm_mali_lpae_cfg.transtab |= ARM_MALI_LPAE_TTBR_SHARE_OUTER;
>>> +     cfg->nents_per_pgtable = 1 << data->bits_per_level;
>>
>> The result of this highly complex and expensive calculation is clearly
>> redundant with the existing bits_per_level field, so why do we need to
>> waste space storing when the driver could simply use bits_per_level?
> 
> bits_per_level is in the private struct arm_lpae_io_pgtable, while
> drivers can only access struct io_pgtable_cfg. Are you suggesting
> to move bits_per_level out of the private struct arm_lpae_io_pgtable
> to the public struct io_pgtable_cfg?
> 
> Or am I missing another bits_per_level?

Bleh, apologies, I always confuse myself trying to remember the fiddly 
design of io-pgtable data. However, I think this then ends up proving 
the opposite point - the number of pages per table only happens to be a 
fixed constant for certain formats like LPAE, but does not necessarily 
generalise. For instance for a single v7s config it would be 1024 or 256 
or 16 depending on what has actually been unmapped.

The mechanism as proposed implicitly assumes LPAE format, so I still 
think we're better off making that assumption explicit. And at that 
point arm-smmu-v3 can then freely admit it already knows the number is 
simply 1/8th of the domain page size.

Thanks,
Robin.
