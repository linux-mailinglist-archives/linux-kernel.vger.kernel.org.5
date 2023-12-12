Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ACE80E0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjLLBFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345638AbjLLBFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:05:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D12AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:05:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148FEC433C8;
        Tue, 12 Dec 2023 01:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702343117;
        bh=gdeYmzLGW6q5hnej08l9tQkVl0oulGvc8W5Uv0V0XJ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S8nkUR+eJnFc4803EYqwm1jnlA4pKdl+goIF7OpuC/PzMZpNlElrOu6B5a8nSHAuU
         g96ltQKNBehLQlDsesGAaTn+vxLfhhRrQcmXBi67Ggd+D4BrNnM4tdMr0ejRskWPyb
         VeI/LsDc4hwOS3QGi32Ul1F8kjbb4/EhrnlNLkT3rhot5/3ovNLPgj5/PM+MBIHSSx
         xrF+yE6qqZNLUVxX3yublQapAxkv9aztESZmnOtsNCOFuRyEWVXsJOGEEByiA/snF5
         kZ72AETixuOiR9pOmZ1Z5iZfeeR7VgxYu4QUGiXTlYWnW0iHh+YPDRqgoxU8cJbbde
         +3L1bv95hg13g==
Message-ID: <5884e300-5384-4a49-9f8d-8cced50f4e6d@kernel.org>
Date:   Tue, 12 Dec 2023 09:05:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] f2fs: fix to restrict condition of compress inode
 conversion
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20231210113547.3412782-1-chao@kernel.org>
 <20231210113547.3412782-5-chao@kernel.org> <ZXeJKCNrxcit0eTC@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZXeJKCNrxcit0eTC@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/12 6:11, Jaegeuk Kim wrote:
> On 12/10, Chao Yu wrote:
>> This patch adds i_size check during compress inode conversion in order
>> to avoid .page_mkwrite races w/ conversion.
> 
> Which race condition do you see?

Something like:

- f2fs_setflags_common
  - check S_ISREG && F2FS_HAS_BLOCKS
					- mkwrite
					 - f2fs_get_block_locked
					  : update metadata in old inode's disk layout
  - set_compress_context

Thanks,

> 
>>
>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/f2fs.h | 8 +++++++-
>>   fs/f2fs/file.c | 5 ++---
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 65294e3b0bef..c9b8a1953913 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4397,13 +4397,19 @@ static inline int set_compress_context(struct inode *inode)
>>   #endif
>>   }
>>   
>> +static inline bool inode_has_data(struct inode *inode)
>> +{
>> +	return (S_ISREG(inode->i_mode) &&
>> +		(F2FS_HAS_BLOCKS(inode) || i_size_read(inode)));
>> +}
>> +
>>   static inline bool f2fs_disable_compressed_file(struct inode *inode)
>>   {
>>   	struct f2fs_inode_info *fi = F2FS_I(inode);
>>   
>>   	if (!f2fs_compressed_file(inode))
>>   		return true;
>> -	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
>> +	if (inode_has_data(inode))
>>   		return false;
>>   
>>   	fi->i_flags &= ~F2FS_COMPR_FL;
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 1a3c29a9a6a0..8af4b29c3e1a 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1922,8 +1922,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>   
>>   			f2fs_down_write(&F2FS_I(inode)->i_sem);
>>   			if (!f2fs_may_compress(inode) ||
>> -					(S_ISREG(inode->i_mode) &&
>> -					F2FS_HAS_BLOCKS(inode))) {
>> +					inode_has_data(inode)) {
>>   				f2fs_up_write(&F2FS_I(inode)->i_sem);
>>   				return -EINVAL;
>>   			}
>> @@ -3996,7 +3995,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>>   		goto out;
>>   	}
>>   
>> -	if (F2FS_HAS_BLOCKS(inode)) {
>> +	if (inode_has_data(inode)) {
>>   		ret = -EFBIG;
>>   		goto out;
>>   	}
>> -- 
>> 2.40.1
