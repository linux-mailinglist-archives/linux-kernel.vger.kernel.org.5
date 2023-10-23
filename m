Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA747D3B52
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjJWPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjJWPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:49:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108B0101;
        Mon, 23 Oct 2023 08:49:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso25385795e9.3;
        Mon, 23 Oct 2023 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698076158; x=1698680958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99vvqY3a62R+FSNgedTvGTn1Ho9xYE+BPOA4cYmL7ss=;
        b=FovKsoKoQBOTOMoCbnso84aoD1fKPtCM7hvJhFBKTXmuV+7LoFB8SlQsWONlMgqTJW
         Supzfz8jT4CNxjxpuG6SSOrW3otFA9VDGrRE5C7pof2D0iDli/pyUypITK8AZlKjpdEo
         cNEOHaVKcPW0gLwN5dAi25lg3tCwXx7egACdMqwOToGsIesUjgzODYXipbgSUeFWWCR9
         rM8f/8yX0Urz+4HJy1jlKxmEEfeF/xQzZm0j0nfIEiDE+eDh09BFRwkl71PDenqlKeXU
         mXOcO8NStbNlIEOaL677BJYKUAowpAnQ9N2q4ZgpPm1q0J6xoyDbwJOyOQBsSWx3GHBA
         LIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698076158; x=1698680958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99vvqY3a62R+FSNgedTvGTn1Ho9xYE+BPOA4cYmL7ss=;
        b=jRko4kBSRo6b6TuZ/7jQ50kxO9lrbT5+kZWYrD28zhNzsqYFW6m2BaKz5IW2r4wM9J
         9rVXh39zuDYBt6HoWJU40UYOkBLdiKCHBTmxCfKJOjYaV4/TelZKhkBPdPJ0FXqsOl8C
         d6Vm/PeWteM/x2ohVLKPfO8bHforO7g6H11ja3D5fvqE+gxR+xmD+P9fgeNNuDu9Ew6H
         Imka4CVlc6vsji/DjmV2vAMmgtsW/sWMX6VBGFp/hZ0wATfjjoc6E9AOzDAeIH4pLs+/
         Mitd430Egu8J/431Pi6xJkwwZahbp9M4oFVx5XZ/ZmgGvkwuk02M+vieyMuWqTeAzyUs
         d6Uw==
X-Gm-Message-State: AOJu0YwJAM0cQTkDzRmqVPuNCTLntUykXD1/PBdmToXnC6L8XE5kmDqJ
        0twPLXlQwSWwjkDEtHrNGeo=
X-Google-Smtp-Source: AGHT+IG99IjlfivFo6WK5QnjYKrDjIihUfYEP6AcPPqn8XoZsXSFBeG9i6v7AO+y6rhDotBMZnRCzA==
X-Received: by 2002:a05:600c:4f12:b0:401:bdd7:49ae with SMTP id l18-20020a05600c4f1200b00401bdd749aemr8315715wmq.18.1698076158310;
        Mon, 23 Oct 2023 08:49:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b24-20020a05600c06d800b004064e3b94afsm14420510wmn.4.2023.10.23.08.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:49:17 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: codecs: rt298: remove redundant assignment to d_len_code
Date:   Mon, 23 Oct 2023 16:49:17 +0100
Message-Id: <20231023154917.671595-1-colin.i.king@gmail.com>
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

Variable d_len_code is being initialized to zero and then re-assigned a
different value in all the valid cases in the following switch statement.
The only place it is not being assigned a value is on the return for
a default case and in this case it does not need to be assigned. The
initialization is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/rt298.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 8fbd25ad9b47..ad3783ade1b5 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -789,7 +789,6 @@ static int rt298_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	d_len_code = 0;
 	switch (params_width(params)) {
 	/* bit 6:4 Bits per Sample */
 	case 16:
-- 
2.39.2

