Return-Path: <linux-kernel+bounces-95436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F42874D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BD0B237FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4B4129A77;
	Thu,  7 Mar 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gEy6RMz9"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAB12883D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811388; cv=none; b=Lc7WF5P4mun5ti57pTrWZDqQMuHjuXaoOho7wueOjDRlHw42cqE2oL9YJEkT8zWIYYKsqA2JzU9bHjt4mqDv0xPDObtggZ23EYYpbhjk78I+xm08C9AgAPH3ohVhvgRTTxrDdHyFaGk/dKJsDfygY+D7JzjK40S/baTwbLh6Adc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811388; c=relaxed/simple;
	bh=Y2kcKWYv5e6eNTplSE0YBXQ5c/C4Tz3gOg7+DUtktVI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ugIlRiOpk80Ef0FYHzLT1/2Bxf0Qz7ul0DM/VMoOOf/hl+Pw966Kvg+CDEWi2JAVJMBVgz4qHkaorId179/bSLHWpb0Ae/un0nIPLK9RHoHSblyEVeZCzRNlEBjyYNz2QdIN1uIwYTLIDUtLgj0Uye3QBaNquRYHcok1EIGxkJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gEy6RMz9; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240307113624epoutp02e872919ceb33b60f04acb506bb6dd578~6eGUxCEaF1885618856epoutp02X
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:36:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240307113624epoutp02e872919ceb33b60f04acb506bb6dd578~6eGUxCEaF1885618856epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709811384;
	bh=LxEJ8CBILPYnTnqg6+IsyZdTHbi8aif3bwtHVqb81hA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=gEy6RMz9Wp6q8wfPqOwK8PNYZg1+BCaQhLUwWB9GTAOcWIYw5a4n9dnNLAHaH8miQ
	 dkvdBtCA2Xs3DSo8K/X9UHrZ9vDBxqzWhiuLIMqWov/JL0YLiEAJh5KLS55XD2323e
	 e5ec2vebg3XwcGfPcYh8dsLESNNllwq8cjifpZF0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240307113624epcas1p36d0397d767f282dacfa92ef949b175ca~6eGUiC0ed0318903189epcas1p3G;
	Thu,  7 Mar 2024 11:36:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.231]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Tr6h72PfWz4x9Pt; Thu,  7 Mar
	2024 11:36:23 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.36.11177.7B6A9E56; Thu,  7 Mar 2024 20:36:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240307113623epcas1p42a0aea5010c17a3390d30a9a9359f9c4~6eGTYTf7I1827218272epcas1p4j;
	Thu,  7 Mar 2024 11:36:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240307113623epsmtrp244182b4e564c6d540bf39b7f41d2948e~6eGTXtEbF2368023680epsmtrp2O;
	Thu,  7 Mar 2024 11:36:23 +0000 (GMT)
X-AuditID: b6c32a35-a17ff70000002ba9-fb-65e9a6b71e7e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.CE.07368.6B6A9E56; Thu,  7 Mar 2024 20:36:22 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240307113622epsmtip2ce0b2ce0442a033c1c9d3594d438cd8e~6eGTMbJBN0402904029epsmtip2n;
	Thu,  7 Mar 2024 11:36:22 +0000 (GMT)
From: "Chanwoo Choi" <cw00.choi@samsung.com>
To: "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>, "'Stanley
 Chang'" <stanley_chang@realtek.com>, <linux-kernel@vger.kernel.org>
