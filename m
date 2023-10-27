Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF007D8F00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbjJ0GzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJ0GzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:55:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030BB8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:55:21 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R6lOhu013344;
        Fri, 27 Oct 2023 06:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dQjM6iS+9STB/Y6kSOp623YYK3M18r5O6RxwVdvVk6s=;
 b=T7XjJzq+WeOhNaYT0Ljq9ixgr7hrCBabnb8LTjSzEMUJTOgSKCGXveJ2volHx/bpD1sz
 wjHymG8kDx94c/+TGmftDz+f2X6IkAnF4Cycvn9fWSpiG69g8q183RMPdzFGPvc/D7w/
 OFURGDFSr7auWa+CKT0mkYmQ/VG5+KK/cYEww0AtIfmsmJmz1h+I8+kMqoJv2z7TjIsL
 vcK9SIce1iX5wd4hoZ3oaeoemJXP/uDg7AlYbL3+DG25bzb7AaTSLuWJGuznSwrRbHbn
 DTVMq/hx6X1rfJmHew/l70l3kkE2eAxvsF7B0RZ0cCYPR7AGKoH0agZhzhJgF20EeiqA Pg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyws99c7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 06:55:15 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39R6tEF7031329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 06:55:14 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 26 Oct
 2023 23:55:09 -0700
Message-ID: <4b79272a-1206-5c71-7ddd-3144d1afa451@quicinc.com>
Date:   Fri, 27 Oct 2023 12:25:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Yu Wang <quic_yyuwang@quicinc.com>, <johannes@sipsolutions.net>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
 <c1add351-f132-60d5-7ed8-cba1061d98b1@quicinc.com>
In-Reply-To: <c1add351-f132-60d5-7ed8-cba1061d98b1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: narq0r8GEXMiibDzfUhQGHR-C0cUpwqw
X-Proofpoint-GUID: narq0r8GEXMiibDzfUhQGHR-C0cUpwqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_04,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270060
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2023 11:53 AM, Mukesh Ojha wrote:
> 
> 
> On 10/27/2023 11:25 AM, Yu Wang wrote:
>> With sample code as below, it may hit use-after-free issue when
>> releasing devcd device.
>>
>>      struct my_coredump_state {
>>          struct completion dump_done;
>>          ...
>>      };
>>
>>      static void my_coredump_free(void *data)
>>      {
>>          struct my_coredump_state *dump_state = data;
>>          ...
>>          complete(&dump_state->dump_done);
>>      }
>>
>>      static void my_dev_release(struct device *dev)
>>      {
>>          kfree(dev);
>>      }
>>
>>      static void my_coredump()
>>      {
>>          struct my_coredump_state dump_state;
>>          struct device *new_device =
>>              kzalloc(sizeof(*new_device), GFP_KERNEL);
>>
>>          ...
>>          new_device->release = my_dev_release;
>>          device_initialize(new_device);
>>          ...
>>          device_add(new_device);
>>          ...
>>          init_completion(&dump_state.dump_done);
>>          dev_coredumpm(new_device, NULL, &dump_state, datalen, 
>> GFP_KERNEL,
>>                        my_coredump_read, my_coredump_free);
>>          wait_for_completion(&dump_state.dump_done);
>>          device_del(new_device);
>>          put_device(new_device);
>>      }
>>
>> In devcoredump framework, devcd_dev_release() will be called when
>> releasing the devcd device, it will call the free() callback first
>> and try to delete the symlink in sysfs directory of the failing device.
>> Eventhough it has checked 'devcd->failing_dev->kobj.sd' before that,
>> there is no mechanism to ensure it's still available when accessing
>> it in kernfs_find_ns(), refer to the diagram as below:
>>
>>      Thread A was waiting for 'dump_state.dump_done' at #A-1-2 after
>>      calling dev_coredumpm().
>>      When thread B calling devcd->free() at #B-2-1, it wakes up
>>      thread A from point #A-1-2, which will call device_del() to
>>      delete the device.
>>      If #B-2-2 comes before #A-3-1, but #B-4 comes after #A-4, it
>>      will hit use-after-free issue when trying to access
>>      'devcd->failing_dev->kobj.sd'.
>>
>>      #A-1-1: dev_coredumpm()
>>        #A-1-2: wait_for_completion(&dump_state.dump_done)
>>        #A-1-3: device_del()
>>          #A-2: kobject_del()
>>            #A-3-1: sysfs_remove_dir() --> set kobj->sd=NULL
>>            #A-3-2: kernfs_put()
>>              #A-4: kmem_cache_free() --> free kobj->sd
>>
>>      #B-1: devcd_dev_release()
>>        #B-2-1: devcd->free(devcd->data)
>>        #B-2-2: check devcd->failing_dev->kobj.sd
>>        #B-2-3: sysfs_delete_link()
>>          #B-3: kernfs_remove_by_name_ns()
>>            #B-4: kernfs_find_ns() --> access devcd->failing_dev->kobj.sd
>>
>> To fix this issue, put operations on devcd->failing_dev before
>> calling the free() callback in devcd_dev_release().
>>
>> Signed-off-by: Yu Wang <quic_yyuwang@quicinc.com>
>> ---
>>   drivers/base/devcoredump.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
>> index 91536ee05f14..35c704ddfeae 100644
>> --- a/drivers/base/devcoredump.c
>> +++ b/drivers/base/devcoredump.c
>> @@ -83,9 +83,6 @@ static void devcd_dev_release(struct device *dev)
>>   {
>>       struct devcd_entry *devcd = dev_to_devcd(dev);
>> -    devcd->free(devcd->data);
>> -    module_put(devcd->owner);
>> -
>>       /*
>>        * this seems racy, but I don't see a notifier or such on
>>        * a struct device to know when it goes away?
> 
> Does this comment became obsolete now ?

I thought about this, looks like this comment could be valid
for dev_coredumpv() case.

-Mukesh
> 
> -Mukesh
> 
>> @@ -95,6 +92,8 @@ static void devcd_dev_release(struct device *dev)
>>                     "devcoredump");
>>       put_device(devcd->failing_dev);
>> +    devcd->free(devcd->data);
>> +    module_put(devcd->owner);
>>       kfree(devcd);
>>   }
