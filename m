Return-Path: <linux-kernel+bounces-103757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C2987C40C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFA7284230
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB7876054;
	Thu, 14 Mar 2024 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pD9zK5/t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468F7580B;
	Thu, 14 Mar 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446873; cv=none; b=Bcwt0ouxy40DMchrrgiALZbLcmPE+dsC2ryN2eOZbk769OpQO/rN5FqBiic+dvnPIU9m2S97Nf4mQvGrI+HuEHFl42bxZpNCDc4PCLVvLx3WEAwlTQMYehEih9L+Hiydm4YrFgXI0Q80cucoc+9V5w13X20zpE7IkVtqCRhffDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446873; c=relaxed/simple;
	bh=9A5EOtniYKawheI5A+IPoSnXdOL1RI0PftzjkJAaAjI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDQ2HcgLfVxRZmpmQoQ/WkntxGAWe3EZ0NK/XpSlLPj+DXLlm9nApeWERUxeJ25mflI0kNsZEw8Znf9+fUE2RF2oRD15iAjixD74qHafg4gOksvb4WNPXWeKvGkq9D7FIwNULXyOr2YC4oGi0JkN9CbAeYqQQzJze8WCuZwDBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pD9zK5/t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E5xD6c024159;
	Thu, 14 Mar 2024 20:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=3xlRjrOG++m/gTd4bJdiZ
	w0cFNOuDJJrYtP9qeXcXVA=; b=pD9zK5/tAYzW+EnwG6WHwGKjPc6FPCpWQk//a
	DaGqTOiXFZWZX/lipNXxm8IXqHzsBKaEHJtQswImHiCBLGmRiouns/FE8iEi0cPX
	M7yqFADDdzgaVJYHVtCefMBFDT5nsh/LnAYxmUGB3e4ZGzpb0ZYjibDIqLp1WIUk
	d9JljTfz3LzqF/NfKSTdDN4G1ZTOfuV1gZ/EaKVgw9BEGPnrGDfS60rR6ezPQ8RS
	bSfrIz83Vg9+Isfh1RjTCGlF+xOJXAceSK+7gxilWQ8uGxIPQ/7+C+8RKhWjUmCR
	n/1+yUbXbC5PcwdgL06svlPMLE1BzsOp63x2EfnowIN/YrZNA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuujssuyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:07:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EK7imb028294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:07:44 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 13:07:41 -0700
Date: Thu, 14 Mar 2024 13:07:40 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: Amrit Anand <quic_amrianan@quicinc.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>, <peter.griffin@linaro.org>,
        <linux-riscv@lists.infradead.org>, <chrome-platform@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>, Simon Glass <sjg@chromium.org>
Subject: Re: Re: [PATCH v2 2/2] dt-bindings: qcom: Update DT bindings for
 multiple DT
Message-ID: <20240314113908471-0700.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Caleb Connolly <caleb.connolly@linaro.org>, 
	Amrit Anand <quic_amrianan@quicinc.com>, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com, peter.griffin@linaro.org, 
	linux-riscv@lists.infradead.org, chrome-platform@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, Simon Glass <sjg@chromium.org>
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
 <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
 <f6f317d9-830d-4c38-998f-b229b3d9f95a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6f317d9-830d-4c38-998f-b229b3d9f95a@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6lGfARaeuwH6HOGWh8oo9c6RWsGScCpQ
X-Proofpoint-GUID: 6lGfARaeuwH6HOGWh8oo9c6RWsGScCpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 mlxlogscore=635 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140155

On Thu, Mar 14, 2024 at 02:20:38PM +0000, Caleb Connolly wrote:
> Hi Amrit,
> 
> On 14/03/2024 12:11, Amrit Anand wrote:
..
> >  
> > +examples:
> > +  - |
> > +    #include <dt-bindings/arm/qcom,ids.h>
> > +    / {
> > +         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
> > +         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
> > +
> > +         #board-id-cells = <2>;
> > +         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
> > +                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
> > +                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
> > +         board-id-types = "qcom,soc-id",
> > +                          "qcom,soc-id",
> > +                          "qcom,board-id";
> Forgive me if this is a particularly cynical view, but this seems
> incredibly blatant, the "qcom,board-id" property is deprecated for
> various good reasons, just using a key/value map where "qcom,board-id"
> is a key doesn't change that. There are two main issues I have with the
> proposal here:
> 
> 1. This breaks backwards compatibility, millions of production devices
> with bootloaders that will never receive another update might be
> compatible with the downstream "qcom,board-id" property, but they won't
> work with this.
> 2. A top level board-id property that isn't namespaced implies that it
> isn't vendor specific, but the proposed implementation doesn't even
> pretend to be vendor agnostic.
> 

I agree with the concerns you listed.

One point I wanted to bring is that if you provide a boot image that has
only one DTB, all production Qualcomm bootloaders I'm aware of will use
that DTB so long as "qcom,board-id" isn't a mismatch. I believe this is
what most everyone is doing if using the DTBs from kernel.org. We'd like
to use an open standard for DTB selection and that would very likely be
incompatible with existing bootloaders that don't have whatever that
standard is.

> U-Boot also has some ideas around this issue, there you can pass in
> multiple DTBs and provide some board specific "best match" function.
> I think there's definitely some value in exposing this information, but
> there's no good reason to define the same data as `qcom,board-id` while
> breaking production bootloaders.

One concern we have with U-Boot's approach is that it's based on
metadata external to the DTB and, in our experience, makes it hard to
track which board goes to which DTB. This approach also isn't
necessarily portable to other image types/boot flows.

Thanks,
Elliot


