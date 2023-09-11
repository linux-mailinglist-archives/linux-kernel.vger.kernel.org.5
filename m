Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721A179B52E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348037AbjIKVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbjIKKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:07:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF7C101;
        Mon, 11 Sep 2023 03:07:04 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B9gQ2w020649;
        Mon, 11 Sep 2023 10:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BOJ07bV4t2/uag4UNTUkpBRa2NMKQP1lRLDwm6QfzlE=;
 b=foUUgrpP5Kt2DqDWXLYzSwX5MwSyNGE8vxIqIdovuAQicf8WvrJYKduvLbdR912sQnYp
 tYukODwENivPl9cWoYYi9fxcm5A0kBaYNq06cIwuEqZUGiCqLl2sAGVuD3QHYfY4hI8w
 nw8SfYpZaCyPQ6J9uAuBw54N602U9t0phtPfPiD4kSUiSqSZoUvtS1CmaFEgFYv7fPbp
 vnisLw4FLn+a3kvcI+p0xmc0Xtd1k6wf1XRfj/9VqDcGRG3I+TM3pFU2KHFrN1Xiv67U
 5iVQiM5JS/NkR1kXo4MNzJjVrrMP7Bs55FBIkEu/qoQxlwMFJ5X1xoIoMK+lbCIekcdi Ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0h3du4bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:02:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BA2uU0000951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:02:56 GMT
Received: from [10.253.14.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 03:02:53 -0700
Message-ID: <d34242f8-6e21-1549-b87d-3db2e825b7d5@quicinc.com>
Date:   Mon, 11 Sep 2023 18:02:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
 <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com>
 <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _zm_SmkmFyd3BL5yPQYTnMgcv3R3EEnr
X-Proofpoint-ORIG-GUID: _zm_SmkmFyd3BL5yPQYTnMgcv3R3EEnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309110091
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/11/2023 5:46 PM, Konrad Dybcio wrote:
> On 11.09.2023 11:42, Can Guo wrote:
>> Hi Konrad,
>>
>> On 9/11/2023 5:17 PM, Konrad Dybcio wrote:
>>> On 11.09.2023 07:59, Can Guo wrote:
>>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
>>>>
>>>> Retrieve UFS device version from UFS host controller's spare register
>>>> which is populated by bootloader, and use the UFS device version together
>>>> with host controller's HW version to decide the proper power modes which
>>>> should be used to configure the UFS PHY.
>>> That sounds a bit fishy.. is there no bootloader-independent
>>> solution to that? Can't we bring in the code that the bootloader
>>> uses to determine these values?
>>>
>>> Konrad
>>
>> Agree, it is.
>>
>>
>> All these complexities come from one request from PHY design team - power saving.
>>
>> And to achieve power saving, Qualcomm UFS developers are requested to use the
>>
>> lowest hanging PHY settings which can sustain the Max agreed HS Gear (btw host
>>
>> and UFS device) during UFS's lifecycle in High Level OS,  whereas the power saving
>>
>> request does not apply to bootloader, which works for only a few seconds during
>>
>> bootup. Hence, there is no such version detect code in bootloader -  it just uses the
>>
>> highest PHY settings to configure PHY, boot up UFS and put UFS device version in this
>>
>> register.
> First of all, your email client seems to be inserting 2 newlines
> instead of 1. If you're using thunderbird, you may want to edit:
>
> mail.identity.(default or your mail identity idx).default.compose_html
>
> to `false`
>
> and add that to your internal wiki page, as I see many @quic folks having
> this issue.
>
>
> Going back to the main topic, I don't think we understood each other.
> The commit message states:
>
>
> "Retrieve UFS device version from UFS host controller's spare register
> which is populated by bootloader"
>
>
> Which means the bootloader is able to somehow determine the value
> that's in the spare register and write it there.
>
> I'm asking whether we can take the logic behind this value and
> move it to Linux so that we don't depend on the bootloader to
> guarantee it (e.g. Chrome or some other devices with more exotic
> fw may not work this way).
>
>
> Konrad


There is no logic behind this value at all in bootloader, as I 
explained, after bootloader

initializes UFS, bootloader simply reads UFS's device version (the value 
you are referring)

and write it to the register. But in Linux kernel, we need (or want to 
know) this value

BEFORE we initialize UFS host controller (and UFS device).


Thanks,

Can Guo.

