Return-Path: <linux-kernel+bounces-18654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB082609A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D521C20E4A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4882882F;
	Sat,  6 Jan 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="o5Q2aPRI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5453847E;
	Sat,  6 Jan 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704558513; x=1705163313; i=erick.archer@gmx.com;
	bh=e0hTcOOsR2RlK2Db6LVueiP/okSfxGYoljbOBYdnEEc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=o5Q2aPRIR0doNwIOWKP7y3nN7/7K0nX6kqVVjAgqHBDfTyb9LDtmoU6H0tU6r2R/
	 6NaA3TPwqnnrpUNWiQrvbXPhwbOKDBXTwMlV3RuA857vk4+Qxc9VCVVmwZ0svJw9y
	 7ckioRsuoA0+nHXHSge1o5rcmVHybJQvT6/kCmim0wav+GtTPij++zaBHepTgIfci
	 ksArFuktycokVf9aAYqmCTpt/nUkzG3UfYvAuFYEc3fUhg6oJgs3zn+tQAXDy73TK
	 NY0U0sobHB2FbGYCqJVewxjMmHt8akxumqgSzd8eXEb0yv57Tn4rFXXoLMDWiAikY
	 Y2G3B/2pnVDZcql+cA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N2V4J-1rCXvz3Vlf-013sJX; Sat, 06 Jan 2024 17:28:33 +0100
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
Subject: [PATCH] ASoC: ti: Use devm_kcalloc() instead of devm_kzalloc()
Date: Sat,  6 Jan 2024 17:27:52 +0100
Message-Id: <20240106162752.18599-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J9Z2yJ/wHte/ThnemlRGX6DPdngNYkEu5Qmuu/TGsQ8JKiVmBNd
 6q6JnJK6keaY+rBVn7TTtmK84OcBNuF5vnT5G4jvLwLJSfAO7jWJpnGhEvk08CTPfHOQPmX
 Lto0JUk1oMdf/wEimKI8LglRKgqilAChkvBcQd6ACUhECvTMZ7IKbnyxbh3WrcAiyuLJdP4
 jCvhm6oCcV8RBB1Ji+4qg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tg/f7GjQ5YU=;TdqW4FC/+MrquMk23XdxfWu2lHR
 g2MLe95BV+DYAwonE0gIbvxdJwOShhn7OswR9fwILcCN615FOmEGuIWjFVhyln4ew5g/sFYHX
 wHzpfjy9cLiiDivcPgw9Swmn/vu1JTazYOUQX36WDVlodE6d3wtZxn0Y1aOJ7gL9gg8Kdj8f9
 mW+YIEq2oONNCgApI3u1d7XsWae0n5touxq35HqRLZ9pt7VFBD+qqD5HDjHHDB3x6vBX5Tq99
 QTgf0uBwibbfNfq1MP8FaeKlesNR7vLvTwt/TrTN6ysYRj9hZPHfVWNY4Ae+2fH1jTv8awFKQ
 QmfxdjrQorKxTvjD25nAIAYIrQBBslz2sFxHVJov2rY4xYx5rghjbvCPnQMopZ/jfxS7xCYQ2
 mpLgRv5sK/bx5ddfHwAV2nWarOTuumbkFnOyh74sOTFem9le672UaeTcRHBXVDz+3EXEoDBQq
 eKo03gewcOALgtOsJn00iD7ZyrdqXFc0kVn6R9s9agi5IFxLnLW2Iy/xxZJzb4bDaSg751BOb
 BipGzoC8llWXessJW+2ZBBPZYVHy57O0fqLHHoGMqUlPek2WXLwndXztaqfClTvPFMpdetoqy
 EvvX0Hm01m41He1YupvZuRuVhJEy8LAjkblGWrvKLHnCcl2JH34cNasBNsxF2eqVpiThEMi7v
 +gYhf3SLvWmY2TfWH2vYhcOTUxpg1UhC8LulFXNz+3EyGAOifXTwC9T5DbuoR/j5iOuCpUirC
 yuCPIscCKNvq/QhfcWJmK0F9iMegD1cht3eVOy2NHvrYTir6kVHYP6atbv1sINvHrZ1IcGjDc
 S76zz7+mTU1SO40/bd1S4LBeSMU0NaeIBbnQ41GRAS4RgMNkeGmheo9lLexV3dJz8qy5H9b0j
 tS9JmCtdJTkAAa7zesMUtftS5MYzG76IyxSsQ9YZ+RBquMnXG5QGOM44EYlWS6noq5ODfRTN5
 48bciHh1M6tSaOrBBqqZ2d9xFUs=

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
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


