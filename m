Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDF811062
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjLMLnD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 06:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjLMLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:43:01 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8DDF2;
        Wed, 13 Dec 2023 03:43:07 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6da09f8ce35so937565a34.0;
        Wed, 13 Dec 2023 03:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467787; x=1703072587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFX8KgBna94AOXnbpss9Eb/Qd6gXo+veA8DhSkzU7QQ=;
        b=riNB9nlVUNHNJ+SKvIyoHMDEDFzUUyLSyrNhlGAF9GMMi8qW7crahGsXU4MG7hvseh
         I0ZdB5/c+R6Qpkx1GCU0wILYvzXa1L6iEtIvTqtwzg2Uy/NzS+abQ9hyCNDcSyykRmCP
         j16bOqGudcdD2g6J+jOI12bCiZNDtsizM5tyP2vDWTlbP/X3bUr+hkGjwknY7J66Ckh6
         QZf/9E0MN9E9gH059Vck5jkH5ZMhrnBzrU/mTwwwXrl3xc5zhOvjNDh9fi6gSaANziAE
         VPbqih33I5du2PmQoXGKbWbipWylgJuyaNPZ/P3s/s8Xr1yWWdsRZSOdDFrw+7Ro49cE
         l0DA==
X-Gm-Message-State: AOJu0YxQhbbu1HFIpzNwJkLXobMhxeBP/jNROG0CxZwi3qzifWqMyCOz
        eQDWLTn1WYMrHzBOADv7jgRmjCPjzg8JPVwj5sE=
X-Google-Smtp-Source: AGHT+IHKMZQ7YLe2NahSJVfb5JywbxiSIYhH8TulopNfB95zbQyA1nPekWCMIoKHNZHuWE/3pKmC/WmwaDErYU/sMhM=
X-Received: by 2002:a05:6870:9607:b0:1fb:23ec:3318 with SMTP id
 d7-20020a056870960700b001fb23ec3318mr14577032oaq.0.1702467786852; Wed, 13 Dec
 2023 03:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20231213113305.29098-1-ulf.hansson@linaro.org>
In-Reply-To: <20231213113305.29098-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 12:42:55 +0100
Message-ID: <CAJZ5v0hZPAUDhtzGX7GzdCe=jO63Zby65kgUMUFRShifUKEjZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domains: Move genpd and its governor to the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:33 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It seems reasonable to collect the core parts for the generic PM domain,
> along with its corresponding provider drivers. Therefore let's move the
> files from drivers/base/power/ to drivers/pmdomain/ and while at it, let's
> also rename the files accordingly.
>
> Moreover, let's also update MAINTAINERS to reflect the update.
>
> Cc: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for both patches in the series.

Thanks!

> ---
>  MAINTAINERS                                            | 10 +---------
>  drivers/base/power/Makefile                            |  1 -
>  drivers/pmdomain/Makefile                              |  1 +
>  drivers/{base/power/domain.c => pmdomain/core.c}       |  0
>  .../power/domain_governor.c => pmdomain/governor.c}    |  0
>  5 files changed, 2 insertions(+), 10 deletions(-)
>  rename drivers/{base/power/domain.c => pmdomain/core.c} (100%)
>  rename drivers/{base/power/domain_governor.c => pmdomain/governor.c} (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea790149af79..ab4b0aed34f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8878,21 +8878,13 @@ F:      Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.yaml
>  F:     drivers/i2c/muxes/i2c-demux-pinctrl.c
>
>  GENERIC PM DOMAINS
> -M:     "Rafael J. Wysocki" <rafael@kernel.org>
> -M:     Kevin Hilman <khilman@kernel.org>
>  M:     Ulf Hansson <ulf.hansson@linaro.org>
>  L:     linux-pm@vger.kernel.org
>  S:     Supported
>  F:     Documentation/devicetree/bindings/power/power?domain*
> -F:     drivers/base/power/domain*.c
> -F:     include/linux/pm_domain.h
> -
> -GENERIC PM DOMAIN PROVIDERS
> -M:     Ulf Hansson <ulf.hansson@linaro.org>
> -L:     linux-pm@vger.kernel.org
> -S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
>  F:     drivers/pmdomain/
> +F:     include/linux/pm_domain.h
>
>  GENERIC RADIX TREE
>  M:     Kent Overstreet <kent.overstreet@linux.dev>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 8fdd0073eeeb..01f11629d241 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -2,7 +2,6 @@
>  obj-$(CONFIG_PM)       += sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
>  obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o wakeup_stats.o
>  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
> -obj-$(CONFIG_PM_GENERIC_DOMAINS)       +=  domain.o domain_governor.o
>  obj-$(CONFIG_HAVE_CLK) += clock_ops.o
>  obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
>
> diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
> index f0326b27b30b..a68ece2f4c68 100644
> --- a/drivers/pmdomain/Makefile
> +++ b/drivers/pmdomain/Makefile
> @@ -16,3 +16,4 @@ obj-y                                 += sunxi/
>  obj-y                                  += tegra/
>  obj-y                                  += ti/
>  obj-y                                  += xilinx/
> +obj-y                                  += core.o governor.o
> diff --git a/drivers/base/power/domain.c b/drivers/pmdomain/core.c
> similarity index 100%
> rename from drivers/base/power/domain.c
> rename to drivers/pmdomain/core.c
> diff --git a/drivers/base/power/domain_governor.c b/drivers/pmdomain/governor.c
> similarity index 100%
> rename from drivers/base/power/domain_governor.c
> rename to drivers/pmdomain/governor.c
> --
> 2.34.1
>
