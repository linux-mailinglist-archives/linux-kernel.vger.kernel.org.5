Return-Path: <linux-kernel+bounces-57358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ACC84D774
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B11C22B54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428621A5AC;
	Thu,  8 Feb 2024 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WWVmrBsx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811741E4B0;
	Thu,  8 Feb 2024 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707354785; cv=none; b=quxn/KEETqgGrFFIw1OelLkZz4W8fwUpdq88OGSm8guAMMVP5dp5pYVX1MiySsvR0/Csce3pL09djleNWIZ8Ytx74VOE6nDiGIWO5g49A8VomCrtQsjEfebT5AMcJRbbl3g2LXHkn0J/PUlbKgv9lkm9UteTEk3GZ+GoS/cloG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707354785; c=relaxed/simple;
	bh=x9A1/FOA6EmR6w5mDa0Zp9L68DgWOGTw7oHs45qiSjI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Ozwt/iDVYdUz1J+qzzBSUZpaR3+iqYTNRJqCS6osyh/JjBMcNegHGuZTzS3e46ATttQsAQRK08B7lCfiC6pCbXgJ1piJPQu4BLeKZh8XG2G1VMe9lwxFYZhCiLfUuO3HrxfrBNlGhMCBpzvNEKZEMe4NNPB9NZJ1Z7imydCYoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WWVmrBsx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4180YrxR010052;
	Thu, 8 Feb 2024 01:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xVJk48w5NzPjZ+mnuBAfIYVhyNE714x3/Oi0jtM8iYg=; b=WW
	VmrBsx1WE9IJJ4fm/j4l9+1zv+WXdtKIo30djrC1GEzJY4V+LCATlpElr2xMiymz
	+Nt46JHYVZ1ANw5hphXkUCj90cRbrT6U5yHWiKmSf7zYOkAG6p8trGJV22oYAgW+
	zhxO6bRSrPlAKFqp6TqTLDZtLrwP0WQ0cmHlSqeMJx5HRYdRcb+VHN9ghUyjrQnM
	fqVC2u6yyebg9K+IQgJRAmqnxUfPkgA25G+jF9kUKd9ph/LjtmQQVWra/6AqsD1S
	Q2RoAy/OkdKPT1V9HVz6sfMRQqItvb2agVzh01jZlDKNrXjfoBmbkindBSiq0FTN
	9apQw71dOBD9kXWYoIeA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4425tbhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 01:12:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4181C2L5014533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 01:12:02 GMT
Received: from [10.110.36.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 17:12:01 -0800
Message-ID: <0cb39613-ec01-50aa-807f-b537f201dac0@quicinc.com>
Date: Wed, 7 Feb 2024 17:12:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v13 35/53] ALSA: usb-audio: Prevent starting of audio
 stream if in use
Content-Language: en-US
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: Takashi Iwai <tiwai@suse.de>
CC: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
 <20240203023645.31105-36-quic_wcheng@quicinc.com>
 <87y1bxvj0o.wl-tiwai@suse.de>
 <ef83036f-6605-1db3-d962-ac28a10711ac@quicinc.com>
 <877cjg7o0k.wl-tiwai@suse.de>
 <810161b3-4d98-755f-163f-fdfc9fe37063@quicinc.com>
In-Reply-To: <810161b3-4d98-755f-163f-fdfc9fe37063@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1qFXwgtLZiHWDEqASuuYCj_Qb9m6oVU8
X-Proofpoint-GUID: 1qFXwgtLZiHWDEqASuuYCj_Qb9m6oVU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_10,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=919 clxscore=1015 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080004

Hi Takashi,

On 2/7/2024 4:02 PM, Wesley Cheng wrote:
> Hi Takashi,
> 
> On 2/6/2024 11:05 PM, Takashi Iwai wrote:
>> On Wed, 07 Feb 2024 01:08:00 +0100,
>> Wesley Cheng wrote:
>>>
>>> Hi Takashi,
>>>
>>> On 2/6/2024 5:07 AM, Takashi Iwai wrote:
>>>> On Sat, 03 Feb 2024 03:36:27 +0100,
>>>> Wesley Cheng wrote:
>>>>>
>>>>> With USB audio offloading, an audio session is started from the ASoC
>>>>> platform sound card and PCM devices.  Likewise, the USB SND path is 
>>>>> still
>>>>> readily available for use, in case the non-offload path is 
>>>>> desired.  In
>>>>> order to prevent the two entities from attempting to use the USB bus,
>>>>> introduce a flag that determines when either paths are in use.
>>>>>
>>>>> If a PCM device is already in use, the check will return an error to
>>>>> userspace notifying that the stream is currently busy.  This 
>>>>> ensures that
>>>>> only one path is using the USB substream.
>>>>>
>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>
>>>> Hm, I'm not sure whether it's safe to hold chip->mutex there for the
>>>> long code path.  It even kicks off the auto-resume, which may call
>>>> various functions at resuming, and some of them may re-hold
>>>> chip->mutex.
>>>>
>>>
>>> That's a good point.
>>>
>>>> If it's only about the open flag, protect only the flag access with
>>>> the mutex, not covering the all open function.  At least the re-entry
>>>> can be avoided by that.
>>>>
>>>
>>> Sure, let me re-order the check/assignment and the mutex locking.
>>> Since this is now checked here in USB PCM and the QC offload driver,
>>> we want to make sure that if there was some application attempting to
>>> open both at the same time, we prevent any possible races.
>>>
>>> I think the best way to address this would be something like:
>>>
>>> static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
>>> {
>>> ...
>>>     mutex_lock(&chip->mutex);
>>>     if (subs->opened) {
>>>         mutex_unlock(&chip->mutex);
>>>         return -EBUSY;
>>>     }
>>>     subs->opened = 1;
>>>     mutex_unlock(&chip->mutex);
>>>
>>> //Execute bulk of PCM open routine
>>> ...
>>>     return 0;
>>>
>>> // If any errors are seen, unwind
>>> err_resume:
>>>     snd_usb_autosuspend(subs->stream->chip);
>>> err_open:
>>>     mutex_lock(&chip->mutex);
>>>     subs->opened = 0;
>>>     mutex_unlock(&chip->mutex);
>>>
>>>     return ret;
>>> }
>>>
>>> Set the opened flag first, so that if QC offload checks it, it can
>>> exit early and vice versa.  Otherwise, if we set the opened flag at
>>> the same position as the previous patch, we may be calling the other
>>> routines in parallel to the QC offload enable stream routine.  The
>>> only thing with this patch is that we'd need some error handling
>>> unwinding.
>>
>> The above is what I had in mind.
>>
>> But, thinking on this again, you might be able to get the same result
>> by using the ALSA PCM core substream open_mutex and hw_opened flag.
>> This is already held and set at snd_pcm_core() (the hw_opened flag is
>> set after open callback, though).  The offload driver can use those
>> instead of the own lock and flag, too, although it's not really
>> well-mannered behavior (hence you need proper comments).
>>
> 
> I think I had looked into this as well previously, and it was difficult 
> to achieve, because from the USB offloading perspective, we don't ever 
> call: snd_usb_pcm_open()
> 
> This is actually where we populate the pcm_substream parameter within 
> struct snd_usb_substream based on when userspace opens the USB SND PCM 
> device (which is not the case for offloading).  So the offload driver 
> doesn't have a way to fetch the struct snd_pcm that is allocated to the 
> PCM device created by the USB SND card.
> 

Sorry, took a look at it again, and found a way.  Although not pretty, 
we can access it using:
subs->stream->pcm->streams[direction].substream->hw_opened

Thanks
Wesley Cheng

