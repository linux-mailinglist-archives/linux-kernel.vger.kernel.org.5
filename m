Return-Path: <linux-kernel+bounces-100383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8487969F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFD91C21F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EF7B3E5;
	Tue, 12 Mar 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hQmYB09x"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0087446DB;
	Tue, 12 Mar 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254640; cv=none; b=poqdVYNSFVAUocJi9XjlnKHFW+LvF887ebnQC2x0uivTY/AYmlGJsFSjmCOr3rNWU0BUYVVlXFfQrfq5cWCDwXPs7J5bhaQ1bJIDdM7aAVgv0+fNOY/bwwiGRfiM3ZshA7fpOOWdFqo7cWOVfM+NAMNwhJL7Vc1XaqzHXQdNmyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254640; c=relaxed/simple;
	bh=9aqeEjqrSxZ3z4np5RgcZBgvi4Dkx6XdrQx5TcCjiWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/tVgdHm/EkJYJ4vvFda71prCd6y+1Gup0laPplBY1FKmt3iiMxPVeE/cgNtOsshiHLW0jIL7hQSHh6IwZfVCWigqCXHwAhz+Q8x23suMfjyp2FpcxROPnAqNjat5e6dG4xZ4VNRgLxgozHTI8NW9fszhEU3GAZ/n2S3T22GsYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hQmYB09x; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710254633; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uT8aAqyd+rduZcp2F81NvL5qdcpeON8D+3swzxD8WG4=;
	b=hQmYB09xOJPjFx0/WmJm8UxlER9GNa6CFlGSh+ZHPxaD2UCBr7hqXb5uZSn1kUB59/BX4xQ7BIglQM2lHYhoPuDaTMQc+H68/sNQtLbgOV7SRHcDJFmivzantns4mxj8xGUcHysHikNgsEfbAHvU3zpLFJIUYvLltxvubLdTu4Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2MGvX7_1710254631;
Received: from 30.221.129.234(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2MGvX7_1710254631)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 22:43:53 +0800
Message-ID: <ef810058-7529-4deb-889c-82477aeef3fb@linux.alibaba.com>
Date: Tue, 12 Mar 2024 22:43:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
 <aa8062a9-9caa-4773-a3f5-29df70ec93b7@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <aa8062a9-9caa-4773-a3f5-29df70ec93b7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/12 22:33, Jan Karcher wrote:
> 
> 
> On 12/03/2024 15:27, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The first
>> part can be referred from [2]), the updated things of this version are listed
>> at the end.
> 
> Hi Wen Gu,
> 
> Re-running the tests with this version and finishing up review.
> Please give me some time.
> 

Sure! Thank you very much for your time and help!

