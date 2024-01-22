Return-Path: <linux-kernel+bounces-32709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81DC835F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7937B1F26444
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006D3A1AE;
	Mon, 22 Jan 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g0gTlvsO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E443A1A3;
	Mon, 22 Jan 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918222; cv=none; b=OUddZu/bxgo2eqYj08lwcRVS1uIhxM5ZM8C6Fm0sn2gciDjGv0Yq65oXty/BJqUzP+dPTM27Cm7Zh3TmAx3855ErOuYCCv8lIR5+NoCbogAp/o/UMqNtdbXZRpsKq3nDAsmoVEiHFCYFcowq50v0hrFG4EWl8jLtT/IYE00qMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918222; c=relaxed/simple;
	bh=PBOtkPIryD0bNegKqmqx/36FGFSN6iCMu/XYr0xn/xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JrrLu9adXhAZKMQpsHNKNGbiYAe+RlhH7boOQMiqPXXTm/QAlGQ6qO9xT0o5V1MP8atVECptNdVc3G627wRoRCkNwbFUQGWENG3LFiODJ9NOWfzRznYjkEGdibkgjK2N4yZG62cxb2cQWohyOQGxnnIzinRN6ne0r0mI5szMtDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g0gTlvsO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M9tZsG009649;
	Mon, 22 Jan 2024 10:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Q/+GfaRYa9bykPxO1FU0xoaPYaPB0FIarp0Y35xl660=; b=g0
	gTlvsOwMYsuCH5ODFMF5KenqMEbuSTlcEFaktipPWdnPGPig19+2Bw+HBX1z1jCN
	ubE6Zy1ZDVjHPmgz2uh1W15e63elJrxVp191OT9VhjGOFXEN944v8B42Y3lfEyiR
	d3aijHlQMyKaXscb6jDXi3TQD1Sx0FBEjjH1ujXfgtBTlrefpwJvadrx4Zsyp4A0
	xY0/NolTMMnAtv8xOv/Ls7iuxCxvAIMuYR5zUgZbAP/J63BQEQqvIAyWZphbZvg4
	yvwrsCvVxZUbuE+EcPElu7q13XJYAkY7ySTd4qzJbjEJX3qTQzpXMJxfvARjjuiE
	SWCE5Xhyb2sYbdcYE6gw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsn0wr68b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 10:10:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MAAFBB023958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 10:10:15 GMT
Received: from [10.216.25.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 02:10:08 -0800
Message-ID: <f21bc259-45fa-d14b-a556-625b813287f4@quicinc.com>
Date: Mon, 22 Jan 2024 15:40:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Content-Language: en-US
To: Trilok Soni <quic_tsoni@quicinc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
 <6e40dd60-884f-be23-0052-d14f7194f844@quicinc.com>
From: Amrit Anand <quic_amrianan@quicinc.com>
In-Reply-To: <6e40dd60-884f-be23-0052-d14f7194f844@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YLj8zV_gYcLuZkKWc-w34w2Kb7XYieDq
X-Proofpoint-GUID: YLj8zV_gYcLuZkKWc-w34w2Kb7XYieDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=605 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220072


On 1/21/2024 12:40 AM, Trilok Soni wrote:
> On 1/20/2024 3:20 AM, Amrit Anand wrote:
>> From: Elliot Berman <quic_eberman@quicinc.com>
>>
>> Device manufacturers frequently ship multiple boards or SKUs under a
>> single software package. These software packages will ship multiple
>> devicetree blobs and require some mechanism to pick the correct DTB for
>> the board the software package was deployed. Introduce a common
>> definition for adding board identifiers to device trees. board-id
>> provides a mechanism for bootloaders to select the appropriate DTB which
>> is vendor/OEM-agnostic.
> Please extend CC list to more architectures? linux-arm-kernel, risc-v etc; since
> the proposal below is not specific to ARM but any architecture is using the
> devicetree.
Wouldn't devicetree@vger.kernel.org will have concern folks from all the 
architectures?
Please correct me.

Thanks,
Amrit.

