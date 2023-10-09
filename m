Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8661E7BDB9E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376378AbjJIMWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346676AbjJIMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:21:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3281A10D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:21:29 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399BKFoG029814;
        Mon, 9 Oct 2023 12:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=frEGUpCbOiJtTjmeme1Pg7GzkJZnwz54U17kH22WhhI=;
 b=pfl/n9AE9bFb2NZ1eV5XXU2mf1BDJAIWMFEg5rXqTdxvrRQ3YSJY5+jHhpPrmHct69h5
 mb0hT4Hr2AyYOJxBkruH0HztZxFZ0kj/lT3/xV+cmRjqdIsT0LaRZPw01VV5eWplaTSp
 t4Dt3nA9idD4uZx3cqPOAoJkWKBeE02dGnAxZazgGjr5Y9sOql/l+LRG8Zsy2Ed8s6/g
 HiuM/6oKT5aRZr7qyd80KVoYQQfK6XMdS9CXFrghdXCuKKlwQmERUH+WoVtTy4KOrbeF
 eR9faKVXwNblYPJvSI+GcK/zweMxCDnv2N7JarKQYAxMGjlxM18JuzJofIZsR/kE1PZy PQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh5e2e1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 12:21:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399CL8ga010365
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 12:21:08 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 05:21:05 -0700
Message-ID: <25f271b5-5cfb-b300-cc1a-764e21e630d5@quicinc.com>
Date:   Mon, 9 Oct 2023 20:21:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v3] binder: add mutex_lock for mmap and NULL when free
Content-Language: en-US
To:     Carlos Llamas <cmllamas@google.com>
CC:     <gregkh@google.com>, <gregkh@linuxfoundation.org>,
        <surenb@google.com>, <arve@android.com>, <joel@joelfernandes.org>,
        <brauner@kernel.org>, <tkjos@android.com>, <maco@android.com>,
        <linux-kernel@vger.kernel.org>, Sherry Yang <sherryy@android.com>
References: <20231007122813.84282-1-quic_yingangl@quicinc.com>
 <ZSHmtLqtNZRAtaZ0@google.com>
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <ZSHmtLqtNZRAtaZ0@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tGQYyF3HyKMRv-60-a1IxqU7a4QofMvz
X-Proofpoint-ORIG-GUID: tGQYyF3HyKMRv-60-a1IxqU7a4QofMvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090101
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/8 7:16, Carlos Llamas wrote:
> On Sat, Oct 07, 2023 at 08:28:13PM +0800, Kassey Li wrote:
>> - Enforce alloc->mutex in binder_alloc_mmap_handler when add the entry to
>>    list.
>>
>> - Assign the freed pages/page_ptr to NULL to catch possible use after free
>>    with NULL pointer access.
>>
>> Fixes: 19c987241ca1 ("binder: separate out binder_alloc functions")
>> Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")
>> CC: Todd Kjos <tkjos@android.com>
>> CC: Sherry Yang <sherryy@android.com>
>> Link: https://lore.kernel.org/all/20231007034046.2352124-1-quic_yingangl@quicinc.com/
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>> V1 -> V2: Add Fixes info.
>> V2 -> V3: Add this history.
>> ---
>>   drivers/android/binder_alloc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
>> index e3db8297095a..c7d126e04343 100644
>> --- a/drivers/android/binder_alloc.c
>> +++ b/drivers/android/binder_alloc.c
>> @@ -775,6 +775,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>>   	}
>>   
>>   	buffer->user_data = alloc->buffer;
>> +	mutex_lock(&alloc->mutex);
> 
> At this stage we are already holding the mm->mmap_lock. If you take the
> alloc->mutex here you will deadlock. You should see this warning with
> lockdep enabled. Also, you don't need the lock here...

   lockdep did not warn, but i agree with you, i did not aware the 
mm->mmap_lock. thanks for the remind.
> 
>>   	list_add(&buffer->entry, &alloc->buffers);
>>   	buffer->free = 1;
>>   	binder_insert_free_buffer(alloc, buffer);
>> @@ -782,7 +783,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>>   
>>   	/* Signal binder_alloc is fully initialized */
>>   	binder_alloc_set_vma(alloc, vma);
> 
> This barrier will set the alloc->vma pointer. Once set, it signals that
> the alloc-> space has been initialized and it is safe to access.
> 
>> -
>> +	mutex_unlock(&alloc->mutex);
>>   	return 0;
>>   
>>   err_alloc_buf_struct_failed:
>> @@ -856,9 +857,11 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>>   				     __func__, alloc->pid, i, page_addr,
>>   				     on_lru ? "on lru" : "active");
>>   			__free_page(alloc->pages[i].page_ptr);
>> +			alloc->pages[i].page_ptr = NULL;
>>   			page_count++;
>>   		}
>>   		kfree(alloc->pages);
>> +		alloc->pages = NULL;
> 
> The process is dying and there aren't any more references to it. It is
> pointless to mark the pages NULL. No one is or will use them after.

   looks correct.
> 
>>   	}
>>   	mutex_unlock(&alloc->mutex);
>>   	if (alloc->mm)
>> -- 
>> 2.25.1
>>
> 
> I see that you reported a crash on the previous thread here:
> https://lore.kernel.org/all/26988068-8c9f-8591-db6e-44c8105af638@quicinc.com/
> ...unfortunately, it doesn't seem to me like setting alloc->pages = NULL
> would help fix your issue.
> 
> I do agree this sounds like a use-after-free though. Are you able to
> reproduce the issue with KASAN enabled? This should tell us where the
> actual problem is.

   kasan is trying but not reproduced yet,  we will chasing with this 
test enable kasan.
> 
> --
> Carlos Llamas
