Return-Path: <linux-kernel+bounces-58333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A3384E4C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF84C285BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EA97D417;
	Thu,  8 Feb 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D1r0nZIV"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807178667;
	Thu,  8 Feb 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408784; cv=none; b=WtUJZ6/fIrK7izJK1F1xcBB8+S28VW8hMNvEMLBZ/jTF5lHcq9qeolBph6i3iotOXC/fsiC/IMTwlQbTfI4r1iLdV8eIPSy3zI+p2GE+W89QHWHU0+ukSouEZQCywcI3aSSKg3PINGuct+3Su/i5t2or5xqfQDsb5Qd/TFE6RJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408784; c=relaxed/simple;
	bh=httI3jPwLFmSHmstxtkwKfoc0Oiu9/X7f4uOJchIqxE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WgwgLuSTcRcWkJMOYcZQQKweIbkZJJ/INL7t9K+fs3R4eSEn4iIy9KZ4eeSsrqNuC3eQqLF8N2q0cL0l8Gq55uzQ4rFv6jW03rGR5T8Vm7Obrp7i3gA5hXyiq7qcR94uxn2xLD2BZVaM4dxae0ghBVKjQcb7/jEg55TA/W63TJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D1r0nZIV; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707408772; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=FfIGolZtnx4ArqMHswsjhwdEWJ6tIV6Ggvo4TitHT3c=;
	b=D1r0nZIV6TRMZMfyMGGLW5BIeTpDbwl9Zm+ViGltfZXxWQ/bmlS0/amWjX6b8FLTr0cnU3ZvgQCZcdTPedOuXEujyKzki4P5PsI7/sI2x1uohAVK4H/hBNd/iEQEFf3NlKSuI6UNVeLpyC3/XzhzLtw37N1sDOmHg4rHVjldEYs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W0JlSZN_1707408769;
Received: from 192.168.1.100(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0JlSZN_1707408769)
          by smtp.aliyun-inc.com;
          Fri, 09 Feb 2024 00:12:51 +0800
Message-ID: <357fa933-a19f-40eb-a108-9fcf71471648@linux.alibaba.com>
Date: Fri, 9 Feb 2024 00:12:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
To: Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <83b9d600-339c-4c9f-860d-ab4539a0ae6b@linux.ibm.com>
In-Reply-To: <83b9d600-339c-4c9f-860d-ab4539a0ae6b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/6 20:18, Alexandra Winter wrote:
> 
> 
> On 11.01.24 13:00, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The first
>> part can be referred from [2]), the updated things of this version are listed
>> at the end.
>>
>> # Background
>>
>> SMC-D is now used in IBM z with ISM function to optimize network interconnect
>> for intra-CPC communications. Inspired by this, we try to make SMC-D available
>> on the non-s390 architecture through a software-implemented virtual ISM device,
>> that is the loopback-ism device here, to accelerate inter-process or
>> inter-containers communication within the same OS instance.
> 
> 
> Hello Wen Gu,
> 
> thank you very much for this patchset. I have been looking at it a bit.
> I installed in on a testserver, but did not yet excercise the loopback-ism device.
> I want to continue investigations, but daily work interferes, so I thought I
> send you some comments now. So this is not at all a code review, but some
> thoughts and observations about the general concept.
> 

Hi Sandy and Wenjia,

Thank you very much for your feedback!
I am working on the detailed replies. As we are on holiday for Chinese New Year,
the progress may be slower. But please feel free to leave any other comments and
feedback, thank you!

Best regards!
Wen Gu

> 
> In [1] there was a discussion about an abstraction layer between smc-d and the
> ism devices.
> I am not sure what you are proposing now, is it an smc-d feature or independent of smc?
> In 3/15 you say it is part of the SMC module, but then it has its own device entry.
> Didn't you want to use it for other things as well? Or is it an SMC-D only feature?
> Is it a device (Config help: "kind of virtual device")? Or an SMC-D feature?
> 
> Will we have a class of ism devices (s390 ism, ism-loopback, virtio-ism)
> That share common properties (internal API?)
> and smc-d will work with any of those?
> But they all can exist without smc ?! BTW: This is what we want for s390-ism.
> The client-registration interface [2] is currently the way to achieve this.
> But maybe we need a more general concept?
> 
> Maybe first a preparation patchset that introduces a class/ism
> Together with an improved API?
> In case you want to use ISM devices for other purposes as well..
> But then the whole picture of ism-loopback in one patchset (RFC?)
> has its benefits as well.
> 
> 
> Other points that I noticed:
> 
> Naming: smc loopback, ism-loopback, loopback-ism ?
> 
> config: why not tristate? Why under net/smc?
> 
> /sys/devices/virtual/smc  does not initially show up in my installation!!!
> root@t35lp50:/sys/devices/virtual/> ls
> 3270/  bdi/  block/  graphics/  iommu/  mem/  memory_tiering/  misc/  net/  tty/  vc/  vtconsole/  workqueue/
> root@t35lp50:/sys/devices/virtual/> ls smc/loopback-ism
> active  dmb_copy  dmbs_cnt  dmb_type  subsystem@  uevent  xfer_bytes
> root@t35lp50:/sys/devices/virtual/> ls
> 3270/  bdi/  block/  graphics/  iommu/  mem/  memory_tiering/  misc/  net/  smc/  tty/  vc/  vtconsole/  workqueue/
> Is that normal behaviour?
> 
> You introduced a class/smc
> Maybe class/ism would be better?
> The other smc interfaces do not show up in class/smc!! Not so good
> 
> Why doesn't it show in smc_rnics?
> (Maybe some deficiency of smc_rnics?)
> 
> But then it shows in other smc-tools:
> root@t35lp50:/sys/> smcd device
> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
> 0000 0     loopback-ism  ffff   No        0
> 0029 ISM   0000:00:00.0  07c1   No        0  NET1
> Nice!
> 
> Kind regards
> Sandy
> 
> 
> [1] https://lore.kernel.org/lkml/e3819550-7b10-4f9c-7347-dcf1f97b8e6b@linux.alibaba.com/
> [2] 89e7d2ba61b7 ("net/ism: Add new API for client registration")

