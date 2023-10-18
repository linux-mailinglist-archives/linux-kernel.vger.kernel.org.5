Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7257CE918
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjJRUfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbjJRUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:33:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A70D1AA;
        Wed, 18 Oct 2023 13:33:43 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IKXGjj008745;
        Wed, 18 Oct 2023 20:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D3VEipluic1dnj4xaArrQ04lPUUz9iyghjTrQJeu5aE=;
 b=HYRGvFZRbv9ZGlNVYgJ0bbpCQaouRJDG5GUWgOJMv8bbGAA6WVtbowAcpNgL1UIXgMf/
 y50Q2HXtqKrGtoRkoxHIGNsZg/KRUx82bSURxVn8GlnUD0hKAcef5jIg57jToidW83gF
 /23UwY9CiDh7BiNTTijZl9a34YGWQ7NBq3xASPduJKSoMFsA5GOq1lSfQ8TxdTEIYPQn
 cXWTcYUbJj4i8e1TttKiXXDIs5icR3UvmFXC1k1Os16QVfcmoYhq+/UkLdWcODIbv4VC
 rZDmGV+KbdLAT5Oy0EFnJMxKBjKtJNrYMdvFh2KPyoUOMlIul2f9XJ5ladpkYnZf9jwh fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttb7ahrvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:33:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IKXPdM003412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:33:25 GMT
Received: from [10.110.123.255] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 13:33:24 -0700
Message-ID: <09bf52fe-0234-3fc6-1911-9d0f8217d8ad@quicinc.com>
Date:   Wed, 18 Oct 2023 13:33:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 21/34] ASoC: usb: Add PCM format check API for USB
 backend
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-22-quic_wcheng@quicinc.com>
 <dbb1f64b-8112-4a2f-9138-616e04bdc53c@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <dbb1f64b-8112-4a2f-9138-616e04bdc53c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GnQCwHKt7WkSwgc5_0rgRzLNxfyB9Hpg
X-Proofpoint-GUID: GnQCwHKt7WkSwgc5_0rgRzLNxfyB9Hpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=727 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180169
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 10/17/2023 3:33 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/17/23 15:00, Wesley Cheng wrote:
>> Introduce a check for if a particular PCM format is supported by the USB
> 
> Introduce a helper to check if a ...
> 

Ack.

>> audio device connected.  If the USB audio device does not have an audio
>> profile which can support the requested format, then notify the USB
>> backend.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   include/sound/soc-usb.h |  3 +++
>>   sound/soc/soc-usb.c     | 13 +++++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
>> index 58c686f4f7ba..c6ddc055c4cd 100644
>> --- a/include/sound/soc-usb.h
>> +++ b/include/sound/soc-usb.h
>> @@ -37,6 +37,9 @@ struct snd_soc_usb {
>>   	void *priv_data;
>>   };
>>   
>> +int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
>> +			int direction);
>> +
>>   int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
>>   int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
>>   void *snd_soc_usb_find_priv_data(struct device *usbdev);
>> diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
>> index 73b1bcc3b506..7407678a993e 100644
>> --- a/sound/soc/soc-usb.c
>> +++ b/sound/soc/soc-usb.c
>> @@ -63,6 +63,19 @@ void *snd_soc_usb_find_priv_data(struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(snd_soc_usb_find_priv_data);
>>   
>> +int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
>> +			int direction)
>> +{
>> +	struct snd_usb_stream *as;
>> +
>> +	as = snd_usb_find_suppported_substream(card_idx, params, direction);
>> +	if (!as)
>> +		return -EOPNOTSUPP;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_find_format);
> 
> Is this the right way to check for formats?
> 
> formats are defined within the scope of an endpoint, and those endpoints
> are themselves defined within the scope of an interface?
> 
> I don't see a notion of endpoint here. Does this assume all endpoints
> are valid, or maybe the existence of a single endpoint in a device?
> 
> Confused.

At least in terms of USB and USB UAC, formats are defined within an 
audio streaming interface descriptor, which will include multiple (up to 
2) USB endpoints.  Those endpoints will be described w/ both an audio 
streaming endpoint descriptor as well as a standard USB endpoint 
descriptor.  The audio interface/format descriptors are the ones that 
carry the information about what formats are supported by the USB 
device.  So this API finds a possible USB AS streaming descriptor on the 
device that matches the requested one.  Endpoints will be opened 
subsequently when the audio stream is started, and an interface is 
enabled by sending a SET_INTERFACE control packet on the USB bus.

Thanks
Wesley Cheng
