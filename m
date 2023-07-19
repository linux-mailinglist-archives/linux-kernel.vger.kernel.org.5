Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C427A759423
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGSL1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGSL1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:27:13 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892BA10F1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:27:11 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so2510505241.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689766030; x=1690370830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFpCRVv5PmHo/Qhu0MnJ0bOoe/8r6+kZDXvCAU4jW/Q=;
        b=svj9PdUL8LTzXa9se3SSvZNb2ZYezXHm8mXI+oN9nc93JUM+CnOxCmHhLsODsxrHg7
         WzXDaTnfoAqgAvmD/0MJHaTZfRYkR/wLgSX7S0mmo61NV8qwvTr4OH8JbfaZVttzU3Q8
         t8kN5TI4mnizgE77AcBTV/68Q3/PgMzZL4LCMD2rG/OwfxGYI5S1xFW3Pm8yUrjiVe4W
         PTy8PT33FbBtSuI/dACJWprW+W7K7g/P6EQ25lf0Us4Ke7WDraqGKjHzOdDf1qyW57qB
         5cKjJwHsAVxdzWiGmLh6yCxWdReDP7kFdAiuqVUmknrfcm10uAcufhBUvU2099TbRIL9
         9eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766030; x=1690370830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFpCRVv5PmHo/Qhu0MnJ0bOoe/8r6+kZDXvCAU4jW/Q=;
        b=URPTSroRDkwYcEX8Zc+mRJAySswwSNPM2T8dSsC5AgCHcS0/JiK0Fya+mi1sSalrzT
         RokD5J0GNnhtbWgx0xranMYlxXcJSAqHvchIpY7HZuNMgZfIunJP5d3i7UzoLPHm7iik
         KiQnUWoViFXYyHF+ZJEqC1L6XHPseKbi3DtxOx35GgCxT3kazAS+5+2hYEyv7ZQzACzR
         +OR92d7X+Gpd1ct+1lgpeggO3FPQDWEbScnrWoHWg4jXT7ksTnyZXmGmYKT4YbomEd0a
         +/l78lKCKKgK/4OizZzdfl/EN9UnXyC/FLCVCFo3bVrSbPrPcp44h1vbL7xMh1fnZIl1
         3PzA==
X-Gm-Message-State: ABy/qLaiQ+vm6+QPPBvBse+9uQqqvHV4bb+awvAY7Zfe5FBCus+5S2/a
        095DJYuLFSzxdCr4WqVdrYiNJ4iOtBpLfGqZ2MDf1Q==
X-Google-Smtp-Source: APBJJlHO8O/mzwi0btqCKPoMkRPFIuJIBANWpH9wNXuUY9oCFT6pA2cTWvsQ7kkaFNjae/hMkeEv/v2DDEA7D8f1G4Q=
X-Received: by 2002:a67:ee09:0:b0:443:6a5d:b312 with SMTP id
 f9-20020a67ee09000000b004436a5db312mr1447339vsp.14.1689766030703; Wed, 19 Jul
 2023 04:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230718223055.2809-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230718223055.2809-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 19 Jul 2023 13:26:59 +0200
Message-ID: <CAMRc=MeiE7SL_XGdRgXoKTr35kx1904sDb3NGiEEL4mqNmAyWw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: bcm-kona: Make driver OF-independent
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:30=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is nothing in the driver that requires OF APIs,
> make the driver OF independent.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Series applied, thanks!

Bart
