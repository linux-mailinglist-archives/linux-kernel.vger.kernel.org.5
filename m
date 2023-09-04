Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A413791240
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbjIDHdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350962AbjIDHdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:33:00 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892BCDF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:32:44 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d7820f9449bso1003576276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693812763; x=1694417563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvNYnMU1q/NYMgMZD1mpM6fkhhhL4YTdzrZptcyKkqs=;
        b=rBcdvLa34KoAj+iux5ckznlnABsHhckr7tXpBvEDc4yAMjQAKIvvJwskEUO4Yqt+Qx
         f3zToSQOtnK5mZcvtVeXE1diiGJIZwePpJJzE8CxbQ0NbthvDmtE3+61Dcab9W3sXfnU
         1zi4krxIv7T6Gn/52/YwPhR1dIJ5OotgVQG9MqMGb3wDnbji8zO9E9k3xj/tw80fcnjG
         mSPtfhBbawu30OjlPjGt6GD0R3DMrgfiVUopry3tqF5qvSK7kQf3iQ3rdaNj9gqWKr2v
         c37AKN0X2GsgkfVFe7th6KWYwSimw3PMV6OYjVfzZY6n1OgXZjv0wcF24wCeD8iOaZ9R
         amMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812763; x=1694417563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvNYnMU1q/NYMgMZD1mpM6fkhhhL4YTdzrZptcyKkqs=;
        b=Bz+coI7uB2LeaLof8NB6zEW2ADWiFHcORT204x7M0Junivde1E/5QqM7Rov6+nT8T1
         6nVdFdhx27uP+gI2PnCnTP0lcoRVK6DAzombWtIvaIUDYqXfp6H9L5ilwks/Dl+y/Yld
         DyERDjVQLlTZQqJxRQAHNMwnhGbaLn2q/wFuru0TU+3JXMLtHSW2IReqmQJeZM7yIr6p
         QNBilI5TFzrGaolZHXuU6q+dOPRKOHTG3Yi0dnD+oNwjFIEmeh7R+EfGN0udKTyMXzq7
         YS4dELP1CH1Q7DvdKU6vY5nWWb6a3K+Kd7GCTXvur9xEr3j8U9RByKSEJD49LMc71GgW
         Ygkg==
X-Gm-Message-State: AOJu0YwPIes9+ngWe/XLC3x4oX5bM7q8+8llWKxISnT/2nRtrbP5dW2g
        +gnS3hMctcl6uozo5ElaSH0ixwhVns+m/+ZbfnXF3A==
X-Google-Smtp-Source: AGHT+IFubKUbIyBl/neDJNGHZm9GGu1Eyn9gRKMgeycHQQEJToscP2A2gpx8TIYyMbgsPuv3Xq+YlnwOrSRvTvQS6HM=
X-Received: by 2002:a25:83cb:0:b0:d7f:466a:ea75 with SMTP id
 v11-20020a2583cb000000b00d7f466aea75mr498077ybm.4.1693812763251; Mon, 04 Sep
 2023 00:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230903190657.12393-1-brgl@bgdev.pl>
In-Reply-To: <20230903190657.12393-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Sep 2023 09:32:32 +0200
Message-ID: <CACRpkdZjkQOh807XeeJ7MKmz5p-5wvRhaQ6LzzBta87akHHFYg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: unexport gpiod_set_transitory()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 3, 2023 at 9:07=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There are no and never have been any users of gpiod_set_transitory()
> outside the core GPIOLIB code. Make it private.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Well spotted!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
