Return-Path: <linux-kernel+bounces-96996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082BF876435
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761751F22E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217F057335;
	Fri,  8 Mar 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WD9Z6FgV"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF656459;
	Fri,  8 Mar 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900569; cv=none; b=SJuuwnY51Qz5k/J7o7QJqBRVVlVKd1F4J5AdKcF36cCfIrSuuh6uYqhJGpCR0IN5UF91z18deWbo83q1MlkXJZiU3hmYHBWIW9+RBEjvdqmsXvJp1Vjnb1cjDVsXjNSp2ixfuDIV9B/kT0sWSTIAvG/vIDzWHYoX66vRJAEX6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900569; c=relaxed/simple;
	bh=MwnN52taKxoIrsRQSWZvKNKBFp0IP5evqvl5JrzWQv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P+Bdyl+hCnLXZwCIN20yIZPXpV2IB1AHWuCEei0JeatbrtjCt+aqpKp/ODwfndsUXewgbTUO+kc8uinWlunhbD7lNXczcUCQwk9XC4AhhWvIJx3goXqIpU88Jej+8sthh8vQ0FFH4c+zB1gRXZNNpKob7KcjxNnuBcL1wFJ+40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WD9Z6FgV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Bw7eF003021;
	Fri, 8 Mar 2024 12:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3P5IRkSyssxG3VEnWZ5U3CdG/Lc/YVW/KpoiKNcZ5h8=;
 b=WD9Z6FgVc3Bc7wOyKRYnRT8nA1ePTz9ZPsATrhfGCIdMQZDjmMSDHP2FRv293r5RW53S
 +kt13wewpILBlv6Ge25kFn9KRx9Ym7Ur8o7lCM2eZ0SYnE5y6NmNEgngYve2Tn8uNLWo
 aBKSTEaD55CTFaCeiHhY3AQqBq7hI47au5kisdAhgwEHEEoAMmukTTCWb8TDkG5NCzRQ
 BNUz4UUfvel51KPVNtsYJP7EJojm3ypyrPkA071kJ9Wpu5f+jkAI4MUOZb4f2zcczb1e
 CTgno1gbBx5sH28cmLI0rnqCeXmpVnGTWLks0o5GeN2puRuZy9/lybBFp/4aPCUka8TQ Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr28w8cvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:22:42 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428C9ABp000350;
	Fri, 8 Mar 2024 12:22:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr28w8cv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:22:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428B75OW026296;
	Fri, 8 Mar 2024 12:22:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfepcahy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:22:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428CMYFm26870026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 12:22:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3BA820043;
	Fri,  8 Mar 2024 12:22:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B5F420040;
	Fri,  8 Mar 2024 12:22:33 +0000 (GMT)
Received: from [9.171.69.10] (unknown [9.171.69.10])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 12:22:33 +0000 (GMT)
Message-ID: <a95ed8a0-0f31-431c-aa4c-d81e2efcbf6d@linux.ibm.com>
Date: Fri, 8 Mar 2024 13:22:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240307095536.29648-1-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240307095536.29648-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lOLea1TH92hWdr1pP8YPCr_ZzFpATaEm
X-Proofpoint-GUID: m-QxkFzrFEqPD6q7Znhqtd8DUQa4jMSS
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
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080099



On 07/03/2024 10:55, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The first
> part can be referred from [2]), the updated things of this version are listed
> at the end.

Hi Wen Gu,

thanks for the updated patch. Please givr me some time to review and 
test the latest version.

Thanks
- Jan

