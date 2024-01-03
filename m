Return-Path: <linux-kernel+bounces-15566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED78822E36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8AF1C20441
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32AE199C0;
	Wed,  3 Jan 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UAR7ywbz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD4199A3;
	Wed,  3 Jan 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403D59J3029045;
	Wed, 3 Jan 2024 13:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MLmjvccV2jC5p6zINn45B3nzwnMb9oe4KxWl8hljtmA=; b=UA
	R7ywbzBvp2C+wiL6R5T96bEH5Rd/dN8vQGEjNlmmm8aOxlNe6sIKIN5aMKL0PNZd
	zoTBXgy/tLjfAE8gVS50QW3oYdqQSBUMrvWESSh7UR2tI5hIvj0/pR/e9TiyUqR0
	szfRm4bM3CNo5cdznxYuHWClmI8TQ60JyeIYsiEr0TgPn+7SiFZqy4uKt2MWBZpe
	YTGOYP+VxOpP3AYCZgqvsM+oTCPf1mFTH/Q7VdS8AYP9ZVq9WtT4iAvwC0EQKxhE
	E5ey/vH3fD5KjtmCN98IMKZSdtNN0DYTrZ75RyulKEhMW8alAtxlg1XeaUFlKv9Y
	WyF+G4YPXHWG6vA5wAHQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd84cr1kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:27:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403DR8RI032346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 13:27:08 GMT
Received: from [10.253.72.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 05:27:03 -0800
Message-ID: <63a7f0a7-a634-49a8-8502-abb117b6ca3c@quicinc.com>
Date: Wed, 3 Jan 2024 21:27:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] net: mdio: ipq4019: move eth_ldo_rdy before MDIO
 bus register
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-2-quic_luoj@quicinc.com>
 <ZZRG3eZJM5QouR9+@shell.armlinux.org.uk>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZZRG3eZJM5QouR9+@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ofke_IZcbAJSKmind8rdvuqCrfzHEOO2
X-Proofpoint-GUID: Ofke_IZcbAJSKmind8rdvuqCrfzHEOO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=844 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030110



On 1/3/2024 1:24 AM, Russell King (Oracle) wrote:
> On Mon, Dec 25, 2023 at 04:44:20PM +0800, Luo Jie wrote:
>> +/* Maximum SOC PCS(uniphy) number on IPQ platform */
>> +#define ETH_LDO_RDY_CNT				3
>> +
>>   struct ipq4019_mdio_data {
>> -	void __iomem	*membase;
>> -	void __iomem *eth_ldo_rdy;
>> +	void __iomem *membase;
>> +	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
> 
> Do you have any plans to make use of eth_ldo_rdy other than by code that
> you touch in this patch? If you don't, what is the point of storing
> these points in struct ipq4019_mdio_data ? You're using devm_ioremap()
> which will already store the pointer internally to be able to free the
> resource at the appropriate moment, so if your only use is shortly after
> devm_ioremap(), you can use a local variable for this... meaning this
> becomes (in addition to the other suggestion):

I will remove the eth_lod_rdy from the structure, which is only for
enabling LDO shortly, will update to use the local variable for this.
Thanks for review comments.

> 
>> +	/* This resource are optional */
>> +	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
>> +		if (res) {
>> +			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
>> +								res->start,
>> +								resource_size(res));
>> +
>> +			/* The ethernet LDO enable is necessary to reset PHY
>> +			 * by GPIO, some PHY(such as qca8084) GPIO reset uses
>> +			 * the MDIO level reset, so this function should be
>> +			 * called before the MDIO bus register.
>> +			 */
>> +			if (priv->eth_ldo_rdy[index]) {
>> +				u32 val;
>> +
>> +				val = readl(priv->eth_ldo_rdy[index]);
>> +				val |= BIT(0);
>> +				writel(val, priv->eth_ldo_rdy[index]);
>> +				fsleep(IPQ_PHY_SET_DELAY_US);
>> +			}
>> +		}
> 
> 		void __iomem *eth_ldo_rdy;
> 		u32 val;
> 
> 		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
> 		if (!res)
> 			break;
> 
> 		eth_ldo_rdy = devm_ioremap(&pdev->dev, res->start,
> 					   resource_size(res));
> 		if (!eth_ldo_rdy)
> 			continue;
> 
> 		val = readl(eth_ldo_rdy) | BIT(0);
> 		writel(val, eth_ldo_rdy);
> 		... whatever sleep is deemed required ...
> 
> Other issues:
> 
> 1. if devm_ioremap() fails (returns NULL) is it right that we should
>     just ignore that resource?

Since each LDO is independent, each LDO is for controlling the
independent Ethernet device, that should be fine to ignore the
failed resource.

> 
> 2. Do you need to sleep after each write, or will sleeping after
>     writing all of these do? It may be more efficient to detect when
>     we have at least one eth_ldo_rdy and then sleep once.
Yes, sleeping can be used after writing all of these, will update the
code as you suggest, thanks Russell.

> 
> Thanks.
> 

