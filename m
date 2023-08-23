Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA03A785BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbjHWPX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjHWPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:23:26 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E02110F0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:23:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VqQfGU._1692804159;
Received: from 30.25.196.234(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqQfGU._1692804159)
          by smtp.aliyun-inc.com;
          Wed, 23 Aug 2023 23:22:43 +0800
Message-ID: <4f6d7e71-d989-03d7-0d7b-832a539d1f36@linux.alibaba.com>
Date:   Wed, 23 Aug 2023 23:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/8] erofs: move preparation logic into
 z_erofs_pcluster_begin()
To:     Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-3-hsiangkao@linux.alibaba.com>
 <48235010-25e4-341f-77a3-a3399af3b6be@kernel.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <48235010-25e4-341f-77a3-a3399af3b6be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/23 23:05, Chao Yu wrote:
> On 2023/8/17 16:28, Gao Xiang wrote:
>> Some preparation logic should be part of z_erofs_pcluster_begin()
>> instead of z_erofs_do_read_page().  Let's move now.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/zdata.c | 59 +++++++++++++++++++++---------------------------
>>   1 file changed, 26 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 4ed99346c4e1..30ecdfe41836 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -852,7 +852,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>   static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>   {
>>       struct erofs_map_blocks *map = &fe->map;
>> +    struct super_block *sb = fe->inode->i_sb;
>> +    erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
>>       struct erofs_workgroup *grp = NULL;
>> +    void *mptr;
>>       int ret;
>>       DBG_BUGON(fe->pcl);
>> @@ -861,8 +864,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>       DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>>       if (!(map->m_flags & EROFS_MAP_META)) {
>> -        grp = erofs_find_workgroup(fe->inode->i_sb,
>> -                       map->m_pa >> PAGE_SHIFT);
>> +        grp = erofs_find_workgroup(sb, blknr);
>>       } else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
>>           DBG_BUGON(1);
>>           return -EFSCORRUPTED;
>> @@ -881,9 +883,24 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>       } else if (ret) {
>>           return ret;
>>       }
>> +
>>       z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
>>                   Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
>> -    /* since file-backed online pages are traversed in reverse order */
>> +    if (!z_erofs_is_inline_pcluster(fe->pcl)) {
>> +        /* bind cache first when cached decompression is preferred */
>> +        z_erofs_bind_cache(fe);
>> +    } else {
> 
> Nitpick, mptr can be defined here.

Okay, will apply the following diff directly:

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3730775650f4..036f610e044b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -848,7 +848,6 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
         struct super_block *sb = fe->inode->i_sb;
         erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
         struct erofs_workgroup *grp = NULL;
-       void *mptr;
         int ret;

         DBG_BUGON(fe->pcl);
@@ -883,6 +882,8 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
                 /* bind cache first when cached decompression is preferred */
                 z_erofs_bind_cache(fe);
         } else {
+               void *mptr;
+
                 mptr = erofs_read_metabuf(&map->buf, sb, blknr, EROFS_NO_KMAP);
                 if (IS_ERR(mptr)) {
                         ret = PTR_ERR(mptr);

> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
> 
