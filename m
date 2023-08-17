Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB277FC44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353709AbjHQQlV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353686AbjHQQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:41:06 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DE2724;
        Thu, 17 Aug 2023 09:41:05 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56e6544cb74so11929eaf.0;
        Thu, 17 Aug 2023 09:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692290465; x=1692895265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcKONi/m0Byj8vFv/ZPyDYdiMy7QHXeseviNKlZvIjs=;
        b=ffd4pT/bNuXLfzNSS8bb0+PENtDzblWM5iQf4NIb2tpC3zeo1paZau92Hzhk35scXX
         A1Prlj8IY65fD/gu2IstSYvQdEcmADBcqtHIPN9RNiFqCoYu5CPpIwnCrXNUAirXT9gU
         Q1EtDXe1KursuC4eNYk8iKtZSdDL6AwP1XGdMFZPYqs/212e4WP3qr0mUn2Nlt1yTkvC
         fHYIDCzAFOsKITDQjOpcVPw3H+1+t4Pn18h0d3YRSIgKUHJTdfg+qM8+IVx92D1QHKPf
         ExW0pFT9di7QC6u7g9HrKzgpTICLxw+5XazkOPmF4j/DlRhqChz3uVz84btZEMmYU8QR
         ZM5Q==
X-Gm-Message-State: AOJu0YxxiWqUZhPAq1uWG7GdTZcUvPGJzZ8pABgswf9v9aojvi/8KnXs
        1SezK4rhI6YHoPq2LhvpmNllQiaBl7U6vGCdMBDQgQuu
X-Google-Smtp-Source: AGHT+IEpfOhaLaMT2ctr2bxRLO3mnIcKLz0ypThRAax1+yKrke+9xJQZEXYF3nfRV8zz+yHDRaxmnrPvKv23JBwglwM=
X-Received: by 2002:a4a:e684:0:b0:56d:6bd4:4db5 with SMTP id
 u4-20020a4ae684000000b0056d6bd44db5mr356226oot.0.1692290464675; Thu, 17 Aug
 2023 09:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230717022258.2579631-1-maobibo@loongson.cn> <fbe94cf6-0fd0-fbb5-4308-e1730e3af214@loongson.cn>
In-Reply-To: <fbe94cf6-0fd0-fbb5-4308-e1730e3af214@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 18:40:53 +0200
Message-ID: <CAJZ5v0iU0iQR=s2Df2E8wNnSLDvTAkxGfRrBAowmLEZ9yQKRsA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor_core: LoongArch: Get physical id from
 MADT table
To:     bibo mao <maobibo@loongson.cn>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jul 25, 2023 at 2:32 AM bibo mao <maobibo@loongson.cn> wrote:
>
> slightly ping :)
>
> 在 2023/7/17 10:22, Bibo Mao 写道:
> > With ACPI Spec 6.5 chapter 5.2.12.20, each processor in LoongArch
> > system has a Core Programmable Interrupt Controller in MADT table,
> > value of its type is 0x11 in the spec and defined as enum variable
> > ACPI_MADT_TYPE_CORE_PIC in Linux kernel. Physical id can be parsed
> > from MADT table for LoongArch system, also it can be parsed from
> > MAT table for hotplug cpu. This patch adds physical id parsing for
> > LoongArch system.
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> > Changes in v2:
> >  Refresh the changelog and add detailed description of acpi spec
> >  about MADT table for LoongArch system.
> >
> >  Add comments in function map_core_pic_id.
> >
> > ---
> >  drivers/acpi/processor_core.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> > index d6606a9f2da6..7dd6dbaa98c3 100644
> > --- a/drivers/acpi/processor_core.c
> > +++ b/drivers/acpi/processor_core.c
> > @@ -132,6 +132,30 @@ static int map_rintc_hartid(struct acpi_subtable_header *entry,
> >       return -EINVAL;
> >  }
> >
> > +/*
> > + * Retrieve LoongArch CPU physical id
> > + */
> > +static int map_core_pic_id(struct acpi_subtable_header *entry,
> > +             int device_declaration, u32 acpi_id, phys_cpuid_t *phys_id)
> > +{
> > +     struct acpi_madt_core_pic *core_pic =
> > +             container_of(entry, struct acpi_madt_core_pic, header);
> > +
> > +     if (!(core_pic->flags & ACPI_MADT_ENABLED))
> > +             return -ENODEV;
> > +
> > +     /* device_declaration means Device object in DSDT, in LoongArch
> > +      * system, logical processor acpi_id is required in _UID property
> > +      * of DSDT table, so we should check device_declaration here
> > +      */
> > +     if (device_declaration && (core_pic->processor_id == acpi_id)) {
> > +             *phys_id = core_pic->core_id;
> > +             return 0;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> >  static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
> >                                  int type, u32 acpi_id)
> >  {
> > @@ -165,6 +189,9 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
> >               } else if (header->type == ACPI_MADT_TYPE_RINTC) {
> >                       if (!map_rintc_hartid(header, type, acpi_id, &phys_id))
> >                               break;
> > +             } else if (header->type == ACPI_MADT_TYPE_CORE_PIC) {
> > +                     if (!map_core_pic_id(header, type, acpi_id, &phys_id))
> > +                             break;
> >               }
> >               entry += header->length;
> >       }
> > @@ -216,6 +243,8 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
> >               map_x2apic_id(header, type, acpi_id, &phys_id);
> >       else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
> >               map_gicc_mpidr(header, type, acpi_id, &phys_id);
> > +     else if (header->type == ACPI_MADT_TYPE_CORE_PIC)
> > +             map_core_pic_id(header, type, acpi_id, &phys_id);
> >
> >  exit:
> >       kfree(buffer.pointer);
>

Sorry for the delay.

Applied (under a slightly edited subject) as 6.6 material, thanks!
