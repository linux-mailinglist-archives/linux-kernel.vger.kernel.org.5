Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8227F98F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjK0F4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0F4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:56:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7628F;
        Sun, 26 Nov 2023 21:56:12 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR5sFHh018175;
        Mon, 27 Nov 2023 05:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nlI8cWTeXYFoG1oJvZ938PdClUylpLDMRPsO/tEC1cM=;
 b=GQjpePUqxxgqZwJVWHz0ocJe30he/L4gpdtZY+v3MqtiSVNfWAqrdc08ao+73dAC4D6W
 kwJ1brNbaNnBDpFn2BWXzFgvZr2g5xK8N/Xz7h3O75pK3rvQSzFY2ZjuNto7cSgLebwv
 c+c8vLyXPccDgic09MbYt4FRhyYTvydbBZ7NFeJJjwDZePkj8KnT+psk5EY2Q0wFk2Iq
 tB/xfv5DiuI9NaCr+sXSu2cZj0O5Ckndj9Y18Q3hMH6kNCXWgwk4HoiGi0WutCKulcJe
 ibz3dvaI9u3TSwkEJcbG62EeXmzKq99/kT4XBvK2MFnC1oGLedRrDqwVH+2ITnzSGXZv wg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk9adk9kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 05:55:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AR5tkoW021046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 05:55:46 GMT
Received: from [10.216.37.62] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 26 Nov
 2023 21:55:38 -0800
Message-ID: <47c9eb95-ff6a-4432-a7ef-1f3ebf6f593f@quicinc.com>
Date:   Mon, 27 Nov 2023 11:25:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: update Rx clk divider for 10M SGMII
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
References: <20231124050818.1221-1-quic_snehshah@quicinc.com>
 <ZWBo5EKjkffNOqkQ@shell.armlinux.org.uk>
From:   Sneh Shah <quic_snehshah@quicinc.com>
In-Reply-To: <ZWBo5EKjkffNOqkQ@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m6oG0PAYAdRoiQlI4f-kSCLeC0qZhmxp
X-Proofpoint-GUID: m6oG0PAYAdRoiQlI4f-kSCLeC0qZhmxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=933 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You are right here for GENMASK(15,14) | BIT(10). I am using this to create a field value.I will switch to FIELD_PREP as that seems like a better way to do this.

This field programming is required only for 10M speed in for SGMII mode. other speeds are agnostic to this field. Hence we are programming it always when SGMII link comes up in 10M mode. init driver data for ethqos is common for sgmii and rgmii. As this fix is specific to SGMII we can't add this to init driver data.

On 11/24/2023 2:42 PM, Russell King (Oracle) wrote:
> On Fri, Nov 24, 2023 at 10:38:18AM +0530, Sneh Shah wrote:
>>  #define RGMII_CONFIG_LOOPBACK_EN		BIT(2)
>>  #define RGMII_CONFIG_PROG_SWAP			BIT(1)
>>  #define RGMII_CONFIG_DDR_MODE			BIT(0)
>> +#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)
> 
> So you're saying here that this is a 9 bit field...
> 
>> @@ -617,6 +618,8 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>>  	case SPEED_10:
>>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
>>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
>> +		rgmii_updatel(ethqos, RGMII_CONFIG_SGMII_CLK_DVDR, BIT(10) |
>> +			      GENMASK(15, 14), RGMII_IO_MACRO_CONFIG);
> 
> ... and then you use GENMASK(15,14) | BIT(10) here to set bits in that
> bitfield. If there are multiple bitfields, then these should be defined
> separately and the mask built up.
> 
> I suspect that they aren't, and you're using this to generate a _value_
> that has bits 5, 4, and 0 set for something that really takes a _value_.
> So, FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR, 0x31) or
> FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR, 49) would be entirely correct
> here.
> 
> The next concern I have is that you're only doing this for SPEED_10.
> If it needs to be programmed for SPEED_10 to work, and not any of the
> other speeds, isn't this something that can be done at initialisation
> time? If it has to be done depending on the speed, then don't you need
> to do this for each speed with an appropriate value?
> 
