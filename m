Return-Path: <linux-kernel+bounces-131523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012E4898904
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC89B21460
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319412838D;
	Thu,  4 Apr 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S5qcrfZm"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF276023;
	Thu,  4 Apr 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238293; cv=none; b=k+zcoo2n/mfPb9uh8Sz5uERAwJqAKyhzbTct5EI9LwMtIiIgfSycE02F1eBaxW+t3vXKm5tWBSzJRNSgBNqT5TcdQ0e9bYcFDuK5NFKyGecZrZFw8nh/sMw33o8Oj2fJdETE8p7XuL5plfBCpkD6R00FCqySzU/L7c9a+CMnctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238293; c=relaxed/simple;
	bh=tAAtr7pnR4MH/4TMN77ugW13pgkeIiTR+g76NLCU3ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayOWBDwlMlJCLtJzr47kkX41z9+LBT3lWXdzu/Pp1O1AKzCao+ZE750npVvjDFuGQnlSaqe2PZkEfgdpnajB6CX0f8SRIU3xa1ebnZLqe1RarD+uRd4X4t3mwC1nM96tUoTSvbmEaXEuZXOI5rrF9adJMP8u3MU3hGhlswhlF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S5qcrfZm; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712238280; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O+o5H6Rp/YKTpylXkB7+dR8XqLzGRaNwaFZPCluqRS8=;
	b=S5qcrfZm1dko10hBCbO8YldAe+QslRnlpEVQBpZ76+NqGZUfVErND4p+JrABcyINl3+O3JmpGiQ2lC0P0YRDcgx3cqQ4V3A5Ypdo6CQE31FlAlb64oquLJPI0Jwu0v4Swah4Xq0HlN2JkGWFWLWsDauCmHa8h8nGs1c3ONIEhuU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W3uXJtx_1712238278;
Received: from 30.236.60.242(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3uXJtx_1712238278)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 21:44:39 +0800
Message-ID: <7c3733b7-a3f2-45ba-9b8d-880957ed5cdf@linux.alibaba.com>
Date: Thu, 4 Apr 2024 21:44:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 05/11] net/smc: implement DMB-related
 operations of loopback-ism
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <20240324135522.108564-6-guwen@linux.alibaba.com>
 <9a17268d4046f99b30f3620079b5749a9ddc5cd9.camel@linux.ibm.com>
 <92b0c4b1-4844-4adf-a15a-a9323fb859e1@linux.alibaba.com>
 <6d3cfa04c9826a24f0ad8d401940af3ad02a67bc.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <6d3cfa04c9826a24f0ad8d401940af3ad02a67bc.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/4 19:27, Niklas Schnelle wrote:
> On Thu, 2024-04-04 at 18:20 +0800, Wen Gu wrote:
>>
>> On 2024/4/4 01:20, Gerd Bayer wrote:
>>> On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
>>>
>>> When I instrumented this to see, why I still see tons of my other
>>> temporary instrumentation messages from the "ism" driver, I found that
>>> in my setup loopback-ism is used rather infrequently.
>>>
>>> I suspect this is due to how the SMC proposals are constructed in
>>> net/smc/af_smc.c and net/smc/smc_pnet.c - and later evaluated in
>>> smc_check_ism_v2_match() - where there is a first-come-first-serve
>>> selection.
>>>
>>> I wonder if one should change that to favour loopback-ism over "real"
>>> ISM devices - and how this could be achieved elegantly.
>>>
>>> Just some food for thought... Probably little you can do on x86.
>>>
>>
>> Yes, it is about the priority of available ISM devices, and now it
>> is decided by their order in the smcd_dev_list. The later registered
>> ISMv2 devices(without pnetid) will be added to the beginning of the
>> list (see smcd_register_dev()). So there is a probability that
>> loopback-ism will not be ranked first, since it is added into list
>> earlier during smc_init().
>>
>> If we have the runtime switch of loopback-ism, we can re-active the
>> loopback-ism, that make it be re-added into the beginning of the dev
>> list and be chosen first. Or a new netlink command to adjust the slot
>> order of available ISM devices in the list. As we discussed before,
>> that could be tasks in stage 1 or stage 2.
>>
>> Thanks!
> 
> Maybe when adding the ISM devices we could instead make sure that all
> ISM devices are added after loopback and loopback is added in the
> beginning. I think loopback should always be preferred and would
> consider it a bug if it isn't faster too. Between virtio-ism and ISM it
> may be less clear so maybe for stage 2 we would want a priority setting
> and then insert ordered by priority. Thoughts?
I have no objection. If we all agree, I will keep it at the beginning of the list.

Thanks!


