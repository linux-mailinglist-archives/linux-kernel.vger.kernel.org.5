Return-Path: <linux-kernel+bounces-133280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6351089A1A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942EA1C23118
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5F0171069;
	Fri,  5 Apr 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WxdcJsFD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05E16EC0B;
	Fri,  5 Apr 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331905; cv=none; b=i9c/foE9T6DuBWbGrLLh0hDzEJ2+0VQdzbUB2x62qoxgHgcCGyzLIS/BwOOwHTjuHOhuWnFcFyArRai6Crz6bUQct8F4YAxnyorE5IhVJdMLXeBaLULa0sSG+evOGYVhgBK8QO0538BW2/xHQcsD0Vstm2awqTdV1nen7uDuRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331905; c=relaxed/simple;
	bh=aNurIvIombhEP1xBEnb9evF2NRW63iCEPSa4g7owfNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cJENER0EsKrNpiGpKbp5pO5rSHKPPa+xHgESocAGOjbcLlYltxgrQkfwQfaR/txYfLF/OJNOX/Vy34+a8NaP2T2y1Ug7UxN1TsnsZvq5DkSJl+Bg0EtjciqHAfp2yBEFjYeUTUWAFC9vmOxVras9Ak6ALHxs8yV5TVasW0Cyzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WxdcJsFD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435BXit4013624;
	Fri, 5 Apr 2024 15:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=aNurIvIombhEP1xBEnb9evF2NRW63iCEPSa4g7owfNA=; b=Wx
	dcJsFDCRtNjsx1myJLDZVvdn/7cpgyvGQmKM4gmeN14BiANU61bJDLndqGzyxPt4
	CZ5ahURTh5dAoHtI7YB679/F8PsF9OnPooNpYBGzAVu2w/r8NIkxLLLplZAheQuk
	86j2A/VzmlHqbGp586vrAzddTLisJ/OB/XN7ZpmSPSv2HnhSQhsC1w/fBnpXhtni
	cdTE5lTSKFW68MO8jGrsqWV5cYvQjAShaJy5xfOX5ysRo9um4Dwe2IEWYcYstSDa
	2n/3dr39zXpcTsjc5YhJUFAJSgINIu71VJB51TwPRLacUWQwTTfGTQ8f96LXEcRW
	G+8xdHH9r3ObcaokCL6Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xad7h10am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:44:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FiaHY013633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:44:36 GMT
Received: from [10.110.127.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:44:34 -0700
Message-ID: <7e23aaea-4840-4fc8-8472-e401a04493b5@quicinc.com>
Date: Fri, 5 Apr 2024 08:44:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/16] dt-bindings: net: wireless: describe the ath12k
 PCI module
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan
	<saravanak@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd
 Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marek
 Szyprowski <m.szyprowski@samsung.com>,
        Alex Elder <elder@linaro.org>,
        Srini
 Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Manivannan
 Sadhasivam <mani@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240325131624.26023-1-brgl@bgdev.pl>
 <20240325131624.26023-6-brgl@bgdev.pl> <87msqm8l6q.fsf@kernel.org>
 <CAMRc=MeCjNn7QdDrcQMuj32JFYoemQ6A8WOYcwKJo1YhDTfY+Q@mail.gmail.com>
 <87cyr440hr.fsf@kernel.org>
 <CAMRc=MdzhGxLNcNLWvRfqr0S9pey-iw964=AcYx_yDXgyDDjMA@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAMRc=MdzhGxLNcNLWvRfqr0S9pey-iw964=AcYx_yDXgyDDjMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JWcaCRTE3Ipb214CYpQmJ5B-avG_4z9q
X-Proofpoint-ORIG-GUID: JWcaCRTE3Ipb214CYpQmJ5B-avG_4z9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=770 clxscore=1015 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050112

On 4/5/2024 2:52 AM, Bartosz Golaszewski wrote:
> In addition to what Krzysztof already said about you seamingly
> confusing the maintenance of the driver vs maintenance of the
> device-tree bindings (IOW: structured hardware description) and in
> response to your question: I don't see any functional change to any
> dt-bindings neither from you nor from Jeff. Are you convinced you can
> maintain and properly review any changes?

Speaking just for myself, I know Bartosz is far more capable in this regard
than I am, so I'd expect him to be listed as a maintainer before me.

/jeff


