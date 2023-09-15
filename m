Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9F7A1A89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjIOJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjIOJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:27:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133EF35B0;
        Fri, 15 Sep 2023 02:26:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso1348053f8f.3;
        Fri, 15 Sep 2023 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694770001; x=1695374801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6AkTjApExULwisbP0f8MYFXveFddh4jpBpFZba8uP0=;
        b=KDLSJRrPMi6Dwin5RTeic/NH8yD2GiK7lj0omhggupAyViLgjLBcVhWvG+kup9f85b
         X+l4e1io38rHPzPbiFS+r48hgukSdQ2p2xbsqWhDL/dF3x+gJ3hn+e/e1Hnmng2kjZKr
         gij/5oKcMCzYKlY2mDb7QfGAalW33vCPDNUhPpSAndY7QWgiBpKJdL0VCGKeFQ4uVr/1
         2rh7c4ugKXhjImvSt1R3cIlR8zH3OV3rKwTp0FPOTvSfbzfPVL3AcWZz4C/pV1skapIu
         qjHIWkKmNbnL2fqQ9Ays3kHqvjtKvmBlNuVDmqcm0APNAsctHZGQikEooZAZI4nsbNR0
         nvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694770001; x=1695374801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6AkTjApExULwisbP0f8MYFXveFddh4jpBpFZba8uP0=;
        b=Ao7p3o3Wbt9Jvuo5l+2z0MAz6oSz13w8PrLEyQjP2+hsLvyXIRR7tnMc9sl9wx07Z2
         dFPMTGFaXhmg/eXPl9+6Z2fguOaLV7kNjTc248Ke4EKMn99yjztSegyujUjJEgnU2PQU
         CApwqU2BFaqrMlxsDGn1stk7GtG74I0ZzvCPzBISccIRjBuL0FbHtfrseuui9QtQ5eJ8
         CXbMFeXQk+DzvSMH3Ok/D8B3ziVxV8YGBYjbSNyg06zyGpGLnWhWl+TUgFyg0qPQgbr0
         tc0Qj95dQGt+dk2GsqluSpgGL6NTNfojpo/m5qSO2s2xI3MI2eV+sc9QR5NrkLiRx+7c
         eWkg==
X-Gm-Message-State: AOJu0YwgQIu0vvc6CWtx0jfELCFG/e7smq9KWhAsyC66qWZV/fqs5jeF
        gb73aLhCCzvVnEm+UIdrAz8=
X-Google-Smtp-Source: AGHT+IGO7dNEsmwqe62k1eEbBiRKgNNo1d4fDvsoEEl8b2q/cCALAmnkXq8JIS+ehHW+Ftj+DVntWg==
X-Received: by 2002:adf:ecc7:0:b0:31f:a717:f1cf with SMTP id s7-20020adfecc7000000b0031fa717f1cfmr893102wro.56.1694770000481;
        Fri, 15 Sep 2023 02:26:40 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p20-20020a7bcc94000000b003feea62440bsm4109371wma.43.2023.09.15.02.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:26:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: cs42l43: make const array controls static
Date:   Fri, 15 Sep 2023 10:26:39 +0100
Message-Id: <20230915092639.31074-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the const array controls on the stack, instead make it
static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 1a95c370fc4c..4e3bc15f1b25 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -162,7 +162,7 @@ CS42L43_IRQ_COMPLETE(load_detect)
 static irqreturn_t cs42l43_mic_shutter(int irq, void *data)
 {
 	struct cs42l43_codec *priv = data;
-	const char * const controls[] = {
+	static const char * const controls[] = {
 		"Decimator 1 Switch",
 		"Decimator 2 Switch",
 		"Decimator 3 Switch",
-- 
2.39.2

