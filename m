Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EBC8130E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573201AbjLNNGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573177AbjLNNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:06:44 -0500
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F979113
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:06:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SrXdv3BRwz29fpL;
        Thu, 14 Dec 2023 21:05:39 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
        by mail.maildlp.com (Postfix) with ESMTPS id E3A3A1A0190;
        Thu, 14 Dec 2023 21:06:47 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 21:06:47 +0800
Subject: Re: [PATCH] ext4: fix inconsistent between segment fstrim and full
 fstrim
To:     Jan Kara <jack@suse.cz>
References: <20231214064635.4128391-1-yebin10@huawei.com>
 <20231214085834.svce3mvfnctikwyq@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <657AFDE6.1090606@huawei.com>
Date:   Thu, 14 Dec 2023 21:06:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20231214085834.svce3mvfnctikwyq@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/14 16:58, Jan Kara wrote:
> On Thu 14-12-23 14:46:35, Ye Bin wrote:
>> There will not issue discard cmd when do segment fstrim for ext4 fs, however,
>> if full fstrim for the same fs will issue discard cmd.
>> Above issue may happens as follows:
>> Precondition:
>> 1. Fstrim range [0, 15] and [16, 31];
>> 2. Discard granularity is 16;
>>              Range1          Range2
>>        1111000000000000 0000111010101011
>> There's no free space length large or equal than 16 in 'Range1' or 'Range2'.
>> As ext4_try_to_trim_range() only search free space among range which user
>> specified. However, there's maximum free space length 16 in 'Range1'+ 'Range2'.
>> To solve above issue, we need to find the longest free space to discard.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> OK, I agree that there is this behavioral difference. However is that a
> practical problem? I mean I would not expect the range to be particularly
> small, rather something like 1GB and then these boundary conditions don't
> really matter. This is also sensible so that we can properly track whether
> the whole block group was trimmed or not. Finally I'd also argue that
> trimming outside of specified range might be unexpected for the user. So a
> *fix* for this in my opinion lays in userspace which needs to select
> sensible ranges to use for trimming.
>
> 								Honza
Thanks for your reply.
Our product fstrim entire file system, found to take a long time, thus 
affecting other processes.
So they want to segment the file system fstrim based on the IO of the 
system. But they found
that fragmented fstrims didn't work the same as fstrim  for the entire 
file system.
Users do not know the distribution of free blocks in the file system, 
and they do not know the
reasonable range. The user's simple perception is that the effect of 
segmented fstrim and full
fstrim should be consistent.
I researched the implementation of fstrim on the XFS file system, and 
for the scenario described
in my patch, the results of both operations are consistent.
>> ---
>>   fs/ext4/mballoc.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index d72b5e3c92ec..d195461123d8 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6753,13 +6753,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
>>   __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   {
>> -	ext4_grpblk_t next, count, free_count;
>> +	ext4_grpblk_t next, count, free_count, last, origin_start;
>>   	bool set_trimmed = false;
>>   	void *bitmap;
>>   
>> +	last = ext4_last_grp_cluster(sb, e4b->bd_group);
>>   	bitmap = e4b->bd_bitmap;
>> -	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
>> +	if (start == 0 && max >= last)
>>   		set_trimmed = true;
>> +	origin_start = start;
>>   	start = max(e4b->bd_info->bb_first_free, start);
>>   	count = 0;
>>   	free_count = 0;
>> @@ -6768,7 +6770,10 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   		start = mb_find_next_zero_bit(bitmap, max + 1, start);
>>   		if (start > max)
>>   			break;
>> -		next = mb_find_next_bit(bitmap, max + 1, start);
>> +
>> +		next = mb_find_next_bit(bitmap, last + 1, start);
>> +		if (origin_start == 0 && next >= last)
>> +			set_trimmed = true;
>>   
>>   		if ((next - start) >= minblocks) {
>>   			int ret = ext4_trim_extent(sb, start, next - start, e4b);
>> -- 
>> 2.31.1
>>

