Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1277BF6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjJJJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:05:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692F4A7;
        Tue, 10 Oct 2023 02:05:24 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A8P6vL010898;
        Tue, 10 Oct 2023 09:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EoN/xq0RhbRPvd82MKssrOGPVfvh78jLFZhOIk0C/YE=;
 b=Nl1w4KQkQNltrj6tg5VJoeOsuJEi8r7Au+Fj2gtFfdL8bIFVcC6sl7jKgJjPSz+Jbnpg
 oVz1wNPvIYXuBe/1juK+qqAnTMdtrp+6ODdRtmDcLh14IUiza+80pOPJufI4jwKBiqjc
 COFfvdOcxBQab2zOeYs6c9KjGnJZaJYLq1gQim+qJSc8LHX+9mQcmASr+AzqzXOyLYYX
 /nfpsGFU7EQ7OuDCldLFXhdBDT9L4NiPBJECgbpL2PuwypujAf/M6TolX04JWRcGUQUY
 WRZkk2zVV5dYflRNhdD3YddsLDC4kH+5Rmws+EMMAdH2WtBGcvk4e3rKASY/Ug6qNcE0 WQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmyma8dhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 09:04:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39A94oth020223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 09:04:50 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 10 Oct
 2023 02:04:47 -0700
Message-ID: <5f9b483a-ec7e-05f4-4472-57e2300f2c01@quicinc.com>
Date:   Tue, 10 Oct 2023 14:34:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RESEND] xhci: Keep interrupt disabled in initialization
 until host is running.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hongyu Xie <xy521521@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>, <stable@kernel.org>,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
References: <1696847966-27555-1-git-send-email-quic_prashk@quicinc.com>
 <2023100943-underhand-wizard-6901@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023100943-underhand-wizard-6901@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DNj0ZdrotpaFZCORjSLhjA2CfT_WIqRx
X-Proofpoint-GUID: DNj0ZdrotpaFZCORjSLhjA2CfT_WIqRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=485
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100067
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09-10-23 06:22 pm, Greg Kroah-Hartman wrote:
> On Mon, Oct 09, 2023 at 04:09:26PM +0530, Prashanth K wrote:
>> From: Hongyu Xie <xy521521@gmail.com>
>>
>> [ Upstream commit a808925075fb750804a60ff0710614466c396db4 ]
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
>> Cc: <stable@vger.kernel.org> # 5.15
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
> 
> Any specific reason you missed adding the extra blank line in this
> version of the backport that the original added?  That is going to cause
> problems in the future if other patches are added on top of this that
> would be expecting it because it is that way in Linus's tree.
> 

Thanks for pointing out, i removed it while resolving some merge 
conflicts. Will add it back in next version.

> And why is this only relevant for 5.15.y?

I'm not really sure why this was only ported from 5.19 onwards and not 
present in older kernels (could be because of dependencies/conflicts).

But anyways im backporting it to 5.15 since an irq storm was seen on a 
qcom SOC working on 5.15, and this patch is helping solve it.

Should I change the CC to just stable kernel (without mentioning kernel 
version) ?
something like this -- Cc: <stable@vger.kernel.org>

Regards.
Prashanth K
