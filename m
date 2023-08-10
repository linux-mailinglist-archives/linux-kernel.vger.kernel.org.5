Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7D7771FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjHJH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjHJH5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:57:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A81BCF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:57:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ccc462deca6so590996276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691654223; x=1692259023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0STt0Takw7Y0P938rttZLRMpSJH30p1wWPnOAeM08cE=;
        b=Tgi2kkRMtZ0BZuUMn6u4JHBS7YtfvbqcG2i1jqQG0JS4U0nwI1114IQtgzjX+c7IR4
         0TJOl5EJPwnUE5mF+PvN8A1cdrlWOOG0Gg5WffRqVRfE//eOsu19ScjKA6bZ3M4PXUt7
         oN924JhHC6uJpsAt1lGRD67Up8j+Gk+hLJj3zoQP0UwhYVARbmyXPwbUXfhEw8n68XaT
         0RmFMyoV3BES3k/uwrhtkJLvApLYipW7Mwmt2qlWKz3hR1JEig6Z1uY5bXTBHU24lie5
         dmsfjdFTVoWgTvZR6tRYDk86uFZG/qXSbv0M3Rp2lxd5yIREEAgFZxOSB3J7DqODxPKz
         U92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654223; x=1692259023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0STt0Takw7Y0P938rttZLRMpSJH30p1wWPnOAeM08cE=;
        b=Aqy9gvM9gZFBGm7lHtK+xjJXLMm8HZWu+aJfo2YgnMAb9zVCle4fVup7xr15VoFKlk
         5e/Q8fOSdUNzHvX+33qrQWaO6zeOxYI1O3+HhTcQxrwlJeBWv2J8gF/c8/VGntOMku9f
         g2FM0vnV1Gan8JL1fyj2qdTh93tA3e1Lh+iJzZU+gtsabQiPTX8JlXhpMoN2URYtgqFS
         /yIk9mBlu+S7wy05sCSgGRlqWDxivCSk8GwQS2lf2Z38bxPkn0UgCRwiXRXxxGetKZaC
         IFfU8A9hpbU80cEQfGWdc2Q8m+wsFAtmsLTFhuOYmkon4m9ceOadB/zY9hk2PbSSsXMS
         mEXQ==
X-Gm-Message-State: AOJu0Yy9pAGoLI7IFO+Z1bnXDccuPWFrZjUTJohB5zZom4Ge3X3AF4MH
        MZtWPtKdanr6gyTojee74CvXfj6ltRRP6GTkngphA93JTsZE3otf
X-Google-Smtp-Source: AGHT+IH+HHlOnbALjvLYzAEZF6kJxPPAeSM47NBdZbA6K2trPA3XVRBt0uGjd0F0UAYulLJ95OpwqbWtjC9tB9NX9es=
X-Received: by 2002:a25:ac65:0:b0:d4b:6936:90f9 with SMTP id
 r37-20020a25ac65000000b00d4b693690f9mr1961508ybd.49.1691654223538; Thu, 10
 Aug 2023 00:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100409.1608395-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230621100409.1608395-1-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 09:56:52 +0200
Message-ID: <CACRpkdZbdAidnNjjixkBnrBYK8eGhG5jPegkhEDppV-1o1mLfQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: mcp23s08: check return value of devm_kasprintf()
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 12:04=E2=80=AFPM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:

> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
>
> Fixes: 0f04a81784fe ("pinctrl: mcp23s08: Split to three parts: core, I=C2=
=B2C, SPI")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Patch applied!

Yours,
Linus Walleij
