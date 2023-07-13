Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55C7527E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGMQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjGMQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:00:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E0E2721;
        Thu, 13 Jul 2023 09:00:40 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DFw4J1027805;
        Thu, 13 Jul 2023 15:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fSArSgO9bwqrqif65MpBfx9WrYhxeS4WErOmQ5MnvHo=;
 b=iIOAUMiMEp0iK2hfVNCTqVVEttwDqCfXuNs0AubV/DlpIrCvGLvPylVbcuis1WCchxi5
 AhfvasUs6nVchC7GjQWJJsKTO2dCPFVqYeT1PMRE0hv4N3rmM0xY/3cryBZlriTIRmGU
 J8/Xo9KtUepEjXhdC0AjkSB+p8r6pEG3tlT8VNuZ/Wc4rQoiLIA2TvMWDQQ3jff0OuZz
 tAvULnOK9e0s9PI+g6aMHlux8NzvqOxfF+HAbifw/I+4bUtdPTFgCWqDGf6Pva+ilRRQ
 SPAFdZZ4MO8Ia7wye5FVaAD29Y7FZMaA2C2OLhJ/A2jM7IO/U6KaoO7r+THiWCh47hE9 4g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtbmus5h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 15:58:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DFw2QX006041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 15:58:02 GMT
Received: from [10.111.182.44] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 08:58:02 -0700
Message-ID: <96b788c1-91bf-94b1-5768-6745003b782a@quicinc.com>
Date:   Thu, 13 Jul 2023 08:58:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v1] net:wireless:Fix an NULL vs IS_ERR() bug for
 debugfs_create_dir()
Content-Language: en-US
To:     Wang Ming <machel@vivo.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Rajkumar Manoharan <rmanoharan@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Sujith Manoharan <Sujith.Manoharan@atheros.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>
References: <20230713030358.12379-1-machel@vivo.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230713030358.12379-1-machel@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pR5alaSA54_Tb_P-mZz6iSMfnHBirYMh
X-Proofpoint-ORIG-GUID: pR5alaSA54_Tb_P-mZz6iSMfnHBirYMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=883 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130140
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

correct subject prefix is "wifi: ath9k: "

On 7/12/2023 8:03 PM, Wang Ming wrote:
> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in ath9k_htc_init_debug() was forgotten.
> 
> Fix the remaining error check.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> 
> Fixes: e5facc75fa91 ("ath9k_htc: Cleanup HTC debugfs")
> ---
>   drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
> index b3ed65e5c4da..c55aab01fff5 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
> @@ -491,7 +491,7 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
>   
>   	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
>   					     priv->hw->wiphy->debugfsdir);
> -	if (!priv->debug.debugfs_phy)
> +	if (IS_ERR(priv->debug.debugfs_phy))
>   		return -ENOMEM;
>   
>   	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);

