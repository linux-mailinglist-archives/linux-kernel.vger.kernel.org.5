Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA56877EC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346588AbjHPVll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346673AbjHPVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:41:35 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF0B2D7B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:41:18 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58c92a2c52dso12873197b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692222077; x=1692826877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM2d8iCeF3hjgjUnKhIrZx6ABnQwbFOwCyrc+YukRcU=;
        b=Mxnl5jY7bKUsxCvorsG3pNieWLVGkaJNRBXChZA9KDf7TytXPrwgObDN4rQ0goNj3V
         DYs32WTOA6Qa5lKh0QH95iMsWgtnOTRAkmkscTI8wQjM2USOJWOdNZh8U/d0UYdfuwMX
         dElzfkUa9mRp9HufX0SozO+YBzi+oXAHJxDnbBLSqIF18yCa+qOe5WasHBzl4jS9e2Gp
         NTjWrHiCl9S4PAcQ8I3bFB83XAB8iqRXDMNI2U0WjksUzYXshLSDvDxE07I0N3H9zYt5
         gnjbvYDpUQhtEeLsyYiOWcysbDp04JhFMpcHprrXhwjhUbltBF/NyCG/dEr7EsDbKadG
         4HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692222077; x=1692826877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM2d8iCeF3hjgjUnKhIrZx6ABnQwbFOwCyrc+YukRcU=;
        b=S9hWHNWPBM7YMs8wfqHQ/n07HGjg3Awa2UJlzR1I/G7cPNjRv8USwtmFprsCFg+TBc
         vEvNtVdWVVrfEouzY++tqO6hAGgWdjj7ReoA3r+6zEGEWTYC7tRyPhopE9+dJUHKSSNw
         fWS/u7powIKJNYrTO5vipVnTOTFyZlzKnGooI2ykq6j7FBMJK4oEj9vYltqVJemhoQyG
         1GZ0jGkEyefAAtznB1bNQ9YahpW7CGg7xwzYbOiKgLgiml6rE7ppJM1Jx0MDFlRiDvCD
         3mklCW/vU0q66kZ/Rb5iUqjg5ipM0tA1AFphJeMz660e+pqEIxPrULtr2b7Rg4GLSf4K
         /+Ew==
X-Gm-Message-State: AOJu0YzNvY4AYvwDprb31E6V2vJpOqmP4DvebyRVJ7cDBVtkwM2MaVIT
        wUer3MuDRtZtIBFGyaZ+SPkTyjY5D3bIbhRBxqB64g==
X-Google-Smtp-Source: AGHT+IF2K3nSGKFFw9RoL3fu5zk1l3Bx7/4FhkrJhLUHZPgAou6gIjFpZk/Q13JhyjcX3Qw1xdligCFwhJp8Gd9VkGg=
X-Received: by 2002:a0d:c4c4:0:b0:56d:d58:82b7 with SMTP id
 g187-20020a0dc4c4000000b0056d0d5882b7mr3314034ywd.23.1692222077678; Wed, 16
 Aug 2023 14:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230816122032.15548-1-brgl@bgdev.pl>
In-Reply-To: <20230816122032.15548-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Aug 2023 23:41:06 +0200
Message-ID: <CACRpkdaTUi0r+nY12J8sLxmvfG2xRd+OMngcMiQkr5cqerevtA@mail.gmail.com>
Subject: Re: [PATCH 0/5] gpio: cdev: bail out of poll() if the device goes down
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 2:20=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Wake up all three wake queues (the one associated with the character
> device file, the one for V1 line events and the V2 line request one)
> when the underlying GPIO device is unregistered. This way we won't get
> stuck in poll() after the chip is gone as user-space will be forced to
> go back into a new system call and will see that gdev->chip is NULL.
>
> Bartosz Golaszewski (5):
>   gpio: cdev: ignore notifications other than line status changes
>   gpio: cdev: rename the notifier block and notify callback
>   gpio: cdev: wake up chardev poll() on device unbind
>   gpio: cdev: wake up linereq poll() on device unbind
>   gpio: cdev: wake up lineevent poll() on device unbind

I see why this is needed and while the whole notification chain
is a bit clunky I really cannot think about anything better so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
