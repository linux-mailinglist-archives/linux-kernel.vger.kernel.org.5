Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1577EDC05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344854AbjKPHdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjKPHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:33:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC91EDD;
        Wed, 15 Nov 2023 23:32:59 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG4YTml026586;
        Thu, 16 Nov 2023 07:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c6bDfKqalMc1iw+BQ9T6nolF/0krV2p0p5oysDFOP/U=;
 b=Ef65JlJkWdZ3APeyyTXnDs4471g8Uo3xhhh26OGg2g0qZyE0cfpy7VWYbtFhIgL9+lCB
 DPLu/mcwHkF2ui28oS5xn0CmPBfvyMsLehk8Gfh51F3XOACNVE9+VB7+L3VaThSFwAJD
 oC1k73/w2hYDIw55qb8R/w+H86Z2vobT4qOuvD3u4CfLidxXVLmbEBxTHvKFUcy8iX/N
 PwMgFu+3x2s0EZ1+LIAuGE6O4+OuF8adblILdc7C7Jc2CA7RR3elw7tPRw39Z3Ion6fg
 Uq6DyR5/C2cj65MQ6FpuAiX/NqjIXqVGS2uIpLymFHwKwBnRSISoUGMjscN/ye7l0wwj ZQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud6ecgxgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 07:32:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG7Wi99025541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 07:32:44 GMT
Received: from [10.253.72.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 23:32:40 -0800
Message-ID: <7794de4e-b9d6-4b57-aaf1-466a848a311b@quicinc.com>
Date:   Thu, 16 Nov 2023 15:32:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] net: phylink: move phylink_pcs_neg_mode() to
 phylink.c
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20231115140630.10858-1-quic_luoj@quicinc.com>
 <20231115140630.10858-2-quic_luoj@quicinc.com>
 <ZVTSVIx+S+W/+X4B@shell.armlinux.org.uk>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZVTSVIx+S+W/+X4B@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IITavh1_vUoOiEH4AKM5mkWyHzosQOdl
X-Proofpoint-ORIG-GUID: IITavh1_vUoOiEH4AKM5mkWyHzosQOdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_04,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 10:14 PM, Russell King (Oracle) wrote:
> Hi,
> 
> You don't need this patch for your series, and you're bypassing my
> ability to decide when this patch should be merged (which is not yet,
> I want things to remain as-is for another cycle.)
> 
> In theory, looking at past history, 6.7 will probably be a LTS kernel,
> but until that is known for certain, I don't want to commit to moving
> this function in case LTS gets delayed by a cycle.
> 
> Please drop it from your series.
> 
> Thanks.

Got it, Russell.
I will drop this patch in the next patch set, Thanks.

