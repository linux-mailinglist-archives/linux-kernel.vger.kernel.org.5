Return-Path: <linux-kernel+bounces-106878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4CE87F4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFCA1C21566
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC1A40;
	Tue, 19 Mar 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aOaQxjbW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F10F4FC;
	Tue, 19 Mar 2024 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710811071; cv=none; b=oSlgXsS8UnxiNxH+C48PF8gggQuOgsaX5Omh4K2TdjL0Ve3dchHCOd4ASQu4rMeQlyakuztvTw0J+qdjV44koa95GJHAcZJEKXe4TgRTr42Xh14q9aBnadyChAoFUc4VNXyXjm3P9N8wLMvsE4pxo6Z98gpF47HR/ZwVxmZ3P3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710811071; c=relaxed/simple;
	bh=296Aa5IYrw+k3OBNGji0A97d7DKH3UDMwHn5T5Ph/hw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glwPceXkCE7vRwyBAi+N4FGgytPVEWBlrE4K7M0j4ERZ7LmhzxtL0wLj2MaSpLEYI6aaqM6ICKJktAsF8XXi3v+SaYsUqU9vLf1Zxguwhe/T76qrCBcypqi2dH49+hVpt7QijsBumKjWaVrXxSVzONonsE8yEO1iPcvU3f6JWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aOaQxjbW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J0kunb023937;
	Tue, 19 Mar 2024 01:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=H7x/R1+R+BCgNC4W4I1mP
	HO8Zw8WK5UeRiKPms7Hmh8=; b=aOaQxjbWAt+CWON7aJhaxV05LSf5wBy2Z6Ow2
	5ItxFn+JRmfiSlIdG6BCaBNOb2xUUizP0T9AvudL1o7IMndgO+ot4Wu7aIVkfyFv
	tHmZX9NqSwHmSlNnHAvJY48ALQzK/zrkqZHsqFSI2B7Gzzzg+8vWeh6cIYAxj9xt
	KUVUQag8akV3jq0OabFy2wI6MIfg6TBctsj2DOpCEruoDGxJUA2yDRdVOBkswqoe
	ynN+DUAsxoz9xVhGU8LVNpii5ttgP+vKFjo+40kuJoykXEbr3+ctZZDurYb3Op8f
	rcvNgWNsq5wDbaebJLsSVHFKjQ3I95i2AZxFNl+1sLo0tQn6g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxmnjsnrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 01:17:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J1Hkdk025641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 01:17:46 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Mar 2024 18:17:43 -0700
Date: Tue, 19 Mar 2024 06:47:40 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v12 7/9] firmware: qcom: scm: Fix __scm->dev assignement
Message-ID: <03367100-1ad4-4d83-8200-5879550398be@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-8-quic_mojha@quicinc.com>
 <n2gomlmlzwodpg2v3gzuc62n3plewdqgiwctrv2tawdih26rig@obqd2a2ovqvp>
 <260371ff-da7a-8406-0511-4019f6b860bf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <260371ff-da7a-8406-0511-4019f6b860bf@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jnpVEGgqOve90oQlCkE5ZPbPm_TRA_JO
X-Proofpoint-ORIG-GUID: jnpVEGgqOve90oQlCkE5ZPbPm_TRA_JO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 mlxlogscore=987 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403190008

On Mon, Mar 18, 2024 at 06:38:20PM +0530, Mukesh Ojha wrote:
> 
> 
> On 3/3/2024 12:55 AM, Bjorn Andersson wrote:
> > On Tue, Feb 27, 2024 at 09:23:06PM +0530, Mukesh Ojha wrote:
> > > qcom_scm_is_available() gives wrong indication if __scm
> > > is initialized but __scm->dev is not.
> > > 
> > > Fix this appropriately by making sure if __scm is
> > > initialized and then it is associated with its
> > > device.
> > > 
> > 
> > This seems like a bug fix, and should as such have a Fixes: tag and
> > probably Cc: stable@vger.kernel.org
> > 
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > >   drivers/firmware/qcom/qcom_scm.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > > index 6c252cddd44e..6f14254c0c10 100644
> > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > > @@ -1859,6 +1859,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
> > >   	if (!scm)
> > >   		return -ENOMEM;
> > > +	scm->dev = &pdev->dev;
> > >   	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
> > >   	if (ret < 0)
> > >   		return ret;
> > > @@ -1895,7 +1896,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
> > >   		return ret;
> > >   	__scm = scm;
> > > -	__scm->dev = &pdev->dev;
> > 
> > Is it sufficient to just move the line up, or do we need a barrier of
> > some sort here?
> 
> Would be good to use, smp_mb() before the assignment
>      __scm = scm
> along with moving below line
> __scm->dev = &pdev->dev
> 

Full memory barrier is not needed here. store variant is sufficient.
WRITE_ONCE() + smp_store_release() will fit here no?

Thanks,
Pavan

