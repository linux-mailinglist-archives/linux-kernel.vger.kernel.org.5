Return-Path: <linux-kernel+bounces-11375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D662E81E54D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB52814B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96004BA90;
	Tue, 26 Dec 2023 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mSrS5zD0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B44B5C5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231226054837epoutp04544b79e2842b4d72d26fb4984b906268~kS6HI9tMH0141601416epoutp04M
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:48:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231226054837epoutp04544b79e2842b4d72d26fb4984b906268~kS6HI9tMH0141601416epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703569717;
	bh=yakKDh1aAxqR67PPB8zgJ2H9KaDZW3RdwYfn1iPKbnk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=mSrS5zD0wXxiTcANdZkIyRI5PZ5QT0iXCYnqq2Q8V9GcpyhGagpXvNiDIb3hys4nd
	 MzapTe4E7z+StVDK5DD1CS9mePAMfYeoSpyT5CboY6ByRk4nZjRU+16aTEOvSgJ6VH
	 D2XnQa6WBKIKZIiP6jpCeSF8LZr+zPhHr6BxBSV4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231226054836epcas5p3239eaf44d85bd2419f73e93e54269918~kS6GvCxlP2534425344epcas5p3p;
	Tue, 26 Dec 2023 05:48:36 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SzkN26QWyz4x9Q7; Tue, 26 Dec
	2023 05:48:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.E1.09672.2396A856; Tue, 26 Dec 2023 14:48:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231226051218epcas5p12bec72a809babec505f85bfa19793a0d~kSaZw_KnS2823728237epcas5p1f;
	Tue, 26 Dec 2023 05:12:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226051218epsmtrp10e95ee097f783a0f5ba73053639a628b~kSaZwQ-LQ0965709657epsmtrp1Y;
	Tue, 26 Dec 2023 05:12:18 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-14-658a69326ad4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.43.07368.2B06A856; Tue, 26 Dec 2023 14:12:18 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226051216epsmtip25b9d639c0f5c64a35e7ae26a54dcda25~kSaYMIL3L3188831888epsmtip2U;
	Tue, 26 Dec 2023 05:12:16 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-2-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 02/15] media: s5p-mfc: drop unused static s5p_mfc_ops
Date: Tue, 26 Dec 2023 10:42:15 +0530
Message-ID: <15cf01da37ba$18936ad0$49ba4070$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAFJzwIkAnbPk3avNTqAkA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmuq5RZleqwe/Dxhb3F39msdj7eiu7
	xabH11gtls0Osri8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLFoal7A6cHnsnHWX3WPxnpdM
	HptWdbJ53Lm2h81j85J6j74tqxg9/r5+xebxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMKzNDCnYLVLxaMpWpgXE6XxcjJ4eE
	gInEnxV/2EBsIYHdjBIPZxtA2J8YJY48lehi5AKyvzFKLNj0hBGm4eLt38wQRXsZJe5854Yo
	es4osfBVL1gRm4C+xP1TPawgCRGBc4wS2/qnMIE4zAI3GSWOvZkJ1s4p4CJxd9MdsA5hAU+J
	270PwO5gEVCVOLTnCQuIzStgKbHj+H9GCFtQ4uRMiDizgLbEsoWvmSFOUpD4+XQZK4gtIuAk
	0XJ5DzNEjbjE0Z89zCCLJQSOcEj8/r2DHaLBReLmk0msELawxKvjW6DiUhIv+9ug7GSJx4te
	Qi3IkVi/ZwoLhG0vceDKHCCbA2iBpsT6XfoQYVmJqafWMUHs5ZPo/f2ECSLOK7FjHoytJjHn
	zg+otTISh1cvZZzAqDQLyWuzkLw2C8kLsxC2LWBkWcUomVpQnJueWmxaYJyXWg6P7+T83E2M
	4ASs5b2D8dGDD3qHGJk4GA8xSnAwK4nwyip2pArxpiRWVqUW5ccXleakFh9iNAWG90RmKdHk
	fGAOyCuJNzSxNDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgenljtYlhfEV
	kgnVAaUbLmZsdGOKPrR0nZDJ3NN/pl9SPqftvMFx5mQdFcufR9XrfX9lTg36Ey3vmRWtcUb8
	5c+oQAvz2V+MNqTHvvstEydjIrjESuat4prsKw2szx687/qy96VuzrZf/oVLAtbJZdvn3veY
	9sqQIUffR+jy0qDs3xXMB8V4N6z3MJ6h/bnjeM5hSfH1SvILmjc4J357ynvsuk0jl6jtlT3W
	MVs0XRSP+iuv6W07c6betX9u6YeV2hLuz3kM3D6tvTxp/grhkvo2G3fuECnRpI5L8Wuurzre
	u/ZAV/ekTZOf8Bi86Z2XkVtieXD5Thcv3ezmihqJku9mi5+fZr3ip9+45ShTkRJLcUaioRZz
	UXEiAIV0Q91JBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvO6mhK5Ug8W3WC3uL/7MYrH39VZ2
	i02Pr7FaLJsdZHF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWbQ0LmF14PLYOesuu8fiPS+Z
	PDat6mTzuHNtD5vH5iX1Hn1bVjF6/H39is3j8ya5AI4oLpuU1JzMstQifbsEroxNE6YwF3zm
	r9i55DVbA+N53i5GTg4JAROJi7d/M3cxcnEICexmlNjU8IAFIiEj8b/tGDuELSyx8t9zdoii
	p4wSi3ZcYAJJsAnoS9w/1cMKkhARuMAosWXPAjYQh1ngPqNE16btYFVCAmcZJT5tZQOxOQVc
	JO5uusMIYgsLeErc7n0AFmcRUJU4tOcJ2GpeAUuJHcf/M0LYghInZ0LEmQW0JXoftjLC2MsW
	vmaGOE9B4ufTZawgtoiAk0TL5T3MEDXiEkd/9jBPYBSehWTULCSjZiEZNQtJywJGllWMkqkF
	xbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMGxqKWxg/He/H96hxiZOBgPMUpwMCuJ8MoqdqQK
	8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUIJsvEwSnVwLRj+131+11/
	j83nO744YnGg9fxT80Sl7pbJ2c1zm8B7Nt1bWPHJw4bNT9/wPuc/XMA9957G34rDGUKRZzc4
	axfPfnZogrPzqfQjda/Vln8LbxCYo7/L5/TljN8Ce33SWGNKDFtdMx9dyT5+fO6RJQLTm2tc
	7+3RMnVdpi3+epHZkzNFU65nJjnfUPUWPLeRteJUxLYWA9llD74kuMedTnhmdmLurwN326r+
	8yjHvjqYv+a+9ravx426J1h9zLot+MknTM9N7e0cw3m6wSfrswxbw1sP5G7dFJF2Tt6vxUfq
	7d7dTy5G/Vjik6b/lPe9bNxdUc8D/vFSr3Zuei9/Xd1ctNv679etqdMCfr0rzmVUYinOSDTU
	Yi4qTgQAX6GZmDQDAAA=
