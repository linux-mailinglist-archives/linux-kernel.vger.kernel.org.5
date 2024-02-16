Return-Path: <linux-kernel+bounces-69489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D857858A49
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5F1F21983
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF20149012;
	Fri, 16 Feb 2024 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ixKeYUkr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22D1487FB;
	Fri, 16 Feb 2024 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126962; cv=none; b=PtTyN0vinSq+7byfxOnD6sjrg+AmJf7y2IjgC/d7P9Ty5s0l032sjzV9ct2cj6mTvrHGrtjIFiP+gIpa9iJkzchkJNRJ/8RkuelbsQh09d0pevsX43npUTFwo70pFJ+1nAAd3HdLE9onyuIXGuYReh7wMWDkv5zHu9+QmZJJmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126962; c=relaxed/simple;
	bh=0f/lJaE7np4wJ8qcvDWsKdx42xlbBpUAMwHfNk0De/o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Rk3AcB0DFM6h8Cvl+UQ+PHjG3OMuE7Wz3T0OvAPUCghPNidBLLeU8zeENHuFc+Bn8mjOzK6Ph81a/8FgEgibQxrbFZYAIf9kRYLq2WL072mJVrcZHTXhhKCvDEaahKiarCX/JWDb/4CEzW4Qr7anI2XYcX+eBg25b7uv/+swhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ixKeYUkr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GNSFHi016258;
	Fri, 16 Feb 2024 23:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6DgPpATQlh7NUJzNAI7b09ejSZYjTKm5C4iXiGLdzE0=; b=ix
	KeYUkr1x4Vikwhh4ln39sQcsjrNMfXDYMf2PypJH6ggyQqT3o0d3m6MQz6XRko+z
	l2xA+95N+jkvYOpnZhY4ak57lc57X7EqTKCAf/t0qnRJLG78352tsZEvxa3QPYPa
	36lGTzDC+VBKWbI9TPjiIrzf9u6Unr9eF8yd9Gnk5UWg6E5HTtYZuNwH+HEGEcCa
	GIJhEIXibTgNCm8yrZuqWR0z1VQiUsoVtCDaIXbqIcwuPUqckdcLxwqjawo1dRBS
	Z1rEft9f4qTZssAzbO9p/nsenPJvPwlHPctG7+BEejBihJQI0M20M6i3l2rljf2j
	BuW/YN5Z3p2RieKwwAOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wabeerqtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 23:42:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GNgK9G028271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 23:42:20 GMT
Received: from [10.110.4.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 15:42:18 -0800
Message-ID: <7f0c4f85-5a63-4643-8553-e3f5d6af67ec@quicinc.com>
Date: Fri, 16 Feb 2024 15:42:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v14 32/53] ALSA: usb-audio: Check for support for
 requested audio format
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
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
 <20240208231406.27397-33-quic_wcheng@quicinc.com>
 <87v86x2a27.wl-tiwai@suse.de>
 <cb3b7857-dc6c-80db-4fa7-6772a856f328@quicinc.com>
In-Reply-To: <cb3b7857-dc6c-80db-4fa7-6772a856f328@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GFCgtESozsNllTv87D_KsdZvPpRBjijJ
X-Proofpoint-GUID: GFCgtESozsNllTv87D_KsdZvPpRBjijJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=868 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160186

Hi Takashi,

On 2/9/2024 1:34 PM, Wesley Cheng wrote:
> Hi Takashi,
> 
> On 2/9/2024 2:42 AM, Takashi Iwai wrote:
>> On Fri, 09 Feb 2024 00:13:45 +0100,
>> Wesley Cheng wrote:
>>>
>>> Allow for checks on a specific USB audio device to see if a requested 
>>> PCM
>>> format is supported.  This is needed for support when playback is
>>> initiated by the ASoC USB backend path.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> ---
>>>   sound/usb/card.c | 31 +++++++++++++++++++++++++++++++
>>>   sound/usb/card.h | 11 +++++++++++
>>>   2 files changed, 42 insertions(+)
>>>
>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>> index 7dc8007ba839..1ad99a462038 100644
>>> --- a/sound/usb/card.c
>>> +++ b/sound/usb/card.c
>>> @@ -155,6 +155,37 @@ int snd_usb_unregister_platform_ops(void)
>>>   }
>>>   EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
>>> +/*
>>> + * Checks to see if requested audio profile, i.e sample rate, # of
>>> + * channels, etc... is supported by the substream associated to the
>>> + * USB audio device.
>>> + */
>>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>>> +            struct snd_pcm_hw_params *params, int direction)
>>> +{
>>> +    struct snd_usb_audio *chip;
>>> +    struct snd_usb_substream *subs;
>>> +    struct snd_usb_stream *as;
>>> +
>>> +    /*
>>> +     * Register mutex is held when populating and clearing usb_chip
>>> +     * array.
>>> +     */
>>> +    guard(mutex)(&register_mutex);
>>> +    chip = usb_chip[card_idx];
>>> +
>>> +    if (chip && enable[card_idx]) {
>>> +        list_for_each_entry(as, &chip->pcm_list, list) {
>>> +            subs = &as->substream[direction];
>>> +            if (snd_usb_find_substream_format(subs, params))
>>> +                return as;
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
>>> +
>>>   /*
>>>    * disconnect streams
>>>    * called from usb_audio_disconnect()
>>> diff --git a/sound/usb/card.h b/sound/usb/card.h
>>> index 02e4ea898db5..ed4a664e24e5 100644
>>> --- a/sound/usb/card.h
>>> +++ b/sound/usb/card.h
>>> @@ -217,4 +217,15 @@ struct snd_usb_platform_ops {
>>>   int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
>>>   int snd_usb_unregister_platform_ops(void);
>>> +
>>> +#if IS_ENABLED(CONFIG_SND_USB_AUDIO)
>>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>>> +            struct snd_pcm_hw_params *params, int direction);
>>> +#else
>>> +static struct snd_usb_stream *snd_usb_find_suppported_substream(int 
>>> card_idx,
>>> +            struct snd_pcm_hw_params *params, int direction)
>>> +{
>>> +    return NULL;
>>> +}
>>> +#endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
>>
>> The usefulness of ifdef guard here is doubtful, IMO.  This header is
>> only for USB-audio driver enablement, and not seen as generic
>> helpers.  So, just add the new function declarations without dummy
>> definitions.
>>
> 
> Got it, will remove it.  We also have a dependency in place for the 
> qc_audio_offload driver and SND USB AUDIO in the Kconfig.
> 

Looking at this again after trying some mixed Kconfig settings.  These 
declarations aren't specific for USB-audio.  They are helpers that are 
exposed to soc usb, so that it can do some basic verification with soc 
usb before allowing the enable stream to continue.  Since the ASoC layer 
doesn't have insight on what audio profiles are supported by the usb 
device, this API will ensure that the request profile is supported.

Issues are seen when we disable SND USB audio config and enable the ASoC 
parts.

Thanks
Wesley Cheng

