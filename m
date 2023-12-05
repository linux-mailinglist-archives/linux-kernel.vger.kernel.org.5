Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB380500F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjLEKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjLEKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:17:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49A4BA;
        Tue,  5 Dec 2023 02:17:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b397793aaso33637935e9.0;
        Tue, 05 Dec 2023 02:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701771462; x=1702376262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJBKssIQGKxkPqlelIJU0W9JViZCvTkkSVAhWadYU4Q=;
        b=Uh+6E++G1cwdLDwGF4YbQ9Ta36Q2rVlA+Q5ZGdC7kqYXebfg5O68PHZu19qeYp/sOY
         d1fv5T/GjjIWVlFaUEhw/ofwF5nf76SX1ykBZb+srfdQwuWsYcVeGVM3VAhzvMrd2OT/
         P9Lbu/g6ArxClW8uUqoGtdKDWlxgUpREUxgve2m2UkUwbf391uvE3tlayhquI9tG5Syb
         snccDwow9xOFVNSacp8NPs8LZSDtHMwY/0LberHd/kH7jg6mdD+SV6uPln8xExaLvg0T
         +8xCyBThSoUXxZI11o/f0ojdsxNiWr8e7ep0CQNKvgMguyYfet840pKJQLuPQOoykA7C
         hX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701771462; x=1702376262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJBKssIQGKxkPqlelIJU0W9JViZCvTkkSVAhWadYU4Q=;
        b=unY1hMzZhfnYeEfvc/G7lDFduBFlBWqG0V4904miXPt7f0sp4DV82jwbebO6/uFudB
         sVtjb1yf/rDi6/ix17YCGZdtiruUEgUUa9gyYQg02vjGBpDD+XZWWvbntuAC9r65Byhm
         9mvEPOUO4dB7vVJllTXpQcCwm6XqcK3ETfvUsawCHesXk3Yt+ef1us1lxkDMRpzvDaO4
         2Izp9T6DqJ1aFtY+VmpEVAGsatckRICauhzms1rDsShfSuFELy4j2cLZKP2aM3UoBwDU
         /onpTTcOQujF20QT6FJksmU9Lx33jZkpJVpx+y5ZQIf83mhgq+0t6aXR0G0QfqcU4dVI
         LwqQ==
X-Gm-Message-State: AOJu0YxZJKGnJK2oE2RRqH5LKjoY30IkqkqppmeXErw6bBk9+TRAXz07
        HmDbGU9vfroQs87u9+GRhTQxiTNMX+Ah5A==
X-Google-Smtp-Source: AGHT+IGcYkj9vHpGOjdhpw/Nc/NNNK79W6EablJZAbbv5BwQsKA+3A9C2gHnonbbWzWmSFvF7mnhYQ==
X-Received: by 2002:a05:600c:a45:b0:40b:5e26:237b with SMTP id c5-20020a05600c0a4500b0040b5e26237bmr375938wmq.44.1701771462047;
        Tue, 05 Dec 2023 02:17:42 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d680c000000b003333e09990dsm8139840wru.8.2023.12.05.02.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:17:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: cs4271: Fix spelling mistake "retrieveing" -> "retrieving"
Date:   Tue,  5 Dec 2023 10:17:40 +0000
Message-Id: <20231205101740.2820813-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_err_probe error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/cs4271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 74a84832d958..e864188ae5eb 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -643,7 +643,7 @@ static int cs4271_common_probe(struct device *dev,
 	cs4271->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(cs4271->reset))
 		return dev_err_probe(dev, PTR_ERR(cs4271->reset),
-				     "error retrieveing RESET GPIO\n");
+				     "error retrieving RESET GPIO\n");
 	gpiod_set_consumer_name(cs4271->reset, "CS4271 Reset");
 
 	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
-- 
2.39.2

