Return-Path: <linux-kernel+bounces-74538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A322B85D5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7FE281E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87A1DA5E;
	Wed, 21 Feb 2024 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E3+vm1zt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA83D561;
	Wed, 21 Feb 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511668; cv=none; b=gCXFybEYegwTG23IJ0yFLpf/6s/P0TO4Hj6hEilHdiASWCEhs+bTmGQRHnu3EhvY1VWwplnh4tXZjKb8orogz5bwuIPuOM5oEM0suy4vpepsIQWCfhAqyaMZC9AR4SWYvhCDBInYBRK7fEVOjAcXxijQ7XRcE2ILRUGui0odYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511668; c=relaxed/simple;
	bh=z3aLnsh8Qe+1OmuVDN5NOlsZFSABSDdQj5+DEjz88lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oq+vraEJYhAV7ruUQbhXQg3oMuJndduXQ9iQKVanGw387d7PNmvuMcLXzSRq8vH11nj/K8neYXM7gLpU4JQq3B8zK2st3tA1eBM4x4DJrrp5V8aEyiGWI8Lw7nhnZitWV6EmSSBLSfEcvd+SQC0qchxUqSocdCZBMqcaijO61Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E3+vm1zt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L6np3w029179;
	Wed, 21 Feb 2024 10:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s15kuA4pjVy4qKgvcnbye/y/cqmB3GFypPX74p+09nQ=; b=E3
	+vm1ztPVgjCqgYRi7TylETjlJKiLaJ4wrU2ThrCYxTUFTvAPQDhn+kfRoGuxOGrh
	EGfhopK6p9JW011Nllbh0QEBV2/r9mQZ64cTcNhDEsy6dOlCcqYDX0eEw2G7NWzs
	7MFtF3cAw1+fQ75I+HS0Q8Etf6tvy/FARHrGDpTfYcUWbMhfRfPLw76uJORSyBwZ
	5JZSMCXjRm+fNzcXNyvE5sulXyO4a3dXmseGEA7zhSY3NDmzLgR4Gx6z2GtPSPj6
	kdhQeU/sm6BiTnO5i9RDR3K8BSNzZnVnA80ClwyIPrx1V/tP95ugijPGl9lB38US
	3i9t+kV7B11jo/3GMkxQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21usn0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:34:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LAYEro001339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:34:14 GMT
Received: from [10.216.62.93] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 02:34:08 -0800
Message-ID: <bfa0edb7-02fd-42dd-2235-0ea34f362515@quicinc.com>
Date: Wed, 21 Feb 2024 16:04:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/5] Add QPIC SPI NAND driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240219130412.GC3281@thinkpad>
 <3ad2909d-4ac3-fff3-739d-b12a3408fa0f@quicinc.com>
 <454a7e8d-70f5-4bf5-a3f1-bf9e42672c4c@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <454a7e8d-70f5-4bf5-a3f1-bf9e42672c4c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MLVOkpa9aMrn448T-yV6pcqheFsX2HW6
X-Proofpoint-ORIG-GUID: MLVOkpa9aMrn448T-yV6pcqheFsX2HW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=770 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210081



On 2/20/2024 5:06 PM, Krzysztof Kozlowski wrote:
> On 20/02/2024 12:32, Md Sadre Alam wrote:
>>
>>
>> On 2/19/2024 6:34 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Feb 15, 2024 at 07:18:51PM +0530, Md Sadre Alam wrote:
>>>> This series of patches will add initial supports
>>>> for QPIC SPI NAND driver.
>>>>
>>>> Currently this driver support following commands
>>>>
>>>> -- RESET
>>>> -- READ ID
>>>> -- BLOCK ERASE
>>>> -- PAGE READ
>>>> -- PAGE WRITE
>>>> -- GET FEATURE
>>>> -- SET FEATURE
>>>> -- BAD BLOCK CHECK
>>>>
>>>> This driver has been tested with dd command with read/write page
>>>> with multiple file size 1MiB, 10MiB,40MiB etc.
>>>> Also tested with "mtd" command like mtd erase, mtd write, mtd verify etc.
>>>>
>>>
>>> This is not the first version isn't it? Where is the changelog describing what
>>> has changed since then?
>>
>>     The earlier patch was the RFC for design review only.
> 
> RFC is state of patch, not version. This is v2 then.
> 
> These RFC postings are really becoming mess. Some people make multiple
> RFCs and then post v1 hiding entire previous history... And why even
> bother with calling it RFC?

  Sorry, I was not aware of this. Shall I post the next one as V3
  and add references to the RFC patch and this patch in the cover
  letter of V3?
> 
> Best regards,
> Krzysztof
> 

