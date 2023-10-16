Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40557CA9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjJPNjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjJPNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:38:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9C10DB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:38:28 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GBUGb8021402;
        Mon, 16 Oct 2023 13:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4dUZoaXroPnIYe+E5tKQv90XkTcgsEWMUCoq+h51ths=;
 b=jCNGBrfeK2efbqEQ80cDsLzc7GKJv+TrtP0Y3w7dyrUZwwk0hyPQ8NM4ChTrh9T9hNKE
 S7rfW2QLj71I8p56eTjNIihc4x43LRyuFJ0W6xiBQnpADYfpWZaeoLBRzDDdi+3faDFw
 M/W+/CMApoJ38xAFEYYheGn/obFQqOMhv4hVSyWX6NtYeq/SHRFcJR2jkpsiyMpEf5cV
 Zn9b95ez2qeTJfnFlMWUX+GCyhofdpWwqjpLHfDUOdzX04jwMU4M5cOiK4QzEEhH2cOo
 DbfcyKsm1lMGG8U7iMCR9/mzqjaz6RaR0STwAdkz2xy6JDY56AjgG1vuJJgxzdYzjQaB 5g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqk2yv6pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 13:38:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39GDc6DX031568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 13:38:06 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 16 Oct
 2023 06:38:03 -0700
Message-ID: <994410bb-89aa-d987-1f50-f514903c55aa@quicinc.com>
Date:   Mon, 16 Oct 2023 19:08:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <osalvador@suse.de>, <dan.j.williams@intel.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <20231014152532.5f3dca7838c2567a1a9ca9c6@linux-foundation.org>
 <a46cf10b-d852-c671-ee20-40f39bdbceac@redhat.com>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <a46cf10b-d852-c671-ee20-40f39bdbceac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6PTa4NeRHXIA0iEtJNhQuIt2EdxzNnSz
X-Proofpoint-ORIG-GUID: 6PTa4NeRHXIA0iEtJNhQuIt2EdxzNnSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310160118
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew/David,

On 10/16/2023 1:53 PM, David Hildenbrand wrote:
>>> The below race is observed on a PFN which falls into the device memory
>>> region with the system memory configuration where PFN's are such that
>>> [ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL]. Since normal zone start and
>>> end pfn contains the device memory PFN's as well, the compaction
>>> triggered will try on the device memory PFN's too though they end up in
>>> NOP(because pfn_to_online_page() returns NULL for ZONE_DEVICE memory
>>> sections). When from other core, the section mappings are being removed
>>> for the ZONE_DEVICE region, that the PFN in question belongs to,
>>> on which compaction is currently being operated is resulting into the
>>> kernel crash with CONFIG_SPASEMEM_VMEMAP enabled.
>>
>> Seems this bug is four years old, yes?  It must be quite hard to hit.
> 
> From the description, it's not quite clear to me if this was actually
> hit -- usually people include the dmesg bug/crash info.

On Snapdragon SoC,  with the mentioned memory configuration of PFN's as
[ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL],  we are able to see bunch of
issues daily while testing on a device farm.

I note that from next time on wards will send the demsg bug/crash info
for these type of issues. For this particular issue below is the log.
Though the below log is not directly pointing to the
pfn_section_valid(){ ms->usage;}, when we loaded this dump on T32
lauterbach tool, it is pointing.

[  540.578056] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  540.578068] Mem abort info:
[  540.578070]   ESR = 0x0000000096000005
[  540.578073]   EC = 0x25: DABT (current EL), IL = 32 bits
[  540.578077]   SET = 0, FnV = 0
[  540.578080]   EA = 0, S1PTW = 0
[  540.578082]   FSC = 0x05: level 1 translation fault
[  540.578085] Data abort info:
[  540.578086]   ISV = 0, ISS = 0x00000005
[  540.578088]   CM = 0, WnR = 0
[  540.579431] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS
BTYPE=--)
[  540.579436] pc : __pageblock_pfn_to_page+0x6c/0x14c
[  540.579454] lr : compact_zone+0x994/0x1058
[  540.579460] sp : ffffffc03579b510
[  540.579463] x29: ffffffc03579b510 x28: 0000000000235800 x27:
000000000000000c
[  540.579470] x26: 0000000000235c00 x25: 0000000000000068 x24:
ffffffc03579b640
[  540.579477] x23: 0000000000000001 x22: ffffffc03579b660 x21:
0000000000000000
[  540.579483] x20: 0000000000235bff x19: ffffffdebf7e3940 x18:
ffffffdebf66d140
[  540.579489] x17: 00000000739ba063 x16: 00000000739ba063 x15:
00000000009f4bff
[  540.579495] x14: 0000008000000000 x13: 0000000000000000 x12:
0000000000000001
[  540.579501] x11: 0000000000000000 x10: 0000000000000000 x9 :
ffffff897d2cd440
[  540.579507] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
ffffffc03579b5b4
[  540.579512] x5 : 0000000000027f25 x4 : ffffffc03579b5b8 x3 :
0000000000000001
[  540.579518] x2 : ffffffdebf7e3940 x1 : 0000000000235c00 x0 :
0000000000235800
[  540.579524] Call trace:
[  540.579527]  __pageblock_pfn_to_page+0x6c/0x14c
[  540.579533]  compact_zone+0x994/0x1058
[  540.579536]  try_to_compact_pages+0x128/0x378
[  540.579540]  __alloc_pages_direct_compact+0x80/0x2b0
[  540.579544]  __alloc_pages_slowpath+0x5c0/0xe10
[  540.579547]  __alloc_pages+0x250/0x2d0
[  540.579550]  __iommu_dma_alloc_noncontiguous+0x13c/0x3fc
[  540.579561]  iommu_dma_alloc+0xa0/0x320
[  540.579565]  dma_alloc_attrs+0xd4/0x108

>>> Fix this issue by the below steps:
>>> a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.
>>> b) RCU protected read side critical section will either return NULL when
>>> SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.
>>> c) Synchronize the rcu on the write side and free the ->usage. No
>>> attempt will be made to access ->usage after this as the
>>> SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.
> 
> 
> This affects any kind of memory hotunplug. When hotunplugging memory we
> will end up calling synchronize_rcu() for each and every memory section,
> which sounds extremely wasteful.
> 
> Can't we find a way to kfree_rcu() that thing and read/write the pointer
> using READ?ONCE?WRITE_ONCE instead?

I am inspired to use the synchronize_rcu() because of [1] where we did
use it in offline_page_ext(). And my limited understanding is that, a
user can trigger the offline operation more often than the unplug operation.

I agree here that there is a scope to use kfree_rcu() unlike in [1]. Let
me check for a way to use it.

[1]
https://lore.kernel.org/all/1661496993-11473-1-git-send-email-quic_charante@quicinc.com/

Thanks,
Charan
