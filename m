Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8667A7CAD70
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjJPP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPP0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:26:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA1583;
        Mon, 16 Oct 2023 08:26:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GDqkYC016148;
        Mon, 16 Oct 2023 15:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MyC9f2w4EEsPlVpNLnlyuAWHpwQt8r4G/toQCWixs/8=;
 b=DOEboIWieNTh9elHXLcw2qP1jt0wMIp1zsuNc7m3ISKuXV7PAi4bUUhozxzmthqewDC9
 PF8VBQhgcNmaeqoewRnxiCmORDttb5eMhmidSeQ/e0SE7PwteSUr1PEFCrB2ghv+q8CQ
 evWMWXi3g1OCLEPu2btQfkDLwGIZS6g6q6JzRf8GZ6Q6Knz1M47DCFgri8rWTc5MhW4l
 0+aRHWFSHZmkSJz/M00wEnIgnOxSPphliPBKC0K7KjPfzsTSM92ym+JgC3rWpEzt5icl
 ATxPKIP8acCriJwzMGgw93cewgdfutlcFnwJXSrAXd0PnxQmd11gPPzf3PsqPHNE3ssN PQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqgbt4p4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 15:26:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39GFQRsX005741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 15:26:27 GMT
Received: from [10.48.240.22] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 16 Oct
 2023 08:26:27 -0700
Message-ID: <bb95048f-2540-4d42-abb2-3132d33cd6c3@quicinc.com>
Date:   Mon, 16 Oct 2023 08:26:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: use vmm_table as array in wilc struct
Content-Language: en-US
To:     =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>,
        Michael Walle <mwalle@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        <stable@vger.kernel.org>
References: <20231016-wilc1000_tx_oops-v2-1-8d1982a29ef1@bootlin.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231016-wilc1000_tx_oops-v2-1-8d1982a29ef1@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hn3_gZv5TaIoq10NCTZuuGF58VgI8Baz
X-Proofpoint-ORIG-GUID: hn3_gZv5TaIoq10NCTZuuGF58VgI8Baz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_08,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=927
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2023 1:29 AM, Alexis Lothoré wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Enabling KASAN and running some iperf tests raises some memory issues with
> vmm_table:
> 
> BUG: KASAN: slab-out-of-bounds in wilc_wlan_handle_txq+0x6ac/0xdb4
> Write of size 4 at addr c3a61540 by task wlan0-tx/95
> 
> KASAN detects that we are writing data beyond range allocated to vmm_table.
> There is indeed a mismatch between the size passed to allocator in
> wilc_wlan_init, and the range of possible indexes used later: allocation
> size is missing a multiplication by sizeof(u32)
> 
> Fixes: 40b717bfcefa ("wifi: wilc1000: fix DMA on stack objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - keep dedicated dynamic allocation for vmm_table
> - Link to v1: https://lore.kernel.org/r/20231013-wilc1000_tx_oops-v1-1-3761beb9524d@bootlin.com
> ---
>   drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 58bbf50081e4..e4113f2dfadf 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -1492,7 +1492,7 @@ int wilc_wlan_init(struct net_device *dev)
>   	}
>   
>   	if (!wilc->vmm_table)
> -		wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE, GFP_KERNEL);
> +		wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE * sizeof(u32), GFP_KERNEL);

this is probably OK since the values are constant, but kcalloc() is 
generally preferred

>   
>   	if (!wilc->vmm_table) {
>   		ret = -ENOBUFS;
> 
> ---
> base-commit: ea12d85cbfd6b08fff40a4fefccc011b6cfadf8e
> change-id: 20231012-wilc1000_tx_oops-58ce91ee3e93
> 
> Best regards,

