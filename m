Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78D76C9DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjHBJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjHBJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:51:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17FB212B;
        Wed,  2 Aug 2023 02:51:23 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3726xPt9002676;
        Wed, 2 Aug 2023 09:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a5NjeYH3HnsFOY6h/fPBHbvlp/RSe0G0J/X9vljpGpA=;
 b=mtU59eVcWaafJHOFq8n+96hhjQvsRo4v98zRJ5tg4yeNNnS//JU9qsOT5Z5w3u307uW/
 fKO0VbUV0MSN0ipqxLt3xIbIkd+5def8//iYKWjsP2nNdXD2bNWpiC6AaC1bNQMyEfpX
 LeRcOskRQZfhRDS1AVx4jCd3k9+lDcPu5JH1T+v/EsQUK1f0xEGz7VDwpIH1oXg0k6GM
 zmKmYxK3E9vfwxIOy4W0tgcu6ygQCvCJLJV5Zqg8jDho7QEfoC72J/OW9gGGn2cRYOUW
 v/qC08/VPJqBuelyhrRAT0b+RgjocyDlgMB4sTEwxy7mv3qPSSGJMuSchM0PgUMbHeH8 3w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6yq4avh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 09:50:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3729olVr013411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 09:50:47 GMT
Received: from [10.253.73.93] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 02:50:44 -0700
Message-ID: <5b647893-6208-e360-fea8-ba7496f6bc61@quicinc.com>
Date:   Wed, 2 Aug 2023 17:50:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
To:     Paolo Abeni <pabeni@redhat.com>, Leo Li <leoyang.li@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Bauer <mail@david-bauer.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Wei Fang <wei.fang@nxp.com>
References: <20230728215320.31801-1-leoyang.li@nxp.com>
 <20230728215320.31801-2-leoyang.li@nxp.com>
 <8071d8c5-1da3-47a0-9da2-a64ee80db6e5@lunn.ch>
 <AM0PR04MB6289323F6F93E197103A225D8F05A@AM0PR04MB6289.eurprd04.prod.outlook.com>
 <9912df2897bed863ad541807354d49db95970668.camel@redhat.com>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <9912df2897bed863ad541807354d49db95970668.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ePQbXI9HmfjcDAASCbowBFtEqOtazpux
X-Proofpoint-GUID: ePQbXI9HmfjcDAASCbowBFtEqOtazpux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_04,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020087
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2023 5:16 PM, Paolo Abeni wrote:
> On Mon, 2023-07-31 at 14:58 +0000, Leo Li wrote:
>>> -----Original Message-----
>>> From: Andrew Lunn <andrew@lunn.ch>
>>> Sent: Saturday, July 29, 2023 3:14 AM
>>> To: Leo Li <leoyang.li@nxp.com>
>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>; Russell King
>>> <linux@armlinux.org.uk>; David S . Miller <davem@davemloft.net>; Jakub
>>> Kicinski <kuba@kernel.org>; David Bauer <mail@david-bauer.net>;
>>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Viorel Suman
>>> <viorel.suman@nxp.com>; Wei Fang <wei.fang@nxp.com>
>>> Subject: Re: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
>>>
>>> On Fri, Jul 28, 2023 at 04:53:19PM -0500, Li Yang wrote:
>>>> In commit 7beecaf7d507 ("net: phy: at803x: improve the WOL feature"),
>>>> it seems not correct to use a wol_en bit in a 1588 Control Register
>>>> which is only available on AR8031/AR8033(share the same phy_id) to
>>>> determine if WoL is enabled.  Change it back to use
>>>> AT803X_INTR_ENABLE_WOL for determining the WoL status which is
>>>> applicable on all chips supporting wol. Also update the
>>>> at803x_set_wol() function to only update the 1588 register on chips having
>>> it.
>>>
>>> Do chips which do not have the 1588 register not have WoL? Or WoL
>>> hardware is always enabled, but you still need to enable the interrupt.
>>
>> Some of them do and some don't, which is removed in the other patch
>> from the series.  Since I don't find the register to enable it, I
>> guess it always enabled.
>>
>>>
>>> Have you tested on a range of PHY? It might be better to split this patch up a
>>> bit. If it causes regressions, having smaller patches can make it easier to find
>>> which change broken it.
>>
>> No, I only have AR8035 to test with.  Changes for other chips are
>> according to the datasheet.  It would be good if others having the
>> hardware can test it too.
> 
> Adding Luo Jie for awareness.
> 
> @Luo Jie: do you have access to other chips handled by this driver
> other then AR8035? could you please test this series:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=770734
> 
> ?
> 
> Thanks!
> 
> Paolo
> 

Hi Paolo & Leo,
To make WoL feature working, we need to enable bit 
MDIO_MMD_PCS.AT803X_PHY_MMD3_WOL_CTRL.AT803X_WOL_EN on both PHY
qca8081 and at803x, which does not depend on the 1588 feature.

The bit AT803X_INTR_ENABLE.AT803X_INTR_ENABLE_WOL is just for triggering 
the external WoL interrupt PIN when the WOL interrupt occurs.

Thanks,
Jie
