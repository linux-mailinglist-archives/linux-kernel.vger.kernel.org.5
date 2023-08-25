Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B57881BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbjHYIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243456AbjHYIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:12:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DC2109
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ff88239785so973905e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692951133; x=1693555933;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZsvxtDw2cHrK/gH+F8nfBihvnVgUOAVKlUaPMeEkUI=;
        b=LCbnJHQy1VMiQ4tifKEsp9uvCTkV/Ewo2KCxFPSMWF2TjNpFdyR5fghHe/vkK9AhdY
         9qFQLtd07F9/BU3IgmFeBPtrGLmUqgx5mW+eNtIQyyTXUbxG/jv+OLSx3N/PWvQLIzpe
         /HucRdle7oxDOeV8DOn2HgvUuPymfi+Y64FAMMUqVqF52ruIeDZtvH6zqCwx5zHpvmMH
         mHIozSTtGU7qZLvQEiBCi7AbdNGtSFVmQbp19e/pMityydV8pmpM+4x1n7TQA2bxPkKG
         9A26hOml8zRBQNNw53M0gg2usWBiHbnmBpGQYSiqJOkJQoRdoQfSyyd6DOnxUAp042xh
         EnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692951133; x=1693555933;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZsvxtDw2cHrK/gH+F8nfBihvnVgUOAVKlUaPMeEkUI=;
        b=MD0VHcnPEELAeaIzcYQ8Ce5SB83YMlIQyvDpbeyV2xjdZhGSd/kSm6rwKF+sxQ1csl
         ycj63OPiW3QzLTStH3n35kn8LTurZjJEVG9F5SHUb3lL2q0/kqlDJn3vDJQrWrkT3/BW
         8eQYN3+OmOab62xE9kNhDZro0B2K1J+qlBhFNzQUcg7Mx6egQ5LePvv1Tv4Aq+0SN0+T
         Ql1WcU7S07bED5OQ2A6lAuUjVRI2xqf/4ldLWMseS2bRjnkJ2kR7Vr1UlrUALcPiPhkB
         Adn2r4HNjBFzBawHnI/mMBieC0YY8jW7zrGtaEp466MJERpeX6DLj5LKoQ5+2Oao+ewj
         XHCQ==
X-Gm-Message-State: AOJu0YxiVzNPTjcb4DV7+YhQnv/YRfcNcyEwN/m4nOygr0luhUAZfJo5
        jXiIFCATTZvkWgGAuEIIh2/Xq2dhxc90+E2pHi8=
X-Google-Smtp-Source: AGHT+IH2cYfOyAKDYkikVhhazevJIX4VasKy+kIf6y6CW4pTRpKnyies/vWRmWxt1pM2ZCb6NQEIfQ==
X-Received: by 2002:a05:6512:128c:b0:4fa:f96c:745f with SMTP id u12-20020a056512128c00b004faf96c745fmr16758118lfs.38.1692951132892;
        Fri, 25 Aug 2023 01:12:12 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2511c000000b004fe1a35fd15sm195559lfb.140.2023.08.25.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:12:12 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/7] ASoC: Convert some Maxim codecs to use GPIO
 descriptors
Date:   Fri, 25 Aug 2023 10:12:10 +0200
Message-Id: <20230825-descriptors-asoc-max-v1-0-b212292b2f08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpi6GQC/22Nyw6CMBBFf4XM2jFtjYCu/A/DovQBkyglM4ZgS
 P/dSly6PDc5524ggSkIXKsNOCwklKYC+lCBG+00BCRfGIwyJ9XqBn0QxzS/EgtaSQ6fdsW+0dY
 p00cdIxR15hBp3bP3rvBIUoT3/rLo7/oLmvP/4KJRobd10/a1ssZfbg+aLKdj4gG6nPMHtnz41
 rkAAAA=
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
base-commit: 17b9f4387ebabb19b871bbe2d06562e48e4e7130
change-id: 20230817-descriptors-asoc-max-b71ac02bf1ff

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

