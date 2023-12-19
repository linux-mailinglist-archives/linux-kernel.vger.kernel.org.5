Return-Path: <linux-kernel+bounces-4576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C6817F89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837A6B2359B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79C1FB6;
	Tue, 19 Dec 2023 02:03:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62768187F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VyogQL4_1702951421;
Received: from 30.221.145.29(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VyogQL4_1702951421)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 10:03:42 +0800
Message-ID: <112dd87b-1072-4568-93d5-3b13ed818511@linux.alibaba.com>
Date: Tue, 19 Dec 2023 10:03:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix arithmetic for bdi min_ratio and max_ratio
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shr@devkernel.io, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com
References: <20231218031640.77983-1-jefflexu@linux.alibaba.com>
 <20231218102117.c91ab02353ff76b952f3ec9e@linux-foundation.org>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20231218102117.c91ab02353ff76b952f3ec9e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 2:21 AM, Andrew Morton wrote:
> On Mon, 18 Dec 2023 11:16:40 +0800 Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> bdi->[min|max]_ratio are both part per million.  Fix the wrong
>> arithmetic when setting bdi's min_ratio and max_ratio.
>>
>> Fixes: efc3e6ad53ea ("mm: split off __bdi_set_max_ratio() function")
>> Fixes: 8021fb3232f2 ("mm: split off __bdi_set_min_ratio() function")
> 
> As we have two Fixes:, it would be better to have two patches please.

Sounds reasonable.  Thanks.

> 
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -692,7 +692,6 @@ static int __bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ra
>>  
>>  	if (min_ratio > 100 * BDI_RATIO_SCALE)
>>  		return -EINVAL;
>> -	min_ratio *= BDI_RATIO_SCALE;

This indeed has visible runtime effect as follows:

# cat /sys/class/bdi/253\:0/min_ratio
0
# cat /sys/class/bdi/253\:0/max_ratio
100
# echo 1 > /sys/class/bdi/253\:0/min_ratio
-bash: echo: write error: Invalid argument

Setting min_ratio will fail with -EINVAL, as the above code tries to set
min_ratio with (min_ratio * BDI_RATIO_SCALE)%, i.e. 10000% in the above
example.

>>  
>>  	spin_lock_bh(&bdi_lock);
>>  	if (min_ratio > bdi->max_ratio) {
>> @@ -729,7 +728,8 @@ static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ra
>>  		ret = -EINVAL;
>>  	} else {
>>  		bdi->max_ratio = max_ratio;
>> -		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
>> +		bdi->max_prop_frac = div64_u64(FPROP_FRAC_BASE * max_ratio,
>> +					       100UL * BDI_RATIO_SCALE);
>>  	}
>>  	spin_unlock_bh(&bdi_lock);

This one has no visible runtime effect, but I believe this would affect
the incrementing of writeout completion count when max_ratio is not 100%.


-- 
Thanks,
Jingbo

