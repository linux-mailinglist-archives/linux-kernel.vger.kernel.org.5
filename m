Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C487DC4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjJaC4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjJaC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:56:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE6A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:56:33 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V2l4Vp021477;
        Tue, 31 Oct 2023 02:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ww8VMGJYBALprhE/ePbQnMezKuVu2Fwl/HbEoCxLImY=;
 b=XC6Hitt5fi8T20s1BmYY+9vcVRRkfnY3mLNeVyO2VoCMx6LTtCG1bWowFAEbN+6esaD1
 XklNzgyIBl/2LShO2rFh02tpmdCmEfjbyM3QUxfgUE7LYljttxX5HIYna5MzjRmIxmEY
 Ggd+DGJ3g+ziBSNBHkrkof9WK4zVuckXwUJaVGltSxpXw2mh9E6eXpDUV27GAGEMkd//
 oDhFqt8ufPH6LhnZ8DhpdeiA+T3bLRa+zF24QrWkw9/tH5jUtqDUdSrhKatOBslJwZ6C
 Nd9bvksuuxAVUUtWS/jNiO6n2ibCGk4K4z7P4o6R+977Kgs4MICpjhJS7exxyXoXMn2N Zg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2fuvh4as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 02:56:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V2uSau029496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 02:56:28 GMT
Received: from [10.233.17.145] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 19:56:26 -0700
Message-ID: <c244eae0-d3d8-414b-8d1f-c902bd46bd61@quicinc.com>
Date:   Tue, 31 Oct 2023 10:56:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to pass software configuration to driver built as module in
 boot up phase
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>
References: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
 <2023103021-revolving-clapper-632d@gregkh>
From:   Tingwei Zhang <quic_tingweiz@quicinc.com>
In-Reply-To: <2023103021-revolving-clapper-632d@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SsBJ3LL2r7bu02ZwmZl7zssyI21Pjmze
X-Proofpoint-GUID: SsBJ3LL2r7bu02ZwmZl7zssyI21Pjmze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=886 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2023 7:30 PM, Greg Kroah-Hartman wrote:
> On Mon, Oct 30, 2023 at 07:21:48PM +0800, Tingwei Zhang wrote:
>> Hi Masami, Greg and Rafael,
>>
>> I have one driver that needs a bunch to software configuration like 1000
>> settings. These settings can be different according to the use case.
> 
> That seems very odd, what type of driver is this?
The example use case is below DCC driver which is a DMA engine. It can 
be configured to read/write registers while whose registers need to be 
configured by software. It's mainly used to debug device crash issue.
https://lore.kernel.org/lkml/cover.1691496290.git.quic_schowdhu@quicinc.com/T/
> 
>> They are required in boot up phase so we can't reply on user space to make
>> the configuration.
>>
>> Boot config is not preferred since we'd like to build that driver as dynamic
>> load Kernel module.
>>
>> Could you let me know if there's any mechanism in Kernel to do that?
> 
> What is wrong with the existing ways of doing this that all other
> drivers use?
I'm not aware of all the existing ways. Below ways are what I know and 
they may not be suitable for some reason.
1. Let user space to configure with sysfs/debugfs/ioctl interface. Since 
we need this configuration to be done in early stage before user space 
is up. This doesn't work.
2. Use device tree to pass the configuration to driver. Since the 
configuration is software configuration instead of hardware descirption. 
It doesn't fit in device tree.
3. Boot config or commandline parameter. If the driver is built in, it 
can work. But it doesn't work for dynamically loadable Kernel module.

I started this thread to look for suitable way in Kernel for driver to use.

> 
> thanks,
> 
> greg k-h

-- 
Thanks,
Tingwei

