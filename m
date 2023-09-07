Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649697978B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbjIGQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjIGQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:52:39 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E94310FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:52:13 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58dfe2d5b9aso15652897b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105477; x=1694710277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2mdAZRDyp8VLACjM3IsJrv/DB/YaVz8BTWDKGc7zo=;
        b=uelHLugbLdt2Ec+QEXxxpIonDiAajqygav1+6x4pFRAYYZTW6W84m47KUwMO5kBWgO
         LB5gOVF0Ar5F9eO4Lpe9szia0RM0FBXguyHsr/8cbxLBD5FLzeIDd+4ln1CdXJvf8It2
         xKgilGRbMFDDtf61w1vehjOWJ+YiAho/GHb6qChQSJo+TyRR7/X5EcdWiJ0CGyJOAjIC
         jgDwQwV1+FP0YL8Y/2rAV9mxSR5WFdntiWwFcG6eysFwET540I4egIFVhjMVi+04LGlY
         mawE04w+h4AwgDlXSUT+3xoW6pMytukfL0jTiePXROjIVDyJjBCctneHPGgHxXPmfbX0
         xsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694105477; x=1694710277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY2mdAZRDyp8VLACjM3IsJrv/DB/YaVz8BTWDKGc7zo=;
        b=uXtXpHCjxERwmaW0HF8H2tY9J/IW9MREXzQ30DI19990G23FocJUZsvfAucJEAX314
         MaDiMQyaTymYVy+87PTVdwbIQOyFV4qXksz/vXf3p4bSpcIW/sUCAM8U+GgATuz28jVJ
         5NLusgy+txq4UHGc2OV7wPgMBqjBdHAZyB6VLRxhNiNR/3GUebQ9DPSSeszftu92FXnA
         R+1sB36KRIfPwfSwQ9hZnj9ixg3DgiJ1cY7JG+NoP26G1nJ3IM5A1aS745JoQuMSmssN
         RW2X1ng+N+DZAYPGxGuV6tqq6kcDKjQNs5cfaLdJ8g44M+lndSNCU/AvqCHvVkmwWnaC
         2Plg==
X-Gm-Message-State: AOJu0YxIQRMaJViB8AHJpiwfwNFXDIfdNSh4DemHkJ+vPAltSUeQ+Onl
        zhK7HBJO7KiPNQMZ679g0Cwc/DJEwq4imBlzXv1E25bfKLY8tHdSqEQ=
X-Google-Smtp-Source: AGHT+IG0DLNKfUPhB/XHRakKjzQvJdJ2oAW9KHDtArjRFCSpF0Q5z+EJuu/6b8snoqW3fkVGsSaqNy6kxIliPZAjMsU=
X-Received: by 2002:a25:dc04:0:b0:d4a:499d:a881 with SMTP id
 y4-20020a25dc04000000b00d4a499da881mr2163263ybe.9.1694072375343; Thu, 07 Sep
 2023 00:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-19-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-19-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:39:24 +0200
Message-ID: <CACRpkdYOp5162vhQXBp9FwLZzXnjByYHt8OurK4aUyQmJzgfoA@mail.gmail.com>
Subject: Re: [PATCH 18/21] gpio: acpi: replace gpiochip_find() with gpio_device_find()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the ACPI GPIO code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With Andy's comment addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
