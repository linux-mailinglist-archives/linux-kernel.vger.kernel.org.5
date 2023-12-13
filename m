Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C28113E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjLMN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjLMN7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:59:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B410CB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:57:58 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD4grrj018311;
        Wed, 13 Dec 2023 13:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:from:to:cc:references
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=m0Pizm8nde7nHZnifLV3BkqAkBQzDS7qyrzU6Hm4LtE=; b=Im
        C1Kvph3G4qsTmuTe58fbbDzhU+OLGKSxkB1YtxDzY80gvVggSRx4CwbqHSe9TCOM
        FpmtBejfEb0mZydrDtfAoT/U9uqGOypoAX7/VLnMN6D88YdiWLtOZHb/dsjUGuBY
        P9pgQE7TbAKykDunZ5kaTLEbeKz9RQ82Zzs8S9uIf+ls/OcnV9HsNVJNt+VWB8Jq
        Rq9NA9+NGILrf8r+mm3EsL5w/8CXJFO4URpTYa45gHEJoBN2hHmVhxn6HORIMyS1
        XTY0FkhY51bhVdm6zs8ACGT8NqSFcVFb94BCABx+IkkjRm17ZMhelqpjhNbrLQyL
        k7SsLcC3d2m3RQcTXvow==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy5tvh7qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 13:57:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDDvYGh014667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 13:57:34 GMT
Received: from [10.216.55.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 05:57:31 -0800
Message-ID: <05b4b5ab-a075-e693-7182-2477b40745dd@quicinc.com>
Date:   Wed, 13 Dec 2023 19:27:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] [RFC] mm: migrate: rcu stalls because of invalid swap
 cache entries
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <hannes@cmpxchg.org>, <kirill.shutemov@linux.intel.com>,
        <shakeelb@google.com>, <n-horiguchi@ah.jp.nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1700569840-17327-1-git-send-email-quic_charante@quicinc.com>
 <ZVzXLu4Ds+3aQtGm@casper.infradead.org>
 <51f727a2-75e9-d42f-bae6-d3e4c3328af1@quicinc.com>
In-Reply-To: <51f727a2-75e9-d42f-bae6-d3e4c3328af1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6epGjchljk1wYzS80vb1f4JE1uhRYoii
X-Proofpoint-GUID: 6epGjchljk1wYzS80vb1f4JE1uhRYoii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=635 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130101
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Matthew, Just a ping to have your valuable opinion here.

Thanks,
Charan

On 11/23/2023 7:55 PM, Charan Teja Kalla wrote:
>> What would you think to this?  I think a better fix would be to
>> fix the swap cache to user multi-order entries, but I would like to
>> see this backportable!
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index d9d2b9432e81..2d67ca47d2e2 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -405,6 +405,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>>  	int dirty;
>>  	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
>>  	long nr = folio_nr_pages(folio);
>> +	long entries, i;
>>  
>>  	if (!mapping) {
>>  		/* Anonymous page without mapping */
>> @@ -442,8 +443,10 @@ int folio_migrate_mapping(struct address_space *mapping,
>>  			folio_set_swapcache(newfolio);
>>  			newfolio->private = folio_get_private(folio);
>>  		}
>> +		entries = nr;
>>  	} else {
>>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>> +		entries = 1;
>>  	}
>>  
>>  	/* Move dirty while page refs frozen and newpage not yet exposed */
>> @@ -453,7 +456,11 @@ int folio_migrate_mapping(struct address_space *mapping,
>>  		folio_set_dirty(newfolio);
>>  	}
>>  
>> -	xas_store(&xas, newfolio);
>> +	/* Swap cache still stores N entries instead of a high-order entry */
>> +	for (i = 0; i < entries; i++) {
>> +		xas_store(&xas, newfolio);
>> +		xas_next(&xas);
>> +	}
>>  
>>  	/*
>>  	 * Drop cache reference from old page by unfreezing
> Seems a cleaner one to store N entries. Supporting swap cache for multi
> order entries might be time consuming. Till then, can we use this patch
> as the solution, with the proper commit log conveying revert of this
> patch when swap cache supported with Multi-order indices?
> 
> Please Lmk, If I can raise this patch with suggested-by:you 
