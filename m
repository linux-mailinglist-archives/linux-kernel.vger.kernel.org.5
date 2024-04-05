Return-Path: <linux-kernel+bounces-133375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97989A2F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19A6B229EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE2171662;
	Fri,  5 Apr 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fLn0QGhZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07DE1D530;
	Fri,  5 Apr 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336303; cv=none; b=KRiKczmGUkuN2EQ5V0jxnK1XXuLT7gwtGWRGUkRV/goE5Lb/+M320Avrnma/cXLWNCVUKXSGMh2tq6pzwQbGyK407ZAdwK17hfxwoE15l62SWUj/lWyIWQnbNd5RMR2x2BKUfS5rxSm/WE8Jatloux/lt3SJN12oAcbcqS8EhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336303; c=relaxed/simple;
	bh=9FApvoxcrmF0KAwjGuStONiAqHxiDKFUt4yrEwT5Ht8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TxRO6M26Be3NSK9HOHq+lrY0XVcqVBucmy5QcjAihl5HK1qEkjY1ZYtPZ7qdMU7p3JYK0QMtX0zGfFeaRSqF58YFfIGHleVgbfZJK7+44cB7NOP2N5VQZ2KhVvZkYsC8zecwHh+CytkISBjG0+cIPLfyb31Jrn7jO+YRa6UPZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fLn0QGhZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435BQeFP011666;
	Fri, 5 Apr 2024 16:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jlSvlwx1DIYu2a8LtFCH2ITQ5R5r9ksV7tC/6/xSt4A=; b=fL
	n0QGhZ9FIYitlhxcECLJXl8w0CzvuSmRuaRoPVf+yvbnyOuJNGuim+Zr9LekPsvd
	UrKOOJUOrFp8/P4mNFW85HKTM7LZjwYmH/wQ6UVtmo9b4f3LDxKluIlX1MJ4ouw5
	31vgFT4Y/AHHs91EKIgP00aisQ/qFMsYeQ0HSEmaOzRIpwtD/+le34AQnT7s9IKp
	RUFPSpCy9IwX1M6bUq5dUPJuaWKkqtKYjJ8uBqLJ7jTw9K4WIIMmDBZY8bE0IEAQ
	aV8tw8GJ079ygVInxxb6Nw+ifEOEYT4qNttNf3bXJZ3gIJcc7wljDX1mFj4YdbC8
	r2Q4oMVN+1etLgqGS77g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xafe3rx6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 16:58:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435GwGOm005043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 16:58:16 GMT
Received: from [10.216.23.38] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 09:57:34 -0700
Message-ID: <6277fb20-d579-1171-3e34-432e37727ac1@quicinc.com>
Date: Fri, 5 Apr 2024 22:26:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] soc: qcom: pmic_glink: don't traverse clients list
 without a lock
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil
 Armstrong <neil.armstrong@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
 <20240403-pmic-glink-fix-clients-v2-1-aed4e02baacc@linaro.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240403-pmic-glink-fix-clients-v2-1-aed4e02baacc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -QkxH5zR_S5qHJZlOIKJVFqb2MXQGHhi
X-Proofpoint-ORIG-GUID: -QkxH5zR_S5qHJZlOIKJVFqb2MXQGHhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_19,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=713 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050118



On 4/3/2024 8:40 AM, Dmitry Baryshkov wrote:
> Take the client_lock before traversing the clients list at the
> pmic_glink_state_notify_clients() function. This is required to keep the
> list traversal safe from concurrent modification.
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Nice catch.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

