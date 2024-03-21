Return-Path: <linux-kernel+bounces-109755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7820088554C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324BC282B87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E905B5A6;
	Thu, 21 Mar 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GFSgtZ0c"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81F1DFD2;
	Thu, 21 Mar 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008735; cv=none; b=XtytA5u8Y9vUs/Wr4RGIhtP/LkxZRlClOtEiyf1it79fIvfoIw5JYmhu1FjIWZ7f9mh17cEVDm71nzREcU7Y9Sf7ApWJVpDctq7bWNocw6r8C5L7M62r4394Kxc/xecfiWvt/UrPXvK6HU45Gdk9lXxqirSDHiSdnreBilHqC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008735; c=relaxed/simple;
	bh=btUzfRjc7u+lJqCqrt0PKMnEzipBonGP6RO5MLdkERA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BtYsljQVBB5jiwkWiZQ7+YEJC2pIQmpfkzsfAHjPkvB25SEKUDNyrDhmKt6xktHT1HNW7nniA4BAxNKktpiMfeMy5Yz0939hyPFUG+7ul/IkSpTkZTi543t0OQHdP0rNAcO02ltu/7qztyW/Pp5wILHghImfjMj8MIglmZ5jvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GFSgtZ0c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L5qv8Q003794;
	Thu, 21 Mar 2024 08:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QAjMN1wyzQIE7r+l38eKerVt3H1Ejfd0fKwTDbS+z1w=;
 b=GFSgtZ0cQSfi7/SOAi+cQhU1abtF88bN7uiSXCb4shYXu7dXNiC4eidvA14F0WQzMD8f
 y7h5qc8IU1UpmyPITF2aSQ4E+S8CnWyhszma83fVyLyYxj24Z3URcELHIrF55O76E2Zw
 A27ZLo5Mo5KFLoWc3GNn5irGnm6eQck6hqR8hxMjaV/58SxvxKgM3QUMkfpfE+LATrHF
 YdLcBDKBuGugaC5MeU5sK4lrP4m2D0unPFUYenvH1vmzAjSS/zIViZVRrDN0a1wHtkzY
 67GD93MGiu9NlFVjQX0KpNRil9GcKS7V5/U+1Zd4gRNoBlgCracCdl7jz4h2InqWiBCb jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0dk90e37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42L8C8g4008476;
	Thu, 21 Mar 2024 08:12:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0dk90e33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L7FRuR019872;
	Thu, 21 Mar 2024 08:12:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqykufdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L8C1IY47645076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 08:12:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCFD22005A;
	Thu, 21 Mar 2024 08:12:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C44952004E;
	Thu, 21 Mar 2024 08:12:00 +0000 (GMT)
Received: from [9.179.15.41] (unknown [9.179.15.41])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 08:12:00 +0000 (GMT)
Message-ID: <3b6c41e5-ef2c-4c75-a444-afc130fe2529@linux.ibm.com>
Date: Thu, 21 Mar 2024 09:11:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240317100545.96663-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: khc5HsffR76YSm4zaCqCFXiQV7JuERzI
X-Proofpoint-GUID: Fa7WbP8iQMtlytp4llk0luuFZp98YPgK
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
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210055



On 17/03/2024 11:05, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The first
> part can be referred from [2]), the updated things of this version are listed
> at the end.

Hi Wen Gu,

thanks for the v4. Please see my comments for the patches.
Testing looks good so far on s390.

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
>   - Patch #1: some prepare work for loopback-ism.
>   - Patch #2-#7: implement loopback-ism device. Noted that loopback-ism now
>     serves only SMC and no userspace interface exposed.
>   - Patch #8-#11: memory copy optimization for intra-OS scenario.
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
> rate (msg/s)              81433                  143938(+76.75%)
> 
> 2. sockperf
> 
>   - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>   - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
> 
>                              TCP                  SMC-lo
> Bandwidth(MBps)         4903.07                 7978.69(+62.73%)
> Latency(us)               6.095                   3.539(-41.94%)
> 
> 3. nginx/wrk
> 
>   - serv: <smc_run> nginx
>   - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
> 
>                             TCP                   SMC-lo
> Requests/s           161665.67                244272.41(+51.10%)
> 
> 4. redis-benchmark
> 
>   - serv: <smc_run> redis-server
>   - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
> 
>                             TCP                   SMC-lo
> GET(Requests/s)       88790.23                117474.30(+32.31%)
> SET(Requests/s)       87508.20                118623.96(+35.57%)
> 
> 
> Change log:
> 
> RFC v4->v3:
> - The merge window of v6.9 is open, so post this series as an RFC.
> - Patch #6: since some information fed back by smc_nl_handle_smcd_dev() dose
>    not apply to Emulated-ISM (including loopback-ism here), loopback-ism is
>    not exposed through smc netlink for the time being. we may refactor this
>    part when smc netlink interface is updated.
> 
> v3->v2:
> Link: https://lore.kernel.org/netdev/20240312142743.41406-1-guwen@linux.alibaba.com/
> - Patch #11: use tasklet_schedule(&conn->rx_tsklet) instead of smcd_cdc_rx_handler()
>    to avoid possible recursive locking of conn->send_lock and use {read|write}_lock_bh()
>    to acquire dmb_ht_lock.
> 
> v2->v1:
> Link: https://lore.kernel.org/netdev/20240307095536.29648-1-guwen@linux.alibaba.com/
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
> Link: https://lore.kernel.org/netdev/20240111120036.109903-1-guwen@linux.alibaba.com/
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
>    net/smc: decouple ism_client from SMC-D DMB registration
>    net/smc: introduce loopback-ism for SMC intra-OS shortcut
>    net/smc: implement ID-related operations of loopback-ism
>    net/smc: implement some unsupported operations of loopback-ism
>    net/smc: implement DMB-related operations of loopback-ism
>    net/smc: ignore loopback-ism when dumping SMC-D devices
>    net/smc: register loopback-ism into SMC-D device list
>    net/smc: add operations to merge sndbuf with peer DMB
>    net/smc: attach or detach ghost sndbuf to peer DMB
>    net/smc: adapt cursor update when sndbuf and peer DMB are merged
>    net/smc: implement DMB-merged operations of loopback-ism
> 
>   drivers/s390/net/ism_drv.c |   2 +-
>   include/net/smc.h          |   7 +-
>   net/smc/Kconfig            |  13 ++
>   net/smc/Makefile           |   2 +-
>   net/smc/af_smc.c           |  28 ++-
>   net/smc/smc_cdc.c          |  52 ++++-
>   net/smc/smc_core.c         |  61 ++++-
>   net/smc/smc_core.h         |   1 +
>   net/smc/smc_ism.c          |  60 ++++-
>   net/smc/smc_ism.h          |  10 +
>   net/smc/smc_loopback.c     | 462 +++++++++++++++++++++++++++++++++++++
>   net/smc/smc_loopback.h     |  52 +++++
>   12 files changed, 724 insertions(+), 26 deletions(-)
>   create mode 100644 net/smc/smc_loopback.c
>   create mode 100644 net/smc/smc_loopback.h
> 

