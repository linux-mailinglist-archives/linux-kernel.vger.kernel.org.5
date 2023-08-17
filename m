Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5E77FDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354284AbjHQSUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354321AbjHQSUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:20:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF19B2D5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:19:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF0DD75;
        Thu, 17 Aug 2023 11:20:39 -0700 (PDT)
Received: from [10.57.90.41] (unknown [10.57.90.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ADB23F64C;
        Thu, 17 Aug 2023 11:19:56 -0700 (PDT)
Message-ID: <a8623bd8-1df4-42b7-4993-006316594818@arm.com>
Date:   Thu, 17 Aug 2023 19:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify stage selection logic
Content-Language: en-GB
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Will Deacon <will@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
 <928822fd-642a-5ca7-7b42-dc7885f3cf51@arm.com>
 <CAKHBV27bsDWsS_dUsj=xdTfnc0CDhcH+0ZLZ2z481BZMsBQX4w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAKHBV27bsDWsS_dUsj=xdTfnc0CDhcH+0ZLZ2z481BZMsBQX4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-17 18:06, Michael Shavit wrote:
> On Fri, Aug 18, 2023 at 12:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> The reason it's like this is because of arm_smmu_enable_nesting(), which
>> *is* the additional thing that's going on with the stage selection logic.
>>
>> Thanks,
>> Robin.
> 
> Right, but arm_smmu_enable_nesting isn't involved in this computation
> at this point in the flow.
> 
> arm_smmu_enable_nesting returns early if smmu_domain->smmu isn't set,
> and smmu_domain->smmu is only set after arm_smmu_domain_finalise.
> So at this point, smmu_domain->stage is being initialized for the
> first time. If this code is responsible for handling some special
> nesting case, then it's probably not working as intended.

I think you may have misread that code...

Anyway, the point of the logic here is that it is not "selection", it 
is, as the comment says, "restriction" - i.e. it is checking that the 
already-selected stage is actually supported, and coercing it if not. 
The default selection for a newly-allocated domain is always implicitly 
ARM_SMMU_DOMAIN_S1 (which is explicitly defined as 0 to convey that 
significance), but it may be set to ARM_SMMU_DOMAIN_NESTED before the 
first attach finalises the pagetable format.

Obviously this could be clearer, especially for anyone not so familiar 
with all the history, but at this point I honestly don't think it's 
worth doing anything without completely ripping out 
arm_smmu_enable_nesting() as well. Jason already had a patch a while 
ago, and my bus rework is now also very close to the point of finally 
fixing iommu_domain_alloc() to be able to return working domains, such 
that all the "domain_finalise" bodges go away and that whole "modify the 
domain between allocation and attach" paradigm is no longer valid at all.

By this point I'm not too fussed about breaking the current meaning of 
ARM_SMMU_DOMAIN_NESTED any more. But what I definitely don't want to do 
is have a change like this which subtly but decisively breaks it while 
still leaving all the now-dead code in place ;)

Thanks,
Robin.
