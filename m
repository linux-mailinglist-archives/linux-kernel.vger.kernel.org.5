Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA2754DB2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjGPHmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPHmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 03:42:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9A184
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:42:08 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so2612807276.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689493328; x=1692085328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lCMeTABFSTAL+b37i/Hfx3xbovynYtg6IKWQ/+Fnrk=;
        b=EAp8oYmgQBedIbijp/JuWTfeC63XPjGGKP/fM0W3N7nT1AoFpUszkFBj7rF8T/j4d5
         E/Bl5S27VHeebTnfh5RYy1ZukBfc44Agj9qmaZXW+IxRMPM45vXj3yXRMOK85dngyndQ
         FXfbuUV3ch95eumtg6XmTaQohbA4pMgYhG7tNK0Qc5H6ZWOrCppMBKEkXgbXT7GDlLPR
         UqQ8BBiiCIFRk/ywSmf1NNk6uYJQo0FUhcT6URtwa6FRNQpp+ikydiFOgykURWz6ECt7
         3EU8WCcPLLAaFs+Ewcu4J9hm42bfc6PSJxzIgY3FqCOg213wfEJqihBgbVZY4WgPSbK/
         /o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689493328; x=1692085328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lCMeTABFSTAL+b37i/Hfx3xbovynYtg6IKWQ/+Fnrk=;
        b=kIRziw8RwuMO97WK6NlO5tiZzOkAd0wD4VhFe1/dmGhGTMTZY0Wnw6yQ7OB7wmGjoD
         mbM5t0iGysRbixj5ZWG9Rqq+f9O9veM2cBiCLE0qLBYeu1xNSFFXrbOpRWfbkC5OHvJH
         pa49zia++wNXKvlB398Wev8/xr340+aSTKrcOFyirSO11MKs91BFzCSEsK1of5kMeSSs
         ijKnxNZ/4XVJ4JegVMbMvqU2/umCxXWVHp8MXkDY1/15bEaVvbu2LeFr8GNOuDH5X3we
         zBXEBJr1GzpZDVNn+l8k9EJh4ymyy3oWjchb+HViyG3b+NZZnFOSoPElmiIqQLc7mNL3
         2pEw==
X-Gm-Message-State: ABy/qLYC8Gmme9g8tx/k/6l351vvzhgUEGqPxj3ITHkhmWWJhiLkQq7S
        gn1ZQ6UGzph6Sh4LIwkmB6ZAm0mAMW1thE91d1XaZQ==
X-Google-Smtp-Source: APBJJlF5SWJQOEEjmpDacKPP/jKmMv0M8gCGTNy5qIy0jVQ+TzyysBmasZsW62CeoBGuvJZS81a04vhxrXKYrtIRUec=
X-Received: by 2002:a81:6306:0:b0:570:899f:3a52 with SMTP id
 x6-20020a816306000000b00570899f3a52mr9002578ywb.35.1689493327968; Sun, 16 Jul
 2023 00:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230711151248.4750-1-asmaa@nvidia.com>
In-Reply-To: <20230711151248.4750-1-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 09:41:56 +0200
Message-ID: <CACRpkdYVg+ZshnWYTH0uzD_0bQn1yQJo6gYdmKVgg+_-RhoK7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, bgolaszewski@baylibre.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, davthompson@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 5:13=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:

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

Still looks good! :)

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
