Return-Path: <linux-kernel+bounces-121560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5819288EAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83EEB3E0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217081386BF;
	Wed, 27 Mar 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iz9Gw0BZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC15134CC0;
	Wed, 27 Mar 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554280; cv=none; b=WV1IzF0lI0ejK2M5ZCdcSHCrEdL3BGjIlVgOoDCA+cuvP/DACHx8Ui8a2ftdITA/9Ihu6TI3S8ff1b9i6AWhmqPjUnu46nvH8JZ4WhOYQs5WVvqQ3a4MVyXDB/J2WKJjI/2KefjLeHON7tHfK23968zwqOk+FHiEfOm/H3Euvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554280; c=relaxed/simple;
	bh=8RixWcSd2JJyYLHi087rVeRA/JkQ9IP17D2hcMIULYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k+iPlsZl9l5f3gZ9Hucr12CJJVV2nnfjB3ntYFqIN1mL9U2TCwmwpWlpsmBH6gqAQgJ2QwbX3tqfA8eqUoV8mBLl0r29jhcuajSG2QOXdkP1PuU8ecjRorc0qNRthKSMCYuLcLMAjAKuBauOCXBLhGg2dRx79LLWw7BcXW4BE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iz9Gw0BZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RAQv8N021075;
	Wed, 27 Mar 2024 15:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8DoMiz8HpEkPB1xE3p2eeM8oOzoz/X+6OQFWHtIe7wY=; b=iz
	9Gw0BZH1FCzh/4v+cjUrBF3yu2dGmd6sCW2zGkJcdN++RmMIgqUfCnsYEabQvpOp
	spjRvN7LNJKyXd3/1sbNdZUZDh0LF0xSvpWK8FOBlmNhG6EoK+G/ScQ95C0NAfBM
	6o6dETSN7ylfYeZeuRhJ69sJd9Td3sFVrQXt2hCSG07ekvOmjGBsKCWUlkfZ1H3P
	djK51e4W6ywekm69jkbNb8s6rlWuAY81DYXraYrdz+eUoW/VmsYP4EW2UJhz6em2
	YZ1I9WxzUvXOPuzVoMxAm23mwapO4p9BJRVgMkQlnhcMWTaWvJH2wf9YoKHqZJ8G
	mKlxItByWUJxwu8dZh6A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4etk9atv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 15:42:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RFgucx017852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 15:42:56 GMT
Received: from [10.110.28.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 08:42:56 -0700
Message-ID: <00b1703a-47d7-4dc1-a3cd-f07f1a24db92@quicinc.com>
Date: Wed, 27 Mar 2024 08:42:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <keescook@chromium.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)"
	<linux-wireless@vger.kernel.org>,
        "open list:QUALCOMM ATHEROS ATH10K WIRELESS
 DRIVER" <ath10k@lists.infradead.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20240319104754.2535294-1-leitao@debian.org>
 <9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
 <20240321072821.59f56757@kernel.org>
 <5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
 <20240321151744.246ce2d0@kernel.org> <Zf2ceu2O47lLbKU3@gmail.com>
 <20240322082336.49f110cc@kernel.org> <ZgQvTTnMoBn2oG1K@gmail.com>
 <20240327074516.624b7ecf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240327074516.624b7ecf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9t0qFKztIXR9CV8_LmGTXfCo6DyZLgh_
X-Proofpoint-ORIG-GUID: 9t0qFKztIXR9CV8_LmGTXfCo6DyZLgh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=882
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270108

On 3/27/2024 7:45 AM, Jakub Kicinski wrote:
> On Wed, 27 Mar 2024 07:38:05 -0700 Breno Leitao wrote:
>>   -void init_dummy_netdev(struct net_device *dev)
>>   +void init_dummy_netdev_core(struct net_device *dev)
> 
> Can init_dummy_netdev_core() be a static function (and no export)?
> alloc_netdev_dummy() is probably going to be the only user.
> 
> I'd also lean towards squashing the two commits into one.

And once all of the conversions are complete, won't init_dummy_netdev() no
longer be used and can be removed?




