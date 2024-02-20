Return-Path: <linux-kernel+bounces-72996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07FE85BBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C3D1F2221E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D3567E79;
	Tue, 20 Feb 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RpNK2xzW"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4567E70
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431493; cv=none; b=rtrrCYYPQHSxA99K1Nc0HboCjZy1vzj27nNA6Hf1qUXgs+x06QLVWilibFCHWeTsIZdrlma/g9wX3wI3oL4lUAq3PeQqXf/SwLb7vkPvAVp+0Aiwi51Fg+x2dJxuEnXodI6F1v15hm4t00ycRju1zuAbIne0qd2To1wC8ghZkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431493; c=relaxed/simple;
	bh=FyNYzT8EV/tDwSUKQpoe9xy1MnakgX8mWChybUQAYz4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=XX2EsIzw6FGk3hvr2ORmkUrMz2yasit5KbXRZq4FOcRIl2PXpgtpUvHna1ehy4ZNb1bMqfFvv2Hn0edEHyif64y/bOkbQfudIvVXMSVi+JyCnFBeObCig+e6ohTD+UdbC9Kt9uV58Ol3eDAPlDuUYQ6CTNq2aphf9yKDivDt624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RpNK2xzW; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240220121808epoutp02f7e765a6faf9a4e9f82feda74801fbf1~1kWMnRHzY2800328003epoutp024
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:18:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240220121808epoutp02f7e765a6faf9a4e9f82feda74801fbf1~1kWMnRHzY2800328003epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708431488;
	bh=FyNYzT8EV/tDwSUKQpoe9xy1MnakgX8mWChybUQAYz4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=RpNK2xzWiCsMyVnPhMpq52sMpwZwQ3oJNX9hE7jY9iAJY3C8DdZ6qIXPNiStaKwLt
	 1tgAUceJqBTuMCOBYk+X4cz5WA5BQtfmJsZoqQ+YgfKDnRWpnvhZW+ZnGU/uZbpfkY
	 puJBoJZyBzPt1BtsvBXLx40LWheaNeIhW8XHgD0E=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240220121808epcas5p45507e0d247b7228e8b5b784223425b7e~1kWMMqAXs2515225152epcas5p4a;
	Tue, 20 Feb 2024 12:18:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TfJMd6vLKz4x9Pr; Tue, 20 Feb
	2024 12:18:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	23.D9.09672.D7894D56; Tue, 20 Feb 2024 21:18:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240220121804epcas5p3f01e75b1089af1edf6db4ee3ea3a5efa~1kWJGqsyX3231832318epcas5p3F;
	Tue, 20 Feb 2024 12:18:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240220121804epsmtrp2a62d16806647f420afad909b08430dc1~1kWJE7VzD0477204772epsmtrp2c;
	Tue, 20 Feb 2024 12:18:04 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-e9-65d4987dce4d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.85.08817.C7894D56; Tue, 20 Feb 2024 21:18:04 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240220121802epsmtip2c274177845b43966e4d2735153498c4d~1kWG__oCO2982329823epsmtip2_;
	Tue, 20 Feb 2024 12:18:02 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Georgi
 Djakov'" <djakov@kernel.org>, "'Bjorn Andersson'" <andersson@kernel.org>,
	"'Konrad Dybcio'" <konrad.dybcio@linaro.org>, "'Sylwester	Nawrocki'"
	<s.nawrocki@samsung.com>, =?utf-8?Q?'Artur_=C5=9Awigo=C5=84'?=
	<a.swigon@samsung.com>, "'Thierry Reding'" <thierry.reding@gmail.com>,
	"'Jonathan Hunter'" <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Cc: "'Thierry Reding'" <treding@nvidia.com>
