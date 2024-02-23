Return-Path: <linux-kernel+bounces-79305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6F7862091
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21494B22454
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4409314CACB;
	Fri, 23 Feb 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c/VJNPl1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2C199A2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730253; cv=none; b=hs+g9vPJGki23CZNBi1nxlyE88vxnOML26dYqBl4uMb61+rCw8SdfK14sbx6+cbP1MHeUxV1s903k7qJ8LDJHLY7NNleSRLqKesSMak5B4zGJMMnIEyTeXSuy8Uyo4IrJVkh+Chho4ANmV2tYAuPJw8YMzjQfdVE4JhJFhzPpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730253; c=relaxed/simple;
	bh=fceJfyNcHrIsskklZhe4yllL2tISv3C9iSoNAZQJrAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ocvvunm3EUX32Fo+d95LPVbcVZxUWnCPjNF8CMxUrJC4oPe3oUelSbOOAucO2iqiFPqhnSXIQ3L6neDtSoRmBrtZN9yHh8RCEnGExHPgTNXIeRhKR+zpX0WSsLnRfYoplVLUDCw/Nwl/KOkmAZnuhcPn2PVchEwaOB9nQQy3Flk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c/VJNPl1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NNEwK1011389;
	Fri, 23 Feb 2024 23:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/+j6zitO0g9tfmQStelz6EINortPRw4TJZaYrFo8pTc=; b=c/
	VJNPl1dfoU3UY5tDvHBDbeSWWGTGwp7r77d7WKgssR/ggKNBmYiNbhAOpH+W5YsA
	Ie4/ZS+U70EYYqNOhhV7Wc8T2BA6JblVlncHp7ty8n4sRF6AVL1mZOcrjHnZ5GkA
	sbNoooVo6EClLTJohyP5C5I2jex2o7rbHIOkuZCtiTHY40eAlV4SoVwsPHk5Otwc
	3k20q+Uu/9fQhm7crpuAvm9WGzmGuIMgsiVI4oX/Fg8LgQGvnJ/FjNRfAyQCYAMq
	8cqb3NgQvjPFT2Dr4nbIV7VYCDZD4zRXRDBfpLnBHFPHZFkTnUKlwt4h+Rmlt8aW
	42vPa20OU/j7NhKmAvvA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weytjrmq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:17:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NNHPDF009910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:17:25 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:17:24 -0800
Message-ID: <52d70360-5520-53e2-78cd-988117e5b4b9@quicinc.com>
Date: Fri, 23 Feb 2024 15:17:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] accel/habanalabs/gaudi2: drain event lacks rd/wr
 indication
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Ofir Bitton <obitton@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-9-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-9-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vjApn0oS88gJHtp_0_Q0tzkTBm9EP6n0
X-Proofpoint-ORIG-GUID: vjApn0oS88gJHtp_0_Q0tzkTBm9EP6n0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=824 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230167

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Ofir Bitton <obitton@habana.ai>
> 
> Due to a H/W issue, AXI drain event does not include a read/write
> indication, hence we remove this print.
> 
> Signed-off-by: Ofir Bitton <obitton@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

