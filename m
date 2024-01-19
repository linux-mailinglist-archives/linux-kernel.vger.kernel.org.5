Return-Path: <linux-kernel+bounces-30691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F04583231D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59B4286927
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E950C1376;
	Fri, 19 Jan 2024 01:47:02 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBB1C30;
	Fri, 19 Jan 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628822; cv=none; b=T+pAS5dAJD4zRpzpJPIwdxXRp7mKZL3KTL/WGAbKLwlx/ONKHw/h+6M5wom8YGjiNL0xnDSAelNsEBw0xYIJ4zq9MCWZnVGad58EJBs6Y9F1xcFUeG+4ic7ZFDXtSR0f02I1H30+EQruot5mn+MlHsLkfhA+4aF9VOWoHDKc5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628822; c=relaxed/simple;
	bh=oc+EVWt5c6vefMU4eC9AG7b2I59Qa+MJy8/Oj+jNVaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRrSo2lLa5shi0iGIXqQOVJ+G0BaWAr8TqGmrzKLJTsrG8cQn/9hdpRvjNyixkQg6883z8rPnPBhNk/VdEsEfcSOJEmfrzARxRpsxOr2DU+R5f5cGWBabRqd2zGHtZqFe6zdtfaQQJzZ6Zi+AKfqZcFd0ZlOGLxU+TUNpMKxtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W-u9l7M_1705628794;
Received: from 30.221.129.170(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-u9l7M_1705628794)
          by smtp.aliyun-inc.com;
          Fri, 19 Jan 2024 09:46:52 +0800
Message-ID: <1860588f-2246-4dcd-9db5-4ccd7add0f4a@linux.alibaba.com>
Date: Fri, 19 Jan 2024 09:46:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <f98849a7-41e9-421b-97b7-36d720cc43ee@linux.alibaba.com>
 <20a1a1f3-789a-4d91-9a94-dca16161afd7@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20a1a1f3-789a-4d91-9a94-dca16161afd7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/18 21:59, Wenjia Zhang wrote:
> 
> 
> On 18.01.24 09:27, Wen Gu wrote:
>>
>>
>> On 2024/1/11 20:00, Wen Gu wrote:
>>> This patch set acts as the second part of the new version of [1] (The first
>>> part can be referred from [2]), the updated things of this version are listed
>>> at the end.
>>>
>>
>> Hi Wenjia and Jan, I would appreciate any thoughts or comments you might have
>> on this series. Thank you very much!
>>
> Hi Wen,
> 
> I'm still in the middle of the proto type on IPPROTO_SMC and other issues, so that I need more time to review this patch 
> series.
> 
> Thank you for your patience!
> Wenjia

Understood. Thank you! Wenjia.

Best regards,
Wen Gu

