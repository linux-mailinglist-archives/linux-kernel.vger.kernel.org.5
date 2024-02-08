Return-Path: <linux-kernel+bounces-57485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099CC84D9B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B617C282644
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6503D67C66;
	Thu,  8 Feb 2024 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xbmkv5wN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC267C61
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371609; cv=none; b=gY4Ro+OIDB7GH9vga2dAdnn7qgiWfPzgqgw+R6XRk4YHMUS5uEG37jPvYocJ1nZl7ePvTASj/i7Iy9WUo8J7Zxv36V9tjyay4h1laVzSkUO+/+RvxmZbma5DIPktDCYezW37q7MguSd6Q9PtkIQbNGKoXao4JuyWL+kKeizuv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371609; c=relaxed/simple;
	bh=xVb0C3dbyq1xbserUKHoovA7zf1xTE34Kb2AhThIueM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D78svxeewSMIFZDdOxyIX7huf0XE8DbgW//LoGcRGtGuv1dN1eaKRuAdOhdaTNMuOLaEpd9TYJgaG/ZQmd8t6ylw8IVSStOTasV1mJzqFWVBbOR6SfgBExEmDHpkPvHvWrF6oNNZdVGiwRsM9GkNS9lb8HmX04VVLZJ/B7V9Igk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xbmkv5wN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4183MTtW017376;
	Thu, 8 Feb 2024 05:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZztR+92YMRjspZGkSCWD3w8VBnmbNuBtLEscOQCBG8c=;
 b=Xbmkv5wNTJTkP7zcJb3Pl/YJt43MSlX3Vin8YSvhjejAVoNs+2Ag6Ww6ZkbPlUCw63Gq
 b/cQzhIedvPAgbTO2ySI5rAzaUjcApb2Vw4pP5FDA3jZ+ChaUO3yihOYbN8/E1ZaIjYG
 Wfou19IMfcQ6fCwMDMQ/NCrhOYdnzK/46kqnwHzWSSfcVehFsfukjz+/FtGUasbKvbdz
 m2BWIiJfkDvcpx+MhdGNjhpysWV1tghwtihTLC7RPP7yNGHNfEdkNRDLktO/9CxMQPI8
 c9IS8tEpEK1IXP2muTj96DJ/e1y5mG7/sz+0nvVCY33/CKAKE4Ye63qB1pq3dCUSdevV vQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4q00tkg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 05:53:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418512a0008758;
	Thu, 8 Feb 2024 05:53:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206ytp0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 05:53:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4185rC8O3015548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 05:53:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABBA35805D;
	Thu,  8 Feb 2024 05:53:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C0758052;
	Thu,  8 Feb 2024 05:53:09 +0000 (GMT)
