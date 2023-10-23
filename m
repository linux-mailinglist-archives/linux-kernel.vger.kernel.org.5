Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC817D3A86
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjJWPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJWPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:17:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B21DD;
        Mon, 23 Oct 2023 08:17:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32caaa1c493so2478832f8f.3;
        Mon, 23 Oct 2023 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698074226; x=1698679026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAyRkZU+G6EHBgXjNlQRdapo8Bo6bVrz7BpJ95EsKKo=;
        b=Q6dWGkTchYhEQO8eiI6BkdXC/b/J1vj+wusDdEoTU7V7vzZjByc8NWdV2sbqgdC+32
         zqLEeQ8aTvTIhB+90Y9A04xw0KokWspnE0rGBlLwH8Ojw4qCK79HOoL9xqeVxDp7ErL9
         nWiUbsxRaeMDkEAHWNcmQ5nUW30bhVhftAJIei66GCX1iJoFyrnDQb74VepsfRzhEt8i
         q/g+tdb5YAL8rYS0Ln3gTnE7rBJxCRUa3e0B6Ot7OVPMicv/Uvj1frjk0dxZYBD8zIvx
         cChf0icpsWJmXEFSVT0STLLTPIYzwRgCm368vKycSFGg1NavanNkzqu6cwZRCcg1MKz3
         nkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698074226; x=1698679026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAyRkZU+G6EHBgXjNlQRdapo8Bo6bVrz7BpJ95EsKKo=;
        b=xS+aCro8iZKZNN1gnyfTyQ7hR32myicRWn8tHQc5Dd8hQF0cHfqImxtM6tFQ7Ko45L
         tcoXW/+nfiAS18F5uXhO2RdaFPCCppijWdadTpqa2C8zDM96j6x5AZgBBWjxZkPY/TVQ
         fSbsDcPSvJjYIlOY3Lft98nNxOhJDhtDzpy0sIjNKtiaqpsEsKAKO7SYMxn3LUcTnEpo
         P0OBZCAJ/gfwR6bnwNgbhJAB0bM1bt8ThxA5EfwdJXl62TWO6evOWB8DEB7SWnjdocrv
         CRsxxXzBp2vxtvzCN+9CgfgsMLlJWoBXhhc3gPVWJnoPdl5Ny03N+krhocznRTYfWsea
         /ZDw==
X-Gm-Message-State: AOJu0Yww4YD3qS1L5NIM/qoPO2GrT3a1Du1q4XJls7FxOftdPkImdVYl
        qQIyx75qsWkdmc2u5BRoy2o=
X-Google-Smtp-Source: AGHT+IG/PhtGCsg7wXm8Rc5Irl5IiMZvAOjGLp6Od9Km/HS5gzwHrgf4OZgoP6sqwU+2RfvtoTXxsQ==
X-Received: by 2002:adf:9dcb:0:b0:32d:a29a:b6ef with SMTP id q11-20020adf9dcb000000b0032da29ab6efmr6726291wre.23.1698074225584;
        Mon, 23 Oct 2023 08:17:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d5510000000b0032d2489a399sm7913701wrv.49.2023.10.23.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:17:05 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: mediatek: mt8186: remove redundant assignments to variable tdm_con
Date:   Mon, 23 Oct 2023 16:17:04 +0100
Message-Id: <20231023151704.670240-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two occurrences where variable tdm_con is being initialized
to zero and the next statement re-assigns tdm_con to a new value. The
initializations are redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
index 4148dceb3a4c..ef2801f84d27 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
@@ -416,12 +416,10 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(afe->regmap, ETDM_IN1_CON1, ETDM_IN_CON1_CTRL_MASK, tdm_con);
 
 	/* ETDM_IN1_CON3 */
-	tdm_con = 0;
 	tdm_con = ETDM_IN_CON3_FS(tran_rate);
 	regmap_update_bits(afe->regmap, ETDM_IN1_CON3, ETDM_IN_CON3_CTRL_MASK, tdm_con);
 
 	/* ETDM_IN1_CON4 */
-	tdm_con = 0;
 	tdm_con = ETDM_IN_CON4_FS(tran_relatch_rate);
 	if (slave_mode) {
 		if (lrck_inv)
-- 
2.39.2

