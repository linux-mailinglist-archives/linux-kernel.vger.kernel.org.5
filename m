Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB377559BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGQCrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQCrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:47:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705D1AA;
        Sun, 16 Jul 2023 19:47:13 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H0o73j007808;
        Mon, 17 Jul 2023 02:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SSfRCYihTeJpKG/7EGoim4dMbudIEn2CuBv+9YUMlH0=;
 b=d8cMXKA7Ka5Q6TWc0V8oK1dBBUOBiB+K4fIvGZCmeByxOI2WVeqyiU+eyjXhtahi60SR
 YIb5SlLiRowVuprS92gQ2ktIp+NoPNh7nwn/lVSRx4v1HnCSZAelzYhzq+rWUQAcH1tp
 aF7Vl/XdbkePxW92Gw1zpI4wBd/Jfzf7g7Zd6fHneOwLPcLXhJ3FNEQjgQf1+WX+b89n
 i1QJKGYEVeB+pI+QICpVHAgAo1hPVGgN06TpZ28OYeCmcc7QhIbhBLwt0sKJmJ57p6yC
 rrj8/qeYmOaHC8a6AS9XnCRvaalmKn6P5XH44KIADz9uuVW6JhGEHqgNy7/kuueSDIBM zQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1k2943-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 02:46:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H2kqW3013039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 02:46:52 GMT
Received: from [10.253.38.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 16 Jul
 2023 19:46:50 -0700
Message-ID: <b557fae5-21e7-8d72-1616-032458a529c7@quicinc.com>
Date:   Mon, 17 Jul 2023 10:46:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/6] net: phy: at803x: remove qca8081 1G fast retrain
 and slave seed config
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230716084924.9714-1-quic_luoj@quicinc.com>
 <20230716084924.9714-6-quic_luoj@quicinc.com>
 <8d2dd95b-13f7-41d8-997f-d5c2953dcb06@lunn.ch>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <8d2dd95b-13f7-41d8-997f-d5c2953dcb06@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q_JFM7kWmIX9ld_FZ21CvUF1myejNRLF
X-Proofpoint-ORIG-GUID: Q_JFM7kWmIX9ld_FZ21CvUF1myejNRLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_01,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=682
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170024
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2023 10:48 PM, Andrew Lunn wrote:
> On Sun, Jul 16, 2023 at 04:49:23PM +0800, Luo Jie wrote:
>> The fast retrain and slave seed configs are only applicable when the 2.5G
>> ability is supported.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> FYI: You normally have Signed-off-by: last. No need to resend, but
> please keep this in mind for the next patchset.
> 
>      Andrew

got it, thanks Andrew for the reminder.
