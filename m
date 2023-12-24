Return-Path: <linux-kernel+bounces-10770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F6181DB94
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8681F21A2A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1381CCA6F;
	Sun, 24 Dec 2023 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BQC3R0l4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02A748A;
	Sun, 24 Dec 2023 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436502; x=1704041302; i=markus.elfring@web.de;
	bh=fer0npM9x++5IlF6KQWWoivekp1DBR9tflb/ZiR/dXA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=BQC3R0l4dJB7droV1PcxJ+qkpaEfjBV2qiJVn8WPDTj++zBskW+qj84vAhhe8VpO
	 1bWOnjqdNPGZ6e0RwBtOtVRtGKyYv6ISDt24/6C6Ro+y64de+yzKATIZh2SbMDcs7
	 aQ1PWPDMRPDkwf838+4StruLz866jebSr5ErD2wXHPlu8NX2nWyo4tpvBL49WVB3y
	 RnSwdMabDCR+6DIxqx+Jp5XvZrfml8q9C+Bq+bNUoWa4Rh7evq1mEwMtn4nYpthwL
	 dBq5WWY4crTOUmvR2UDDcuDARFptvAJ4DOpwiqVFUmZrUooSclmhtaVgYy4Mw8Dv/
	 XeP+oFk0em+uOxwlTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1rHzsd3QJO-0011xE; Sun, 24
 Dec 2023 17:48:21 +0100
Message-ID: <0a9cd717-0909-4bc2-b78c-73fe9f661156@web.de>
Date: Sun, 24 Dec 2023 17:48:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 08/10] clk: ti: Use common error handling code in
 _ti_omap4_clkctrl_setup()
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
X-Provags-ID: V03:K1:eokwazI7oC0F6W7Kup8Jd63Lo0nLI7yBgMcHCMI9YWI79wiE0SJ
 LENS88H4VP2YwYihRAUtWIUnURHjK+pf2+EVgeC7zVnUOARgsOpjl62NfuZJScXfcVTMiHc
 0aGZ1S8LmPh7rQaTcgQhPVGqTQob2YhOMBDkI/ijlBCvY0BJ/ILKvZj6x2OwwR2EAp9TqEE
 8PDAGQQFBnyEUQiI+k7kQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0yddZSuIJUw=;rcgSNkMomWPs6nh+rAyPw7L1Z44
 UAnRXoW+vxvufYZjwR/FJpdnYBKVzzdk9buA6iM3KJU7D8w3tkPpRDOHBEfiS5ZWYvaHhT+CO
 SZfP/vKfb7yIO1l1cF3SLxRgc7fFuprB/egnqbYp1GwzrRwVo4Q84vjhDfkBlcTCdIuizu7oc
 v5QX1+nsltp2qgNJc+YWfBxz6pZZhooBZbUJM57lfRi53FNqV4WzKMfb0K8lyJrCMibKHPdUA
 JsvIPX6LVa5sKI7ja3A6fsAWybmA4xLCBMH/tIc5rpeufnN9JcnCSNNUPHeANr05kwztSX6C3
 9QU5SbAni+G5nnW/O9bJaa903G1e1bzWlaoNNAYt5RuYY5Dh266cM8XTrGd26nV5gyTDe5B7l
 14WiIXuovalBBYnc2sw7qT8YePtvlqHAhS0Z9hPS7T0HsXD3x9bkw/A20Dd/WV//FPtFcDXwe
 NG7/0+gfiEbjK0Ou/HFZrbNnPon6+g+x7OsmeDh8AOtdw7xlBmFrWkDTqXsGBXJHGfjE5kYEO
 56Sj78TrZdLarSYvzOYA1yZ4S4YtUMWS//mLHE4UkB3zOSAUFtFZ933m4+OLsLvm3jlRlTPWC
 bflCmWZPchcmKruzvoaRTyI6eUn90b5mE0IWHszIapFIhp5mP+sfhaama9e9x+5aHdqnHfxec
 2PfJB6J8ZZuUjUIQ0rk3xBqeHkFPFbLqKAWN6N2j+ebIAC3OBClaP/5ek5s3BsS3QcISAjSZt
 pHxraHXyP5m7BmPU8JCKwsml6dHIh1gEnTfS0y7t9OWcDJLljnL2PsXU6EQxvieayVVm++yI3
 UHPYBTgikwByklR6dG7d29BR8nv83tzvQDfPQaq148MWgs3Rvhmplm1fIyZeeUFBiy5agFECc
 kcH0Fhq8HyObSaPTLXxjwOQfl+uV5keFPpu7HnvCB1DpivtJgZFY0VXCqw071vNvd/9QdLUjT
 7ep7ng==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 15:56:08 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/clkctrl.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 82b48548818b..5a1bd176160c 100644
=2D-- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -590,10 +590,9 @@ static void __init _ti_omap4_clkctrl_setup(struct dev=
ice_node *node)
 	if (clkctrl_name) {
 		provider->clkdm_name =3D kasprintf(GFP_KERNEL,
 						 "%s_clkdm", clkctrl_name);
-		if (!provider->clkdm_name) {
-			kfree(provider);
-			return;
-		}
+		if (!provider->clkdm_name)
+			goto free_provider;
+
 		goto clkdm_found;
 	}

@@ -603,10 +602,8 @@ static void __init _ti_omap4_clkctrl_setup(struct dev=
ice_node *node)
 	 */
 	if (legacy_naming) {
 		provider->clkdm_name =3D kasprintf(GFP_KERNEL, "%pOFnxxx", node->parent=
);
-		if (!provider->clkdm_name) {
-			kfree(provider);
-			return;
-		}
+		if (!provider->clkdm_name)
+			goto free_provider;

 		/*
 		 * Create default clkdm name, replace _cm from end of parent
@@ -615,10 +612,8 @@ static void __init _ti_omap4_clkctrl_setup(struct dev=
ice_node *node)
 		provider->clkdm_name[strlen(provider->clkdm_name) - 2] =3D 0;
 	} else {
 		provider->clkdm_name =3D kasprintf(GFP_KERNEL, "%pOFn", node);
-		if (!provider->clkdm_name) {
-			kfree(provider);
-			return;
-		}
+		if (!provider->clkdm_name)
+			goto free_provider;

 		/*
 		 * Create default clkdm name, replace _clkctrl from end of
@@ -710,4 +705,8 @@ static void __init _ti_omap4_clkctrl_setup(struct devi=
ce_node *node)

 	return;

+free_provider:
+	kfree(provider);
+	return;
+
 cleanup:
=2D-
2.43.0


