Return-Path: <linux-kernel+bounces-74526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497DA85D580
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD21C211A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CDC3D982;
	Wed, 21 Feb 2024 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lUWubFn4"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846A3D970
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511330; cv=none; b=SDrF0bXEj1zR/yVfpc3wUvIWnWgjLU7GzYV+BRrnnguTtmkd4CN4MzHC2ms785HC5HcoVHVCk6ai0G9UcePdz6jvfjvSJ3WHmXNy6wkqNMge5y4gqMv54E82LeEcmkTv5PH3az/Aw95/jN7q5IE4J60UT/gWQoico0yaJ95rwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511330; c=relaxed/simple;
	bh=PKJd0I/O36A8M3van6LVSkiFBdzDAtvfjisCm1Nq5Cs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Ahtby3sCmisRrfHXXTU3AJ0ypoyrb5jtWZg51upAflaOCuZHASXX9hqBREbNVMqTyXGY8amAtvlBwmaRwKVKTSAuVQdEVgANSo5n8YmtSgf5y99FT91ei/QrKvUTP0UpfyX9Vz3/Jj31Hu9g9vjpJjPwmfCD7ZQf18poknQ5/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lUWubFn4; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240221102844epoutp045cb519b349d0677d6abf5f1a1901f252~12f96nFfM1842918429epoutp04G
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240221102844epoutp045cb519b349d0677d6abf5f1a1901f252~12f96nFfM1842918429epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708511324;
	bh=PKJd0I/O36A8M3van6LVSkiFBdzDAtvfjisCm1Nq5Cs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lUWubFn4tcjoPKlYl7MQu0H5bEwn212ku2SNLVMpPe5tGVogLoZIEvYmqsdmajU0i
	 ormpURbv2TlN+CGkXIWJnUPoO8yUu13JrZSZZPJOftPSKyNZf4IMN3aFEbBHIJs3Ka
	 Y1njN3nnYXgCAIeGTtFfrA+SjWrO+sAl6VOCuolQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240221102844epcas5p3aca4c638739983f7f85654eb18db54a3~12f9ieYfI3148431484epcas5p3G;
	Wed, 21 Feb 2024 10:28:44 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Tfsty6yTxz4x9Pw; Wed, 21 Feb
	2024 10:28:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.BC.19369.A50D5D56; Wed, 21 Feb 2024 19:28:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240221102842epcas5p2d0406a570da552037d4ef2eb5e612c39~12f7edJg40883008830epcas5p2D;
	Wed, 21 Feb 2024 10:28:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240221102842epsmtrp1e49193dd1e282b2a1aa16f80ef17c74f~12f7dnYhE2096420964epsmtrp1J;
	Wed, 21 Feb 2024 10:28:42 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-21-65d5d05a15d9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.89.08755.A50D5D56; Wed, 21 Feb 2024 19:28:42 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240221102840epsmtip278885f7484b909c076089c2c695805be~12f5aMXL41172211722epsmtip2p;
	Wed, 21 Feb 2024 10:28:39 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Georgi
 Djakov'" <djakov@kernel.org>, "'Bjorn Andersson'" <andersson@kernel.org>,
	"'Konrad	Dybcio'" <konrad.dybcio@linaro.org>, "'Sylwester Nawrocki'"
	<s.nawrocki@samsung.com>, =?utf-8?Q?'Artur_=C5=9Awigo=C5=84'?=
	<a.swigon@samsung.com>, "'Thierry Reding'" <thierry.reding@gmail.com>,
	"'Jonathan Hunter'" <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Cc: "'Thierry Reding'" <treding@nvidia.com>
