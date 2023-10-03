Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA09B7B6CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjJCPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjJCPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:14:49 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B04EA7;
        Tue,  3 Oct 2023 08:14:45 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ae35773a04so661405b6e.0;
        Tue, 03 Oct 2023 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696346084; x=1696950884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9v1BXZnCjiIfMQyrGG/Xux/yOjBTOVdEf4NCm3iTbU=;
        b=Ilw0iZs3ZUT68UcIBCp4AAIvFrL/ujNKO4M1f0VBKUCcWyGQ7guTtu2fJTR36F9BJX
         6EuATXNwZKd+TqLWLjuWFBYBjUqcGaAAIj/dYT5iBYc21CozmQ+rBL5rgyiy+13y8ECw
         BtkUhGpUVaw0kU3gL7J+MmZHXq2lOEDL+KZ1x1Jmo6tRe05YCBkQbNVGK96IpYONaJU3
         df+O/m+85pf+lEjAu+nF/Uz9FvPHNo7520x8+zaCUq0pio/KNlFOgPVYgWVbsHdJCpyt
         VmSmti2LjBTxeReryqmXeeo0Kz3C4bDqKSELcFr1zXdBvJYljJf65hD9OihaWhkH9CPT
         qRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346084; x=1696950884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9v1BXZnCjiIfMQyrGG/Xux/yOjBTOVdEf4NCm3iTbU=;
        b=Mn/a9/nuQK6OaYYR+8vgrGvvOVyiMfnquOMSAItO2c0Hvqe1IOkeL42PjRfKyyS7mP
         qjyYsfM9vRnQuRIcyC53gGL3o0vCaUIPheVuCv+c0GQNW5Vk0eMap7ffy2viAlRktsGZ
         xov2ibPXM/ufrgYkFP8Wxff+v/W35mjIwnN/X20g+M/LMsCToP0GRJJprKzU7Xmad3J5
         S0SO3Omn9jCdUUKQMdbcNBSMhrnb6WCQ/v4qQSrKniMwk+7GBQpvU02hitfhYGtFqRQp
         aPQA/p7ScalyUYoXtXUYV1CMmlBUBASKMTQ5mxmPb79RLWFM/6AjdCTUWRKW/cahb4JI
         y6lQ==
X-Gm-Message-State: AOJu0Yz0KxFpVQS5zp9WArJg4PreDQ5mXsDTHGxu+z3FeGcpv9EjfeRe
        nUPMVMwVzPc7zMsIcoX5KPHI/m2rCmnwzgZoVQU=
X-Google-Smtp-Source: AGHT+IGCrtur4JgGsVFGsvC9n6qhrrUtTZ9olUQrA5PBh1UfleDL8UIWH0Kqgm8qlIHUkT0jdaKB0JsLxv9s2k/ySxc=
X-Received: by 2002:a05:6808:188d:b0:3a7:1962:d7ff with SMTP id
 bi13-20020a056808188d00b003a71962d7ffmr16202926oib.57.1696346084672; Tue, 03
 Oct 2023 08:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-4-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-4-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 18:14:08 +0300
Message-ID: <CAHp75VfV2cY+wsM0EtpRA-gwfC0bgbhnOgNJN4v0SLpxLVSEjg@mail.gmail.com>
Subject: Re: [PATCH 03/36] gpiolib: generic: use new pinctrl GPIO helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 5:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.

With whatever name of the APIs at the end,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--
With Best Regards,
Andy Shevchenko
