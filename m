Return-Path: <linux-kernel+bounces-159174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D808D8B2A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D021C20FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078F4154422;
	Thu, 25 Apr 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D8AseFBS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4541553B7;
	Thu, 25 Apr 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078653; cv=none; b=iUxUtprbt8sY28sEqmUlgwlLHN5f+JH9aOZ2MtSJSFpjITfvoDgJ3nhmmGHgkcoE7kSb0vLQgVhtBj405H+NPhGsBnmjgcam9XENUfBn3wUrkE83nGgmjfult0m/+cX/mPZqrs7PdriOkUWwIiLjBagav4+htjgo3wb4Lb6V1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078653; c=relaxed/simple;
	bh=AA31ddoXPKsG50Blt7amrjvlWtaClJc1gqXqt8UVLHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SFkn6YkdJS28bdnWxm5xaHghSarEtymfteeH8GK3Jg0E9DxKd1g2dfyQ6T0KQL97iMySNG9EYpQP48Wy+u3Df2185YhUlSmQTMFN57l3cp17QRETBtpOuHwrq3+V/0cqRiLDq0ZG5b+/fVRr3xkVXVJBBeEtVVSFGTcA6Mq8ptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D8AseFBS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PHoWMq019476;
	Thu, 25 Apr 2024 20:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BJP5DtH0Y5o3nXhxlA9Gq4DZnIs9BkthWHmZdxjB3W0=; b=D8
	AseFBSrS0mm3BNW+1LaXwnFTR/2BDqbsXye2JeygsXFV4DBUkVVttPbEjn+PJUjC
	/uDhutnD1DYRqe9u9yH9Gzy9KVGL6RStemXCBQKEJgynEsxKTENT1OWNmEPARTTf
	+dfdkyHxO6ReRuNiv8DcnPPAF4R+Fb6u2gbqEkf/RCmVrU+GIYQbxJfNQotIJEET
	VpAnHrJ59Fd1HKcBoPKCqBtZEMgF47wiR2y8MqpaW+2aU3WKr1Bb4jS+moKx5fyd
	Jja8x/M5o5v51FLxTzPczCepnYnSx9hbJDlxmtXNJFiG0h4NnJ/fQ/MI8noU1PON
	pb7/QFPAw4/hEaehzhWA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqtph8jd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 20:57:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PKvOnX014606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 20:57:24 GMT
Received: from [10.110.3.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 13:57:23 -0700
Message-ID: <8ff32c6c-0ab9-b6b8-5c89-033eb11f33be@quicinc.com>
Date: Thu, 25 Apr 2024 13:57:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 4/6] soc: qcom: qmi: add a way to remove running
 service
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Xilin Wu <wuxilin123@gmail.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
 <20240424-qcom-pd-mapper-v7-4-05f7fc646e0f@linaro.org>
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240424-qcom-pd-mapper-v7-4-05f7fc646e0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5KoNx70fbGDgiMyy4fhI3GQQeaCeLZ6E
X-Proofpoint-ORIG-GUID: 5KoNx70fbGDgiMyy4fhI3GQQeaCeLZ6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_20,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=922 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250150



On 4/24/2024 2:28 AM, Dmitry Baryshkov wrote:
> Add qmi_del_server(), a pair to qmi_add_server(), a way to remove
> running server from the QMI socket. This is e.g. necessary for
> pd-mapper, which needs to readd a server each time the DSP is started or

s/readd/read/

> stopped.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

<snip>

> +/**
> + * qmi_del_server() - register a service with the name service

Update comment to describe removal of service instead of 'register'.

