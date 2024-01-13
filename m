Return-Path: <linux-kernel+bounces-25233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F982CAC5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A48283FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36D617E8;
	Sat, 13 Jan 2024 09:22:31 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5421841;
	Sat, 13 Jan 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-VLVBo_1705137736;
Received: from 192.168.43.59(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-VLVBo_1705137736)
          by smtp.aliyun-inc.com;
          Sat, 13 Jan 2024 17:22:18 +0800
Message-ID: <895a0da3-bf6c-4e76-a672-d73481b4e58b@linux.alibaba.com>
Date: Sat, 13 Jan 2024 17:22:15 +0800
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
 <d7f9684e-4115-4b04-9e92-dbb841a52935@linux.alibaba.com>
 <ZaFfqZbgpVtVt4XM@nanopsycho>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ZaFfqZbgpVtVt4XM@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/12 23:50, Jiri Pirko wrote:
> Fri, Jan 12, 2024 at 01:32:14PM CET, guwen@linux.alibaba.com wrote:
>>
>>
>> On 2024/1/12 17:10, Jiri Pirko wrote:
>>> Fri, Jan 12, 2024 at 09:29:35AM CET, guwen@linux.alibaba.com wrote:
>>>>

<...>

>>>>>> # Benchmark Test
>>>>>>
>>>>>> * Test environments:
>>>>>>         - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>>>>>>         - SMC sndbuf/DMB size 1MB.
>>>>>>         - /sys/devices/virtual/smc/loopback-ism/dmb_copy is set to default 0,
>>>>>>           which means sndbuf and DMB are merged and no data copied between them.
>>>>>>         - /sys/devices/virtual/smc/loopback-ism/dmb_type is set to default 0,
>>>>>
>>>>> Exposing any configuration knobs and statistics over sysfs for
>>>>> softdevices does not look correct at all :/ Could you please avoid
>>>>> sysfs?
>>>>>
>>>>
>>>> In previous reviews and calls, we think loopback-ism needs to be more
>>>> like a device and be visible under /sys/devices.
>>>>
>>>> Would you mind explaining why using sysfs for loopback-ism is not correct?
>>>> since I saw some other configurations or statistics exists under /sys/devices,
>>>> e.g. /sys/devices/virtual/net/lo. Thank you!
>>>
>>> You have smc_netlink.c exposing clear netlink api for the subsystem.
>>> Can't you extend it to contain the configuration knobs and expose stats
>>> instead of sysfs?
>>>
>>
>> Thank you for the suggestion. I've also considered this approach.
>>
>> But I didn't choose to extend the smc netlink because for now smc netlink
>> are used for SMC protocol related attributes, for example:
>>
>> SMC_NETLINK_GET_SYS_INFO:     SMC version, release, v2-capable..
>> SMC_NETLINK_GET_LGR_SMC{R|D}: SMC-{R|D} link group inform (lgr id, lgr conn num, lgr role..)
>> SMC_NETLINK_GET_LINK_SMCR:    SMC-R link inform (link id, link state, conn cnt..)
>> SMC_NETLINK_GET_DEV_SMCD:     SMC-D device generic inform (user cnt, pci_fid, pci_chid, pci_vendor..)
>> SMC_NETLINK_GET_DEV_SMCR:     SMC-R device generic inform (dev name, port pnet_id, port valid, port state..)
>> SMC_NETLINK_GET_STATS:        SMC generic stats (RMB cnt, Tx size, Rx size, RMB size...)
>>
>> And the knobs and stats in this patchset are loopback-ism device specific
>> attributes, for example:
>>
>> active:        loopback-ism runtime switch
>> dmb_type:      type of DMB provided by loopback-ism
>> dmb_copy:      support for DMB merge of loopback-ism
>> xfer_bytes:    data transferred by loopback-ism
>> dmbs_cnt:      DMB num provided by loopback-ism
>>
>> The layer will be:
>>
>>                +--------------------------------------+
>>                |                                      |
>>                |             SMC protocol             |
>>                |  (attrs by netlink in smc_netlink.c) |
>>                |                                      |
>>                +--------------------------------------+
>>              ------------------smcd_ops------------------
>>      +---------------+  +---------------------+  +--------------+
>>      | loopback-ism  |  |  s390 firmware ISM  |  | Possible     |
>>      +---------------+  |                     |  | other        |
>>      (attrs by sysfs    |                     |  | virtual ISM  |
>>     in smc_loopback.c)  |                     |  |              |
>>                         |                     |  |              |
>>                         +---------------------+  +--------------+
> 
> So nest it:
> SMC_NETLINK_BACKEND_GET_INFO
> SMC_NETLINK_BACKEND_GET_STATS
> ?
> I mean, isn't it better to have the backend knobs and stats in one place
> under same netlink commands and attributes than random sysfs path ?
> 
Thank you for suggestion.

