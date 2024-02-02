Return-Path: <linux-kernel+bounces-49616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D37846CF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFEE1C26767
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8410C6A002;
	Fri,  2 Feb 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h2RupUvM"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075360DD1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867475; cv=none; b=h92xF++m0vwY7VqFS9lj4yrpUbZvAx2m6HrXgMZWUAPpMm9OxdghQSkSDam8gmNFMfQMIDseX/Z572JI4DSB4GVRNpWrFrr+wiIZI1JOXjC67FMdf9NmjOIfNgNvyeTiOOPezJNohYMexh1gVYBIBphHobatqQLSPFR5xxwBbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867475; c=relaxed/simple;
	bh=JybYjCCHujDzBFAKMJGr3eMGWChjnD5s5NLoxVK6Pwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=qpWDxKmZ1svat3GpBhyAbnW2Y+vNVXtlc6dk/52NFX1xP3rCkL2vXpUBSuPNT+v90VtHBO3dhhOEsQoZOeYpASQ5HOdN1li2ybzSYtDny5Q57VwcVoxeYxkARPG/nljvlSRCdvKefQwpJJTYxEgO1yUr2fWQMHMHl7JRKnVtDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h2RupUvM; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240202095105euoutp02ea1e511bb0c58ef2e123b3af57ddd474~wAuqaE75o1105911059euoutp020
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:51:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240202095105euoutp02ea1e511bb0c58ef2e123b3af57ddd474~wAuqaE75o1105911059euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706867465;
	bh=Bf7rQoU5d3WU3FmKbvnaNCSLH3IiWNFAQPjzDN4h2DA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=h2RupUvMh0R3caFVIp6ukDjpf3fzWFs+JV1u/Kb0qY6dLR29d9EQyrpUo4euQG168
	 HLxQYntFu/zqdKtC+CxcW8kaCrk4jF4uG45UQ/0UtISz4ng0eg1ZVxlrAlhnbxeKEt
	 B4Bgjcb2z170QYruMReQi59No9xAsDTokL5xk/C8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240202095105eucas1p1aa13c67394f117a9b1c5e2ab9c781273~wAuqCOByy2463424634eucas1p18;
	Fri,  2 Feb 2024 09:51:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 8B.A6.09814.80BBCB56; Fri,  2
	Feb 2024 09:51:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240202095104eucas1p2df4522cc4a7ee29540db1fb61d8e19fc~wAupfiSY-0953409534eucas1p2F;
	Fri,  2 Feb 2024 09:51:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240202095104eusmtrp15fbe04a3ea76a0b1797f65ac46b92a6d~wAupeseMs2064820648eusmtrp1g;
	Fri,  2 Feb 2024 09:51:04 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-d3-65bcbb086c8b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.C8.10702.80BBCB56; Fri,  2
	Feb 2024 09:51:04 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240202095103eusmtip15e86ad33d27184a8710bda287b9b4121~wAuojslAw2135221352eusmtip1b;
	Fri,  2 Feb 2024 09:51:03 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Russell King
	<linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Andrew Davis <afd@ti.com>, Mark Brown
	<broonie@kernel.org>, Lee Jones <lee@kernel.org>, Daniel Thompson
	<daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, David
	Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable BACKLIGHT_CLASS_DEVICE
