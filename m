Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C37E6B60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKINp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjKINpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:45:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9A430CF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:45:53 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SR3BC5Qv8zfb1J;
        Thu,  9 Nov 2023 21:45:39 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 21:45:49 +0800
Message-ID: <89069fa4-7347-4364-8793-1ce705a00b92@huawei.com>
Date:   Thu, 9 Nov 2023 21:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next V2] erofs: code clean up for function
 erofs_read_inode()
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
        <chao@kernel.org>
CC:     <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yangerkun@huawei.com>
References: <20231109194821.1719430-1-wozizhi@huawei.com>
 <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
From:   Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/9 21:14, Gao Xiang 写道:
> Hi,
> 
> On 2023/11/10 03:48, WoZ1zh1 wrote:
>> Because variables "die" and "copied" only appear in case
>> EROFS_INODE_LAYOUT_EXTENDED, move them from the outer space into this
>> case. Also, call "kfree(copied)" earlier to avoid double free in the
>> "error_out" branch. Some cleanups, no logic changes.
>>
>> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
> 
> Please help use your real name here...
> 
>> ---
>>   fs/erofs/inode.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index b8ad05b4509d..a388c93eec34 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -19,7 +19,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>       erofs_blk_t blkaddr, nblks = 0;
>>       void *kaddr;
>>       struct erofs_inode_compact *dic;
>> -    struct erofs_inode_extended *die, *copied = NULL;
>>       unsigned int ifmt;
>>       int err;
>> @@ -53,6 +52,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>       switch (erofs_inode_version(ifmt)) {
>>       case EROFS_INODE_LAYOUT_EXTENDED:
>> +        struct erofs_inode_extended *die, *copied = NULL;
> 
> Thanks for the patch, but in my own opinion:
> 
> 1) It doesn't simplify the code
OK, I'm sorry for the noise(;´༎ຶД༎ຶ`)
> 
> 2) We'd like to avoid defining variables like this (in the
>     switch block), and I even don't think this patch can compile.
I tested this patch with gcc-12.2.1 locally and it compiled
successfully. I'm not sure if this patch will fail in other environment
with different compiler...

> 3) The logic itself is also broken...

Sorry, but I just don't understand why the logic itself is broken, and
can you please explain more?

Thanks,
Zizhi Wo

> Thanks,
> Gao Xiang
> 
>> +
>>           vi->inode_isize = sizeof(struct erofs_inode_extended);
>>           /* check if the extended inode acrosses block boundary */
>>           if (*ofs + vi->inode_isize <= sb->s_blocksize) {
>> @@ -98,6 +99,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>               inode->i_rdev = 0;
>>               break;
>>           default:
>> +            kfree(copied);
>>               goto bogusimode;
>>           }
>>           i_uid_write(inode, le32_to_cpu(die->i_uid));
>> @@ -117,7 +119,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>               /* fill chunked inode summary info */
>>               vi->chunkformat = le16_to_cpu(die->i_u.c.format);
>>           kfree(copied);
>> -        copied = NULL;
>>           break;
>>       case EROFS_INODE_LAYOUT_COMPACT:
>>           vi->inode_isize = sizeof(struct erofs_inode_compact);
>> @@ -197,7 +198,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>       err = -EFSCORRUPTED;
>>   err_out:
>>       DBG_BUGON(1);
>> -    kfree(copied);
>>       erofs_put_metabuf(buf);
>>       return ERR_PTR(err);
>>   }
> 
