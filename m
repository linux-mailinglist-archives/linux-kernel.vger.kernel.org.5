Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F999797CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjIGTbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbjIGTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:31:41 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC819AF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 12:31:35 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c0bbbbad81so458726a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694115094; x=1694719894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VX520/JAjo5YxFEs6vhZtWf0iQa736VrN0vgqzfoO4=;
        b=U+WL6gZJ8ogeIh6p7mcGACH8bpoHTuGyDSuYo14fsd1aex34DciEq3wrdsk2nfzmQq
         Z9yuO3gPTZ/rvOoTCfL8MUtTSoNSmA2pNIDdswUa+HMREfzVxU+9phgxJI/uRfZ4Q0JG
         jy8mxARFHYoqOrSLxkQXI3bbdQscXG7u5QfWvG8eEXxDavz25pQ7LhZ06iLJm1GQEx5P
         TreueuXm2sv11rupkwktP8sPc1TFv9e86afhVg0D1T3P7z/O476T0Dv4ea1MWD/htnvC
         eyaKcPXVHtBPN32zKBAoJtk0VLqNUx39J0lITuHoadkmY3gd1O6FVRQHNiqo3XEi3Npo
         olMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694115094; x=1694719894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VX520/JAjo5YxFEs6vhZtWf0iQa736VrN0vgqzfoO4=;
        b=ADJw37A1mENagOds7qzEhKAWiK7TBKZbK/hOHbvLyaFn/uHU8/xGKii3KGi6BDuocI
         5ZfTSVJ9L2X2lo1xglbS5tf0EPPb+7xaP2BFn0sDU0zF2gVf0HqajBC5H5+Km82G4WmA
         S8B9iun6Li+DKzC3CXT6zwGmtFpjOgdT/57xQp+6e80btN6FziykjVEMkZ0n3neKGN6t
         PB7ab851B7VUpIdc+j/0ebfMpiL/ZgojSSkbjvM5z71/jY7+BNi4uGkQ7dS3E6ghNmw7
         nuKiieqvcBVhkcwvl/sbGwpPaDKoEdMG2Neugo3A7Jx/z7aKwRXrEqJ+tM+7LyqYWc+U
         tpjw==
X-Gm-Message-State: AOJu0YwUYBXLzktojFBhqTIwKWKrxypIkgGaQXGVx3c5pT7KHPjaOrsr
        3ELbzPcy8s4LyZOip0EAYxoBT1BDqSEWeH0w6sfz43e1n6fc7Rzi
X-Google-Smtp-Source: AGHT+IGsG5hJJbLxB8MJ18cSL64AbAsKmU8HUkb1gvXKq17Y/8ZLDXSkKoAPtcsGb/CfUJGklHIiazXnZYlmi1tiRYs=
X-Received: by 2002:a25:d78a:0:b0:d78:47a:d76e with SMTP id
 o132-20020a25d78a000000b00d78047ad76emr19559951ybg.49.1694072224500; Thu, 07
 Sep 2023 00:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-17-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-17-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:36:53 +0200
Message-ID: <CACRpkdap-AFmVFG_gtYeGuR5JFLgHQ6i7w6HRwKP4+pu=nd66A@mail.gmail.com>
Subject: Re: [PATCH 16/21] gpio: of: correct notifier return codes
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
> According to the comments in linux/notifier.h, the code to return when a
> notifications is "not for us" is NOTIFY_DONE, not NOTIFY_OK.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This should just be applied, right? If the notifiers already
went upstream (sorry for my ignorance) then it should be
a Fixes: even.

Yours,
Linus Walleij