Date: Fri,  2 Feb 2024 10:50:44 +0100
Message-Id: <20240202095044.1980696-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH97v39t5Ls5LrxcVfAME0wQdSfG3zZjSKC4l3Q+MjkiyLDxq5
	A0Ip2MKY/DFRHGLHoLSi0IKiYApsCpSXQBFpllagNkMY6oBgAUOsMoYWw0Nwttc5//ucx/ec
	70kOidITAn8yUZHGKRUyuRgXYs3WeYeEbDdzmx1vtjPTPYUEc/fBNYSZf3oRMEtaK8EUOSdw
	xv58hGDeNBeizMDsNM6UGbSAqXKXEEzHsyaCuZVzFWNM44MCpr+tFGcsRR2AufH7CBFJsf2D
	fSi7uKAFbMercox9UtBEsIX3JGyrfoRgTTXncXZ40Iyzoz/bELah8hSb31gDWNvDFoR9aQra
	L/pWKI3j5Infc8pNO2KFCfnXjCC1QvjDpPOOIAu4SDXwISH1KVxq70fVQEjSVBWAS+et7wI3
	gMbqIQEfvATw2eAQogakV9KYG87njQC2GMbAe0XFPxrMMxentkD1lBr38EoqEbZU2jFPE0pl
	Y3DJUYZ6Cn7Ubni5W+1ljAqBfeUOgWeDiNoJ71T68v6CYWfXPW+LiFoBu0smvPPRt/nsJoPX
	KqQqfKDRkI3xgih4t6bnHftBl62R4DkQ9uryMF5wDsDyxVGEDzQAZk3+BfiuCDjsWMA9LlBq
	A6xt28SfvAveL0jh0Rc+nFrBe/CF2uZLKJ8Wwdwcmp+xFuptN99v7frjPsozC5fNPYiHaeoI
	1P1Zj2rAGv0Hl+k/uEz/v4VygNaAVVy6KjmeU21VcBnhKlmyKl0RH348JdkE3j5i77LNfQsY
	XTPhFoCQwAIgiYpXiqqDWjlaFCc7mckpU44p0+WcygICSEy8ShQSF8zRVLwsjUviuFRO+V8V
	IX38sxA5GlC8uHzbftkv7EKE5EpgxoL1ZGhD8etXlMOQutd0OGbUJK0vrYURTzZjZl1XaVP0
	CfK57Me6xW8Uf7syUKGpQ509WYSvKcmZMvg/pSU3OzWOgbAdqYEHIteLf+kcP7NB4JrDZst+
	y3T1/SQUKE5vG9J9Uic5cqJWmhdT91nf7NmxzI3DM+7deflXqr7bZz4aIIuJjY2iRWHRxWmh
	/fsuzkeF2o3B17cmvAjJDeoO2faR9pIz6PNHravTFAMZ7avbMM2A5SvnwatfJ5VOz0VI5WbX
	IXrMmh9NP47Oky4XuG/oKNy8MCP98sKv4z32ucc7xdVfzH4ceWh7mcu5rm2PGFMlyLaEokqV
	7F96UzfR9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7ocu/ekGhw7JWTx/tREdosT1xcx
	Wfx8OY3R4u+kY+wWUx8+YbM48+Yuu8X/bROZLa58fc9mMXf2JEaLFV9mslvsfb2V3WJH20IW
	i02Pr7FaXN41h83i0NS9jBZrj9xldxDwuHztIrPH71+TGD32flvA4vG0fyu7x8Szuh47Z91l
	99i0qpPN4861PWwe97uPM3lsXlLv0bdlFaPH8RvbmTw+b5IL4I3SsynKLy1JVcjILy6xVYo2
	tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy+hbtJyxYDFXxfOHB1gbGF9xdDFy
	cEgImEhs6dDrYuTiEBJYyiix9eRlpi5GTqC4jMTJaQ2sELawxJ9rXWwQRZ8YJS6e+8UGkmAT
	MJToetsFZosIZEv82XiFBaSIWaCXReLEoyXMIAlhAXeJeSe7wGwWAVWJiwvOsYJs5hWwlziw
	hA9igbzE/oNnwUp4BQQlTs58wgJiMwPFm7fOZp7AyDcLSWoWktQCRqZVjCKppcW56bnFRnrF
	ibnFpXnpesn5uZsYgZG47djPLTsYV776qHeIkYmD8RCjBAezkgjvSrmdqUK8KYmVValF+fFF
	pTmpxYcYTYHOm8gsJZqcD0wFeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUw
	fUwcnFINTBNm7P25tX2v34GmJXY3TqW5FQt79ZyXFd7hu+wv8+doXvbtimq8ypM/53I2mi+/
	v/fKdDnG3FUbQl9NCj3c1XUz3MN22tRXa28o/DN8XMr8svFz7rxdH1X27Fvwtjw555n+pv45
	8kWab1pEL/ftMm56479a6bWXlsfp/3d8Y/q3+P16ox/yVu/qC0mBWn01sflpfnb/d965bP7o
	wkuZGQwqC3JO73t14XHRl1d689ZHb9/+xMxU99ajmsWzA+L2ujmrlGhN3MqwpnZJZODS0/YG
	O9I73vhwMy/zPGfygtlox1qhU8v/st+5PPtQ3/mSnIUP17rP/73Y+I631bYT+64vbpyvPsGO
	b+Yml7N2cyY8VmIpzkg01GIuKk4EAC+h70VNAwAA
X-CMS-MailID: 20240202095104eucas1p2df4522cc4a7ee29540db1fb61d8e19fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240202095104eucas1p2df4522cc4a7ee29540db1fb61d8e19fc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240202095104eucas1p2df4522cc4a7ee29540db1fb61d8e19fc
References: <CGME20240202095104eucas1p2df4522cc4a7ee29540db1fb61d8e19fc@eucas1p2.samsung.com>

Commit 72fee6b0a3a4 ("fbdev: Restrict FB_SH_MOBILE_LCDC to SuperH")
disabled availablity of the SH_MOBILE_LCDC driver on the RENESAS arch.
This innocent change has a significant side-effect on the ARM's
multi_v7_defconfig, because FB_BACKLIGHT symbol is no longer selected,
what in turn leaves BACKLIGHT_CLASS_DEVICE symbol selected only as
a module. The latter disables some backlight related code in the DRM
core, because the DRM core is set to be compiled-in in this defconfig.
This leaves all DRM display panels without integrated backlight control,
even if the needed modules have been properly loaded and probed.

Fix this by selecting BACKLIGHT_CLASS_DEVICE to be compiled-in in
multi_v7_defconfig.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f7445729cd0..b2955dcb5a53 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -777,6 +777,7 @@ CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SIMPLE=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_AS3711=y
 CONFIG_BACKLIGHT_GPIO=y
-- 
2.34.1


