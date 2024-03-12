Return-Path: <linux-kernel+bounces-100406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A187970A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF62B21C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950B37C084;
	Tue, 12 Mar 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nLiwURvL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282A6FB9;
	Tue, 12 Mar 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255727; cv=none; b=MToSoO4KrYWmcaUjOzQWWyGZ7iPEQVDvlx3Qg1u4Oj0IsrH21MJHc6pPoR0xIjSQnGW9Un7MKAr0yd+cSePStDF+RhArqyXOlzObtDjvEljtLFlaCK03DaWMVPFqJaj5ZrGIPY8Vb58Iyr/EfU1TFUqm2ceUpuA0PG0gsMhIXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255727; c=relaxed/simple;
	bh=+2b6ed3F/KPCOCDW0fG1OdfwFqw9j+nnEkaHGDQ6eqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xy18ZPhFu1iZGnIGBxvwryfd0aHhwoVwrHVrBj5G56gK9dJeT8lOhrR2VTNALTee921dHZulkD1O0g8ZleIxInacpJIXE4RwiU6zwVaynJ/NzVFVLp9sqIm2dQpGFgtDbbycBKtdCoH+ulpw7vbwEugqZXH0V3xN0zDjG4hILTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nLiwURvL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CAvwvU021211;
	Tue, 12 Mar 2024 15:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qXoAYhHKfTUJsSlgTVytqgymms4yVPOoUBmHB7FY+F0=; b=nL
	iwURvLXZXJMQX43Y0kLb4lxaEVl8xGwk4s2N7OzlDJttEtuNqvGVFCiH1DPAO6U1
	HBi3VyogXhHLXifL1Cmq/2I6WApVFRuuJmymnrcM+NOL9+GmO14oHXBFAtc9B2Hj
	xB2xvLxuZnkvonoVIKfVHKnZt+GwIhzdISZcO80evlqsfviPU/SUuslxA+tpMgz4
	7WZShHjlWT+cSutPJudqzJO/ZV4rG7Aw7oc4HAx84Zk9Yek4l7dfneQNjM8a/VGa
	5sM5gtP+Bm3itHOc7h0lsfp3+/77HAqHZL5d9Aapkrp+fPEVVKVcmUzHFUhdJ78G
	Qolz6ktpyqu9s/UOn0xQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtjef0xs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 15:01:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CF1wAS026791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 15:01:58 GMT
Received: from [10.251.45.43] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 08:01:55 -0700
Message-ID: <b852d178-dfb6-47fb-a5bf-55b614cbfae3@quicinc.com>
Date: Tue, 12 Mar 2024 17:01:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] media: qcom: camss: Add per sub-device type resources
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
References: <20240227122415.491-1-quic_grosikop@quicinc.com>
 <20240227122415.491-2-quic_grosikop@quicinc.com>
 <9af62237-98ec-4130-8523-f6c9cb0ad281@linaro.org>
From: "Gjorgji Rosikopulos (Consultant)" <quic_grosikop@quicinc.com>
In-Reply-To: <9af62237-98ec-4130-8523-f6c9cb0ad281@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LGqLkHqDYaoPEJxN4hAgfQ_V7MvdLw0y
X-Proofpoint-GUID: LGqLkHqDYaoPEJxN4hAgfQ_V7MvdLw0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120115

Hi Konrad,

Thank you for the review.

On 3/12/2024 4:44 PM, Konrad Dybcio wrote:
> 
> 
> On 2/27/24 13:24, Gjorgji Rosikopulos wrote:
>> From: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
>>
>> Currently resources structure grows with additional parameters
>> required for
>> each sub-deivce. However each sub-device has some specific resources or
>> configurations which need to be passed during the initialization.
>>
>> This change adds per sub-device type structure to simplify the things
>> and removes the magical void pointer to hw_ops.
> 
> I'm not quite sure what the benefit here is, as opposed to simply
> extending <name>_device?
> 
> Generally, I think the driver state as of today is somewhat backwards..
> 
> We define a common set of resources, and then assign them subdev-specific
> ops, instead of defining the subdev and consuming clocks/pds/resets
> within a subdevice there..

In the current code only ops are specific. However there are other
configurations passed to the sub-devices which are actually specific to
different sub-device, as an example:


1. is_lite flag. The lite flag is valid for csid and vfe but not for csiphy.

2. line_num this is valid only for vfe sub-device.

3. video device available formats. Those formats are only used by the
vfe sub-device and are not valid to other sub-devices which are not
having any video device connected, (those will be added in next patches
in the patch-set).

Please check the other changes in this patch-set maybe it will make more
sense.

I am not sure with such differences in the sub-device code we can have
generic structure which contains only ops...

And please note that when we are introducing new sub-device for other
SoC it may need additional specific configuration.


Regards,

~Gjorgji


