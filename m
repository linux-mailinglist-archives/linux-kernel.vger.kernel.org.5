Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB9808480
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378549AbjLGJXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjLGJWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:22:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179841723;
        Thu,  7 Dec 2023 01:21:35 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B78xATn017704;
        Thu, 7 Dec 2023 09:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UPK6JgHMg+43fthh/PfcoABgDSewRXvyr2FyzyOmAWg=;
 b=mTjwf7xonT0zCzUlD6ANKLSVPajLIw2vXYl+btdpoyYvPFwWKXU7sFIGdXAorK1hQJct
 VWS2+SEOelzBUFGeWl0+KFH+a0DC7mv6Wth/1JTrANL/o8402eukt0PIlur16orpibL1
 ZX5jcYLgRK8tAJDjNeYpxtbmo6jdF6n/H2a7r/Ef0DIVPhUJyMcdD0an1bkYcTjhHBdc
 vCLKuelrs+zNC2EcxAfrohdyI5T1Zl0o+sz6kM/n3rVwb9dzgRfI1/vBLy8k2TuLiaXC
 fdfjeBYLU64AaShLZaixGuO669KBXVvjPqtJk6CMbTk0ZDBGGW0tfXDk7FC5KULhvIRT rw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu2trgyj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 09:21:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B79KuE9016213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 09:20:56 GMT
Received: from [10.253.35.241] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 01:20:54 -0800
Message-ID: <c12b0ed6-4189-4625-84bf-abd835b9b364@quicinc.com>
Date:   Thu, 7 Dec 2023 17:20:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] bus: mhi: host: Take irqsave lock after TRE is
 generated
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>,
        Hemant Kumar <quic_hemantk@quicinc.com>,
        Lazarus Motha <quic_lmotha@quicinc.com>
References: <1699939661-7385-1-git-send-email-quic_qianyu@quicinc.com>
 <1699939661-7385-5-git-send-email-quic_qianyu@quicinc.com>
 <20231124100916.GB4536@thinkpad>
 <ae1514d1-1cdf-42f8-ac8c-6e6c2005922f@quicinc.com>
 <20231207063851.GD2932@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20231207063851.GD2932@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rYNauRuawIpTuYpOhS5AX1iwU8SIXg4h
X-Proofpoint-ORIG-GUID: rYNauRuawIpTuYpOhS5AX1iwU8SIXg4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=897
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/2023 2:38 PM, Manivannan Sadhasivam wrote:
> On Mon, Nov 27, 2023 at 03:19:49PM +0800, Qiang Yu wrote:
>> On 11/24/2023 6:09 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Nov 14, 2023 at 01:27:41PM +0800, Qiang Yu wrote:
>>>> From: Hemant Kumar <quic_hemantk@quicinc.com>
>>>>
>>>> If CONFIG_TRACE_IRQFLAGS is enabled, irq will be enabled once __local_bh_
>>>> enable_ip is called as part of write_unlock_bh. Hence, let's take irqsave
>>> "__local_bh_enable_ip" is a function name, so you should not break it.
>> Thanks for let me know, will note this in following patch.
>>>> lock after TRE is generated to avoid running write_unlock_bh when irqsave
>>>> lock is held.
>>>>
>>> I still don't understand this commit message. Where is the write_unlock_bh()
>>> being called?
>>>
>>> - Mani
>> Write_unlock_bh() is invoked in mhi_gen_te()
>> The calling flow is like
>> mhi_queue
>>      read_lock_irqsave(&mhi_cntrl->pm_lock, flags)
>>      mhi_gen_tre
>>          write_lock_bh(&mhi_chan->lock)
>>          write_unlock_bh(&mhi_chan->lock)   // Will enable irq if
>> CONFIG_TRACE_IRQFLAGS is enabled
>>      read_lock_irqsave(&mhi_cntrl->pm_lock, flags)
>>
>> after adding this patch, the calling flow becomes
>>
>> mhi_queue
>>      mhi_gen_tre
>>          write_lock_bh(&mhi_chan->lock)
>>          write_unlock_bh(&mhi_chan->lock)
>>      read_lock_irqsave(&mhi_cntrl->pm_lock, flags)
>>      read_lock_irqsave(&mhi_cntrl->pm_lock, flags)
> So this patch essentially fixes the issue caused by patch 1? If so, this should
> be squashed into patch 1.
>
> - Mani

Yes, this patch is to fix the issue caused by patch 1. Will squash patch 
1 and this patch into one patch

in next version.

>
>>>> Signed-off-by: Hemant Kumar <quic_hemantk@quicinc.com>
>>>> Signed-off-by: Lazarus Motha <quic_lmotha@quicinc.com>
>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>> ---
>>>>    drivers/bus/mhi/host/main.c | 13 +++++--------
>>>>    1 file changed, 5 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>>> index 33f27e2..d7abd0b 100644
>>>> --- a/drivers/bus/mhi/host/main.c
>>>> +++ b/drivers/bus/mhi/host/main.c
>>>> @@ -1128,17 +1128,15 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
>>>>    	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
>>>>    		return -EIO;
>>>> -	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
>>>> -
>>>>    	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
>>>> -	if (unlikely(ret)) {
>>>> -		ret = -EAGAIN;
>>>> -		goto exit_unlock;
>>>> -	}
>>>> +	if (unlikely(ret))
>>>> +		return -EAGAIN;
>>>>    	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf_info, mflags);
>>>>    	if (unlikely(ret))
>>>> -		goto exit_unlock;
>>>> +		return ret;
>>>> +
>>>> +	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
>>>>    	/* Packet is queued, take a usage ref to exit M3 if necessary
>>>>    	 * for host->device buffer, balanced put is done on buffer completion
>>>> @@ -1158,7 +1156,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
>>>>    	if (dir == DMA_FROM_DEVICE)
>>>>    		mhi_cntrl->runtime_put(mhi_cntrl);
>>>> -exit_unlock:
>>>>    	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
>>>>    	return ret;
>>>> -- 
>>>> 2.7.4
>>>>
>>>>
