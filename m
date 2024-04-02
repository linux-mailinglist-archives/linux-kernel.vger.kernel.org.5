Return-Path: <linux-kernel+bounces-127856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E048951BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7001C22BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73EA64CF9;
	Tue,  2 Apr 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="USt2QAJo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53455A4C7;
	Tue,  2 Apr 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056996; cv=none; b=JXomUOTz+WI/v0VOlwYSodAuHo+b0pWS4ZVuJzBa0iLhICx0u3SX+ggANGnJXhSQczipBMVSMOMvFFSYcJBGit9OlCQrx8k5wwC9G6DaN9nkcl8Dv8lycApdNHfXaS6uofKYIZ1GeO5etU0bniAQ+vfFCD0jpRWkJLVQe/45KvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056996; c=relaxed/simple;
	bh=morUMKR7wtRILPlFE9D6EyoFs/zj8kAJjMEuc8ZTiHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTiunl9CG983zSOzGf8MYzF4gik1w35OBN7WYGj6/6JFU4g4V6JOuHw/FH9JpEIxSNNX2vis0u7O14Jk/ULERjgXF8q2OwAbh6+hD2DpwBwIqeaUTfH7AhE0IQL4ZNVu+r+a7yIZdpCLByKkJy0nZhIXQLux/obQfJCerFJDEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=USt2QAJo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4323tw2w005834;
	Tue, 2 Apr 2024 11:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=0we4webLnenUhy33WZLG0
	feILlkWNth/g1ASVsyMqV8=; b=USt2QAJo1pUG3i+ESnZyQuCmwuWfMty04UEnq
	f8LjyuKm3jmuXUcu0rxf0AGv5wEi9WK3dZqM+zCbOmLfAZzbOppJJlQt46N6e3fV
	twriUhvn6ZTIok3OLFr83r95Js8PY183eKwfwHvcMUG8B/60wuUTD5v5pdWvotjs
	0YVmnCTpCPI29vie+6ErS0Vh+isb5oUB/c50wk37/Irwd/cdMWSlrysZt58igtTE
	/46aksgUueK+jub7ql66Jxz4lZszgYT6U+wMeL83Tp2TY68d4reATIR4mzR48rE4
	kjOt31l5WYmZnUMzGdyv6Hantozv/dhDPSmjHKxohMXV1/APw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x893ts59c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 11:23:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432BN601023545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 11:23:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 04:23:02 -0700
Date: Tue, 2 Apr 2024 16:52:58 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
Message-ID: <ZgvqkhF2mTG82Rx2@hu-varada-blr.qualcomm.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-4-quic_varada@quicinc.com>
 <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
 <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com>
 <ZgvlrbvvPNA6HRiL@hu-varada-blr.qualcomm.com>
 <CAA8EJpp2dgy0DcLoUuo6gz-8ee0RRwJ_mvCLGDbdvF-gVhREFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpp2dgy0DcLoUuo6gz-8ee0RRwJ_mvCLGDbdvF-gVhREFg@mail.gmail.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P8z6DNFXNn9OXxV3Jd_cdILWQpXl28xC
X-Proofpoint-ORIG-GUID: P8z6DNFXNn9OXxV3Jd_cdILWQpXl28xC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_05,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020082

On Tue, Apr 02, 2024 at 02:16:56PM +0300, Dmitry Baryshkov wrote:
> On Tue, 2 Apr 2024 at 14:02, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Tue, Apr 02, 2024 at 01:48:08PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, 2 Apr 2024 at 13:40, Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> > > > <quic_varada@quicinc.com> wrote:
> > > > >
> > > > > Wrap icc_clk_register to create devm_icc_clk_register to be
> > > > > able to release the resources properly.
> > > > >
> > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > ---
> > > > > v5: Introduced devm_icc_clk_register
> > > > > ---
> > > > >  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
> > > > >  include/linux/interconnect-clk.h |  4 ++++
> > > > >  2 files changed, 33 insertions(+)
> > > >
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >
> > > Wait. Actually,
> > >
> > > Unreviewed-by: me
> > >
> > > Please return int from devm_icc_clk_register instead of returning the pointer.
> >
> > Wouldn't returning int break the general assumption that
> > devm_foo(), returns the same type as foo(). For example
> > devm_clk_hw_get_clk and clk_hw_get_clk return struct clk *?
>
> Not always. The only reason to return icc_provider was to make it
> possible to destroy it. With devres-managed function you don't have to
> do anything.

Ok. Will change as follows

	return prov; -> return PTR_ERR_OR_ZERO(prov);

Thanks
Varada

