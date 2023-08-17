Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE577F7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351385AbjHQNbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351515AbjHQNaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:30:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817726BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so122682001fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692279027; x=1692883827;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqPL20+ASkIf7J9Js8wWxOYppVj2GzrpsRc4VB1aKQE=;
        b=RrRrafPKFPRnnWpY5579CSi/gEwFLYijlwHtFn/3Pvspbu2wqZuMAqsQePXg1M0NUJ
         NIWv9D8Sn03gyl4rAOLGaiDLUuJfIPPX2haLkGY17j1gIYOxVzlDxJ3N9lc90HKdsCOy
         p3eGJitNr+dDe/zdr+zECppM2xYSP/ZPdF59K0hkebv81aXZVav70VcX78xXJsZmhG6M
         u46feMInhQFDCUbZLXvw6T99jHDkSyMsK4tTPJcZP9qWZHkgmMK3iTkwRBwFxn30+bq6
         F9LddGBr1DxqzamQHsCE6qpC/HPkdHHKx2Fi49IxrGP1HlmQzcAU2204Kfvm1oF8NtGq
         h2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279027; x=1692883827;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqPL20+ASkIf7J9Js8wWxOYppVj2GzrpsRc4VB1aKQE=;
        b=GlcxnaUJwsc3veI105b2z9bsZyZN7zJq8/ablFv5lcF0JKbzWRvGBNfHWmNTY1vIR7
         FVh7PZJj1KSmeXid9GBCb1OAUe5ivo2fz2XkNQB7TFWK9Z39cfyIY6fKPTMVyXIZphdP
         O9TEp3fbmjl+LCag5tSNvFWrhbJZGEF1fgA4P/thmC2svkOFC4Fw73sgL/WLNlKWv0+8
         KCMdFHUqVBa4FTjgpP1YbwiBv0j+Zw5MX/Cr1lBMcnj58g5wfYpOnkf/59CgUdEPRJV/
         bJ4J/X5JwPDtdcq0P1VyQ54GfgJkG/d6sMNYV8lToJe+7jHJwY3LCtUFJ+4SySkOv/ZA
         ZsOg==
X-Gm-Message-State: AOJu0Ywl2BsH1ecQ6BQWRfw8Cjhez0nawfOqo2dI8rSbz54Rtwno8irQ
        FoldnNIxfndm7oqfrW3Oc2kT9Ijk27owAkEB99Y=
X-Google-Smtp-Source: AGHT+IGo4IJtNuN18JCObOYUV8FNAZFh0tysAmxt8dB74j8o6m0zJpESP5MgoF12/mjNJgZJJe6JZw==
X-Received: by 2002:a2e:9e52:0:b0:2ba:5ca7:2311 with SMTP id g18-20020a2e9e52000000b002ba5ca72311mr3886327ljk.41.1692279027459;
        Thu, 17 Aug 2023 06:30:27 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z22-20020a05651c023600b002b9de06f119sm3941689ljn.67.2023.08.17.06.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:30:26 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] ASoC: Convert remaining Realtek codecs to GPIO
 descriptors
Date:   Thu, 17 Aug 2023 15:30:14 +0200
Message-Id: <20230817-descriptors-asoc-rt-v1-0-434f5f177cee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOYg3mQC/x3MMQqAMAxA0atIZgO1FateRRykjZrFSiIiFO9uc
 XzD/xmUhElhrDII3aycjoKmriDsy7ERciwGa6wzfeMxkgbh80qiuGgKKBcOwXg7uDY630EpT6G
 Vn/86ze/7AXPCRUZlAAAA
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
 sound/soc/codecs/rt5682-sdw.c |  4 ++++
 sound/soc/codecs/rt5682.c     | 20 ++++++++++++----
 sound/soc/codecs/rt5682.h     |  3 +++
 sound/soc/codecs/rt5682s.c    | 16 ++++++-------
 sound/soc/codecs/rt5682s.h    |  2 ++
 14 files changed, 67 insertions(+), 91 deletions(-)
---
base-commit: c5b06b35a73b80f1af931c2371de084fa77b5c23
change-id: 20230817-descriptors-asoc-rt-9c072934d376

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

