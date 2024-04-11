Return-Path: <linux-kernel+bounces-140018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6488A0A69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24751F21DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7513F44B;
	Thu, 11 Apr 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WJIeMfdS"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A213EFF6;
	Thu, 11 Apr 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821564; cv=none; b=pKHiscbpafONn2rh4rH5w2Ejip/56f89ApOHl2pjlxdJy7BuqDRMRv/upeMM1KMz2u78AOXVjErw0zTsTVpJuFp5+hJ3Ns/w1mMXCOFNG11dKupGR/XS/h2lNZZyE6Q10u7BFCrWWvEUMyJbTQe+wsj7qCesNbVEEjJf+gzelTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821564; c=relaxed/simple;
	bh=ZwLPH/UOcOFhWCSF3mwT9KX212oLhnTdEXSZz3Y9JAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko0l6kT/16mOPneW1vsPk5bR6QH2tl8RwvoXNKkLjdJQdKQZpsNh0k2M7D6MMn1k17UtI+1Qrbxlt4b6/m/au28ry1UZxy5jBLnQ9NtrTRtWlXVDFmEFjOjiUjsaIvfQ/1yu1h7RCckclB/sJxTes4zG3ZSzIFGBEqgDGCbWa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WJIeMfdS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712821554; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RuejJJ0cVW5wmtXibI9GDaEHnBr5czrBIGaDfgbbXis=;
	b=WJIeMfdSJuiU0MAW2remApcJOvCaXxGxT0xbX+vOeoysqQXxIM6C6Ph+b+BrTjWRJLc/fJamgjWu2ilVzKA4mOjEtfr8f/F1+YxMJ1tQfQ7VBTuEt3YNjTQxRxiPE2OcsKa+mORwuG1mgZ+2pObZzx2sISKyNoRBqYEVQ/gFRaY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4KbRbP_1712821552;
Received: from 30.221.130.208(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4KbRbP_1712821552)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 15:45:53 +0800
Message-ID: <fc274220-cb6e-43be-aa76-69e37449e535@linux.alibaba.com>
Date: Thu, 11 Apr 2024 15:45:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Gerd Bayer <gbayer@linux.ibm.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <ae3ea4bc-4a9c-416e-a593-2885fea96ae5@linux.alibaba.com>
 <27deaa5dbb30c467fcdaa0667ef39da86bcee03f.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <27deaa5dbb30c467fcdaa0667ef39da86bcee03f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/3 19:10, Gerd Bayer wrote:
> On Wed, 2024-04-03 at 14:35 +0800, Wen Gu wrote:
>>
>>
>> On 2024/3/24 21:55, Wen Gu wrote:
>>> This patch set acts as the second part of the new version of [1]
>>> (The first
>>> part can be referred from [2]), the updated things of this version
>>> are listed
>>> at the end.
>>
>>> Change log:
>>>
>>> RFC v5->RFC v4:
>>> - Patch #2: minor changes in description of config SMC_LO and
>>> comments.
>>> - Patch #10: minor changes in comments and
>>> if(smc_ism_support_dmb_nocopy())
>>>     check in smcd_cdc_msg_send().
>>> - Patch #3: change smc_lo_generate_id() to smc_lo_generate_ids()
>>> and SMC_LO_CHID
>>>     to SMC_LO_RESERVED_CHID.
>>> - Patch #5: memcpy while holding the ldev->dmb_ht_lock.
>>> - Some expression changes in commit logs.
>>>
>>
>> Hi, Jan. Do you have any comments on this version and should I post a
>> new patch series without 'RFC'? Thank you.
> 
> Hi Wen,
> 
> Jan has been out sick for a little while now, and Wenjia is expected
> back from a longer vacation tomorrow. So if you could hold off until
> begin of next week, Wenjia might have some more feedback.
> 
> In the meantime, I'm looking at your patchset...
> 
> Thank you, Gerd
> 

Hi Gerd, is there any further information? I am wondering if I
should wait for more feedback from SMC maintainers. Thanks!


Hi Wenjia, when it's convenient for you, could you please confirm
if [1] and [2] need to be included in the next version? Thanks!

[1] https://lore.kernel.org/netdev/7291dd1b2d16fd9bbd90988ac5bcc3a46d17e3f4.camel@linux.ibm.com/
[2] https://lore.kernel.org/netdev/60b4aec0b4bf4474d651b653c86c280dafc4518a.camel@linux.ibm.com/

