Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B87B8A96
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbjJDSg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbjJDSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:36:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8487A7;
        Wed,  4 Oct 2023 11:36:26 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FBLvr028282;
        Wed, 4 Oct 2023 18:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6M3YAebF9rrs3opK3mpTD1jmedIyRT/cMOQ6DDH1tyM=;
 b=AfcnYAjLVk8hVxmWmdF/yylUGqfIZ7FeD1F4DB9WeY2hh1UuUaO8K8wzGq8ENxXacTBv
 +rXSm3UKVxoh9zjzKMby24VOV44iXS4UiH+RgCqYC8p/eg4/8vz4et4tjPoOwYPM4B4q
 duDpI5J0Dr9MHLh4hLwsjAQZOps3/HLypCaDY9fIcuMU6YyyGj6OgzDanbRsqcki2GAi
 2ujp+RKWMC8xWFH56kRquJsGwybxookOCZVxSPiNqMMm/Z89gpgUGFNEdLbTr4ZyTIdm
 WvAqoiCoOL9fA3OTtsRUCuK3AydDvMiu0GhTgKM0stQKqOcKGtZuH+vz4/U4Wny8iARN Jw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th2gq1t4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 18:35:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394IZhC3025160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 18:35:44 GMT
Received: from [10.71.112.36] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 11:35:10 -0700
Message-ID: <2127ef61-e263-2a0e-438a-6baa125aa70d@quicinc.com>
Date:   Wed, 4 Oct 2023 11:35:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 01/33] xhci: add support to allocate several
 interrupters
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-2-quic_wcheng@quicinc.com>
 <10ad0613-7e88-dbe8-c5a2-d535f8e9db03@linux.intel.com>
 <e3f3c8cd-6338-da08-d988-4d2ed68280e6@quicinc.com>
 <843897f1-3ce5-f8da-5f10-7d8a68849fd2@intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <843897f1-3ce5-f8da-5f10-7d8a68849fd2@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6qI8t9feb8uXz-ckzPnXYaJeZ5ViYC9L
X-Proofpoint-ORIG-GUID: 6qI8t9feb8uXz-ckzPnXYaJeZ5ViYC9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=598 mlxscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040136
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 10/4/2023 7:02 AM, Mathias Nyman wrote:
> On 2.10.2023 23.07, Wesley Cheng wrote:
>> Hi Mathias,
>>
>> On 9/28/2023 3:31 AM, Mathias Nyman wrote:
>>> On 22.9.2023 0.48, Wesley Cheng wrote:
>>>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>>
>>>> Modify the XHCI drivers to accommodate for handling multiple event 
>>>> rings in
>>>> case there are multiple interrupters.  Add the required APIs so 
>>>> clients are
>>>> able to allocate/request for an interrupter ring, and pass this 
>>>> information
>>>> back to the client driver.  This allows for users to handle the 
>>>> resource
>>>> accordingly, such as passing the event ring base address to an audio 
>>>> DSP.
>>>> There is no actual support for multiple MSI/MSI-X vectors.
>>>>
>>>> Factoring out XHCI interrupter APIs and structures done by Wesley 
>>>> Cheng, in
>>>> order to allow for USB class drivers to utilze them.
>>>>
>>>>   }
>>>> +void xhci_remove_secondary_interrupter(struct usb_hcd *hcd, struct 
>>>> xhci_interrupter *ir)
>>>> +{
>>>> +    struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>>>> +    unsigned int intr_num;
>>>> +
>>>> +    /* interrupter 0 is primary interrupter, don't touchit */
>>>> +    if (!ir || !ir->intr_num || ir->intr_num >= 
>>>> xhci->max_interrupters) {
>>>> +        xhci_dbg(xhci, "Invalid secondary interrupter, can't 
>>>> remove\n");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* fixme, should we check xhci->interrupter[intr_num] == ir */
>>>> +    spin_lock(&xhci->lock);
>>>
>>> Needs to be spin_lock_irq() ir spin_lock_irqsave() as xhci->lock is 
>>> used in interrupt handler.
>>>
>>>
>>>> +    intr_num = ir->intr_num;
>>>> +    xhci_free_interrupter(xhci, ir);
>>>> +    xhci->interrupters[intr_num] = NULL;
>>>> +    spin_unlock(&xhci->lock);
>>>
>>> likewise
>>>
>>
>> Let me check these again.  In general, I think I will use both the 
>> xhci->mutex and xhci->lock where needed, because I believe we'd run 
>> into sleep while atomic issues
>> while freeing the DMA memory.  Will rework this and submit in the next 
>> rev.
>>
> 
> Maybe we need to split xhci_free_interrupter() into separate remove and 
> free functions
> 

Thanks for sharing the work you've been doing.  Yes, I did something 
similar as well on my end, but will refactor in your code and re-test.

> Did some work on this, and on the sideband api in general.
> 
> Code still has a lot of FIXMEs, and it's completely untested, but to 
> avoid us
> from doing duplicate work I pushed it to my feature_interrupters branch 
> anyway
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git 
> feature_interrupters
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters 
> 

Ok.  Initial look at it seems like it will be fine, but will integrate 
and make changes where needed.

Thanks
Wesley Cheng
