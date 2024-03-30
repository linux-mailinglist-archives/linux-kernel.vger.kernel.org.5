Return-Path: <linux-kernel+bounces-126258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B3189345A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D9F28445C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C9146D78;
	Sun, 31 Mar 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dr+wzPEV"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA163087;
	Sun, 31 Mar 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903371; cv=fail; b=SwI5by1+QxMzYPWxL/mcJgXCKmcwt0GQMxiJr9nlI4IuOBCs+J3SQ2j5ypfJsZ6BIpt3cahJeBeoTE9GFpnDOXPaGcDh//ssZuYD3zlZozGiF90I4qsKZIXDOYYSVFrrLlh5MSJWQ5l4DepPSa1/PXOKWgAc1kdkg/szj05kGRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903371; c=relaxed/simple;
	bh=N6u+CsXFjkW0UlfT+FcahFVFKJvPjZuvjC2ZqwEpeig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PYEnnv6hAQhbB0jld8N+UrHoEeEFhospT3TH1ZFIpUpnSPomwziY/SkkfYw6Ha3d8i+fYND8ZlWfHot+IZ0JdmmF5biAI4sLxpLMbr9mTI6bJ3x1CilMPPNgnhwxx7d1Dhk5mhTJnKVLFWyXmJO159KnT8MfEnoNatzawsl99FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=fail (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dr+wzPEV reason="signature verification failed"; arc=none smtp.client-ip=205.220.180.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A4C0620184;
	Sun, 31 Mar 2024 18:42:47 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MNFUPMJA_BgV; Sun, 31 Mar 2024 18:42:46 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 97C7D208B7;
	Sun, 31 Mar 2024 18:42:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 97C7D208B7
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 8A9B180005E;
	Sun, 31 Mar 2024 18:42:44 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:42:44 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:21 +0000
X-sender: <linux-usb+bounces-8666-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAq4OmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBFAAAA2IoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 19666
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=linux-usb+bounces-8666-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 8F24A2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dr+wzPEV"
X-Original-To: linux-usb@vger.kernel.org
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

X-sender: <linux-kernel+bounces-125641-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoAv4OmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 13255
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 10:14:29 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 10:14:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E63DC205ED
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 10:14:28 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=-2.751 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_NONE=-0.0001,
	SPF_HELO_NONE=0.001, SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=quicinc.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTXNbJLHTTqf for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 10:14:25 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125641-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7EFFC200BC
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7EFFC200BC
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 10:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E047B21C48
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115610782;
	Sat, 30 Mar 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dr+wzPEV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F04F9FF;
	Sat, 30 Mar 2024 09:13:47 +0000 (UTC)
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
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42U8lmLF013098;
	Sat, 30 Mar 2024 09:13:18 GMT
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
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x683s0vc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 09:13:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42U9DHR2016503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 09:13:17 GMT
Received: from [10.216.59.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 30 Mar
 2024 02:13:11 -0700
Message-ID: <6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com>
Date: Sat, 30 Mar 2024 14:43:07 +0530
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
Return-Path: linux-kernel+bounces-125641-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 09:14:28.9673
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 6663fb99-680d-4c2f-5ad7-08dc5099cd9e
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-01.secunet.de:TOTAL-FE=0.010|SMR=0.010(SMRPI=0.007(SMRPI-FrontendProxyAgent=0.007));2024-03-30T09:14:28.977Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 12710
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy



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


