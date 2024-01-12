Return-Path: <linux-kernel+bounces-24656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B6382BFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA6B1C20C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9926C59B52;
	Fri, 12 Jan 2024 12:32:32 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71C41C67;
	Fri, 12 Jan 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-T9dnj_1705062738;
Received: from 30.221.130.160(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-T9dnj_1705062738)
          by smtp.aliyun-inc.com;
          Fri, 12 Jan 2024 20:32:19 +0800
Message-ID: <d7f9684e-4115-4b04-9e92-dbb841a52935@linux.alibaba.com>
Date: Fri, 12 Jan 2024 20:32:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
To: Jiri Pirko <jiri@resnulli.us>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <ZaAAJDiQ3bPGGRFK@nanopsycho>
 <2d8e7aeb-06da-434c-b7fe-6c1bd2e0674a@linux.alibaba.com>
 <ZaEB-b-W9Jt77T98@nanopsycho>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ZaEB-b-W9Jt77T98@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/12 17:10, Jiri Pirko wrote:
> Fri, Jan 12, 2024 at 09:29:35AM CET, guwen@linux.alibaba.com wrote:
>>
>>

<...>

>>>> inter-containers communication within the same OS instance.
>>>>
>>>> # Design
>>>>
>>>> This patch set includes 3 parts:
>>>>
>>>> - Patch #1-#2: some prepare work for loopback-ism.
>>>> - Patch #3-#9: implement loopback-ism device.
>>>> - Patch #10-#15: memory copy optimization for loopback scenario.
>>>>
>>>> The loopback-ism device is designed as a ISMv2 device and not be limited to
>>>> a specific net namespace, ends of both inter-process connection (1/1' in diagram
>>>> below) or inter-container connection (2/2' in diagram below) can find the same
>>>> available loopback-ism and choose it during the CLC handshake.
>>>>
>>>> Container 1 (ns1)                              Container 2 (ns2)
>>>> +-----------------------------------------+    +-------------------------+
>>>> | +-------+      +-------+      +-------+ |    |        +-------+        |
>>>> | | App A |      | App B |      | App C | |    |        | App D |<-+     |
>>>> | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
>>>> |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
>>>> |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
>>>> |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
>>>> +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
>>>>                |   |           |                                  |
>>>> Kernel       |   |           |                                  |
>>>> +----+-------v---+-----------v----------------------------------+---+----+
>>>> |    |                            TCP                               |    |
>>>> |    |                                                              |    |
>>>> |    +--------------------------------------------------------------+    |
>>>> |                                                                        |
>>>> |                           +--------------+                             |
>>>> |                           | smc loopback |                             |
>>>> +---------------------------+--------------+-----------------------------+
>>>>
>>>> loopback-ism device creates DMBs (shared memory) for each connection peer.
>>>> Since data transfer occurs within the same kernel, the sndbuf of each peer
>>>> is only a descriptor and point to the same memory region as peer DMB, so that
>>>> the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.
>>>>
>>>> Container 1 (ns1)                              Container 2 (ns2)
>>>> +-----------------------------------------+    +-------------------------+
>>>> | +-------+                               |    |        +-------+        |
>>>> | | App C |-----+                         |    |        | App D |        |
>>>> | +-------+     |                         |    |        +-^-----+        |
>>>> |               |                         |    |          |              |
>>>> |           (2) |                         |    |     (2') |              |
>>>> |               |                         |    |          |              |
>>>> +---------------|-------------------------+    +----------|--------------+
>>>>                   |                                         |
>>>> Kernel          |                                         |
>>>> +---------------|-----------------------------------------|--------------+
>>>> | +--------+ +--v-----+                           +--------+ +--------+  |
>>>> | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
>>>> | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
>>>> | +-----|--+    |                                 +-----|--+             |
>>>> | | DMB C  |    +---------------------------------| DMB D  |             |
>>>> | +--------+                                      +--------+             |
>>>> |                                                                        |
>>>> |                           +--------------+                             |
>>>> |                           | smc loopback |                             |
>>>> +---------------------------+--------------+-----------------------------+
>>>>
>>>> # Benchmark Test
>>>>
>>>> * Test environments:
>>>>        - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>>>>        - SMC sndbuf/DMB size 1MB.
>>>>        - /sys/devices/virtual/smc/loopback-ism/dmb_copy is set to default 0,
>>>>          which means sndbuf and DMB are merged and no data copied between them.
>>>>        - /sys/devices/virtual/smc/loopback-ism/dmb_type is set to default 0,
>>>
>>> Exposing any configuration knobs and statistics over sysfs for
>>> softdevices does not look correct at all :/ Could you please avoid
>>> sysfs?
>>>
>>
>> In previous reviews and calls, we think loopback-ism needs to be more
>> like a device and be visible under /sys/devices.
>>
>> Would you mind explaining why using sysfs for loopback-ism is not correct?
>> since I saw some other configurations or statistics exists under /sys/devices,
>> e.g. /sys/devices/virtual/net/lo. Thank you!
> 
> You have smc_netlink.c exposing clear netlink api for the subsystem.
> Can't you extend it to contain the configuration knobs and expose stats
> instead of sysfs?
> 

Thank you for the suggestion. I've also considered this approach.

But I didn't choose to extend the smc netlink because for now smc netlink
are used for SMC protocol related attributes, for example:

SMC_NETLINK_GET_SYS_INFO:     SMC version, release, v2-capable..
SMC_NETLINK_GET_LGR_SMC{R|D}: SMC-{R|D} link group inform (lgr id, lgr conn num, lgr role..)
SMC_NETLINK_GET_LINK_SMCR:    SMC-R link inform (link id, link state, conn cnt..)
SMC_NETLINK_GET_DEV_SMCD:     SMC-D device generic inform (user cnt, pci_fid, pci_chid, pci_vendor..)
SMC_NETLINK_GET_DEV_SMCR:     SMC-R device generic inform (dev name, port pnet_id, port valid, port state..)
SMC_NETLINK_GET_STATS:        SMC generic stats (RMB cnt, Tx size, Rx size, RMB size...)

And the knobs and stats in this patchset are loopback-ism device specific
attributes, for example:

active:        loopback-ism runtime switch
dmb_type:      type of DMB provided by loopback-ism
dmb_copy:      support for DMB merge of loopback-ism
xfer_bytes:    data transferred by loopback-ism
dmbs_cnt:      DMB num provided by loopback-ism

The layer will be:

                +--------------------------------------+
                |                                      |
                |             SMC protocol             |
                |  (attrs by netlink in smc_netlink.c) |
                |                                      |
                +--------------------------------------+
              ------------------smcd_ops------------------
      +---------------+  +---------------------+  +--------------+
      | loopback-ism  |  |  s390 firmware ISM  |  | Possible     |
      +---------------+  |                     |  | other        |
      (attrs by sysfs    |                     |  | virtual ISM  |
     in smc_loopback.c)  |                     |  |              |
                         |                     |  |              |
                         +---------------------+  +--------------+

So I choose to use current way to provide this lower layer loopback-ism
device's attributes, restrict loopback-ism specific code to smc_loopback.c
and try to make a clear layer architecture.

Thanks,
Wen Gu
> 
>>
>>
>>
>> Thanks again,
>> Wen Gu
>>
>>>
>>>>          which means DMB is physically contiguous buffer.
>>>>
>>>> * Test object:
>>>>        - TCP: run on TCP loopback.
>>>>        - SMC lo: run on SMC loopback device.
>>>>
>>>> 1. ipc-benchmark (see [3])
>>>>
>>>> - ./<foo> -c 1000000 -s 100
>>>>
>>>>                              TCP                  SMC-lo
>>>> Message
>>>> rate (msg/s)              80636                  149515(+85.42%)
>>>>
>>>> 2. sockperf
>>>>
>>>> - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>>>> - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
>>>>
>>>>                              TCP                  SMC-lo
>>>> Bandwidth(MBps)         4909.36                 8197.57(+66.98%)
>>>> Latency(us)               6.098                   3.383(-44.52%)
>>>>
>>>> 3. nginx/wrk
>>>>
>>>> - serv: <smc_run> nginx
>>>> - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
>>>>
>>>>                             TCP                   SMC-lo
>>>> Requests/s           181685.74                246447.77(+35.65%)
>>>>
>>>> 4. redis-benchmark
>>>>
>>>> - serv: <smc_run> redis-server
>>>> - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
>>>>
>>>>                             TCP                   SMC-lo
>>>> GET(Requests/s)       85855.34                118553.64(+38.09%)
>>>> SET(Requests/s)       86824.40                125944.58(+45.06%)
>>>>
>>>>
>>>> Change log:
>>>>
>>>> v1->RFC:
>>>> - Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
>>>>    /sys/devices/virtual/smc/loopback-ism/xfer_bytes
>>>> - Patch #10: add support_dmb_nocopy operation to check if SMC-D device supports
>>>>    merging sndbuf with peer DMB.
>>>> - Patch #13 & #14: introduce loopback-ism device control of DMB memory type and
>>>>    control of whether to merge sndbuf and DMB. They can be respectively set by:
>>>>    /sys/devices/virtual/smc/loopback-ism/dmb_type
>>>>    /sys/devices/virtual/smc/loopback-ism/dmb_copy
>>>>    The motivation for these two control is that a performance bottleneck was
>>>>    found when using vzalloced DMB and sndbuf is merged with DMB, and there are
>>>>    many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is caused
>>>>    by the lock contention in vmap_area_lock [5] which is involved in memcpy_from_msg()
>>>>    or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigating the
>>>>    vmap lock contention [6]. It has significant effects, but using virtual memory
>>>>    still has additional overhead compared to using physical memory.
>>>>    So this new version provides controls of dmb_type and dmb_copy to suit
>>>>    different scenarios.
>>>> - Some minor changes and comments improvements.
>>>>
>>>> RFC->old version([1]):
>>>> Link: https://lore.kernel.org/netdev/1702214654-32069-1-git-send-email-guwen@linux.alibaba.com/
>>>> - Patch #1: improve the loopback-ism dump, it shows as follows now:
>>>>    # smcd d
>>>>    FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>>>>    0000 0     loopback-ism  ffff   No        0
>>>> - Patch #3: introduce the smc_ism_set_v2_capable() helper and set
>>>>    smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
>>>>    regardless of whether there is already a device in smcd device list.
>>>> - Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
>>>> - Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
>>>>    to activate or deactivate the loopback-ism.
>>>> - Patch #9: introduce the statistics of loopback-ism by
>>>>    /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
>>>> - Some minor changes and comments improvements.
>>>>
>>>> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>>>> [2] https://lore.kernel.org/netdev/20231219142616.80697-1-guwen@linux.alibaba.com/
>>>> [3] https://github.com/goldsborough/ipc-bench
>>>> [4] https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
>>>> [5] https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
>>>> [6] https://lore.kernel.org/all/20240102184633.748113-1-urezki@gmail.com/
>>>>
>>>> Wen Gu (15):
>>>>    net/smc: improve SMC-D device dump for virtual ISM
>>>>    net/smc: decouple specialized struct from SMC-D DMB registration
>>>>    net/smc: introduce virtual ISM device loopback-ism
>>>>    net/smc: implement ID-related operations of loopback-ism
>>>>    net/smc: implement some unsupported operations of loopback-ism
>>>>    net/smc: implement DMB-related operations of loopback-ism
>>>>    net/smc: register loopback-ism into SMC-D device list
>>>>    net/smc: introduce loopback-ism runtime switch
>>>>    net/smc: introduce loopback-ism statistics attributes
>>>>    net/smc: add operations to merge sndbuf with peer DMB
>>>>    net/smc: attach or detach ghost sndbuf to peer DMB
>>>>    net/smc: adapt cursor update when sndbuf and peer DMB are merged
>>>>    net/smc: introduce loopback-ism DMB type control
>>>>    net/smc: introduce loopback-ism DMB data copy control
>>>>    net/smc: implement DMB-merged operations of loopback-ism
>>>>
>>>> drivers/s390/net/ism_drv.c |   2 +-
>>>> include/net/smc.h          |   7 +-
>>>> net/smc/Kconfig            |  13 +
>>>> net/smc/Makefile           |   2 +-
>>>> net/smc/af_smc.c           |  28 +-
>>>> net/smc/smc_cdc.c          |  58 ++-
>>>> net/smc/smc_cdc.h          |   1 +
>>>> net/smc/smc_core.c         |  61 +++-
>>>> net/smc/smc_core.h         |   1 +
>>>> net/smc/smc_ism.c          |  71 +++-
>>>> net/smc/smc_ism.h          |   5 +
>>>> net/smc/smc_loopback.c     | 718 +++++++++++++++++++++++++++++++++++++
>>>> net/smc/smc_loopback.h     |  88 +++++
>>>> 13 files changed, 1026 insertions(+), 29 deletions(-)
>>>> create mode 100644 net/smc/smc_loopback.c
>>>> create mode 100644 net/smc/smc_loopback.h
>>>>
>>>> -- 
>>>> 2.32.0.3.g01195cf9f
>>>>
>>>>

