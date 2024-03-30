Return-Path: <linux-kernel+bounces-126118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE1893265
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC4FB22275
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4137146001;
	Sun, 31 Mar 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dr+wzPEV"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B136145B3D;
	Sun, 31 Mar 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900976; cv=pass; b=Nts6yA2eZKGNdTY/dAw4Zp1FZHh0LNkoKkeSrv+rOcDCylL4w6GE0BNyS3G5nY2PZN+0PUfwt6ewFiZFxfz5zUmSbPNREmjQjBC1t9kKhdJgPbyiwVZeE0myONb1XQ1tyA8IhlX0W1RdkApxJjcDKWmXys5VCV6M79E1jSs46M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900976; c=relaxed/simple;
	bh=zZiTRe3m3NLbb+/Qp3yvgOHwujhfgKPzWdst81UulPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GksRrYPqJuZv115Edm/g6dk33T3wI6VYFELc/WV8YZ1CEzGFcmR6DVZZzvlRcyDUGJrK13JDFw0FPbOaSHQc71gf5DNTDGwo7IwhjPSNcqWy4oWLnOYw8wHAMkRCrDp/g4ML3K4z/zeckFb5BmoxKOU3/MRo1BhG5QTq3djUR84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dr+wzPEV; arc=none smtp.client-ip=205.220.180.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C7427208CE;
	Sun, 31 Mar 2024 18:02:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZY3A73DUWGeU; Sun, 31 Mar 2024 18:02:53 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DE374208C7;
	Sun, 31 Mar 2024 18:02:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DE374208C7
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id CEDE0800055;
	Sun, 31 Mar 2024 18:02:52 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:02:52 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:44 +0000
X-sender: <linux-kernel+bounces-125641-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAxTtrGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKADkAAADXigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 19552
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125641-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7EFFC200BC
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790030; cv=none; b=lXU7Ekz5ncEDY/O9Boxjk5W+HMOOIeuSlYhhKi0CBZ/qUPspQ6Olg6S1qxV01F6VpVfqpKXOjrPe2Z8z7TFdsQlZXBRmwUkDtFdBlBvmasbPLpNDSdZ2YaeSuLkpWruig/HewhILtxGlhwVA3FWgdXK+pKVdSaek6zpCLqFzqhM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790030; c=relaxed/simple;
	bh=zZiTRe3m3NLbb+/Qp3yvgOHwujhfgKPzWdst81UulPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AMVPkQvKsvsggWlW2CXCR3/fJ8JDxZVGvlQ+uI3gMzYJx0cgJieHXKtCyJhx8DIgKz2I6NJcfqSkXX/cLd+lNtKDc0ulcDcP7hKb8701hkd1v3sYeB2zC3pOuZjAs8SXPxjDDCR5nl2cCijUt/VrjzdrY8Pu+y6/5LfYcG5zJ4c=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dr+wzPEV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FhEb9K/BxdRk2okMHgeAtJuKVJhrSJebpoCQp1OmvdQ=; b=Dr
	+wzPEVwH7l3fpu5u9f0GQkCoTKNTSvm9ud24uR2CqFOkLT4jY/d1iNvdwK/gfikA
	MVhUZA/vXCcPd4tqHknfRWldfxOHAqyiz5eHDY6o9ua2iLkpneM0VwUkFef4KtIy
	U76UI5UQbdeDzKGxOMkDfKlOTNJF+2pAlDraJK+JPGlm7wz72lr+WCKpAiJnevvd
	AsZZeF9BI0+wrycErZrjVIPFubolxEwYTO2hFV1YfbVds5kmhSLIc/DAHr3IEz6o
	OvuEROLpFpa9K8qKLd1ckvoNCx3cPtZcgvR3dija5av+XnoW/vg93pm/vQbx4a36
	JZq1TgXVwPzht7KwoTIw==
