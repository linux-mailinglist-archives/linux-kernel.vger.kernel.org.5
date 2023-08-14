Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE177C371
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjHNW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjHNW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:28:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E85171A;
        Mon, 14 Aug 2023 15:28:29 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ELhZbL010009;
        Mon, 14 Aug 2023 22:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Wif1oq0DHEy5UWGIznmQNwtwGJzn/tUSejbg2LV0+xM=;
 b=KVBokM2uoMoHknU62NOnin0x/rC0oxv4dv3E14pJqbTq0j2cu798Iv7eNPsesOm51Fen
 wCO9xUWN/BqepLdwZaBqiG5CqiXb1eIOe/tA1BBrVHhms4i7DoxQVJ3JRYKoBKYKEuLh
 MVQ8wx7zgVZugQg70MR4fiVKbQF3s2iyiovy98lMcV2zjtwc1YWSTxR09IM+bJCZv5TB
 z+ECq5YOPrcmWxDNFM9b0YcW0QWueLJMxWUmXDsIlAaTagC2hPGxh9PsjEWoH8ou8Lam
 m+ENEfI1OfQve487usWuHneqmCGwM2CwKOQaoOtXBC+8iQzKI/QEx23SbrgOZ4ICy7wj SQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfh74hgxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 22:28:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EMSKsM025357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 22:28:20 GMT
Received: from [10.48.240.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 15:28:19 -0700
Message-ID: <01fc3da3-dc67-8873-dd59-f77a7d067f33@quicinc.com>
Date:   Mon, 14 Aug 2023 15:28:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ath5k: fix WARNING opportunity for swap.
Content-Language: en-US
To:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>,
        <jirislaby@kernel.org>, <mickflemm@gmail.com>, <mcgrof@kernel.org>,
        <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20230814200234.637583-1-mahmoudmatook.mm@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230814200234.637583-1-mahmoudmatook.mm@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YBU0J004caSdKnRzn9553Kp782crBrwO
X-Proofpoint-GUID: YBU0J004caSdKnRzn9553Kp782crBrwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=929 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2023 1:02 PM, Mahmoud Maatuq wrote:
> coccinielle reported the following:
> ./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()

Suggest you add something like:

This revealed that ath5k_hw_get_median_noise_floor() had open-coded 
sort() functionality. Since ath5k_hw_get_median_noise_floor() only 
executes once every 10 seconds, any extra overhead due to sort() calling 
it's "compare" and "swap" functions can be ignored, so replace the 
existing logic with a call to sort().

and before your SOB add:
Suggested-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> ---
> changes in v1:
> - replace the entire double loop with sort()
>    as suggested by Jiri Slaby <jirislaby@kernel.org>
> ---
>   drivers/net/wireless/ath/ath5k/phy.c | 29 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
> index 5797ef9c73d7..7ee4e1616f45 100644
> --- a/drivers/net/wireless/ath/ath5k/phy.c
> +++ b/drivers/net/wireless/ath/ath5k/phy.c
> @@ -26,6 +26,7 @@
>   
>   #include <linux/delay.h>
>   #include <linux/slab.h>
> +#include <linux/sort.h>
>   #include <asm/unaligned.h>
>   
>   #include "ath5k.h"
> @@ -1554,6 +1555,11 @@ static void ath5k_hw_update_nfcal_hist(struct ath5k_hw *ah, s16 noise_floor)
>   	hist->nfval[hist->index] = noise_floor;
>   }
>   
> +static int cmps16(const void *a, const void *b)
> +{
> +	return *(s16 *)a - *(s16 *)b;
> +}
> +
>   /**
>    * ath5k_hw_get_median_noise_floor() - Get median NF from history buffer
>    * @ah: The &struct ath5k_hw
> @@ -1561,25 +1567,16 @@ static void ath5k_hw_update_nfcal_hist(struct ath5k_hw *ah, s16 noise_floor)
>   static s16
>   ath5k_hw_get_median_noise_floor(struct ath5k_hw *ah)
>   {
> -	s16 sort[ATH5K_NF_CAL_HIST_MAX];
> -	s16 tmp;
> -	int i, j;
> -
> -	memcpy(sort, ah->ah_nfcal_hist.nfval, sizeof(sort));
> -	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX - 1; i++) {
> -		for (j = 1; j < ATH5K_NF_CAL_HIST_MAX - i; j++) {
> -			if (sort[j] > sort[j - 1]) {
> -				tmp = sort[j];
> -				sort[j] = sort[j - 1];
> -				sort[j - 1] = tmp;
> -			}
> -		}
> -	}
> +	s16 sorted_nfval[ATH5K_NF_CAL_HIST_MAX];
> +	int i;
> +
> +	memcpy(sorted_nfval, ah->ah_nfcal_hist.nfval, sizeof(sorted_nfval));
> +	sort(sorted_nfval, ATH5K_NF_CAL_HIST_MAX, sizeof(s16), cmps16, NULL);
>   	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX; i++) {
>   		ATH5K_DBG(ah, ATH5K_DEBUG_CALIBRATE,
> -			"cal %d:%d\n", i, sort[i]);
> +			"cal %d:%d\n", i, sorted_nfval[i]);
>   	}
> -	return sort[(ATH5K_NF_CAL_HIST_MAX - 1) / 2];
> +	return sorted_nfval[(ATH5K_NF_CAL_HIST_MAX - 1) / 2];
>   }
>   
>   /**