Cc: "'MyungJoo Ham'" <myungjoo.ham@samsung.com>
In-Reply-To: <20240304174913.1198974-1-andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v1 1/1] extcon: realtek: Remove unused of_gpio.h
Date: Thu, 7 Mar 2024 20:36:22 +0900
Message-ID: <000101da7083$ae5d55b0$0b180110$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG7tkI6tt2s17nzUnp+U++O8oduIwBxDmu9sWYSVkA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTT3f7spepBq2zBC16m6YzWVzeNYfN
	4nbjCjaL67uamR1YPOadDPR4/HYzu0ffllWMHp83yQWwRGXbZKQmpqQWKaTmJeenZOal2yp5
	B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBtVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
	F5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2yat4Wx4DlnxY6d/5gaGJdwdDFy
	ckgImEh0T7jE2sXIxSEksINR4ubMO2wQzidGicNfFkA53xglji+ZAORwgLVsW6YCEd/LKPFu
	9UGo9peMEgt6NoMVsQnoSCz4EQoSFxHoYZRovvmGBWQfs4C+xOoPtxlBbE4BT4mJ976B2cIC
	LhKrJ7WygtgsAioSy7s/soPYvAKWEvuezGeCsAUlTs58AjVHXmL72znMED8oSPx8ugysV0TA
	SuL7z59sEDUiErM725hBjpAQ+Mku0b7uCyNEg4vEkm8NbBC2sMSr41vYIWwpic/v9rJBNExm
	lLj4+jVU93pGiY0rW6DWGUvsXzqZCeRNZgFNifW79CG28Um8+9rDCgkiXomONiGIamWJyw/u
	MkHYkhKL2zuh9npILPvwl3kCo+IsJL/NQvLbLCQ/zEJYtoCRZRWjWGpBcW56arFhgSE8upPz
	czcxgpOjlukOxolvP+gdYmTiYDzEKMHBrCTCy2LxMlWINyWxsiq1KD++qDQntfgQoykwtCcy
	S4km5wPTc15JvKGJpYGJmZGxiYWhmaGSOO+ZK2WpQgLpiSWp2ampBalFMH1MHJxSDUxrD0kY
	KWttYNzbs1On2Eiu9Unw11a5k21H71QsLf/JevOcvQXvnuLsayqfV3/SM09dezrms9gh9UMx
	M66VWHydd5bvaYZ0YtSJijDLiwv0DhirztHct2vNhfUu7Nxre/6tfbg4S0DM3+pTaWOexZtr
	gjOm/Wb5efuC5D+99x5hCfoLPj3rFOadNv23e51kwTav0H3zP/Lx+/xJeVDxKLE+ZW+P0Kso
	K0meI0xTZZcG8/ZFbfqbZfqUZX6lKZN/UNPvrx8vWnD+n6i1W7xhl09s+BqeK0ud/Jwc/B7O
	Pft48nITh2UumtVNvS/tX+y86ee67mjT33WlEWlPuu0vrrmdMf2a71Yj5xhb7uq+jMdKLMUZ
	iYZazEXFiQD+gMMsFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvO62ZS9TDVrfWFv0Nk1nsri8aw6b
	xe3GFWwW13c1MzuweMw7Gejx+O1mdo++LasYPT5vkgtgieKySUnNySxLLdK3S+DK2DRvC2PB
	c86KHTv/MTUwLuHoYuTgkBAwkdi2TKWLkZNDSGA3o8Tj63EgtoSApMS0i0eZIUqEJQ4fLu5i
	5AIqec4osaC5lxEkziagI7HgRyhIuYhAH6PE3jdpIDazgL7E6g+3GSFGzmKUONQSBmJzCnhK
	TLz3DSwuLOAisXpSKyuIzSKgIrG8+yM7iM0rYCmx78l8JghbUOLkzCcsIKuYBfQk2jYyQoyX
	l9j+dg4zxJUKEj+fLmOFOMFK4vvPn2wQNSISszvbmCcwCs9CMmkWwqRZSCbNQtKxgJFlFaNk
	akFxbnpusmGBYV5quV5xYm5xaV66XnJ+7iZGcGRoaexgvDf/n94hRiYOxkOMEhzMSiK8LBYv
	U4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpgmhg5o5Tf
	nvmN0MJHi5e+y2StmaHsf3ijgNW7gxw1Wzq/hfnzi+1qyt+Y5alu2qLhq/WwrtBa5//sns2P
	PSfscT/B031pzSTmwgJH+zcNxhdj9Hfl1r59tIW1QejYGr93PaXby2OsLkk/e7GZf8qzkp5K
	rm/WbF/fZ7gdjw5USuotmHLu/IKZovvb5h104QgWTHwuL980S+lVq0GA1vZ5mQ3aJbzSsrcE
	edYqs+9kjZp+ctJH98i4e2+yixRNM2Zqn7Fke/6e303J+NyepB+GGyurgk6lRudPrl0R/krg
	72lOn/TXvxZtENP4cZ9v2f9FjYE82yyi3cVv5Himcre6BE+fea/O+9u1/8s0Dh5TYinOSDTU
	Yi4qTgQAVVBzFvsCAAA=
X-CMS-MailID: 20240307113623epcas1p42a0aea5010c17a3390d30a9a9359f9c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240304174938epcas1p379bfb2a4834ffc255149b5fcaba60534
References: <CGME20240304174938epcas1p379bfb2a4834ffc255149b5fcaba60534@epcas1p3.samsung.com>
	<20240304174913.1198974-1-andriy.shevchenko@linux.intel.com>



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, March 5, 2024 2:49 AM
> To: Stanley Chang <stanley_chang@realtek.com>;
linux-kernel@vger.kernel.org
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo Choi
> <cw00.choi@samsung.com>; Andy Shevchenko
<andriy.shevchenko@linux.intel.com>
> Subject: [PATCH v1 1/1] extcon: realtek: Remove unused of_gpio.h
> 
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon-rtk-type-c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-rtk-type-c.c
b/drivers/extcon/extcon-rtk-
> type-c.c
> index a592bab77538..19a01e663733 100644
> --- a/drivers/extcon/extcon-rtk-type-c.c
> +++ b/drivers/extcon/extcon-rtk-type-c.c
> @@ -13,7 +13,6 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/syscalls.h>
> --
> 2.43.0.rc1.1.gbec44491f096
> 

Applied it. Thanks.

Best Regards,
Chanwoo Choi


