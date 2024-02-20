Return-Path: <linux-kernel+bounces-73015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349785BC21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED570B23D18
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8E6996D;
	Tue, 20 Feb 2024 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V7i8i2ko"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E769968;
	Tue, 20 Feb 2024 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432134; cv=none; b=p0dF14MmawUThV/F1prAguOvxu0G3jB2Y/txOg2y3gta5hIKEdkUOPijg+4E511fJBdy3jgrftoXGIzofEU4Kngdi51WK2G2sQGdWdyGl5uOgiIUbU4/0CICVY72o5NVQwyktBHNtMDZ4MCMRBX20notYiGmv0j1y0VGb9dqHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432134; c=relaxed/simple;
	bh=9hC48CFGOI+zH+J/OnR3D9Cvj+eSSX+d271pEsg8oYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JTQRFwAnRmSVKXDtRg+21dNhDmTY6N8hicVvAOT3CCXI/gMbT3uYPEyXOSADhCJZFciB1TVY+NwA42T7Q3wYNsU4HkC08DHILidFajcvNfFtGfrZ+cVwrtFIH+XFqyJozYxp4KmUzUJsHnA4b6o3JGpsmOXHWfDEfkgpbkEmdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V7i8i2ko; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K5laxu005396;
	Tue, 20 Feb 2024 12:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=g28R+uJawHAgWOgBmwhyNrp8WnEMlRZ+lOB3MV0yd50=; b=V7
	i8i2ko3gpKbqmbgIStQ7+rg1mEXmv0vXkgwdKevULxE80JN6lQQp9ejBf+OR7UX1
	mnxNAM5B2xZSt7Fsu2ku6aKWNB21rPkchyYfKHrhPACJJzGH9jRbQQ/kENIYSKS5
	/yc8MQequPiJxA9OBdnGPsCspMqr7aa5Xr6TVAnuTe+uORZB8Uxfna8o5Bxvh43q
	hBwXPbi1vjZpdamOFBgW9ZXeRzMBWgvjGntg4fqwC660NcEmDeKmslxS3zm8FmLj
	DKDQ1sfa4512fQnZuRIPSwvo5bxmXS8wT+f//1ntgJtwQOZGlW5nGhZLyMACQCCG
	TJEvonc9iT4xReU7e05A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcmqp8wm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:28:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KCSgcB013993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:28:42 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:28:36 -0800
Message-ID: <196fe404-ad88-27da-9fd2-e717355be520@quicinc.com>
Date: Tue, 20 Feb 2024 17:58:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-2-quic_mdalam@quicinc.com>
 <8c3d8fc3-2c1e-4ece-abb1-b427a909ad39@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <8c3d8fc3-2c1e-4ece-abb1-b427a909ad39@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5-uOaEB-mW3eyFykmLRc0U2UUciV0rZr
X-Proofpoint-ORIG-GUID: 5-uOaEB-mW3eyFykmLRc0U2UUciV0rZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200090



On 2/16/2024 12:32 AM, Krzysztof Kozlowski wrote:
> On 15/02/2024 14:48, Md Sadre Alam wrote:
>> Add device-tree binding documentation for QCOM QPIC-SNAND-NAND Flash
>> Interface.
>>
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
Ok
> 
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>   .../bindings/spi/qcom,spi-qpic-snand.yaml     | 82 +++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
>> new file mode 100644
>> index 000000000000..fa7484ce1319
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> 
> Filename like compatible.
Ok
> 
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/qcom,spi-qpic-snand.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QPIC NAND controller
>> +
>> +maintainers:
>> +  - Md sadre Alam <quic_mdalam@quicinc.com>
>> +
> 
> Provide description which will describe hardware.
Ok
> 
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq9574-snand
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 3
> 
> You must document the items (could be sufficient in clock-names if the
> names are obvious).
Ok
> 
> 
> Why the clocks are flexible? This given IPQ9574 has variable clock
> inputs? Please explain.

  I have checked Hardware Spec. and clocks are fixed in IPQ9574. Will fix in next
  patch.
> 
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 3
>> +
> 
> required goes here.
Ok
> 
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
> 
> 
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,ipq9574-snand
>> +
>> +    then:
>> +      properties:
>> +        dmas:
>> +          items:
>> +            - description: tx DMA channel
>> +            - description: rx DMA channel
>> +            - description: cmd DMA channel
>> +
>> +        dma-names:
>> +          items:
>> +            - const: tx
>> +            - const: rx
>> +            - const: cmd
> 
> No clue why it is here, move it to top level.
Ok
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +    qpic_nand: spi@79b0000 {
> 
> Drop unused label
Ok
> 
>> +        compatible = "qcom,ipq9574-snand";
>> +        reg = <0x1ac00000 0x800>;
>> +
>> +        clocks = <&gcc GCC_QPIC_CLK>,
>> +                 <&gcc GCC_QPIC_AHB_CLK>,
>> +                 <&gcc GCC_QPIC_IO_MACRO_CLK>;
>> +        clock-names = "core", "aon", "iom";
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        flash@0 {
>> +            compatible = "spi-nand";
>> +            reg = <0>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            nand-ecc-engine = <&qpic_nand>;
>> +            nand-ecc-strength = <4>;
>> +            nand-ecc-step-size = <512>;
>> +            };
> 
> Fix indentation.
Ok
> 
>> +        };
> 
> Best regards,
> Krzysztof
> 

