Return-Path: <linux-kernel+bounces-10762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8781DB6D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416591C20ABE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD07CA68;
	Sun, 24 Dec 2023 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="M1W+/3hU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD1D27A;
	Sun, 24 Dec 2023 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703435921; x=1704040721; i=markus.elfring@web.de;
	bh=CAB4VQvQ8vvQgycqUYcZEZDvRj1YXXBaD0h2ZtqUKNk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=M1W+/3hU0SXqPb0RjBVtvbE+VZL1bLI4eHMUM8OglLo7SrFbIPZzStzubCBn0/8j
	 TvZ2oD8WHtwqnbMyhDL6w9hVD1ZCUNeBqGn8baenssLx5nVa5xykeCUyzAC8b8A23
	 87S78NeOLg0W8eNAer/4d2gx9c7kMnedGAwZ/LEBmXrQPJ1y0L6ogAmfMYEI9tcZv
	 m3wjVlNU3yK3Lka9WaD/NSIYtid2sR2xsev74/7rvx+maBtk8BwA/TprgpeDJjhvf
	 pBKuVQ79V7swSyThB+TfgI40EDhCN7MN8Al90K4c5jNToh4iwOwvLfcDcFEHSxb0l
	 KwgD30iO6Ig8ws2vGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4N98-1rAODG3JJO-011YvB; Sun, 24
 Dec 2023 17:38:40 +0100
Message-ID: <6f3b159f-a3cc-4072-aae8-9792c9d274cd@web.de>
Date: Sun, 24 Dec 2023 17:38:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 02/10] clk: ti: Less function calls in of_dra7_apll_setup()
 after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
In-Reply-To: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0iUr9rY3KOdtRUuHpaTnIE9UM3Ofnc+IVxrPkfGbkvwxqOwawbz
 7QZbl4YM2pyuLyOwskzMe0smfHmXUXiO1mrMToTpXvdOPL1Zexz3liAbnWZ9XgTBe0/ghkw
 GhWbDDprQR3vy9WUrd0pVptMrpZTaFNFx4s7yzGMFHg0Wc+4jWnwVlwcmL1kbH5a9TLvtGJ
 UMvosAlxJlr3lByLehkzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wNYY4Bv+5RY=;k4r5glqF+IDQmcblxV+FmhkJKeC
 akNtHh7j9RuPCJ5AJRHcRrx3X4xmH+j7MKnqiN75sZCvJ1vxYrHgvgmeM3GVZLS2LgcWou4NT
 sn8kQ9hEoseFSLsELpIPloXGyQKPov3sGs8TO4njzi88kO31F8dF2QB2ydayDoBfl90LsNd45
 rIXCtQ3bgAnY64XQKRUvm3gBrr6FAZVzdJYhlSgdIXlcCw1ILRhLCRPonOdIWnHqaqeT1jtqw
 dRCjHDn5EfS2nrTlpGooS5taw8uclJkjLjIuApTFfenktBqTLwPjH2hrvCRUx9VL4qGskFJ46
 fyeYtOSM3xeMespOU8ggufJZ9WpltmfUGq95mXLCy/SXAY7YdfNgFVqEY1n/Y/nZkx9LetJj4
 r5eIvDf+hjdHFYC8OWzShsa1yRllAYYJi2hkQBPDjyLV0wnV6EPS91noF9SbAvpvZUq4HENvI
 N6vgMVrFddPViKeS23l0ekktFFcdJRkC+hzR9KnD/cGyf6gUHjSQFIZO0rwxtjY4ukzp8PgVP
 PZIychVq9YU1O3/9omGBVT21wL6EtDyPPKIfQvryw1K+j0RiMG3dDVnWRoRyhSVXHg+sKfaCH
 TIWrGS+6o83gXD+e8B/pQfjjDQl3sQy1jJUGqj5Zf4WfLoV6vZIEGEd8hBf5gyY3HcQkDMYHD
 ELWJCthfCZi4knZVf0vWO4fT/mpCUF+N+QzOstY2klU7cF5cwgqESet52Cs1X7KMYX8GIZZEI
 9S3CfFknzZe4SqtE1Mlf+7htqS/0OyoOuPYv8KBrmFsWQH2KdXVF2GIwDQ0n3gg4dz0kUvZMz
 d8LW3mUsrzyYs1bythnlYZrnFU3Z/n0cJwlArRezZ3yDTo29bTFmZ6PGpUQEw3UBU4hvwHxf1
 NZ0HOBspcHL0nl+S7RMRybsRIXCyw8BCUU097mRDAK4U6Tz0wDeiZ7fCUpTi5QEDHtcE4DkF+
 MD4p9g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 12:27:09 +0100

The kfree() function was called in up to four cases by
the of_dra7_apll_setup() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Split a condition check.

* Adjust jump targets.

* Delete four initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/apll.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 929c021f0cdb..d2be672521a3 100644
=2D-- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -177,17 +177,22 @@ static void __init omap_clk_register_apll(void *user=
,

 static void __init of_dra7_apll_setup(struct device_node *node)
 {
-	struct dpll_data *ad =3D NULL;
-	struct clk_hw_omap *clk_hw =3D NULL;
-	struct clk_init_data *init =3D NULL;
-	const char **parent_names =3D NULL;
+	struct dpll_data *ad;
+	struct clk_hw_omap *clk_hw;
+	struct clk_init_data *init =3D kzalloc(sizeof(*init), GFP_KERNEL);
+	const char **parent_names;
 	int ret;

-	ad =3D kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!init)
+		return;
+
 	clk_hw =3D kzalloc(sizeof(*clk_hw), GFP_KERNEL);
-	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
-	if (!ad || !clk_hw || !init)
-		goto cleanup;
+	if (!clk_hw)
+		goto free_init;
+
+	ad =3D kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!ad)
+		goto free_clk_hw;

 	clk_hw->dpll_data =3D ad;
 	clk_hw->hw.init =3D init;
@@ -198,12 +203,12 @@ static void __init of_dra7_apll_setup(struct device_=
node *node)
 	init->num_parents =3D of_clk_get_parent_count(node);
 	if (init->num_parents < 1) {
 		pr_err("dra7 apll %pOFn must have parent(s)\n", node);
-		goto cleanup;
+		goto free_ad;
 	}

 	parent_names =3D kcalloc(init->num_parents, sizeof(char *), GFP_KERNEL);
 	if (!parent_names)
-		goto cleanup;
+		goto free_ad;

 	of_clk_parent_fill(node, parent_names, init->num_parents);

@@ -223,8 +228,11 @@ static void __init of_dra7_apll_setup(struct device_n=
ode *node)

 cleanup:
 	kfree(parent_names);
+free_ad:
 	kfree(ad);
+free_clk_hw:
 	kfree(clk_hw);
+free_init:
 	kfree(init);
 }
 CLK_OF_DECLARE(dra7_apll_clock, "ti,dra7-apll-clock", of_dra7_apll_setup)=
;
=2D-
2.43.0


