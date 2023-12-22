Return-Path: <linux-kernel+bounces-9914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C9B81CD30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395241F23DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37602250F1;
	Fri, 22 Dec 2023 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lDIg7aRD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39324B38;
	Fri, 22 Dec 2023 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703262954; x=1703867754; i=markus.elfring@web.de;
	bh=hGP8tPk4MgeQkC4qAQyOA8Ei+y7T+/UNmzFqrcccYrE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=lDIg7aRDDh34j6zbkdf6CqgXZBbESv7YKB2zqIgdiqT+uNNk8lY+hHNWweK2m1bO
	 qz3APVm7iQlKX1IuG++i09NKEGz1o4/pNGa9317fvWM5jSt6hOEXFuR/B5C0G6Lh8
	 PKfNHa0kfs4S7GJVhqVKZiZ3q4xRb6+xGm9jBn35DXMSGf5dY0xwsN8pJRjeWYzdN
	 MIfWmq/Ep5dWOLm5TK+y2gVWWoUZsPZYnqBsfIUazWw4SkGzMABoQsusNkl8dEZQb
	 D0zEAeDH43DGeZPZAv4UDIsHfg9PWM+WE4dgW04SMkV+UpgFioVrF3tXxWvfjjLax
	 DKY4+Hx54IdGSoEnNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1rPTvW2oIC-009Ilg; Fri, 22
 Dec 2023 17:35:54 +0100
Message-ID: <147ca1e6-69f3-4586-b5b3-b69f9574a862@web.de>
Date: Fri, 22 Dec 2023 17:35:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] clk: imx: composite-8m: Less function calls in
 __imx8m_clk_hw_composite() after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
In-Reply-To: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0VWpmmx7o1yt73QWfIGaaqlY5F4i6zRgEqXuglALwGa18bIXKW8
 AOqDAUNW2Cjsz06QxmYHDoTBLM99qSfkA8gpV2Eep67T8N2XvumNoBvMSDZL+MVcICEknKr
 8vh3ggCJemhW9bVcaXt9ybA+0LXlevWtdmdzBDNCUp3uslBto9tV0ddzLPIX7kIkd/LqhoU
 t1UQ7qde2xsX9YWyhSWCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uXnSM6Y3y2Y=;ZqW32hB+ptk2kYuDiM61wjVdQAm
 aL3BOWuDVDmj/GqfYIOBsNosFuxpsJAIF76ShhehyftRzyOf6yL5ej9V0Osq5eHdjvPbL0pYW
 69y+VjNrOqLWmgi8elxKtmmlmx2dxH/kBvOYeSQQyqTyApK+rRRDlDgHwMO3kqzTgV0c19G3i
 HG2/5wIgQ1cUJmr8cQgqiMMR0nuYspFk6UVN3jJxiwBMMu+8AoPykeq7CGp+pfgJhms/Lm8oX
 PvssBnTr/X2ml35RXgK+pjW4l7Zl0GBgnl+sRv3M7pqhxkVPWWBY2+C9h6TtiOMjTJqhHDBYG
 hIs7zhMy4fLuwOKu0oX+KvqhLhvE2SlDuelguWgy8fCKlHIId/35lrgiu7WG0vGKv+Hil8cR+
 l6vXjvpd6HKf8Klc6mUWg5SZjOB5QAe9Tsj5ip9+QWO46DNN6cPySxaXWL2f3I5euzw0QJjhV
 wCFqGq4oqy81Byb9nRUx6EVd1eQooS1AVRGrNf+elEl7N2nvPQxaeb1OGAzvRLl6t3bAFDb/0
 JRtMWEgE59ziYYefEjIvex4DDgnx03Js86TG52IqI334FvTtp6RIK28Mkyo+dSfVsWIYp1Ow0
 B4j1Z2RuLe4LwY0V4+hylU5M2QwFOCejlk7YSWydaSxEVKHBW/1CtLzYpRPjcOPESYxNCF5S1
 +tyyF45iz0PlFvaz8QFSDuoqVGr9Zf8hfhMHXYw8qUglcG5B8Lfq5HPjk2npQoH+8+tIdptms
 HQIebkSco+YYHh3fCZOlKQWNcgNcvN6cV90LjKZWrmxmcxvknesnwFKQxbk/sROz9zoTcWOsV
 tbXYC+SuKi7RtOwpVWGF8bafesB3iRctdCLylup3wAFM2U4vMKNB0lDKbhn+eNjTdKjlE1kUV
 7urRWbSX7kOfqglzfS3fNXVmV1pAmiU1nUpqYQ7ROr7xEBJ5eEPH2Ju8SQ9SdFA6hqC+EI6D4
 I4p6rw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Dec 2023 16:48:24 +0100

The function =E2=80=9Ckfree=E2=80=9D was called in up to three cases
by the function =E2=80=9C__imx8m_clk_hw_composite=E2=80=9D during error ha=
ndling
even if the passed variables contained a null pointer.

Adjust jump targets according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/imx/clk-composite-8m.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-comp=
osite-8m.c
index 27a08c50ac1d..eb5392f7a257 100644
=2D-- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -220,7 +220,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *na=
me,

 	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
-		goto fail;
+		return ERR_CAST(hw);

 	mux_hw =3D &mux->hw;
 	mux->reg =3D reg;
@@ -230,7 +230,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *na=
me,

 	div =3D kzalloc(sizeof(*div), GFP_KERNEL);
 	if (!div)
-		goto fail;
+		goto free_mux;

 	div_hw =3D &div->hw;
 	div->reg =3D reg;
@@ -260,7 +260,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *na=
me,
 	if (!mcore_booted) {
 		gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
 		if (!gate)
-			goto fail;
+			goto free_div;

 		gate_hw =3D &gate->hw;
 		gate->reg =3D reg;
@@ -272,13 +272,15 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *=
name,
 			mux_hw, mux_ops, div_hw,
 			divider_ops, gate_hw, &clk_gate_ops, flags);
 	if (IS_ERR(hw))
-		goto fail;
+		goto free_gate;

 	return hw;

-fail:
+free_gate:
 	kfree(gate);
+free_div:
 	kfree(div);
+free_mux:
 	kfree(mux);
 	return ERR_CAST(hw);
 }
=2D-
2.43.0


