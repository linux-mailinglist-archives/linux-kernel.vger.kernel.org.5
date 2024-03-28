Return-Path: <linux-kernel+bounces-122646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32E688FADD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7601F2947C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2355FB88;
	Thu, 28 Mar 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tm5tMuo+"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02754664
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617272; cv=none; b=JLk62QMV8QoJ2nMO+AOWYONC07cGLWCF361GwNV/OCUYDARXwGURW5eiY5fqOF/heFg9fpeBC7mJwu5OrCwufKkdiiBw6gU+l9XgOc5HoLz3lifvTulGgpfbWslAf0ymhBxps2QuHQbpedr841W8blx0ElQX4ZgqlexcEZe+tlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617272; c=relaxed/simple;
	bh=NvRgnweRNx8jfh9jFYr4kyG4aZ6/vwkHqoAX75g9yjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=pEZDk9+D0EVfUshz5LZ/Upx0NYNDRHWrjB++h4GWvGIGHthjScQFMAS77ooGiZR6+P9o0WKrTt7IJ88ZG8g0oGRpE3/SQ9Yz+VhCDupGuTtwjdIkUoAkZLevz3+haIwehOconZqnUQ66Nked8X6/S3EUCRXy7VlL/qELUnfwHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Tm5tMuo+; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240328091427epoutp0297df3d12962725cf92c0029c529bcc93~A4tYb6nBZ0939909399epoutp02o
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:14:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240328091427epoutp0297df3d12962725cf92c0029c529bcc93~A4tYb6nBZ0939909399epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711617267;
	bh=XZNLfrC7sORfa/3+gXDEZEzLM/IoNByBCHeH72dhZic=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Tm5tMuo+FJY5rsB83ByZrrMx+VImEmgMRCjIPNAPeAXuFJ0SUtIHt+HULf6glOQjf
	 hRfkzhZstprXle+QJOclOCle6zzt71YjJU/TLr7dGcptE21k9APD4sR3RARVtbi4mJ
	 X81PbJf3yI4fEHwjjYRN77oAuo41K2CrehFmO8b0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240328091426epcas2p208bab96ab52db40fb58d0091188f5057~A4tX1gJge3121631216epcas2p2B;
	Thu, 28 Mar 2024 09:14:26 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4V4yXf4q51z4x9Q1; Thu, 28 Mar
	2024 09:14:26 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	BC.F0.09665.2F435066; Thu, 28 Mar 2024 18:14:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240328091426epcas2p4f227abb6cd7e710f49f4e61aa022f74f~A4tXDFxY13276532765epcas2p47;
	Thu, 28 Mar 2024 09:14:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240328091426epsmtrp113175e5df09bfaf7961f2a532f0f0bfb~A4tXCUtKk0853508535epsmtrp1F;
	Thu, 28 Mar 2024 09:14:26 +0000 (GMT)
X-AuditID: b6c32a47-b9bfa700000025c1-d5-660534f247a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.8E.08390.1F435066; Thu, 28 Mar 2024 18:14:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240328091425epsmtip22419b86997fe6f36ca040526125ccc0d~A4tWyT-0B2411324113epsmtip2h;
	Thu, 28 Mar 2024 09:14:25 +0000 (GMT)
From: Jaewon Kim <jaewon02.kim@samsung.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sylwester Nawrocki
	<s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jaewon
	Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] clk: samsung: exynosautov9: fix wrong pll clock id value
