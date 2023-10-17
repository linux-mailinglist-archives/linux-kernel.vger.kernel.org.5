Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C5E7CC5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJQOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjJQOPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:15:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FDF115
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:15:38 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HCGXUB013219;
        Tue, 17 Oct 2023 14:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TyhjTT4pB9EO0fyvzA/m54aikNSBRWtwo+TTKftWgmM=;
 b=SonJUsEH/X3RrorQwkBvjODhg9ojLsugwJhQ4rnzJD6mmW7vkNqvxER51yzm8PRLJ/7a
 KEXF7VrjZZ4S9yC5kv0w5TdMK/1YjQlBFcZwfYI9uJZ961INzlBTVzG6mx19CnwRgfgm
 gKZFN7g9EAqmJ/nBDzei3wQSAs2kaKEMycCfA20NmJA34MjDE4taDbgy+jR5dG6yaHCs
 1QiDpcVTCFUWYyEoHsYrlDoKNzEmu7ef3prCoLpgvNzczsw2nYujrIbFiJXiVSwhAQgH
 eeApFkegmmdwIYFbAMjFhoBQQlaSJXhAeyo3gc8LZBO+8ap3rmFkcAQZkW3IhKy2/bqn aw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsb7xj1an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 14:10:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HEAMBc026920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 14:10:22 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 07:10:19 -0700
Message-ID: <b4a2bbe8-4181-68ad-1a6c-463fbe64d8f8@quicinc.com>
Date:   Tue, 17 Oct 2023 19:40:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <akpm@linux-foundation.org>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <e1102c1b-1773-4e59-8a70-00a7deff2bde@quicinc.com>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <e1102c1b-1773-4e59-8a70-00a7deff2bde@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 81IvLGkGtB1TAHFuIo4t5iTuYB6uf3sl
X-Proofpoint-GUID: 81IvLGkGtB1TAHFuIo4t5iTuYB6uf3sl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=561 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170119
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pavan!!

On 10/16/2023 4:03 PM, Pavan Kondeti wrote:
>> Fix this issue by the below steps:
>> a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.
>> b) RCU protected read side critical section will either return NULL when
>> SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.
>> c) Synchronize the rcu on the write side and free the ->usage. No
>> attempt will be made to access ->usage after this as the
>> SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.
>>
>> Since the section_deactivate() is a rare operation and will come in the
>> hot remove path, impact of synchronize_rcu() should be negligble.
> struct mem_section_usage has other field like pageblock_flags. Do we
> need to protect its readers with RCU? Also can we annotate usage field
> in struct mem_section with __rcu and use RCU accessors like
> rcu_dereference() while using memsection::usage field?

Good question about the pageblock_flags!! I think we rely on the
get_pageblock_bitmap() to read the ms->usage->pageblock_flags by passing
struct page*.

1) All the functions that I have come across calling
get_pageblock_bitmap()/get_pfnblock_flags_mask() passing the page* which
it get from buddy. I think we are safe here as the device pages(from
which the problem is coming will never be onlined/added to buddy)

2) There are functions in compaction which directly operate on the pfn's
through pfn_to_online_page(). As for device pages, it is going to return
NULL, I think we are safe here too.

3) alloc_contig_range() which also operate on the pfn's directly, and
TMK, we will not pass the [start , end) values of this function to
contains the hole/offlined pages. I think we are safe here too.

May be David/other reviewers can help in commenting if there are some
mistakes above.

I am currently working on to use the __rcu accessors.

> 
>>  		/*
>> +		 * Mark the section invalid so that valid_section()
>> +		 * return false. This prevents code from dereferencing
>> +		 * ms->usage array.
>> +		 */
>> +		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
>> +
> This trick may not be needed if we add proper NULL checks around ms->usage. We are anyway
> introducing a new rule this check needs to be done under RCU lock, so why not revisit it?
> 

I think this is for valid_section().

>>  		 * was allocated during boot.
>>  		 */
>>  		if (!PageReserved(virt_to_page(ms->usage))) {
>> +			synchronize_rcu();
>>  			kfree(ms->usage);
>>  			ms->usage = NULL;
>>  		}
> If we add NULL checks around ms->usage, this becomes
> 
> tmp = rcu_replace_pointer(ms->usage, NULL, hotplug_locked());
> syncrhonize_rcu();
> kfree(tmp);
Per David input, I am working on using kfree_rcu().

Thanks,
Charan
