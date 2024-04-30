Return-Path: <linux-kernel+bounces-164677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683118B80F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EC81C22CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70201A0AF1;
	Tue, 30 Apr 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FF0FHltS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D43174EF1;
	Tue, 30 Apr 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507213; cv=none; b=uihn9/NTt7kqRKo9iErQHr2k1anN7VkPZ83jiQ1q+GeZcNyTgYorhmoRcKl8czblpOyLQUPOGjXcNrC57f7FYeLKM7ZIWdcE+Gdv/MDpPuM/bgbyRLSraxp9jkIyT7pr6Tlj07Qni7DZUUI1GwQpN61kizCMQgRfncus7OUNNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507213; c=relaxed/simple;
	bh=a0yrZPZEKYcyVZidoYzVQcM4ReLKOBzaNowogk7EJ0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GmHWbyZ46K2snMuqRFIf5ihVJmzGmx7154NT10DrnrxMdsRdfB3GArxVU3wm9NyGuOgmYagPB+uGocROGvT2u0qarnoqq13paykp4suPNtnjWdG+8lPLldL7jtHpjBaUkur5c6sVghCtC23PwTGZJc1OGkRrsUMgAJm3Gg+hDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FF0FHltS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UIxZUE023766;
	Tue, 30 Apr 2024 20:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=a0yrZPZEKYcyVZidoYzVQcM4ReLKOBzaNowogk7EJ0w=; b=FF
	0FHltStIiKnAUGo+dClS3AUKZaSiR4AWJpgcbFPp2Rtj6z5QtNEdsENYu1PKqhhB
	q95qMawFAGF0mEe5Sf8h+aRFVs4/guTdV82AqvTu2O5LLa5/KnMnRIzJr6+tjw7o
	dwGo6IiD87EzXGGJTI823W26hs6tHsSfZkUXNIvT52c1WyO7fteOU2m6cY0YTYck
	KOVQnU1+4swEvjssU9iUH4Piqx1+keXevo2NdmmswarnWXbnSv9ctu6DV48SC+rv
	o0JWmafwazkRQT6h1nHfOb4QrOnlLjjdzlflgsiDXJSyAxTKOQheJU/FsZjyB0H6
	r6Ec2Iq7LQup17xHYI7A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu6cug3av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 20:00:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UJxxj8003281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:59:59 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 12:59:58 -0700
Message-ID: <9983345a-d590-4a78-94ca-6d96832860b1@quicinc.com>
Date: Tue, 30 Apr 2024 12:59:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: Avoid address calculations via out of
 bounds array indexing
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook
	<keescook@chromium.org>
CC: Nathan Chancellor <nathan@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20240424220057.work.819-kees@kernel.org>
 <e2f20484fb1f4607d099d2184c1d74c6a39febc1.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e2f20484fb1f4607d099d2184c1d74c6a39febc1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZzcwzMuN5h_Vyv7lYwzGm3icX5xEMFDp
X-Proofpoint-GUID: ZzcwzMuN5h_Vyv7lYwzGm3icX5xEMFDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=430 mlxscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300143

On 4/30/2024 3:01 AM, Johannes Berg wrote:
> This really doesn't even seem right, shouldn't do pointer arithmetic on
> void pointers.

FWIW I argued this in the past in another context and Linus gave his opinion:

https://lore.kernel.org/all/CAHk-=whFKYMrF6euVvziW+drw7-yi1pYdf=uccnzJ8k09DoTXA@mail.gmail.com/


