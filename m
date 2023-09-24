Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B57AC6FB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjIXHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIXHgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 03:36:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A443197
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 00:36:05 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id kJesqk7nIGc65kJesqQUu3; Sun, 24 Sep 2023 09:36:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695540963;
        bh=018xaLEDvxggoMddYpgeo/uvtqjMWAwwaPEHKHKhtvA=;
        h=From:To:Cc:Subject:Date;
        b=pQy7OeR8/JRokKoalfqARW7ycJBOE9XFchZQxVNYhEXztu4UfdU1+F0kj2pmV28aO
         avdVOG0lO5QJB3GNl3bBX6xGCB2HsPjwCPGC7ZqDlHUFdlzbmmvmofoZQq2OofMt9g
         zl975c9qmr6bq2Ji42XXpKuAK1ig5oC5yVccIcVpOOYiEBRfXSZAmwF1uA43icMWrh
         mmlPixtAbDWeRPqP7MHo3XDf6exTjL5hhPh0Jj86aRb/YFxqXekWxjXu7y0/iYnUU+
         /R1zrZGk5lKkqODxeXGwJv1SG2Ja2xHQcrjd2mCUOXlK3zLH7MsnQCVsRnV9LjF8N4
         mYyvzM4ZCl5dg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Sep 2023 09:36:03 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: audio-iio-aux: Use flex array to simplify code
Date:   Sun, 24 Sep 2023 09:36:01 +0200
Message-Id: <1c0090aaf49504eaeaff5e7dd119fd37173290b5.1695540940.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"io-channel-names" is expected to have few values, so there is no real
point to allocate audio_iio_aux_chan structure with a dedicate memory
allocation.

Using a flexible array for struct audio_iio_aux->chans avoids the
overhead of an additional, managed, memory allocation.

This also saves an indirection when the array is accessed.

Finally, __counted_by() can be used for run-time bounds checking if
configured and supported by the compiler.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/audio-iio-aux.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/audio-iio-aux.c b/sound/soc/codecs/audio-iio-aux.c
index a8bf14239bd7..1e8e1effc2af 100644
--- a/sound/soc/codecs/audio-iio-aux.c
+++ b/sound/soc/codecs/audio-iio-aux.c
@@ -26,8 +26,8 @@ struct audio_iio_aux_chan {
 
 struct audio_iio_aux {
 	struct device *dev;
-	struct audio_iio_aux_chan *chans;
 	unsigned int num_chans;
+	struct audio_iio_aux_chan chans[]  __counted_by(num_chans);
 };
 
 static int audio_iio_aux_info_volsw(struct snd_kcontrol *kcontrol,
@@ -250,23 +250,18 @@ static int audio_iio_aux_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	iio_aux = devm_kzalloc(dev, sizeof(*iio_aux), GFP_KERNEL);
+	count = device_property_string_array_count(dev, "io-channel-names");
+	if (count < 0)
+		return dev_err_probe(dev, count, "failed to count io-channel-names\n");
+
+	iio_aux = devm_kzalloc(dev, struct_size(iio_aux, chans, count), GFP_KERNEL);
 	if (!iio_aux)
 		return -ENOMEM;
 
 	iio_aux->dev = dev;
 
-	count = device_property_string_array_count(dev, "io-channel-names");
-	if (count < 0)
-		return dev_err_probe(dev, count, "failed to count io-channel-names\n");
-
 	iio_aux->num_chans = count;
 
-	iio_aux->chans = devm_kmalloc_array(dev, iio_aux->num_chans,
-					    sizeof(*iio_aux->chans), GFP_KERNEL);
-	if (!iio_aux->chans)
-		return -ENOMEM;
-
 	names = kcalloc(iio_aux->num_chans, sizeof(*names), GFP_KERNEL);
 	if (!names)
 		return -ENOMEM;
-- 
2.34.1

