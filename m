Return-Path: <linux-kernel+bounces-159050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D430A8B28A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758AA1F211CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B971509AE;
	Thu, 25 Apr 2024 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TOgwzaAl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F214E2CC;
	Thu, 25 Apr 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071582; cv=none; b=IJFrliSOC/SR0Fl268EMd/7+mdImyuzO6zE28AR9ih2qFWZnBC5bPhfjy18+Ku2a3wL2ntWVMOetQZoccWWmHZe7UxbPZVnMlv/a1TXevb2/0T7Lb+wQi/YuXn1R7jkJDdl4vj1o+a0Blsq/txUOGUiVd6XxNj6EUNYed7BpJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071582; c=relaxed/simple;
	bh=W1jleSnAzaiTkRZrgdNKbc8caMPKFs8+4nzn+DPMNlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fLhzvy9lR908RPhViX+yBHNrmmRkLZatVYbdFzGw4k/p/1K7wEoD0GdqI8+flloMjAC9u96HefGaD4/d+KL3F3DXJv+PEW8pO6iTk+sPb6YAboZ6p5f/ggOPqZXmXJLdRWLIAQBo3n5/28/JRWCRFgosC4QEWw7ZI/UVVAKlE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TOgwzaAl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PEP8FO013847;
	Thu, 25 Apr 2024 18:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=W1jleSnAzaiTkRZrgdNKbc8caMPKFs8+4nzn+DPMNlw=; b=TO
	gwzaAl+F09iIn7kr8AsNWX/nRO7Gryl9chXZrysYrfdpJyqy5eT+plzotzwwWI3Z
	yDybu11dzKq8yACGyvhXIn/Ob/QCegiO2BCD49oq2RHwnX4sn8xuwT3xAuVeT0Ji
	ZI1KavkYVkHKtBgIHYjBwFohAps41JEMfcy5pDzTSmGp7tgP8ihwSZXSIolZzFyF
	y/4oRcpxK8U0iVYZwcM2UXb8plhTPMPCKAtoj7IUlF8yPiDMkifUKG7bF+elt+AG
	N45fZNEftehAgpx/dekJupq0c7jHfrsweYkTBvByY98fiws0CIbCeTuY9S30g3ZG
	yFVh1dEDhVuA8/EU9iAg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqrwwrng3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:59:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PIxZEQ030335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:59:35 GMT
Received: from [10.110.58.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 11:59:35 -0700
Message-ID: <22bfac62-5476-9e8f-e5a4-381cf5ae7a04@quicinc.com>
Date: Thu, 25 Apr 2024 11:59:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH0108
 and PMD8028 support
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_jprakash@quicinc.com>
References: <20240326220628.2392802-1-quic_amelende@quicinc.com>
 <20240326220628.2392802-3-quic_amelende@quicinc.com>
 <CAL_JsqLZkU_74JK-BGOe83-redCi_TcV3dOOZs9DX3jThHfXrw@mail.gmail.com>
From: Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CAL_JsqLZkU_74JK-BGOe83-redCi_TcV3dOOZs9DX3jThHfXrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mWJmo5NWXpS-fRBK6WbBb_4dnvZy3VwP
X-Proofpoint-ORIG-GUID: mWJmo5NWXpS-fRBK6WbBb_4dnvZy3VwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_19,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=681 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404250136

On 4/23/2024 10:02 AM, Rob Herring wrote:
> It took me a bit to find, but you've got a typo here. The result is
> this "if" schema is always true unless you actually have an instance
> with the typo too. Please send a fix.
Thanks for finding typo! Fix is here: https://lore.kernel.org/all/20240425185603.3295450-1-quic_amelende@quicinc.com/

