Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5B75848D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGRSVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGRSVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:21:03 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA3EDD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:21:02 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-78f208ebf29so1868594241.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689704461; x=1692296461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrugx7KI1EVrxuOX8UYknjbUTHEed/rOAZZDAg45sNo=;
        b=fONXT3gIOLqAdNT92yIJWsaEBJcCpfqrLAh5LfKVz021q3iNnvd/wVAZkPJeoy1pVt
         gsdn/7BsjQq697y5LFuu5ZqujTCqQguuMn+SbGekSpPKBWA3HpHWsCTbEKS2PKMNR9zb
         4YxrXizTL07CZyQT567urzA4KNJbskptw6KU0eMFzcrrK7Ijbzyr5FT3JnzfX+m9q3ym
         HiN1fzTimyZ1r55CdZ4wtrrEm2+poVc6QX96mQxi8vbSR2Gn6AHNnVduwW9+V2L3abzE
         PwaNfD5oQca/3hzec+w+dZQl70ajhAWkW7migjR08rPyo1zh0jjim6Gpk7y++PZm2fKt
         3gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689704461; x=1692296461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrugx7KI1EVrxuOX8UYknjbUTHEed/rOAZZDAg45sNo=;
        b=NW3bl5KKp2KeIiz82+U5UscOXns/mR9dmwOfAd5oeDXkCFKB6M3La2k9AjaqSPNOhg
         cT5XAJPJ/e8lnz5iHSLT4bJ82I7WbHW2XspEPo2csO6dGXljNpoKNoJrfM0f7R2UOx3D
         IJbkj9Lg5TSfU05jCQjrGz2apWPZerNig29oCzTk1MmUqPfR+XgbzlMQQSGKNAeURP05
         a/bxfcJn/FCzXc18Rh0cXRYRAdSnXGgM8/gTnHTpibuAK3TSFHCAhCVVsxCSsQbM9YKR
         5ZCQA0v92/CPtpD0ohPPkUUOf1SPNmVHNGG40ongrrL4fUvBsTjD5FYhBK/ayOaPCr8y
         PCqA==
X-Gm-Message-State: ABy/qLb01YrqhpJK44CkDfzK9bsZqtkxPBffywu7z2u8t4oTtHqZZ32G
        ouvDXd6XISmKshDS6oAhqnOnScG/tlQi/ILmvx9KEQ==
X-Google-Smtp-Source: APBJJlHcXlOqL3+TOAeF7hpsjENS1RHB+L4LNghHklUSMuVl3b39D6vUyvUy6A8isCrU1weyrGbAfYlpi8FAmOpY5SU=
X-Received: by 2002:a05:6102:24b:b0:443:73ac:896d with SMTP id
 a11-20020a056102024b00b0044373ac896dmr6866028vsq.27.1689704461617; Tue, 18
 Jul 2023 11:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230711151248.4750-1-asmaa@nvidia.com>
In-Reply-To: <20230711151248.4750-1-asmaa@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 18 Jul 2023 20:20:50 +0200
Message-ID: <CAMRc=McCwXeJpKuvHY4aheURimqh3ZznvVXKxsV2HzeT0=QYGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, davthompson@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 5:13=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> bgpio_init() uses "sz" argument to populate ngpio, which is not
> accurate. Instead, read the "ngpios" property from the DT and if it
> doesn't exist, use the "sz" argument. With this change, drivers no
> longer need to overwrite the ngpio variable after calling bgpio_init().
>
> If the "ngpios" property is specified, bgpio_bits is calculated
> as the round up value of ngpio. At the moment, the only requirement
> specified is that the round up value must be a multiple of 8 but
> it should also be a power of 2 because we provide accessors based
> on the bank size in bgpio_setup_accessors().
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

I'm confused. Is this the final version after all?

Bart