Message-ID: <6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com>
Date: Sat, 30 Mar 2024 14:43:07 +0530
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Add gpio-usb-c-connector compatible
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miquel
 Raynal" <miquel.raynal@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Bjorn Helgaas" <bhelgaas@google.com>, Kyle Tso <kyletso@google.com>,
        Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
 <CAA8EJpqx+VFW8z6oG=+pnhPN97Q3R6z+ygf85Uspve-9syQsUw@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJpqx+VFW8z6oG=+pnhPN97Q3R6z+ygf85Uspve-9syQsUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w9l_gJ3vqg3mZzBvIWmjhsf3kITwbXlG
X-Proofpoint-ORIG-GUID: w9l_gJ3vqg3mZzBvIWmjhsf3kITwbXlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_05,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403300075
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10



On 3/29/2024 6:23 PM, Dmitry Baryshkov wrote:
> On Fri, 29 Mar 2024 at 09:20, Krishna Kurapati
> <quic_kriskura@quicinc.com> wrote:
>>
>> QDU1000 IDP [1] has a Type-c connector and supports USB 3.0.
>> However it relies on usb-conn-gpio driver to read the vbus and id
>> gpio's and provide role switch. However the driver currently has
>> only gpio-b-connector compatible present in ID table. Adding that
>> in DT would mean that the device supports Type-B connector and not
>> Type-c connector. Thanks to Dmitry Baryshkov for pointing it out [2].
> 
> USB-B connector is pretty simple, it really has just an ID pin and
> VBUS input, which translates to two GPIOs being routed from the
> _connector_ itself.
> 
> USB-C is much more complicated, it has two CC pins and a VBus power
> pin. It is not enough just to measure CC pin levels. Moreover,
> properly handling USB 3.0 inside a USB-C connector requires a separate
> 'orientation' signal to tell the host which two lanes must be used for
> the USB SS signals. Thus it is no longer possible to route just two
> pins from the connector to the SoC.
> 
> Having all that in mind, I suspect that you are not describing your
> hardware properly. I suppose that you have a Type-C port controller /
> redriver / switch, which handles CC lines communication and then
> provides ID / VBUS signals to the host. In such a case, please
> describe this TCPC in the DT file and use its compatible string
> instead of "gpio-c-connector".
> 

Hi Dmitry,

  My bad. I must have provided more details of the HW.

  I presume you are referring to addition of a connector node, type-c 
switch, pmic-glink and other remote endpoints like in other SoC's like 
SM8450/ SM8550/ SM8650.

  This HW is slightly different. It has a Uni Phy for Super speed and 
hence no DP.

  For orientation switching, on mobile SoC's, there is a provision for 
orientation gpio given in pmic-glink node and is handled in ucsi_glink 
driver. But on this version of HW, there is a USB-C Switch with its own 
firmware taking care of orientation switching. It takes 8 SS Lines and 2 
CC lines coming from connector as input and gives out 4 SS Lines (SS 
TX1/TX2 RX1/RX2) as output which go to the SoC. So orientation switch is 
done by the USB-C-switch in between and it automatically routes 
appropriate active SS Lane from connector to the SoC.

  As usual like in other targets, the DP and DM lines from type-c 
connector go to the SoC directly.

  To handle role switch, the VBUS and ID Pin connections are given to 
SoC as well. There is a vbus controller regulator present to provide 
vbus to connected peripherals in host mode.

  There is no PPM entity (ADSP in mobile SoC's) and no UCSI involved 
here. Hence we rely on usb-conn-gpio to read the vbus/id and switch 
roles accordingly.

  Hope this answers the query as to why we wanted to use usb-conn-gpio 
and why we were trying to add a new compatible.

Regards,
Krishna,

>>
>> This series intends to add that compatible in driver and bindings
>> so that it can be used in QDU1000 IDP DT.
>>
>> [1]: https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@quicinc.com/
>> [2]: https://lore.kernel.org/all/CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com/
>>
>> Krishna Kurapati (2):
>>    dt-bindings: connector: Add gpio-usb-c-connector compatible
>>    usb: common: usb-conn-gpio: Update ID table to add usb-c connector
>>
>>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 3 +++
>>   drivers/usb/common/usb-conn-gpio.c                             | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> --
>> 2.34.1
>>
> 
> 
> --
> With best wishes
> Dmitry


