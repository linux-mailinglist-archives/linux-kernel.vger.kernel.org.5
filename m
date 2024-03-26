Return-Path: <linux-kernel+bounces-118848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2848D88C029
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B428EB22A07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8D23838C;
	Tue, 26 Mar 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aXb6WYt6"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520111B59A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451183; cv=none; b=ZG3uU9qYPghmFsw5D9mBBu1oyOjAhTGhBDVGg53764hGZmbbvQDTBqkOx/gC4tM8BdRm2nueuoVlTOxEoo8ZUo433hkUTmNjTCHPMxGZpOBQFRTjtKOKIEOGfB67NWG87KxsZ0kKHf+Z5QA6qGA6oV8x2hckv9gklBAG2VwHLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451183; c=relaxed/simple;
	bh=ldy7Xw7UarvJSibVff5dgyLFqEi23msHxXXSaqS7KrI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=B4RnqkqX2sVrsSrQSVcnSnIBRefszHMuSSNGLxfHcE0cIn5Xl4wvTpNBA/TRCK3ft4sljid7GNBLamEAWSAkCDvXXrHTTOsCMNr8xHCODRKBygLQ90gNg96hgc2jBozifUv4KBBvEI/LF5w52nFBB1B9el6n88PC1IhXzqOkogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aXb6WYt6; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240326110611epoutp033da42571a94717ae6b84339b30a7b6dc~AS8XofBqi2631926319epoutp03F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:06:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240326110611epoutp033da42571a94717ae6b84339b30a7b6dc~AS8XofBqi2631926319epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711451171;
	bh=ldy7Xw7UarvJSibVff5dgyLFqEi23msHxXXSaqS7KrI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=aXb6WYt6au9wxHsu9pwfBy+z4g9CMc3SFJa8Nz4Rq/lo3haxlNnyRSzPv0QTzcHvR
	 5/vdvpCZznlxV6NQ/lhNI3nJvnz4yFcONBHrKhFC7Oy0CLxFIzhLOGtVwkXD9hdFSR
	 PCtFQ2sLUTL7tuTl5lGCiR2rKyLA8omrpFQHhrMA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240326110611epcas5p2cdc96cb90fd86075d505bc553f148095~AS8XOYFRL2662026620epcas5p2m;
	Tue, 26 Mar 2024 11:06:11 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4V3n6T2WwSz4x9Ps; Tue, 26 Mar
	2024 11:06:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A0.EC.19431.12CA2066; Tue, 26 Mar 2024 20:06:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240326110608epcas5p45d754f5f92d3d14ffa6d765d4f423a78~AS8UdtNrt0288102881epcas5p44;
	Tue, 26 Mar 2024 11:06:08 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240326110608epsmtrp2ea8a92593b2c4b65e04d1e10c4100a50~AS8Uc_ylK1665516655epsmtrp2k;
	Tue, 26 Mar 2024 11:06:08 +0000 (GMT)
X-AuditID: b6c32a50-f57ff70000004be7-4a-6602ac219b71
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.E7.07541.02CA2066; Tue, 26 Mar 2024 20:06:08 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240326110606epsmtip1e237dded34f67ce167b84334ed531a46~AS8SQFkr41339713397epsmtip1e;
	Tue, 26 Mar 2024 11:06:05 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>,
	<peter.griffin@linaro.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andre.draszik@linaro.org>,
	<willmcvicker@google.com>, <kernel-team@android.com>
In-Reply-To: <20240326103620.298298-2-tudor.ambarus@linaro.org>
Subject: RE: [PATCH v2 1/4] arm64: dts: exynos: gs101: move serial_0
 pinctrl-0/names to dtsi
