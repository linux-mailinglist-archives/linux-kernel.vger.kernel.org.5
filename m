Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C999478247B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjHUHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjHUHb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:31:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350BEB6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:31:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d665467e134so3125053276.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692603087; x=1693207887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjXKvBEbZDyxZVHAS3SQL17XsSTcqLGs2/W2EigwZCI=;
        b=eTOFoAafMTe+/yueTy7En94GrirWgoV9pf9/kfZMjzmmDZuc2dB2F3YwJu3O1dvJZt
         4xEhgKy2MvkqooZgJR2kRcytaB4QdQWfqN1OywvSuL2BYJ/hYiuSTXZBDxKV0dEqaYeQ
         GEXMe5PeBplRtZmCKpZktuODqFmn93NgIwIanCZvtGQEI75htZgtTIamXAoMKUntNSn6
         WujBRTSRf0RVuPqLTWFgbRP3Od+EHUXfQcrNLD1WBzQDnuaxiRSxQXHJcvtwv311iDoF
         bHQZfEUtUYJUdDZVsKtrSTg/Xs7AyFcm00TLtiwghVx2xI1ZdDbNxmQ8UpHiOwLq6zGq
         CElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603087; x=1693207887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjXKvBEbZDyxZVHAS3SQL17XsSTcqLGs2/W2EigwZCI=;
        b=PZeqOqsbccK6dKVFs3Qtpp3tEhT1s9ZQ+l9zSZqeheiMu0ips12a68/I5BMUu1Np+B
         XeNw3SZXyFKsyn35sTGJbjl0Pz2YUKMxfHGOdXD2V9ZUvWC6r5vTY+Ymk1ifCQuyCJ/3
         hhYkCcpXwn4c+DszsZ4Obcf8bh4qH3HJ8fqA2BqE9STmKTHQiJHl0D+/OJVpt77xLq0O
         HuOLZ+PPDU+FG1ipGcoZT4akh9MOCSgZSqe1ToFoun840FdkAsaDRlqo1BfNegbZPu26
         uLLGKw5xVuvJ6JfrxmVKy7NYaqzjcHsAVLTM6lBe2ozjZrYuKppuo05+bbPo8KusmtLI
         Ui/A==
X-Gm-Message-State: AOJu0YxeHNqVInnwuw/+71VkwXM2OZJsU/uJEVZO5FAufgJYZqnGT9yt
        Qcuy7N/Nc/2/tXHnCW5vG2qqYd5fcBrA9gglgeyieA==
X-Google-Smtp-Source: AGHT+IF7JgN+OInt84SdnnMFNzjcQlY9oYruZ3M0klPFKvPHhqbi/BsugQpfOs2q3Y+oyewPlvlH+B0B4+EEmFF/BUc=
X-Received: by 2002:a25:8502:0:b0:d4e:3ffe:79d4 with SMTP id
 w2-20020a258502000000b00d4e3ffe79d4mr6277728ybk.61.1692603087458; Mon, 21 Aug
 2023 00:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230818164314.8505-1-asmaa@nvidia.com>
In-Reply-To: <20230818164314.8505-1-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Aug 2023 09:31:16 +0200
Message-ID: <CACRpkdZu8BL49QD5DudxW42hrLxmOqUDGeHgTRYF5JBjVMha-g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Fix Nvidia BlueField-3 GPIO access
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 6:43=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:

> Fix Nvidia BlueField-3 GPIO access via libgpiod gpioset tool.
> gpioset tool fails to modify the GPIO value due to the following:
> 1) the pinctrl-mlxbf3 driver defines mlxbf3_gpio_request_enable()
>    to enable software to take control over a gpio. Only then can
>    the gpio-mlxbf3 driver modify the direction and value of the
>    gpio. mlxbf3_gpio_disable_free() gives control back to hardware
>    and is called when the "gpioset" command is invoked.
>    This cancels out the effort to change the GPIO value and
>    direction. So mlxbf3_gpio_disable_free() needs to be removed.
> 2) the gpio-mlxbf3 driver calls gpiochip_generic_request() which
>    calls mlxbf3_gpio_request_enable(). "pin_ranges" needs not to be
>    empty for mlxbf3_gpio_request_enable() to be invoked. So
>    gpio-mlxbf3 needs to populate "pin_ranges".

This patch set looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
