Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190B27BC729
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbjJGLec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjJGLea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:34:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352A8BF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 04:34:29 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397BTPRU006713;
        Sat, 7 Oct 2023 11:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=G+by8RcLA+dS9xjWR5WO1qwVXkDdY4wQRTadK1A2YtQ=;
 b=dEVzae/VUoiiQrgG5ROXwrEcSaqUzZK+gyUqI1heJFN5fVF2D/MQZn/ptaajkJBGBVFA
 27WhilrZitRAojdJ1y40VtNfruekbeCjGQ885UQyGjEMKrhQAXbiM6bc1g++YVF0rXZV
 ze0Jkp7nWMRHFRNRhXrEVUvIO9CTpNRkRgQO60ge+UPpKHt7FEp0bxfYJ7cEFWepgJzM
 +yJKtj69XsTcSbuWA+6foRdnQKlxqSvvrgJB092Nip/T3+R+hmtHtAjIuosHuMTWQ2Di
 Blcw6j0mm4SK4xJjwdTDcKxaFpofq7NyuW4gzfRSf9c47eSONz2D2MVISRfV7zM0oJQR cQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tk03q0kkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 11:34:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 397BYAaV006816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 11:34:10 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 7 Oct
 2023 04:34:07 -0700
Message-ID: <12642deb-0db3-9210-b468-1872cd3d5409@quicinc.com>
Date:   Sat, 7 Oct 2023 19:34:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] binder: add mutex_lock for mmap and NULL when free
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <gregkh@google.com>, <cmllamas@google.com>, <surenb@google.com>,
        <arve@android.com>, <joel@joelfernandes.org>, <brauner@kernel.org>,
        <tkjos@android.com>, <maco@android.com>,
        <linux-kernel@vger.kernel.org>
References: <20231007034046.2352124-1-quic_yingangl@quicinc.com>
 <2023100715-blade-valiant-714d@gregkh>
 <26988068-8c9f-8591-db6e-44c8105af638@quicinc.com>
 <2023100725-oversized-shore-c873@gregkh>
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <2023100725-oversized-shore-c873@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oKVpFQwegheiCvwgBYvYCh1lz8k7Ezyb
X-Proofpoint-GUID: oKVpFQwegheiCvwgBYvYCh1lz8k7Ezyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=661
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070103
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/7 19:18, Greg KH wrote:
> On Sat, Oct 07, 2023 at 07:07:40PM +0800, Kassey Li wrote:
>>
>>
>> On 2023/10/7 14:44, Greg KH wrote:
>>> On Sat, Oct 07, 2023 at 11:40:46AM +0800, Kassey Li wrote:
>>>> Enforce alloc->mutex in binder_alloc_mmap_handler when add
>>>> the entry to list.
>>>>
>>>> Assign the freed pages/page_ptr to NULL to catch possible
>>>> use after free with NULL pointer access.
>>>>
>>>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>>>> ---
>>>>    drivers/android/binder_alloc.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> What commit id does this fix?
>>
>>    there is no specific commit id this change going to fix.
>>
>>    it is a follow up for commit
>> 	19c987241ca1216a51118b2bd0185b8bc5081783  binder: separate out binder_alloc
>> functions (mutex lock added for list access in alloc/free)
>> 	f2517eb76f1f2f7f89761f9db2b202e89931738c  android: binder: Add global lru
>> shrinker to binder (set page->page_ptr = NULL;)
>>
>>    the background to raise this change that we are easy hit below crash in
>> monkey test:
>>
>> where a wrong end is passing to
>> binder_update_page_range, thus calculate a weird index
>> for
>>    page = &alloc->pages[index]
> 
> Obviously it is a fix for some commit, please list that here.

  ok, please kindly review this patch description according your 
suggest, i can re-send v2 patch again.

commit 16aaeb8556ff4eb75823c56773ee82b06bac44a0 (HEAD -> master)
Author: Kassey Li <quic_yingangl@quicinc.com>
Date:   Thu Sep 28 10:42:52 2023 +0800

     binder: add mutex_lock for mmap and NULL when free

     -Enforce alloc->mutex in binder_alloc_mmap_handler when add
     the entry to list.

     -Assign the freed pages/page_ptr to NULL to catch possible
     use after free with NULL pointer access.

     Fixes: 19c987241ca1 ("binder: separate out binder_alloc functions")
     Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to 
binder")
     Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>

> 
> thanks,
> 
> greg k-h
