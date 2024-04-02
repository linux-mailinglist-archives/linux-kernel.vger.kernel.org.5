Return-Path: <linux-kernel+bounces-128531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB4895C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541A31C22EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAEA15B552;
	Tue,  2 Apr 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f0AqIV4K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4E1756A;
	Tue,  2 Apr 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084400; cv=none; b=H8wMoch36zqOT9D9k8cXLiwkVdObMPm2WGlQkNbfYU1VfoUIXZmb9oyJYV4UrbSmVpz4/SwoMoUDKXChrmThShw2zvuTWbeNYfma/0JJppMxS2Gwc77LM9yeaLHz/9NQGBOi51MWz1HPJQPlky6xFbQI2NV6nZSt5jZF2Itim1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084400; c=relaxed/simple;
	bh=XK2fdkBQ+MvvV6zIPd48I+1uIxWQKMWrst9IAvR7eiE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEDpN8kE8VNOSdN+LYAvdm5kCH83QmHtmHu96A01UhXomNyag560WVC6sMQfbmUjb9gQg2SIGzFJmynS4LfEAKE24pqu6o2rRldgEadBQEckFw1sLmEba8+yD9kh6mwQwz4KZ9yG314sNjm0y+plGHUH+XeLiiZKo0g1nbgJNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f0AqIV4K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HKXhI002709;
	Tue, 2 Apr 2024 18:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=VqCmabEEXms0gnwOlD8Gt
	pYxp5nGccGkYx0Om8wRvMM=; b=f0AqIV4KVw+LUR32FIJomBJy82lsek0rN4FGg
	+pWUVtIOQBeIzMbd1suTFVIGpFmKqCK0/nI5UWn2J9GNZ4Pij+OXv6kN57P9Qbhb
	zYGc3ENoiLzqxBm3wiBXhw075yPStaD1qtpXaplFzg3/D7/ZywQIez9FKvBAh3ii
	n19b9i2mVnciSQpwmAVubCFMb+uuKOjVTbqAJvnH7axh/kfW5/ME2ImFwIjAoeaT
	iKJZfaeoXeLpWyNCgd+KaisD0TwZ4vWoa8tbe7u8hL1zesM7qICNpId5UgWYAyz7
	FRKkZQM+bpO0C9cbn2xa2mpwqKrRhhZZj8BJcwQ9QKj56eXLw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8gn5hc1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:59:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432IxsSM008926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 18:59:54 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 11:59:54 -0700
Date: Tue, 2 Apr 2024 11:59:52 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Jonathan Corbet <corbet@lwn.net>, <workflows@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] docs: submitting-patches: describe additional tags
Message-ID: <ZgxVqIwPxiFtcBrB@hu-bjorande-lv.qualcomm.com>
References: <20240401-additional-trailers-v1-1-f472bf158d2f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240401-additional-trailers-v1-1-f472bf158d2f@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c3j5-wwZOkjC5JO4VVjP782aDnzOvVlc
X-Proofpoint-ORIG-GUID: c3j5-wwZOkjC5JO4VVjP782aDnzOvVlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020140

On Mon, Apr 01, 2024 at 08:17:03AM +0300, Dmitry Baryshkov wrote:
> Described tags do not fully cover development needs. For example the LKP
> robot insists on using Reported-by: tag, but that's not fully correct.
> The robot reports an issue with the patch, not the issue that is being
> fixed by the patch. Describe additional tags to be used while submitting
> patches.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/process/submitting-patches.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 66029999b587..3a24d90fa385 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -544,6 +544,25 @@ future patches, and ensures credit for the testers.
>  Reviewed-by:, instead, indicates that the patch has been reviewed and found
>  acceptable according to the Reviewer's Statement:
>  
> +Additional tags to be used while submitting patches
> +---------------------------------------------------
> +
> +The tags described previously do not always cover the needs of the development
> +process.
> +
> +For example, if the kernel test robot reports an issue in the patch, the robot
> +insists that the next version of the patch gets the Reported-by: and Closes:
> +tags.  While the Closes: tag can be considered correct in such a case, the
> +Reported-by: tag is definitely not correct. The LKP robot hasn't reported the
> +issue that is being fixed by the patch, but instead it has reported an issue
> +with the patch. To be more precise you may use the Improved-thanks-to: tag for
> +the next version of the patch.
> +
> +Another frequent case is when you want to express gratitude to the colleagues,
> +who helped to improve the patch, but neither the Co-developed-by: nor
> +Suggested-by: tags are appropriate. In such case you might prefer to use
> +Discussed-with:, Listened-by:, or Discussed-over-a-beer-with: tags.
> +

I really like the idea of defining two additional tags for these
purposes ("Improved-from-review-feedback/testing-by" and "Cred-to").

I do however think that in order to gain acceptance and widespread
usage, they need to be defined in the same clear fashion as the entires
under the "Using Reported-by:, Tested-by:, ..." section.

Regards,
Bjorn

>  Reviewer's statement of oversight
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> 
> ---
> base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
> change-id: 20240401-additional-trailers-2b764f3e4aee
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

