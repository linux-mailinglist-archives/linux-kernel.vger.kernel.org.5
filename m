Return-Path: <linux-kernel+bounces-134606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBF789B386
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD7D1F20F5F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798C3C48E;
	Sun,  7 Apr 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iUzvG9FV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DE1C0DC5;
	Sun,  7 Apr 2024 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712514764; cv=none; b=mvr8Y1HBqIvSwNG8Yz5FJK+F7BeY24RQsMlO0N7uXsr4pu1wzHMiLoqgcbPxWtAxXVxbcBaxFYqMqe0PoGWwSKwkctHmTkmMASTfCIEgH1M+PFIY/CaRRZLbbvps5HyhzE/7DbyiQTwnInxVSOLYW3xPp3vQIA1BfQvuQ86oWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712514764; c=relaxed/simple;
	bh=HzkQQBG/yfRkSTo9hzDayTg2cP+FfBYSPRYBXPzw3Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eYvY/I99lkTl+k+lR7yJ3bEN72lEqMFHPF5VYMjg+C6jnk6R7mMR6ABiaA6yCp5wl3ee9m3/px875e4nl3zdcylPVwqIOI8CGa6uO3/ogefZPmRibpoerVHMRfTIenWxFIMZ0LQkPPhgDzE8lgOOsOHF31OHZZEGbUeOC00/ATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iUzvG9FV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 437IPF23019112;
	Sun, 7 Apr 2024 18:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vHN8aIPA4MWCXD6GTXJBjjbsC8NMxInK844BR7pqhAk=; b=iU
	zvG9FVA/+9Y8VLJULLu6XJ66IyNy0VL9fe2/TShFJmqz+CGxVR1slczZ/Br+6rVR
	SHNFG9Zy5QMhKFDdbvx+bzdAwSmecu6jr3SrCs/Ubce950CdvjBovWBzf8cnQQYK
	JXlKp39px0iA038Gi/kePSx/IurQKfKDRSzqrhLUGNEgzPcH9X5tf7yZPbNk24w/
	HLvZWTmFemE5zfWwWVr0jv0iwwzk76iyITCVSGPZfi5YiiBRW25QysW09M9POS6h
	PTm3e4vA+Xuzr1SlbR7C5PTeeEcCxnjkmcbhuugt/AcyD1GLU8kw7uOFIEyVLpyN
	tndiMqCNpigWAjS1WunQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xawbv25jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 18:29:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 437IT11R017900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 18:29:01 GMT
Received: from [10.110.80.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 7 Apr 2024
 11:29:01 -0700
Message-ID: <d409c77b-f4fa-4c12-9467-1a9916f697ef@quicinc.com>
Date: Sun, 7 Apr 2024 11:29:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ar5523: enable proper endpoint verification
Content-Language: en-US
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Kalle Valo
	<kvalo@kernel.org>
CC: Wu Yunchuan <yunchuan@nfschina.com>,
        Johannes Berg
	<johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
        <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
References: <20240407150534.26737-1-n.zhandarovich@fintech.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240407150534.26737-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4gMZI9ZllN1XgdEtB3bxT8meZ-ajjSuB
X-Proofpoint-GUID: 4gMZI9ZllN1XgdEtB3bxT8meZ-ajjSuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=877 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404070150

On 4/7/2024 8:05 AM, Nikita Zhandarovich wrote:
[...]
> diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
> index 815f8f599f5d..5cac4a6452db 100644
> --- a/drivers/net/wireless/ath/ar5523/ar5523.c
> +++ b/drivers/net/wireless/ath/ar5523/ar5523.c
> @@ -1594,6 +1594,20 @@ static int ar5523_probe(struct usb_interface *intf,
>  	struct ar5523 *ar;
>  	int error = -ENOMEM;
>  
> +	static u8 bulk_ep_addr[] = {

add 'const' qualifier

> +		AR5523_CMD_TX_PIPE | USB_DIR_OUT,
> +		AR5523_DATA_TX_PIPE | USB_DIR_OUT,
> +		AR5523_CMD_RX_PIPE | USB_DIR_IN,
> +		AR5523_DATA_RX_PIPE | USB_DIR_IN,
> +		0};
> +
> +	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr)) {
> +		dev_err(&dev->dev,
> +			"Could not find all expected endpoints\n");
> +		error = -ENODEV;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Load firmware if the device requires it.  This will return
>  	 * -ENXIO on success and we'll get called back afer the usb
> 


