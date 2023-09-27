Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B37AFEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjI0Irx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjI0Irs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:47:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133ECC;
        Wed, 27 Sep 2023 01:47:47 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R7Qg6M027364;
        Wed, 27 Sep 2023 08:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DFClMcz23Gf8da0D7pNHglGNlh8JbZ50VURIo0Bxb8k=;
 b=npEqrAHBiyP32TW6/Yu+8ZBRAzBT+ka/hXE2azEJoMbjrM2GKvaWa3TMYcXKsxl4WKMY
 NsggJbrdePDD5pPOp1Zo9h2BFV5AwvWv37YrECLGJK3PzWToEcxDqZ4M3fSR5HDJlA/A
 /yv3IKAWmeME62jLrnNxGG1hpbqRx2dt1FYQDkXMdU+01WvbALpSjnPQdNlJ+90OwIwZ
 yxQxfNwa8q12OCQFfO4rd81TRp39RLiqnJUE1e5RTfLpgmhRF/juJI8J6m1GZPp8HMz8
 orhI4oXAXb0H4XU8/2KNMHAcsdbvztZvpepAGKu2kZvQ90qfLZ0jFNXGCp7t19oRHmmV WA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcda7rena-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:47:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R8lL1b004704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:47:22 GMT
Received: from [10.216.34.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 01:47:17 -0700
Message-ID: <3c18614f-eb77-4eff-be1d-068cde655b0a@quicinc.com>
Date:   Wed, 27 Sep 2023 14:17:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] usb: gadget: udc: Handle gadget_connect failure during
 bind operation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20230927073027.27952-1-quic_kriskura@quicinc.com>
 <2023092701-facelift-projector-d1d4@gregkh>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <2023092701-facelift-projector-d1d4@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nP6WagGRzemSeX86E-Bhsd90GT-U81k0
X-Proofpoint-GUID: nP6WagGRzemSeX86E-Bhsd90GT-U81k0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=498 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 1:46 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 27, 2023 at 01:00:27PM +0530, Krishna Kurapati wrote:
>> In the event gadget_connect call (which invokes pullup) fails,
>> propagate the error to udc bind operation which in turn sends the
>> error to configfs. The userspace can then retry enumeration if
>> it chooses to.
> 
> Will this break userspace that is not expecting error codes to be
> returned?  What userspace code will now be modified to handle this?
> Where is that work happening?
> 
> thanks,

Hi Greg,

  This only handles cases where the pullup failed but the error code 
wasn't returned to configfs_udc_store approrpiately. In userspace when 
we do the following:

echo "UDC NAME" > /usb_gadget/<>/UDC

in the issue I was facing, the core soft reset was failing and we return 
-110 from dwc3/core.c to udc's bind_to_driver call, but it is not 
checked any where today and we return 0 to udc_store in configfs. The 
userspace assumes the UDC write went through (and enum happened) but it 
actually doesn't. If we propagate the -ETIMEDOUT coming from dwc3-core 
all the way to configfs_udc_store, it will reach userspace as well 
indicating that the echo command was not successful which then the user 
can choose to retry or not. On Android devices, I saw userspace retry 
happening when we propagate dwc3-core error to userspace. So nothing in 
userspace breaks. It can stay as it but this time, the echo in userspace 
will fail if pullup fails for some reason.

Regards,
Krishna,
