Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D2078068B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358183AbjHRHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352585AbjHRHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:48:17 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E1930FE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:48:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vq1nWfF_1692344889;
Received: from 30.221.131.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vq1nWfF_1692344889)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 15:48:10 +0800
Message-ID: <671a514f-8597-7693-1323-929e39c56dda@linux.alibaba.com>
Date:   Fri, 18 Aug 2023 15:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] erofs: get rid of fe->backmost for cache
 decompression
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
 <20230818135156.00005a05.zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230818135156.00005a05.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/18 13:51, Yue Hu wrote:
> On Thu, 17 Aug 2023 16:28:11 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
>> incomplete pcluster for later read or not.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/zdata.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 4009283944ca..c28945532a02 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -528,8 +528,6 @@ struct z_erofs_decompress_frontend {
>>   	z_erofs_next_pcluster_t owned_head;
>>   	enum z_erofs_pclustermode mode;
>>   
>> -	/* used for applying cache strategy on the fly */
>> -	bool backmost;
>>   	erofs_off_t headoffset;
>>   
>>   	/* a pointer used to pick up inplace I/O pages */
>> @@ -538,7 +536,7 @@ struct z_erofs_decompress_frontend {
>>   
>>   #define DECOMPRESS_FRONTEND_INIT(__i) { \
>>   	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
>> -	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
>> +	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
>>   
>>   static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
>>   {
>> @@ -547,7 +545,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
>>   	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
>>   		return false;
>>   
>> -	if (fe->backmost)
>> +	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))
> 
> So, i understand (map.m_flags & EROFS_MAP_FULL_MAPPED) should be false if allocate cache is needed
> (fe->backmost is true)?

fe->backmost is inaccurate compared with !EROFS_MAP_FULL_MAPPED,
if !EROFS_MAP_FULL_MAPPED, it should be cached instead.

Thanks,
Gao Xiang
