Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CEC805EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjLET6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLET63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:58:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE07A5;
        Tue,  5 Dec 2023 11:58:34 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5Gj8g8032027;
        Tue, 5 Dec 2023 19:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c/wZAY+ddHkdVkk/Vxl590rR18m0rlnIQ0ZhfkdjWpE=;
 b=cdpc7fldIFHxcvk+5soYY4pZIydLXNxMxyJVtBSEdooL7k/jnYLLX2eNuOViyW9vvNaJ
 DsGVaZAAmUyrrc5O8i08AIG/zKpgU/F4BtzLjGcrj9h+Z0Br3Hbga1wzB11kgEAT0nwJ
 xawdZoPfiJJKikGOxChPrGkdF8sZ8UY/mZNSXEJ+1139EG1oy2IJAdgqB7NDZIX9Q3lF
 o2qM+o3l9Tbt3ca3qDyzo+b+MZKTD8kb9LhwElF3F+BK4gbpd7vkK50yVs/vuUKApNNs
 9Ivcu277Jx4u2MgFzDZ19U7OGOPBh/EX8fF8FCaQp6q+XMHbitw/N7VbsEV0NuMAvh9T 1g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ut1a39dw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 19:58:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B5JwGPT026819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 19:58:16 GMT
Received: from [10.110.89.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 11:58:15 -0800
Message-ID: <91dcd8c3-ae86-4350-838d-62ddb62fa2bb@quicinc.com>
Date:   Tue, 5 Dec 2023 11:58:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package MMD
 read/write
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <workflows@vger.kernel.org>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
 <20231128133630.7829-3-ansuelsmth@gmail.com>
 <20231204181752.2be3fd68@kernel.org>
 <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
 <656f37a6.5d0a0220.96144.356f@mx.google.com>
 <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
 <ZW89errbJWUt33vz@shell.armlinux.org.uk> <20231205072912.2d79a1d5@kernel.org>
 <ZW9LroqqugXzqAY9@shell.armlinux.org.uk>
 <d2762241-f60a-4d61-babe-ce9535d9adde@quicinc.com>
 <ZW9oc9TO93kOq20s@shell.armlinux.org.uk>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZW9oc9TO93kOq20s@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tD30F0z24fRN8-Nigg0r7H_OegAYate3
X-Proofpoint-GUID: tD30F0z24fRN8-Nigg0r7H_OegAYate3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_15,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=554 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2023 10:14 AM, Russell King (Oracle) wrote:
> On Tue, Dec 05, 2023 at 09:44:05AM -0800, Jeff Johnson wrote:
>> So in my experience a function prototype IS the function definition, and
>> the actual function is just the implementation of that definition.
>>
>> But that thinking obviously isn't shared by others.
> 
> Interestingly, the view that a function prototype is a function
> definition does not seem to be shared by w3school, Microsoft, IBM,
> and many more.
> 
> If we look at the C99 standard, then 6.9.1 Function definitions gives
> the syntax as including a compound-statement, which is defined as
> requiring the curley braces and contents. Therefore, a function
> definition as defined by the C standard includes its body.
> 

Note I was speaking in terms of functional languages in general, not C
specifically. Perhaps I should have used the term "specification"
instead of "definition" (which would align with the Ada terminology).

Having worked with closed-source systems, especially VxWorks, for many
years (where the header files contain all the documentation), it just
seems strange to embed the documentation in the .c files.

/jeff


