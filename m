Return-Path: <linux-kernel+bounces-32703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F662835F29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8F4B20BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68F33A1D0;
	Mon, 22 Jan 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OG0f6K9+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED439FEB;
	Mon, 22 Jan 2024 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918058; cv=none; b=QZSZhDz9WgNpAxE0inXJE/Uvae+mo6wEN9RLSb7iAezGA97PKgsOQ3fZRn6zQhA6EAj5u+HfkBcq2pOJSUNqmkBRWFcCazxDbh61N7QkRXLePTw/lePAl2/zBGD983KSMhA7ewiQBwBIycyJic7qg8wAZEmx8KlYWrmZaayjfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918058; c=relaxed/simple;
	bh=0DBCtBL7EIQT2jBc+2uIH7Ya0F0CfhR/U4M8QK0l2zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jbxdbNku1oHTGNl+qRHokns26DjAgtyC4MbmFe00GSxGZL1BPs8KE3A1DKApWpKVNvMl7NRR5hYMGz2mYvesD9Lxeow0i/64yXQxrCRG2vL+E8vf1uTXp1TZMifl2J28vxX40ibuxdEYud/tDO2ZWu7F7/xqwUANZ5/89tpVFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OG0f6K9+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M5brQI028656;
	Mon, 22 Jan 2024 10:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=C/vkJQ/dVUcxOvXvJM0Z+onrH+j+Sst7yDaKR3InxDY=; b=OG
	0f6K9+9hUXEorDjkYrkxoF1fdAHr7iQrAH82gOHnJwdJad2ESCBUgLaeE77aqxF3
	z2S2FvBq5Z+O6MjB3OaFPC2jpqss3t+NKsYKmItDd5l73ESgtW+Y3MPICegflLRv
	nmBoGHgq28G4ep/wc/CNfL8GODnPlzjGqIyO5WdlRVgTKG2X76LteIyvhOHPdDzW
	Q5KfQuGI05kXp0nF1txktrUIaS6I+nx0pBsjhoswPFzKlXo4eP0udHgfmSdPySG7
	8dObQ098YhzN20TmfpVFVdHVM0m+xzqlmlUABgkS8QrlvPQzGL3r9dCnWyF3+1yw
	20OsKnVcra+cipViU3zA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr54wum0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 10:07:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MA7OlM029669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 10:07:24 GMT
Received: from [10.216.25.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 02:07:17 -0800
Message-ID: <391f8f48-d1f5-702d-20d4-ae8b8a7ace58@quicinc.com>
Date: Mon, 22 Jan 2024 15:37:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dt-bindings: hwinfo: Add Qualcomm's board-id types
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
 <54426665-90c5-4355-a174-f512004e11e5@linaro.org>
Content-Language: en-US
From: Amrit Anand <quic_amrianan@quicinc.com>
In-Reply-To: <54426665-90c5-4355-a174-f512004e11e5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _nwZ8vsPmPDLgjgNQrNUDMbBvQBAACKm
X-Proofpoint-GUID: _nwZ8vsPmPDLgjgNQrNUDMbBvQBAACKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220072


On 1/20/2024 7:02 PM, Konrad Dybcio wrote:
> On 20.01.2024 12:20, Amrit Anand wrote:
>> Qualcomm based DT uses two or three different identifiers. The SoC
>> based idenfier which signifies chipset and the revision for those
>> chipsets. The board based identifier is used to distinguish different
>> boards (e.g. IDP, MTP) along with the different types of same boards.
>> The PMIC attached to the board can also be used as a identifier for
>> device tree.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>> ---
>>   .../devicetree/bindings/hwinfo/qcom,board-id.yaml  | 86 ++++++++++++++++++++++
>>   include/dt-bindings/arm/qcom,ids.h                 | 68 +++++++++++++++--
>>   2 files changed, 146 insertions(+), 8 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>> new file mode 100644
>> index 0000000..807f134
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>> @@ -0,0 +1,86 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwinfo/qcom,board-id.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: QCOM Board Identifier for Devicetree Selection
>> +
>> +maintainers:
>> +  - Amrit Anand <quic_amrianan@quicinc.com>
>> +  - Elliot Berman <quic_eberman@quicinc.com>
>> +
>> +description: |
> The '|'s are unnecessary in both commits, IIRC they're used for
> preserving formatting which we don't really need for non-styled
> plaintext
Sure, will do.
>> +  Qualcomm uses two and sometimes three hardware identifiers to describe
>> +  its boards
>> +      - a SoC identifier is used to match chipsets (e.g. sm8550 vs sm8450)
>> +      - a board identifier is used to match board form factor (e.g. MTP, QRD,
>> +        ADP, CRD)
>> +      - a PMIC identifier is occasionally used when different PMICs are used
>> +        for a given board/SoC combination.
>> +  Each field and helper macros are defined at::
>> +      - include/dt-bindings/arm/qcom,ids.h
>> +
>> +  For example,
>> +    / {
>> +        #board-id-cells = <2>;
>> +        board-id = <456 0>, <457 0>, <10 0>;
>> +        board-id-types = "qcom,soc-id", "qcom,soc-id", "qcom,board-id";
>> +     }
>> +
>> +allOf:
>> +  - $ref: board-id.yaml#
>> +
>> +properties:
>> +  board-id:
>> +    minItems: 2
> I believe some older platforms match exclusively based on socid, so
> perhaps 1 would be okay as well.
>
> [...]

Ok, considering legacy targets we can make it 1.

But i think ideally it should always be recommended to have a board ID 
associated with a SoC ID, correct me if my understanding is wrong.

>> +examples:
>> +   - |
>> +     #include <dt-bindings/arm/qcom,ids.h>
>> +     / {
>> +         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
>> +         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
>> +
>> +         #board-id-cells = <2>;
>> +         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
>> +                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
>> +                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
>> +         board-id-types = "qcom,soc-id",
>> +                          "qcom,soc-id",
>> +                          "qcom,board-id";
> So, would the matching here would be:
>
> loop over disctinct board-id-types
> 	check if there's at least 1 match for all of them
> 		use this dtb if that's the case
>
> stop booting / "best guess match"
>
> ?
>
> [...]

Yes, But the "if" checking would have preference in place.
The preference logic would look something like this,

First will check for SoC-ID, if we have an exact match for SoC-ID then 
will proceed for board-ID match. Otherwise the DT would be discarded.
Once (exact) board-ID found, will proceed for subtype , pmic and so on.
Exact match and best match logic is used. Parameters like SoC-ID, 
board-ID are required to be best matched. Other few fields follow best 
match logic and best of the DT can be picked.

>> +#define QCOM_BOARD_ID_MTP		0x8
>> +#define QCOM_BOARD_ID_DRAGONBOARD	0x10
>> +#define QCOM_BOARD_ID_QRD		0x11
>> +#define QCOM_BOARD_ID_HDK		0x1F
>> +#define QCOM_BOARD_ID_ATP		0x21
>> +#define QCOM_BOARD_ID_IDP		0x22
>> +#define QCOM_BOARD_ID_SBC		0x24
>> +#define QCOM_BOARD_ID_QXR		0x26
>> +#define QCOM_BOARD_ID_CRD		0x28
> Missing ADP/QCP/Ride (if they're separate)

Sure, will update. Would need to work with teams.

Thanks,
Amrit.


