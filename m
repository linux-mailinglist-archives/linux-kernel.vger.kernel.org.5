Return-Path: <linux-kernel+bounces-10765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5171881DB7B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15181F21820
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AFECA69;
	Sun, 24 Dec 2023 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kI+9RdT9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2A746B;
	Sun, 24 Dec 2023 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436140; x=1704040940; i=markus.elfring@web.de;
	bh=xPOZJwyuU2nZ40HhhBkd6/p4ub+Ys2PvUwGIEA88uOk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=kI+9RdT9y3YBcqQmU8AnmSqWOLc9pef+PlVwff+u9XrHAUp3YD4nU8cs2H4/wbD2
	 /+iH/U+SXwbAu0HfYudpVRZQFq2MufFD8vuFZ7lv2epRmyZGt+VCl38v37dwkYnI9
	 gqdQfk/pEdykw9n1UhWV/NZAYBxRgLXJaj0OgpSn4Gfl4taJxLdPA1Swlmf+2CtYM
	 08J62D7gJ1vfdLD0969kVMa3+ShInJn4+spZuGBB2qJ0AKzNuXuOjlFs1FoALrCJz
	 no8P7v/S/dSXEqAZcR65q9nOIJzSHwc/YraTlWreDwL6jUrEVJF9WNE1h2X7vj1cZ
	 HytpbcgdY4qaXz+xfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1rHzWI0ix8-000z2J; Sun, 24
 Dec 2023 17:42:20 +0100
Message-ID: <ee5499f6-e06f-4b6a-9483-b73646660117@web.de>
Date: Sun, 24 Dec 2023 17:42:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 04/10] clk: ti: Less function calls in ti_fapll_setup() after
 error detection
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
X-Provags-ID: V03:K1:ZZEXd63kDl+1X6VLV9csl6o6Tolw8zBW2zGW03MPQm51PBoxFmB
 OfVJrS3T2lRZ+Lpev6rZc7KJj2SZ1I1X4uc208XygpBiixeMxL1gAmfw53gY5AGgV3X6u6U
 RNxWEGNw2HslqJqOWwC/RimZForGOuPXfYCVgjsioAOo8zx/EI7wCon85BC4ldckoIVZYsV
 ouKmDtS8wq8lcXtClFGfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qc5Akm03OAM=;VwVf1e59LJU+8iW5h/2yXzamYCH
 +R1xK+oIQ4s5cfz2JO2Pbh1F7norfdph3z3VVExYc+WG6cMRBOuxz6U9AgmPrjy/QzXnDStJ5
 Aed7BO1YqnO92NNEbvOr5eUOnx2ejvT7GCzSKKOAIfFH3jGLRlv9Gwq3acYrvvM0R+ojS7QFJ
 YT6dHTENOF7UYhKSWEntlmCr+Nw9FYgPmyGvirTRkxwdodsaJ1/yTZI19hUlj6sNSKjchyuE2
 KouYS5Ahz4RXFW1Iox1NI0NTU0MUWcReio/fcMd8944tCwZLXWrvXcmVSD3zmABFMDqCCS4LG
 mS46E0er/+akh5PdbwrIdmj11ErJHrI2jJOnD45lf4mFFwvTAeshOs8Y0Tuh8k5dnmURi2R8M
 6H3Qt+pHR87c8Z2MDf13y3SC8anYmWgEZmFOcWtqn8MciFhTPLlp+U7oFcZVp0a3d5gH2Ybud
 LJMKrhLrZeifbcwFkz9pBCUxqxrRE8BbfBG6QI0RzMufKdkHMXiAFaK1oK5pXkftK8PxtSBzi
 DvoZ00ph9P/cH9ZB7ipBT6+ASEjBXPL8AxmPiL/W9TEfhrhNALwchEXYUfJP0AUzffsv75Ui9
 OgPiivc824rL2oi96oI3dAzJW/sujs2Hiz2/Fq/E8e2GS8g/6+CEtzt/sXLOuCScGXuppvQEV
 pu4LcaHi1+hYNJsYY47/jgYcwiYh/Lyub5sfAGd39d8cBij+UkjJh6awy3K1yOP7++B4HLG/a
 Jop+KPnIQCBrBunnK6RzyTHAgHPN71PSQN5UfE6xboUd38pGF37AUHc9yBxSONZ7oA8QJ3pFH
 ONJ6eMVtIQqe55Wc1xq6HR0NvmBilq8slcnUjYakRuP/kX6KbOSFGv4xd7OgAFwjhHvL2/m18
 JqXmZIarHlwmhMxWNaC8lhCQTgog1RxoptubxDFTAw/3zYMDT4VNFSA3Uje06J6XhzrW77Zkw
 VM57DdlWmLQsKsOqABrFmWa7ts8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 13:55:44 +0100

The kfree() function was called in some cases by
the ti_fapll_setup() function during error handling
even if the passed variable contained a null pointer.

* Adjust jump targets.

* Delete two condition checks which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/fapll.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 2db3fc4a443e..e9956e3ccd65 100644
=2D-- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -546,11 +546,11 @@ static void __init ti_fapll_setup(struct device_node=
 *node)
 				   MAX_FAPLL_OUTPUTS + 1,
 				   GFP_KERNEL);
 	if (!fd->outputs.clks)
-		goto free;
+		goto free_fd;

 	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
 	if (!init)
-		goto free;
+		goto free_clks;

 	init->ops =3D &ti_fapll_ops;
 	name =3D ti_dt_clk_name(node);
@@ -559,7 +559,7 @@ static void __init ti_fapll_setup(struct device_node *=
node)
 	init->num_parents =3D of_clk_get_parent_count(node);
 	if (init->num_parents !=3D 2) {
 		pr_err("%pOFn must have two parents\n", node);
-		goto free;
+		goto free_init;
 	}

 	of_clk_parent_fill(node, parent_name, 2);
@@ -568,19 +568,19 @@ static void __init ti_fapll_setup(struct device_node=
 *node)
 	fd->clk_ref =3D of_clk_get(node, 0);
 	if (IS_ERR(fd->clk_ref)) {
 		pr_err("%pOFn could not get clk_ref\n", node);
-		goto free;
+		goto free_init;
 	}

 	fd->clk_bypass =3D of_clk_get(node, 1);
 	if (IS_ERR(fd->clk_bypass)) {
 		pr_err("%pOFn could not get clk_bypass\n", node);
-		goto free;
+		goto put_clk_ref;
 	}

 	fd->base =3D of_iomap(node, 0);
 	if (!fd->base) {
 		pr_err("%pOFn could not get IO base\n", node);
-		goto free;
+		goto put_clk_bypass;
 	}

 	if (fapll_is_ddr_pll(fd->base))
@@ -653,14 +653,16 @@ static void __init ti_fapll_setup(struct device_node=
 *node)

 unmap:
 	iounmap(fd->base);
-free:
-	if (fd->clk_bypass)
-		clk_put(fd->clk_bypass);
-	if (fd->clk_ref)
-		clk_put(fd->clk_ref);
+put_clk_bypass:
+	clk_put(fd->clk_bypass);
+put_clk_ref:
+	clk_put(fd->clk_ref);
+free_init:
+	kfree(init);
+free_clks:
 	kfree(fd->outputs.clks);
+free_fd:
 	kfree(fd);
-	kfree(init);
 }

 CLK_OF_DECLARE(ti_fapll_clock, "ti,dm816-fapll-clock", ti_fapll_setup);
=2D-
2.43.0


