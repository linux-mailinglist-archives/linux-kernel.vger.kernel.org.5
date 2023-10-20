Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6D7D14C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377735AbjJTRWq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJTRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:22:44 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986FB13E;
        Fri, 20 Oct 2023 10:22:40 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57f137dffa5so61830eaf.1;
        Fri, 20 Oct 2023 10:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822560; x=1698427360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WExMwOi8yEvexXOlKKBpSe1onE84T9t/cK767zdHnCI=;
        b=bSDR9vzNmoK5uxNx/8K3cV6d4+2CIf1FOPrdcmW0LocSBZAlSueNa76IPmHdI3IrNb
         4ruFdYZOpyjjFiidRq4v/wkXaCV3/PGqNkk82RTpTrRt3ziCwUMWsbqBjZdwQeBWEAVD
         T1OVk22RVMBSylQJD+pnXbH8TkFDqE4dKK82zzZ56pNWn6zKTjGtsgnGR27BynnF1RXQ
         tuASOHz1p38cnrTC5yBnTsCvkSctsI5+q1SKo6XX8wCAlY52DNIn75rYoUEt/kvF5MyW
         Fi7pNWMn1I9u4kTathvK2Bwcg07viTblAEZQPU2xvjSd2iWhpOJjJQIG1CSLXUvPKHTI
         e7aA==
X-Gm-Message-State: AOJu0YzoxW3U/SaRl8ISZNqo95J3eJgha6YkkwrAMau8qqRKGBNPrJcT
        pLe3aX1h3kelrlJie4oVMrcw9Jv/XHLIGQR9xJQ=
X-Google-Smtp-Source: AGHT+IH9r9pBkMk4eODC0OIDRDLecdjQbDcsz5fF3rVx/e5d06YRe98srBD0VUQXPGsNansNseJslea96o8USjeX9rg=
X-Received: by 2002:a4a:bd84:0:b0:581:ed38:5505 with SMTP id
 k4-20020a4abd84000000b00581ed385505mr2726894oop.0.1697822559885; Fri, 20 Oct
 2023 10:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com> <20231020084732.17130-7-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-7-raag.jadav@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Oct 2023 19:22:28 +0200
Message-ID: <CAJZ5v0g7kkFhk8tNp1PMxuKkS7jv5rp16X-jvK0kc1TO0NTwFQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] perf: qcom: use acpi_device_uid() for fetching _UID
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:48 AM Raag Jadav <raag.jadav@intel.com> wrote:
>
> Convert manual _UID references to use standard ACPI helpers.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/perf/qcom_l3_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> index 2887edb4eb0b..f16783d03db7 100644
> --- a/drivers/perf/qcom_l3_pmu.c
> +++ b/drivers/perf/qcom_l3_pmu.c
> @@ -742,8 +742,8 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
>
>         l3pmu = devm_kzalloc(&pdev->dev, sizeof(*l3pmu), GFP_KERNEL);
>         name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "l3cache_%s_%s",
> -                     acpi_dev_parent(acpi_dev)->pnp.unique_id,
> -                     acpi_dev->pnp.unique_id);
> +                     acpi_device_uid(acpi_dev_parent(acpi_dev)),
> +                     acpi_device_uid(acpi_dev));
>         if (!l3pmu || !name)
>                 return -ENOMEM;
>
> --

Applied as 6.7 material.

QCom perf maintainers, if you'd rather take this yourselves, please let me know.

Thanks!
