Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833807E6DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbjKIPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344330AbjKIPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:43:59 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF7046B5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:42:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vw1KTVn_1699544525;
Received: from 30.25.226.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vw1KTVn_1699544525)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 23:42:06 +0800
Message-ID: <872a459d-449d-c057-625e-98c7c8b697ab@linux.alibaba.com>
Date:   Thu, 9 Nov 2023 23:42:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH -next V2] erofs: code clean up for function
 erofs_read_inode()
To:     Zizhi Wo <wozizhi@huawei.com>, xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        yangerkun@huawei.com
References: <20231109194821.1719430-1-wozizhi@huawei.com>
 <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
 <89069fa4-7347-4364-8793-1ce705a00b92@huawei.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <89069fa4-7347-4364-8793-1ce705a00b92@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/9 21:45, Zizhi Wo wrote:
> 
> 
> 在 2023/11/9 21:14, Gao Xiang 写道:
>> Hi,
>>
>> On 2023/11/10 03:48, WoZ1zh1 wrote:
>>> Because variables "die" and "copied" only appear in case
>>> EROFS_INODE_LAYOUT_EXTENDED, move them from the outer space into this
>>> case. Also, call "kfree(copied)" earlier to avoid double free in the
>>> "error_out" branch. Some cleanups, no logic changes.
>>>
>>> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
>>
>> Please help use your real name here...
>>
>>> ---
>>>   fs/erofs/inode.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>> index b8ad05b4509d..a388c93eec34 100644
>>> --- a/fs/erofs/inode.c
>>> +++ b/fs/erofs/inode.c
>>> @@ -19,7 +19,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>>       erofs_blk_t blkaddr, nblks = 0;
>>>       void *kaddr;
>>>       struct erofs_inode_compact *dic;
>>> -    struct erofs_inode_extended *die, *copied = NULL;
>>>       unsigned int ifmt;
>>>       int err;
>>> @@ -53,6 +52,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>>       switch (erofs_inode_version(ifmt)) {
>>>       case EROFS_INODE_LAYOUT_EXTENDED:
>>> +        struct erofs_inode_extended *die, *copied = NULL;
>>
>> Thanks for the patch, but in my own opinion:
>>
>> 1) It doesn't simplify the code
> OK, I'm sorry for the noise(;´༎ຶД༎ຶ`)
>>
>> 2) We'd like to avoid defining variables like this (in the
>>     switch block), and I even don't think this patch can compile.
> I tested this patch with gcc-12.2.1 locally and it compiled
> successfully. I'm not sure if this patch will fail in other environment
> with different compiler...

For example, it fails as below on gcc 10.2.1:

fs/erofs/inode.c: In function 'erofs_read_inode':
fs/erofs/inode.c:55:3: error: a label can only be part of a statement and a declaration is not a statement
    55 |   struct erofs_inode_extended *die, *copied = NULL;
       |   ^~~~~~

> 
>> 3) The logic itself is also broken...

Maybe I was missing something, but this usage makes
me uneasy...

Thanks,
Gao Xiang

> 
> Sorry, but I just don't understand why the logic itself is broken, and
> can you please explain more?
> 
> Thanks,
> Zizhi Wo
> 
>> Thanks,
>> Gao Xiang
