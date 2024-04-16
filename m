Return-Path: <linux-kernel+bounces-146942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E62F8A6D50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF3287AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886412D218;
	Tue, 16 Apr 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AzKDH9U5"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466612CD9A;
	Tue, 16 Apr 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276374; cv=none; b=HqA0cvAdRSc8QpPg/9wI7HVkeYuOhIlZULlTotFDKA3NOR1zsJN2rLej9TMroFNiNMo563sWkHA5Cl96xpfNmHjFsmzzizPB7681AqsN+yr/Sn58wB5oU71BxM0cxGEuy1AXk6okdrtzmHeml3NH7a9m8udFQd/L1lzXqwiLMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276374; c=relaxed/simple;
	bh=OIjBZ2uSrRRCPA7njEkAYgEvMcESbAP5c3QefnQVxTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptpJD4R3w3gCnpHS4LDaUKEnT1Z+/TBXh6xNv9IQ+WuiOU1l47/Qwsb9MCtXKxctqpJugExfkxSsfZRyVjzF/O1ZpUHkCEIXqCSlxn/xFANmzYoNAYaQFZmUvNNtJk2BOV4juKniaJneVFf5wHFf/YRZg5ApDLufBINLjPE6btE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AzKDH9U5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713276369; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xEYEMePmztZfbv9xHlEGvnUIEV3Ro9LAXkzvLijPqCM=;
	b=AzKDH9U57bdwbad16JV9nYVCvrfGqIt1Z59x5f/IyczPiIjwxucwaM9LDa7zZzIBXBBRn0FA2ysg8KM3hWZuwhe+XcdScnJcXQ0lQrg3Li3m/Bljzwr9mpnRiG4gGDnGu1OAnbECgoEJSEFGqSOIPWk3JY/wDTWLL0bRVKFx3oY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4i8467_1713276365;
Received: from 30.213.156.135(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4i8467_1713276365)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 22:06:07 +0800
Message-ID: <eb7eb42a-ea96-41d9-b385-c459379bed99@linux.alibaba.com>
Date: Tue, 16 Apr 2024 22:06:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 10/11] net/smc: adapt cursor update when
 sndbuf and peer DMB are merged
To: Simon Horman <horms@kernel.org>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-11-guwen@linux.alibaba.com>
 <20240416110538.GK2320920@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240416110538.GK2320920@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/16 19:05, Simon Horman wrote:
> On Sun, Apr 14, 2024 at 12:03:03PM +0800, Wen Gu wrote:
>> If the local sndbuf shares the same physical memory with peer DMB,
>> the cursor update processing needs to be adapted to ensure that the
>> data to be consumed won't be overwritten.
>>
>> So in this case, the fin_curs and sndbuf_space that were originally
>> updated after sending the CDC message should be modified to not be
>> update until the peer updates cons_curs.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> 
> ...
> 
>> @@ -255,6 +256,14 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
>>   		return rc;
>>   	smc_curs_copy(&conn->rx_curs_confirmed, &curs, conn);
>>   	conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
>> +
>> +	if (smc_ism_support_dmb_nocopy(conn->lgr->smcd))
>> +		/* if local sndbuf shares the same memory region with
>> +		 * peer DMB, then don't update the tx_curs_fin
>> +		 * and sndbuf_space until peer has consumed the data.
>> +		 */
>> +		return rc;
> 
> Hi Wen Gu,
> 
> A minor nit from my side:
> 
> To my mind "return rc" implies returning an error value.
> But here rc is 0, which based on the comment seems correct.
> So perhaps it would be clearer to simply return 0.
> 
> Flagged by Smatch.
> 
>> +
>>   	/* Calculate transmitted data and increment free send buffer space */
>>   	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
>>   			     &conn->tx_curs_sent);
> 
> ...

OK. I will improve it and another 'return rc' at the end of
smcd_cdc_msg_send(). Thanks! Simon.

