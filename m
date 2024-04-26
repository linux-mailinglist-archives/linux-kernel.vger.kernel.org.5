Return-Path: <linux-kernel+bounces-159683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290108B3223
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B19281C05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADCD13C9B3;
	Fri, 26 Apr 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZCTRv1x4"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AB14293;
	Fri, 26 Apr 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119437; cv=none; b=LWtiK1rW+bE1GF4mqOQ6fGzajCxNOcDE7XMDbx3s8ECEafwPAuVxI6SyhQM8d1IDPuDCbmaFVw1U3VP6qtYIkMACVjYAMPjLVhAs09YS4Ji+OxeTM2Zvk4CgW5QMFvl7CEfRuFIKkLcaOSXlfha1IaJgktyeVxrPecsX6UgL3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119437; c=relaxed/simple;
	bh=KYXaZjdI+5IkXp0DualbSWgVlbRSytaWokMYpK++Zbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElFSAY1x5tnGYLiqT3vGHwpJL+GSs1AlkQbDe7brv/7A150SUjy+xirEcEtINo22rakPZRzOs3jZnQpYhwqXgW+lDYYTFdnLi9ui90m53LGlfkmcdCo6fXScjEnu1XiIfemas+y/cEFWhfR31p58R+cTtqmW37DkOnGVyFvpM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZCTRv1x4; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714119431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aS7zNkUjp+X466NnRKZw+mwarWr8jMNg/0m58+2vk84=;
	b=ZCTRv1x46T6wUAiLrn0pjNOLPIZOzryCpGstk4b419L8hjZFwx4ZtXzroSj0I80Wy7Gy+zWpBOArUW96jAl0VDtq1OcmNQdFu4s/wIhoHrYZPzKHS3FskXefbuoDpPtYG/CZa3MF8DCzxAmG9c/D7/doAoHwkcaZfmGpC33jRto=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W5ISEMi_1714119429;
Received: from 30.221.129.216(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5ISEMi_1714119429)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 16:17:10 +0800
Message-ID: <3f2a7456-c310-4fdc-a507-896fcaaad454@linux.alibaba.com>
Date: Fri, 26 Apr 2024 16:17:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <5f50bc62-f7d5-4094-94de-a77a103fc111@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <5f50bc62-f7d5-4094-94de-a77a103fc111@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/26 15:02, Jan Karcher wrote:
> 
> 
> On 14/04/2024 06:02, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The first
>> part can be referred from [2]), the updated things of this version are listed
>> at the end.
>>
>> - Background
>>
>> SMC-D is now used in IBM z with ISM function to optimize network interconnect
>> for intra-CPC communications. Inspired by this, we try to make SMC-D available
>> on the non-s390 architecture through a software-implemented Emulated-ISM device,
>> that is the loopback-ism device here, to accelerate inter-process or
>> inter-containers communication within the same OS instance.
>>
>> - Design
>>
>> This patch set includes 3 parts:
>>
>>   - Patch #1: some prepare work for loopback-ism.
>>   - Patch #2-#7: implement loopback-ism device and adapt SMC-D for it.
>>     loopback-ism now serves only SMC and no userspace interfaces exposed.
>>   - Patch #8-#11: memory copy optimization for intra-OS scenario.
>>
>> The loopback-ism device is designed as an ISMv2 device and not be limited to
>> a specific net namespace, ends of both inter-process connection (1/1' in diagram
>> below) or inter-container connection (2/2' in diagram below) can find the same
>> available loopback-ism and choose it during the CLC handshake.
>>
>>   Container 1 (ns1)                              Container 2 (ns2)
>>   +-----------------------------------------+    +-------------------------+
>>   | +-------+      +-------+      +-------+ |    |        +-------+        |
>>   | | App A |      | App B |      | App C | |    |        | App D |<-+     |
>>   | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
>>   |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
>>   |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
>>   |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
>>   +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
>>                |   |           |                                  |
>>   Kernel       |   |           |                                  |
>>   +----+-------v---+-----------v----------------------------------+---+----+
>>   |    |                            TCP                               |    |
>>   |    |                                                              |    |
>>   |    +--------------------------------------------------------------+    |
>>   |                                                                        |
>>   |                           +--------------+                             |
>>   |                           | smc loopback |                             |
>>   +---------------------------+--------------+-----------------------------+
>>
>> loopback-ism device creates DMBs (shared memory) for each connection peer.
>> Since data transfer occurs within the same kernel, the sndbuf of each peer
>> is only a descriptor and point to the same memory region as peer DMB, so that
>> the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.
>>
>>   Container 1 (ns1)                              Container 2 (ns2)
>>   +-----------------------------------------+    +-------------------------+
>>   | +-------+                               |    |        +-------+        |
>>   | | App C |-----+                         |    |        | App D |        |
>>   | +-------+     |                         |    |        +-^-----+        |
>>   |               |                         |    |          |              |
>>   |           (2) |                         |    |     (2') |              |
>>   |               |                         |    |          |              |
>>   +---------------|-------------------------+    +----------|--------------+
>>                   |                                         |
>>   Kernel          |                                         |
>>   +---------------|-----------------------------------------|--------------+
>>   | +--------+ +--v-----+                           +--------+ +--------+  |
>>   | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
>>   | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
>>   | +-----|--+    |                                 +-----|--+             |
>>   | | DMB C  |    +---------------------------------| DMB D  |             |
>>   | +--------+                                      +--------+             |
>>   |                                                                        |
>>   |                           +--------------+                             |
>>   |                           | smc loopback |                             |
>>   +---------------------------+--------------+-----------------------------+
>>
>> - Benchmark Test
>>
>>   * Test environments:
>>        - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>>        - SMC sndbuf/DMB size 1MB.
>>
>>   * Test object:
>>        - TCP: run on TCP loopback.
>>        - SMC lo: run on SMC loopback-ism.
>>
>> 1. ipc-benchmark (see [3])
>>
>>   - ./<foo> -c 1000000 -s 100
>>
>>                              TCP                  SMC-lo
>> Message
>> rate (msg/s)              79693                  148236(+86.01%)
>>
>> 2. sockperf
>>
>>   - serv: <smc_run> sockperf sr --tcp
>>   - clnt: <smc_run> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
>>
>>                              TCP                  SMC-lo
>> Bandwidth(MBps)         4815.18                 8061.77(+67.42%)
>> Latency(us)               6.176                   3.449(-44.15%)
>>
>> 3. nginx/wrk
>>
>>   - serv: <smc_run> nginx
>>   - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
>>
>>                             TCP                   SMC-lo
>> Requests/s           196555.02                263270.95(+33.94%)
>>
>> 4. redis-benchmark
>>
>>   - serv: <smc_run> redis-server
>>   - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
>>
>>                             TCP                   SMC-lo
>> GET(Requests/s)       88711.47                120048.02(+35.32%)
>> SET(Requests/s)       89465.44                123152.71(+37.65%)
>>
>>
> 
> Hi Wen Gu,
> 
> I did run the tests again with the v6 and reviewed the patchset. If you decide to address Simons nit feel free to add my:
> 
> Reviewed-and-tested-by: Jan Karcher <jaka@linux.ibm.com>
> 
> Thanks for your effort and contribution.
> - J

Thank you all for the review and test! I will address Simon's nit and
collect the Rb tags in the next version.

Thanks!