> 
> - Background
> 
> SMC-D is now used in IBM z with ISM function to optimize network interconnect
> for intra-CPC communications. Inspired by this, we try to make SMC-D available
> on the non-s390 architecture through a software-implemented Emulated-ISM device,
> that is the loopback-ism device here, to accelerate inter-process or
> inter-containers communication within the same OS instance.
> 
> - Design
> 
> This patch set includes 3 parts:
> 
>   - Patch #1-#2: some prepare work for loopback-ism.
>   - Patch #3-#7: implement loopback-ism device. Noted that loopback-ism now
>     serves only SMC and no userspace interface exposed.
>   - Patch #10-#15: memory copy optimization for intra-OS scenario.
> 
> The loopback-ism device is designed as an ISMv2 device and not be limited to
> a specific net namespace, ends of both inter-process connection (1/1' in diagram
> below) or inter-container connection (2/2' in diagram below) can find the same
> available loopback-ism and choose it during the CLC handshake.
> 
>   Container 1 (ns1)                              Container 2 (ns2)
>   +-----------------------------------------+    +-------------------------+
>   | +-------+      +-------+      +-------+ |    |        +-------+        |
>   | | App A |      | App B |      | App C | |    |        | App D |<-+     |
>   | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
>   |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
>   |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
>   |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
>   +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
>                |   |           |                                  |
>   Kernel       |   |           |                                  |
>   +----+-------v---+-----------v----------------------------------+---+----+
>   |    |                            TCP                               |    |
>   |    |                                                              |    |
>   |    +--------------------------------------------------------------+    |
>   |                                                                        |
>   |                           +--------------+                             |
>   |                           | smc loopback |                             |
>   +---------------------------+--------------+-----------------------------+
> 
> loopback-ism device creates DMBs (shared memory) for each connection peer.
> Since data transfer occurs within the same kernel, the sndbuf of each peer
> is only a descriptor and point to the same memory region as peer DMB, so that
> the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.
> 
>   Container 1 (ns1)                              Container 2 (ns2)
>   +-----------------------------------------+    +-------------------------+
>   | +-------+                               |    |        +-------+        |
>   | | App C |-----+                         |    |        | App D |        |
>   | +-------+     |                         |    |        +-^-----+        |
>   |               |                         |    |          |              |
>   |           (2) |                         |    |     (2') |              |
>   |               |                         |    |          |              |
>   +---------------|-------------------------+    +----------|--------------+
>                   |                                         |
>   Kernel          |                                         |
>   +---------------|-----------------------------------------|--------------+
>   | +--------+ +--v-----+                           +--------+ +--------+  |
>   | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
>   | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
>   | +-----|--+    |                                 +-----|--+             |
>   | | DMB C  |    +---------------------------------| DMB D  |             |
>   | +--------+                                      +--------+             |
>   |                                                                        |
>   |                           +--------------+                             |
>   |                           | smc loopback |                             |
>   +---------------------------+--------------+-----------------------------+
> 
> - Benchmark Test
> 
>   * Test environments:
>        - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>        - SMC sndbuf/DMB size 1MB.
> 
>   * Test object:
>        - TCP: run on TCP loopback.
>        - SMC lo: run on SMC loopback-ism.
> 
> 1. ipc-benchmark (see [3])
> 
>   - ./<foo> -c 1000000 -s 100
> 
>                              TCP                  SMC-lo
> Message
> rate (msg/s)              79287                  148946(+87.86%)
> 
> 2. sockperf
> 
>   - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>   - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
> 
>                              TCP                  SMC-lo
> Bandwidth(MBps)         5053.47                 8195.07(+62.17%)
> Latency(us)               6.108                   3.404(-44.27%)
> 
> 3. nginx/wrk
> 
>   - serv: <smc_run> nginx
>   - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
> 
>                             TCP                   SMC-lo
> Requests/s           178187.56                247970.92(+39.16%)
> 
> 4. redis-benchmark
> 
>   - serv: <smc_run> redis-server
>   - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
> 
>                             TCP                   SMC-lo
> GET(Requests/s)       89067.02                123877.36(+39.08%)
> SET(Requests/s)       87700.07                131319.77(+49.73%)
> 
> 
> Change log:
> 
> v2->v1:
> - All the patches: changed the term virtual-ISM to Emulated-ISM as defined by SMCv2.1.
> - Patch #3: optimized the description of SMC_LO config. Avoid exposing loopback-ism
>    to sysfs and remove all the knobs until future definition clear.
> - Patch #3: try to make lockdep happy by using read_lock_bh() in smc_lo_move_data().
> - Patch #6: defaultly use physical contiguous DMB buffers.
> - Patch #11: defaultly enable DMB no-copy for loopback-ism and free the DMB in
>    unregister_dmb or detach_dmb when dmb_node->refcnt reaches 0, instead of using
>    wait_event to keep waiting in unregister_dmb.
> 
> v1->RFC:
> - Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
>    /sys/devices/virtual/smc/loopback-ism/xfer_bytes
> - Patch #10: add support_dmb_nocopy operation to check if SMC-D device supports
>    merging sndbuf with peer DMB.
> - Patch #13 & #14: introduce loopback-ism device control of DMB memory type and
>    control of whether to merge sndbuf and DMB. They can be respectively set by:
>    /sys/devices/virtual/smc/loopback-ism/dmb_type
>    /sys/devices/virtual/smc/loopback-ism/dmb_copy
>    The motivation for these two control is that a performance bottleneck was
>    found when using vzalloced DMB and sndbuf is merged with DMB, and there are
>    many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is caused
>    by the lock contention in vmap_area_lock [5] which is involved in memcpy_from_msg()
>    or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigating the
>    vmap lock contention [6]. It has significant effects, but using virtual memory
>    still has additional overhead compared to using physical memory.
>    So this new version provides controls of dmb_type and dmb_copy to suit
>    different scenarios.
> - Some minor changes and comments improvements.
> 
> RFC->old version([1]):
> Link: https://lore.kernel.org/netdev/1702214654-32069-1-git-send-email-guwen@linux.alibaba.com/
> - Patch #1: improve the loopback-ism dump, it shows as follows now:
>    # smcd d
>    FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>    0000 0     loopback-ism  ffff   No        0
> - Patch #3: introduce the smc_ism_set_v2_capable() helper and set
>    smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
>    regardless of whether there is already a device in smcd device list.
> - Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
> - Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
>    to activate or deactivate the loopback-ism.
> - Patch #9: introduce the statistics of loopback-ism by
>    /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
> - Some minor changes and comments improvements.
> 
> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> [2] https://lore.kernel.org/netdev/20231219142616.80697-1-guwen@linux.alibaba.com/
> [3] https://github.com/goldsborough/ipc-bench
> [4] https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
> [5] https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
> [6] https://lore.kernel.org/all/20240102184633.748113-1-urezki@gmail.com/
> 
> Wen Gu (11):
>    net/smc: adapt SMC-D device dump for Emulated-ISM
>    net/smc: decouple ism_client from SMC-D DMB registration
>    net/smc: introduce loopback-ism for SMC intra-OS shortcut
>    net/smc: implement ID-related operations of loopback-ism
>    net/smc: implement some unsupported operations of loopback-ism
>    net/smc: implement DMB-related operations of loopback-ism
>    net/smc: register loopback-ism into SMC-D device list
>    net/smc: add operations to merge sndbuf with peer DMB
>    net/smc: attach or detach ghost sndbuf to peer DMB
>    net/smc: adapt cursor update when sndbuf and peer DMB are merged
>    net/smc: implement DMB-merged operations of loopback-ism
> 
>   drivers/s390/net/ism_drv.c |   2 +-
>   include/net/smc.h          |   7 +-
>   net/smc/Kconfig            |  13 +
>   net/smc/Makefile           |   2 +-
>   net/smc/af_smc.c           |  28 ++-
>   net/smc/smc_cdc.c          |  58 ++++-
>   net/smc/smc_cdc.h          |   1 +
>   net/smc/smc_core.c         |  61 ++++-
>   net/smc/smc_core.h         |   1 +
>   net/smc/smc_ism.c          |  71 +++++-
>   net/smc/smc_ism.h          |   5 +
>   net/smc/smc_loopback.c     | 469 +++++++++++++++++++++++++++++++++++++
>   net/smc/smc_loopback.h     |  52 ++++
>   13 files changed, 741 insertions(+), 29 deletions(-)
>   create mode 100644 net/smc/smc_loopback.c
>   create mode 100644 net/smc/smc_loopback.h
> 

