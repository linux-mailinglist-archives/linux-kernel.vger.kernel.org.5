Return-Path: <linux-kernel+bounces-125647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C8892A10
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE79283312
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681DF9FF;
	Sat, 30 Mar 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k+gimahY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7009EADF;
	Sat, 30 Mar 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711791043; cv=none; b=Xk1D5/Kz3G29JBjVrvjgy0mtwRkdO4z8gjd7gFg4J0ly+xWxncuzmG0UQbOlVSQ61EFeS8eJ2n5oy4pZ+znvmw6uLsr09NulpVPPPo97UV/8qU6OZxdpreKjMBDwhgv+kyYLL3RPM4DCE2t/IbwVTYwb5xMbQRva20XTL+wevH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711791043; c=relaxed/simple;
	bh=O31tmMlYNDhIfcohA+3IDTmFUeZNs3Ca+9iLfjyJ85k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGvbP1PmWOpvJZULGO9m+z6ijjKq3aOGr097bfH4W/honWRCbaya2ZKXt6qn/8+bNB7sObM6KcMp6/C8AttWqY+ASpmYpd2vN8xWPBCyTh95VP/ssft58lca1a6phO7b9YN4zzCPXzEQItnHeGhUm2/fZC19nve9Ubl7s2FgiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k+gimahY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42U8mGiO024176;
	Sat, 30 Mar 2024 09:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=BqN2enxxA0AlYVe5KnB8a
	zdCJIlxTCplM68XTDaCFuY=; b=k+gimahYOblSKVY7s0EYR27OPf6KvbJUGFBB6
	2CWILwFB/Y4oujnIO3WsqY0lShUOqKWDJ41JoneZ+WYiHxQT2u3LWl09brp2kvzS
	t+YL+RB1j2St3Ris/8htcPLbYRpKoOEuDr9ASaJWV2mJZ88vVv71p8j7q0rQj1Ox
	kUhIi/Nx4s8ZGflc5VEgdv8ZJFzp9k21Pw7key4divm+oA4xehHNOv5BqBQu4pWE
	O03mIm8xfQ9LOqu8f0UPVLWWVfl5uQCKfVk0BJYSCkDhdcdhwgtmOYr+L3w3Wx0H
	xmKrSDz7FTcbRXPCOkqox5W0PWZpcowIVF4WMQkUGOquBZ2Mg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x69pvrpx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 09:30:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42U9UZSZ030761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 09:30:35 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 02:30:31 -0700
Date: Sat, 30 Mar 2024 15:00:27 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Stephen Boyd <sboyd@kernel.org>, <andersson@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mturquette@baylibre.com>, <quic_anusha@quicinc.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v5 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC
 related clocks
Message-ID: <Zgfbs5SFN2cA0gSK@hu-varada-blr.qualcomm.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com>
 <20240328075936.223461-5-quic_varada@quicinc.com>
 <95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org>
 <ZgaeGZL7QXh75aSA@hu-varada-blr.qualcomm.com>
 <031d0a35-b192-4161-beef-97b89d5d1da6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <031d0a35-b192-4161-beef-97b89d5d1da6@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MCE8G2q1LBiie2LNQErgRJhK3oRwQD5V
X-Proofpoint-GUID: MCE8G2q1LBiie2LNQErgRJhK3oRwQD5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_05,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=750 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403300077

On Fri, Mar 29, 2024 at 01:10:03PM +0100, Krzysztof Kozlowski wrote:
> On 29/03/2024 11:55, Varadarajan Narayanan wrote:
> >>> +
> >>> +enum {
> >>> +       ICC_ANOC_PCIE0,
> >>> +       ICC_SNOC_PCIE0,
> >>> +       ICC_ANOC_PCIE1,
> >>> +       ICC_SNOC_PCIE1,
> >>> +       ICC_ANOC_PCIE2,
> >>> +       ICC_SNOC_PCIE2,
> >>> +       ICC_ANOC_PCIE3,
> >>> +       ICC_SNOC_PCIE3,
> >>> +       ICC_SNOC_USB,
> >>> +       ICC_ANOC_USB_AXI,
> >>> +       ICC_NSSNOC_NSSCC,
> >>> +       ICC_NSSNOC_SNOC_0,
> >>> +       ICC_NSSNOC_SNOC_1,
> >>> +       ICC_NSSNOC_PCNOC_1,
> >>> +       ICC_NSSNOC_QOSGEN_REF,
> >>> +       ICC_NSSNOC_TIMEOUT_REF,
> >>> +       ICC_NSSNOC_XO_DCD,
> >>> +       ICC_NSSNOC_ATB,
> >>> +       ICC_MEM_NOC_NSSNOC,
> >>> +       ICC_NSSNOC_MEMNOC,
> >>> +       ICC_NSSNOC_MEM_NOC_1,
> >>> +};
> >>
> >> Are these supposed to be in a dt-binding header?
> >
> > Since these don't directly relate to the ids in the dt-bindings
> > not sure if they will be permitted there. Will move and post a
> > new version and get feedback.
>
> You can answer this by yourself by looking at your DTS. Do you use them
> as well in the DTS?

I can use them in the DTS. The icc-clk framework automatically
creates master and slave nodes as 'n' and 'n+1'. Hence I can have
something like this in the dt-bindings include file

	#define ICC_ANOC_PCIE0		0
	#define ICC_SNOC_PCIE0		1
		.
		.
		.
	#define ICC_NSSNOC_MEM_NOC_1	20

	#define MASTER(x)	((ICC_ ## x) * 2)
	#define SLAVE(x)	(MASTER(x) + 1)

> It's a pity we see here only parts of DTS, instead of full interconnect
> usage.

Unfortunately cannot include the pcie dts changes with this
patch, but you can refer to them at https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/

The above macros will be used in the pcie node as follows

pcie0: pci@28000000 {
	compatible = "qcom,pcie-ipq9574";
	. . .
	interconnects = <&gcc MASTER(ANOC_PCIE0) &gcc SLAVE(ANOC_PCIE0)>,
			<&gcc MASTER(SNOC_PCIE0) &gcc SLAVE(SNOC_PCIE0)>;
	interconnect-names = "pcie-mem", "cpu-pcie";
	. . .
};

Hope this is acceptable.

Thanks
Varada

