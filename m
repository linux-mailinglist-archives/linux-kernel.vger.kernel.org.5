Return-Path: <linux-kernel+bounces-39544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBBF83D293
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08061F24FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE398F47;
	Fri, 26 Jan 2024 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TkzBq7wT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2B8F44;
	Fri, 26 Jan 2024 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236485; cv=none; b=KOHk1rTzTPaMLwfDyDDUC17U67vShgx1ys0D6F1BBMbGZSE1mUkcrQGZC5w13qtBcSezTrEUa/0zqfp1oBFBj2KtOkpmfrDM/KHKl5J4jivgcU/xoskqaPluPtOC5tuVGVBHdQxBPdKIXKchT95mxHmu4UE2nqgbVlcqN9KayuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236485; c=relaxed/simple;
	bh=gEFdeH1dz5MeH3OyYmFVrtxyGmyY5C/fWJsuhHJJiBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kz4JXOBFxs2Gag8TLiAfvKAHNU8jKJjyTeVfXSJ1g6UbeVBq1S3nIjRo7Unl6fowwjp1zOLtPDEVl/z8CAAapxUetS6MpejzXz+UAXikvCbt2QGOsYPtjRndwADsTlidpOb35Gd48Pn38BjmrhRPb+QiSegFM2OOalO7dK0mayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TkzBq7wT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q0qqsK019345;
	Fri, 26 Jan 2024 02:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7aCazePiOgGahy5501KDly4q9vHVLXT5EBlhyF1E9P8=; b=Tk
	zBq7wTSWNYn00NM23lg7QZMIx6/Tert/9D9CXHgr7XUR+CVAHsKALu38DgqcIxkx
	54ullmmC/hgyT3WN56gBNmF1U3IhZyaVZvRHxOtMBahmJiLUntE6AFM/be+6s5pU
	mBojgS4NO5XHexqhS4TBp67srTwxVO1Lg53q+IrnMkvYocyDBiQYEAzoGjBWL8+y
	wATMoLhi8bGWI0/xvEg2/VLP18YEkeD2iBynkPidgayFNyp9xDHzL1vpRXdATDrn
	TrCzKRkVE4GeRAfjoRaQFS5z1wTy9IPTadv7++WM9DMZuXdI0/4U4ePh8YjF1Wv/
	ZccaJUQhXTHdmtZU51iw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vup2tj82c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 02:34:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40Q2Ycvt027670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 02:34:38 GMT
Received: from [10.239.29.49] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 18:34:31 -0800
Message-ID: <05a5402e-9c9e-4dbe-88a6-f990c5c2fbf0@quicinc.com>
Date: Fri, 26 Jan 2024 10:34:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add dma-coherent property
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <quic_kuiw@quicinc.com>, <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
 <20240125102413.3016-2-quic_lxu5@quicinc.com>
 <918d1d55-e95a-4b00-af59-7b5d7057b9fb@linaro.org>
From: Ling Xu <quic_lxu5@quicinc.com>
In-Reply-To: <918d1d55-e95a-4b00-af59-7b5d7057b9fb@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lzknJc3C8nQLOzuySaw82gYcgQJhLq8K
X-Proofpoint-ORIG-GUID: lzknJc3C8nQLOzuySaw82gYcgQJhLq8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=587 phishscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401260018

在 2024/1/26 0:38, Konrad Dybcio 写道:
> 
> 
> On 1/25/24 11:24, Ling Xu wrote:
>> Add dma-coherent property to fastRPC context bank nodes to pass dma
>> sequence test in fastrpc sanity test, ensure that data integrity is
>> maintained during DMA operations.
>>
>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>> ---
> 
> How can we replicate this validation?
> 
> Konrad

Without this change, case8 and case14 about DMA sequence test in fastRPC sanity test can not pass.

The steps to do fastRPC sanity test is:
1.download code
p4 login
export PATH="$PATH:/prj/qct/asw/qctss/linux/bin/vce"
vce.py view --base fastrpctest.common.1.0 --checkout=<username> --root .
2.compile command
chmod -R 777 ./fastrpc_tests && python3 ./fastrpc_tests/build_fastrpc_test.py -target=LE
3.run fastRPC test
fastrpc_tests_ReleaseG_push_LE.bat
adb shell fastrpc_tests -e (case number) -d 3

-- 
Thx and BRs,
Ling Xu


