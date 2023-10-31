Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EB7DC827
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjJaIaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjJaIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:30:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD69D8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:29:57 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V8MWoJ006525;
        Tue, 31 Oct 2023 08:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9Hn77NQwY6AThwZPjiuVDGtZ59cJf5SXzge7H1OZnIw=;
 b=UBrlysvr0NbRvdiFErsli9WqBlbb5RH9V8XqNnnH7TXEmVudLqneLH5b4rSlCbdwfaUQ
 +cvJ3PcN3boQpMvumilk4issMEAj3oQlaE+gZVqboZzrRNtCjVjMJzqfsGAsCELwGaXA
 s5lGIJ5SK2bC/ILFGNZVsgg68BhUWaG7CW1sK8Va7BkHUneSW4ZEeAaX59MraAdlBPrf
 WhmJEp8DHoD1QU4o+kup9aKwPjZZq2dDp7kc9mI7Z80Q6yUL6sQvo0fpvY94wgSXupBK
 FoQBuGGtWJPmoKm4vh+uGe1jnmYA4xzazOh/UHTKq46QQNX83qFPpiHLgV759kIoD2EB EA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2tpx0eqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 08:29:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V8TonW030717
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 08:29:50 GMT
Received: from [10.231.194.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 01:29:46 -0700
Message-ID: <ab509035-cf3c-4902-87a8-cbba03ac948c@quicinc.com>
Date:   Tue, 31 Oct 2023 16:29:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
 <2023102730-twins-thieving-d04e@gregkh>
 <22ab53d1ae36d4925732e6e1dc989dc75af126da.camel@sipsolutions.net>
From:   Yu Wang <quic_yyuwang@quicinc.com>
In-Reply-To: <22ab53d1ae36d4925732e6e1dc989dc75af126da.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UzOr7_JgPXVHO4eXhL7QXftwdSmVlplW
X-Proofpoint-GUID: UzOr7_JgPXVHO4eXhL7QXftwdSmVlplW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=920
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comments :)

On 10/27/2023 8:45 PM, Johannes Berg wrote:
> On Fri, 2023-10-27 at 13:11 +0200, Greg KH wrote:
>>>
>>>     static void my_coredump()
>>>     {
>>>         struct my_coredump_state dump_state;
>>>         struct device *new_device =
>>>             kzalloc(sizeof(*new_device), GFP_KERNEL);
>>>
>>>         ...
>>>         new_device->release = my_dev_release;
>>>         device_initialize(new_device);
>>>         ...
>>>         device_add(new_device);
>>>         ...
>>>         init_completion(&dump_state.dump_done);
>>>         dev_coredumpm(new_device, NULL, &dump_state, datalen, GFP_KERNEL,
>>>                       my_coredump_read, my_coredump_free);
>>>         wait_for_completion(&dump_state.dump_done);
>>>         device_del(new_device);
>>>         put_device(new_device);
>>>     }
>>
>> Is there any in-kernel user like this?  If so, why not fix them up to
>> not do this?

In this case, the device is temporarily added for dump only, so we need to
delete it when dump is completed.
The other users doesn't add/delete the device like this.

>>
> 
> Maybe this is only a simplified scenario and whenever you remove a
> device when a coredump is still pending this can happen?

It removes the device when the @free function has been called, I think
the @free function should be considered as a completion signal, and so
we need to put @free at the end of falling-device-related-clean-up in
devcoredump framework (the change in the patch).

> 
> Actually, no, wait, what is this doing??? Why is there a completion and
> all that stuff there? You shouldn't really care about the dump once you
> have created it, and not pass NULL for the struct module pointer
> either?!

Yes, I know we don't need to care about the dump data, but as mentioned
upon, the device is locally and temporarily created for this one-time dump
only, we need to free it when dump is completed, so introduce this completion.
Refer to drivers/remoteproc/remoteproc_coredump.c.

Regarding NULL for the struct module pointer, looks it's allowed for this
API (<remoteproc_coredump.c> also pass NULL)? But yes, it's not nice indeed,
we need this to get a reference of the calling module for safety.
Will correct in the next patch set.

> 
> johannes

Best Regards,
Yu