In-Reply-To: <20240220072213.35779-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v2] interconnect: constify of_phandle_args in xlate
Date: Tue, 20 Feb 2024 17:48:01 +0530
Message-ID: <1d9b01da63f6$daeb0170$90c10450$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLQP0hpybpPMp0Wp7r3CvZ4KlHU5QIjg6hJrxZRFBA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmum7tjCupBt+PG1vcn9fKaLGtw8bi
	2a1GNouWWYtYLDomb2ex2Pt6K7vFpsfXWC0m7j/LbnF51xw2i8+9RxgtZpzfx2TR+WUWm8Xh
	N+2sFj93zWOxuP2bz4HfY+esu+wem1Z1snncubaHzWPzknqP3uZ3bB59W1YxenzeJBfAHpVt
	k5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0tZJCWWJO
	KVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+P0
	6Y8sBd8lKlp2r2BtYGyV6GLk5JAQMJG4vOE6G4gtJLCbUaJvV2oXIxeQ/YlRYvnlZUwQzjdG
	id2zvrLCdPx7MpMdIrGXUeLhw1/MEM4LRolHx3oYQarYBHQldixuYwNJiAjcZ5H4saIXrJ1Z
	QFviyNMbQO0cHJwCLhIXH8WAmMIC7hJdC6RBKlgEVCXmf58AVs0rYCkx/8xqJghbUOLkzCcs
	MFOWLXzNDHGQgsTPp8vA6kUErCR2Hb7KCFEjLvHy6BGwQyUErnBIPD/2mQWiwUViy9xmqG+E
	JV4d38IOYUtJfH63lw3kHgkBD4lFf6QgwhkSb5evZ4Sw7SUOXJnDAlLCLKApsX6XPsQqPone
	30+YIDp5JTrahCCqVSWa312FWiotMbG7G2qph0TbvkcsExgVZyF5bBaSx2YheWAWwrIFjCyr
	GCVTC4pz01OLTQuM81LL4bGdnJ+7iRGcorW8dzA+evBB7xAjEwfjIUYJDmYlEV6W8iupQrwp
	iZVVqUX58UWlOanFhxhNgaE9kVlKNDkfmCXySuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8s
	Sc1OTS1ILYLpY+LglGpg2uBuxeh2f3pHpmmrzbSP9S3745aeLfZbktEcpeiR5/kz5GDBfEFe
	nY/fs4tyZA/fNvk8icdgyZqbtSGiWRGHHu6W3p375DPnZ/9qUYkbZ8ruL1swr5WPv71Vb+Wj
	o90v3zY+bD/k4N23UuDRH//78+/WON3dvagxc/KuJMWDDw+KrIq480w1qlzyxxHhjX2lbiz1
	PE/yYixjIsLZJ9T733/s5CgdPZ9/ioO4XcHWX9NNnPrV7eL466XfN3R9txU44Cn50Xzvn6n/
	z2/NL9q+wWz6Ya+UuxXrTarkGhXTG1+zz38sEqTpMnXRm9mLvFuv/Nj5vU2ttUmmsr7xwt5F
	dsJx+j53GYt+m5rw/G5QYinOSDTUYi4qTgQAQaaPGloEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSvG7NjCupBn/eG1rcn9fKaLGtw8bi
	2a1GNouWWYtYLDomb2ex2Pt6K7vFpsfXWC0m7j/LbnF51xw2i8+9RxgtZpzfx2TR+WUWm8Xh
	N+2sFj93zWOxuP2bz4HfY+esu+wem1Z1snncubaHzWPzknqP3uZ3bB59W1YxenzeJBfAHsVl
	k5Kak1mWWqRvl8CV8WsVZ8EjwYqVV3qZGhhP83UxcnJICJhI/Hsyk72LkYtDSGA3o8S5z69Z
	IBLSEtc3TmCHsIUlVv57DmYLCTxjlOjaIQRiswnoSuxY3MYG0iwi8JJFYv/mJawgCWYBbYkj
	T29ATZ3KKLH47HqgKg4OTgEXiYuPYkBMYQF3ia4F0iDlLAKqEvO/TwBr5RWwlJh/ZjUThC0o
	cXLmExaYkU9vPoWzly18zQxxm4LEz6fLwHpFBKwkdh2+yghRIy7x8ugR9gmMwrOQjJqFZNQs
	JKNmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOFK1tHYw7ln1Qe8QIxMH
	4yFGCQ5mJRFelvIrqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5v73uTRESSE8sSc1OTS1ILYLJ
	MnFwSjUwLb0cbfizqpLjzl3DF8+OZX/xKpJSeyW7483UXR9qb5x/0CzvenVdyYbQjDWbv4S+
	5o/liC6cpbNYNvA895UkgxO7wrZY6HIt64iP6v8Y2rT8X979CapsVw6d/yE7zUihXdlJN+CN
	l+Hdp5fYb7lm+eq+ZlsicfBOW9zhfTcKWIS4alYvzcjc/u/XqlP33Rv+u4VPPibvvbvNLjL3
	U3JM6yWXOiaRNxdeZjtUWru+Fw3xWMj491OKSv2i/W0X37Ux8/j3WM+KUQqcP9f5fE6fxZ+d
	K0xWPmtL8//p2cCt52E1qzm/gct/ueuVtau8OZYV5y650vXGs7pRZZpTluLjXr1qiyPsD+Ru
	xyyJ0FRVYinOSDTUYi4qTgQA33CUyEMDAAA=
X-CMS-MailID: 20240220121804epcas5p3f01e75b1089af1edf6db4ee3ea3a5efa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220072224epcas5p4ff60556b0b5632abfc44d2b8ad932b8f
References: <CGME20240220072224epcas5p4ff60556b0b5632abfc44d2b8ad932b8f@epcas5p4.samsung.com>
	<20240220072213.35779-1-krzysztof.kozlowski@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Tuesday, February 20, 2024 12:52 PM
