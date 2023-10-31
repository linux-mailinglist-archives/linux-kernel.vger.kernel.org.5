Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB88D7DC9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjJaJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:41:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88CAC2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:41:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V8UK7W013247;
        Tue, 31 Oct 2023 09:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6/Gw3DiYI+Z+VtvYTROcYyEwChcKA6oHVuyV2KHiJS4=;
 b=HVScRkhL7AAyOsgP1Qk6+C6q46SV3ziKPMTghGcDqaWUO/cyTwGzDkcYUswxhH52ZBQS
 eeBRDYT94ZubW23NpCG/a9I383ko5pV5dsI+65IWAEa4jvrGmJQ0S+BPsKRYmPhyVQ65
 q8p+R0IosNEu/4RUT7FCHUXJTtEgFvAw+TCtSgU+81CCssO+aSlpOxzEKpj3YgP6/CX7
 YiFJn4myNAnfMOydERqmi3PhvUPbg7GW1J2BYPT5TYrySdm61V6c2oby6GZYMD19pUs+
 VPId0f85WFgnMmIsBCR2LYdW3RlxJiv57fCwcACYto5aWR/M51Vz0c43vbKIDD86b8vV qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey2e2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 09:41:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V9faKa028870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 09:41:36 GMT
Received: from [10.231.194.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 02:41:32 -0700
Message-ID: <aaec829c-26a3-439a-a83c-96c3fa057752@quicinc.com>
Date:   Tue, 31 Oct 2023 17:41:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <johannes@sipsolutions.net>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
 <2023102757-spree-unruly-dcd6@gregkh>
 <df7d1881-2e8f-43e5-a589-cacfb26138ab@quicinc.com>
 <2023103126-matchless-overview-3558@gregkh>
From:   Yu Wang <quic_yyuwang@quicinc.com>
In-Reply-To: <2023103126-matchless-overview-3558@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HSXL-0Tr4aNjCnq_157m4uywS9D5P7ja
X-Proofpoint-GUID: HSXL-0Tr4aNjCnq_157m4uywS9D5P7ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310310075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2023 3:39 PM, Greg KH wrote:
> On Tue, Oct 31, 2023 at 03:15:12PM +0800, Yu Wang wrote:
>>
>>
>> On 10/27/2023 7:12 PM, Greg KH wrote:
>>> On Thu, Oct 26, 2023 at 10:55:21PM -0700, Yu Wang wrote:
>>>> With sample code as below, it may hit use-after-free issue when
>>>> releasing devcd device.
>>>>
>>>>     struct my_coredump_state {
>>>>         struct completion dump_done;
>>>>         ...
>>>>     };
>>>>
>>>>     static void my_coredump_free(void *data)
>>>>     {
>>>>         struct my_coredump_state *dump_state = data;
>>>>         ...
>>>>         complete(&dump_state->dump_done);
>>>>     }
>>>>
>>>>     static void my_dev_release(struct device *dev)
>>>>     {
>>>>         kfree(dev);
>>>>     }
>>>>
>>>>     static void my_coredump()
>>>>     {
>>>>         struct my_coredump_state dump_state;
>>>>         struct device *new_device =
>>>>             kzalloc(sizeof(*new_device), GFP_KERNEL);
>>>>
>>>>         ...
>>>>         new_device->release = my_dev_release;
>>>>         device_initialize(new_device);
>>>>         ...
>>>>         device_add(new_device);
>>>>         ...
>>>>         init_completion(&dump_state.dump_done);
>>>>         dev_coredumpm(new_device, NULL, &dump_state, datalen, GFP_KERNEL,
>>>>                       my_coredump_read, my_coredump_free);
>>>>         wait_for_completion(&dump_state.dump_done);
>>>>         device_del(new_device);
>>>>         put_device(new_device);
>>>>     }
>>>>
>>>> In devcoredump framework, devcd_dev_release() will be called when
>>>> releasing the devcd device, it will call the free() callback first
>>>> and try to delete the symlink in sysfs directory of the failing device.
>>>> Eventhough it has checked 'devcd->failing_dev->kobj.sd' before that,
>>>> there is no mechanism to ensure it's still available when accessing
>>>> it in kernfs_find_ns(), refer to the diagram as below:
>>>>
>>>>     Thread A was waiting for 'dump_state.dump_done' at #A-1-2 after
>>>>     calling dev_coredumpm().
>>>>     When thread B calling devcd->free() at #B-2-1, it wakes up
>>>>     thread A from point #A-1-2, which will call device_del() to
>>>>     delete the device.
>>>>     If #B-2-2 comes before #A-3-1, but #B-4 comes after #A-4, it
>>>>     will hit use-after-free issue when trying to access
>>>>     'devcd->failing_dev->kobj.sd'.
>>>>
>>>>     #A-1-1: dev_coredumpm()
>>>>       #A-1-2: wait_for_completion(&dump_state.dump_done)
>>>>       #A-1-3: device_del()
>>>>         #A-2: kobject_del()
>>>>           #A-3-1: sysfs_remove_dir() --> set kobj->sd=NULL
>>>>           #A-3-2: kernfs_put()
>>>>             #A-4: kmem_cache_free() --> free kobj->sd
>>>>
>>>>     #B-1: devcd_dev_release()
>>>>       #B-2-1: devcd->free(devcd->data)
>>>>       #B-2-2: check devcd->failing_dev->kobj.sd
>>>>       #B-2-3: sysfs_delete_link()
>>>>         #B-3: kernfs_remove_by_name_ns()
>>>>           #B-4: kernfs_find_ns() --> access devcd->failing_dev->kobj.sd
>>>>
>>>> To fix this issue, put operations on devcd->failing_dev before
>>>> calling the free() callback in devcd_dev_release().
>>>>
>>>> Signed-off-by: Yu Wang <quic_yyuwang@quicinc.com>
>>>> ---
>>>>  drivers/base/devcoredump.c | 5 ++---
>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> Also, what commit id does this fix?
>>
>> Thanks for your comment :)
>> Do you mean the commit which introduced this issue? It's from initial version of devcoredump.c.
> 
> Ok, but then what in-kernel code has the above pattern to cause this
> "problem"?  Why not fix that up?
> 
We use this API as below:
<Create a device> -> <submit dump on it and wait for completion> -> <Remove the device>.

The difference with the in-kernel code is that the time between <submit dump on it and wait for completion>
and <remove the device> is very short and causes race between sysfs_delete_link() and device_del().
I think devcoredump framework should also cover this case.

> thanks,
> 
> greg k-h
