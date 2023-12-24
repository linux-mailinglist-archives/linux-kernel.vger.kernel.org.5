Return-Path: <linux-kernel+bounces-10767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF05181DB86
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C534281EA6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF69BCA6B;
	Sun, 24 Dec 2023 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ocnEnBLv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C10CA64;
	Sun, 24 Dec 2023 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436334; x=1704041134; i=markus.elfring@web.de;
	bh=rIlcz4hsgLr5IuoUvlYO4snd4l8Oh6JPILbZ0XdVhaI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=ocnEnBLv1ZdoxCh/A5KpMu1pjzoNNj7GkXqDoj73ViELx8GpIH00JTPPdOxHRa27
	 +95eSoF2bYAnIPbk1evHf9ZD+W8ZTBZdhQN8n6xp0ro4G9HAuTFz/7V6ie3d2mxyo
	 ZJFg43yYkDsBqwnb0YYmQT8bQ45JGW3OATujhKfIC2u0kzrEKsl9qoTH5K7KlDIZa
	 tmxjl6wOivtCyO2Btm0n3HX+TcfluDAj8+9bn5Km77MGVV23wBCKsiMA3oNLfx9+p
	 zSul9G2JGsKOFCqBPDtUAVRiYd5g2YRQQ0LITeu6/sKFrw+6JIeDMyWpAsOYk81AI
	 ToMaBdUk8CGlag0EUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrdM-1qxivW1sCG-00tHXK; Sun, 24
 Dec 2023 17:45:34 +0100
Message-ID: <769d269c-126f-477e-a046-d00dcf918829@web.de>
Date: Sun, 24 Dec 2023 17:45:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 06/10] clk: ti: Return directly after a failed kzalloc() in
 of_mux_clk_setup()
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
X-Provags-ID: V03:K1:/6OmN1PZ8R/kwCXXkcrmaU8tPWjwWsHBwdPLlxjovbJAPktU2Lg
 YK8ClV7XYr/8oPrjOf8juijZcJWlPKrpZLrLgVGIUG8JmdMIv8OcWa1i0lUDrbHrgYHN2ye
 fmdARTQORywVsXaBLECgLCwL7rVaydK4b77WPoAxmQCvO90Rh6HBvaOmwtudqpsmgIr4ZnP
 tyG94hmLjq8B6otEpK0jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7AZ2as5BfFY=;q63bFAXQH93kRNCwv0AIiisgcPQ
 WeMEgia6QumAjtMsd0rQoCRh/NNdFC7hgcjQHzO2VO/yH3kHCLhcflgvIbK90OjTD77H30uvj
 v8J8JIdDk2qT3lmGdTBh3rdMBurtS2TiC3VCoFjzbqjE5KQRWIS94/SeLMzkQUFFulrjMWmuc
 3zeZ/b7OyQTmaoQtpTF9zEAG1O24zJtLTxqA7zWw3vOYR9Gr6E68V7kAR/sefQywaqH34IwUP
 c9h9+TXgxKVepF3rSNX6OfYN71T/25YfMZPs4ApZ+8rqbRedzataiDRhDkI1rM3JKH4WfQTB/
 yPYQ9b+DgggVVZ51mhC7cUmuq7sXFiOJa9ASoKu6HhhP5GyA3tz4nqUkqKOk95GsZZOm2bcG4
 R76F9wxXeI/6VdUc687fhFhPH+MkSVJhZOmUcetSNfmKJSX1ByNCKMeoyux1lsC4AD1JcsjrY
 hA6gyYUQoUX63+vPqqgHIYbzZiEku0PDWdhH7wtOuzgohuHzOSUdqHtIlVdmiZ0uY2DxxmuuJ
 v2CXnvEDXwb++vrwchB1AJ+GIPbW3oV6UN0dleVviQq/kPm95LEtLB/6jkSDctrNJWwDVrmEZ
 d3c0Varl0cuSEzXG+sJESY/7rptoL+kFRavnHteBKqugc6qKHrVFCqQ8KtPeFPUmhgv5ehkzd
 jn+qvC89l0dVr61wXSR8POyIPzFt0v+PILMyLlOWtuItOn4a9CvKEmbO5e632y06CApGrY+gg
 pDKQTc2pfGoiLq1FqYAHXyeuO7jpOZs/uh+aZqV5U3pNxkGU1iYvZERV3WLf1PPwZCovmpO8c
 GhKT3qtTv20qEcLVBbhuXi19IVoHfHbDkhD0oSdhL1Eii6Sn6ofexmrASJ5kWemqQFj8NFusy
 r5cpMLaKOONESWby/VGzkVrw7G/DFVPXRYGgL3sSH+YBdH3g+6rCEb3m7v6elra7Tzcf5DoAa
 8//mPA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 14:20:18 +0100

The kfree() function was called in one case by
the of_mux_clk_setup() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 1ebafa386be6..ab1205fa40d6 100644
=2D-- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -182,7 +182,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	}
 	parent_names =3D kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
 	if (!parent_names)
-		goto cleanup;
+		return;

 	of_clk_parent_fill(node, parent_names, num_parents);

=2D-
2.43.0


