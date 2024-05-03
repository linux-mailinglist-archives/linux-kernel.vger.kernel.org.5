Return-Path: <linux-kernel+bounces-168085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0558BB376
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C503B1F24292
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51C57C8A;
	Fri,  3 May 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pEVFslJO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C42E646
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762193; cv=none; b=Y70Wq6McKflVMwHAg2XaL0KnncXKwxva/nYesfamcmWZv742+UAXNOSbNept6RA44nTJrLSZWaX/LRqWFZW8QCkEbXcFy+ie6mKN70M+tM0c/AraHEIPN6IZpnvu7tW19j9BAHTWKVcHVOrK0MCrbdYy7n1jrfQT6lq0vPwVZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762193; c=relaxed/simple;
	bh=yGw40/sPrzRGZYXQ4KjFa8YDK/5S6JDFw6lfLNvowjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fDZtGp00tpv7r62VMu1mqlAcmddPbkc2bviWCery1MCsUlXIHbHDhhSMjhoJGxlqvgh/dYyEvoT2ge6UQAwvOhy1twCs0ypCSIxvkCmbvjkLY3IKXxu4pbwq9Yx52xgozfUNutfTWJFaLjoqDheRwODrtqqHQ7dvjS6SZzoYzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pEVFslJO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443Hj0Yp014003;
	Fri, 3 May 2024 18:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=77hzGIyr9qM/bmZ3o2LLjXkvCbHgrrzMWUibQcn58ic=; b=pE
	VFslJOGHpZ/L09Q5397B+RLy7ZXdX2CbKtrxxLr+dYBSQVL7iF8DxCAvuulu76po
	hQaZhSRKYyH5ZJkDrzL0ijjkFPuGh1tYyqc6fuxHDL3ti+PpbAAytxoVLKVO24Q9
	smPpKrlZAwuWDo5Y3srOr6hqgOUD98h+ne10DvW9uqd4ryTzrtdlwFZsXZZTC/0+
	NYhGKyBRYJNd7rRYRYwgpnD71XaX2cqY3qCpMgkOk/leUqTm7t0p1h1P197c/7N6
	nT1gZJoYJo47d4VG8t6JxgC7Lp9NPHNlxe1/opG8FCGQgwqjRWzMsvKjSEccTii3
	nuLQK9xGPBiu91xV3rag==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xw2nc8d2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 18:49:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443InRNW019967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 18:49:27 GMT
Received: from [10.110.94.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 11:49:26 -0700
Message-ID: <3a0edfd7-fa22-434a-902d-a3a0df1c9d0f@quicinc.com>
Date: Fri, 3 May 2024 11:49:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mtd: cfi: Get rid of redundant 'else'
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20240503184230.2927283-1-andriy.shevchenko@linux.intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240503184230.2927283-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Sxuo-uLUCjxAOsviM6ODP59QscNBSQ_G
X-Proofpoint-GUID: Sxuo-uLUCjxAOsviM6ODP59QscNBSQ_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_13,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030133

On 5/3/2024 11:42 AM, Andy Shevchenko wrote:
> In the snippets like the following
> 
> 	if (...)
> 		return / goto / break / continue ...;
> 	else
> 		...
> 
> the 'else' is redundant. Get rid of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>  include/linux/mtd/cfi.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
> index 947410faf9e2..35ca19ae21ae 100644
> --- a/include/linux/mtd/cfi.h
> +++ b/include/linux/mtd/cfi.h
> @@ -308,32 +308,32 @@ static inline uint8_t cfi_read_query(struct map_info *map, uint32_t addr)
>  {
>  	map_word val = map_read(map, addr);
>  
> -	if (map_bankwidth_is_1(map)) {
> +	if (map_bankwidth_is_1(map))
>  		return val.x[0];
> -	} else if (map_bankwidth_is_2(map)) {
> +	if (map_bankwidth_is_2(map))
>  		return cfi16_to_cpu(map, val.x[0]);
> -	} else {
> -		/* No point in a 64-bit byteswap since that would just be
> -		   swapping the responses from different chips, and we are
> -		   only interested in one chip (a representative sample) */
> -		return cfi32_to_cpu(map, val.x[0]);
> -	}
> +	/*
> +	 * No point in a 64-bit byteswap since that would just be
> +	 * swapping the responses from different chips, and we are
> +	 * only interested in one chip (a representative sample)
> +	 */
> +	return cfi32_to_cpu(map, val.x[0]);
>  }
>  
>  static inline uint16_t cfi_read_query16(struct map_info *map, uint32_t addr)
>  {
>  	map_word val = map_read(map, addr);
>  
> -	if (map_bankwidth_is_1(map)) {
> +	if (map_bankwidth_is_1(map))
>  		return val.x[0] & 0xff;
> -	} else if (map_bankwidth_is_2(map)) {
> +	if (map_bankwidth_is_2(map))
>  		return cfi16_to_cpu(map, val.x[0]);
> -	} else {
> -		/* No point in a 64-bit byteswap since that would just be
> -		   swapping the responses from different chips, and we are
> -		   only interested in one chip (a representative sample) */
> -		return cfi32_to_cpu(map, val.x[0]);
> -	}
> +	/*
> +	 * No point in a 64-bit byteswap since that would just be
> +	 * swapping the responses from different chips, and we are
> +	 * only interested in one chip (a representative sample)
> +	 */
> +	return cfi32_to_cpu(map, val.x[0]);
>  }
>  
>  void cfi_udelay(int us);


