Return-Path: <linux-kernel+bounces-10760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1D781DB68
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3ECB212CB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22959CA64;
	Sun, 24 Dec 2023 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d2btJZgB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71608747F;
	Sun, 24 Dec 2023 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703435819; x=1704040619; i=markus.elfring@web.de;
	bh=HUtTyqgAjeXilij1EZvW9BI8jaGz1KwDa0ackvdaMP0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=d2btJZgBjrL9shctEps3kZP6ar2tniPSbSRCDxu5GQKJuq9gCNGhMqPt2GrvewjQ
	 3IDdl8d6sMRsR6RugTGpDyuJ8Ny54xfbFq/osyKsFMDoqUGOqMivCT5iVw/Z8zHCR
	 FCBCHvRnPw6aZ8gdXOOdq/roceRzdW8gN0OxeLcSmzHjeVHdzJjWpkmJTlcvrkJM1
	 MpXaBo0FyGv+8i8VfajSsWx2eCa3MqO94+K6TqEQTinPg0c5MvzpFCSjZwzwGuiIN
	 inQVAyjI0MEE+/MMujKR5HtPxyygugniPGRUwm672dw+rBdOc8rF7ZR+FrPj1pkmA
	 1wzR9sjG78uxX4Lm9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HKG-1rJcGY3hhQ-0070lV; Sun, 24
 Dec 2023 17:36:58 +0100
Message-ID: <422c6249-31ac-410e-911d-ec25aeee126a@web.de>
Date: Sun, 24 Dec 2023 17:36:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 01/10] clk: ti: Less function calls in of_omap2_apll_setup()
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
X-Provags-ID: V03:K1:5Zlu4vBjOn8y3rhK/v7xJFB3kzVjuBnaLVTVepoXE3uf2IfFtqB
 6rHVkvjJnEO9/UjDh4AgBecn1KYpjrdkyYpVByNrgF+lPLy6EhBHUwttNktZ3HbbeWAY2WZ
 ynEcS9grOUky6y9Lp7PKZHfuvoi7y2yUIAbBhDW+E2l1Vsw6ZCmN0SawMeLTX7aaB1iirtb
 IJSPvsHD6I4Ry1wVjcZig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iocNUSrfeNw=;wYkjPLwi2LIAvzmFQCTm/TVNKNP
 dySDCNs/XyI8mriI9wR/iF0jYz36JlM7n4uOAlurxXlRCek9gBOiFIB4DPPXou0jXevH3ao4E
 Xf1u50XGvq8y7rjPJkSoJ6d+LELHTsmWYthxYMkHtBxRq/ANC3OCHy0uAI+RuuTCGORLDGLxo
 dZ3pJYhcbIMIGaU0w8sikQ/Fh10GhCu3FHR5XDP1O6zRs+K3O3zFk8z/YwEdMIowxBIWioBco
 DY6oUDExpJtAhyExNYuia88lcq3I+uUU2pVj2AM9iygDwQ2ZsdmgowuktDtsGzG0b/ZLADVUR
 QZWswuvVh7GXTGiukDJz3hIoW92R1dLQQc0fBB9r8VpzKustixfEIblNY/+oznttG0dHfvCRU
 ETRz2J3h0/pM/4RIZdfBRwwWnUCMZkGZcSeOpjVDYV5Dv/DT+cZ9gDNX5WPE3LyEXoVxP6ebp
 fVw8OKY74NAL5VJkUsUMpolCNOxhe/lJsHVtipS2CZV8A9nRMnTtzhsg5/IYdq5/X+W/H0uX1
 CTEHoQGXbZn/QqUAtAcm2W53Kb2YBHP7pkaXEGiPzc7ibeEjEk55QYU0FUaF9Kxoy/05HGwVh
 R49G5+LYIIhoO2+YGY4pRkXqYBSHCgV+VWGu7Ht4yXCgEIYI+H/exhGOjbBzyJk6q8dwVgi+x
 2CCEzxT0B+O1v0p+sCFqiV9+fEthbUCTUIVYUtokvxro/4N9Mcox1ArD0a1KEyBbrIt+HsB3D
 VKEhkDIMAHKCKSaa8Am/FZOL4kGUJ/lQTbrYrWqfi8MlrlOS1NW9XaxdmRHtuEWnXyaPAgrxQ
 //78P2kKxNwxGGT0YMqZtAh73NUtZHsHqpMvgqcRwav8/gHR2SpVtLojRZ26IslwieeL69c+f
 e1d8+55MqT1lMAqYo60S1ZZrJAIXHM01vDHTXOoyPnDUQpiJvuq6eJvU1jei1BFT+a/ShrKuM
 jrI4PA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 11:15:27 +0100

The kfree() function was called in up to three cases by
the of_omap2_apll_setup() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Split a condition check.

* Adjust jump targets.

* Delete three initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/apll.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 93183287c58d..929c021f0cdb 100644
=2D-- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -338,21 +338,25 @@ static const struct clk_hw_omap_ops omap2_apll_hwops=
 =3D {

 static void __init of_omap2_apll_setup(struct device_node *node)
 {
-	struct dpll_data *ad =3D NULL;
-	struct clk_hw_omap *clk_hw =3D NULL;
-	struct clk_init_data *init =3D NULL;
+	struct dpll_data *ad;
+	struct clk_hw_omap *clk_hw;
+	struct clk_init_data *init =3D kzalloc(sizeof(*init), GFP_KERNEL);
 	const char *name;
 	struct clk *clk;
 	const char *parent_name;
 	u32 val;
 	int ret;

-	ad =3D kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!init)
+		return;
+
 	clk_hw =3D kzalloc(sizeof(*clk_hw), GFP_KERNEL);
-	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
+	if (!clk_hw)
+		goto free_init;

-	if (!ad || !clk_hw || !init)
-		goto cleanup;
+	ad =3D kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!ad)
+		goto free_clk_hw;

 	clk_hw->dpll_data =3D ad;
 	clk_hw->hw.init =3D init;
@@ -403,12 +407,13 @@ static void __init of_omap2_apll_setup(struct device=
_node *node)
 	clk =3D of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		kfree(init);
-		return;
+		goto free_init;
 	}
 cleanup:
 	kfree(ad);
+free_clk_hw:
 	kfree(clk_hw);
+free_init:
 	kfree(init);
 }
 CLK_OF_DECLARE(omap2_apll_clock, "ti,omap2-apll-clock",
=2D-
2.43.0


