Return-Path: <linux-kernel+bounces-21225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953FD828C41
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5F41C24F78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AFB3D569;
	Tue,  9 Jan 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="B29xcGD9"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E33C466;
	Tue,  9 Jan 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704823897; x=1705428697; i=erick.archer@gmx.com;
	bh=PZABZvFu6YfewBVsfWRIsRfRTNc3fsB6tyPmtxoCWCw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=B29xcGD9pJnrAoiLFpmOkfTFB/SsYMSIyA5nwqm9eVATIxvpptcEVeM98ngs2bES
	 pD1uHMpJ5ljFpXEhGCPMExkAnOBH/dY0Wiw0EwtMovH+k7OJtMrfl5PyFPqH1M+1V
	 b6s8y/tIDgaJZCnBBQmu9kj1Ovinw7ZmvRoWVqKFEW6djOjOCsJep/kPOjqoiPx6K
	 tOn2YukORtnKB/zZJLFG3nLZnubmy2x+FMsAYD+Lgn5DP1bTf+mOkuSC4PQJmsAZ9
	 wmPHBXgJack0D08nkI51jCgot4RJyqgHL9iij66K8ZrY/xYs0bSVxqFHIZxd3dKwx
	 Z1qPyn23mPZFHVqoSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N33Ed-1rAqX60qfl-013JkH; Tue, 09 Jan 2024 19:11:37 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] ASoC: ti: j721e-evm: Use devm_kcalloc() instead of devm_kzalloc()
Date: Tue,  9 Jan 2024 19:11:01 +0100
Message-Id: <20240109181101.3806-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FQsFrpfyWYIKyTGfUr8bMQdMIgv0XDftz8xSNidl484g0foWv3
 QsSRpMhc5PM5K1X/QVF3MPErICODTv70QT4510g408rqnzAbuoEQiZR1vcelqJuQF4iPOmT
 J3q307fdOBJKiUQoTeX1O6wQbN5NXKwMbEjbo1uixPcJDUbrk10gHSclH/F1e+qOExIpIUq
 BMNRsVYowKU35EuYzwL1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HqM7Q25+xKA=;ZvHEBSr7KNi6TYu4C+KGhvAVlGP
 s4H5lD02JyV2eVDZIryDMPxkDN4wch7uGmKBucRuWBvCX5Km9GPVjpfyJ1+MDyPq9O5sEiDR5
 Co9Tvtz9GY8FisLl8famEPEwNTp50nsujR+9JS3NTNLmuBOlB0d0fdKrOt+M6qlPyxIiJMMEo
 rJ/o0NpJ4tu+E/aSLJ6sMI70KQPAaTSTRugOVtFLqC7D3M8mfFYEYS5Qsk2Hwax4UgeMNcDqN
 Y60c/TDS0GgxbmgxhWluzfpWIcNR0MmlHyhx1QL1NhuYeBBBWKdrfAHV7qJRmtGKe3VPdf5m8
 co/kioq+0lyGYTzRJ50/CPMvkcVTEc6sJKKGpF/5VQoL9N8LHJgyVQAm+GEL5RBVl0kg64BS9
 zmM3n41TymExB7k0851H3juNGz3APx10CTHTbC9uIa3cnkaKnQKDB0trKXpv+GOY9FKKjafBk
 +zqI9heJT2FKE2RTOmcM/91qiKS0Xq1zV+exknAnh/AeoJUAdgZOJMMkoEJJkgfJ4xvQTTyxi
 DIQpWvkIjuzySdtWl8Uv4gAdMhJTuGrblab2g+ExrpdJxNeb9L0TxDU9vC/XSGwMrE0NTUkCb
 vRGOk2rxZ88XOlJr7DXqLLiW6uIXEz4kTiwZNSJSLtbgJV3HM+giJrLRhqtNiTdcLzc2Xwczs
 7/JMc9NJT0vcjGevcBUbEgpx+lO2GHkuhvIgoeGyO+NevhzJPephji6vg3T7pXEmvuGVM2OTg
 WSgZ0AQsVp9XK0sviU3z/3NQIxtJKIO/VwAMgwSVfHhCCaTIxGspThmvovRSXBBuZVrXOcjY0
 rv2x77IOJRMU20Qiv9guHs1b29h35202a9Ov7C4S9nVr59yn1QBoCHew7Sg8zjchZ0ekYkmtn
 DUZq5E4n+0h5JcEjnD4e69Udeu/dYvxnPhUzMqbzVYG5rO0YUHnMPPv7NhbiJTJ9UIPbH8Xcm
 KkHCdL/Xd5Qc/5RPsv5zlcoGkPQ=

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Changes in v2:
- Fix the commit title adding "j721e-evm"
=2D--
 sound/soc/ti/j721e-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index b4b158dc736e..d9d1e021f5b2 100644
=2D-- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -649,7 +649,7 @@ static int j721e_soc_probe_cpb(struct j721e_priv *priv=
, int *link_idx,
 	 * Link 2: McASP10 <- pcm3168a_1 ADC
 	 */
 	comp_count =3D 6;
-	compnent =3D devm_kzalloc(priv->dev, comp_count * sizeof(*compnent),
+	compnent =3D devm_kcalloc(priv->dev, comp_count, sizeof(*compnent),
 				GFP_KERNEL);
 	if (!compnent) {
 		ret =3D -ENOMEM;
@@ -763,7 +763,7 @@ static int j721e_soc_probe_ivi(struct j721e_priv *priv=
, int *link_idx,
 	 *		   \ pcm3168a_b ADC
 	 */
 	comp_count =3D 8;
-	compnent =3D devm_kzalloc(priv->dev, comp_count * sizeof(*compnent),
+	compnent =3D devm_kcalloc(priv->dev, comp_count, sizeof(*compnent),
 				GFP_KERNEL);
 	if (!compnent) {
 		ret =3D -ENOMEM;
=2D-
2.25.1


