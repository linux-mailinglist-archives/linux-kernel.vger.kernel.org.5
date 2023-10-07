Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7D7BC6FF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbjJGLH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbjJGLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:07:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FD583
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 04:07:52 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397AwKcL009630;
        Sat, 7 Oct 2023 11:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PvEm4ahhxZ/O66RJV2KwGTIHqJl9MAamDxZlvuMyCmU=;
 b=kvVNOIae6wuLZrua9FEjg1ZSG0qZjcxQ3a4fxrc/wSchLBOQ2di9aCabHfTWmXHhs7K5
 +uZ7Da2pF8puANdsiVN7n/w0VbLVOA5lAoPBCtQOu5apSmVA94yZ0Em0FRQ1Fe34ZboQ
 yflkOd3qwowWS9qjGEnHhpwDykswSF25vHGsJ/NwtxJWjXv+bZD0F1RwMw1N7H6odMkq
 UVomKiMqGJVrlmqEg3E3nxC9GXW0WMjzIY4OI/AeWEvbwCrbWPqu/Yt4sKgrTnEip2/y
 Qsi6RSevKCxFPJBtr38v87L0ugu+yvdJFhECdMbtYO5AxdBukGw8WABNAfkoVDdSW3rU cQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjxnqrraa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 11:07:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 397B7jtF024725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 11:07:45 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 7 Oct
 2023 04:07:42 -0700
Message-ID: <26988068-8c9f-8591-db6e-44c8105af638@quicinc.com>
Date:   Sat, 7 Oct 2023 19:07:40 +0800
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
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <2023100715-blade-valiant-714d@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i6891KNSqvLvcvJLkhU0LewGJ7ja7izV
X-Proofpoint-GUID: i6891KNSqvLvcvJLkhU0LewGJ7ja7izV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_08,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=693
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070099
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/7 14:44, Greg KH wrote:
> On Sat, Oct 07, 2023 at 11:40:46AM +0800, Kassey Li wrote:
>> Enforce alloc->mutex in binder_alloc_mmap_handler when add
>> the entry to list.
>>
>> Assign the freed pages/page_ptr to NULL to catch possible
>> use after free with NULL pointer access.
>>
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>>   drivers/android/binder_alloc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> What commit id does this fix?

   there is no specific commit id this change going to fix.

   it is a follow up for commit
	19c987241ca1216a51118b2bd0185b8bc5081783  binder: separate out 
binder_alloc functions (mutex lock added for list access in alloc/free)
	f2517eb76f1f2f7f89761f9db2b202e89931738c  android: binder: Add global 
lru shrinker to binder (set page->page_ptr = NULL;)

   the background to raise this change that we are easy hit below crash 
in monkey test:

where a wrong end is passing to
binder_update_page_range, thus calculate a weird index
for
   page = &alloc->pages[index]

then causing the crash:

Unable to handle kernel paging request at virtual address 01ffff8724ade180


here this change will make sure the list access with mutex locked, and 
freed pointer to NULL to easy the debug for such kind of issues.

pc : list_lru_add+0x30/0x11c
lr : list_lru_add+0x30/0x11c
sp : ffffffc0374bb9c0
x29: ffffffc0374bb9c0 x28: ffffff890dc82000 x27: ffffff89df890000
x26: ffffffdf957a86f8 x25: 000ffffff0b72e0c x24: ffffffdf965a4208
x23: ffffffdf95585008 x22: ffffff89d6170000 x21: ffffffdf965a4208
x20: 01ffff8724ade180 x19: ffffff8022340580 x18: ffffffdf957bae60
x17: 00000000529c6ef0 x16: 00000000529c6ef0 x15: 00000000226956ae
x14: 00000000e8903d35 x13: 00000000ebb92cf6 x12: ffffff89df890b50
x11: 00000000000000e0 x10: 0000000000000000 x9 : 0000000000000080
x8 : 00000000000000c0 x7 : 0000000000000000 x6 : ffffffdf93764970
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffffffdf94717c05 x0 : 0000000000000005
Call trace:
list_lru_add+0x30/0x11c
binder_update_page_range+0x154/0x994
binder_free_buf_locked+0x120/0x214
binder_alloc_free_buf+0xf4/0x118
binder_free_buf+0x284/0x390
binder_ioctl_write_read+0x1050/0x2d50
binder_ioctl+0x4f0/0x21c0
__arm64_sys_ioctl+0xa8/0xe4
invoke_syscall+0x58/0x114
el0_svc_common+0x94/0x118
do_el0_svc+0x2c/0xb8
el0_svc+0x30/0xb0
el0t_64_sync_handler+0x68/0xb4
el0t_64_sync+0x1a0/0x1a4

crash> list 0xFFFFFF890D063800 -s binder_buffer  -x
ffffff890d063800
struct binder_buffer {
   entry = {
     next = 0xffffff8a6c0fde00,
     prev = 0xffffff88e2e56ab0
   },
   rb_node = {
     __rb_parent_color = 0xffffff895461a811,
     rb_right = 0x0,
     rb_left = 0x0
   },
   free = 0x0,
   clear_on_free = 0x0,
   allow_user_free = 0x0,
   async_transaction = 0x0,
   oneway_spam_suspect = 0x0,
   debug_id = 0x5d16463,
   transaction = 0x0,
   target_node = 0xffffff898724b000,
   data_size = 0x68,
   offsets_size = 0x8,
   extra_buffers_size = 0x0,
   user_data = 0x7e63364000,
   pid = 0x4950
}
ffffff8a6c0fde00
struct binder_buffer {
   entry = {
     next = 0xffffff895461a800,
     prev = 0xffffff890d063800
   },
   rb_node = {
     __rb_parent_color = 0xffffff895461a811,
     rb_right = 0x0,
     rb_left = 0xffffff89ebbcd610
   },
   free = 0x0,
   clear_on_free = 0x0,
   allow_user_free = 0x0,
   async_transaction = 0x0,
   oneway_spam_suspect = 0x0,
   debug_id = 0x5d16467,
   transaction = 0xffffff8a0435a300,
   target_node = 0xffffff8978905b00,
   data_size = 0x84,
   offsets_size = 0x0,
   extra_buffers_size = 0x0,
   user_data = 0xffffff89d6171a00,   // bad address
   pid = 0x5584
}

> 
> thanks,
> 
> greg k-h
