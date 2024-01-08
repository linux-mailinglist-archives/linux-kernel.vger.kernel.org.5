Return-Path: <linux-kernel+bounces-19860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C0682758F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72297B213DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19AD53E32;
	Mon,  8 Jan 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M3EvzQoy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905185381B;
	Mon,  8 Jan 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408ErPrY027212;
	Mon, 8 Jan 2024 16:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=FO86rpvOW1MW0cxKDcGsA
	aMDqrd90lBjORAQzptXprg=; b=M3EvzQoyEor08EFn7FMX1zLB35x9JI3dRoVKy
	sY7ZmYLpaY8SkQg/sX9PKzRoq9CGiKddKUIlagQysSQI9sKHy81uikmEIysL9/iU
	zwPCn4Hl2GnmlGN1dzm5GyoELkY55+Hwdh00oZ/+IRSpToXbNNxhkkQG+lkbGru4
	wIIdJZoOIe1bSvpRCpQs19IxB3fPpFeO6qb+LoElmG4Utk0a6/PhZmlVznvZVsv6
	0/ac/Wx+VoeI0TbgScBkfZSgkesPeuNuXohi22WqEaYIdwvCtgmkBw9rBGWALt8T
	sElUuthVLbvGORvIakwe7c6i74tNw+FwfEv25jpcluumvPaQw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vghkvgfyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 16:42:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408GgXjQ019690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 16:42:33 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 08:42:32 -0800
Date: Mon, 8 Jan 2024 08:42:31 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Kurapati PSSNV
	<quic_kriskura@quicinc.com>
Subject: Re: [PATCH 04/12] usb: dwc3: Expose core driver as library
Message-ID: <20240108164231.GI1315173@hu-bjorande-lv.qualcomm.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-4-ab4a84165470@quicinc.com>
 <ZV3ssSP5dTwAs-e3@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZV3ssSP5dTwAs-e3@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zMI_u-Lk-eYJNVznLh-3UAcDrA-xRHg9
X-Proofpoint-GUID: zMI_u-Lk-eYJNVznLh-3UAcDrA-xRHg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080141

On Wed, Nov 22, 2023 at 12:57:37PM +0100, Johan Hovold wrote:
> On Mon, Oct 16, 2023 at 08:11:12PM -0700, Bjorn Andersson wrote:
> > The DWC3 IP block is handled by three distinct device drivers: XHCI,
> > DWC3 core and a platform specific (optional) DWC3 glue driver.
> > 
> > This has resulted in, at least in the case of the Qualcomm glue, the
> > presence of a number of layering violations, where the glue code either
> > can't handle, or has to work around, the fact that core might not probe
> > deterministically.
> > 
> > An example of this is that the suspend path should operate slightly
> > different depending on the device operating in host or peripheral mode,
> > and the only way to determine the operating state is to peek into the
> > core's drvdata.
> > 
> > The Qualcomm glue driver is expected to make updates in the qscratch
> > register region (the "glue" region) during role switch events, but with
> > the glue and core split using the driver model, there is no reasonable
> > way to introduce listeners for mode changes.
> > 
> > Split the dwc3 core platfrom_driver callbacks and their implementation
> > and export the implementation, to make it possible to deterministically
> > instantiate the dwc3 core as part of the dwc3 glue drivers and to
> > allow flattening of the DeviceTree representation.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  drivers/usb/dwc3/core.c | 134 ++++++++++++++++++++++++++++++++----------------
> >  drivers/usb/dwc3/core.h |  10 ++++
> >  2 files changed, 100 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index d25490965b27..71e376bebb16 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1876,7 +1876,7 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
> >  	return 0;
> >  }
> >  
> > -static int dwc3_probe(struct platform_device *pdev)
> > +struct dwc3 *dwc3_probe(struct platform_device *pdev)
> 
> Perhaps you should move allocation of struct dwc3 to the caller as well
> as you are going to need some way to pass in callback to core which need
> to be set before you register the xhci platform device.
> 
> There could be other ways, like passing in a struct of callbacks, which
> can be added incrementally but it may be good think this through from
> the start.
> 

My intention was to have callbacks and quirks passed through additional
arguments in an incremental patch.

IMHO passing such information through a pre-allocated and partially
initialized struct is more obscure than passing that information as
explicit parameters to the function...

> >  {
> >  	struct device		*dev = &pdev->dev;
> >  	struct resource		*res, dwc_res;
> > @@ -1886,14 +1886,14 @@ static int dwc3_probe(struct platform_device *pdev)
> >  
> >  	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
> >  	if (!dwc)
> > -		return -ENOMEM;
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	dwc->dev = dev;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!res) {
> >  		dev_err(dev, "missing memory resource\n");
> > -		return -ENODEV;
> > +		return ERR_PTR(-ENODEV);
> >  	}
> >  
> >  	dwc->xhci_resources[0].start = res->start;
> > @@ -1922,7 +1922,7 @@ static int dwc3_probe(struct platform_device *pdev)
> >  
> >  	regs = devm_ioremap_resource(dev, &dwc_res);
> >  	if (IS_ERR(regs))
> > -		return PTR_ERR(regs);
> > +		return ERR_CAST(regs);
> >  
> >  	dwc->regs	= regs;
> >  	dwc->regs_size	= resource_size(&dwc_res);
> > @@ -1953,7 +1953,6 @@ static int dwc3_probe(struct platform_device *pdev)
> >  		goto err_disable_clks;
> >  	}
> >  
> > -	platform_set_drvdata(pdev, dwc);
> 
> This is broken however as the pm ops access the data driver data and can
> be called as soon as you call pm_runtime_put() below.
> 

You're right, thanks for spotting that.

Regards,
Bjorn

> >  	dwc3_cache_hwparams(dwc);
> >  
> >  	if (!dwc->sysdev_is_parent &&
> > @@ -2006,7 +2005,7 @@ static int dwc3_probe(struct platform_device *pdev)
> >  
> >  	pm_runtime_put(dev);
> 
> That is here.
> 
> > -	return 0;
> > +	return dwc;
>  
> > -static void dwc3_remove(struct platform_device *pdev)
> > +static int dwc3_plat_probe(struct platform_device *pdev)
> >  {
> > -	struct dwc3	*dwc = platform_get_drvdata(pdev);
> > +	struct dwc3 *dwc;
> > +
> > +	dwc = dwc3_probe(pdev);
> > +	if (IS_ERR(dwc))
> > +		return PTR_ERR(dwc);
> 
> And that leaves a window, for example, here where you can hit a NULL
> pointer dereference.
> 
> > +	platform_set_drvdata(pdev, dwc);
> > +
> > +	return 0;
> > +}
> 
> Johan
> 

