Return-Path: <linux-kernel+bounces-69487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538F858A39
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24898B24BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05F2149000;
	Fri, 16 Feb 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IWjmm4Fy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627E13541B;
	Fri, 16 Feb 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126621; cv=none; b=in8ry8XyP2kEVcx5t6ERUMB3R+JahJRyktlcDAB2BU5mehS18PvdF7whX+BEXg2mD+U5ANj5qqNF/0pe+RdAMJSvB7DifbdDmyq/0EwwnJLGmJs66sTWvVKRcOTZK9LU4TjJwOKEAoCoMGc9y6kTlsnhST9gNNS14CArq/AjFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126621; c=relaxed/simple;
	bh=zvtJ/goEXl78uXi/CkTnmJLWqFaobtHaj24advs/UyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SDaXe/pYFD1UrltM2mwhHzNQizi+hCLBWjuTTCh9sv8OEoSlrqzEdBuPvsy7HZGnsWcf31xyiyzOzTBhC+u3xQhk+n9CMp5Syizh3FG0kwUlZ7w4mTInOue7tJzFLpE4ynSvH+rI6wSykqoL/C1Cumv55/faIdsFUck7LZXwHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IWjmm4Fy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GN1RTd028772;
	Fri, 16 Feb 2024 23:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/Kp/ON2+FVNkC5NRIxIJBRrJsNuKYQMnRLjSnkzi+Oc=; b=IW
	jmm4FyOKbHvPh61NOvHsMMrtd1HY66gUjRUP/O6xukRSTaHnlf4SKxkRC0dURs+Z
	L2JrPGMKGmBlbZZ/1hM89XECcMRaYTYQUpI8a8mPE9RKiPo/WYx1SFs9XevK+Ery
	bimwm4hzXlYjnX6l3jXXUGhlgODN7Q5m0kcZBadF2UayYUmYhXAEGX/+O3q49Ya2
	jrNki28V2Rkg3UNzOdbAq5UNUSyT0FyAlvtmChAK3CWEQxrGxYbYnQPhW/C100cD
	UMZwP2E9R2E4WiP/wSozADmY4nsIuR/ZTHxOvgLqfD+eG9FWN02KVb/K2MYg0EJ+
	4D4BoxCeF8cW3lqejwFw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wabeerqhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 23:36:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GNaYJD020839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 23:36:34 GMT
Received: from [10.110.4.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 15:36:33 -0800
Message-ID: <03f71225-5450-a7c7-5f8c-9b275c1a37f1@quicinc.com>
Date: Fri, 16 Feb 2024 15:36:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v16 00/50] Introduce QC USB SND audio offloading support
Content-Language: en-US
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240216035923.23392-1-quic_wcheng@quicinc.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20240216035923.23392-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _EJn_PmWx1C-2tjP_V0vsB4c74ZlKlXO
X-Proofpoint-GUID: _EJn_PmWx1C-2tjP_V0vsB4c74ZlKlXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160185



On 2/15/2024 7:58 PM, Wesley Cheng wrote:
> Several Qualcomm based chipsets can support USB audio offloading to a
> dedicated audio DSP, which can take over issuing transfers to the USB
> host controller.  The intention is to reduce the load on the main
> processors in the SoC, and allow them to be placed into lower power modes.
> There are several parts to this design:
>    1. Adding ASoC binding layer
>    2. Create a USB backend for Q6DSP
>    3. Introduce XHCI interrupter support
>    4. Create vendor ops for the USB SND driver
> 
>        USB                          |            ASoC
> --------------------------------------------------------------------
>                                     |  _________________________
>                                     | |sm8250 platform card     |
>                                     | |_________________________|
>                                     |         |           |
>                                     |      ___V____   ____V____
>                                     |     |Q6USB   | |Q6AFE    |
>                                     |     |"codec" | |"cpu"    |
>                                     |     |________| |_________|
>                                     |         ^  ^        ^
>                                     |         |  |________|
>                                     |      ___V____    |
>                                     |     |SOC-USB |   |
>     ________       ________               |        |   |
>    |USB SND |<--->|QC offld|<------------>|________|   |
>    |(card.c)|     |        |<----------                |
>    |________|     |________|___     | |                |
>        ^               ^       |    | |    ____________V_________
>        |               |       |    | |   |APR/GLINK             |
>     __ V_______________V_____  |    | |   |______________________|
>    |USB SND (endpoint.c)     | |    | |              ^
>    |_________________________| |    | |              |
>                ^               |    | |   ___________V___________
>                |               |    | |->|audio DSP              |
>     ___________V_____________  |    |    |_______________________|
>    |XHCI HCD                 |<-    |
>    |_________________________|      |
> 
> 
> Adding ASoC binding layer:
> soc-usb: Intention is to treat a USB port similar to a headphone jack.
> The port is always present on the device, but cable/pin status can be
> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
> communicate with USB SND.
> 
> Create a USB backend for Q6DSP:
> q6usb: Basic backend driver that will be responsible for maintaining the
> resources needed to initiate a playback stream using the Q6DSP.  Will
> be the entity that checks to make sure the connected USB audio device
> supports the requested PCM format.  If it does not, the PCM open call will
> fail, and userpsace ALSA can take action accordingly.
> 
> Introduce XHCI interrupter support:
> XHCI HCD supports multiple interrupters, which allows for events to be routed
> to different event rings.  This is determined by "Interrupter Target" field
> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
> 
> Events in the offloading case will be routed to an event ring that is assigned
> to the audio DSP.
> 
> Create vendor ops for the USB SND driver:
> qc_audio_offload: This particular driver has several components associated
> with it:
> - QMI stream request handler
> - XHCI interrupter and resource management
> - audio DSP memory management
> 
> When the audio DSP wants to enable a playback stream, the request is first
> received by the ASoC platform sound card.  Depending on the selected route,
> ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
> will send an AFE port start command (with enabling the USB playback path), and
> the audio DSP will handle the request accordingly.
> 
> Part of the AFE USB port start handling will have an exchange of control
> messages using the QMI protocol.  The qc_audio_offload driver will populate the
> buffer information:
> - Event ring base address
> - EP transfer ring base address
> 
> and pass it along to the audio DSP.  All endpoint management will now be handed
> over to the DSP, and the main processor is not involved in transfers.
> 
> Overall, implementing this feature will still expose separate sound card and PCM
> devices for both the platorm card and USB audio device:
>   0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>                        SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>   1 [Audio          ]: USB-Audio - USB Audio
>                        Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed
> 
> This is to ensure that userspace ALSA entities can decide which route to take
> when executing the audio playback.  In the above, if card#1 is selected, then
> USB audio data will take the legacy path over the USB PCM drivers, etc...
> 
> This feature was validated using:
> - tinymix: set/enable the multimedia path to route to USB backend
> - tinyplay: issue playback on platform card
> 
> Changelog
> --------------------------------------------
> Changes in v16:
> - Modified some code layer dependencies so that soc usb can be split as a separate
>    module.
>    - Split the kcontrols from ASoC QCOM common layer into a separate driver
> - Reworked SOC USB kcontrols for controlling card + pcm offload routing and status
>    so that there are individual controls for card and pcm devices.
> - Added a kcontrol remove API in SOC USB to remove the controls on the fly.  This
>    required to add some kcontrol management to SOC USB.
> - Removed the disconnect work and workqueue for the QC USB offload as it is not
>    required, since QMI interface driver ensures events are handled in its own WQ.
> 

Sorry for sending a bad series.  Please ignore this version, as its 
missing some changes made.  Will resend as v17.

Thanks
Wesley Cheng

