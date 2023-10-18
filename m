Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8E47CD8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjJRKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjJRKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:01:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65945FD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:01:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c3aec5f326so681755366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697623259; x=1698228059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kvddIZrQnxFTAaEhVpmcGqWDKOvzXW76dSFcJDMbgGc=;
        b=CSiOKeMRRNOgmyD+aN6EhYz5Fg9L5WZo6E7qAnbwZJGiIRo+GMIht+AdCcfS8NlN4t
         w2XHtvvLjyX1TioTOt7nnppWpvXdp64y4KODXKAQK3Umbqil85AzdXS3DAn0sAhIlzGq
         0kOCTPimJYuCshARYjw6VB4jCS7kjIyMOzBaRc+XmxfY4MvpNRW2dX9e1C7Lm9D03Ak3
         C+Vfs46I0F1DQrG223mu/OjlNFcHNj6zG2J4sW0146ta1MTRrwPlACQZGKi1Y0HCcgUN
         gb9PINNDHb5blk3qnEKHYsDUcNl0hjwhGgRYpG6eBdvHLwMGtrYyZbT7kNzTUQOvwDCP
         f3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623259; x=1698228059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvddIZrQnxFTAaEhVpmcGqWDKOvzXW76dSFcJDMbgGc=;
        b=TDfFlYqdAnsK2ZomhO39pA8jHcNkjakRlFdk5J6s6mJ+Larulby4WQTepvnaomNbf7
         y8RwTpta7OOE6mdTVV91XzkHfKqB1JAc2RrkhTmdVWJ7FHB0cCgeb2Yz5xoBAs7IppU4
         XK8TlIXfTfi7rnKHJiMc0ANLRPBA//Z/lPeUayuhnG7ncI9PKxYjAaRdt4i5kJGsTEga
         0elcE7lHCRKQJJ+elyXFyJoaDwfL7p2wve0tYhwiZYdEX7D49SpH9Ri5mF5j0H99VU4e
         W7LQHgToBXYMzEJFeaNXzR6mYOr8IjyZyF3jCD5zRJHXZhRVLqHAinycLMJ1Pte/x2s2
         pH5Q==
X-Gm-Message-State: AOJu0YyzyQG3ki1Wh3el5EhDxgcPydx77HGbPdjVNVSD2IZxcuK8zmEn
        uQJvLm0+VBsPaRK2950wPX7iDuWv6DoXU2rgesg=
X-Google-Smtp-Source: AGHT+IH2vGShfrLckC4r3uYkums6iB07VTLBjoxIrR8Ioh3Mk+Ki1DtOQfKHterV7cnZBeX26EhQaQ==
X-Received: by 2002:a17:907:948d:b0:9be:85c9:43f1 with SMTP id dm13-20020a170907948d00b009be85c943f1mr4180282ejc.7.1697623258684;
        Wed, 18 Oct 2023 03:00:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id bt10-20020a170906b14a00b0098884f86e41sm1310004ejb.123.2023.10.18.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:00:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: wsa884x: allow sharing reset GPIO
Date:   Wed, 18 Oct 2023 12:00:55 +0200
Message-Id: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards with multiple WSA8840/WSA8845 speakers, the reset
(shutdown) GPIO is shared between two speakers.  Request it as
GPIOD_FLAGS_BIT_NONEXCLUSIVE to allow such configurations.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa884x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index 993d76b18b53..bee6e763c700 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -1844,7 +1844,7 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 		return ret;
 
 	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_OUT_HIGH);
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
 	if (IS_ERR(wsa884x->sd_n))
 		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_n),
 				     "Shutdown Control GPIO not found\n");
-- 
2.34.1

