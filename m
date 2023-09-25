Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0987ADF38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjIYSqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjIYSqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:46:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A2495;
        Mon, 25 Sep 2023 11:46:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PFMQWE000787;
        Mon, 25 Sep 2023 18:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Jr6k6269NdMSe/wZnFEItt6PcgwyvmPFe7xKMihrEfM=;
 b=b9IULkbGGYs+XbTcJvQXoyMclRcNaqox2nu83sx6YP7NkM9FvEKAkouX6z/tQA8WZJac
 TZYgOzA0cpvBnjinYAtlfK8rcZdieppDNQ3ttOhxRNoo9J3N+gktvv8eYseAS+eYtyly
 GtTPoUOh1n4Uux2rqdp0XVVWwMreMU8eqCOKmrzPN7TEO9xTDtpvdcJ2kZAiekSWNlT+
 a2eSrKeAd2H9/CrpnxdUeCswg9XWGAcw6rXKKAZZpfjTMmZRJyO3B2MvRFK0ddpJM41Q
 Vhfv3JOvESmgvZT4azp9bjEvQAwm7O3rqbfqPQ061K4h7e01Z0RbGRfgY6a9djtomPyA 1g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb6tt1d60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 18:46:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PIk3Ss031334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 18:46:03 GMT
Received: from [10.48.244.213] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 11:46:03 -0700
Message-ID: <c82d9d47-9c4b-4af9-a1e8-7c975b53fe30@quicinc.com>
Date:   Mon, 25 Sep 2023 11:46:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless 1/2] ath: dfs_pattern_detector: Fix a memory
 initialization issue
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Kalle Valo" <quic_kvalo@quicinc.com>,
        <linux-wireless@vger.kernel.org>
References: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uKXFCC1BcjHEwDCRqscCPID6gIha-rr1
X-Proofpoint-ORIG-GUID: uKXFCC1BcjHEwDCRqscCPID6gIha-rr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_15,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309250145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/2023 11:57 PM, Christophe JAILLET wrote:
> If an error occurs and channel_detector_exit() is called, it relies on
> entries of the 'detectors' array to be NULL.
> Otherwise, it may access to un-initialized memory.
> 
> Fix it and initialize the memory, as what was done before the commit in
> Fixes.
> 
> Fixes: a063b650ce5d ("ath: dfs_pattern_detector: Avoid open coded arithmetic in memory allocation")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Patch #1/2 is a fix, for for wireless.
> Patch #2/2 is for wireless-next I guess, but depnds on #1
> 
> Not sure if we can mix different target in the same serie. Let me know.
> 
> BTW, sorry for messing up things with a063b650ce5d :(
> ---
>   drivers/net/wireless/ath/dfs_pattern_detector.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/dfs_pattern_detector.c b/drivers/net/wireless/ath/dfs_pattern_detector.c
> index 27f4d74a41c8..2788a1b06c17 100644
> --- a/drivers/net/wireless/ath/dfs_pattern_detector.c
> +++ b/drivers/net/wireless/ath/dfs_pattern_detector.c
> @@ -206,7 +206,7 @@ channel_detector_create(struct dfs_pattern_detector *dpd, u16 freq)
>   
>   	INIT_LIST_HEAD(&cd->head);
>   	cd->freq = freq;
> -	cd->detectors = kmalloc_array(dpd->num_radar_types,
> +	cd->detectors = kcalloc(dpd->num_radar_types,
>   				      sizeof(*cd->detectors), GFP_ATOMIC);

nit: align descendant on (

>   	if (cd->detectors == NULL)
>   		goto fail;

