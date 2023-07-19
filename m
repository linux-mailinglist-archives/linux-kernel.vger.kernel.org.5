Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72073759B54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGSQs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjGSQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:48:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22F01FD9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:48:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so9791853a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689785296; x=1692377296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yixFqSzT/c4E0mvGw1Uo9KfL2QY9NEvmj8leiEc3puY=;
        b=Y0sBPXTz9dyJZPRwFkzpcMAF8C1+t5QmrsdtFb5qSp1+uPUnaGSzooAFfj2OI2jVWj
         jXB5pXt+6XqggnKKndNnkx0iufj5VXa70c5mH8xOC0FXX7T++VZIlcySPT14vXHduATU
         HsQa6hNZPhbnOmZQOUp6D8ajoMITXzwzGD0dRYoCMLmaqb0gN4AQY727/hfxPSuFik16
         tK4Bq8uQdo820l+L3JHF5LFE/DaQZvenIfCYOUtOuyHHm+an7aqRO/nV05GUQzCYciPc
         oqZJPtv4nR8xNP9OXIgVXRJXvQwy4Q9D88KHaHF7OX1QtbdhcOziKcFxEtGUOB9sFZhG
         jXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785296; x=1692377296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yixFqSzT/c4E0mvGw1Uo9KfL2QY9NEvmj8leiEc3puY=;
        b=PR+p0jnQtJ7yYFxbySgZniG1oTz2b03x5UBGjgK7amDphrhyb6ANyc5kly4ZrLDT1E
         mRZQL47iFDHPEmydIqy5DK8zQRmSaFmxLi3zlIaQgUtb2APUwl2KZK8m6/mpUL1gnXET
         XGb3AOcuRgSYYITJv9jmQozIWAG72oDcjFoybfiM9CFJAS5wSw7tZxiz7WWt/8MfBwbv
         Z3ZDtBeSzPax4G+Yr7s8BlVMCsx1UDQZe6RfiJQWPA1KEqHJ6EkXVfIhALHYn6ZQiDuO
         czFUWMAOMTYPZZ7IC6bqINPNxUI3cyovpEl+jgXdQs708K0Hquj/x2OV0HH65LREp1ND
         Reng==
X-Gm-Message-State: ABy/qLbD/KWK614/7DaFaXlGgf4WpXplJBAoW0Tlx9RAvTVCqjul++Gt
        J37yolIryUDxRbgsHDp4Hsc=
X-Google-Smtp-Source: APBJJlEHbfz/pFyUepLd7VKG/NuQoD7KORKklONmdm98pXW6g5MHna6cHYzQND91adVXuiGLISQbhg==
X-Received: by 2002:a17:907:6d25:b0:982:9daf:9fcf with SMTP id sa37-20020a1709076d2500b009829daf9fcfmr3870702ejc.66.1689785295815;
        Wed, 19 Jul 2023 09:48:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe9c:4c81])
        by smtp.gmail.com with ESMTPSA id gl7-20020a170906e0c700b00989027eb30asm2566959ejb.158.2023.07.19.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:48:15 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Stephen Warren <swarren@nvidia.com>
Cc:     Matus Gajdos <matuszpd@gmail.com>, Mark Brown <broonie@linaro.org>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_spdif: Silence output on stop
Date:   Wed, 19 Jul 2023 18:47:29 +0200
Message-Id: <20230719164729.19969-1-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear TX registers on stop to prevent the SPDIF interface from sending
last written word over and over again.

Fixes: a2388a498ad2 ("ASoC: fsl: Add S/PDIF CPU DAI driver")
Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
---
 sound/soc/fsl/fsl_spdif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 95e639711eba..95bb8b10494a 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -755,6 +755,8 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(regmap, REG_SPDIF_SCR, dmaen, 0);
 		regmap_update_bits(regmap, REG_SPDIF_SIE, intr, 0);
+		regmap_write(regmap, REG_SPDIF_STL, 0x0);
+		regmap_write(regmap, REG_SPDIF_STR, 0x0);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.1

