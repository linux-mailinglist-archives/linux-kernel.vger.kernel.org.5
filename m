Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AA07CDA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjJRLbe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjJRLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:31:33 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01A5111;
        Wed, 18 Oct 2023 04:31:31 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c6591642f2so1577870a34.1;
        Wed, 18 Oct 2023 04:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628691; x=1698233491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHentBHE/DrtRzr1LJu3KtjR8Xr3ccerMFpUqr2z4BQ=;
        b=AcWR8OW0qTzDBZze3vH7HoLMm+nd4zo8Rk1QFBqAI1J8oy3NVUCs9ce/rzjP/oA/gk
         y6XOQWIGDdH7nQbUQMcpE/37kDm50/lbGi7W6U52G7heS2JcqGqYEIZG1zJqQr+YLd6x
         TDrVlU9MAWuY4BkcBCbb1M2nwB40ND5yguHHwO5Vrp5bLSlR5PrEIH6EOIF+h21IIhbX
         IT7y4aD+KK6vo4Tb7SbubW8tsJs93o/bdYqrxRi8BTLOTUWCkgNTv7HKyEn+/RPa4qPc
         S7Or6Qh/iYS7hamQ7ov9oFBCZ1xCttooj3g/s3TwGVbx8gsjwLshqm4SrpqostvYoHft
         BPqg==
X-Gm-Message-State: AOJu0Yy4aDDdr+GrufSx0ey9epvrU3kczaJRLLPFzOTOprSEJvw4RUXn
        xw2tUmrCWTjDwFtsmlG5YgBcFvTPZbOPgaLcSa8=
X-Google-Smtp-Source: AGHT+IEWNgwxgiAwoitCnD04CiK/3JY1UQabRaWJAqFubO1cNSbJEIp0jD/RkyiUovK6zf16xE5r54Jykv/SNqjTMbU=
X-Received: by 2002:a4a:b304:0:b0:581:d5df:9cd2 with SMTP id
 m4-20020a4ab304000000b00581d5df9cd2mr4509936ooo.0.1697628691098; Wed, 18 Oct
 2023 04:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231016170939.1192260-1-sunilvl@ventanamicro.com> <CAJZ5v0hCaXxYSmjWorbM2AEoCJrJk06xCY5Fq-geM945vOE86w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hCaXxYSmjWorbM2AEoCJrJk06xCY5Fq-geM945vOE86w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 13:31:20 +0200
Message-ID: <CAJZ5v0g29Gh4JmKkheqkF5MrnbHefq=KVm=ccxHT4+A99LpVfg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: irq: Fix the incorrect return value in acpi_register_gsi()
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
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

On Wed, Oct 18, 2023 at 1:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Oct 16, 2023 at 7:09 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > acpi_register_gsi() should return negative value in case of failure.
> > Currently, it returns the return value from irq_create_fwspec_mapping().
> > However, irq_create_fwspec_mapping() returns 0 for failure. Fix the issue
> > by returning -EINVAL if irq_create_fwspec_mapping() returns zero.
> >
> > Fixes: d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ domain mapping")
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/acpi/irq.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> > index c2c786eb95ab..403f33df66af 100644
> > --- a/drivers/acpi/irq.c
> > +++ b/drivers/acpi/irq.c
> > @@ -57,6 +57,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
> >                       int polarity)
> >  {
> >         struct irq_fwspec fwspec;
> > +       unsigned int rc;
> >
> >         fwspec.fwnode = acpi_get_gsi_domain_id(gsi);
> >         if (WARN_ON(!fwspec.fwnode)) {
> > @@ -68,7 +69,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
> >         fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> >         fwspec.param_count = 2;
> >
> > -       return irq_create_fwspec_mapping(&fwspec);
> > +       rc = irq_create_fwspec_mapping(&fwspec);
> > +       if (!rc)
> > +               return -EINVAL;
> > +
> > +       return rc;
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_register_gsi);
> >
> > --
>
> Good catch!
>
> Applied as 6.7 material, but I renamed the new rc local variable to irq.
>
> Thanks!

Actually, I'm going to push this for -rc7.
