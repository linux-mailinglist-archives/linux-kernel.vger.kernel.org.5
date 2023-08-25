Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFB788C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbjHYPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244073AbjHYPhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:37:13 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B90268E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:37:11 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 202671868942;
        Fri, 25 Aug 2023 18:37:07 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id v73nNLLpUn7Y; Fri, 25 Aug 2023 18:37:06 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 87BBD1867579;
        Fri, 25 Aug 2023 18:37:06 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I_6nBa4-AHub; Fri, 25 Aug 2023 18:37:06 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.189])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 72BA51868950;
        Fri, 25 Aug 2023 18:37:04 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eason Yen <eason.yen@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] asoc: mediatek: common: Remove check of return value of mtk_memif_set_addr() and mtk_memif_set_format()
Date:   Fri, 25 Aug 2023 18:36:50 +0300
Message-Id: <20230825153650.20923-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_memif_set_addr() and mtk_memif_set_format() functions always retu=
rns 0, so it is
necessary to remove the check of its return value (which was
probably specified by analogy with the check of return values
for other functions) to make the code more readable

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: df799b9502ed ("ASoC: mediatek: common: refine hw_params and hw_pre=
pare")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/media=
tek/common/mtk-afe-fe-dai.c
index 882cdf86c8bf..3c8a11c5958d 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -143,15 +143,10 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *=
substream,
 		  substream->runtime->dma_bytes);
=20
 	/* set addr */
-	ret =3D mtk_memif_set_addr(afe, id,
+	mtk_memif_set_addr(afe, id,
 				 substream->runtime->dma_area,
 				 substream->runtime->dma_addr,
 				 substream->runtime->dma_bytes);
-	if (ret) {
-		dev_err(afe->dev, "%s(), error, id %d, set addr, ret %d\n",
-			__func__, id, ret);
-		return ret;
-	}
=20
 	/* set channel */
 	ret =3D mtk_memif_set_channel(afe, id, channels);
@@ -170,12 +165,7 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *s=
ubstream,
 	}
=20
 	/* set format */
-	ret =3D mtk_memif_set_format(afe, id, format);
-	if (ret) {
-		dev_err(afe->dev, "%s(), error, id %d, set format %d, ret %d\n",
-			__func__, id, format, ret);
-		return ret;
-	}
+	mtk_memif_set_format(afe, id, format);
=20
 	return 0;
 }
--=20
2.30.2

