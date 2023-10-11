Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9C7C4A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjJKGZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbjJKGZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:25:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D91F93;
        Tue, 10 Oct 2023 23:25:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B5tbkx006984;
        Wed, 11 Oct 2023 06:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FNcW6uVn2Ym9wH75Rqrq2d8PLHk+LRw2BARKhFE40V0=;
 b=KBrDM29OU8qw2ZNb7/fCxSXM/AVIs2+CN0UVEwX/mPtH3j3xInQ1tLxoovLZlAG6JgQU
 Hc5DQG2ub7ElNnlri+TuZ7RfCtS631nlPRvZFdf7kF0rJFlqhL7AwRpucre2yBRIOpsz
 64IBpxFsKp1NKzziTHfotm9ysK8nkVRqquhJUNZcwlzVKueiK46bJ3VWWFiw4q/HQKSw
 irIVFuMWyoj8Rmi6QwOmaH3fND502mxwPBfarT8tBdsFE3iHpi4IW2NAxRoavnfGEyR2
 s/HUykKeVETGmtVoaXKRyXLoBfXffthJnrSN8cM1BYhpiC5xJHhzsFvfo7wznT8KrKkl Mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmymaas74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 06:24:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B6OZ4t023306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 06:24:35 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 10 Oct
 2023 23:24:33 -0700
Message-ID: <cb881f40-7053-14f1-2498-cb06e40c0ac4@quicinc.com>
Date:   Wed, 11 Oct 2023 11:54:29 +0530
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
 <5f9b483a-ec7e-05f4-4472-57e2300f2c01@quicinc.com>
 <2023101043-muscular-risk-065f@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023101043-muscular-risk-065f@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l2XiBKCgwb9Gs62g278yteWNLBgv8YYH
X-Proofpoint-GUID: l2XiBKCgwb9Gs62g278yteWNLBgv8YYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_03,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=624
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110056
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10-10-23 04:48 pm, Greg Kroah-Hartman wrote:
> On Tue, Oct 10, 2023 at 02:34:44PM +0530, Prashanth K wrote:
>>
>>
>> On 09-10-23 06:22 pm, Greg Kroah-Hartman wrote:
>>> On Mon, Oct 09, 2023 at 04:09:26PM +0530, Prashanth K wrote:
>>>> From: Hongyu Xie <xy521521@gmail.com>
>>>>
>>>> [ Upstream commit a808925075fb750804a60ff0710614466c396db4 ]
>>>>
>>>> irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
>>>> in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
>>>> It's possible that you will receive thousands of interrupt requests
>>>> after initialization for 2.0 roothub. And you will get a lot of
>>>> warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
>>>> disabled?". This amount of interrupt requests will cause the entire
>>>> system to freeze.
>>>> This problem was first found on a device with ASM2142 host controller
>>>> on it.
>>>>
>>>> [tidy up old code while moving it, reword header -Mathias]
>>>>
>>>> Cc: stable@kernel.org
>>>> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
>>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>> Link: https://lore.kernel.org/r/20220623111945.1557702-2-mathias.nyman@linux.intel.com
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: <stable@vger.kernel.org> # 5.15
>>>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>>>> ---
>>>
>>> Any specific reason you missed adding the extra blank line in this
>>> version of the backport that the original added?  That is going to cause
>>> problems in the future if other patches are added on top of this that
>>> would be expecting it because it is that way in Linus's tree.
>>>
>>
>> Thanks for pointing out, i removed it while resolving some merge conflicts.
>> Will add it back in next version.
>>
>>> And why is this only relevant for 5.15.y?
>>
>> I'm not really sure why this was only ported from 5.19 onwards and not
>> present in older kernels (could be because of dependencies/conflicts).
>>
>> But anyways im backporting it to 5.15 since an irq storm was seen on a qcom
>> SOC working on 5.15, and this patch is helping solve it.
>>
>> Should I change the CC to just stable kernel (without mentioning kernel
>> version) ?
>> something like this -- Cc: <stable@vger.kernel.org>
> 
> No, let us know what kernel version this is to be applied to so we know,
> if you only think this is relevant for 5.15.y as you have tested it
> there, that's fine, I just wanted to be sure.

We tested it on 5.15 for over 20 hours and didn't see any issue. Will 
send a new patch after adding the newline.

Thanks,
Prashanth K
