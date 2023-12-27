Return-Path: <linux-kernel+bounces-12101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5781F009
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D83DB21612
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3945C0B;
	Wed, 27 Dec 2023 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Lc7DXIYX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA145BE1;
	Wed, 27 Dec 2023 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703693048; x=1704297848; i=markus.elfring@web.de;
	bh=pl0j2jlBOHpdYumEB//84LCnmc+A204WKvvK9JoNUAE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Lc7DXIYXmosy75uibtNwU2cS73VVZK/cSY03ClKiUfkc3xCBdEUSUhUXcM/eGCuf
	 A1UIWN9B3ov2GXqI0XIudj3W5EBW9Z9gJ1fS2y6hMbedWD6vfQe4PkP/BHjGmUwrt
	 BV8S1Sxtr2OMJd6m2ScU2zt6gfArVTew+s7tFcTz8VBc2coa4xv9YMSqaaYsRrXcQ
	 zeHkfXjEb7GNuEyGITi/A/jgI7YZRRIweLFtE7qEyUUvAn2j4PSwxbIIJeR3JEhxO
	 nXQY6uNdJYdjqGEIC2zDiFigS/klkNAI7h66Hj95lkG6bxYIc3v7wYp6HxffD+Lvn
	 QLvkSkGoyf+g14M72Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaWF-1qzbcp0V5P-00tfcP; Wed, 27
 Dec 2023 17:04:08 +0100
Message-ID: <fcc9f3ed-b8d0-4999-a06c-12a193a516d3@web.de>
Date: Wed, 27 Dec 2023 17:04:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] nfc: mei_phy: Use common code in mei_nfc_connect()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
In-Reply-To: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LZLFy8584bM7nNvphHPs21dMyK0NX/xpt7a2sjgekqHU4DF+tEL
 WjRYzV4ttYUlRj83D4tFBpGhcOM+pyUOdHz/+n+XxOJR9XwmI7NIjO0jcbRPnq2irlBhPI1
 k5lrKOh4gkYiiVMVFys6gf/EnPWuWSSD4VYet/9cD1aRbzIDHxqWH8wPNQho9BZeYQmoeyz
 sI6ttaVBn4EQG3K3p56TA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CSPkLoRkgos=;ca8zaDvllZcwLBz4r7X8tu5athr
 2swnmbXxg5vxZkB9gKnLlviRogKVGDF9nzhbue8EZb4Q+BZU/DTtLKc6h88hpx2K2OECRMgbU
 dbzQIp+MWaBHtLEs9+BfDfFK7qvcJofZba7MESK82h52cTvvebloPxGO+Y63Ale2OTiGiWxcW
 YQPCuqOhhSKeZcTSudoCje9/Uhv0HZgSm6WIzM/A/DbmNjTgpm23Zcr+5Pz6oyvfif9Xp0tex
 BfGmJIEHjUnruhlX2YcaRWFPfUlmcRgw5fvidF+ZElxHySRInhMvhZh2za85Q4JRL1TC7lQOQ
 fO9Qkfag6b8moUMWqqLVC0a+TvloxQIHL+/Ev4clZRlRu0fxCve096umXkb60T0zuVe1VQ1e3
 WiutHjb/l/ByZG23vYJSY3gMizKk2l/v4xYBUS97KIsBAtZF51PuxVtUMXnkBzWyIO4LG8IoB
 o2uMk+khs3zM8Zxpbi7OPceEhO1kO4feu8cdULHTeF47pzm0pxuykc8RRpcnEtRJ88GBBkuik
 EwulqbHTlCz2xBmSe5GO+7V+s8mF3T+E5S0LwU5WFiAreyiH2y4DpJG9bW2PN8bMUTjBcoD75
 74tSywDeRvIOK5aFVkQZoOf7M7yoEJO/of2WreZHJeoSswGFpUfsVKU1NigxW0+PSd0VtHloW
 1fKcVONAIFPQFiIjuW5A9OsUWaILggTjAbUFHH6m5+jg2KMbuo1ySyCroRAuRA8eU3iRV6Ozk
 1Z19v4Fgq3boKVUyJGci/As68vXOL/5mxf3+JjBzLh5WllGWRQKMEgtnIGa+YGcv23QT7fPDN
 lVMp2+pW0Vy9UVXKym1ueqEdf3gTvRvDDMlGC6FQRwXtW+UBqXS9w4CFOhTWpafvhCA+Y5kkG
 mqzltRDgxuhznRqYjNunl9qvC0l60YJyCdhl4l7TgMg2LbHD2fwP9kZ73br6Vo/JsTHeVi7Ka
 3pO1DrocWNovKtms3CXZv7rnWu0=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 16:45:39 +0100

Use another label so that a kfree() call can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nfc/mei_phy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index 937f229f4646..9272564012b3 100644
=2D-- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -157,8 +157,8 @@ static int mei_nfc_connect(struct nfc_mei_phy *phy)

 	reply =3D kzalloc(connect_resp_length, GFP_KERNEL);
 	if (!reply) {
-		kfree(cmd);
-		return -ENOMEM;
+		r =3D -ENOMEM;
+		goto free_cmd;
 	}

 	connect_resp =3D (struct mei_nfc_connect_resp *)reply->data;
@@ -197,6 +197,7 @@ static int mei_nfc_connect(struct nfc_mei_phy *phy)

 err:
 	kfree(reply);
+free_cmd:
 	kfree(cmd);

 	return r;
=2D-
2.43.0


