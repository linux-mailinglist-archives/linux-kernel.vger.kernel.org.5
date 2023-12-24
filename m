Return-Path: <linux-kernel+bounces-10764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29781DB77
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2F31C20AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4BCA69;
	Sun, 24 Dec 2023 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LscfqP9U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57F748A;
	Sun, 24 Dec 2023 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436009; x=1704040809; i=markus.elfring@web.de;
	bh=VvcPb3zTVCi+fRkNHAv6TVW423QWVXeGKi1oD5ImWcI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=LscfqP9UCsXC+p+Bea5/LMhWXBrT84uXK4HjQsQ0cZPXo8sOMHm8oYGbm1sC4/5D
	 rFKcYYpIAMwcDmpqDp0W2GxH8DYgYoM7S+Tv7wdlROfKkpw8hrySzW9w7VfqZG2mE
	 3H3b/dt0O16K5pYQVDxOI8P6kNTBGZHNhtCG4+KaEekxVm9+KyV2Fgr+oNBvRik4Z
	 cQd9BKPVy+tgKEd3F98ICVgsWl3kb9ILRda8BFfpsJDMYNgR6dhlEq5zFRzD89ELg
	 epDbvggFfrq3xfK/HrW5yeo+22ZeIQFYkfUy7dFWTuRL4Z4tLdb3VU9WtD6Vk2/Pj
	 23P1cNF7oYXckh07xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuFD7-1qz4iq1mP7-00u6nC; Sun, 24
 Dec 2023 17:40:09 +0100
Message-ID: <159195e8-a382-48ab-8159-0c473ec38ad2@web.de>
Date: Sun, 24 Dec 2023 17:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 03/10] clk: ti: Use common code in omap_clk_register_apll()
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
X-Provags-ID: V03:K1:2vXjRt4bOptLQGsxvaUmJtLomLSQyrX0M9nCcPmXcy1A3BcrvMx
 ImTo7wCvKnUSbuhzGHn8Ej/JxVfgbh5EWGsN/A7Tq65TzIghgmO83Cx0XabRYjcStueZjdS
 x9Jv9s3Av3hQBbUba3TyV/g25q2ejgN+eD87Fjnoog/4gOMhR7bXD/Nu37pg+vLmCffVQ4z
 UbYpjbBXQKaSdkT7RuSVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iK6Nj6+3/mw=;zNeXTuolSeAqzD1ZGuX/uvybDV5
 CEpxweIH7h0PJMUKWOIJPuUglHdMd/+mx1NSrN6orAW9IDcAVJZ98T8Of0n999ZvGygH7pvNN
 VDqQbFfYI8v5y1uNgkOoDabS/yW9cg/+q9JGBfnOq6UEtMs7CxcD16vAqUSV8QBqYb8v52f3Q
 BXl4nQ+Wb1A4vglq18P1w7+8maIEJiQf85+k7uLBeDzX5ej3pltKmTJ13zBr2e0wzvaMcCRev
 xAKQqD3ilbyHFaljCr6jj/d6q0OQa6j705J4ViqmXD6OpLxjdpjrhuW5x6lMK1NCiCyFUqB4C
 ZCPaJWbM0J6JSkdEc+UiYJLSRMrmtx6+VUZ09G7qaIwtSToJj38hDeWyn9Un5YzC345KcXwme
 py8dIzJRCZbZE3uKTBXc0Kq92pJt1Hz2K4iUmGfVHiwwbO6sA9R0g80Kjb+g2WZClfB4x8imJ
 fm/RVL+faT0yPySu946bORv4QaUP/0PY9DBbhIzpdC/YEzE8Q1ZJSYLuT5gTnEaMKAtf+nUas
 8qFaupDaYMCyPVea02m2a9x03LroUUZ0woASD1TK+8mJy620NacERG8A9vQZpOfUX9C28gyBA
 kH5GvrunioV4J15m+NSMuJGW8k/YXH4G85YXUzdxMRyX3jCVneLUFckjhh6OlC1J7YXE8X7pN
 cUjkCT8QzQkLYDJJRXv/elB+Z5mjCRM9HBJPH16M8OpLivo8VZM0J3vib/YORV/cHhdQGu0Ho
 Fv59sOrB2SD8ucAW3uRCeV9Qw5KxSxvXkcO+56uAj4ynUGNWbBLi/IVnpU0rPtaOWJSCuQboO
 LPE86NV28ny7n7/koMWeuOk49LQJil1ynt1xHy4xEMZYBXpFXzd5NsaU4Nao2DYlV59lsiR22
 LM5qzZHFEkQrIcW7Q/L5uEGzM9OEnRPyKZFuosTKH6UDI5EqhKqo02EYUGpQzSzDmnJphKpFV
 o094AXEJaVkx4Iml7TOh8fs9qvI=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 12:40:59 +0100

Use another label so that two function calls can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/apll.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index d2be672521a3..406326883741 100644
=2D-- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -163,16 +163,15 @@ static void __init omap_clk_register_apll(void *user=
,
 	clk =3D of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		kfree(init->parent_names);
-		kfree(init);
-		return;
+		goto free_names;
 	}

 cleanup:
 	kfree(clk_hw->dpll_data);
+	kfree(clk_hw);
+free_names:
 	kfree(init->parent_names);
 	kfree(init);
-	kfree(clk_hw);
 }

 static void __init of_dra7_apll_setup(struct device_node *node)
=2D-
2.43.0


