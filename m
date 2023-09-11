Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7F79B542
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358872AbjIKWN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjIKIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:23:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4DE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-501cef42bc9so6728146e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420630; x=1695025430; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VtgG1x2m9o0IpTfX6UiCcH6ibg9JS/Bhrsg9Q6riVRs=;
        b=SPGZUn+uVGB1LuGPyb3uEdw5y9NyNWvBkja/z5fpi5bTeirEnq3A1XpShiNjsy7t3l
         5MkYDVcLKwROEFDgkFqjOEtDc22bLIC2qq9v11/Oz/aiiPR84cULnjFWZYA6vxgCXYF2
         a4UDtsTBXYGsfvp6OzW98D7YV2JkVI259IX8fl32HvizIWZulXAGrznOEyuDK3XkR3hR
         VFPCqO1pzhIvUYWkru1P+RWFfHq2usj2+CHuqvpgnm+pRVG0u1O6Ap4HnTd6qXYpOmzD
         SJE074zwloc+eoTB+v18njMd0gz9LMrakOfZY9Wb3+s55VQtr0N9q6kDwrdtB+5beGxz
         xquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420630; x=1695025430;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtgG1x2m9o0IpTfX6UiCcH6ibg9JS/Bhrsg9Q6riVRs=;
        b=nYPsBOd7cJZntaEfusokzwtjlWlQaO9pri9Cy79KfdzF48qKAoMlZDGANItslOeR8U
         J9/M8tjW+BNcrj+3KaGB5lCDtvf8lmcsuGv4kiBG4yt2AAX2JZtFCSyJ19qS04FZWh6k
         F58fxf5ZhiyptthtAab8bMytjbQyGq5Gw8GpBogwAqz3CX2ZRkHyTAlUrZ/qkQGPvwNv
         6i3egm5sc07rkj3ASBfXSRJ03FS4v3FxTYcnrZgGkRUP84VfmsToAQCfxlz+pGqz7mDH
         /+MuxlloYjil1R+Vxs+EoZRBp6W5Xyxk8SAs/2zF9F21bcOqfqUFqi4G5wz5UX6zZQ+K
         7zkw==
X-Gm-Message-State: AOJu0Yx5xxp4O2dNDs/uWaxAnnCYUwKH4iXOr5ckoOk9ufPBw7Zq4OSc
        RivAi9Hk3TcFJFE8Bxu03ENGyAlv62/Dzxn7hZI=
X-Google-Smtp-Source: AGHT+IHvxuOb7yl617d/Y4wRW8ul/lbBFb1Q/5NZpMJf/su50wFhg505mK8F5xCB60reJfxe9dnBfw==
X-Received: by 2002:a19:5058:0:b0:4fe:1c40:9266 with SMTP id z24-20020a195058000000b004fe1c409266mr7039614lfj.17.1694420629766;
        Mon, 11 Sep 2023 01:23:49 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b00500968ddca9sm1247712lff.136.2023.09.11.01.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:23:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/7] ASoC: Convert some Maxim codecs to use GPIO
 descriptors
Date:   Mon, 11 Sep 2023 10:23:47 +0200
Message-Id: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPO/mQC/42NywrCMBBFf6Vk7UgyYh+u/A/pYvJqB7QpiZRK6
 b+bFhcuXLg8F865i0guskviUiwiuokThyEDHgpheho6B2wzC5R4krWqwLpkIo/PEBNQCgYeNIO
 uFBmJ2ivvRVbH6DzPe/bWZu45ZeG1v0xqWz9BPP8OTgokWCqrWpeS0DbXOw8UwzHEbjv4w9aoE
 BvU6GX9bbfrur4BDr0A7vcAAAA=
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Maxim devices are pretty straight-forward to convert
over to use GPIO descriptors, so let's do it.

Tested with some x86_64 allmodconfig and aarch64 allmodconfig
to smoke out the worst bugs this time.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Rebased on v6.6-rc1
- Link to v1: https://lore.kernel.org/r/20230825-descriptors-asoc-max-v1-0-b212292b2f08@linaro.org

---
Linus Walleij (7):
      ASoC: max9768: Convert to use GPIO descriptors
      ASoC: max98357a: Drop pointless include
      ASoC: max98373: Convert to use GPIO descriptors
      ASoC: max98388: Correct the includes
      ASoC: max98396: Drop pointless include
      ASoC: max98520: Drop pointless includes
      ASoC: max98927: Drop pointless includes

 include/sound/max9768.h         |  4 ----
 sound/soc/codecs/max9768.c      | 45 +++++++++++++++++++++--------------------
 sound/soc/codecs/max98357a.c    |  1 -
 sound/soc/codecs/max98373-i2c.c | 17 ----------------
 sound/soc/codecs/max98373.c     | 35 +++++++++++++++++---------------
 sound/soc/codecs/max98373.h     |  2 +-
 sound/soc/codecs/max98388.c     |  3 +--
 sound/soc/codecs/max98396.c     |  1 -
 sound/soc/codecs/max98520.c     |  2 --
 sound/soc/codecs/max98927.c     |  2 --
 10 files changed, 44 insertions(+), 68 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230817-descriptors-asoc-max-b71ac02bf1ff

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

