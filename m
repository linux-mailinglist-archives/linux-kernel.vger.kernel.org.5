Return-Path: <linux-kernel+bounces-71448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3DF85A55F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD940285FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721F374EA;
	Mon, 19 Feb 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jUCOuyn9"
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD8381BD;
	Mon, 19 Feb 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351496; cv=none; b=A0nRmhDTqdX0Yz4KHimMmHKZXMIMZ4yjyQkZjOEQV3E+Tm72VNuh6jjUWZA66iBJV4NQt0VSgp6qXqXKO+X9BdnLdmIOnDffarjOw+CDLSB7M+aMu5hjS6j9pFiEfY2z4Iea3YYvUyfRCLxMSVaMIJRu3su8GA1UVCB1x8t3jSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351496; c=relaxed/simple;
	bh=zXE55Wn1vwBRvTQKi9WOqRZmT86viMgSf4go7Yu3bbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owAQlgxIHuzo3aggXv/2qIjGNDHTZnJZf/dR4p35y2/QYBHHZ7ipSlvj+qndX9rv5VA7rV8A2on0D5RO2cJzOcgDZ3H4dcoq0yxgmw6IwP5nlv2fxxCmOLZ1oofDkP/lbZ6ZCjI11PPawllKFU9NsDRu/W/VRvjDiQagWKSUUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jUCOuyn9; arc=none smtp.client-ip=47.90.199.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708351474; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BNkhxppDcbFezZ4gGJ8AqJVbJcBTfeeZ+zXUxQ8+TPE=;
	b=jUCOuyn91MI2xA/eVE+GsD/JFOoJByBj0SaPY53TCHgq9g9L5cUwM0JoLersIFC7zh5Xhnok6v7lfxNBj38xhv8HnjT6SIJPsu0hSKgAFZFSzEirN7LV97QHCoMnswY5zkZ2JMwlUOL4VN19YSopr42jJyTjydorIGNDIuZn71s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W0tkCQI_1708351472;
Received: from 30.221.128.181(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0tkCQI_1708351472)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 22:04:33 +0800
Message-ID: <8a333c58-4a74-4a1c-9680-a0b9b4020a62@linux.alibaba.com>
Date: Mon, 19 Feb 2024 22:04:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: Wen Gu <guwen@linux.alibaba.com>
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

Thank you very much, Sandy.

> 
> In [1] there was a discussion about an abstraction layer between smc-d and the
> ism devices.
> I am not sure what you are proposing now, is it an smc-d feature or independent of smc?
> In 3/15 you say it is part of the SMC module, but then it has its own device entry.
> Didn't you want to use it for other things as well? Or is it an SMC-D only feature?
> Is it a device (Config help: "kind of virtual device")? Or an SMC-D feature?
> 

This patchset aims to propose an SMC feature, which is SMC-D loopback. The main work
to achieve this feature is to implement an Emulated-ISM, which is loopback-ism. The
loopback-ism is a 'built-in' dummy device of SMC and only serves SMC.

SMC-D protocol + 'built-in dummy device' (loopback-ism device) = SMC-D loopback feature.

To provide the runtime switch and statistics of loopback-ism, I need to find a sysfs
entry for it, since it doesn't belong to any class (e.g. pci_bus), I created an 'smc'
entry under /sys/devices/virtual/ and put loopback-ism under it.

The other SMC devices, such as RoCE, s390 ISM, virtio-ism will be in their own sysfs
entry, not under the /sys/devices/*virtual*/smc/.

The Config help is somewhat inaccurate. To be more precise, the SMC_LO config is used to
configure whether to enable this built-in dummy device for intra-OS communication.

> Will we have a class of ism devices (s390 ism, ism-loopback, virtio-ism)
> That share common properties (internal API?)
> and smc-d will work with any of those? > But they all can exist without smc ?! BTW: This is what we want for s390-ism.
> The client-registration interface [2] is currently the way to achieve this.
> But maybe we need a more general concept?
> 

I didn't mean to create a class to cover all the ISM devices. It is only for
loopback-ism. Because loopback-ism can not be classified, so I create an entry
under /sys/devices/virtual/.

> Maybe first a preparation patchset that introduces a class/ism
> Together with an improved API?
> In case you want to use ISM devices for other purposes as well..
> But then the whole picture of ism-loopback in one patchset (RFC?)
> has its benefits as well.
> 

Sorry for causing, I didn't mean to create a class to cover all the ISM devices.
They should be in their own sysfs entries (e.g. pci_bus), since they will be used
out of SMC. Only loopback-ism belongs only to SMC.

> 
> Other points that I noticed:
> 
> Naming: smc loopback, ism-loopback, loopback-ism ?
> 
> config: why not tristate? Why under net/smc?
> 

'SMC-D loopback' or 'SMC loopback' is used to indicate the feature or capability.
'loopback-ism' is the emulated-ISM device that 'SMC/SMC-D loopback' used.
('ism-loopback' doesn't seem to appear in my patchset)
If we all agree with these, I will check all the terms in the patch and unify them.

SMC_LO is used to configure whether SMC is allowed to use loopback-ism (CONFIG_SMC_LO),
it acts as a check in the code, so I defined it as a bool.
And loopback-ism only serves SMC-D loopback, as a feature of SMC, so the implementation
(net/smc/smc_loopback.{c|h}) is under net/smc.

> /sys/devices/virtual/smc  does not initially show up in my installation!!!
> root@t35lp50:/sys/devices/virtual/> ls
> 3270/  bdi/  block/  graphics/  iommu/  mem/  memory_tiering/  misc/  net/  tty/  vc/  vtconsole/  workqueue/
> root@t35lp50:/sys/devices/virtual/> ls smc/loopback-ism
> active  dmb_copy  dmbs_cnt  dmb_type  subsystem@  uevent  xfer_bytes
> root@t35lp50:/sys/devices/virtual/> ls
> 3270/  bdi/  block/  graphics/  iommu/  mem/  memory_tiering/  misc/  net/  smc/  tty/  vc/  vtconsole/  workqueue/
> Is that normal behaviour?
> 

/sys/devices/virtual/smc is created after SMC module initialization.
During the SMC module initialization, smc_loopback_init() is called, and the
/sys/devices/virtual/smc entry is created.

> You introduced a class/smc
> Maybe class/ism would be better?
> The other smc interfaces do not show up in class/smc!! Not so good
> 

Sorry for causing, I didn't mean to create a class to cover all the ISM devices.
They should be in their own sysfs entries (e.g. pci_bus), since they can be used
out of SMC. But loopback-ism is a SMC 'built-in' dummy device, it belongs only
to SMC and can't be classified to other entries.


> Why doesn't it show in smc_rnics?
> (Maybe some deficiency of smc_rnics?)
> 
smc_rnics can't be used on the arch other than s390.

# ./smc_rnics  -a
Error: s390/s390x supported only


> But then it shows in other smc-tools:
> root@t35lp50:/sys/> smcd device
> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
> 0000 0     loopback-ism  ffff   No        0
> 0029 ISM   0000:00:00.0  07c1   No        0  NET1
> Nice!
> 

Yes, this is did on patch 01/15.

Best regards,
Wen Gu

> Kind regards
> Sandy
> 
> 
> [1] https://lore.kernel.org/lkml/e3819550-7b10-4f9c-7347-dcf1f97b8e6b@linux.alibaba.com/
> [2] 89e7d2ba61b7 ("net/ism: Add new API for client registration")

