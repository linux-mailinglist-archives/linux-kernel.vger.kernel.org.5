Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111880BE8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 01:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjLKAn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKAnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:43:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5AEED;
        Sun, 10 Dec 2023 16:43:29 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB0KKje010068;
        Mon, 11 Dec 2023 00:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=Xzj/NHvQXcCSxHUwz42Etm4xaK61LGaL2RBV6KfCj6k=; b=Zg
        McstPwqfuZWIuPbEP0F0UpBPydPxv4lKlDBsTtAbK2crjtLNp5JVRLoCLSPF9edT
        z/IPTLt2GZDsYGNtSEMrhNTNfewQJQIzpGgBTb7WMZNwPGaxkXV/f135Azc72Mi7
        1ebV4/MRhlRusn5dNfE6QPHmSAlIwfunK+D0r67Cj58wc9WX+wwhE/YKspGva7Hu
        e8rhaDhkg+vH4SUXRq8Ib6wcKSLw01c5si50z4tqHgD0JCJYwXApGrQT8n+O2yXx
        bqjkhJsVJJlZuW5JVsB2HlpgweQ0Tt/5A37kbvPNbPZ8RLcQ7zH3tqi4Brt9Y7/N
        MFRNI/AhYFFjXEY14Dzg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnyv9w43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 00:42:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB0gGbN001924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 00:42:16 GMT
Received: from [10.110.42.222] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Dec
 2023 16:42:12 -0800
Message-ID: <958182a4-0b42-4e3c-8f14-317cb6a8ac48@quicinc.com>
Date:   Sun, 10 Dec 2023 16:42:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] Dynamic allocation of reserved_mem array.
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <frowand.list@gmail.com>, <dinguyen@kernel.org>,
        <chenhuacai@kernel.org>, <tsbogend@alpha.franken.de>,
        <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <mpe@ellerman.id.au>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20231204185409.19615-1-quic_obabatun@quicinc.com>
 <20231206213543.GB3345785-robh@kernel.org>
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20231206213543.GB3345785-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XlvcT7eWi0OYgyQM10nxEctNG63zTJ9W
X-Proofpoint-ORIG-GUID: XlvcT7eWi0OYgyQM10nxEctNG63zTJ9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/2023 1:35 PM, Rob Herring wrote:
> On Mon, Dec 04, 2023 at 10:54:03AM -0800, Oreoluwa Babatunde wrote:
>> The reserved_mem array is used to store the data of the different
>> reserved memory regions specified in the DT of a device.
>> The array stores information such as the name, node, starting address,
>> and size of a reserved memory region.
>>
>> The array is currently statically allocated with a size of
>> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
>> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
>> will not have enough space to store the information for all the regions.
>>
>> Therefore, this series extends the use of a static array for
>> reserved_mem, and introduces a dynamically allocated array using
>> memblock_alloc() based on the number of reserved memory regions
>> specified in the DT.
>>
>> Memory gotten from memblock_alloc() is only writable after paging_init()
>> is called, but the reserved memory regions need to be reserved before
>> then so that the system does not create page table mappings for them.
>>
>> Reserved memory regions can be divided into 2 groups.
>> i) Statically-placed reserved memory regions
>> i.e. regions defined in the DT using the @reg property.
>> ii) Dynamically-placed reserved memory regions.
>> i.e. regions specified in the DT using the @alloc_ranges
>>     and @size properties.
>>
>> It is possible to call memblock_reserve() and memblock_mark_nomap() on
>> the statically-placed reserved memory regions and not need to save them
>> to the array until after paging_init(), but this is not possible for the
>> dynamically-placed reserved memory because the starting address of these
>> regions need to be stored somewhere after they are allocated.
>>
>> Therefore, this series achieves the allocation and population of the
>> reserved_mem array in two steps:
>>
>> 1. Before paging_init()
>>    Before paging_init() is called, iterate through the reserved_mem
>>    nodes in the DT and do the following:
>>    - Allocate memory for dynamically-placed reserved memory regions and
>>      store their starting address in the static allocated reserved_mem
>>      array.
>>    - Call memblock_reserve() and memblock_mark_nomap() on all the
>>      reserved memory regions as needed.
>>    - Count the total number of reserved_mem nodes in the DT.
>>
>> 2. After paging_init()
>>    After paging_init() is called:
>>    - Allocate new memory for the reserved_mem array based on the number
>>      of reserved memory nodes in the DT.
>>    - Transfer all the information that was stored in the static array
>>      into the new array.
>>    - Store the rest of the reserved_mem regions in the new array.
>>      i.e. the statically-placed regions.
>>
>> The static array is no longer needed after this point, but there is
>> currently no obvious way to free the memory. Therefore, the size of the
>> initial static array is now defined using a config option.
> A config option is not going to work here.
>
>> Because the array is used only before paging_init() to store the
>> dynamically-placed reserved memory regions, the required size can vary
>> from device to device. Therefore, scaling it can help get some memory
>> savings.
>>
>> A possible solution to freeing the memory for the static array will be
>> to mark it as __initdata. This will automatically free the memory once
>> the init process is done running.
>> The reason why this is not pursued in this series is because of
>> the possibility of a use-after-free.
>> If the dynamic allocation of the reserved_mem array fails, then future
>> accesses of the reserved_mem array will still be referencing the static
>> array. When the init process ends and the memory is freed up, any
>> further attempts to use the reserved_mem array will result in a
>> use-after-free.
> If memory allocation for the reserved_mem array fails so early in boot, 
> you've got much bigger problems. Use __initdata, and just WARN if 
> allocation fails and continue on (so hopefully the console is brought 
> up and someone can see the WARN).
>
> Rob

Thanks for pointing that out! I'll move forward with implementing the use
of __initdata to delete the static array.

Regards,
Oreoluwa

