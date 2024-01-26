Return-Path: <linux-kernel+bounces-40347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECDD83DEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368DE289794
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7D1DDF2;
	Fri, 26 Jan 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UPXyFR/3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9E1D699;
	Fri, 26 Jan 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287021; cv=none; b=i38E5pBI/fHAGzcG95m+M3+0KFj5YqiD7MfBQ1cgUkU/dI0rLnY1mWV4dAPcyZJzOZrtIoB90pBmfQksTu/PrDCGg/iT5/b8EucUXGLeIH4pSGsEHBn1deGf/CAHvXIsWPP1QVP6NLn+PQSfuhYAAnhuVk9ZRYvDQVpFRkj5DSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287021; c=relaxed/simple;
	bh=+Gpk2yaqevL/tKELrw8POyvIY7+60LPqnGrjBg05dwg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bldNunbjub6M8Fv5NOY4ANO4aOrLB5L+lERVWWEceWDkjEinC/S5db5O8xVrOvqo3W4et5fdY3D6JEopHzTg4s3htZ31vCb3h+/sC8TPJr+1mjDmcScXaGxLleS2eb8LXPjH8RQ62z602lZm4IWOuDZ2toq3bx67gNIBNcFA2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UPXyFR/3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QEpNav024654;
	Fri, 26 Jan 2024 16:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=iLD35NT4ii31i41EIvj0O
	4pQLJnvKEW1vumGl1xErFk=; b=UPXyFR/35WAPzESkqiR5Yi/tZdTM3u110xbrO
	v8f4o0oIfwnsCu2T0itcl0kV8QNcVdUeif7r2ZQA4gFmtcL138FwuoN6JwKbltbw
	9TCP4OHnmhEV8/jPcC4eCNBZPPNNv8HNm8et5dce+YoUtok9S0bjFGwxJH9Cxd7E
	xxnh3b4K1e1mdE4IYNsD/frLYAfCT5VitKMoekZxHQUMIaEunM5X3jsm0IRnvrEV
	gzM7IFJZ4H1d8AvMBCSMKFr3kjXIz3YwgDAfQmoAW0SxyzOBpuEOLivNA2Ch0mJ5
	wowki1KOCneIJMt3q421lNMt/UR3lteXhZWiN7bWTGTnn7JNw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4nr9k4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:36:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QGamTp021143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:36:48 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 08:36:47 -0800
Date: Fri, 26 Jan 2024 08:36:46 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Daniel Thompson <daniel.thompson@linaro.org>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Message-ID: <20240126163646.GR2936378@hu-bjorande-lv.qualcomm.com>
References: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
 <20240125-x13s-touchscreen-v1-2-ab8c882def9c@quicinc.com>
 <ZbNpdaSyFS9tYrkd@hovoldconsulting.com>
 <20240126130232.GA5506@aspen.lan>
 <ZbPCJv7HW8OQzPMT@hovoldconsulting.com>
 <20240126145346.GN2936378@hu-bjorande-lv.qualcomm.com>
 <ZbPcgqr9gBByqV7Q@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbPcgqr9gBByqV7Q@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: esmn1ks04H4O_INw-xeOmIQKrgwAfSU3
X-Proofpoint-GUID: esmn1ks04H4O_INw-xeOmIQKrgwAfSU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260122

On Fri, Jan 26, 2024 at 05:23:30PM +0100, Johan Hovold wrote:
> On Fri, Jan 26, 2024 at 06:53:46AM -0800, Bjorn Andersson wrote:
> > On Fri, Jan 26, 2024 at 03:31:02PM +0100, Johan Hovold wrote:
> > > On Fri, Jan 26, 2024 at 01:02:32PM +0000, Daniel Thompson wrote:
> 
> > > > In short it looks like the delays make the difference and, even a short
> > > > delay, can fix the problem.
> > > 
> > > Right, but since the suppliers are left enabled by the bootloader (and
> > > never disabled by the kernel), that only begs the question of why this
> > > makes a difference.
> > 
> > You're right, the supply is kept on by other things, so this isn't the
> > problem.
> > 
> > > Without the delay, the other HID devices are probing (successfully)
> > > slightly before, but essentially in parallel with the touchscreen while
> > > using the same resources. Is that causing trouble somehow?
> > 
> > The difference to those other HID devices is GPIO 99 - the reset pin,
> > which is configured pull down input from boot - i.e. the chip is held in
> > reset.
> > 
> > When the HID device is being probed, pinctrl applies &ts0_default starts
> > driving it high, bringing the device out of reset. But insufficient time
> > is given for the chip to come up so the I2C read fails.
> 
> Ah, that's it.
> 
> You should drop that 'output-high' from the pin config as part of this
> patch to avoid toggling the reset line twice at boot.
> 

Sounds reasonable, let's fix that while we're at it...

> Looks like we have the same problem on the CRD as well. There the
> touchscreen still works, possibly because it has been enabled by the
> boot firmware or simply because that touchscreen can handle a shorter
> delay.
> 

I only poke the CRD remotely, forgot that it had touchscreen. Let's
bake a patch for that as well...

> Where exactly did you find those delay values in the ACPI tables? I
> couldn't seem to find anything in the decompiled DSDT.
> 

The PEP sequence for the touchscreen device.

Regards,
Bjorn

> > If you later try to probe again, 200ms has elapsed since the reset was
> > deasserted (driven high).
> 
> Right.
> 
> Johan

