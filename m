Return-Path: <linux-kernel+bounces-18675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367B8260DF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A0F1C2158C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24BC2CD;
	Sat,  6 Jan 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="aoZPsGMF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EBC12A;
	Sat,  6 Jan 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704561417; x=1705166217; i=erick.archer@gmx.com;
	bh=ehawtbA1G6P8hgV9kX0SSq4hQvp6gdhNC80SxSlC0AE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=aoZPsGMF6ZMfBEoL2/qHofT2uOjiPgFUqG5wk1Vy/8CEMW1oVszREPdcrHj0zIP5
	 9za3BitnciTds2PyGVDnLtEN2lNqC4fT3G+hqa2gIB7WQVT9jFMtVZbQhdDrYXrtV
	 2mfzhlhSM6q6f+bZ3/J2CBBEjQi3LUtdwfepQIxIDrllBVH7Ck1Sf5j8WurgzAfQS
	 hsp8NTjzKVTf8dGA/qBgUBVtZeWcJo7G+pGbzcx3qLZ2w/jEKIgRJZvMIS9rLv4ZR
	 /9xSG/VBJX7TP+xriI/DEomFLZ4ri+ujDqxXmXbZXiXJgYaiJ7PdsI9QX+PjbUymN
	 rTPEir7w0/jJSD0GxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N6bfw-1r8ORT1GJi-0182oO; Sat, 06 Jan 2024 18:16:57 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
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
Subject: [PATCH] ASoC: qcom: Use devm_kcalloc() instead of devm_kzalloc()
Date: Sat,  6 Jan 2024 18:16:35 +0100
Message-Id: <20240106171635.19881-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YRX4UVilIzmkB5A8GIVf10FiBsGh6WtPr5VToXbmFOaw0S2ugbb
 z2dkXSIyYbYgrRi1oVJTiH6xqePO/kv4eP7B6QISv2/3THWf8OGgTmtl+sXddgC4m17w4OW
 +pdh2oIH1MK0DRvyNRcxhycFxsLv67BIwUbDDJdxTMoNxpwccvn77hQsJChFG340ZyNiVvZ
 KHlI8VftKZqtJs8frTCKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dhj4uTJ6JLU=;HTpuL9fUftftpUlblsMaGyxbzUB
 9hSH8hjNOg6tGgETMAD32HmYfZqIAGNd5zc5vzHkcOCDo6p3INnNa6PCN31ICKU7Q+lnTwRfY
 ayTByhpaANvXVTrDyPKA0AZWcCFDwJQ+755rbAKvgN83jW1ZwcN9PukO3qJpnOuYVI/aBw4dI
 wLqkKcBvdGQficN5FQlt1N50vHvkaf3cs90FbHX/FBZjmlA2wBb/MtgjOxv3go+w6ptC46gjN
 xu6QdFqm74J0qWdbv1YVRwf5GX/LIZk/R52K7aTj1NGwBHlUyq3f0443IOvu/DZ4dqDVOw4tj
 sWT+ExWRijtse2TgXQ/M3Sm03TWp2vwNrIYjL0fmY227P+TXUPpnrE2w+kgUji7uNu86q8Xh+
 gzNgsVUFBIlhP0nKdGq0gaO+FhCyFEvsxEwYPAP6IQD1R0SEMd2jbwl/fFAwzion45/KAPGik
 Jjmu9cVWNEufoa5EGGmSTw2s7raIkatHKsyR9itZXruxPRAKKtyvom5hJhlKjrv+tDcRMhiq7
 b2PzbXNzkTrD63pdLkYmmP8xd6Ctp0oVs+6JDblL8UrrBorKHCge2UtXjYmluZhBma750wXgi
 3s/AsHaebWbn/jGYgxcBV3VklTiGtRDtPfRoRTmvMKD2rEpJW57gz4GSftNjWsJzj8rqV5o0f
 cKfPtTZ/urXBVZoxBuMUntQW4bv89UUPkq7n4gVJNsT7F5Fb1yBMZuAEAj7uNa8G64tHM5shi
 5HdhlsZ/j2xcmKAOf4rgCFWRfoVU57WDKiXA6qkKfQ1EjTVW1wN16EKFEMgClvi1lzSNQ6Dxf
 IhQemX8pVrmTI08KraB2iW/LX/q74Q0TSSBJEoevE55Xd4Il1bj7vE2HEAxzjlI2t7eFIgPmt
 7lNsIJOvDBckGfP9ErALrixKyFgfrXaZ6ZAfMJVOJ7r5iT0Tk0xUx0Zbo2CZvx5jrETLkfQ/o
 PBjU/g44i8aaV2uxQSIzC9ivgc4=

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 sound/soc/qcom/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 756706d5b493..747041fa7866 100644
=2D-- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -73,7 +73,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	link =3D card->dai_link;

 	for_each_available_child_of_node(dev->of_node, np) {
-		dlc =3D devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
+		dlc =3D devm_kcalloc(dev, 2, sizeof(*dlc), GFP_KERNEL);
 		if (!dlc) {
 			ret =3D -ENOMEM;
 			goto err_put_np;
=2D-
2.25.1


