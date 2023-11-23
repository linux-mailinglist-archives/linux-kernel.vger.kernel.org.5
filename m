Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8F7F6163
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbjKWO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345774AbjKWO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:26:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB6D48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:26:21 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANDKJKm007069;
        Thu, 23 Nov 2023 14:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eI7e/qtvK85QUgdu7R/5LZXsD6RSiqt2MHIZcb984Us=;
 b=TwkumF/T2xgJRYCk2IIpoHRV4UPi8RjzgLuubvaTTlyQ7OcjfXIsiAeiHfQsa3slkqf4
 Y8jT+M5YGIWepy7jkYkwg3C9WBiZNsjwlEe/cWpyQ9pEQ6wx0AsiPhNmz/KfMzMPPk7x
 /s6jvNBINfJpDr2hGvTaUl6IEkfk5e73Slm/+Ovry+hVAsz7nGe1NwKBWsjNPqfWanvO
 mIgswGTqofUguS6nI7nWOBAW6rBGNSGQz2xPFBpr9XCaTiBPji9f0NOkcAUcgmc2DnlM
 FgI85Pdxx7PG3kkZUXvzSImtSdswNaEyp5t3LTysPIEvDvB2pmDfIuQFjoaMgFJYk2b4 ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj7gjr42m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 14:26:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANEQ0ou019604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 14:26:00 GMT
Received: from [10.216.14.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 06:25:57 -0800
Message-ID: <51f727a2-75e9-d42f-bae6-d3e4c3328af1@quicinc.com>
Date:   Thu, 23 Nov 2023 19:55:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] [RFC] mm: migrate: rcu stalls because of invalid swap
 cache entries
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <hannes@cmpxchg.org>, <kirill.shutemov@linux.intel.com>,
        <shakeelb@google.com>, <n-horiguchi@ah.jp.nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1700569840-17327-1-git-send-email-quic_charante@quicinc.com>
 <ZVzXLu4Ds+3aQtGm@casper.infradead.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <ZVzXLu4Ds+3aQtGm@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pTPt2ZsBmQkSjL-uVcWxJGfzqrWUO1-G
X-Proofpoint-GUID: pTPt2ZsBmQkSjL-uVcWxJGfzqrWUO1-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=545 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230104
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Matthew!

On 11/21/2023 9:43 PM, Matthew Wilcox wrote:
> What would you think to this?  I think a better fix would be to
> fix the swap cache to user multi-order entries, but I would like to
> see this backportable!
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d9d2b9432e81..2d67ca47d2e2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -405,6 +405,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>  	int dirty;
>  	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
>  	long nr = folio_nr_pages(folio);
> +	long entries, i;
>  
>  	if (!mapping) {
>  		/* Anonymous page without mapping */
> @@ -442,8 +443,10 @@ int folio_migrate_mapping(struct address_space *mapping,
>  			folio_set_swapcache(newfolio);
>  			newfolio->private = folio_get_private(folio);
>  		}
> +		entries = nr;
>  	} else {
>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
> +		entries = 1;
>  	}
>  
>  	/* Move dirty while page refs frozen and newpage not yet exposed */
> @@ -453,7 +456,11 @@ int folio_migrate_mapping(struct address_space *mapping,
>  		folio_set_dirty(newfolio);
>  	}
>  
> -	xas_store(&xas, newfolio);
> +	/* Swap cache still stores N entries instead of a high-order entry */
> +	for (i = 0; i < entries; i++) {
> +		xas_store(&xas, newfolio);
> +		xas_next(&xas);
> +	}
>  
>  	/*
>  	 * Drop cache reference from old page by unfreezing
Seems a cleaner one to store N entries. Supporting swap cache for multi
order entries might be time consuming. Till then, can we use this patch
as the solution, with the proper commit log conveying revert of this
patch when swap cache supported with Multi-order indices?

Please Lmk, If I can raise this patch with suggested-by:you .

Thanks
Charan