Date: Tue, 26 Mar 2024 16:36:04 +0530
Message-ID: <000001da7f6d$9a6e65a0$cf4b30e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD6o8IeErxKDZrGFPr+Y/HHTXn7CgKkFFLQAv/gtYyy3HNwIA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmuq7iGqY0g7N/+Cy2vNrMYrFm7zkm
	i/lHzrFa7NguYtH34iGzxabH11gtLu+aw2Yx4/w+JosNM/6xWLTuPcJu8elWnMWqT/8ZHXg8
	tu3exuqxYFOpx6ZVnWwed67tYfPYvKTe4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4Hjn
	eFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKADlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2
	SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGWfW7GQvaOCumLfvA0sD43fOLkYODgkB
	E4nHN0q7GLk4hAT2MEq83N3LBOF8YpSY8WwGK4TzjVFi6/stQBlOsI6GN6vYIBJ7GSUOte5n
	hnBeMEo0/9vLBlLFJqArsWNxG1iViMAiRonnZxeCJZgFnjJKHHxpAWJzCthLLJg4kxXEFhaI
	k7hw7gsziM0ioCrxf8VdsDivgKXE7OuHGSFsQYmTM5+wQMzRlli28DUzxEkKEj+fLgOrFxFw
	kli9bDMTRI24xMujR9hBjpAQOMAh8fHJYagGF4llj3ewQtjCEq+Ob2GHsKUkPr8D+QAUMh4S
	i/5IQYQzJN4uX88IYdtLHLgyhwWkhFlAU2L9Ln2IVXwSvb+fMEF08kp0tAlBVKtKNL+7ygJh
	S0tM7O6GWuohce1nL+MERsVZSB6bheSxWUgemIWwbAEjyypGqdSC4tz01GTTAkPdvNRyeIQn
	5+duYgSnX62AHYyrN/zVO8TIxMF4iFGCg1lJhLflC0OaEG9KYmVValF+fFFpTmrxIUZTYHBP
	ZJYSTc4HZoC8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqYZszc
	ueNZyPs/qS8iI9VnvVVpOH5CWNO/xkRPIvYh89M/B7+53Wq+89Dn9D6d3WESb+cYtMrd338h
	Ok/VfmLSLK+TYS83xM7855my5oD/8tsWHubT1Kzd/arvzDIofh5kUHtwi/GiS3nTJ+yX3TJr
	w+Pq2NnLta5MLX16z2iDlNCUO3P21Onk6d148WXBF26u1MOK/Gyf6i6sr/BtD/MJ4ehetdvH
	UqYsdGLI2zyhxU18i/b33Dgprv4+NCI/7WSA9kyTO3lZM6sOJeo9MN8e7ZR8sj/S/dxRJhv+
	2P8m7l9/HHH0uvg7rMnpHpNnetFCjbvh/1+k/Z8csop3m+d6zxTmbeez3vlv/ayteIbXV4ml
	OCPRUIu5qDgRAAVJ3QpIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnK7CGqY0g4d3+Sy2vNrMYrFm7zkm
	i/lHzrFa7NguYtH34iGzxabH11gtLu+aw2Yx4/w+JosNM/6xWLTuPcJu8elWnMWqT/8ZHXg8
	tu3exuqxYFOpx6ZVnWwed67tYfPYvKTe4/MmuQC2KC6blNSczLLUIn27BK6M15P6mApuclYs
	XLuFqYFxGUcXIyeHhICJRMObVWxdjFwcQgK7GSUePXvGApGQlri+cQI7hC0ssfLfczBbSOAZ
	o8T5xfogNpuArsSOxW1sILaIwDJGiamfVUEGMQu8ZpT4tPwKC8TUw4wSU5q2MINUcQrYSyyY
	OJMVxBYWiJF4seY2mM0ioCrxf8VdMJtXwFJi9vXDjBC2oMTJmU/ALmIW0JZ4evMpnL1s4Wtm
	iOsUJH4+XcYKcYWTxOplm5kgasQlXh49wj6BUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bn
	JhsWGOallusVJ+YWl+al6yXn525iBEehlsYOxnvz/+kdYmTiYDzEKMHBrCTC2/KFIU2INyWx
	siq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYOTqkGpiul/zesFMntUfmg
	Khu2//kH/wbrIKX8c+ZzGFNnCb74MPnpg8RkbfMpvXGSWpv5th4/I3FvQ+bRM7GK3Awnfhm/
	ULk2l/0g868zq2p/a2gzHT77ON5lUbDpkS8Lnrk6bhWc1MLLtn4pT/g8qaXzk1VK1Y9+tTKr
	Sbk00/+0iOGnvy+Lmeddygh792pu8LH866bmgXkuS5YfuXSVKUI86+fmC2LV54rL+Opnd7vN
	XX3KvEL2qq0S+9OY+i0BC959+xEkItmyz2rlokmnW1cXVf+adXvtvbkPQ6t2SRRtmVGRMZNv
	06uOrujeVZ9k1K6VV0gE75d192hR3J6e8VhG8N/H28nTknct38r3wUMi1VeJpTgj0VCLuag4
	EQCd9VS9MQMAAA==
X-CMS-MailID: 20240326110608epcas5p45d754f5f92d3d14ffa6d765d4f423a78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240326103630epcas5p16737d4faf2e8f37a1f6d5fe04dd59133
References: <20240326103620.298298-1-tudor.ambarus@linaro.org>
	<CGME20240326103630epcas5p16737d4faf2e8f37a1f6d5fe04dd59133@epcas5p1.samsung.com>
	<20240326103620.298298-2-tudor.ambarus@linaro.org>

Hi Tudor,

> -----Original Message-----
> From: Tudor Ambarus <tudor.ambarus=40linaro.org>
> Sent: Tuesday, March 26, 2024 4:06 PM
> To: peter.griffin=40linaro.org; robh+dt=40kernel.org;
> krzysztof.kozlowski+dt=40linaro.org; conor+dt=40kernel.org
> Cc: alim.akhtar=40samsung.com; linux-arm-kernel=40lists.infradead.org; li=
nux-
> samsung-soc=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; andre.draszik=40linaro.org;
> willmcvicker=40google.com; kernel-team=40android.com; Tudor Ambarus
> <tudor.ambarus=40linaro.org>
> Subject: =5BPATCH v2 1/4=5D arm64: dts: exynos: gs101: move serial_0 pinc=
trl-
> 0/names to dtsi
>=20
> The pinctrl nodes are coming from the shared gs101-pinctrl.dtsi, thus the
> pinctrl-0/names shall stay in dtsi. Move them.
>=20
> While moving, reverse the pinctrl-* lines, first pinctrl-0 then pinctrl-n=
ames.
>=20
> Reviewed-by: Andr=C3=A9=20Draszik=20<andre.draszik=40linaro.org>=0D=0A>=
=20Signed-off-by:=20Tudor=20Ambarus=20<tudor.ambarus=40linaro.org>=0D=0A>=
=20---=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=
=0A=0D=0A>=20=20arch/arm64/boot/dts/exynos/google/gs101-oriole.dts=20=7C=20=
2=20--=0D=0A>=20=20arch/arm64/boot/dts/exynos/google/gs101.dtsi=20=20=20=20=
=20=20=20=7C=202=20++=0D=0A>=20=202=20files=20changed,=202=20insertions(+),=
=202=20deletions(-)=0D=0A>=20=0D=0A=0D=0A

