Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7155B7857BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjHWMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjHWMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:15:14 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63DCD5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:15:12 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ccc462deca6so5431929276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692792911; x=1693397711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N2gnvcEfGb3L+QEwC+N38b9ItEwrmfrslDJ70apZRE=;
        b=KvEB3qKN8VzcKjqujVsocMw0sRuVeLhCp/KM+QEqtq5mdYjWS+/Xbey3x0VhW2vxXz
         VpTfTvsCMtcZL9UXJtIr6ifbntVhGAzDURD898eT8D+vsinNENQn5JRbPoa8quLBMgDU
         pG7Icamv1V9xAVdOs2cILcbbaTHRft9hc+8T3CZwhjCL3BVsq2gpAIyQNfyJE+2A7t37
         FKHwN3wuT/Pad75An0kTaCsolWpRDZRHmGrnMg3UAp8KcoRcyplidXycGiapECsZ3cM7
         sdoi8xM9p7HaSzcfpzdAqKTqeqTEYyA5sdX33QZaVuksD5nUEHAO8n8jzSkKUIdmAglW
         K7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692792911; x=1693397711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0N2gnvcEfGb3L+QEwC+N38b9ItEwrmfrslDJ70apZRE=;
        b=TKRU4q7cey2FbtH+O99JwoZTpUpmkW+c5h12vloVoC7A3CLDCiWUpBiJ9mys7iQFzc
         nrMaKZc2TdZMl84dnVtkndGG8A/LH7KddXmFF/MssC1He8KCCEBauw6AwomfcCl6LDk5
         snlEIc0QlD072exUBI33qwZ20tkyMGtDBDML16mx2B4ZsS2K5C8qnDnWuwo4Peh0MKgG
         bHA5L4bmVFWuZ1+HUuoIaXWxHm3Rv4sQVXuFAzJI+gCQiZks5r1H25fMzojgN96q/OQH
         Huu66KZZGbIwGGCNCmAUbw683K/W6aOl/L8sfPqOipOkWX94FFEiI4BcaJgXisgNxczg
         983g==
X-Gm-Message-State: AOJu0YwR+bxeAHfXZ0zFSEAC2XqejEHxu3p92g1HIE36ZEYGi2sEZiyb
        ysYA1TI5qFDzNvAmsgdqIlipHlphxn1Doha55iXbLA==
X-Google-Smtp-Source: AGHT+IEozVHXH4Oln+v1G7Ein85g60u9KEJ8wZA2BteuvSIbfcJGpkjoSLO9O42JwgcVVVFGEFzwIBnJ3zMVc1ykWhk=
X-Received: by 2002:a25:d78c:0:b0:d73:e979:d5c8 with SMTP id
 o134-20020a25d78c000000b00d73e979d5c8mr13520994ybg.34.1692792911487; Wed, 23
 Aug 2023 05:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230822152244.214394-1-brgl@bgdev.pl>
In-Reply-To: <20230822152244.214394-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 14:14:59 +0200
Message-ID: <CACRpkdZWKDsHtYHqWSqz6QYp4TKT4OskWO7v6w=2v3NhvYWc4w@mail.gmail.com>
Subject: Re: [PATCH] HID: cp2112: make the irqchip immutable
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 5:22=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This make the GPIO irqchip exposed by the CP2112 driver use an immutable
> irq_chip struct thus addressing the following warning on probe:
>
>   (cp2112_gpio): not an immutable chip, please consider fixing it!
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Thanks for fixing this. FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Marc Z, have you checked how we stand with immutable GPIO
irqchips? We should be able to smoke it out to default behaviour
soon I think.

Yours,
Linus Walleij
