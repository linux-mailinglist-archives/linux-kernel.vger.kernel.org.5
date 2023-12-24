Return-Path: <linux-kernel+bounces-10771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCCB81DB98
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7120B1F21B08
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E60D267;
	Sun, 24 Dec 2023 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jGND4Y9I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112B79E5;
	Sun, 24 Dec 2023 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436643; x=1704041443; i=markus.elfring@web.de;
	bh=QWfrLn5Mvq6EClrCdDR9YcOT+EUQjWH56hvUXCNkDTo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=jGND4Y9IkHAqEg8K4v4mIC6aIbTEe1Uas731nInK8zy0ZcCzTY49LdfFIN1go8ZW
	 Abnf5nEK1Ddy0PlNpMcwgr3IbNJcFzHTK1Roj1m+Qn5OHuGVs7uhC0ZW2cV8Xxi7q
	 kRsQmYlV2l07IMjeOaqRx9yXYiIyLG0MfGU4Wz7MMeHxUpz+vu5xyGsnb3cFAqMa3
	 euIAFisPQWRcEKHtGa1irfcEgL31RXDhG4zc8/ZADELBqD2tL0gaE31btDACBWcp4
	 D2iVi9rUlTxuEYZi808tP+FacL1d/N4qQ3F5/FW4pIbR1YqTxJ2cMfVA3xUrVz4+o
	 5kF7eaXVXOqQ4MsKuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtyA4-1qypRP30ai-00uSde; Sun, 24
 Dec 2023 17:50:43 +0100
Message-ID: <b11039e4-69c6-4247-b4ba-c442b9427231@web.de>
Date: Sun, 24 Dec 2023 17:50:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 09/10] clk: ti: Less function calls in
 _ti_clkctrl_clk_register() after error detection
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
X-Provags-ID: V03:K1:/MWeLp3bl5k34XvHfUI/W2lEnDBpqKjkeUU/BEXyT8r+Vr6kXuW
 JYz6AV7/4XrRs/G+WutGLHoSbx3hEdcxD2epWe7JxWXQy84XynjtfQsvXuXobN8Di7EBNIL
 hLQVGXzSJhu3uXEemeWbbf54hrJsAaZb4ualaE/1rrEJJ+pxVgoiRCxqOmeCJevBn5RHYFe
 6WWYY+6KdYDsUZKQ9TvkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hj4f7rq9WDs=;5Np9XTbAJN9ju3o5KWqwGcQaRfV
 FwzOFVEUh3j4f+NVlPqWktWkN2BjHcej/W9EavpqEfF+LehycYYBa3Lamy1GsNyaiKPVTFWKI
 1xDr2+WignlNX1ZZz18UcW5Nsrvx31+vW7I37liaKDaf3GgPtXC32li8fuJhSquJLZ0kRT9hs
 QylzSF/HsxauthrLGkM6fJK0Ob2reR5YPGTPvIZkBr7959ZG9uwgsc3i20fj23jLFQIHuPzYP
 0O0N/kyAtIE3sJyXlrNxG7+JkR70vl9nsnq21VpEMrS9G0zDecO0TDBXSxupJOQkc91YhpCIO
 snE9VEaP2nFlJP6izdvGXotTOqi8vl69htKAuCcoGe8O7d2KqMgfN8HcN3oBTOePTTec/lvPV
 jnkh4n8AxTxD5hHTKnCABwiBkwT8Y4TsKs2pC6407r52AS3YYLyeYdgsXC/vyoYZMxjpNUv79
 sOvoOWYRrO3wTBKBoll04BhVV9TzXruwsq8k3WwUbD6aXArCuVjcpGpw3awTMZAjUgi9CLzsu
 0GP4hIAwy50GUPHSPIKluo9v4w6w9vdwnO4h4U84rgwqFVr8fgmGT+7uqJyXm5EJqm8vZvD7I
 qg4RViMGHVuZt46+pGHa6FvfzRk8uOH86WqqIhXRQ5FHAAtQLdlGftRxoA6sotCT5YVWOw0R9
 Q7lVahjVV4LeyFl+WInH5R/bBBxNQlKo0sXdAqv2wp+KbgbCGAXg55m3B15pwqghhwzY985Bn
 oU9Bkbf8JLjB7QhVmZANidHRQF3k/yW8Zd/Uyx6Pnz8Catp3lNuKkRQxRk95GK/bDVMhgwg9e
 zbaPDIorLQ25DUl13YrPB17nK5bWCv/tRV6Uab726rVrQ4zvjAU85arVBT0aqp2A2lCYy2RC3
 XU3JgEN5bKJEEGYjIzfE7hpgbKFyiZaFH3wDV4HffeaUl0jtLXj2Zsv610tErma89RdfTx58p
 8pH+vQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 16:06:34 +0100

The kfree() function was called in a few cases by
the of_omap2_apll_setup() function during error handling
even if the passed variable contained a null pointer.

* Split a condition check.

* Adjust jump targets.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/clkctrl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 5a1bd176160c..cdc3cf1ddddf 100644
=2D-- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -296,11 +296,13 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provide=
r *provider,
 	init.name =3D clkctrl_get_clock_name(node, clkctrl_name, offset, bit,
 					   ti_clk_get_features()->flags &
 					   TI_CLK_CLKCTRL_COMPAT);
+	if (!init.name)
+		return -ENOMEM;

 	clkctrl_clk =3D kzalloc(sizeof(*clkctrl_clk), GFP_KERNEL);
-	if (!init.name || !clkctrl_clk) {
+	if (!clkctrl_clk) {
 		ret =3D -ENOMEM;
-		goto cleanup;
+		goto free_init_name;
 	}

 	clk_hw->init =3D &init;
@@ -324,8 +326,9 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provider =
*provider,
 	return 0;

 cleanup:
-	kfree(init.name);
 	kfree(clkctrl_clk);
+free_init_name;
+	kfree(init.name);
 	return ret;
 }

=2D-
2.43.0


