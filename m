Return-Path: <linux-kernel+bounces-25209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ABE82CA5B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276AF1C21745
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 07:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BCB18647;
	Sat, 13 Jan 2024 07:12:16 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D814262;
	Sat, 13 Jan 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-V4eFs_1705129921;
Received: from 30.0.168.206(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-V4eFs_1705129921)
          by smtp.aliyun-inc.com;
          Sat, 13 Jan 2024 15:12:03 +0800
Message-ID: <c828acfe-412a-4555-85a9-573e78833ec9@linux.alibaba.com>
Date: Sat, 13 Jan 2024 15:12:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15] net/smc: introduce loopback-ism DMB data
 copy control
To: Niklas Schnelle <schnelle@linux.ibm.com>, wintera@linux.ibm.com,
 wenjia@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-15-guwen@linux.alibaba.com>
 <e0b80a1680ccc693de3f29bfaa9fa654c3b7b4fa.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <e0b80a1680ccc693de3f29bfaa9fa654c3b7b4fa.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/13 00:24, Niklas Schnelle wrote:
> On Thu, 2024-01-11 at 20:00 +0800, Wen Gu wrote:
>> This provides a way to {get|set} whether loopback-ism device supports
>> merging sndbuf with peer DMB to eliminate data copies between them.
>>
>> echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # support
>> echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # not support
> 
> The two support/no support remarks are a bit confusing because support
> here seems to mean "support no-copy mode" while the attribute is more
> like "force copy mode". How about:
> 
> echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # one DMB mode
> echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # copy mode
> 

Thank you! Niklas.
That makes it much clearer. It will be improved in next version.

>>
>> The settings take effect after re-activating loopback-ism by:
>>
>> echo 0 > /sys/devices/virtual/smc/loopback-ism/active
>> echo 1 > /sys/devices/virtual/smc/loopback-ism/active
>>
>> After this, the link group related to loopback-ism will be flushed and
>> the sndbufs of subsequent connections will be merged or not merged with
>> peer DMB.
>>
>> The motivation of this control is that the bandwidth will be highly
>> improved when sndbuf and DMB are merged, but when virtually contiguous
>> DMB is provided and merged with sndbuf, it will be concurrently accessed
>> on Tx and Rx, then there will be a bottleneck caused by lock contention
>> of find_vmap_area when there are many CPUs and CONFIG_HARDENED_USERCOPY
>> is set (see link below). So an option is provided.
>>
>> Link: https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---8<---

