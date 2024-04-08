Return-Path: <linux-kernel+bounces-135931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834C89CD38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E39283E74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA7148835;
	Mon,  8 Apr 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YbtLE+/O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCB147C6D;
	Mon,  8 Apr 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610544; cv=none; b=OZk9VFAZ2u6fxhJ3gB5hm867QXZ8pHP8QKha2ZCwkT5RZZ4bF1nCxKpPVa5v0FMlj4uvs1WF2dH/tnTGkdZFQAD7jKOMKqhy4bsmJdprHCHtlucnJ8pgRTrTn48vhHMFd+EQyeGtcFh+f0YHsBU2wAGvFaLmPiVLpRL5NX6KzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610544; c=relaxed/simple;
	bh=wfTZT5SpEZFUpySIG2Jh4yfcuf+pABe9fL7mPC4B+co=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fPwUNqhwdF/8nPrE7L5XSzng1gDjY5xaEQTg5f+H/1L9mSzlj/441lZpEIZMvfgrefr4AVdtZQ3R8ZTB59CUK041oewxvC+B0zz4fS218sJZAIXLt4GsPzN6znuZPG36Sz7RTVrLnUCzxn5YVTAsCYCYRPcBEmtuDY7GMaWRcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YbtLE+/O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438KTIdL029154;
	Mon, 8 Apr 2024 21:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DqxIk1V1v4JeK29xmds8hYaX8RXaQn1HmtY9KAfza1Y=; b=Yb
	tLE+/OHSvSLa2X0+4CskXApWRsX7ltRMPH2J11CoHLXTCixABs1QarFCqARPDAVf
	8RwHG9cProXj5k1Yo6ADwD2XDp1OtP+cTwCoj8m1a/p0UVOkt0I9hVs0pvGZ1X4P
	zhPyvcuoO+1VcXcKLcmC+G0lxv7StnsGhzycTmgS53r2guA74bSl+vR9zg99CBR1
	Juva4ZCjaBfMdsrWz4t2GET7OH6FtcQ9JusMhQ0lB5cb7QZ7je0IetWOIQbFg8aE
	gRiN6+FlnFXoVb+gVwe22dtN9bl4vTUv1G4o3Z5p7DdUxbJHWMGv5TupNqQ/Iix8
	E/6QDMqjWlMDlWj6oC6w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg2sujh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 21:08:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438L8nXi011985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 21:08:49 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 14:08:48 -0700
Message-ID: <b7ed299d-4cf7-8829-fd7f-e518aef05fb2@quicinc.com>
Date: Mon, 8 Apr 2024 14:08:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/msm/dp: call dp_hpd_plug_handle()/unplug_handle()
 directly for external HPD
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Sean Paul
	<sean@poorly.run>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_jesszhan@quicinc.com>,
        <quic_bjorande@quicinc.com>, <johan@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240406031548.25829-1-quic_abhinavk@quicinc.com>
 <ale6wbwzkfagcg2q6glb4vsxu3pthhkk3tquv2ixlatbdryqvh@xscsq2h6emho>
 <01cb1c0d-a801-37f9-2f55-2bbd8d3a68b9@quicinc.com>
 <k7f22hyltul4h4o4vqe6prc2yx3mm2q4dzk66j3xrsdpdtqllb@3c6ul4fpimwz>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <k7f22hyltul4h4o4vqe6prc2yx3mm2q4dzk66j3xrsdpdtqllb@3c6ul4fpimwz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aJrDRQIIij3iCRMFqeQcq4BXfIBIAjNI
X-Proofpoint-GUID: aJrDRQIIij3iCRMFqeQcq4BXfIBIAjNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080162



On 4/8/2024 1:41 PM, Bjorn Andersson wrote:
> On Mon, Apr 08, 2024 at 12:43:34PM -0700, Abhinav Kumar wrote:
>>
>>
>> On 4/7/2024 11:48 AM, Bjorn Andersson wrote:
>>> On Fri, Apr 05, 2024 at 08:15:47PM -0700, Abhinav Kumar wrote:
>>>> From: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> [..]
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index d80f89581760..bfb6dfff27e8 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -1665,7 +1665,7 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>>>>    		return;
>>>>    	if (!dp_display->link_ready && status == connector_status_connected)
>>>> -		dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
>>>> +		dp_hpd_plug_handle(dp, 0);
>>>
>>> If I read the code correctly, and we get an external connect event
>>> inbetween a previous disconnect and the related disable call, this
>>> should result in a PLUG_INT being injected into the queue still.
>>>
>>> Will that not cause the same problem?
>>>
>>> Regards,
>>> Bjorn
>>>
>>
>> Yes, your observation is correct and I had asked the same question to kuogee
>> before taking over this change and posting.
>>
>> We will have to handle that case separately. I don't have a good solution
>> yet for it without requiring further rework or we drop the below snippet.
>>
>>          if (state == ST_DISCONNECT_PENDING) {
>>                  /* wait until ST_DISCONNECTED */
>>                  dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
>>                  mutex_unlock(&dp->event_mutex);
>>                  return 0;
>>          }
>>
>> I will need sometime to address that use-case as I need to see if we can
>> handle that better and then drop the the DISCONNECT_PENDING state to address
>> this fully. But it needs more testing.
>>
>> But, we will need this patch anyway because without this we will not be able
>> to fix even the most regular and commonly seen case of basic
>> connect/disconnect receiving complementary events.
>>
> 
> I did some more testing on this patch. Connecting and disconnecting the
> cable while in fbcon works reliably, except for:

Thanks for the tests !

> - edid/modes are not read before we bring up the link so I always end up
>    with 640x480
> 

hmmm, I wonder why this should be affected due to this patch. We always 
read the EDID during hpd_connect() and the selected resolution will be 
programmed with the modeset. We will retry this with our x1e80100 and see.

> - if I run modetest -s <id>:<mode> the link is brought up with the new
>    resolution and I get my test image on the screen.
>    But as we're shutting down the link for the resolution chance I end up
>    in dp_bridge_hpd_notify() with link_ready && state = disconnected.
>    This triggers an unplug which hangs on the event_mutex, such that as
>    soon as I get the test image, the state machine enters
>    DISCONNECT_PENDING. This is immediately followed by another
>    !link_ready && status = connected, which attempts to perform the plug
>    operation, but as we're in DISCONNECT_PENDING this is posted on the
>    event queue. From there I get a log entry from my PLUG_INT, every
>    100ms stating that we're still in DISCONNECT_PENDING. If I exit
>    modetest the screen goes black, and no new mode can be selected,
>    because we're in DISCONNECT_PENDING. The only way out is to disconnect
>    the cable to complete the DISCONNECT_PENDING.
> 

I am going to run this test-case and see what we can do.

> Regards,
> Bjorn
> 
>>
>>>>    	else if (dp_display->link_ready && status == connector_status_disconnected)
>>>> -		dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
>>>> +		dp_hpd_unplug_handle(dp, 0);
>>>>    }
>>>> -- 
>>>> 2.43.2
>>>>