> To: Georgi Djakov <djakov=40kernel.org>; Bjorn Andersson
> <andersson=40kernel.org>; Konrad Dybcio <konrad.dybcio=40linaro.org>;
> Sylwester Nawrocki <s.nawrocki=40samsung.com>; Artur =C5=9Awigo=C5=84=0D=
=0A>=20<a.swigon=40samsung.com>;=20Krzysztof=20Kozlowski=0D=0A>=20<krzyszto=
f.kozlowski=40linaro.org>;=20Alim=20Akhtar=0D=0A>=20<alim.akhtar=40samsung.=
com>;=20Thierry=20Reding=20<thierry.reding=40gmail.com>;=0D=0A>=20Jonathan=
=20Hunter=20<jonathanh=40nvidia.com>;=20linux-pm=40vger.kernel.org;=0D=0A>=
=20linux-kernel=40vger.kernel.org;=20linux-arm-msm=40vger.kernel.org;=20lin=
ux-=0D=0A>=20samsung-soc=40vger.kernel.org;=20linux-arm-kernel=40lists.infr=
adead.org;=20linux-=0D=0A>=20tegra=40vger.kernel.org=0D=0A>=20Cc:=20Thierry=
=20Reding=20<treding=40nvidia.com>=0D=0A>=20Subject:=20=5BPATCH=20v2=5D=20i=
nterconnect:=20constify=20of_phandle_args=20in=20xlate=0D=0A>=20=0D=0A>=20T=
he=20xlate=20callbacks=20are=20supposed=20to=20translate=20of_phandle_args=
=20to=20proper=0D=0A>=20provider=20without=20modifying=20the=20of_phandle_a=
rgs.=20=20Make=20the=20argument=0D=0A>=20pointer=20to=20const=20for=20code=
=20safety=20and=20readability.=0D=0A>=20=0D=0A>=20Acked-by:=20Konrad=20Dybc=
io=20<konrad.dybcio=40linaro.org>=0D=0A>=20Acked-by:=20Thierry=20Reding=20<=
treding=40nvidia.com>=20=23=20Tegra=0D=0A>=20Signed-off-by:=20Krzysztof=20K=
ozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20=0D=0A>=20---=0D=0A>=
=20=0D=0A>=20Changes=20in=20v2:=0D=0A>=201.=20Drop=20unrelated=20gpiolib=20=
changes=20(Konrad,=20Thierry).=0D=0A>=202.=20Add=20tags.=0D=0A>=20---=0D=0A=
>=20=20drivers/interconnect/core.c=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=20=204=20++--=0D=0A>=20=20drivers/interconnect/qcom/icc-common.c=20=7C=20=
=203=20++-=0D=0A>=20drivers/interconnect/qcom/icc-common.h=20=7C=20=203=20+=
+-=0D=0A>=20drivers/interconnect/samsung/exynos.c=20=20=7C=20=202=20+-=0D=
=0A>=20=20drivers/memory/tegra/mc.c=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=7C=20=202=20+-=0D=0A>=20=20drivers/memory/tegra/tegra124-emc.c=20=20=20=
=20=7C=20=202=20+-=0D=0A>=20=20drivers/memory/tegra/tegra124.c=20=20=20=20=
=20=20=20=20=7C=20=202=20+-=0D=0A>=20=20drivers/memory/tegra/tegra186-emc.c=
=20=20=20=20=7C=20=202=20+-=0D=0A>=20=20drivers/memory/tegra/tegra20-emc.c=
=20=20=20=20=20=7C=20=202=20+-=0D=0A>=20=20drivers/memory/tegra/tegra20.c=
=20=20=20=20=20=20=20=20=20=7C=20=202=20+-=0D=0A>=20=20drivers/memory/tegra=
/tegra30-emc.c=20=20=20=20=20=7C=20=202=20+-=0D=0A>=20=20drivers/memory/teg=
ra/tegra30.c=20=20=20=20=20=20=20=20=20=7C=20=202=20+-=0D=0A>=20=20include/=
linux/interconnect-provider.h=20=20=7C=2011=20++++++-----=0D=0A>=20=20inclu=
de/soc/tegra/mc.h=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=
=207=20++++---=0D=0A>=20=2014=20files=20changed,=2025=20insertions(+),=2021=
=20deletions(-)=0D=0A>=20=0D=0A=0D=0AFor=20Samsung/Exynos=0D=0AReviewed-by:=
=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A.=0D=0A.=0D=0A=5Bsnip=
=5D=0D=0A>=20--=0D=0A>=202.34.1=0D=0A=0D=0A=0D=0A

