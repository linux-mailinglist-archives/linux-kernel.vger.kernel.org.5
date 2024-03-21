Return-Path: <linux-kernel+bounces-109974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A459E88586D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3163285152
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C458AB0;
	Thu, 21 Mar 2024 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IIFiYMFd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22A56B9C;
	Thu, 21 Mar 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021021; cv=none; b=KsB3M4KqEs/k9OcpAMgTNX2HaTRyN8C5eShPD6FVDRjc06tycLcldzajQdX2MztkSdhZAMc7o6IlK5jSqxFd7tYKJgsUE+bdulyzAVvG1WTcu63B9EFJxZegkT+yEwUN6uyyZkkllSi0pBVqKk+g4/X+1xmAxq1k4RY56kzlw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021021; c=relaxed/simple;
	bh=ZW/lmDZPDUcpi6YJcBgfOXWeHLZGXtzQbVULFL/SW2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K0wyOrjCrdP41U8+OA8kP/Y8yp5vTVQ8bQAZdHlUevRcNUTvU9+ZKPJUtE5q+XWMNqxTgP05dkZDHjj4s2/WLbLJeVWRuVtbye4/vYST97rt76s4jq8fWeV3rG849Oy+u69fY30SDA/wnOgBkgfz+fJwrEXKf1Mh9g+cCllwY84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IIFiYMFd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LBA0xD014142;
	Thu, 21 Mar 2024 11:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QM56RlcJFoSE7/fF9yNnNxqs/106YgOgiHjhhqmK7fc=; b=II
	FiYMFd01KE5c5IQHkDaMxqV8VczrPVwWZNSy8UnPsx17iAFTDltoO1w1oF5dhuSf
	R89e0337KoIRpZSl9YRSlyO+nQN8iCh9vH3GihDoVFB5uyzKL4AYGc9fWRzMqzIV
	+/4/gYAzEzUBUeO6jTzwoMA8RCQ6lS4JPvKT4XDV1OBhtNGZin0x8WwOxbIAVgAf
	d8MFGRy/waE4QPTrfAQUPb1AjF9VQBANMUDGvR5sfTTcx35nZuD2rXWBY0GlV360
	WEyoVk6PBlPlGw/Bc4HUmfDThWMZpzkWg3kxoFo+9awvzpqr9U2jQ7T7J5WHs2vb
	9pOsQ+XQjeEpL4rDu4JQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0b5494ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:36:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LBati2029129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:36:55 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 04:36:49 -0700
Message-ID: <33c54316-492f-4e94-9f02-80d0d272ba3b@quicinc.com>
Date: Thu, 21 Mar 2024 17:06:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 2/6] clk: qcom: videocc-sm8550: Add support for
 videocc XO clk ares
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-3-quic_jkona@quicinc.com>
 <CAA8EJpqrJ1bh3hdS8Gm-QRe1iEYj34Wwz+=vOtONUgAF=hOZYw@mail.gmail.com>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpqrJ1bh3hdS8Gm-QRe1iEYj34Wwz+=vOtONUgAF=hOZYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ILTxTxi4x6d4LU_jQByIfH4SrIGNrY0p
X-Proofpoint-ORIG-GUID: ILTxTxi4x6d4LU_jQByIfH4SrIGNrY0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=914 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210081



On 3/21/2024 3:14 PM, Dmitry Baryshkov wrote:
> On Thu, 21 Mar 2024 at 11:26, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>> Add support for videocc XO clk ares for consumer drivers to be
>> able to request for this reset.
> 
> Nit: s/for//
> 

Sure, will update this in next series.

Thanks,
Jagadeesh

>>
>> Fixes: f53153a37969 ("clk: qcom: videocc-sm8550: Add video clock controller driver for SM8550")
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>> ---
>>   drivers/clk/qcom/videocc-sm8550.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> 