In-Reply-To: <6c4bdd9f-6b1f-43a0-9baa-7c1eedd46f76@linaro.org>
Subject: RE: [PATCH v2] interconnect: constify of_phandle_args in xlate
Date: Wed, 21 Feb 2024 15:58:38 +0530
Message-ID: <1f7401da64b0$bdba8430$392f8c90$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLQP0hpybpPMp0Wp7r3CvZ4KlHU5QIjg6hJAdtsHmwBHGOYhq7/5urQ
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmhm7UhaupBvc/mFjcn9fKaLGtw8bi
	2a1GNouWWYtYLDomb2ex2Pt6K7vFpsfXWC0m7j/LbnF51xw2i8+9RxgtZpzfx2TR+WUWm8Xh
	N+2sFj93zWOxuP2bz4HfY+esu+wem1Z1snncubaHzWPzknqP3uZ3bB59W1YxenzeJBfAHpVt
	k5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0tZJCWWJO
	KVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2Nl
	cxt7wQntigcHNrM2MPZpdTFyckgImEgcXvKWqYuRi0NIYA+jxK6bf1ghnE+MEi8+tjNCON8Y
	JQ437mGGaXl0u48ZIrGXUeLXz1NQLS8YJfbuegFWxSagK7FjcRsbSEJE4D6LRP+XBawgCWYB
	bYkjT2+wg9icAnYSM78dB4pzcAgLuEt0LZAGCbMIqEpcv3kDrJxXwFJi8borULagxMmZT1hg
	xixb+BrqIgWJn0+XgdWICLhJNE5tY4aoEZd4efQIO8gNEgJXOCS+t+1ihGhwkfiwYjcLhC0s
	8er4FnYIW0riZX8bO8g9EgIeEov+SEGEMyTeLl8P1WovceDKHBaQEmYBTYn1u/QhVvFJ9P5+
	wgTRySvR0SYEUa0q0fzuKtQiaYmJ3d2sELaHRNu+RywTGBVnIXlsFpLHZiF5YBbCsgWMLKsY
	pVILinPTU5NNCwx181LL4RGenJ+7iRGcqLUCdjCu3vBX7xAjEwfjIUYJDmYlEV6W8iupQrwp
	iZVVqUX58UWlOanFhxhNgcE9kVlKNDkfmCvySuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8s
	Sc1OTS1ILYLpY+LglGpgyv+Qveh+iPGzeTnbJu3Z8q3no0Z7hHlV/tamxMN7V//2Ull/fKXP
	8gVvais4fq9a+30T77lH9VbXr2z7dc7/4XG7BQ/8JRQ9WvbeDjYJk8outbrNdFB2w5aK+bqh
	ia9YNAMPq7sJTwjQ+8XOXZ/UbPdGT/Tas7Rrx23YfFY8s4qUPMPK/cV67S4z5qc7Htj9bdrO
	4Lx7716te9ovJrhrrrIpe1wleHePxpXO2hvnPq1Z/vfFxyJ9E4VkT9WzeuetHYTkC69sig0V
	vmURVqZoxrdOOjtp9p7QM2tSftXfOy2lxrvJbeJLGaZuw50Fy6LSvIy4Si5ubgtyzpR7e6tz
	ycKytobuP2Vl5xij3/wVVWIpzkg01GIuKk4EAMPUBhNdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSvG7UhaupBlfe8Fncn9fKaLGtw8bi
	2a1GNouWWYtYLDomb2ex2Pt6K7vFpsfXWC0m7j/LbnF51xw2i8+9RxgtZpzfx2TR+WUWm8Xh
	N+2sFj93zWOxuP2bz4HfY+esu+wem1Z1snncubaHzWPzknqP3uZ3bB59W1YxenzeJBfAHsVl
	k5Kak1mWWqRvl8CV8efbV6aCY/IVa9e3szcwLpfqYuTkkBAwkXh0u4+5i5GLQ0hgN6PE33vH
	WCES0hLXN05gh7CFJVb+ew5mCwk8Y5SYtRGsmU1AV2LH4jY2EFtE4CWLRMszaRCbWUBb4sjT
	G+wQQ78ySqya9x6smVPATmLmt+NACzg4hAXcJboWgNWzCKhKXL95A2wvr4ClxOJ1V6BsQYmT
	M5+wwMx8evMpnL1s4WtmiNsUJH4+XcYKcYObROPUNmaIGnGJl0ePsE9gFJ6FZNQsJKNmIRk1
	C0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwbGqpbmDcfuqD3qHGJk4GA8x
	SnAwK4nwspRfSRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TB
	KdXAtOKuoVeY8Y69P58p+bwoLXHIWXP0s1Or7s5U50+B/En9R0US05b843pzapvM5NLDE+xu
	TLo9KevpZ9nut5Nb0nY5BE/WaXdXN2iY0B1wveaBrWvdjZdzOyZH/NfwLE95fz7/Zt6RuLqN
	IodP7Za5xbWwdrl26AHphFP+s+6/nbld6hOXxgH3nbcWix94ZLTON2LG173Rd5kNvJp9Lm97
	ud9MznlO0JlkaenPq3ZfzNj+RmjP939bXlyu65lvcHFz84xNp6ftf3rucPf6wEsruB/MPCMo
	eLJx5dr1vVKPrS/u3xNqnX/1njdHUjBvh8n/FpaFLEbz/lYdOyhYva5H0GuCoOSM/SXSHf+5
	jh+SFYhRYinOSDTUYi4qTgQA+8onEEQDAAA=
