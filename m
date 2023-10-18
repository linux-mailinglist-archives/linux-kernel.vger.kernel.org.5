Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA77CDA14
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjJRLNr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 07:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjJRLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:13:36 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C4F10F;
        Wed, 18 Oct 2023 04:13:34 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57bf04841ccso1376125eaf.0;
        Wed, 18 Oct 2023 04:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627614; x=1698232414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9BSIDSxSdsjvE34XyGwJrHtCdQ+4sCjaON3ksE44JE=;
        b=gjVpQ+HIJnhRDsX72ZR37HfJEQL5hJA+Z5Mvokf0tKUd4rICNfVwQpmWfwnLVCVgkw
         zBj93RL/++M6DObn524bYhvwypzyobqO1fy2zWhAJWR9dOyIz3kdmPDNDSds6Z/Hzihp
         TyV4mY8RPpnpVz6LTw2mHVnSYJ5/rIiBokI3bx0z3JJomTjxHrj2uMWT0OKbyteQN9aF
         OQT/EoFLXP7YxInFJRcLBM1ImzpN71m/Y+lgDqVU71rYcdiiGPv86eKLMla9Q7vBfHp4
         IuPRy+Q1YWFQ8XjQFwB5JJ1aIj6s4pcVMbwxIG4BPxDyGdDa9InoLGl34822ncmALLpb
         JaQw==
X-Gm-Message-State: AOJu0YyClGiG22Qic8vxorc4ZZv8vFqpTSlKDy/j80oviyf/Jz2SWwxz
        Nbz5m5tABA5cGQTmyXeMgm3tpqQGOeEu/lqcx6Q=
X-Google-Smtp-Source: AGHT+IF8QIsqTfTZXraFJb6Yq4Gp3Xa7Nxdbi2xU1PMbhGxb2pZmh4LhMgw0IBQC9OaGI7xahIOryH2MiQMrlJJMvBw=
X-Received: by 2002:a4a:ee94:0:b0:581:5990:dbb8 with SMTP id
 dk20-20020a4aee94000000b005815990dbb8mr4901446oob.0.1697627614027; Wed, 18
 Oct 2023 04:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231016170939.1192260-1-sunilvl@ventanamicro.com>
In-Reply-To: <20231016170939.1192260-1-sunilvl@ventanamicro.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 13:13:23 +0200
Message-ID: <CAJZ5v0hCaXxYSmjWorbM2AEoCJrJk06xCY5Fq-geM945vOE86w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: irq: Fix the incorrect return value in acpi_register_gsi()
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 7:09 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> acpi_register_gsi() should return negative value in case of failure.
> Currently, it returns the return value from irq_create_fwspec_mapping().
> However, irq_create_fwspec_mapping() returns 0 for failure. Fix the issue
> by returning -EINVAL if irq_create_fwspec_mapping() returns zero.
>
> Fixes: d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ domain mapping")
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/irq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index c2c786eb95ab..403f33df66af 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -57,6 +57,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>                       int polarity)
>  {
>         struct irq_fwspec fwspec;
> +       unsigned int rc;
>
>         fwspec.fwnode = acpi_get_gsi_domain_id(gsi);
>         if (WARN_ON(!fwspec.fwnode)) {
> @@ -68,7 +69,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>         fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
>         fwspec.param_count = 2;
>
> -       return irq_create_fwspec_mapping(&fwspec);
> +       rc = irq_create_fwspec_mapping(&fwspec);
> +       if (!rc)
> +               return -EINVAL;
> +
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(acpi_register_gsi);
>
> --

Good catch!

Applied as 6.7 material, but I renamed the new rc local variable to irq.

Thanks!