Date: Thu, 28 Mar 2024 18:10:00 +0900
Message-ID: <20240328091000.17660-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhe4nE9Y0g/u/FS0ezNvGZnH9y3NW
	ix0NR1gt9r7eym6x6fE1VouPPfdYLS7vmsNmMeP8PiaLi6dcLQ6/aWe1+HdtI4sDt8f7G63s
	HptWdbJ53Lm2h81j85J6j74tqxg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
	MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpOSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
	klNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd0TvvDnvBO56KxXP/sjQwzuDuYuTkkBAwkXjU
	18MIYgsJ7GCUmNBo18XIBWR/YpR49mwWK4TzjVFiY99iVpiOww0zGSESe4GqWr4wQTgfGSVO
	969mBqliE9CW+L5+MVi7iEAbk8TTU9/BHGaB9YwS1x+cAKsSFvCUuL9tD5jNIqAqsf7CGTCb
	V8BW4sWPo4wQ++Ql7p6ZBRUXlDg58wkLiM0MFG/eOpsZZKiEwEd2iXk9X9khGlwkzkzrgDpW
	WOLV8S1QcSmJl/1tUHa+RNuVM1B2jcTGBZegltlLLDrzEyjOAbRAU2L9Ln0QU0JAWeLILai1
	fBIdh/+yQ4R5JTrahCAa1STuTz3HBmHLSEw6spIJwvaQmLpoJTR8YyWOv/vPPoFRfhaSZ2Yh
	eWYWwt4FjMyrGMVSC4pz01OLjQqM4bGanJ+7iRGcQrXcdzDOePtB7xAjEwfjIUYJDmYlEd6d
	R1nShHhTEiurUovy44tKc1KLDzGaAoN3IrOUaHI+MInnlcQbmlgamJiZGZobmRqYK4nz3mud
	myIkkJ5YkpqdmlqQWgTTx8TBKdXA1Ji8aUPLzrI3xp822E/KWZ+zeqbYoYX2AdfVVr/03nbB
	IDv3pWG3m4PInv1tO7UO73/otHffOXWBB0pX3rkbbmkrrMl5przuz0auqcsP65Wuf8y2YBqb
	+qyfy758f9RvxB04S+uKUmuWQfv6rdtXpTe+rT2TWxj99vhZpp8WDJa/jt1NjpEtk5nsd8/W
	6Gjpxl0/lYuibk7kb1uiY73YNordylvih7Oiy+rU5KMXM4tTesK3vRAOuun1vOayHdune+fO
	/bMP4b7WL2t+p/fc6vDiDMkrrld7mbp9XRx/1Eya+fbn5I+NzYe79x7p472vsSbx6Se+WMu7
	B1je7/4esYcrgq36eRSDr/qf3xb3HymxFGckGmoxFxUnAgC56IwbKgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvO5HE9Y0g22frCwezNvGZnH9y3NW
	ix0NR1gt9r7eym6x6fE1VouPPfdYLS7vmsNmMeP8PiaLi6dcLQ6/aWe1+HdtI4sDt8f7G63s
	HptWdbJ53Lm2h81j85J6j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4MronXeHveAdT8XiuX9Z
	GhhncHcxcnJICJhIHG6YydjFyMUhJLCbUeLUu15WiISMxPJnfWwQtrDE/ZYjrBBF7xklJj4+
	xgKSYBPQlvi+fjFYQkSgi0liypE/bCAOs8BmRolHHw8zgVQJC3hK3N+2hxnEZhFQlVh/4QyY
	zStgK/Hix1FGiBXyEnfPzIKKC0qcnPkEbAMzULx562zmCYx8s5CkZiFJLWBkWsUomVpQnJue
	W2xYYJSXWq5XnJhbXJqXrpecn7uJERzYWlo7GPes+qB3iJGJg/EQowQHs5II786jLGlCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MHU+/b9ynuxE/9ln
	9Kc2HI9ceKZoTi+nnZG9sJqMuO9eh6yyvVOcZQ59z1h8Pl1E1UT8rc4f6YPlAdz/1LX+W6tc
	4PZZ5X/LVeBMeEdtvsT0QsGTvU1vCzfkcbycvv/dnpnrJi2uCX4d8C9S4UpNSfmOcwZ1t3li
	VBY77ZvwT13/t7Xlh+rsdb+inltdOr7niQx/ccQfCblyl0cuR6/8sCt04iwOTnn3OMXONLTi
	d3LExGypjgeL/P/rPVE87Ndl5ZDzWY/rOlPuv8IDrCbrdpxd3azx6XJfx+YDqsA4nDontub1
	x1Ctw/NPn3vOvHrltbxD6znaIhxSfbM/ant8exGz6r70r5Wnd202itdyUGIpzkg01GIuKk4E
	AL+axcXbAgAA
X-CMS-MailID: 20240328091426epcas2p4f227abb6cd7e710f49f4e61aa022f74f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240328091426epcas2p4f227abb6cd7e710f49f4e61aa022f74f
References: <CGME20240328091426epcas2p4f227abb6cd7e710f49f4e61aa022f74f@epcas2p4.samsung.com>

All PLL id values of CMU_TOP were incorrectly set to FOUT_SHARED0_PLL.
It modified to the correct PLL clock id value.

Fixes: 6587c62f69dc ("clk: samsung: add top clock support for Exynos Auto v9 SoC")
Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/clk/samsung/clk-exynosautov9.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynosautov9.c b/drivers/clk/samsung/clk-exynosautov9.c
index e9c06eb93e66..f04bacacab2c 100644
--- a/drivers/clk/samsung/clk-exynosautov9.c
+++ b/drivers/clk/samsung/clk-exynosautov9.c
@@ -352,13 +352,13 @@ static const struct samsung_pll_clock top_pll_clks[] __initconst = {
 	/* CMU_TOP_PURECLKCOMP */
 	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED0, PLL_CON3_PLL_SHARED0, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared1_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED1_PLL, "fout_shared1_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED1, PLL_CON3_PLL_SHARED1, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared2_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED2_PLL, "fout_shared2_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED2, PLL_CON3_PLL_SHARED2, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared3_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED3_PLL, "fout_shared3_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED3, PLL_CON3_PLL_SHARED3, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared4_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED4_PLL, "fout_shared4_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED4, PLL_CON3_PLL_SHARED4, NULL),
 };
 
-- 
2.43.2


