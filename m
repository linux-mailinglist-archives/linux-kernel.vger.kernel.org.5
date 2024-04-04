Return-Path: <linux-kernel+bounces-131188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE41898430
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7631C2687F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C16380623;
	Thu,  4 Apr 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OpQiInbP"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DD71730;
	Thu,  4 Apr 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223131; cv=none; b=hygvL4P14CwlKGTD8dDH7yydlY1jqJ35pDpYrx5LGiiHrPuyO6GhtDWEs2ZsfWzStRx0YJmNq9lwYkBTE1LhYavajBRtMaiGIQpcfFWvFnEgHf5vNItDrCGvAHxaqSnZsi/e/Tgf7lDnf2SLsPkOZ0HtVUnGstgDqd56Sj1co50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223131; c=relaxed/simple;
	bh=NTkIUFsN+o79sd3pZSLcsMIjH/xgf74EVtlGOhG5jsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG99hH/yiLkczDToWy6gldXKdoTufH+FLb6oif/8raPTAzNnjIu8GLL5CTJbbv2CzoCd/ZkcDNx6CWKfJogpiQKmN1z/f0GkiDCev+9iVzX4dJOpQ8zt7DNml4AEMenYESiWyzhqhc7Syeknp5Bwk9rkLe7ECn+xwTwKSqO8Xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OpQiInbP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712223126; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vcxcoTPPCvHJeWJFRiHn9mDGeolKMHFN0SNJlYjkGaw=;
	b=OpQiInbPmiTtgXoqMNav2dCQ+hrEWjUHoWO//wF9a/2hqIBgmuCkP7zdRUPfhwmKNd1JgbwENlILZSQoamFBf/TtLrAspbiPA/67m3eMWx9oKTssDu0qPpVomQkAvebeYtswy3Smr6IDy1Zn5rV2Nmng91iRlPazZZBEvkJ2VFE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W3u1izQ_1712223124;
Received: from 30.39.185.155(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3u1izQ_1712223124)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 17:32:05 +0800
Message-ID: <1db6ccab-b49f-45d2-a93c-05b0f79371a3@linux.alibaba.com>
Date: Thu, 4 Apr 2024 17:32:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 04/11] net/smc: implement some unsupported
 operations of loopback-ism
To: Gerd Bayer <gbayer@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <20240324135522.108564-5-guwen@linux.alibaba.com>
 <3122eece5b484abcf8d23f85d6c18c36f0b939ff.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <3122eece5b484abcf8d23f85d6c18c36f0b939ff.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/4 00:25, Gerd Bayer wrote:
> On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
>> This implements some operations that loopback-ism does not support
>> currently:
>>   - vlan operations, since there is no strong use-case for it.
>>   - signal_event operations, since there is no event to be processed
>> by the loopback-ism device.
> 
> Hi Wen,
> 
> I wonder if the these operations that are not supported by loopback-ism
> should rather be marked "optional" in the struct smcd_ops, and the
> calling code should call these only when they are implemented.
> 
> Of course this would mean more changes to net/smc/smc_core.c - but
> loopback-ism could omit these "boiler-plate" functions.
> 

Hi Gerd.

Thank you for the thoughts! I agree that checks like 'if(smcd->ops->xxx)'
can avoid the device driver from implementing unsupported operations. But I
am afraid that which operations need to be defined as 'optional' may differ
from different device perspectives (e.g. for loopback-ism they are vlan-related
opts and signal_event). So I perfer to simply let the smc protocol assume
that all operations have been implemented, and let drivers to decide which
ones are unsupported in implementation. What do you think?

Thanks!

>>   
>> +static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int smc_lo_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int smc_lo_set_vlan_required(struct smcd_dev *smcd)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int smc_lo_reset_vlan_required(struct smcd_dev *smcd)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid
>> *rgid,
>> +			       u32 trigger_irq, u32 event_code, u64
>> info)
>> +{
>> +	return 0;
>> +}
>> +
> 
> Just a pattern that I saw elsewhere in the kernel...
> 
> Thanks,
> Gerd

