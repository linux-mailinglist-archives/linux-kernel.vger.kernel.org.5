Return-Path: <linux-kernel+bounces-35936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D28398EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E534A1F2BD32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4112AAF5;
	Tue, 23 Jan 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HcrSUoPJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D5823BB;
	Tue, 23 Jan 2024 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035924; cv=none; b=d2XotzUPOEQLoIFPV+QGWgTVHQ3Bcimlu+FcP/0ppga3YEeeu5hQIIP7J3ieXOn0fo+ulfalzZjQt9f8/qSxqc7UEIqUDUrHHN9y/X0afgOUDFE57gExVWgC/fvDXRrUaYK/mfntEtTdua5o5KyK8ga/v4Sr97hLjeRFWDFZBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035924; c=relaxed/simple;
	bh=+tATZfcfl1sz7Fvgi9akTACEfpVKDfHWT/M4eF2jU+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U2y5G91w5R/bazX+sYH9Z+OEqLnoobYux/E8OJryBwM9YN716ALRF8DdfECQgayVWWLcCKkwDRIHlHOWtSiD2Q4iBROlAIy/sX+b8zL9X8AJdyZRXUpgm0EW4yzb4eLddTm/6k/05A6Ma/X6yeiYgcvI9RThanFKmaruWbveZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HcrSUoPJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N5CtZM013950;
	Tue, 23 Jan 2024 18:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IVkFnOmAPX2AjxPz9Cgiu45yGgWd87xgn7rebsJuZG4=; b=Hc
	rSUoPJP5682/qQtoJhy7q+7RPMtW4y4quwxAoF4ILaagSPBmVKI5Ctd2ZXvn17le
	QfKFDIg6W6fyKhWC31yAurVCyCJ+SZbxyOKnw99oKH83s0eqA59hJ0l+bGz9xERk
	YBguYOEWWkiHSJx0TSTjCxrmZyTvjWDrSGyAEXtZn4REf1Zc+av5pvDGnwIi4YS5
	jaTzx0n135D2y93pwy5Esyso+xVH0qJ9qzRdsh39mdU7csfDdpi8PZXbWsH1CH5z
	8xCIqkLhCf/nk6lJtiPtAI5y/+IVKLrQm+4FHWbKDW5c9thTch1LaB7N3MmcsLj5
	OO6ZoUK3xBQ/rgY+RVxw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt06mjtap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:51:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NIpvWO014118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:51:57 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 10:51:53 -0800
Message-ID: <1941558d-d1e0-43b7-9208-65b9ba191bc2@quicinc.com>
Date: Tue, 23 Jan 2024 10:51:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
To: Amrit Anand <quic_amrianan@quicinc.com>
CC: Trilok Soni <quic_tsoni@quicinc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Conor Dooley
	<conor@kernel.org>, <andersson@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
 <6e40dd60-884f-be23-0052-d14f7194f844@quicinc.com>
 <f21bc259-45fa-d14b-a556-625b813287f4@quicinc.com>
 <499320f4-f6b1-4582-9512-89ab505305b6@linaro.org>
 <20240123-sterilize-flap-8971aa3bad4b@spud>
Content-Language: en-US
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20240123-sterilize-flap-8971aa3bad4b@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tp3vmZil-hcHVp41a5cct2uBRkBZuxmN
X-Proofpoint-ORIG-GUID: tp3vmZil-hcHVp41a5cct2uBRkBZuxmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=791 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401230139



On 1/23/2024 9:18 AM, Conor Dooley wrote:
> On Tue, Jan 23, 2024 at 12:50:07PM +0100, Krzysztof Kozlowski wrote:
>> On 22/01/2024 11:10, Amrit Anand wrote:
>>>
>>> On 1/21/2024 12:40 AM, Trilok Soni wrote:
>>>> On 1/20/2024 3:20 AM, Amrit Anand wrote:
>>>>> From: Elliot Berman <quic_eberman@quicinc.com>
>>>>>
>>>>> Device manufacturers frequently ship multiple boards or SKUs under a
>>>>> single software package. These software packages will ship multiple
>>>>> devicetree blobs and require some mechanism to pick the correct DTB for
>>>>> the board the software package was deployed. Introduce a common
>>>>> definition for adding board identifiers to device trees. board-id
>>>>> provides a mechanism for bootloaders to select the appropriate DTB which
>>>>> is vendor/OEM-agnostic.
>>>> Please extend CC list to more architectures? linux-arm-kernel, risc-v etc; since
>>>> the proposal below is not specific to ARM but any architecture is using the
>>>> devicetree.
>>> Wouldn't devicetree@vger.kernel.org will have concern folks from all the 
>>> architectures?
>>> Please correct me.
>>
>> No.
> 
> The chromium guys should get a CC on future versions of this stuff,
> since they like doing wacky things with compatible strings in their
> bootloader and this problem is one they also face. Doug Anderson and the
> mediatek chromebook folks would be a good start.
> 

Please CC Peter Griffin from Linaro as he helped restart this 
discussion at Plumbers.

Peter Griffin <peter.griffin@linaro.org>

Also, for the oneplus boards:
Caleb Connolly <caleb.connolly@linaro.org>

