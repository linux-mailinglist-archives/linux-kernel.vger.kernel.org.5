Return-Path: <linux-kernel+bounces-156988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FEB8B0B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE278B27DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6C615E5BB;
	Wed, 24 Apr 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GczbsT6q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954515821F;
	Wed, 24 Apr 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965807; cv=none; b=BbToZHHV+dszMGQlPSWhUjqICgOZngo8UMQYDdv0kgSaG1O977+ks8LW7pvhzcG45cpyV0zkIbOBmU4fe+wfMOdyJJh6RA/GfHS1y7UDw98RoVTKVSweE+6KA6gskEIdk2bj8lqoLFgZlw4mua10j7/yWfz1YdwVuBSt0v1Z7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965807; c=relaxed/simple;
	bh=DuQNMPYJW6nVPPpUrxmyaaPSFytPiiZGOb8vuk7RtvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HkpDVlc4RBr4pdncUrzWKzYrEl92WFggN/2XZzSaA3wakbA2DsP6pSKVnpE00K3C989Ncm0EPtZDiKE5OHRv0fysz/2iaVL0vRP2C4ECFLK/ejMvaOSYyb0X5OQsrMD2FvXWysE1Ba6hPjh7or2MuswCdWYJN00FgbJQXfozO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GczbsT6q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6YePx004880;
	Wed, 24 Apr 2024 13:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oYniM3lBZJlijcpoHr5Avlp7PJZDsiyAWcS90aQaz2g=; b=Gc
	zbsT6qm1dxXj4F1fhsi090wTJ6mh+QDF7fCR1W4+Z97XnzeSNBGe82RwlBoVpVG6
	WHhkS8Z0OEBDf3Br1PmyFsfczHImg9jzsurJNr8vwNgG1X6hy6K87d5xiNgNxu7R
	OHmG8ZSI++80X6q9haS1eJgxPrRynAPqKrbLliMfdwmT59jihp7aq3jbusLmTdlh
	Tf7OgMkG1qCxYY36grEcWAsceOXCIJliODKY8U0zn6T6QAV082PAyRsh3vNn+unZ
	wCdkB/R98/BLPkP7Elis4mUW+QhwVGGiuqv2N/703swx8c02er2WnMjclkJTafTb
	Sxm8gW5ZeCy/p+NA7VTQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e0y2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:36:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ODacwR023204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:36:38 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 06:36:36 -0700
Message-ID: <97ecc6fc-6b0e-4028-ac06-1952f133bd2a@quicinc.com>
Date: Wed, 24 Apr 2024 21:36:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
 <CACMJSesZqCG=fdWe5C31a0iOFJ-ZpPRr70T_1TNLn7xqChZ4Sg@mail.gmail.com>
 <0e6bc9af-71f2-46b5-8b92-5da674b44ad7@quicinc.com>
 <a45016e9-1668-40eb-83a1-7a62162e319a@penguintechs.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <a45016e9-1668-40eb-83a1-7a62162e319a@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YEs_md7NkxeOFgCjzNTvvEsxMQQAy2Pp
X-Proofpoint-ORIG-GUID: YEs_md7NkxeOFgCjzNTvvEsxMQQAy2Pp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240046

On 4/24/2024 9:31 PM, Wren Turkal wrote:
> On 4/24/24 6:22 AM, quic_zijuhu wrote:
>> On 4/24/2024 9:18 PM, Bartosz Golaszewski wrote:
>>> On Wed, 24 Apr 2024 at 15:10, Wren Turkal <wt@penguintechs.org> wrote:
>>>>
>>>> On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Any return value from gpiod_get_optional() other than a pointer to a
>>>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth:
>>>>> hci_qca:
>>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>>>> power_ctrl_enabled on NULL-pointer returned by
>>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on
>>>>> errors.
>>>>> While at it: also bail-out on error returned when trying to get the
>>>>> "swctrl" GPIO.
>>>>>
>>>>> Reported-by: Wren Turkal<wt@penguintechs.org>
>>>>> Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
>>>>> Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use
>>>>> IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>>> Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>
>>>> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>>>>
>>>>
>>>> Like this?
>>>
>>> Yes, awesome, thanks.
>>>
>>> This is how reviewing works too in the kernel, look at what Krzysztof
>>> did under v1, he just wrote:
>>>
>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>
>> v1 have obvious something wrong as i pointed and verified.
>> so i think it is not suitable to attach v1's review-by tag to v2 anyway.
> 
> @Zijun, your concern is that current DTs may not define the gpio and
> this will cause the bluetooth not to work?
> 
> Would that not more appropriately be fixed by machine-specific fixups
> for the DT?
> 
for lunched production, it is difficult or not possible to change such
config.

>>
>>> And mailing list tools will pick it up.
>>>
>>> Bartosz
>>
> 


