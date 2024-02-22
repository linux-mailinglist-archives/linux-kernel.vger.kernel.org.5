Return-Path: <linux-kernel+bounces-75960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9779485F129
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F14283B47
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B77175B5;
	Thu, 22 Feb 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s38UhaES"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C10125CE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581374; cv=none; b=XS0OBMWabQ/AD3dyhbPXy7NGLvxEyJZp7MzORopj1Bk5JW9+LDcrKNOE/grRnQCbyl674br578/x/ueisaF4x4jBhoIXfmYh0laC8VNaNDfz0u5Qn+vHRPkrglLjBjzu7Db/hpbzn+sDjCvlOxkJ9riVOTKurtK/AHKcSzXJhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581374; c=relaxed/simple;
	bh=F5IraG7ieKlrDZyPpTV4KrEQY2qiDUaPk71BZjUt+4w=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=KIPTb3+7cbk6XNkOxHFuA7BFTkSfVN1qKJr8jmA4xjRFcMZIVlqvokEDwuAPaqtn+4QCoE1DN04GAzlwiSSnF3An8o9zrkCVSlZm1hxEfVwu7oY08YFb/w3mlKo5Fw86ASUpOpPWy+fwaW4gEj6fU08GGsWyv0oiwaBVdhvI3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=s38UhaES; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240222055602epoutp018d4f6d7ad446147157f44e35166da53b~2GbJgH3Rd0972409724epoutp01Z
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:56:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240222055602epoutp018d4f6d7ad446147157f44e35166da53b~2GbJgH3Rd0972409724epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708581362;
	bh=hD8FsSBm5jVSL8LOze+8LvsZcmKlon4NO6ECn5MEzhs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=s38UhaESDBGi7qyLd7UNAEcbhowwu4mO1tBWn2of8pmZDuwRDL+LoEq4eZ0mx8m4h
	 0ei7NgSJXDj1oeipW/KJisJgGaFgwdeu8jbPPK5dBzNegm7Ux7FtUniHQdE3u9uTRn
	 Ntf+CgTHN49rG0IOfu4HijFB62kdMUlwdEwGbjiY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240222055601epcas1p4cabf02e9c596088ec9b35094294ac266~2GbI-x2no3136731367epcas1p4W;
	Thu, 22 Feb 2024 05:56:01 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.233]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TgMns0VHvz4x9QL; Thu, 22 Feb
	2024 05:56:01 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.A5.09739.0F1E6D56; Thu, 22 Feb 2024 14:56:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240222055600epcas1p29c5bc5ae90d58cde48229e682e1e65fc~2GbH26uA21672416724epcas1p2l;
	Thu, 22 Feb 2024 05:56:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240222055600epsmtrp2abeb0e1d3795ad156f605fe5a67e5784~2GbH2OePd1097110971epsmtrp2h;
	Thu, 22 Feb 2024 05:56:00 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-a9-65d6e1f07865
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.0C.08817.0F1E6D56; Thu, 22 Feb 2024 14:56:00 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240222055600epsmtip29c894bfd1c12865901ad7b50c5213a5b~2GbHoP1__1995619956epsmtip2P;
	Thu, 22 Feb 2024 05:56:00 +0000 (GMT)
From: "Chanwoo Choi" <cw00.choi@samsung.com>
To: "'Randy Dunlap'" <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
Cc: "'Arnd Bergmann'" <arnd@arndb.de>, "'MyungJoo Ham'"
	<myungjoo.ham@samsung.com>, "'Marc Zyngier'" <maz@kernel.org>, "'Philipp
 Zabel'" <p.zabel@pengutronix.de>, "'Peter Rosin'" <peda@axentia.se>, "'Greg
 Kroah-Hartman'" <gregkh@linuxfoundation.org>
In-Reply-To: <20240213060028.9744-1-rdunlap@infradead.org>
Subject: RE: [PATCH v2] extcon: max8997: select IRQ_DOMAIN instead of
 depending on it
