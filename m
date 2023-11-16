Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE18E7EE617
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjKPRn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKPRn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:43:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62735A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:43:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB40A1595;
        Thu, 16 Nov 2023 09:44:37 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2A733F6C4;
        Thu, 16 Nov 2023 09:43:50 -0800 (PST)
Message-ID: <b541f87c-fa8e-4b09-bf1c-68829bc9e6c9@arm.com>
Date:   Thu, 16 Nov 2023 17:43:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd/selftest: Fix dirty_bitmap tests
Content-Language: en-GB
To:     Joao Martins <joao.m.martins@oracle.com>, kevin.tian@intel.com,
        jgg@ziepe.ca
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <90e083045243ef407dd592bb1deec89cd1f4ddf2.1700153535.git.robin.murphy@arm.com>
 <72f0e75b-6c91-4c17-beb2-3f198ed05cd0@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <72f0e75b-6c91-4c17-beb2-3f198ed05cd0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 5:28 pm, Joao Martins wrote:
> On 16/11/2023 16:52, Robin Murphy wrote:
>> The ASSERT_EQ() macro sneakily expands to two statements, so the loop
>> here needs braces to ensure it captures both and actually terminates the
>> test upon failure.
> 
> Ugh
> 
>> Where these tests are currently failing on my arm64
>> machine, this reduces the number of logged lines from a rather
>> unreasonable ~197,000 down to 10. While we're at it, we can also clean
>> up the tautologous "count" calculations whose assertions can never fail
>> unless mathematics and/or the C language become fundamentally broken.
>>
>> Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> I was going to say that the second assert is useful, but we are already test the
> number of bits we set against what the mock domain set after
> mock_domain_set_dirty(). So the second is redundantly testing the same, and can
> be removed as you are doing. Thanks for fixing this.

Yeah, it's still effectively just counting half the number of loop 
iterations executed, but since there's no control flow that could exit 
the loop early and still reach the assertion, it must always be true 
following the previous assertion that out_dirty == nr == nbits/2.

> I would suggest the subject to:
> 
> 	iommufd/selftest: Fix _test_mock_dirty_bitmaps()
> 
> Because dirty-bitmap tests seems to imply the whole fixture, which covers more
> than the bitmaps.

Sure, that sounds reasonable. Jason, Kevin, would you want a v2 for that 
or could it be fixed up when applying?

>> ---
>>   tools/testing/selftests/iommu/iommufd_utils.h | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
>> index 050e9751321c..ad9202335656 100644
>> --- a/tools/testing/selftests/iommu/iommufd_utils.h
>> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
>> @@ -293,15 +293,13 @@ static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
>>   				    __u64 bitmap_size, __u32 flags,
>>   				    struct __test_metadata *_metadata)
>>   {
>> -	unsigned long i, count, nbits = bitmap_size * BITS_PER_BYTE;
>> +	unsigned long i, nbits = bitmap_size * BITS_PER_BYTE;
>>   	unsigned long nr = nbits / 2;
>>   	__u64 out_dirty = 0;
>>   
>>   	/* Mark all even bits as dirty in the mock domain */
>> -	for (count = 0, i = 0; i < nbits; count += !(i % 2), i++)
>> -		if (!(i % 2))
>> -			set_bit(i, (unsigned long *)bitmap);
>> -	ASSERT_EQ(nr, count);
>> +	for (i = 0; i < nbits; i += 2)
>> +		set_bit(i, (unsigned long *)bitmap);
>>   
>>   	test_cmd_mock_domain_set_dirty(fd, hwpt_id, length, iova, page_size,
>>   				       bitmap, &out_dirty);
>> @@ -311,9 +309,10 @@ static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
>>   	memset(bitmap, 0, bitmap_size);
>>   	test_cmd_get_dirty_bitmap(fd, hwpt_id, length, iova, page_size, bitmap,
>>   				  flags);
>> -	for (count = 0, i = 0; i < nbits; count += !(i % 2), i++)
>> +	/* Beware ASSERT_EQ() is two statements -- braces are not redundant! */
>> +	for (i = 0; i < nbits; i++) {
>>   		ASSERT_EQ(!(i % 2), test_bit(i, (unsigned long *)bitmap));
>> -	ASSERT_EQ(count, out_dirty);
>> +	}
>>   
>>   	memset(bitmap, 0, bitmap_size);
>>   	test_cmd_get_dirty_bitmap(fd, hwpt_id, length, iova, page_size, bitmap,
> 
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> Tested-by: Joao Martins <joao.m.martins@oracle.com>

Thanks!

Robin.
