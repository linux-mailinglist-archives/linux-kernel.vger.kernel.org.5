Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95977F844
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351657AbjHQOEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351656AbjHQODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:03:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0EC2D64
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so123509791fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692281008; x=1692885808;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDdSkDnAa4EA45wBy/GLSEV+l5NgSMIiiSHWvRZ2KOA=;
        b=No0KlvABaYxw/rZPqIHVWHsDziq6x7bSxyP7ou/8aZa900Caq8T1gj8P21xYN37GBH
         pIPtj52oMnu6T0jp4Y26t7RZneMdSofgiuyuIvAwmC9YQ8F/Bs74inq2yUFtzGvdBqwn
         XP2b7g8/ABAfVAgudf/Ls9JV0oEPeIHXlloU/r9QWlatTA958VOQzYkq65N2hM3wGrw4
         TmYlmgT77Ez/jjZFBDNXpGB/UdPR8cB9wlCFVofRSl0fnRhN5wpkf16PzMoKmHJEMoHr
         O7DOG1nP9nf6nB8AqU9kS0eXYpqgDl31Z5xQdnZdXtyctlNUjA6TPOi4ukHr4/I/ANO3
         yjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281008; x=1692885808;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDdSkDnAa4EA45wBy/GLSEV+l5NgSMIiiSHWvRZ2KOA=;
        b=Dh7e+71ZajHiVE5AOAHFKpq03X9sXRrwkiBrhU1EmqvMhgajW99IPceWuM42QGxHdT
         +lmmg/OnYsjcy++kB6uKCU6nuiP/BRc9XAoGuKamPjcuyIQAbNxEqCM2iHsYIi+ND2XR
         WFPtKJ+d9Qk2Ucl+YR8Fcw9la+SNReNVRz9B058vqcRITToo6u7j1mfb2/Z6BJgFGB9u
         n7vn8wVSalNPdxHDK9uveHph+jk46c+E2PiKkplsY1Iw+hu10ZWgp9ZKtmL6V3bGNd4D
         hD/FNQyK9bX1n8wIgSvLNunKQ0FfPYQ449N1jJqS1Xy+UBLngI3ZfD3UbDoZ3WVOYnHm
         IUTQ==
X-Gm-Message-State: AOJu0YwoCQL5WydNQyjXWjtX+z3VWPunBrIHFJiZ/ZBuSNKUBxVvy5Or
        TvNBb8hL2sd23YGhuEe3xIhGERDy/ejErVYhJ24=
X-Google-Smtp-Source: AGHT+IG7UCqtLK72meyZRcjb0NwX5VMnpVVHQ/PTZFMBfc6PLe2Wyn/oxfUWSQoy5ABuPKOFhNLqRg==
X-Received: by 2002:a2e:874a:0:b0:2b6:c61c:745b with SMTP id q10-20020a2e874a000000b002b6c61c745bmr4379877ljj.3.1692281008117;
        Thu, 17 Aug 2023 07:03:28 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id g3-20020a2eb0c3000000b002b9c3e18095sm4064645ljl.14.2023.08.17.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:03:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/5] ASoC: Convert remaining Realtek codecs to GPIO
 descriptors
Date:   Thu, 17 Aug 2023 16:03:16 +0200
Message-Id: <20230817-descriptors-asoc-rt-v2-0-02fa2ca3e5b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKQo3mQC/32NSw6CQBBEr0J6bZv5oCOuvIdhQYYGOjEM6SZEQ
 +bujhzA5atUvdpBSZgU7tUOQhsrp7mAO1UQp24eCbkvDM44b242YE8ahZc1iWKnKaKs2EQTXOP
 r3ocrlOUiNPD7sD7bwhNr6X+Ok83+0v++zaLB2tfDZbAhRKLHi+dO0jnJCG3O+QsQUAiFtwAAA
 A==
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
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

After dropping unused headers a few Realtek devices
actually using the GPIO descriptors remain.

Converting them to use optional GPIO descriptors is
pretty straight-forward.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Rebased on asoc-6.6
- Link to v1: https://lore.kernel.org/r/20230817-descriptors-asoc-rt-v1-0-434f5f177cee@linaro.org

---
Linus Walleij (5):
      ASoC: rt5640: Convert to just use GPIO descriptors
      ASoC: rt5665: Convert to use GPIO descriptors
      ASoC: rt5668: Convert to use GPIO descriptors
      ASoC: rt5682: Convert to use GPIO descriptors
      ASoC: rt5682s: Convert to use GPIO descriptors

 include/sound/rt5665.h        |  2 --
 include/sound/rt5668.h        |  3 ---
 include/sound/rt5682.h        |  3 ---
 include/sound/rt5682s.h       |  3 ---
 sound/soc/codecs/rt5640.c     | 55 ++++++++++++-------------------------------
 sound/soc/codecs/rt5640.h     |  2 +-
 sound/soc/codecs/rt5665.c     | 17 +++++++------
 sound/soc/codecs/rt5668.c     | 17 +++++++------
 sound/soc/codecs/rt5682-i2c.c | 11 ++++-----
 sound/soc/codecs/rt5682-sdw.c |  5 ++++
 sound/soc/codecs/rt5682.c     | 20 ++++++++++++----
 sound/soc/codecs/rt5682.h     |  3 +++
 sound/soc/codecs/rt5682s.c    | 16 ++++++-------
 sound/soc/codecs/rt5682s.h    |  2 ++
 14 files changed, 68 insertions(+), 91 deletions(-)
---
base-commit: 17b9f4387ebabb19b871bbe2d06562e48e4e7130
change-id: 20230817-descriptors-asoc-rt-9c072934d376

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

