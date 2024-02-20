Return-Path: <linux-kernel+bounces-72910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD085BAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE111C212ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A8F66B5A;
	Tue, 20 Feb 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M6mlcGeG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6D5B66C;
	Tue, 20 Feb 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428789; cv=none; b=lc57Frr4RkAMRHLRcmsHhyRK+cnKj8SMOGnu4nLLQStKHbx9DpB0QWVaZpNhV5pj8FHJq0XeKunsf8EJbvkYXlcOPvjMbYVKrSuzppfFqgkl+e1jDZ881WfJLCdyhUGFrv9h7n/tgQGLAaRimMF8xrFY8U5KvVfAtQwc0a06QSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428789; c=relaxed/simple;
	bh=nu5ywiYaSjFjgFyE5Qqnc33gPSlkptZflEOVTZMX7GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=crLG5u5xSiMaeK9hCQKQNt6dT4MVO2UEPQikQLaayyfhkET4AE5Nx1RrgY7ouc3QNlWuBE/SPffNPPNBEVQj1vAOEVpwLd2WlrbnwtwTrSVbb2OOpX596esW5MzhcXEZ3zDaZVS1eVyu0XJuIp/Pz/LvAgTFwbmcAAeRIhekWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M6mlcGeG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KAApqN025688;
	Tue, 20 Feb 2024 11:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CuAAaIpyHcdXRL6GRG/AMq7g/D+YIAJuhwyqTbufseo=; b=M6
	mlcGeGRuSih/K/mEhOa9t5ijxezOCTaiVwHctk2bDCx4opbRz0SsOnyymZO9MGmE
	81QuAEYqf6K3GLhNMcwLDYvJ1YD99BmQDeuKrOQheT/d6vcxXxJg+VZVoqUWfQdO
	psuYLwGZyYfvBoWLHKHbwjAwe+bLcrKGVoTE3bL8HtLKTV+U4ti4yTU+4cRmiCVi
	j+3GpLYWQBeE804lk7qLC2d4EwSS2iur78wgNnmrxG3Cyna8Cb8KakM5LhdHNMzp
	CHC2WSS21U5UF9LU237b7zer5wox+lcoe8VzNF4QshdIVuXIMXIgajUs/iQEp4Ok
	/8rr6NtoRGOIN6uy6JLg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct3d0504-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 11:32:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KBWm4W026534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 11:32:48 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 03:32:43 -0800
Message-ID: <3ad2909d-4ac3-fff3-739d-b12a3408fa0f@quicinc.com>
Date: Tue, 20 Feb 2024 17:02:40 +0530
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
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240219130412.GC3281@thinkpad>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240219130412.GC3281@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D3u3QcuM8VBH9Rtw3Kb75Ur5-gaB298t
X-Proofpoint-GUID: D3u3QcuM8VBH9Rtw3Kb75Ur5-gaB298t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200083



On 2/19/2024 6:34 PM, Manivannan Sadhasivam wrote:
> On Thu, Feb 15, 2024 at 07:18:51PM +0530, Md Sadre Alam wrote:
>> This series of patches will add initial supports
>> for QPIC SPI NAND driver.
>>
>> Currently this driver support following commands
>>
>> -- RESET
>> -- READ ID
>> -- BLOCK ERASE
>> -- PAGE READ
>> -- PAGE WRITE
>> -- GET FEATURE
>> -- SET FEATURE
>> -- BAD BLOCK CHECK
>>
>> This driver has been tested with dd command with read/write page
>> with multiple file size 1MiB, 10MiB,40MiB etc.
>> Also tested with "mtd" command like mtd erase, mtd write, mtd verify etc.
>>
> 
> This is not the first version isn't it? Where is the changelog describing what
> has changed since then?

   The earlier patch was the RFC for design review only.
> 
> - Mani
> 
>> Need help to test these all patches on SDX65 and SDX75 platform.
>>
>> Md Sadre Alam (5):
>>    spi: dt-bindings: add binding doc for spi-qpic-snand
>>    drivers: mtd: nand: Add qpic_common API file
>>    spi: spi-qpic: Add qpic spi nand driver support
>>    arm64: dts: qcom: ipq9574: Add SPI nand support
>>    arm64: dts: qcom: ipq9574: Disable eMMC node
>>
>>   .../bindings/spi/qcom,spi-qpic-snand.yaml     |   82 ++
>>   .../boot/dts/qcom/ipq9574-rdp-common.dtsi     |   43 +
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |    2 +-
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         |   27 +
>>   drivers/mtd/nand/Makefile                     |    1 +
>>   drivers/mtd/nand/qpic_common.c                |  794 +++++++++++
>>   drivers/mtd/nand/raw/qcom_nandc.c             | 1226 +----------------
>>   drivers/spi/Kconfig                           |    9 +
>>   drivers/spi/Makefile                          |    1 +
>>   drivers/spi/spi-qpic-snand.c                  | 1025 ++++++++++++++
>>   include/linux/mtd/nand-qpic-common.h          |  548 ++++++++
>>   11 files changed, 2547 insertions(+), 1211 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
>>   create mode 100644 drivers/mtd/nand/qpic_common.c
>>   create mode 100644 drivers/spi/spi-qpic-snand.c
>>   create mode 100644 include/linux/mtd/nand-qpic-common.h
>>
>> -- 
>> 2.34.1
>>
> 

