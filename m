Return-Path: <linux-kernel+bounces-155766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4618AF6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1EC1F227A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42EC13F45A;
	Tue, 23 Apr 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JqD0ppGj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894013E3FA;
	Tue, 23 Apr 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898020; cv=none; b=kQy2hULWDUcsVLB4UonTKds7XfttXzrbpd30a4F22I2jbpjfH+PO+rDIElii38H4ozTKsLavr2Vxg/w53B0EHmjSDN+sKTdBE95kPOSFXHIoB5L5RvdfTUC/OIshsEfcTZnfSyuxcAC814uHe2cWxXwaOj8UFWLYOwFY1954pxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898020; c=relaxed/simple;
	bh=eDIJ3+MJpBImloGLMO5gq7Xkd5gmDED6oLJC1IQyaYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pgB/3c83nPqsbsjv/n7i1sF/ZmnkrlMduparrDA8rWugYlOlmqFqoALS2UthdsjdSOQ153AkLrSiIaY92fVviyaKZB1GUePi4vgNNHAd6OE5U7OoSHMQqJK1BsJ98O+Tr+dLvMr2GS8pvH8NJnq3tAwa6/WdMnti9dzUFNknllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JqD0ppGj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NHTvZ3016965;
	Tue, 23 Apr 2024 18:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VWfp8unN8bbHw0a+C9DNsJI0GAw+ks5tw//vps2BHp8=; b=Jq
	D0ppGja6OLJ/ZDkNgAEpRMcF4KZinJgGVYG9vL8NfmR6Y4EvaRawsi7ktqLj1sl6
	wxYKnW8tXEciIeoZEIMVj26F+bqHE5h9OggTtQBGBsXgy8+t49x9faBzYQ884b+m
	aI4bWOCfQpSHqNj88KQ6MsWK5OO96ERZ423PdeHX13gayhyYrTaNUd7D2HUgvV3v
	QPiO7Ds9LVrsupm1pjvsTGx9Xi5ZJeQEWVPPHq1T3hUETvzauvFPpdTFyYftpnzz
	A9S2NMtkSSsQIWRfwoOBSI7cYECsQQYL8PruK6YE/QtP50Ceo6MLAlFt4mZJ/gAy
	S+BgbQWt6sty/fut8ycw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp978stdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:46:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NIktmt002045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:46:55 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 11:46:54 -0700
Message-ID: <5df422b9-d660-e19b-07f1-67f2ee4d018f@quicinc.com>
Date: Tue, 23 Apr 2024 12:46:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 3/3] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
 <1713868417-37856-4-git-send-email-quic_qianyu@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1713868417-37856-4-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ngq_00zODfU5eZIb9KpM_aceti3AzA0G
X-Proofpoint-GUID: Ngq_00zODfU5eZIb9KpM_aceti3AzA0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=862 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230043

On 4/23/2024 4:33 AM, Qiang Yu wrote:
> Some of the MHI modems like SDX65 based ones are capable of entering the EDL
> mode as per the standard triggering mechanism defined in the MHI spec v1.2. So
> let's add a common mhi_pci_generic_edl_trigger() function that triggers the EDL
> mode in the device when user writes to the /sys/bus/mhi/devices/.../trigger_edl
> file.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

