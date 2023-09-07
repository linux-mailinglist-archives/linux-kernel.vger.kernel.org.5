Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83155797C73
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbjIGS6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbjIGS6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:58:44 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C807A1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:58:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4122436627eso8551261cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694113117; x=1694717917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDyS14lOc9gIdV8qqpJN7dVOi7FiXE2O1crBwgTrNhg=;
        b=XsEqKKymO5exgabWlyfCqcLtQylgFI8tUxmmzhAraa7Qldbak1rH0+qfR9pyg+OGAG
         dRoH9HjEav4EO1QUXn7OCZ4G5UwzHR7aQCkmJoTGUQKcwyU5ig5Yv86QY05VUGYf7i8Y
         QckCjz4jFFQ9wvldLTQX+xYCVHvHE4e3AVauu4tIxDRQ3h3DtI641JDHIMx6bS9aqXFm
         w61Hher+eb2g4UFFFUsk+l9lzcHQSVJUSeD45djXdMkeUlESV2GRFcdFwcGTM9b8pIH0
         HU8tpkmrumxNqOl4yB2UX++69tbcDI1FrHpJaadjPWNXqpglO6Zs6GDZIiYsRML4IiYN
         LjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694113117; x=1694717917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDyS14lOc9gIdV8qqpJN7dVOi7FiXE2O1crBwgTrNhg=;
        b=vkUnS7+nDRSc8cSwV4xmKc7OIy/kGyb8YCKzSGUKAydG5o/D7apCqFS0oJimNmHQke
         TCfqwepNooZSUxZ72BfmFXUPNjOr5e5n4Sq1u9ieSyzamDvp40HHxxUFp+7defVWXBBg
         B5bGfhWByrLIfFzGJM1nSys8ku4ibRZ65TsBVgWePFdTRh7eO+dqsQeFjRdHbcMh1opB
         ZXrfpsoiTuFuwVVYh81YsiwtCNstTBHdx6zC5ZlC6urpvcnd0HuL6054aOubMdUFkWjE
         SNRGnugXxgEFq40z2hjBWgdsJ2whsiVOU5Ti2ye+p4Ryetb1jMBraFS8z3zh4nQrrCDg
         Cizw==
X-Gm-Message-State: AOJu0Yzi+Zih/zUbuXDlCgAwVIeJu/pncR8l+7IhwZscd8oMx7FNYWo4
        bCqF/z4u/0LJvpeT6FM642gii6c/6a9J7swrYKiAWQaKNNbi6WQq
X-Google-Smtp-Source: AGHT+IGJ2fOJYbfgZwCYkGOqpBoV8zRdwms0YQyjwmM812KoO4CG3kmEhKK7s/PjKGQeVe41+y3pVjBhSp9/fdWja/U=
X-Received: by 2002:a25:408a:0:b0:d06:49e9:a29c with SMTP id
 n132-20020a25408a000000b00d0649e9a29cmr19754022yba.34.1694071374753; Thu, 07
 Sep 2023 00:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-13-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-13-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:22:43 +0200
Message-ID: <CACRpkdYJhP5otaFXbn49sK_33GJMy85MszyD9rqoQT1-fqd9dA@mail.gmail.com>
Subject: Re: [PATCH 12/21] hte: allow building modules with COMPILE_TEST enabled
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
> Allow building all HTE modules with COMPILE_TEST Kconfig option enabled.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This should be a separate patch should it not?
Just send it separately to Dipen so he can merge it.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
