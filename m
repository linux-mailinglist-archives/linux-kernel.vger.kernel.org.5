Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D301809D32
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573252AbjLHHeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjLHHeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:34:13 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F51724
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:34:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vy2OoK8_1702020855;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vy2OoK8_1702020855)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 15:34:16 +0800
Message-ID: <9ced71c9-4460-4907-abb9-21b517a883c7@linux.alibaba.com>
Date:   Fri, 8 Dec 2023 15:34:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] erofs: refine z_erofs_transform_plain() for sub-page
 block support
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
 <20231206091057.87027-5-hsiangkao@linux.alibaba.com>
 <20231208132031.00003b8d.zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231208132031.00003b8d.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/8 13:20, Yue Hu wrote:
> On Wed,  6 Dec 2023 17:10:56 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> Sub-page block support is still unusable even with previous commits if
>> interlaced PLAIN pclusters exist.  Such pclusters can be found if the
>> fragment feature is enabled.
>>
>> This commit tries to handle "the head part" of interlaced PLAIN
>> pclusters first: it was once explained in commit fdffc091e6f9 ("erofs:
>> support interlaced uncompressed data for compressed files").
>>
>> It uses a unique way for both shifted and interlaced PLAIN pclusters.
>> As an added bonus, PLAIN pclusters larger than the block size is also
>> supported now for the upcoming large lclusters.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/decompressor.c | 81 ++++++++++++++++++++++++-----------------
>>   1 file changed, 48 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
>> index 021be5feb1bc..5ec11f5024b7 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -319,43 +319,58 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
>>   static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>>   				   struct page **pagepool)
>>   {
>> -	const unsigned int inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
>> -	const unsigned int outpages =
>> +	const unsigned int nrpages_in =
>> +		PAGE_ALIGN(rq->pageofs_in + rq->inputsize) >> PAGE_SHIFT;
>> +	const unsigned int nrpages_out =
>>   		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
>> -	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
>> -					     PAGE_SIZE - rq->pageofs_out);
>> -	const unsigned int lefthalf = rq->outputsize - righthalf;
>> -	const unsigned int interlaced_offset =
>> -		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
>> -	u8 *src;
>> -
>> -	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
>> -		DBG_BUGON(1);
>> -		return -EFSCORRUPTED;
>> -	}
>> -
>> -	if (rq->out[0] == *rq->in) {
>> -		DBG_BUGON(rq->pageofs_out);
>> -		return 0;
>> +	const unsigned int bs = rq->sb->s_blocksize;
>> +	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
>> +	u8 *kin;
>> +
>> +	DBG_BUGON(rq->outputsize > rq->inputsize);
>> +	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
>> +		cur = bs - (rq->pageofs_out & (bs - 1));
>> +		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
>> +		cur = min(cur, rq->outputsize);
>> +		if (cur && rq->out[0]) {
>> +			kin = kmap_local_page(rq->in[nrpages_in - 1]);
>> +			if (rq->out[0] == rq->in[nrpages_in - 1]) {
>> +				memmove(kin + rq->pageofs_out, kin + pi, cur);
>> +				flush_dcache_page(rq->out[0]);
>> +			} else {
>> +				memcpy_to_page(rq->out[0], rq->pageofs_out,
>> +					       kin + pi, cur);
>> +			}
>> +			kunmap_local(kin);
>> +		}
>> +		rq->outputsize -= cur;
>>   	}
>>   
>> -	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
>> -	if (rq->out[0])
>> -		memcpy_to_page(rq->out[0], rq->pageofs_out,
>> -			       src + interlaced_offset, righthalf);
>> -
>> -	if (outpages > inpages) {
>> -		DBG_BUGON(!rq->out[outpages - 1]);
>> -		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
>> -			memcpy_to_page(rq->out[outpages - 1], 0, src +
>> -					(interlaced_offset ? 0 : righthalf),
>> -				       lefthalf);
>> -		} else if (!interlaced_offset) {
>> -			memmove(src, src + righthalf, lefthalf);
>> -			flush_dcache_page(rq->in[inpages - 1]);
>> -		}
>> +	for (; rq->outputsize; rq->pageofs_in = 0, cur += PAGE_SIZE, ni++) {
>> +		insz = min(PAGE_SIZE - rq->pageofs_in, rq->outputsize);
> 
> min_t(unsigned int, ,)?
> 
> ../include/linux/minmax.h:21:28: error: comparison of distinct pointer types lacks a cast [-Werror]
>    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))

What compiler version are you using? I didn't find any error
and
https://lore.kernel.org/linux-erofs/202312080122.iCCXzSuE-lkp@intel.com

also didn't report this.

Thanks,
Gao Xiang
