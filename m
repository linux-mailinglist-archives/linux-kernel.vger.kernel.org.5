Return-Path: <linux-kernel+bounces-104016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8987C7EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB031F21677
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A87D517;
	Fri, 15 Mar 2024 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S4U5o89N"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F66119
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472987; cv=none; b=bWmi/68xjUI6f98sx8J22cCNmtfsEDP2yc9BDvVw5Mph6intUarZyRs7gyY/BF84Uw266l7U9CiqbsKScY6zIvvJyvgx/b6A/HNyrCcxqyHGcAbrPaPmZSD/MPvfGUyjteISf7tdjR70sz1LPKz5Bma//VO6p9A5yV+ogVkYlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472987; c=relaxed/simple;
	bh=RsDlM7XRmRWsJCRyi7nBTGErp8a6/KNRPan9fsKzZ7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=desVO4xHmYU65gqriat9HQsSnGdsPSs8nDkq91qZN4pqozaD0C7wfPT73NqI28vu/2XqPGko//oDdjE8n7R5Re5sWB7v1r8+LGV9j5dPuAl8Ld1Wsb35iApabtoaKYMlHIZVfrAhGD6lk0Tg4aa8qITMOs+OO2o7bpWP/v9sUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S4U5o89N; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710472975; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9RApS/dgoDW2OO187PDIQGg8As0KtloDMqq9iA6UnB0=;
	b=S4U5o89N5knlu3fUUofAHzqsziMfM9870PgxeJKFpVktWHisovp6y0iFUKZcPfGN8e2TvguJ17XjfflTOrRNWbrpTRgPGBPdVLUfo2dgZweQXsT7VMtjHsbzX2HguXKF7sJ0yfqUyMFnl7I+oc5XOgt1rHr/o4hIn1Y6mv7eluk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W2UXS.C_1710472974;
Received: from 30.221.128.90(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W2UXS.C_1710472974)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 11:22:55 +0800
Message-ID: <2f93789c-e931-452a-9b42-43c3254b626f@linux.alibaba.com>
Date: Fri, 15 Mar 2024 11:22:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] relay: avoid relay_open_buf inproperly fails in
 buffer-only mode
To: zhangzhengming <zhang.zhengming@h3c.com>
Cc: akpm@linux-foundation.org, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, gregkh@linuxfoundation.org,
 guwen@linux.alibaba.com, hengqi@linux.alibaba.com, kunyu@nfschina.com,
 linux-kernel@vger.kernel.org, nabijaczleweli@nabijaczleweli.xyz,
 xuanzhuo@linux.alibaba.com, zhao_lei1@hoperun.com, zhou.kete@h3c.com
References: <20240220105836.15815-1-lulie@linux.alibaba.com>
 <20240315023912.13390-1-zhang.zhengming@h3c.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20240315023912.13390-1-zhang.zhengming@h3c.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/15 10:39, zhangzhengming wrote:
>> diff --git a/kernel/relay.c b/kernel/relay.c
>> index a8e90e98bf2c..0d8b8325530a 100644
>> --- a/kernel/relay.c
>> +++ b/kernel/relay.c
>> @@ -391,12 +391,13 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
>>   			goto free_buf;
>>   		relay_set_buf_dentry(buf, dentry);
>>   	} else {
>> -		/* Only retrieve global info, nothing more, nothing less */
>> +		/* In buffer-only mode, relay_open_buf is called with
>> +		 * filename=NULL, but create_buf_file is still needed to
>> +		 * retrieve is_global info. So dentry should be NULL here.
>> +		 */
>>   		dentry = chan->cb->create_buf_file(NULL, NULL,
>>   						   S_IRUSR, buf,
>>   						   &chan->is_global);
>> -		if (IS_ERR_OR_NULL(dentry))
>> -			goto free_buf;
>>   	}
>>   
>>    	buf->cpu = cpu;
> I suggest replacing IS_ERR_OR_NULL with IS_ERR instead of removing it due to the possibility of create_buf_file callback returning an error.
> 

This would be fine. AFAICT the return value here is un-important. So 
reverting to `WARN_ON(dentry)` maybe another choice.