X-CMS-MailID: 20231226051218epcas5p12bec72a809babec505f85bfa19793a0d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154437epcas5p4ce3d24f3cbdc4ad25b215f14c5bccd3e
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154437epcas5p4ce3d24f3cbdc4ad25b215f14c5bccd3e@epcas5p4.samsung.com>
	<20231224-n-s5p-mfc-const-v1-2-a3b246470fe4@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: 24 December 2023 21:14
> To: Marek Szyprowski <m.szyprowski=40samsung.com>; Andrzej Hajda
> <andrzej.hajda=40intel.com>; Mauro Carvalho Chehab
> <mchehab=40kernel.org>
> Cc: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-fsd=40tesla.coma; li=
nux-
> samsung-soc=40vger.kernel.org; Smitha T Murthy
> <smithatmurthy=40gmail.com>; linux-arm-kernel=40lists.infradead.org; linu=
x-
> media=40vger.kernel.org; linux-kernel=40vger.kernel.org; Krzysztof Kozlow=
ski
> <krzysztof.kozlowski=40linaro.org>
> Subject: =5BPATCH 02/15=5D media: s5p-mfc: drop unused static s5p_mfc_ops
>=20
> File-scope static variable =22s5p_mfc_ops=22 is not read after assignment=
, thus it
> can be dropped entirely.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c =7C 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
> index 673962301173..5ba791fa3676 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
> =40=40 -14,18 +14,15 =40=40
>  =23include =22s5p_mfc_opr_v5.h=22
>  =23include =22s5p_mfc_opr_v6.h=22
>=20
> -static struct s5p_mfc_hw_ops *s5p_mfc_ops;
> -
>  void s5p_mfc_init_hw_ops(struct s5p_mfc_dev *dev)  =7B
>  	if (IS_MFCV6_PLUS(dev)) =7B
> -		s5p_mfc_ops =3D s5p_mfc_init_hw_ops_v6();
> +		dev->mfc_ops =3D s5p_mfc_init_hw_ops_v6();
>  		dev->warn_start =3D S5P_FIMV_ERR_WARNINGS_START_V6;
>  	=7D else =7B
> -		s5p_mfc_ops =3D s5p_mfc_init_hw_ops_v5();
> +		dev->mfc_ops =3D s5p_mfc_init_hw_ops_v5();
>  		dev->warn_start =3D S5P_FIMV_ERR_WARNINGS_START;
>  	=7D
> -	dev->mfc_ops =3D s5p_mfc_ops;
>  =7D
>=20
>  void s5p_mfc_init_regs(struct s5p_mfc_dev *dev)
>=20
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain=40samsung.com>

Thanks=21


