Return-Path: <linux-kernel+bounces-95124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F50874978
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FB3B215A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C763405;
	Thu,  7 Mar 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CHyQwfI3"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114663137
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799713; cv=none; b=mTcrNKUfJNYTFWJLnmzbqCi6TNX/LK1YLxmhM4IzTThekg3wQLpFLSlHgOBG0A5Z8/T39T+xKUgN3NkiCRFlgDLJiXIV+YeLbpSF0jn3O6M8QI8fHhPeaHOOfV8T8pCTtxFVK4eo6XIaY/I53AxuR450c7WqaxPxKqzHYv0cSSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799713; c=relaxed/simple;
	bh=hZRTcmWWWxhQ8c8yez4c37AOY7/nF4HvQ+uh5EqRhQk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=c13zuTkLVruROZtzL7Px8cJHjqpnYvzA4gVCHD8kOsffLT9/jGBaMuMwEuT9LMD4xTbJ7Uyl58/NuskFwtzQgZE9rYzj3umcXCFD9XHeTyM3Aj4ipBj9a9fJkogF05pz8TDzZy6yjMyyzHgV3Gt2BG/g6A3EROn9YQ+PP1wBO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CHyQwfI3; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240307082149epoutp03406046a64f712dc212213fd962d079c2~6bcbbkbY61323413234epoutp03Z
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:21:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240307082149epoutp03406046a64f712dc212213fd962d079c2~6bcbbkbY61323413234epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709799709;
	bh=3W78F17dLjh1QWJeBUfvsdxwQaPK5P3cWiCDKBt+zW4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=CHyQwfI32s1DQAPQ6PixP6JKN2T6pfkt7Q5SPv1Q0cYyIooVpQL0d6ca7tgPyNkzz
	 M6od9bk89w6p1vFdZmOSyJBWN8hMV/b5CAVxmtcsVlSYUiI3VDs4UMS0lczzvI6E0L
	 fjLDScM7i47yrRbl6avUKP8NwmKLLbflJY22SRxM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240307082148epcas2p1b012394ce32ceeb5fb6ca77a16f7dc1b~6bca9jvmA0932109321epcas2p1p;
	Thu,  7 Mar 2024 08:21:48 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Tr2Mc2v5Xz4x9Pp; Thu,  7 Mar
	2024 08:21:48 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.3F.09622.C1979E56; Thu,  7 Mar 2024 17:21:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240307082147epcas2p440fe042df70c6001d91f9dbe5090f3ef~6bcZ-tb8I2501425014epcas2p4l;
	Thu,  7 Mar 2024 08:21:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240307082147epsmtrp29267d18e6dfbfebfd817c18c1fcf86ff~6bcZ_4IZt3066830668epsmtrp2D;
	Thu,  7 Mar 2024 08:21:47 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-d9-65e9791c7970
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.9C.08817.B1979E56; Thu,  7 Mar 2024 17:21:47 +0900 (KST)
Received: from KORCO156694 (unknown [10.229.18.72]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240307082147epsmtip2bd36f10a919d6306a599937faf190f41~6bcZuIhtv0640406404epsmtip2D;
	Thu,  7 Mar 2024 08:21:47 +0000 (GMT)
From: =?utf-8?B?6rmA7J6s7JuQL0pBRVdPTiBLSU0=?= <jaewon02.kim@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>, "'Sylwester Nawrocki'"
	<s.nawrocki@samsung.com>, "'Chanwoo Choi'" <cw00.choi@samsung.com>, "'Alim
 Akhtar'" <alim.akhtar@samsung.com>
Cc: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Krzysztof Kozlowski'"
	<krzysztof.kozlowski@linaro.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"'linux-arm-kernel'" <linux-arm-kernel@lists.infradead.org>, "'Peter
 Griffin'" <peter.griffin@linaro.org>, =?utf-8?Q?'Andr=C3=A9_Draszik'?=
	<andre.draszik@linaro.org>, "'William McVicker'" <willmcvicker@google.com>,
	<kernel-team@android.com>
In-Reply-To: <d508dfc1-bc28-4470-92aa-cf71915966f4@linaro.org>
Subject: RE: samsung: clk: re-parent MUX to OSCCLK at run-time
Date: Thu, 7 Mar 2024 17:21:47 +0900
Message-ID: <000001da7068$7f60f020$7e22d060$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIrup01/zmT+XD05TC1AfQUk5ZcMgJSyW8WsHbDZHA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmha5M5ctUg4X/hSwezNvGZrHl1WYW
	i+tfnrNa7NguYrH39VZ2i02Pr7FafOy5x2pxedccNosZ5/cxWWyY8Y/F4vCbdlaL531A7qdb
	cRarPv1ndODz2LZ7G6vHgk2lHneu7WHz2Lyk3qNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNT
	MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BOVVIoS8wpBQoFJBYXK+nb2RTl
	l5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ6xp3spU8Fi54uWcKcwN
	jH8Euxg5OSQETCSafv5nAbGFBHYwShy9o9TFyAVkf2KU+LHjIlTiG6PE/zM6MA1/LvUxQxTt
	ZZRYvm8HE4TzglGi98o2RpAqNgFPic0v7rGAJEQEdgFVHelmBXGYBc4yS7x8188OUsUpYCfR
	9fASM4gtDGSvP/yLFcRmEVCRuDX1JBOIzStgKXHix2NmCFtQ4uTMJ2A3MQtoSyxb+JoZ4iYF
	iZ9Pl4H1ighYSXQf+84OUSMiMbuzDexWCYEzHBJfP9xmh2hwkVg87QUjhC0s8er4Fqi4lMTn
	d3vZIOx8ibYrZ6DiNRIbF1yCqreXWHTmJ1CcA2iBpsT6XfogpoSAssSRW1Cn8Ul0HP7LDhHm
	lehoE4JoVJO4P/Uc1HAZiUlHVjJNYFSaheSxWUgem4XkgVkIuxYwsqxiFEstKM5NTy02KjCC
	R3Zyfu4mRnAq1nLbwTjl7Qe9Q4xMHIyHGCU4mJVEeFksXqYK8aYkVlalFuXHF5XmpBYfYjQF
	BvVEZinR5HxgNsgriTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoFp
	Z17wgt703wsSjMN85XbKMx5p9Lv8REqmj11vV/MWI74PO86v9Vh9dkeW5fOfd+bYMzv98JMV
	nTLt3+Inkjf1nk2bI3fvVmWL3jclI6cdNy2c1aa+UDk6/Y9ytl/4+ZcJZ1pZfJ8+rdxp3d7k
	yXp0itbWDTqz7hleXuhmef2jMIdl3Ze4S+tMGUy+7F72eLXHcfnegxH9Zboad9/pFAcwe4py
	6xr2l3kFKXqt38g34Wzhgw0e/XzvZJYuzTv3SMD99bpaIX4l2TA+wyStv9cPTI06yFzzsOHR
	4/6Zd95wm86epDD9ObPYtz4DhwYG59Qly2arBVeEzffgmvWiQ6KJaUVXZfjWuMSv5g7XYpmV
	WIozEg21mIuKEwFAkzzqTgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK505ctUg7XvtC0ezNvGZrHl1WYW
	i+tfnrNa7NguYrH39VZ2i02Pr7FafOy5x2pxedccNosZ5/cxWWyY8Y/F4vCbdlaL531A7qdb
	cRarPv1ndODz2LZ7G6vHgk2lHneu7WHz2Lyk3qNvyypGj8+b5ALYorhsUlJzMstSi/TtErgy
	/q9sZy7YpVRxY28nSwPjQYEuRk4OCQETiT+X+phBbCGB3YwSm94bQMRlJJY/62ODsIUl7rcc
	Ye1i5AKqecYocenePSaQBJuAp8TmF/dYQBIiAnsYJS7f+MEG4jALXGaWaL2xjgmipZ9R4u7v
	w2A7OAXsJLoeXgKzhYHs9Yd/sYLYLAIqEremngQbyytgKXHix2NmCFtQ4uTMJywgNrOAtsTT
	m0/h7GULXzND3Kcg8fPpMrA5IgJWEt3HvrND1IhIzO5sY57AKDwLyahZSEbNQjJqFpKWBYws
	qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgmNTS2sH455VH/QOMTJxMB5ilOBgVhLh
	ZbF4mSrEm5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QD04Y8
	C7/7FyYtfLInnG/NvHWhb6dvVNvJUmNd8HRjQb2244SFMjND/tyfumPfjyiPI+lrQkO/5q3b
	FMX9X0I47bfkHyajadcOCfquT/GXSZsov+W9aAdX9O0G6wXXt885xCV/QWGd+IkPJQZnHl7k
	3DNvQsDBKXsDb5ffzpCOvtfxaX9PHAPbL4sFzPmhNz3nCpsc+rtnu8nXGTxvJyxZ/WAyx5/z
	K2/ZP1zpNsk84rDMxBz3lffPZT97a24uf2n+3lvxldce1fCLBjF3i9bJi31478064ezBt4eu
	XN1c4frCULZ+Vpjdk40H4kR/nNibHJO448aFgNOd5UvUJu88a/XZzWPR7UmzzWMeTc5Pcpje
	q8RSnJFoqMVcVJwIAB+qjW88AwAA
X-CMS-MailID: 20240307082147epcas2p440fe042df70c6001d91f9dbe5090f3ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240306032022epcas2p14368c055af804c2f066a6b1ec5cee070
References: <CGME20240306032022epcas2p14368c055af804c2f066a6b1ec5cee070@epcas2p1.samsung.com>
	<d508dfc1-bc28-4470-92aa-cf71915966f4@linaro.org>

Hi Tudor


On 3/6/24 12:20, Tudor Ambarus wrote:
>=20
> Hi,
>=20
> Trying to get some feedback from the samsung experts. Please consider the
> following:
>=20
>                          ---------------------------------------------
>                         =7C                                CMU_PERIC0   =
=7C
>                         =7C                                             =
=7C
>                         =7C  MUX_USI                                    =
=7C
>                         =7C                                             =
=7C
>                         =7C  =7C=5C                                      =
   =7C
>               OSCCLK ---=7C->=7C =5C                                     =
   =7C
>                         =7C  =7C  =5C                                    =
   =7C
>                         =7C  =7C M =7C                                   =
   =7C
>                         =7C  =7C U =7C--> DIV_CLK_PERIC0_USI*_ --> GATE_U=
SI =7C
>                         =7C  =7C X =7C        (1 =7E 16)                 =
     =7C
>                         =7C  =7C  /                                      =
 =7C
> DIV_CLKCMU_PERIC0_IP ---=7C->=7C /                                       =
 =7C
>     (1 =7E 16)          =7C =7C  =7C/                                    =
     =7C
>                       =7C =7C                                            =
 =7C
>                       =7C =7C                                            =
 =7C
>                       =7C =7C  MUX_I3C                                   =
 =7C
>                       =7C =7C                                            =
 =7C
>                       =7C =7C  =7C=5C                                    =
     =7C
>                       --=7C->=7C =5C                                     =
   =7C
>                         =7C  =7C  =5C                                    =
   =7C
>                         =7C  =7C M =7C                                   =
   =7C
>                         =7C  =7C U =7C--> DIV_CLK_PERIC0_I3C --> GATE_I3C=
   =7C
>                         =7C  =7C X =7C                                   =
   =7C
>                         =7C  =7C  /                                      =
 =7C
>               OSCCLK ---=7C->=7C /                                       =
 =7C
>                         =7C  =7C/                                        =
 =7C
>                         =7C                                             =
=7C
>                          ---------------------------------------------
>=20
> Is it fine to re-parent the MUX_USI from above to OSCCLK at run-time,
> during normal operation mode? Experimentally I determined that it's fine,
> but the datasheet that I'm reading mentions OSCCLK just in the low-power
> mode context:
> i/ CMU ... =22Communicates with Power Management Unit (PMU) to stop clock=
s
> or switch OSC clock before entering a Low-Power mode to reduce power
> consumption by minimizing clock toggling=22.
> ii/ =22All CMUs have MUXs to change the OSCCLK during power-down mode=22.
>=20
> Re-parenting the MUX to OSCCLK allows lower clock rates for the USI block=
s
> than the DIV_CLK_PERIC0_USI can offer. For a USI clock rate below
> 6.25 MHz I have to either reparent MUX_USI to OSCCLK, or to propagate the
> clock rate to the common divider DIV_CLKCMU_PERIC0_IP. I find the
> propagation to the common DIV less desirable as a low USI clock rate
> affects I3C by lowering its clock rate too. Worse, if the common bus
> divider is not protected (using CLK_SET_RATE_GATE), USI can lower the I3C
> clock rate without I3C noticing.
>=20
> Either re-parenting the MUX_USI to OSCCLK, or propagating the clock rate
> to DIV_CLKCMU_PERIC0_IP allows the same clock ranges. The first with the
> benefit of not affecting the clock rate of I3C for USI clock rates below
> 6.25 MHz. Is it fine to re-parent MUX_USI to OSCCLK at run-time?
>=20
> If no feedback is received I lean towards propagating the USI clock rate
> to the common divider, but by protecting it with CLK_SET_RATE_GATE.
>=20
> Feel free to add in To: or Cc: whoever might be interested. Thanks, ta


=22DIV_CLK_PERIC0_USI=22 re-parent to OSCCLK is already used samsung downst=
ream driver.
Looking at the samsung downstream SPI driver, if the SPI request clock is l=
ower than the clock that can be supported by the CMU, it re-parents to OSCC=
LK.

There is no problem with clock switching before USI data transfer.

Thanks
Jaewon Kim