I think it is not about nesting or gathering knobs and stats. It is
about not coupling underlying device details to upper layer SMC stack.

 From SMC perspective, it cares about the abstract operations defined
by smcd_ops, regardless of which underlying devices provide these
functions and how they provide. So IMO the details or configurations
of underlying devices shouldn't be involved in SMC.

Besides, the knobs and stats here are specific for loopback-ism device,
they include runtime switch, buffer type choice and mode choice of
loopback-ism (basically they won't change after being set once). The
other kinds of devices used by SMC-D, e.g. s390 firmware ISM or other
virtual ISMs have no similar things.

So I prefer to keep the current solution instead of expanding upper
layer SMC netlink.

Thanks,
Wen Gu

> 
> 
>>
>> So I choose to use current way to provide this lower layer loopback-ism
>> device's attributes, restrict loopback-ism specific code to smc_loopback.c
>> and try to make a clear layer architecture.
>>
>> Thanks,
>> Wen Gu
>>>
>>>>
>>>>
>>>>
>>>> Thanks again,
>>>> Wen Gu
>>>>
>>>>>
>>>>>>           which means DMB is physically contiguous buffer.
>>>>>>
>>>>>> * Test object:
>>>>>>         - TCP: run on TCP loopback.
>>>>>>         - SMC lo: run on SMC loopback device.
>>>>>>
>>>>>> 1. ipc-benchmark (see [3])
>>>>>>
>>>>>> - ./<foo> -c 1000000 -s 100
>>>>>>
>>>>>>                               TCP                  SMC-lo
>>>>>> Message
>>>>>> rate (msg/s)              80636                  149515(+85.42%)
>>>>>>
>>>>>> 2. sockperf
>>>>>>
>>>>>> - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>>>>>> - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
>>>>>>
>>>>>>                               TCP                  SMC-lo
>>>>>> Bandwidth(MBps)         4909.36                 8197.57(+66.98%)
>>>>>> Latency(us)               6.098                   3.383(-44.52%)
>>>>>>
>>>>>> 3. nginx/wrk
>>>>>>
>>>>>> - serv: <smc_run> nginx
>>>>>> - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
>>>>>>
>>>>>>                              TCP                   SMC-lo
>>>>>> Requests/s           181685.74                246447.77(+35.65%)
>>>>>>
>>>>>> 4. redis-benchmark
>>>>>>
>>>>>> - serv: <smc_run> redis-server
>>>>>> - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
>>>>>>
>>>>>>                              TCP                   SMC-lo
>>>>>> GET(Requests/s)       85855.34                118553.64(+38.09%)
>>>>>> SET(Requests/s)       86824.40                125944.58(+45.06%)
>>>>>>
>>>>>>
>>>>>> Change log:
>>>>>>
>>>>>> v1->RFC:
>>>>>> - Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
>>>>>>     /sys/devices/virtual/smc/loopback-ism/xfer_bytes
>>>>>> - Patch #10: add support_dmb_nocopy operation to check if SMC-D device supports
>>>>>>     merging sndbuf with peer DMB.
>>>>>> - Patch #13 & #14: introduce loopback-ism device control of DMB memory type and
>>>>>>     control of whether to merge sndbuf and DMB. They can be respectively set by:
>>>>>>     /sys/devices/virtual/smc/loopback-ism/dmb_type
>>>>>>     /sys/devices/virtual/smc/loopback-ism/dmb_copy
>>>>>>     The motivation for these two control is that a performance bottleneck was
>>>>>>     found when using vzalloced DMB and sndbuf is merged with DMB, and there are
>>>>>>     many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is caused
>>>>>>     by the lock contention in vmap_area_lock [5] which is involved in memcpy_from_msg()
>>>>>>     or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigating the
>>>>>>     vmap lock contention [6]. It has significant effects, but using virtual memory
>>>>>>     still has additional overhead compared to using physical memory.
>>>>>>     So this new version provides controls of dmb_type and dmb_copy to suit
>>>>>>     different scenarios.
>>>>>> - Some minor changes and comments improvements.
>>>>>>
>>>>>> RFC->old version([1]):
>>>>>> Link: https://lore.kernel.org/netdev/1702214654-32069-1-git-send-email-guwen@linux.alibaba.com/
>>>>>> - Patch #1: improve the loopback-ism dump, it shows as follows now:
>>>>>>     # smcd d
>>>>>>     FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>>>>>>     0000 0     loopback-ism  ffff   No        0
>>>>>> - Patch #3: introduce the smc_ism_set_v2_capable() helper and set
>>>>>>     smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
>>>>>>     regardless of whether there is already a device in smcd device list.
>>>>>> - Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
>>>>>> - Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
>>>>>>     to activate or deactivate the loopback-ism.
>>>>>> - Patch #9: introduce the statistics of loopback-ism by
>>>>>>     /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
>>>>>> - Some minor changes and comments improvements.
>>>>>>
>>>>>> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>>>>>> [2] https://lore.kernel.org/netdev/20231219142616.80697-1-guwen@linux.alibaba.com/
>>>>>> [3] https://github.com/goldsborough/ipc-bench
>>>>>> [4] https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
>>>>>> [5] https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
>>>>>> [6] https://lore.kernel.org/all/20240102184633.748113-1-urezki@gmail.com/
>>>>>>
>>>>>> Wen Gu (15):
>>>>>>     net/smc: improve SMC-D device dump for virtual ISM
>>>>>>     net/smc: decouple specialized struct from SMC-D DMB registration
>>>>>>     net/smc: introduce virtual ISM device loopback-ism
>>>>>>     net/smc: implement ID-related operations of loopback-ism
>>>>>>     net/smc: implement some unsupported operations of loopback-ism
>>>>>>     net/smc: implement DMB-related operations of loopback-ism
>>>>>>     net/smc: register loopback-ism into SMC-D device list
>>>>>>     net/smc: introduce loopback-ism runtime switch
>>>>>>     net/smc: introduce loopback-ism statistics attributes
>>>>>>     net/smc: add operations to merge sndbuf with peer DMB
>>>>>>     net/smc: attach or detach ghost sndbuf to peer DMB
>>>>>>     net/smc: adapt cursor update when sndbuf and peer DMB are merged
>>>>>>     net/smc: introduce loopback-ism DMB type control
>>>>>>     net/smc: introduce loopback-ism DMB data copy control
>>>>>>     net/smc: implement DMB-merged operations of loopback-ism
>>>>>>
>>>>>> drivers/s390/net/ism_drv.c |   2 +-
>>>>>> include/net/smc.h          |   7 +-
>>>>>> net/smc/Kconfig            |  13 +
>>>>>> net/smc/Makefile           |   2 +-
>>>>>> net/smc/af_smc.c           |  28 +-
>>>>>> net/smc/smc_cdc.c          |  58 ++-
>>>>>> net/smc/smc_cdc.h          |   1 +
>>>>>> net/smc/smc_core.c         |  61 +++-
>>>>>> net/smc/smc_core.h         |   1 +
>>>>>> net/smc/smc_ism.c          |  71 +++-
>>>>>> net/smc/smc_ism.h          |   5 +
>>>>>> net/smc/smc_loopback.c     | 718 +++++++++++++++++++++++++++++++++++++
>>>>>> net/smc/smc_loopback.h     |  88 +++++
>>>>>> 13 files changed, 1026 insertions(+), 29 deletions(-)
>>>>>> create mode 100644 net/smc/smc_loopback.c
>>>>>> create mode 100644 net/smc/smc_loopback.h
>>>>>>
>>>>>> -- 
>>>>>> 2.32.0.3.g01195cf9f
>>>>>>
>>>>>>

