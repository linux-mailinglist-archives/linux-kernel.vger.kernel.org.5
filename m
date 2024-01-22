Return-Path: <linux-kernel+bounces-33312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AAC836847
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424E1282A28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64326027D;
	Mon, 22 Jan 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LLE5PCUi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BA46559;
	Mon, 22 Jan 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935763; cv=none; b=osobGjl2zqOXpPDGfJ9mIRGUBmOVoKIgb9m8A39qIjhZHsySttnQUzkV9EUKAgo5W3hLKzgZDfbERIo3/S4Zk7zCQs0UeHkUv/0fF0+jijd2JqZKjk3GkUIqifpmZWMU3KM5ch68bC3vs0w6gZa8EM80yLheETi2XEMmkWhhR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935763; c=relaxed/simple;
	bh=8bGFmix80U9/t8wZwLZ5Rw+q5Uz4pSAAPOUtF8Qbh94=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=GhLIvtxxxHKnAUWxvWGXwoNlRMigW6piUH2xXbbfIgMhyTnybgm1s4gspC+cLD2q6yQBVsi0O6FVq5w8aTTIm+eW2Jk9jcc6oHSYWxIcBB2AgeSZ4Ec+Jm4o85ETzCn4laps2/Gd3+UtPKLmwVlkUMfLRorejL2DgZxoAlVfxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LLE5PCUi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MEEKRt023856;
	Mon, 22 Jan 2024 15:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HQT4IJbpgLyZu2gWdGASTg7GGU/7nlJGfQLF+O8FORE=; b=LL
	E5PCUiZBDKg8XqVuua7R999Yh9pC48m4tqG18SD1WAx0xYI+itnKZPLYT8clKoV1
	9moXCOpKjo/n/9ZtvP1MRVOL5QfrxYO2RqrF0v8cucDiLRw5tOJnDo/xLq2cbRtr
	9JyTOEdnirWWl/NG1i43JA7jnaNP3+HTPwGyJ94Td+MdK0mvgnCHw5oOMtc0xgDN
	fiA8nMxxoI/X9LoDFpMjBo2VOomcTwaHZNrk+OdEzQ+37l5EyBaQ8jV5j94d99mX
	ZJ1sUdS60CwKF5Wnc+IIUceB2UB0aHHc26pw0vkUK4i9yHY1EcYiPGzOyzd6U0cc
	vtQESgHJVipbP86uichg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsq7w0n1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 15:01:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MF1c2U009224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 15:01:38 GMT
Received: from [10.253.15.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 07:01:28 -0800
Message-ID: <fc9c3e08-a83c-4748-89e4-8b7b0c62da7f@quicinc.com>
Date: Mon, 22 Jan 2024 23:01:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Lei Wei <quic_leiwei@quicinc.com>
Subject: Re: [PATCH net-next 18/20] net: ethernet: qualcomm: Add PPE MAC
 support for phylink
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Luo Jie
	<quic_luoj@quicinc.com>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shannon.nelson@amd.com>,
        <anthony.l.nguyen@intel.com>, <jasowang@redhat.com>,
        <brett.creeley@amd.com>, <rrameshbabu@nvidia.com>,
        <joshua.a.hay@intel.com>, <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <jacob.e.keller@intel.com>, <andrew@lunn.ch>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryazanov.s.a@gmail.com>, <ansuelsmth@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110114033.32575-19-quic_luoj@quicinc.com>
 <ZZ6LGiSde4hHM+6j@shell.armlinux.org.uk>
Content-Language: en-US
In-Reply-To: <ZZ6LGiSde4hHM+6j@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rEqqTzP-nAa7s86SsOJYcDTm33YE2naW
X-Proofpoint-ORIG-GUID: rEqqTzP-nAa7s86SsOJYcDTm33YE2naW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=742 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401220102



On 1/10/2024 8:18 PM, Russell King (Oracle) wrote:
> On Wed, Jan 10, 2024 at 07:40:30PM +0800, Luo Jie wrote:
>> +static void ppe_phylink_mac_link_up(struct ppe_device *ppe_dev, int port,
>> +				    struct phy_device *phy,
>> +				    unsigned int mode, phy_interface_t interface,
>> +				    int speed, int duplex, bool tx_pause, bool rx_pause)
>> +{
>> +	struct phylink_pcs *pcs = ppe_phylink_mac_select_pcs(ppe_dev, port, interface);
>> +	struct ppe_uniphy *uniphy = pcs_to_ppe_uniphy(pcs);
>> +	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
>> +
>> +	/* Wait uniphy auto-negotiation completion */
>> +	ppe_uniphy_autoneg_complete_check(uniphy, port);
> 
> Way too late...
> 


Yes agree, this will be removed. If inband autoneg is used, 
pcs_get_state should report the link status.  Then this function call 
should not be needed and should be removed.

>> @@ -352,6 +1230,12 @@ static int ppe_port_maxframe_set(struct ppe_device *ppe_dev,
>>   }
>>   
>>   static struct ppe_device_ops qcom_ppe_ops = {
>> +	.phylink_setup = ppe_phylink_setup,
>> +	.phylink_destroy = ppe_phylink_destroy,
>> +	.phylink_mac_config = ppe_phylink_mac_config,
>> +	.phylink_mac_link_up = ppe_phylink_mac_link_up,
>> +	.phylink_mac_link_down = ppe_phylink_mac_link_down,
>> +	.phylink_mac_select_pcs = ppe_phylink_mac_select_pcs,
>>   	.set_maxframe = ppe_port_maxframe_set,
>>   };
> 
> Why this extra layer of abstraction? If you need separate phylink
> operations, why not implement separate phylink_mac_ops structures?
> 

This PPE driver will serve as the base driver for higher level drivers
such as the ethernet DMA (EDMA) driver and the DSA switch driver. The
ppe_device_ops is exported to these higher level drivers, to allow 
access to PPE operations. For example, the EDMA driver (ethernet 
netdevice driver to be pushed for review after the PPE driver) will use 
the phylink_setup/destroy ops for managing netdevice to PHY linkage. The 
set_maxframe op is also to be used by the EDMA driver during MTU change 
operation on the ethernet port.

I also mentioned it in the section "Exported PPE Device Operations" in 
PPE driver documentation:
https://lore.kernel.org/netdev/20240110114033.32575-2-quic_luoj@quicinc.com/

Whereas the PPE DSA switch driver is expected to use the phylink_mac 
ops. However，we will remove the phylink_mac ops from this patch now 
since it is currently unused.