Received: from [9.43.110.69] (unknown [9.43.110.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 05:53:08 +0000 (GMT)
Message-ID: <82a4d9a0-06c9-4152-9845-a261238b2833@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2024 11:23:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [revert commit 83b3836bf83f09beea5f592b126cfdd1bc921e48]
 [mainline] [6.8.0-rc3]kernel BUG at
 arch/powerpc/platforms/pseries/iommu.c:100!
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
To: iommu@lists.linux.dev, jgg@nvidia.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: sbhat@linux.ibm.com, robin.murphy@arm.com, will@kernel.org,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com,
        abdhalee@linux.vnet.ibm.com, tasmiya@linux.vnet.ibm.com
References: <8d75ebd3-85c2-4a05-8eca-08f66f9411dc@linux.vnet.ibm.com>
 <274e0d2b-b5cc-475e-94e6-8427e88e271d@linux.vnet.ibm.com>
Content-Language: en-GB
In-Reply-To: <274e0d2b-b5cc-475e-94e6-8427e88e271d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5EBQxb3T7Ykl6x1FpawtU1Z1YiEs3K2t
X-Proofpoint-GUID: 5EBQxb3T7Ykl6x1FpawtU1Z1YiEs3K2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 mlxlogscore=687 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080028

Adding more people

On 08/02/24 8:26 am, Venkat Rao Bagalkote wrote:
>
> Resending as earlier one bounced.
>
> Greetings!!!
>
>
> [revert commit 83b3836bf83f09beea5f592b126cfdd1bc921e48] [mainline] 
> [6.8.0-rc3]kernel BUG at arch/powerpc/platforms/pseries/iommu.c:100!
>
>
> By Reverting below commit id, issue is not seen.
>
>
> 83b3836bf83f09beea5f592b126cfdd1bc921e48
>      iommu: Allow ops->default_domain to work when !CONFIG_IOMMU_DMA
>
>
> --- Traces ---
>
> KernelBug: Kernel bug in state 'None': kernel BUG at 
> arch/powerpc/platforms/pseries/iommu.c:100!
> [ 7843.148980] Oops: Exception in kernel mode, sig: 5 [#1]
> [ 7843.148984] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
> [ 7843.148988] Modules linked in: nft_compat nf_tables libcrc32c 
> nfnetlink bridge stp llc tls sit tunnel4 ip_tunnel nvram rpadlpar_io 
> rpaphp xsk_diag rfkill binfmt_misc mlx5_ib ib_uverbs ib_core 
> pseries_rng drm drm_panel_orientation_quirks ext4 mbcache jbd2 
> dm_service_time sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft 
> crc64 sg ibmvfc scsi_transport_fc ibmveth mlx5_core mlxfw vmx_crypto 
> psample dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse [last 
> unloaded: tls]
> [ 7843.149041] CPU: 17 PID: 218444 Comm: drmgr Kdump: loaded Tainted: 
> G          I        6.8.0-rc3-autotest-g99bd3cb0d12e #1
> [ 7843.149047] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 
> 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
> [ 7843.149051] NIP:  c0000000000ff4d4 LR: c0000000000ff4cc CTR: 
> 0000000000000000
> [ 7843.149055] REGS: c0000013aed5f840 TRAP: 0700   Tainted: G          
> I         (6.8.0-rc3-autotest-g99bd3cb0d12e)
> [ 7843.149060] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 44002402  XER: 20040000
> [ 7843.149069] CFAR: c000000000a0d170 IRQMASK: 0
> [ 7843.149069] GPR00: c0000000000ff4cc c0000013aed5fae0 
> c000000001512700 c0000013aa362138
> [ 7843.149069] GPR04: 0000000000000000 0000000000000000 
> 0000000000000000 0000000119c8afd0
> [ 7843.149069] GPR08: 0000000000000000 c000001284442b00 
> 0000000000000001 0000000000001003
> [ 7843.149069] GPR12: 0000000300000000 c0000018ffff2f00 
> 0000000000000000 0000000000000000
> [ 7843.149069] GPR16: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [ 7843.149069] GPR20: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [ 7843.149069] GPR24: c0000013aed5fc40 0000000000000002 
> 0000000000000000 c000000002757d90
> [ 7843.149069] GPR28: c0000000000ff440 c000000002757cb8 
> c00000183799c1a0 c0000013aa362b00
> [ 7843.149112] NIP [c0000000000ff4d4] iommu_reconfig_notifier+0x94/0x200
> [ 7843.149123] LR [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200
> [ 7843.149129] Call Trace:
> [ 7843.149131] [c0000013aed5fae0] [c0000000000ff4cc] 
> iommu_reconfig_notifier+0x8c/0x200 (unreliable)
> [ 7843.149138] [c0000013aed5fb10] [c0000000001a27b0] 
> notifier_call_chain+0xb8/0x19c
> [ 7843.149146] [c0000013aed5fb70] [c0000000001a2a78] 
> blocking_notifier_call_chain+0x64/0x98
> [ 7843.149152] [c0000013aed5fbb0] [c000000000c4a898] 
> of_reconfig_notify+0x44/0xdc
> [ 7843.149160] [c0000013aed5fc20] [c000000000c4add4] 
> of_detach_node+0x78/0xb0
> [ 7843.149165] [c0000013aed5fc70] [c0000000000f96a8] 
> ofdt_write.part.0+0x86c/0xbb8
> [ 7843.149171] [c0000013aed5fce0] [c00000000069b4bc] 
> proc_reg_write+0xf4/0x150
> [ 7843.149178] [c0000013aed5fd10] [c0000000005bfeb4] vfs_write+0xf8/0x488
> [ 7843.149184] [c0000013aed5fdc0] [c0000000005c0570] 
> ksys_write+0x84/0x140
> [ 7843.149189] [c0000013aed5fe10] [c000000000033358] 
> system_call_exception+0x138/0x330
> [ 7843.149196] [c0000013aed5fe50] [c00000000000d05c] 
> system_call_vectored_common+0x15c/0x2ec
> [ 7843.149203] --- interrupt: 3000 at 0x20000433acb4
> [ 7843.149208] NIP:  000020000433acb4 LR: 0000000000000000 CTR: 
> 0000000000000000
> [ 7843.149212] REGS: c0000013aed5fe80 TRAP: 3000   Tainted: G          
> I         (6.8.0-rc3-autotest-g99bd3cb0d12e)
> [ 7843.149217] MSR:  800000000280f033 
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42002408  XER: 00000000
> [ 7843.149227] IRQMASK: 0
> [ 7843.149227] GPR00: 0000000000000004 00007fffcde2d2c0 
> 000000013a707f00 0000000000000006
> [ 7843.149227] GPR04: 00007fffcde2d368 0000000000000020 
> 0000000000000000 0000000000000001
> [ 7843.149227] GPR08: 0000000000000020 0000000000000000 
> 0000000000000000 0000000000000000
> [ 7843.149227] GPR12: 0000000000000000 000020000403b1e0 
> 000000013a6df668 0000000000000006
> [ 7843.149227] GPR16: 0000000000000000 0000000000000002 
> 0000000000000004 0000000000000005
> [ 7843.149227] GPR20: 000000013a700018 000000013a6df360 
> 000000013a6dcb20 000000013a6dd918
> [ 7843.149227] GPR24: 000000013a6db178 00000001722028c8 
> 00007fffcde2d7f8 00000001722028c8
> [ 7843.149227] GPR28: 000000013a6dc340 00007fffcde2d368 
> 0000000000000006 0000000000000020
> [ 7843.149268] NIP [000020000433acb4] 0x20000433acb4
> [ 7843.149271] LR [0000000000000000] 0x0
> [ 7843.149274] --- interrupt: 3000
> [ 7843.149277] Code: 4082016c 2c3f0000 41820060 ebff0028 2c3f0000 
> 41820054 e87f0018 2c230000 41820014 4890dc75 60000000 e93f0018 
> <0b090000> e87f0020 2c230000 4182000c
> [ 7843.149292] ---[ end trace 0000000000000000 ]---
>
>
> Regards,
>
> Venkat.
>
>
>> Greetings!!!
>>
>>
>> [revert commit 83b3836bf83f09beea5f592b126cfdd1bc921e48] [mainline] 
>> [6.8.0-rc3]kernel BUG at arch/powerpc/platforms/pseries/iommu.c:100!
>>
>>
>> Reverting below commit id issue is not seen.
>>
>> 83b3836bf83f09beea5f592b126cfdd1bc921e48
>>       iommu: Allow ops->default_domain to work when !CONFIG_IOMMU_DMA
>>
>>
>> Traces:
>>
>>
>> KernelBug: Kernel bug in state 'None': kernel BUG at 
>> arch/powerpc/platforms/pseries/iommu.c:100!
>> [ 7843.148980] Oops: Exception in kernel mode, sig: 5 [#1]
>> [ 7843.148984] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
>> [ 7843.148988] Modules linked in: nft_compat nf_tables libcrc32c 
>> nfnetlink bridge stp llc tls sit tunnel4 ip_tunnel nvram rpadlpar_io 
>> rpaphp xsk_diag rfkill binfmt_misc mlx5_ib ib_uverbs ib_core 
>> pseries_rng drm drm_panel_orientation_quirks ext4 mbcache jbd2 
>> dm_service_time sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft 
>> crc64 sg ibmvfc scsi_transport_fc ibmveth mlx5_core mlxfw vmx_crypto 
>> psample dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse 
>> [last unloaded: tls]
>> [ 7843.149041] CPU: 17 PID: 218444 Comm: drmgr Kdump: loaded Tainted: 
>> G          I        6.8.0-rc3-autotest-g99bd3cb0d12e #1
>> [ 7843.149047] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 
>> 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
>> [ 7843.149051] NIP:  c0000000000ff4d4 LR: c0000000000ff4cc CTR: 
>> 0000000000000000
>> [ 7843.149055] REGS: c0000013aed5f840 TRAP: 0700   Tainted: 
>> G          I         (6.8.0-rc3-autotest-g99bd3cb0d12e)
>> [ 7843.149060] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
>> 44002402  XER: 20040000
>> [ 7843.149069] CFAR: c000000000a0d170 IRQMASK: 0
>> [ 7843.149069] GPR00: c0000000000ff4cc c0000013aed5fae0 
>> c000000001512700 c0000013aa362138
>> [ 7843.149069] GPR04: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000119c8afd0
>> [ 7843.149069] GPR08: 0000000000000000 c000001284442b00 
>> 0000000000000001 0000000000001003
>> [ 7843.149069] GPR12: 0000000300000000 c0000018ffff2f00 
>> 0000000000000000 0000000000000000
>> [ 7843.149069] GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [ 7843.149069] GPR20: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [ 7843.149069] GPR24: c0000013aed5fc40 0000000000000002 
>> 0000000000000000 c000000002757d90
>> [ 7843.149069] GPR28: c0000000000ff440 c000000002757cb8 
>> c00000183799c1a0 c0000013aa362b00
>> [ 7843.149112] NIP [c0000000000ff4d4] iommu_reconfig_notifier+0x94/0x200
>> [ 7843.149123] LR [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200
>> [ 7843.149129] Call Trace:
>> [ 7843.149131] [c0000013aed5fae0] [c0000000000ff4cc] 
>> iommu_reconfig_notifier+0x8c/0x200 (unreliable)
>> [ 7843.149138] [c0000013aed5fb10] [c0000000001a27b0] 
>> notifier_call_chain+0xb8/0x19c
>> [ 7843.149146] [c0000013aed5fb70] [c0000000001a2a78] 
>> blocking_notifier_call_chain+0x64/0x98
>> [ 7843.149152] [c0000013aed5fbb0] [c000000000c4a898] 
>> of_reconfig_notify+0x44/0xdc
>> [ 7843.149160] [c0000013aed5fc20] [c000000000c4add4] 
>> of_detach_node+0x78/0xb0
>> [ 7843.149165] [c0000013aed5fc70] [c0000000000f96a8] 
>> ofdt_write.part.0+0x86c/0xbb8
>> [ 7843.149171] [c0000013aed5fce0] [c00000000069b4bc] 
>> proc_reg_write+0xf4/0x150
>> [ 7843.149178] [c0000013aed5fd10] [c0000000005bfeb4] 
>> vfs_write+0xf8/0x488
>> [ 7843.149184] [c0000013aed5fdc0] [c0000000005c0570] 
>> ksys_write+0x84/0x140
>> [ 7843.149189] [c0000013aed5fe10] [c000000000033358] 
>> system_call_exception+0x138/0x330
>> [ 7843.149196] [c0000013aed5fe50] [c00000000000d05c] 
>> system_call_vectored_common+0x15c/0x2ec
>> [ 7843.149203] --- interrupt: 3000 at 0x20000433acb4
>> [ 7843.149208] NIP:  000020000433acb4 LR: 0000000000000000 CTR: 
>> 0000000000000000
>> [ 7843.149212] REGS: c0000013aed5fe80 TRAP: 3000   Tainted: 
>> G          I         (6.8.0-rc3-autotest-g99bd3cb0d12e)
>> [ 7843.149217] MSR:  800000000280f033 
>> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42002408  XER: 00000000
>> [ 7843.149227] IRQMASK: 0
>> [ 7843.149227] GPR00: 0000000000000004 00007fffcde2d2c0 
>> 000000013a707f00 0000000000000006
>> [ 7843.149227] GPR04: 00007fffcde2d368 0000000000000020 
>> 0000000000000000 0000000000000001
>> [ 7843.149227] GPR08: 0000000000000020 0000000000000000 
>> 0000000000000000 0000000000000000
>> [ 7843.149227] GPR12: 0000000000000000 000020000403b1e0 
>> 000000013a6df668 0000000000000006
>> [ 7843.149227] GPR16: 0000000000000000 0000000000000002 
>> 0000000000000004 0000000000000005
>> [ 7843.149227] GPR20: 000000013a700018 000000013a6df360 
>> 000000013a6dcb20 000000013a6dd918
>> [ 7843.149227] GPR24: 000000013a6db178 00000001722028c8 
>> 00007fffcde2d7f8 00000001722028c8
>> [ 7843.149227] GPR28: 000000013a6dc340 00007fffcde2d368 
>> 0000000000000006 0000000000000020
>> [ 7843.149268] NIP [000020000433acb4] 0x20000433acb4
>> [ 7843.149271] LR [0000000000000000] 0x0
>> [ 7843.149274] --- interrupt: 3000
>> [ 7843.149277] Code: 4082016c 2c3f0000 41820060 ebff0028 2c3f0000 
>> 41820054 e87f0018 2c230000 41820014 4890dc75 60000000 e93f0018 
>> <0b090000> e87f0020 2c230000 4182000c
>> [ 7843.149292] ---[ end trace 0000000000000000 ]---
>>
>>
>> Regards,
>> Venkat.

