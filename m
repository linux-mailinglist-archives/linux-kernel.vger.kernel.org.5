Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F267C7CE6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbjJRSdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjJRSdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:33:01 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941F8118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:32:59 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so7135455276.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697653979; x=1698258779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcuhCkyUkVkJNziShfChcqgUhXGg8fxBljsMorp2LaA=;
        b=ePAoapLTdINEqv0vb+QGSFhX9piNv71BX+6lcbgOhGicNbkA0CTYSeBIpA2wzGnj9t
         Jx8iWGexToXZ/0Mc3Ysw9/hbCUrE3KAK+I0DdAo4rfc2ErNb3jtYaHqC/EHL6gcP2qj+
         zE0pX14WxW5yQ6LBuZNJO2r6RXlEM4U1TM1QpQxKtK8yEfg52XV0iqvRHpFcPwkQh80D
         UvDuFK301kalDuRtdHE3w23IXKN6gL52HzxAk2rKq0YgC8Ml1GuXaNFj3uS2qVigZBww
         ARq3TyxGIzz2X0rLmcFSI9AIkJ9YKra/PMWOGxxM7pvM+u1T25EhhhGCnvTWq2TgzhPP
         vKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653979; x=1698258779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcuhCkyUkVkJNziShfChcqgUhXGg8fxBljsMorp2LaA=;
        b=sTm81fsBa7b2yTU0O4nttIR2ye9OBWBFgXoMFTyFixu6bkgTZL5+vRe6Mcua7POZYm
         PbHcWT1LbeJHmvC/F8k4rNbCp6xAjevSsEc/6ceXWXm5rrW2b3UNjNl1sifU+5uZrmWl
         4rNUlmUOtSxqRTp1unfSNqvkbbMLSpFtgjg1HXJDGmO0DqFFuoH1OEjRaRnttgtjerxW
         KZ4Mz5O4hAX82zr50v5dXmWWxZvKCv1+zWwRp2Dx+dMMsIVc7ppkfxVw7C/V8W8ASQ8y
         bAe6/5wMxPEFPxwcjo4cxYb9or8lNqmiEnBPhweExIwvBDd6pFTirZJozVNk0fN+eayH
         l/sQ==
X-Gm-Message-State: AOJu0YyFwizXn8JWLLKZaGau/pZmD4EOxF/YhT+/PH182QQeO1DAKjwz
        P9VzZ6HxdCORpEmCosJzslxru7TlI+FvI3vc+pASqQ==
X-Google-Smtp-Source: AGHT+IHkEoDEJmC+1gcRzR6CUVYIHQaxyD1p/4F2VErdLaQiFO3wf8DlPdOjz/L+K7KLQtAA+Udj5qMsTRqBXRzn9+Q=
X-Received: by 2002:a25:c588:0:b0:d9b:e043:96fa with SMTP id
 v130-20020a25c588000000b00d9be04396famr176582ybe.22.1697653978695; Wed, 18
 Oct 2023 11:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231018152816.56589-1-ak@it-klinger.de>
In-Reply-To: <20231018152816.56589-1-ak@it-klinger.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 20:32:46 +0200
Message-ID: <CACRpkdbyOqxU_2vP1-9P+XwX4YTXfgSyh+abRJxSimxqqDDbwQ@mail.gmail.com>
Subject: Re: [PATCH] iio: bmp280: fix eoc interrupt usage
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
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

On Wed, Oct 18, 2023 at 5:29=E2=80=AFPM Andreas Klinger <ak@it-klinger.de> =
wrote:


> Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
> bmp085 and bmp180 share the same chip id. Therefore it's necessary to
> distinguish the case in which the interrupt is set.
>
> Fix the if statement so that only when the interrupt is set and the chip
> id is recognized the interrupt is requested.
>
> This bug exists since the support of EOC interrupt was introduced.
> Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC i=
nterrupt")
>
> Also add a link to bmp085 datasheet for reference.
>
> Suggested-by: Sergei Korolev <dssoftsk@gmail.com>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
