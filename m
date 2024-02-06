Return-Path: <linux-kernel+bounces-54943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE384B53B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AA31F21418
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF4133286;
	Tue,  6 Feb 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l1+a2SIR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFB132C25;
	Tue,  6 Feb 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221918; cv=none; b=A5R6k2nCZSHduDO7U7uEu1TNcYZYbnqn+PTnetRgnBcg8djv9/WG01EAPtyflHK8tc2XBWKImXEVEdt9PhpmSYb6GWPkw9Vr2De+esmVu107KaF5juewafJhVCVKhnm3HMLDZOMLGOw8P//zY6eWzF73NScpE66mPeWjeZ1azlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221918; c=relaxed/simple;
	bh=Tn8WnY+a+ept61qhjcmZvxSEPFge8/SObTTCDWxJS7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAvYu3iEFvLAhKiwRzkdSpMZuK36OW9P8j6dYBmSkK37iR8u6BcWYlb3dA2GvyRDGPT5uPDwXjAeBU7ifBJP/z236BPMHa/e6yI09WDukF/t/FfhVVucsCgj5ouAKhRG0hnRP3p5jLPITN8FB4aVr3qYB2uGk61WcnXCVzpxaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l1+a2SIR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416BtAUJ022474;
	Tue, 6 Feb 2024 12:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=J0YDXL0DMuZx6qRUUagB7lMLHl0D1nro9nj04PRHnTw=;
 b=l1+a2SIRg5PF4zDhqgXL9qLL/CahK7oNE6lSCOLCeyP8ZBo/1PhrWcNquUdgrjuzue9d
 c/cXX+TCvKQq59XIkl8go5kDa3zo2ifNdk++37Br4OQJ8Y56gdxSFLaWBtuPvTbuHtrx
 JBU5FPGXbqUYMAqJM21ug+/kPVUr2YIxksEkVx+9KkTHxrPDSwFgUXHMWzKsNbnbVFvI
 y3xK4uELaBM1cmNW6Fz+I7jHDTCVDLku0BVhBqc+W4aUDuwGSWkvnAfxfrR30pHJkJ7F
 PSc6w4oUotwRPDhbuyy6V8Dnfny190MEu8p7XKHgE23MFxde6CuufAb0u49halqZgsVR kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3mafrqqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 12:18:31 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 416BtShm024011;
	Tue, 6 Feb 2024 12:18:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3mafrqq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 12:18:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 416BXUwl019991;
	Tue, 6 Feb 2024 12:18:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytsy53u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 12:18:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 416CIRTf28115506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 12:18:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 031232009F;
	Tue,  6 Feb 2024 12:18:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88BB5200A1;
	Tue,  6 Feb 2024 12:18:26 +0000 (GMT)
Received: from [9.152.224.145] (unknown [9.152.224.145])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Feb 2024 12:18:26 +0000 (GMT)
Message-ID: <83b9d600-339c-4c9f-860d-ab4539a0ae6b@linux.ibm.com>
Date: Tue, 6 Feb 2024 13:18:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240111120036.109903-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9Oq93biWMDhGTymW9bQMJeO9SqpPP0os
X-Proofpoint-ORIG-GUID: zrdy_-uaFOs7-O2Gw8JOKcJKPynszSJC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060087



On 11.01.24 13:00, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The first
> part can be referred from [2]), the updated things of this version are listed
> at the end.
> 
> # Background
> 
> SMC-D is now used in IBM z with ISM function to optimize network interconnect
> for intra-CPC communications. Inspired by this, we try to make SMC-D available
> on the non-s390 architecture through a software-implemented virtual ISM device,
> that is the loopback-ism device here, to accelerate inter-process or
> inter-containers communication within the same OS instance.


Hello Wen Gu,

thank you very much for this patchset. I have been looking at it a bit.
I installed in on a testserver, but did not yet excercise the loopback-ism device.
I want to continue investigations, but daily work interferes, so I thought I
send you some comments now. So this is not at all a code review, but some 
thoughts and observations about the general concept.


In [1] there was a discussion about an abstraction layer between smc-d and the
ism devices. 
I am not sure what you are proposing now, is it an smc-d feature or independent of smc?
In 3/15 you say it is part of the SMC module, but then it has its own device entry.
Didn't you want to use it for other things as well? Or is it an SMC-D only feature?
Is it a device (Config help: "kind of virtual device")? Or an SMC-D feature?

Will we have a class of ism devices (s390 ism, ism-loopback, virtio-ism)
That share common properties (internal API?)
and smc-d will work with any of those?
But they all can exist without smc ?! BTW: This is what we want for s390-ism.
The client-registration interface [2] is currently the way to achieve this. 
But maybe we need a more general concept?

Maybe first a preparation patchset that introduces a class/ism
Together with an improved API?
In case you want to use ISM devices for other purposes as well..
But then the whole picture of ism-loopback in one patchset (RFC?) 
has its benefits as well.


Other points that I noticed:

Naming: smc loopback, ism-loopback, loopback-ism ?

config: why not tristate? Why under net/smc?

/sys/devices/virtual/smc  does not initially show up in my installation!!!
root@t35lp50:/sys/devices/virtual/> ls
3270/  bdi/  block/  graphics/  iommu/  mem/  memory_tiering/  misc/  net/  tty/  vc/  vtconsole/  workqueue/
root@t35lp50:/sys/devices/virtual/> ls smc/loopback-ism
active  dmb_copy  dmbs_cnt  dmb_type  subsystem@  uevent  xfer_bytes
root@t35lp50:/sys/devices/virtual/> ls
3270/  bdi/  block/  graphics/  iommu/  mem/  memory_tiering/  misc/  net/  smc/  tty/  vc/  vtconsole/  workqueue/
Is that normal behaviour?

You introduced a class/smc
Maybe class/ism would be better?
The other smc interfaces do not show up in class/smc!! Not so good

Why doesn't it show in smc_rnics?
(Maybe some deficiency of smc_rnics?)

But then it shows in other smc-tools:
root@t35lp50:/sys/> smcd device
FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
0000 0     loopback-ism  ffff   No        0
0029 ISM   0000:00:00.0  07c1   No        0  NET1
Nice!

Kind regards
Sandy


[1] https://lore.kernel.org/lkml/e3819550-7b10-4f9c-7347-dcf1f97b8e6b@linux.alibaba.com/
[2] 89e7d2ba61b7 ("net/ism: Add new API for client registration")