> Thank you
> - Jan
> 
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
>>   - Patch #1-#2: some prepare work for loopback-ism.
>>   - Patch #3-#7: implement loopback-ism device. Noted that loopback-ism now
>>     serves only SMC and no userspace interface exposed.
>>   - Patch #10-#15: memory copy optimization for intra-OS scenario.
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
>> rate (msg/s)              81433                  143938(+76.75%)
>>
>> 2. sockperf
>>
>>   - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>>   - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 
>> -t 30
>>
>>                              TCP                  SMC-lo
>> Bandwidth(MBps)         4903.07                 7978.69(+62.73%)
>> Latency(us)               6.095                   3.539(-41.94%)
>>
>> 3. nginx/wrk
>>
>>   - serv: <smc_run> nginx
>>   - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
>>
>>                             TCP                   SMC-lo
>> Requests/s           161665.67                244272.41(+51.10%)
>>
>> 4. redis-benchmark
>>
>>   - serv: <smc_run> redis-server
>>   - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
>>
>>                             TCP                   SMC-lo
>> GET(Requests/s)       88790.23                117474.30(+32.31%)
>> SET(Requests/s)       87508.20                118623.96(+35.57%)
>>
>>
>> Change log:
>>
>> v3->v2:
>> - Patch #11: use tasklet_schedule(&conn->rx_tsklet) instead of smcd_cdc_rx_handler()
>>    to avoid possible recursive locking of conn->send_lock and use {read|write}_lock_bh()
>>    to acquire dmb_ht_lock.
>>
>> v2->v1:
>> Link: https://lore.kernel.org/netdev/20240307095536.29648-1-guwen@linux.alibaba.com/
>> - All the patches: changed the term virtual-ISM to Emulated-ISM as defined by SMCv2.1.
>> - Patch #3: optimized the description of SMC_LO config. Avoid exposing loopback-ism
>>    to sysfs and remove all the knobs until future definition clear.
>> - Patch #3: try to make lockdep happy by using read_lock_bh() in smc_lo_move_data().
>> - Patch #6: defaultly use physical contiguous DMB buffers.
>> - Patch #11: defaultly enable DMB no-copy for loopback-ism and free the DMB in
>>    unregister_dmb or detach_dmb when dmb_node->refcnt reaches 0, instead of using
>>    wait_event to keep waiting in unregister_dmb.
>>
>> v1->RFC:
>> Link: https://lore.kernel.org/netdev/20240111120036.109903-1-guwen@linux.alibaba.com/
>> - Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
>>    /sys/devices/virtual/smc/loopback-ism/xfer_bytes
>> - Patch #10: add support_dmb_nocopy operation to check if SMC-D device supports
>>    merging sndbuf with peer DMB.
>> - Patch #13 & #14: introduce loopback-ism device control of DMB memory type and
>>    control of whether to merge sndbuf and DMB. They can be respectively set by:
>>    /sys/devices/virtual/smc/loopback-ism/dmb_type
>>    /sys/devices/virtual/smc/loopback-ism/dmb_copy
>>    The motivation for these two control is that a performance bottleneck was
>>    found when using vzalloced DMB and sndbuf is merged with DMB, and there are
>>    many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is caused
>>    by the lock contention in vmap_area_lock [5] which is involved in memcpy_from_msg()
>>    or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigating the
>>    vmap lock contention [6]. It has significant effects, but using virtual memory
>>    still has additional overhead compared to using physical memory.
>>    So this new version provides controls of dmb_type and dmb_copy to suit
>>    different scenarios.
>> - Some minor changes and comments improvements.
>>
>> RFC->old version([1]):
>> Link: https://lore.kernel.org/netdev/1702214654-32069-1-git-send-email-guwen@linux.alibaba.com/
>> - Patch #1: improve the loopback-ism dump, it shows as follows now:
>>    # smcd d
>>    FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>>    0000 0     loopback-ism  ffff   No        0
>> - Patch #3: introduce the smc_ism_set_v2_capable() helper and set
>>    smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
>>    regardless of whether there is already a device in smcd device list.
>> - Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
>> - Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
>>    to activate or deactivate the loopback-ism.
>> - Patch #9: introduce the statistics of loopback-ism by
>>    /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
>> - Some minor changes and comments improvements.
>>
>> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>> [2] https://lore.kernel.org/netdev/20231219142616.80697-1-guwen@linux.alibaba.com/
>> [3] https://github.com/goldsborough/ipc-bench
>> [4] https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
>> [5] https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
>> [6] https://lore.kernel.org/all/20240102184633.748113-1-urezki@gmail.com/
>>
>> Wen Gu (11):
>>    net/smc: adapt SMC-D device dump for Emulated-ISM
>>    net/smc: decouple ism_client from SMC-D DMB registration
>>    net/smc: introduce loopback-ism for SMC intra-OS shortcut
>>    net/smc: implement ID-related operations of loopback-ism
>>    net/smc: implement some unsupported operations of loopback-ism
>>    net/smc: implement DMB-related operations of loopback-ism
>>    net/smc: register loopback-ism into SMC-D device list
>>    net/smc: add operations to merge sndbuf with peer DMB
>>    net/smc: attach or detach ghost sndbuf to peer DMB
>>    net/smc: adapt cursor update when sndbuf and peer DMB are merged
>>    net/smc: implement DMB-merged operations of loopback-ism
>>
>>   drivers/s390/net/ism_drv.c |   2 +-
>>   include/net/smc.h          |   7 +-
>>   net/smc/Kconfig            |  13 ++
>>   net/smc/Makefile           |   2 +-
>>   net/smc/af_smc.c           |  28 ++-
>>   net/smc/smc_cdc.c          |  52 ++++-
>>   net/smc/smc_core.c         |  61 ++++-
>>   net/smc/smc_core.h         |   1 +
>>   net/smc/smc_ism.c          |  71 +++++-
>>   net/smc/smc_ism.h          |   5 +
>>   net/smc/smc_loopback.c     | 462 +++++++++++++++++++++++++++++++++++++
>>   net/smc/smc_loopback.h     |  52 +++++
>>   12 files changed, 727 insertions(+), 29 deletions(-)
>>   create mode 100644 net/smc/smc_loopback.c
>>   create mode 100644 net/smc/smc_loopback.h
>>

