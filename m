Return-Path: <linux-kernel+bounces-55567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8A84BE36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9745B22EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A517731;
	Tue,  6 Feb 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pQxpupbN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A1175B4;
	Tue,  6 Feb 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248497; cv=none; b=LRj3U6+t1PkKHt8oXig27WnUHzh0eBuEDVmR6qWbQTLZQUXc1ndrDeYfU6YkO6M6iYTdsRX5GfCZPkCNud/7jUfPEhT5lzdFABKgtJYOaJErkHyYoVSd7Ui4HnroLtdfI2P9fxGfXGDPRvlK++81HdAZ4RydaIE1HwhO7R73kQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248497; c=relaxed/simple;
	bh=itMo3TvBls5igRp570SC5K5V0EE/4TF5MkwczexECuo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NKXBhjXpofkXj0f+S6X+1vscTCysHd134bQdtfDGTjuLT3M5TnmSeXzGRQYJ1IZCJ3lIYkiPCh86dN5iJyJHItYDhTyOHWZRGLj0U5OFHlWhgY03htwOh1ZB2QALkcDcHoepu9Dr/gVncaZjs2ctjIS39lGDq+MaYdLRT+va/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pQxpupbN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416J7S1K026356;
	Tue, 6 Feb 2024 19:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6tEK7V+08Z8w77m62FJ5hHvDRAv+bfYut60ANhTlWPs=; b=pQ
	xpupbNv77apvMPq6Ex2s3Frww3VswaeFj8nSyGiqOOKh5VCkX1dB1HqdOIyEi1FG
	ezdF52cYL/x7gdzjC5c044YqmHnn1PTVrSN1e0s+CK8eIIRa0xwQ1BtswICzt5Te
	yNp42readMjKOhql5BxbCV/t9pCGKA50uKkM9b16xMagBtZ6LQbFwkSli5IkalK5
	+2uQiELJ7ZBgMDxP4LZHotOROvarjMr9xQkxfq4iaOz940+uA9eeq0js4H8kzsLv
	qJnX+d1Z2mUI3OxCUmGDR9ULaHBB87z5nOOniqUucpuDD/iJW1QL585TB6Bq3VG8
	mZbGQUDRi0Q2vsmLAUNQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3apjj4ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 19:41:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416JfW5x015795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 19:41:32 GMT
Received: from [10.110.41.143] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 11:41:29 -0800
Message-ID: <ab88f10f-d752-4c6a-b0e5-d8b05af99c28@quicinc.com>
Date: Tue, 6 Feb 2024 11:41:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Subject: Re: [PATCH v2 0/5] LLCC: Support for Broadcast_AND region
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
 <be9d964b-7900-4fef-9268-67ef404cd611@linaro.org>
Content-Language: en-US
In-Reply-To: <be9d964b-7900-4fef-9268-67ef404cd611@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vsrVVJT6tKe7oxPrj3DmAQLxnnjlH0mV
X-Proofpoint-GUID: vsrVVJT6tKe7oxPrj3DmAQLxnnjlH0mV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=302 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060136

On 2/6/2024 12:34 AM, Krzysztof Kozlowski wrote:
> On 06/02/2024 08:15, Unnathi Chalicheemala wrote:
>> This series adds:
>> 1. Device tree register mapping for Broadcast_AND region in SM8450,
>> SM8550, SM8650.
>> 2. LLCC driver updates to reflect addition of Broadcast_AND regmap.
>>
>> To support CSR programming, a broadcast interface is used to program all
>> channels in a single command. Until SM8450 there was only one broadcast
>> region (Broadcast_OR) used to broadcast write and check for status bit
>> 0. From SM8450 onwards another broadcast region (Broadcast_AND) has been
>> added which checks for status bit 1.
>>
>> This series updates the device trees from SM8450 onwards to have a
>> mapping to this Broadcast_AND region. It also updates the llcc_drv_data
>> structure with a regmap for Broadcast_AND region and corrects the
>> broadcast region used to check for status bit 1.
>>
>> Merging strategy
>> ----------------
>>
>> All patches should be merged due to LLCC DeviceTree/driver dependency.
> 
> Dependency? Sorry, there cannot be a dependency between DTS and driver.
> Please fix your patchset.
> 

This is the suggested merge strategy. But I have updated the driver in v2
to ensure that applying the driver patch alone will work with existing DTs.
Sorry for being unclear; "should" does make it sound like there is a hard
dependency. 

> 
> 
> Best regards,
> Krzysztof
> 

