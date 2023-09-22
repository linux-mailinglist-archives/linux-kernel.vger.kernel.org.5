Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD27AAF95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjIVKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIVKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:34:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E899
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:33:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M8Q3bO025536;
        Fri, 22 Sep 2023 10:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UQ9Kuh5z400Zh5gwFTlF3Opqc6mYNjyeBhpwWAY1FcE=;
 b=jwGIry+sax3rEg/uZQ2F7rYWIJOPvfBGKkPIojFlYuFHbL9qC/K4NKfDC9U6/V8szvuK
 5UY5LqUvyjNAky0YaLpZiSH19KIFKG/3BTcM4jpIMxZbE4DrVL6LR8Xo0Ne+sFKUtv3H
 bm5hab4W8/iaYGYnfEeHeKfubKGnPiKtkg+tWD/wamcMWJ9yIIEVWwD6ouSHFZOIH+u9
 rC2mbzK2qdEZvhqhGCsq5OEu5cCeURd92KB1xwA3Ky7dRKc6wHdII1REVgnEnUzjmHO+
 kmi9i8P4HrQerQwFsjumAz0pzYFfALSPKKWTti9Im9Od+iW+0NzL8ZCtIf+sKtNgilmt aA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8txphk3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 10:33:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MAXWlp007257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 10:33:32 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 03:33:30 -0700
Message-ID: <56e210a4-8106-db7a-f44d-e40421e5abf7@quicinc.com>
Date:   Fri, 22 Sep 2023 16:03:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] xhci: Keep interrupt disabled in initialization until
 host is running.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Hongyu Xie <xy521521@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>, <stable@kernel.org>,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
References: <1695374501-22649-1-git-send-email-quic_prashk@quicinc.com>
 <2023092256-smudge-disallow-48d3@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023092256-smudge-disallow-48d3@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 56VhROARQ1JS8PXRTMLcbGvSe_v-z6k6
X-Proofpoint-GUID: 56VhROARQ1JS8PXRTMLcbGvSe_v-z6k6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_08,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=387 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220088
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22-09-23 04:00 pm, Greg Kroah-Hartman wrote:
> On Fri, Sep 22, 2023 at 02:51:41PM +0530, Prashanth K wrote:
>> From: Hongyu Xie <xy521521@gmail.com>
>>
>> [ Upstream commit 808925075fb750804a60ff0710614466c396db4 ]
>>
>> irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
>> in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
>> It's possible that you will receive thousands of interrupt requests
>> after initialization for 2.0 roothub. And you will get a lot of
>> warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
>> disabled?". This amount of interrupt requests will cause the entire
>> system to freeze.
>> This problem was first found on a device with ASM2142 host controller
>> on it.
>>
>> [tidy up old code while moving it, reword header -Mathias]
>>
>> Cc: stable@kernel.org
>> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Link: https://lore.kernel.org/r/20220623111945.1557702-2-mathias.nyman@linux.intel.com
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   drivers/usb/host/xhci.c | 34 +++++++++++++++++++++-------------
>>   1 file changed, 21 insertions(+), 13 deletions(-)
> 
> What stable kernel(s) are you asking this to be applied to?
> 
> greg k-h
Need this patch on v5.15, I had cc'ed "stable@kernel.org # 5.15", but 
looks like it didn't work. Should I resend this with SOB and CC tags?

Thanks,
Prashanth K
