Return-Path: <linux-kernel+bounces-10769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A581DB8F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1451F21387
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD40CA6F;
	Sun, 24 Dec 2023 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Be00ZAz0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6FC8C7;
	Sun, 24 Dec 2023 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436421; x=1704041221; i=markus.elfring@web.de;
	bh=EoQGOCcDaM4+Ixsw81K6brIiYRjh/R6KiMGIqZjOQN8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Be00ZAz0q80WOxH/zPlihloDIsoIBArOTi+T2sigd+FI/ks9dQTzpLWb0r4DfMQk
	 HKVgew8rCCPHvDhdCPqB9gSBzVl1ygcAawL6Msux7QdNDjS5QMTW+x4/sChiUtF9z
	 tnEk3kqAkwjXlNfgid5Lb3efYOCZse9VkgGwffuIftQgbCRMXqlD0ykKRzFFm496s
	 1vLamSoTZYSfpBwYioTDHcQ3+tjd9nvx3KyG/d7X4ccOWB3F+VmX0795OZ1Wzi++6
	 5AU6rjWg/ispq9qPECjZNt/m7J7y7COh3xxaa2afBjQnxOEIxIlhHKydRJO3crucq
	 /ftkPfOYOp96Je2/vQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91LW-1rNWAl0ZMs-006YG8; Sun, 24
 Dec 2023 17:47:01 +0100
Message-ID: <b4bbcc24-b6ca-4fd3-b8cf-7a2088c67795@web.de>
Date: Sun, 24 Dec 2023 17:47:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 07/10] clk: ti: Less function calls in
 _ti_omap4_clkctrl_setup() after error detection
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
X-Provags-ID: V03:K1:mT4mgdDbP7kJOD75VlWL+dv/P6+ReJspjNxOXgs+MnT/XZ5861g
 ByvEFoUqQtzEYGsLC/Ehh50iodVxf8js+XDAzsuDLuyDMnTzUI7ONqdDUsCm2v2/EVbFr3b
 GPxVApgwAeFIrdYETA9PRtiVQMT5eQOX2Sq+FcBSTbYz8v1N61AMVv7CcOeQuu13ZRvcjPr
 AxrlzZeNRBfowBg3Awxgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rJk7DYD2fyc=;i3/9r49VTokzDt6oWsAGi0UsBe7
 ie8E5hQQMgVmqqdrnGnfFhpb+zaw/VnJiCM8Im8uJf1FBFvRffxnUKufpDjboz76cXTsyKcPv
 bUcFf11uv5lbiulCFSneINgBwuUCFO/YW28uQZI3ANT/9eJUpSP9RviWFLsjiWpycWgRwakqM
 42XXgW+gCtKK0bOETVAiwCPa291I5i+svqQ17eQaZy8Age//4JKVRyOwe6AygCEB+biL6xSGq
 5EIASH1dSuvt9B6rVlghxAm9snl23j6XxlXDGFZI5sK8M9LQ/vOkB1kjfXuLbCVmzWWWf2tk+
 aqC8rW2FGnQNyWFzZNBYTGCoF/cssqhrvRXnMN8QC/ZSvt2/hU1aaK/6+4onzNpnMZp9JXeHv
 KkRcempGQjxPu+8oZZtd3+iz2C4iArW1bkPGzN4OuswWNXSIMX2TsWpeW8ixvKHeM9fzevqbE
 9QMeSpC1Yepvx2VwWYnHnVJqI0/rJGDThQe91Vv23saZwEWwqaBOOAUa9m/tcK40IUoC2qvSN
 yX+HHl+7yvfBphl/LuBhseTHeXbm3JAIqcwnRcNAcqeniWQ41Nz6MIBGzhVydYc5/XafrTWxN
 E1NpiEeB/we1aXBFgL31D1pDePENH3wtHFlzSlkSpVtx4pQjkvX5NVDdp+Q6QKhlRyduy4LoC
 SE3182wree+QWi5w9IJC8iT0AORRbhViKAHkveyvZKMkfGsIe9SKtLzYLwiGW9Q3JnxGX5Azj
 cj4kk4fWkVrny/8AHQl93iLUPlUqmf7XmO861k17WZQq56YF3fZO8xJ3Yu9c7mS4ASn3x7oEy
 zZIRln9eMIPDZSPVxBTDniYByQat1lbbLZjTqjm7dXZMAP2/tKVRGRXBvrWvuPBHZM/yFSy/D
 qmbmldUF3B1nnPFeDxie3mE4e15tb1A+OzqErT5HktLrWZ142sjgk/cLrAg77gDCVBi5IcuFg
 BIN0Ag==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 15:46:04 +0100

The kfree() function was called in a few cases by
the _ti_omap4_clkctrl_setup() function during error handling
even if the passed variable contained a null pointer.
Thus adjust jump targets.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/clkctrl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 607e34d8e289..82b48548818b 100644
=2D-- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -681,11 +681,11 @@ static void __init _ti_omap4_clkctrl_setup(struct de=
vice_node *node)
 						   reg_data->offset, 0,
 						   legacy_naming);
 		if (!init.name)
-			goto cleanup;
+			goto free_clkctrl_name;

 		clkctrl_clk =3D kzalloc(sizeof(*clkctrl_clk), GFP_KERNEL);
 		if (!clkctrl_clk)
-			goto cleanup;
+			goto free_init_name;

 		init.ops =3D &omap4_clkctrl_clk_ops;
 		hw->hw.init =3D &init;
@@ -711,10 +711,12 @@ static void __init _ti_omap4_clkctrl_setup(struct de=
vice_node *node)
 	return;

 cleanup:
-	kfree(hw);
+	kfree(clkctrl_clk);
+free_init_name:
 	kfree(init.name);
+free_clkctrl_name:
 	kfree(clkctrl_name);
-	kfree(clkctrl_clk);
+	kfree(hw);
 }
 CLK_OF_DECLARE(ti_omap4_clkctrl_clock, "ti,clkctrl",
 	       _ti_omap4_clkctrl_setup);
=2D-
2.43.0


