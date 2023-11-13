Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887DE7E9C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKMMnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKMMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:43:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CED5F;
        Mon, 13 Nov 2023 04:43:19 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADBvnjQ013242;
        Mon, 13 Nov 2023 12:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a5xXnSMcLkxSfgOKhdk3sXSJKhz64E4rd+8F7z1/o9M=;
 b=D7PEhoYxzqHIv6Piq844rC9s6H9T32l2Jg2E5RfjyluDkS8qCLOiBnVV1l30gRqbzzP5
 3h3MfvEqnzKZqRQJoMgppaQzjoVXeryPZaYzw+GmRxOHar7yobMvw35kMIvU6Qdl74t2
 uKBhkNFTZKfk4BWdUFhF5vfa3qV23iTiZ/L3jjTTFiF+Y3svycz8fZfuu3d2hiH3c+lv
 4ykr51AScLTlJp6EKz6PHJpSsMMhqGjMI+nmECfRkAVEB/qsx3NBG4TNZNF0oa7S0Q0i
 pLSeLbgH5upcxMMlur2EdEiH+WBx9/Utsl7r4llF7Qcg0YSTu667/aTLzoOEGPzWy76J FQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2sw3gev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 12:42:56 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ADCgtkY026004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 12:42:55 GMT
Received: from [10.253.72.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 04:42:53 -0800
Message-ID: <cc8ab317-fc79-4c66-b842-c7c3649d9299@quicinc.com>
Date:   Mon, 13 Nov 2023 20:42:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
To:     Vladimir Oltean <olteanv@gmail.com>
CC:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231108113445.24825-2-quic_luoj@quicinc.com>
 <20231108131250.66d1c236@fedora>
 <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
 <20231110103328.0bc3d28f@fedora>
 <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
 <20231111225441.vpcosrowzcudb5jg@skbuf>
 <39a8341f-04df-4eba-9cc2-433e9e6a798e@quicinc.com>
 <20231112235852.k36lpxw66nt7wh2e@skbuf>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231112235852.k36lpxw66nt7wh2e@skbuf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cnp8dByl68emEdxwiki8C0aUOfPRWixS
X-Proofpoint-GUID: cnp8dByl68emEdxwiki8C0aUOfPRWixS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=358 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/2023 7:58 AM, Vladimir Oltean wrote:
> On Sun, Nov 12, 2023 at 07:27:50PM +0800, Jie Luo wrote:
>> Sure Vladimir, Thanks for sharing this patch.
>>
>> BTW, When do you upstream this patch? or Maybe you can upstream the
>> separate patch for introducing the new interface mode 10g-qxgmii firstly? if
>> that, i can also update qca8084 phy driver based on
>> your patch.
> 
> I've removed the driver changes from the patch and formatted it on
> net-next. There's also one more dependency patch. Both are attached to
> this email.
> 
> I don't think I will find the time to upstream them by the time you
> need them. I think it would be best if you could take these patches,
> add your Signed-off-by: tag below mine, and submit them as the first 2
> patches of your own series.

OK, Vladimir, will take these two patches in the next updated patch set.
