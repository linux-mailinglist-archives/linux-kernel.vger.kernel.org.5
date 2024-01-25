Return-Path: <linux-kernel+bounces-37981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A283B92B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8A9287AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192D1079D;
	Thu, 25 Jan 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gv6rVzxO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF7CA50;
	Thu, 25 Jan 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161788; cv=none; b=VgpXeVz7m8EAP/yWH/2lWs2iQ3DP5cpYlgOoidKjabjHkAZuuCgyaVmryDet/3NNUriYgB/mvXrIS7vRXiUe1nregARLZaNofrtthL/HadiK3rwVyPWOCTw06KQdcuoqYpnCKlFwJ4fj68kbBT6nZGaUKlulvi1xvPcNEtSCAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161788; c=relaxed/simple;
	bh=jEtOBCWHvTb4uHYP5yQCZ1yuaW6/UAwy+xaIHbriYL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O0uRb2o0zg3yRbsk8QFHR3Mp5czS24On7sF5CEVN26FwIhXz1tF57Ob2PhFgdke2BYLjk4uPSR3K+VJFPz6XfflnbQ2VE8c87fNntTKa5ndu+s39jqcKzJwmOYK945a/yjBgyoML/PzmCjRokttDK9Uq8anKN1cdviqrbLWmduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gv6rVzxO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5i5aT014826;
	Thu, 25 Jan 2024 05:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=P2TR27uCwnO+U4fKCMWikVRqcirqj04TH+FzUWx6064=; b=Gv
	6rVzxON7mjLI0yZUqypAExCs0cFXGZZXsRWTTEP5fZcmZbShhbDftxcvwBPDCR6s
	AOhDU8jrulH2xYxdNogw5VOjoKjDwHoQPwDDwsrIxVjHIJG37c2P/7oLo0vbZK4D
	QIVIZE7eaQuCOQooL9cgyvCKlXwIYrpljircnfGeiK4oERaelDtNwLisFjNO9Lt+
	1tPEyU4WtmDmUwJHbghmSTWyab1HvkXbxJE9pvL1Q5hxaWobcxcFhpOIm8ZGGh0Q
	JuRgaj6XMYDI/2doP37KrjC61eq3/1ABKF5mDpTGhtE2y6rxHH0ZwmkRkT7mp7Lf
	X5BOq+ACRKIV1LaGwu2w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vufc80976-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:49:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P5neqI002427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:49:40 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 21:49:34 -0800
Message-ID: <77903574-696b-90f9-f136-be5c5d219ba1@quicinc.com>
Date: Thu, 25 Jan 2024 11:19:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] clk: qcom: gcc-sm8150: Add gcc_parents_0_ao support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
References: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
 <20240123-gcc-ao-support-v1-2-6c18d5310874@quicinc.com>
 <d31a52fc-9073-483d-b84b-1f02a5698a89@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <d31a52fc-9073-483d-b84b-1f02a5698a89@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 962Qzww9toPsXtvzkXVnHV6vFwJI1sfr
X-Proofpoint-GUID: 962Qzww9toPsXtvzkXVnHV6vFwJI1sfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_02,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=834 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250037


On 1/23/2024 11:17 PM, Konrad Dybcio wrote:
>
>
> On 1/23/24 17:34, Satya Priya Kakitapalli wrote:
>> Add active_only support for gcc_parents_0, this is needed because
>> some of the clocks under it are critical which would vote on xo
>> blocking the suspend.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>
> Is there a need to keep gcc_cpuss_ahb_clk_src around? Do we do any
> ratesetting on it? Should we ever turn it off?
>

The branch clocks under gcc_cpuss_ahb_clk_src are critical clocks, which 
are running at 19.2Mhz causing vote on XO during suspend. As of now no 
rate setting is happening but this rcg is useful to get the exact rates 
from debugfs. Hence this change is needed to avoid XO shutdown issues.

