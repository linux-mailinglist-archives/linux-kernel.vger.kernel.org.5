Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0117D7801
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjJYWcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYWcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:32:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1890;
        Wed, 25 Oct 2023 15:32:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PMRckh018217;
        Wed, 25 Oct 2023 22:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0bQFa/OqIcYnNhxbQluyp0FpYS66aD/rqg1j1yF4XKw=;
 b=ijeFRrAL554HbPROVtgWMr342xAc9G3Hb0rAtbzazIeiS1eg43uNeJ5NNvthovYmO1bC
 PbwBEMKg8RwEfBd4KRmSynJ6HsadqSD0aP6JRwG41tKmTEPkLWN07zpX90f5OC/1iVc8
 AuQjJZYAYakQJru8MAWTjJPPSKMr+zN+QfpdTNMneESElujSicMhcJTYobkPp1qKPymj
 VQm+TYJ3AAzEOiKQXMJPDw6HXPHSoOiOSXts2wv4QLyq950/WmSY89YWpssdS2GFWX/A
 bxyLjkgkjbbyWhdodpk4n7LuczyQGKSPtkCtE7tp+/lGrmcWN8ctgfQLXgB8WDj20mRx eA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txwjphvea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 22:31:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PMVsJe024992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 22:31:54 GMT
Received: from [10.71.114.19] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 15:31:53 -0700
Message-ID: <dc14cce6-7967-9992-c552-00fd043b0445@quicinc.com>
Date:   Wed, 25 Oct 2023 15:31:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 34/34] ASoC: usb: Rediscover USB SND devices on USB
 port add
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
 <20231017200109.11407-35-quic_wcheng@quicinc.com>
 <b503058d-e23f-4a63-99b8-f0a62b2a2557@linux.intel.com>
 <6409c486-7393-4352-489c-ecd488597c4c@quicinc.com>
 <efa9cdd0-4e5b-4b54-a4ea-7ec735224f44@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <efa9cdd0-4e5b-4b54-a4ea-7ec735224f44@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 14nEvn4zNDoYq68xWCflDzpsII9GKJ3J
X-Proofpoint-GUID: 14nEvn4zNDoYq68xWCflDzpsII9GKJ3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_12,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250193
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

On 10/24/2023 6:35 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/23/23 16:54, Wesley Cheng wrote:
>> Hi Pierre,
>>
>> On 10/17/2023 4:11 PM, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 10/17/23 15:01, Wesley Cheng wrote:
>>>> In case the USB backend device has not been initialized/probed, USB SND
>>>> device connections can still occur.  When the USB backend is eventually
>>>> made available, previous USB SND device connections are not
>>>> communicated to
>>>> the USB backend.  Call snd_usb_rediscover_devices() to generate the
>>>> connect
>>>> callbacks for all USB SND devices connected.  This will allow for the
>>>> USB
>>>> backend to be updated with the current set of devices available.
>>>>
>>>> The chip array entries are all populated and removed while under the
>>>> register_mutex, so going over potential race conditions:
>>>>
>>>> Thread#1:
>>>>     q6usb_component_probe()
>>>>       --> snd_soc_usb_add_port()
>>>>         --> snd_usb_rediscover_devices()
>>>>           --> mutex_lock(register_mutex)
>>>>
>>>> Thread#2
>>>>     --> usb_audio_disconnect()
>>>>       --> mutex_lock(register_mutex)
>>>>
>>>> So either thread#1 or thread#2 will complete first.  If
>>>>
>>>> Thread#1 completes before thread#2:
>>>>     SOC USB will notify DPCM backend of the device connection.  Shortly
>>>>     after, once thread#2 runs, we will get a disconnect event for the
>>>>     connected device.
>>>>
>>>> Thread#2 completes before thread#1:
>>>>     Then during snd_usb_rediscover_devices() it won't notify of any
>>>>     connection for that particular chip index.
>>> Looks like you are assuming the regular USB audio stuff is probed first?
>>>
>>> What if it's not the case? Have you tested with a manual 'blacklist' and
>>> "modprobe" sequence long after all the DSP stuff is initialized?
>>>
>>> It really reminds me of audio+display issues, and the same opens apply
>>> IMHO.
>>
>> Not necessarily...if the USB audio driver is not probed, then that is
>> the same scenario as when there is no USB audio capable device plugged
>> in, while the offload path is waiting for the connect event. I think
>> this is the standard scenario.
>>
>> In the situation where the platform sound card hasn't probed yet and USB
>> audio devices are being identified, then that is basically the scenario
>> that would be more of an issue, since its USB SND that notifies of the
>> connection state (at the time of connect/disconnect).
> 
> Not following if this scenario is covered?
> 

Yes, this is covered.  For example, if there are already devices 
connected, but the platform sound card is still unbound.  Then this 
rediscover API will be called to traverse through the list of connected 
USB sound devices, so that the USB DPCM dai can know about their 
existence when it is probed.

>> I've tried with building these drivers as modules and probing them at
>> different times/sequences, and I haven't seen an issue so far.
> 
> The scenario I have in mind is this:
> 
> the platform driver is on the deny list, the USB driver detects a
> device. When the platform driver probes at a later time (with a manual
> modprobe to make delays really long), how would the notification be handled?
> 

So that is essentially the same scenario as when there is no USB device 
connected, ie no USB class driver is bounded to anything.  Since the 
notifications are all handled within USB SND (USB class driver) then if 
the module isn't loaded yet, no notification is sent to the DPCM USB 
backend.  Once you say...modprobe the USB SND driver, then the USB 
interface probe occurs, and that would issue the connect callback from 
the USB SND probe routine. (keep in mind these are not platform devices, 
we're working with devices under the usb bus)

> Between audio and display, we use the 'drm_audio_component' layer to
> model these sort of run-time binding between independent driver stacks.
> It's not used here but we need a moral equivalent, don't we?
> 
> It would really help if you documented a bit more the dependencies or
> timing assumptions, to make sure we have a stable solution to build on.
> 

I can add this to the RST that I'll make in detail, and add a summary 
here in the commit message.

Thanks
Wesley Cheng
