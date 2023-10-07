Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF917BC741
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbjJGLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343837AbjJGLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:44:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74108B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 04:44:03 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397Bhu12009405;
        Sat, 7 Oct 2023 11:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q6BWe4Lq7MY1NQBuGsJNqri+3KXC6PSmR18VQrasxTM=;
 b=dByDsoFar/u7gP7jRUC4e9O3XQi2PWQFkqS95xCvwOA8/PNs5su4J2T9D8cTVD0TF8mP
 WeMyL+lN9U8Hvjj7rGlMQVXvXHiGnYIgQYblkDW08XqCBUDyMBHuRewW7ATpHLSaOAmN
 ZXtPSwRhDdWbbnvnA0SwXArryUE2u5a74vJaFyeAbOjCJDZGr0oOWJsUSk0F5TAyrjNO
 lqqEMQsEd3AwWcQLKfEp0b/2yCwisZ7oDI0cxemwGGxAt6YGwefu+n2JZzXbqYGObb3J
 2pKhZ5fYWcV+hOylLb2LOm2BkblE0XdPK9qHFJve0Hmi1ESm2yJQCO0CCVx99W4VtRrs hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjxbhrsse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 11:43:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 397BhtWH027023
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 11:43:55 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 7 Oct
 2023 04:43:52 -0700
Message-ID: <a04f2f27-e746-2b28-ec58-66041def9645@quicinc.com>
Date:   Sat, 7 Oct 2023 19:43:50 +0800
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
 <12642deb-0db3-9210-b468-1872cd3d5409@quicinc.com>
 <2023100735-dullness-cameo-2666@gregkh>
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <2023100735-dullness-cameo-2666@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R-0ksveWcJlr13aq86rhpEudyezGF9M9
X-Proofpoint-GUID: R-0ksveWcJlr13aq86rhpEudyezGF9M9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=711
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070104
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/7 19:37, Greg KH wrote:
> On Sat, Oct 07, 2023 at 07:34:05PM +0800, Kassey Li wrote:
>>
>>
>> On 2023/10/7 19:18, Greg KH wrote:
>>> On Sat, Oct 07, 2023 at 07:07:40PM +0800, Kassey Li wrote:
>>>>
>>>>
>>>> On 2023/10/7 14:44, Greg KH wrote:
>>>>> On Sat, Oct 07, 2023 at 11:40:46AM +0800, Kassey Li wrote:
>>>>>> Enforce alloc->mutex in binder_alloc_mmap_handler when add
>>>>>> the entry to list.
>>>>>>
>>>>>> Assign the freed pages/page_ptr to NULL to catch possible
>>>>>> use after free with NULL pointer access.
>>>>>>
>>>>>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>>>>>> ---
>>>>>>     drivers/android/binder_alloc.c | 5 ++++-
>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> What commit id does this fix?
>>>>
>>>>     there is no specific commit id this change going to fix.
>>>>
>>>>     it is a follow up for commit
>>>> 	19c987241ca1216a51118b2bd0185b8bc5081783  binder: separate out binder_alloc
>>>> functions (mutex lock added for list access in alloc/free)
>>>> 	f2517eb76f1f2f7f89761f9db2b202e89931738c  android: binder: Add global lru
>>>> shrinker to binder (set page->page_ptr = NULL;)
>>>>
>>>>     the background to raise this change that we are easy hit below crash in
>>>> monkey test:
>>>>
>>>> where a wrong end is passing to
>>>> binder_update_page_range, thus calculate a weird index
>>>> for
>>>>     page = &alloc->pages[index]
>>>
>>> Obviously it is a fix for some commit, please list that here.
>>
>>   ok, please kindly review this patch description according your suggest, i
>> can re-send v2 patch again.
>>
>> commit 16aaeb8556ff4eb75823c56773ee82b06bac44a0 (HEAD -> master)
>> Author: Kassey Li <quic_yingangl@quicinc.com>
>> Date:   Thu Sep 28 10:42:52 2023 +0800
>>
>>      binder: add mutex_lock for mmap and NULL when free
>>
>>      -Enforce alloc->mutex in binder_alloc_mmap_handler when add
>>      the entry to list.
>>
>>      -Assign the freed pages/page_ptr to NULL to catch possible
>>      use after free with NULL pointer access.
> 
> Odd indentation :(

thanks for the quick suggest and review, based on this version, will do 
below and send patch v2.

./scripts/checkpatch.pl 
0001-binder-add-mutex_lock-for-mmap-and-NULL-when-free.patch
total: 0 errors, 0 warnings, 26 lines checked

0001-binder-add-mutex_lock-for-mmap-and-NULL-when-free.patch has no 
obvious style problems and is ready for submission.

> 
>>      Fixes: 19c987241ca1 ("binder: separate out binder_alloc functions")
>>      Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to
>> binder")
>>      Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> 
> Looks better than before, thanks.
> 
> greg k-h