> 
> On Wed, Nov 15, 2023 at 10:06:25PM +0800, Luo Jie wrote:
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> Russell points out that there is no user of phylink_pcs_neg_mode()
>> outside of phylink.c, nor is there planned to be any, so we can just
>> move it there.
>>
>> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/net/phy/phylink.c | 65 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/phylink.h   | 66 ---------------------------------------
>>   2 files changed, 65 insertions(+), 66 deletions(-)
>>
>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>> index 25c19496a336..162f51b0986a 100644
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
>> @@ -162,6 +162,71 @@ static const char *phylink_an_mode_str(unsigned int mode)
>>   	return mode < ARRAY_SIZE(modestr) ? modestr[mode] : "unknown";
>>   }
>>   
>> +/**
>> + * phylink_pcs_neg_mode() - helper to determine PCS inband mode
>> + * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
>> + * @interface: interface mode to be used
>> + * @advertising: adertisement ethtool link mode mask
>> + *
>> + * Determines the negotiation mode to be used by the PCS, and returns
>> + * one of:
>> + *
>> + * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
>> + * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
>> + *   will be used.
>> + * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
>> + *   disabled
>> + * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
>> + *
>> + * Note: this is for cases where the PCS itself is involved in negotiation
>> + * (e.g. Clause 37, SGMII and similar) not Clause 73.
>> + */
>> +static unsigned int phylink_pcs_neg_mode(unsigned int mode, phy_interface_t interface,
>> +					 const unsigned long *advertising)
>> +{
>> +	unsigned int neg_mode;
>> +
>> +	switch (interface) {
>> +	case PHY_INTERFACE_MODE_SGMII:
>> +	case PHY_INTERFACE_MODE_QSGMII:
>> +	case PHY_INTERFACE_MODE_QUSGMII:
>> +	case PHY_INTERFACE_MODE_USXGMII:
>> +		/* These protocols are designed for use with a PHY which
>> +		 * communicates its negotiation result back to the MAC via
>> +		 * inband communication. Note: there exist PHYs that run
>> +		 * with SGMII but do not send the inband data.
>> +		 */
>> +		if (!phylink_autoneg_inband(mode))
>> +			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
>> +		else
>> +			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
>> +		break;
>> +
>> +	case PHY_INTERFACE_MODE_1000BASEX:
>> +	case PHY_INTERFACE_MODE_2500BASEX:
>> +		/* 1000base-X is designed for use media-side for Fibre
>> +		 * connections, and thus the Autoneg bit needs to be
>> +		 * taken into account. We also do this for 2500base-X
>> +		 * as well, but drivers may not support this, so may
>> +		 * need to override this.
>> +		 */
>> +		if (!phylink_autoneg_inband(mode))
>> +			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
>> +		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>> +					   advertising))
>> +			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
>> +		else
>> +			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
>> +		break;
>> +
>> +	default:
>> +		neg_mode = PHYLINK_PCS_NEG_NONE;
>> +		break;
>> +	}
>> +
>> +	return neg_mode;
>> +}
>> +
>>   static unsigned int phylink_interface_signal_rate(phy_interface_t interface)
>>   {
>>   	switch (interface) {
>> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
>> index 875439ab45de..d589f89c612c 100644
>> --- a/include/linux/phylink.h
>> +++ b/include/linux/phylink.h
>> @@ -98,72 +98,6 @@ static inline bool phylink_autoneg_inband(unsigned int mode)
>>   	return mode == MLO_AN_INBAND;
>>   }
>>   
>> -/**
>> - * phylink_pcs_neg_mode() - helper to determine PCS inband mode
>> - * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
>> - * @interface: interface mode to be used
>> - * @advertising: adertisement ethtool link mode mask
>> - *
>> - * Determines the negotiation mode to be used by the PCS, and returns
>> - * one of:
>> - *
>> - * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
>> - * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
>> - *   will be used.
>> - * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
>> - *   disabled
>> - * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
>> - *
>> - * Note: this is for cases where the PCS itself is involved in negotiation
>> - * (e.g. Clause 37, SGMII and similar) not Clause 73.
>> - */
>> -static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
>> -						phy_interface_t interface,
>> -						const unsigned long *advertising)
>> -{
>> -	unsigned int neg_mode;
>> -
>> -	switch (interface) {
>> -	case PHY_INTERFACE_MODE_SGMII:
>> -	case PHY_INTERFACE_MODE_QSGMII:
>> -	case PHY_INTERFACE_MODE_QUSGMII:
>> -	case PHY_INTERFACE_MODE_USXGMII:
>> -		/* These protocols are designed for use with a PHY which
>> -		 * communicates its negotiation result back to the MAC via
>> -		 * inband communication. Note: there exist PHYs that run
>> -		 * with SGMII but do not send the inband data.
>> -		 */
>> -		if (!phylink_autoneg_inband(mode))
>> -			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
>> -		else
>> -			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
>> -		break;
>> -
>> -	case PHY_INTERFACE_MODE_1000BASEX:
>> -	case PHY_INTERFACE_MODE_2500BASEX:
>> -		/* 1000base-X is designed for use media-side for Fibre
>> -		 * connections, and thus the Autoneg bit needs to be
>> -		 * taken into account. We also do this for 2500base-X
>> -		 * as well, but drivers may not support this, so may
>> -		 * need to override this.
>> -		 */
>> -		if (!phylink_autoneg_inband(mode))
>> -			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
>> -		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>> -					   advertising))
>> -			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
>> -		else
>> -			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
>> -		break;
>> -
>> -	default:
>> -		neg_mode = PHYLINK_PCS_NEG_NONE;
>> -		break;
>> -	}
>> -
>> -	return neg_mode;
>> -}
>> -
>>   /**
>>    * struct phylink_link_state - link state structure
>>    * @advertising: ethtool bitmask containing advertised link modes
>> -- 
>> 2.42.0
>>
>>
> 
