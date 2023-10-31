Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9AE7DCD44
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjJaMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbjJaMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:46:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26634BD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:46:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VCiMKC001407;
        Tue, 31 Oct 2023 12:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kj42GSjBD9l1IwUpud9VjYe5T+uWJCcb7fnDVpPknos=;
 b=p0cfV3fW9vI1Y0UUvev5x/NnuFc5UEJ4sKL5BaA8XjjLlFlbgANf+/BhYpAUVKUDV9ig
 rwfrQjQidl6c+M/MTSx6aKA+6GdxBO92nIG1F7PXq/JIhwtdI8HCZK4nhyegHIvdq6nY
 d0DhTzLCXwMPyB1G9thx71tqI9IYySxdN9Xl5No4yweOreoAxs5RpVKejX9bFo8fisLw
 /XZbisaxpQ8A/b2/sWEjhyM4v+55ba3OMGWxkBsQ5BY2sJNSXInT8km/G+OLzOTBWlTd
 iAriXarJrfJW/vVX69WTlCAag4QsnGr2h9Tmj23oew6XR9Il0tZt+E93Xdas6HkrldBD Gg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2tpx15ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:46:18 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39VCkHgw017781
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:46:17 GMT
Received: from [10.214.225.95] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 05:46:11 -0700
Message-ID: <bb8113aa-1573-5e02-3fcd-bd92b8ac14ba@quicinc.com>
Date:   Tue, 31 Oct 2023 18:16:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Yu Wang <quic_yyuwang@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
 <2023102730-twins-thieving-d04e@gregkh>
 <22ab53d1ae36d4925732e6e1dc989dc75af126da.camel@sipsolutions.net>
 <ab509035-cf3c-4902-87a8-cbba03ac948c@quicinc.com>
 <d00e8976baa4fb93a1f3f1191998994540bb173b.camel@sipsolutions.net>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <d00e8976baa4fb93a1f3f1191998994540bb173b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F-yrVNa9Fwo1ur2TEGp2bJ6Zc-3781MG
X-Proofpoint-GUID: F-yrVNa9Fwo1ur2TEGp2bJ6Zc-3781MG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=985
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310101
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2023 2:29 PM, Johannes Berg wrote:
> On Tue, 2023-10-31 at 16:29 +0800, Yu Wang wrote:
>>
>> In this case, the device is temporarily added for dump only, so we need to
>> delete it when dump is completed.
>> The other users doesn't add/delete the device like this.
> 
> For good reason, I guess? I think this is probably a bad idea.
> 
> The whole point of this was to actually know which device created the
> coredump? If you make one up on the fly that's ... pointless? Surely you
> must have _some_ device that already exists?

Passing device name to be user space looks to be the reason.

Looks like here, it is trying to do what devcoredump is already doing, 
like dev_coredump creates a custom device and deletes it after either
5 min or based on user space action. Same might being called from caller
of devcoredumpm().
devcd->free() should not be assumed to delete custom device
as devcd has reference to your device..and it can not be freed unless
devcoredump put reference to your device..

What is the assumption behind this comment 89-92 ?
sysfs_delete_link() is assuming the device is still there and
deleting the link..why is this needed if this is vulnerable..

82 static void devcd_dev_release(struct device *dev)
83 {
84         struct devcd_entry *devcd = dev_to_devcd(dev);
85
86         devcd->free(devcd->data);
87         module_put(devcd->owner);
88
89         /*
90          * this seems racy, but I don't see a notifier or such on
91          * a struct device to know when it goes away?
92          */
93         if (devcd->failing_dev->kobj.sd)
94                 sysfs_delete_link(&devcd->failing_dev->kobj, &dev->kobj,
95                                   "devcoredump");
96
97         put_device(devcd->failing_dev);
98         kfree(devcd);


-Mukesh
> 
>> It removes the device when the @free function has been called, I think
>> the @free function should be considered as a completion signal, and so
>> we need to put @free at the end of falling-device-related-clean-up in
>> devcoredump framework (the change in the patch).
> 
> That may be true for the case you have, but really, I wouldn't consider
> that a bug now? >
> Besides, we do hav<e put_device() at the end, and I'm not sure I see how
> the device can be removed before put_device()?
> 
> Can parts of the device there disappear before we release all the
> references? Could that mean the scenario is also possible without your
> contorted device creation and removal, just by unplugging the device
> while a coredump exists in sysfs?


> 
>> Yes, I know we don't need to care about the dump data, but as mentioned
>> upon, the device is locally and temporarily created for this one-time dump
>> only, we need to free it when dump is completed, so introduce this completion.
>> Refer to drivers/remoteproc/remoteproc_coredump.c.
> 
> I still don't think this is right ... Even the code there is awful, it
> potentially blocks for 5 minutes? I'm not sure we should encourage that.
> 
> Note that you could also argue exactly the other way around - what if
> the *free* function requires access to the device? It gets arbitrary
> data after all.
> 
> 
>> Regarding NULL for the struct module pointer, looks it's allowed for this
>> API (<remoteproc_coredump.c> also pass NULL)? But yes, it's not nice indeed,
>> we need this to get a reference of the calling module for safety.
>> Will correct in the next patch set.
> 
> Well, it's not really allowed to literally write NULL - maybe we should
> have a macro that fills in THIS_MODULE. But THIS_MODULE can be NULL at
> runtime if it's in built-in code ... so we can't catch it.
> 
> But actually if you do have the completion you wouldn't care about this
> specific case, but ...
> 
> johannes