X-CMS-MailID: 20240221102842epcas5p2d0406a570da552037d4ef2eb5e612c39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220072224epcas5p4ff60556b0b5632abfc44d2b8ad932b8f
References: <CGME20240220072224epcas5p4ff60556b0b5632abfc44d2b8ad932b8f@epcas5p4.samsung.com>
	<20240220072213.35779-1-krzysztof.kozlowski@linaro.org>
	<1d9b01da63f6$daeb0170$90c10450$@samsung.com>
	<6c4bdd9f-6b1f-43a0-9baa-7c1eedd46f76@linaro.org>

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Wednesday, February 21, 2024 12:44 PM
> To: Alim Akhtar <alim.akhtar=40samsung.com>; 'Georgi Djakov'
> <djakov=40kernel.org>; 'Bjorn Andersson' <andersson=40kernel.org>; 'Konra=
d
> Dybcio' <konrad.dybcio=40linaro.org>; 'Sylwester Nawrocki'
> <s.nawrocki=40samsung.com>; 'Artur =C5=9Awigo=C5=84'=20<a.swigon=40samsun=
g.com>;=0D=0A>=20'Thierry=20Reding'=20<thierry.reding=40gmail.com>;=20'Jona=
than=20Hunter'=0D=0A>=20<jonathanh=40nvidia.com>;=20linux-pm=40vger.kernel.=
org;=20linux-=0D=0A>=20kernel=40vger.kernel.org;=20linux-arm-msm=40vger.ker=
nel.org;=20linux-samsung-=0D=0A>=20soc=40vger.kernel.org;=20linux-arm-kerne=
l=40lists.infradead.org;=20linux-=0D=0A>=20tegra=40vger.kernel.org=0D=0A>=
=20Cc:=20'Thierry=20Reding'=20<treding=40nvidia.com>=0D=0A>=20Subject:=20Re=
:=20=5BPATCH=20v2=5D=20interconnect:=20constify=20of_phandle_args=20in=20xl=
ate=0D=0A>=20=0D=0A>=20On=2020/02/2024=2013:18,=20Alim=20Akhtar=20wrote:=0D=
=0A>=20>=0D=0A>=20>=0D=0A>=20>>=20-----Original=20Message-----=0D=0A>=20>>=
=20From:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A=
>=20>>=20Sent:=20Tuesday,=20February=2020,=202024=2012:52=20PM=0D=0A>=20>>=
=20To:=20Georgi=20Djakov=20<djakov=40kernel.org>;=20Bjorn=20Andersson=0D=0A=
>=20>>=20<andersson=40kernel.org>;=20Konrad=20Dybcio=20<konrad.dybcio=40lin=
aro.org>;=0D=0A>=20>>=20Sylwester=20Nawrocki=20<s.nawrocki=40samsung.com>;=
=20Artur=20=C5=9Awigo=C5=84=0D=0A>=20>>=20<a.swigon=40samsung.com>;=20Krzys=
ztof=20Kozlowski=0D=0A>=20>>=20<krzysztof.kozlowski=40linaro.org>;=20Alim=
=20Akhtar=0D=0A>=20>>=20<alim.akhtar=40samsung.com>;=20Thierry=20Reding=0D=
=0A>=20<thierry.reding=40gmail.com>;=0D=0A>=20>>=20Jonathan=20Hunter=20<jon=
athanh=40nvidia.com>;=20linux-pm=40vger.kernel.org;=0D=0A>=20>>=20linux-ker=
nel=40vger.kernel.org;=20linux-arm-msm=40vger.kernel.org;=20linux-=0D=0A>=
=20>>=20samsung-soc=40vger.kernel.org;=20linux-arm-kernel=40lists.infradead=
org;=0D=0A>=20>>=20linux-=20tegra=40vger.kernel.org=0D=0A>=20>>=20Cc:=20Th=
ierry=20Reding=20<treding=40nvidia.com>=0D=0A>=20>>=20Subject:=20=5BPATCH=
=20v2=5D=20interconnect:=20constify=20of_phandle_args=20in=20xlate=0D=0A>=
=20>>=0D=0A>=20>>=20The=20xlate=20callbacks=20are=20supposed=20to=20transla=
te=20of_phandle_args=20to=0D=0A>=20>>=20proper=20provider=20without=20modif=
ying=20the=20of_phandle_args.=20=20Make=20the=0D=0A>=20>>=20argument=20poin=
ter=20to=20const=20for=20code=20safety=20and=20readability.=0D=0A>=20>>=0D=
=0A>=20>>=20Acked-by:=20Konrad=20Dybcio=20<konrad.dybcio=40linaro.org>=0D=
=0A>=20>>=20Acked-by:=20Thierry=20Reding=20<treding=40nvidia.com>=20=23=20T=
egra=0D=0A>=20>>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzysztof.kozl=
owski=40linaro.org>=0D=0A>=20>>=0D=0A>=20>>=20---=0D=0A>=20>>=0D=0A>=20>>=
=20Changes=20in=20v2:=0D=0A>=20>>=201.=20Drop=20unrelated=20gpiolib=20chang=
es=20(Konrad,=20Thierry).=0D=0A>=20>>=202.=20Add=20tags.=0D=0A>=20>>=20---=
=0D=0A>=20>>=20=20drivers/interconnect/core.c=20=20=20=20=20=20=20=20=20=20=
=20=20=7C=20=204=20++--=0D=0A>=20>>=20=20drivers/interconnect/qcom/icc-comm=
on.c=20=7C=20=203=20++-=0D=0A>=20>>=20drivers/interconnect/qcom/icc-common.=
h=20=7C=20=203=20++-=0D=0A>=20>>=20drivers/interconnect/samsung/exynos.c=20=
=20=7C=20=202=20+-=0D=0A>=20>>=20=20drivers/memory/tegra/mc.c=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=7C=20=202=20+-=0D=0A>=20>>=20=20drivers/memo=
ry/tegra/tegra124-emc.c=20=20=20=20=7C=20=202=20+-=0D=0A>=20>>=20=20drivers=
/memory/tegra/tegra124.c=20=20=20=20=20=20=20=20=7C=20=202=20+-=0D=0A>=20>>=
=20=20drivers/memory/tegra/tegra186-emc.c=20=20=20=20=7C=20=202=20+-=0D=0A>=
=20>>=20=20drivers/memory/tegra/tegra20-emc.c=20=20=20=20=20=7C=20=202=20+-=
=0D=0A>=20>>=20=20drivers/memory/tegra/tegra20.c=20=20=20=20=20=20=20=20=20=
=7C=20=202=20+-=0D=0A>=20>>=20=20drivers/memory/tegra/tegra30-emc.c=20=20=
=20=20=20=7C=20=202=20+-=0D=0A>=20>>=20=20drivers/memory/tegra/tegra30.c=20=
=20=20=20=20=20=20=20=20=7C=20=202=20+-=0D=0A>=20>>=20=20include/linux/inte=
rconnect-provider.h=20=20=7C=2011=20++++++-----=0D=0A>=20>>=20=20include/so=
c/tegra/mc.h=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=207=
=20++++---=0D=0A>=20>>=20=2014=20files=20changed,=2025=20insertions(+),=202=
1=20deletions(-)=0D=0A>=20>>=0D=0A>=20>=0D=0A>=20>=20For=20Samsung/Exynos=
=0D=0A>=20>=20Reviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=
=0A>=20=0D=0A>=20Review=20tags=20are=20per=20patch.=20You=20probably=20mean=
t=20Acked-by.=0D=0Aif=20that=20is=20more=20appropriate=20in=20this=20case,=
=20feel=20free=20to=20add=0D=0AAcked-by:=20Alim=20Akhtar=20<alim.akhtar=40s=
amsung.com>=0D=0A=0D=0A>=20https://protect2.fireeye.com/v1/url?k=3Dbc64ffdb=
-ddefeaed-bc657494-=0D=0A>=2074fe485cbff1-62590d464cd6269e&q=3D1&e=3Dec8047=
f9-eeac-446c-8ba5-=0D=0A>=20476f581d9cfa&u=3Dhttps%3A%2F%2Felixir.bootlin.c=
om%2Flinux%2Fv6.8-=0D=0A>=20rc5%2Fsource%2FDocumentation%2Fprocess%2Fsubmit=
ting-=0D=0A>=20patches.rst%23L544=0D=0A>=20=0D=0A>=20What=20is=20there=20an=
yway=20to=20review=20in=20Samsung?=20Adding=20one=20const=20in=20one=20driv=
er?=0D=0A>=20=0D=0AI=20my=20opinion,=20any=20changes=20coming=20in,=20has=
=20to=20be=20reviewed=20to=20see=20if=20there=20is/are=20any=20side=20effec=
t=20because=20of=20the=20change,=0D=0Aeven=20though=20the=20changes=20looks=
=20trivial.=0D=0A=0D=0A>=20=0D=0A>=20Best=20regards,=0D=0A>=20Krzysztof=0D=
=0A=0D=0A=0D=0A