Date: Thu, 22 Feb 2024 14:56:00 +0900
Message-ID: <001101da6553$cfee68d0$6fcb3a70$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQKmphEMssREiDbY/hBxrofQO+dJJQMCCGwir2VLJ9A=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmvu7Hh9dSDX6WW/yddIzdonnxejaL
	y7vmsFnsnHOS1eJ24wo2i7v3TrBY7D00n9Hi7Z3pLA4cHr9/TWL0mHZgNrvH5hVaHptWdbJ5
	7J+7ht2j/6+BR9+WVYwenzfJBXBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
	KynkJeam2iq5+AToumXmAN2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwLdAr
	TswtLs1L18tLLbEyNDAwMgUqTMjO6L07h63gkUDFhe2vWBsYn/J2MXJySAiYSOx6MYmpi5GL
	Q0hgB6PEzZW7mSGcT4wSZx9vZYVwvjFK/F68jR2mpX/6eaiqvYwSNy40QzkvGSVev24CquLg
	YBPQkVjwIxSkQUTAR+L16WOMIDazwH9GiVePbUFKOAWsJG7NCwYJCwuES/yafIINxGYRUJU4
	++AOmM0rYCnxecZaRghbUOLkzCcsEGPkJba/ncMMcY+CxM+ny1gh4iISszvbmCHWWkm8X7sc
	7AEJgR0cEocXr2CBaHCR6OpfxwhhC0u8Or4F6jEpic/v9rJBNExmlLj4+jUzhLOeUWLjyhao
	dcYS+5dOZgL5gFlAU2L9Ln2IzXwS7772sIKEJQR4JTrahCCqlSUuP7jLBGFLSixu72SDKPGQ
	eL3VegKj4iwkr81C8tosJO/MQti1gJFlFaNYakFxbnpqsWGBMTyyk/NzNzGCk6yW+Q7GaW8/
	6B1iZOJgPMQowcGsJMLLUn4lVYg3JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnA9N8Xkm8oYml
	gYmZkbGJhaGZoZI475krZalCAumJJanZqakFqUUwfUwcnFINTEuehpcZ2n1Ykd0tYqt7cOnk
	r/ZZ8tE/Rae+dfm54kOEi6+0d/W6fuPvUe3iVkbv75732X82c++NzVeZvzXNUzq64MUHj18T
	LVglrpozP80R8v6pfmkyQ8WLb7oqfF3nVgtk2AaGL0r7cPDXTcudITGCoX4hqzee2MjxMUvI
	RHxv9Ps5Imsz9z7SXrovtU3f8KbUnPNRGc8MTNeznBBassvXmqdafGdQ6ZHE1uLPHFO/Jq8y
	+hzpc2unx1bFJbo7uddnzpgXMKM16Fn7Fxt3i40brHdV/32z9KAPe2joKoFAw5dXgvYc5V2+
	Zo9t8c7WRKEv3/KOH9s1e+Gn2YW3y5mZV13v4j+sVi0SKLIhzleJpTgj0VCLuag4EQD0EWKR
	OwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvO6Hh9dSDTZu0bT4O+kYu0Xz4vVs
	Fpd3zWGz2DnnJKvF7cYVbBZ3751gsdh7aD6jxds701kcODx+/5rE6DHtwGx2j80rtDw2repk
	89g/dw27R/9fA4++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK6L07h63gkUDFhe2vWBsYn/J2
	MXJySAiYSPRPP8/cxcjFISSwm1Hi/MmNLBAJSYlpF48CJTiAbGGJw4eLIWqeM0pcOnmTDSTO
	JqAjseBHKEi5iICfxO5zR9hAapgFmpkk/n/uZYRo6GaUuLrpFNggTgEriVvzgkEahAVCJa59
	OcgEYrMIqEqcfXCHDcTmFbCU+DxjLSOELShxcuYTFpBWZgE9ibaNYGFmAXmJ7W/nMEOcqSDx
	8+kyVoi4iMTszjZmiHusJN6vXc46gVF4FpJJsxAmzUIyaRaS7gWMLKsYJVMLinPTc4sNC4zy
	Usv1ihNzi0vz0vWS83M3MYKjTUtrB+OeVR/0DjEycTAeYpTgYFYS4WUpv5IqxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dUA1OQBcu2+SsuXZ6nvl74gPJX
	F4F77jWTbxR/aCuZsyNY4PUvVaaE9vO79eVX+0TLbu+p/eol/mzl3IudNy2Xqlf2fhPjf/Zj
	qX2U4sLM6Z7vTl63fvGyP6hxqrOQ85kn8q8kBZIv2f4x6LwXWyv/stTX7lnGbpFw9YPcXk/u
	yXKft5lm6yiytOf5y9cdZQmOXWzO8Swvj7xnbHyRMedcweIe4ZK2M8UM867sTGT88M6tcNNh
	M4Pzeglc/8Stv38JyztslSh4oGRrkYLZtHf7tj7YlbFzZaHDzrlzJiQnWhyQ+XVJL4inZLGL
	QjTL/JvJorOvzFi0uW13TdHuqu+p3y5mnud9JqTydvtUN7WGHjMlluKMREMt5qLiRADlE9vf
	JQMAAA==
X-CMS-MailID: 20240222055600epcas1p29c5bc5ae90d58cde48229e682e1e65fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213060611epcas1p47134bfa5d8781c5cc1a493757a118752
References: <CGME20240213060611epcas1p47134bfa5d8781c5cc1a493757a118752@epcas1p4.samsung.com>
	<20240213060028.9744-1-rdunlap@infradead.org>



> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Tuesday, February 13, 2024 3:00 PM
> To: linux-kernel@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>; Arnd Bergmann <arnd@arndb.de>;
> MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo Choi
<cw00.choi@samsung.com>;
> Marc Zyngier <maz@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>;
Peter
> Rosin <peda@axentia.se>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: [PATCH v2] extcon: max8997: select IRQ_DOMAIN instead of
depending
> on it
> 
> IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
> Relying on it being set for a dependency is risky.
> 
> Consistently using "select" or "depends on" can also help reduce Kconfig
> circular dependency issues.
> 
> Therefore, change EXTCON_MAX8997's use of "depends on" for IRQ_DOMAIN to
> "select".
> 
> Fixes: dca1a71e4108 ("extcon: Add support irq domain for MAX8997 muic")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: drop Cc: Donggeun Kim <dg77.kim@samsung.com> (bounced)
> 
>  drivers/extcon/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -- a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -116,7 +116,8 @@ config EXTCON_MAX77843
> 
>  config EXTCON_MAX8997
>  	tristate "Maxim MAX8997 EXTCON Support"
> -	depends on MFD_MAX8997 && IRQ_DOMAIN
> +	depends on MFD_MAX8997
> +	select IRQ_DOMAIN
>  	help
>  	  If you say yes here you get support for the MUIC device of
>  	  Maxim MAX8997 PMIC. The MAX8997 MUIC is a USB port accessory

Applied it. Thanks.

Best Regards,
Chanwoo Choi


