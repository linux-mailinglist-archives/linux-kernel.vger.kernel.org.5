Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06EA7B7192
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbjJCTOc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 15:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:14:31 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB88E;
        Tue,  3 Oct 2023 12:14:28 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57ddba5ba84so109659eaf.0;
        Tue, 03 Oct 2023 12:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360467; x=1696965267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLnxI+9L7q2hlugZd5feFm7zHcxH+KjWd0T7wlo3ADI=;
        b=v1TVmZNx4eI341piPL9lK8D0TwkNaGEQw4A/ddwWtkyx56OaELlwBNYObszBCJ4q/C
         w3jGiZ1eBLvr/x68YP4BJ1lbkEBIOeACIgsxKbCOJ4EitUd4oLUiIF9cyi2s0st6iuKc
         2p4koZAm/8T50Fl0RDGC9sX21hY7J9wmvCypYsQgMfApraXKwJnJgj3zJtgkbQtYNEPk
         1B1Al4Vtdx2b0hVZ8u/i83hDWLuiGQnI2EDsCWGH43EFDW2XB7x0i37GaSY23WUKjFCM
         By/oNzy2BvBAmobgCiBVvr6Hzu9OPK/Bjd5JNmBB4jf7ehPdK3FK1ishQUPiytisPohK
         fQVw==
X-Gm-Message-State: AOJu0YzvQ9EKTad8POJTLKeMUgAXn+ZT9W0kqKAkuydTjZKBD1onyRkL
        /hQ/riI/LFHNl73GIEYeWlPcx+KKOz/hUp1Kr+Q=
X-Google-Smtp-Source: AGHT+IEDCjGTpWeYK5y5ChirNp8+//sSGWalh6YtnjNXarMJX525NELg/Fo1WneB/mwT/A2IVVdrn2CyBICzzkpm+9Y=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr314352ooo.0.1696360467236; Tue, 03 Oct
 2023 12:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230927195035.2174949-1-anarsoul@gmail.com>
In-Reply-To: <20230927195035.2174949-1-anarsoul@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 21:14:16 +0200
Message-ID: <CAJZ5v0gUOt3v+rsfD0D8JrHCTR_5qrp7PZxCF=0_ZVFVpg6XMQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: FPDT: properly handle invalid FPDT subtables
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Wed, Sep 27, 2023 at 9:50 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Buggy BIOSes may have invalid FPDT subtables, e.g. on my hardware:
>
> S3PT subtable:
>
> 7F20FE30: 53 33 50 54 24 00 00 00-00 00 00 00 00 00 18 01  *S3PT$...........*
> 7F20FE40: 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00  *................*
> 7F20FE50: 00 00 00 00
>
> Here the first record has zero length.
>
> FBPT subtable:
>
> 7F20FE50:             46 42 50 54-3C 00 00 00 46 42 50 54  *....FBPT<...FBPT*
> 7F20FE60: 02 00 30 02 00 00 00 00-00 00 00 00 00 00 00 00  *..0.............*
> 7F20FE70: 2A A6 BC 6E 0B 00 00 00-1A 44 41 70 0B 00 00 00  **..n.....DAp....*
> 7F20FE80: 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00  *................*
>
> And here FBPT table has FBPT signature repeated instead of the first
> record.
>
> Current code will be looping indefinitely due to zero length records, so
> break out of the loop if record length is zero.
>
> While we are here, add proper handling for fpdt_process_subtable()
> failures.
>
> Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: return error from fpdt_process_subtable() if zero-length record is
> found and handle fpdt_process_subtable() failures
>
>  drivers/acpi/acpi_fpdt.c | 42 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index a2056c4c8cb7..c97c6e3936cc 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -194,12 +194,19 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
>                 record_header = (void *)subtable_header + offset;
>                 offset += record_header->length;
>
> +               if (!record_header->length) {
> +                       pr_err(FW_BUG "Zero-length record found.\n");
> +                       result = -EINVAL;
> +                       goto err;
> +               }
> +
>                 switch (record_header->type) {
>                 case RECORD_S3_RESUME:
>                         if (subtable_type != SUBTABLE_S3PT) {
>                                 pr_err(FW_BUG "Invalid record %d for subtable %s\n",
>                                      record_header->type, signature);
> -                               return -EINVAL;
> +                               result = -EINVAL;
> +                               goto err;
>                         }
>                         if (record_resume) {
>                                 pr_err("Duplicate resume performance record found.\n");
> @@ -208,7 +215,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
>                         record_resume = (struct resume_performance_record *)record_header;
>                         result = sysfs_create_group(fpdt_kobj, &resume_attr_group);
>                         if (result)
> -                               return result;
> +                               goto err;
>                         break;
>                 case RECORD_S3_SUSPEND:
>                         if (subtable_type != SUBTABLE_S3PT) {
> @@ -223,13 +230,14 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
>                         record_suspend = (struct suspend_performance_record *)record_header;
>                         result = sysfs_create_group(fpdt_kobj, &suspend_attr_group);
>                         if (result)
> -                               return result;
> +                               goto err;
>                         break;
>                 case RECORD_BOOT:
>                         if (subtable_type != SUBTABLE_FBPT) {
>                                 pr_err(FW_BUG "Invalid %d for subtable %s\n",
>                                      record_header->type, signature);
> -                               return -EINVAL;
> +                               result = -EINVAL;
> +                               goto err;
>                         }
>                         if (record_boot) {
>                                 pr_err("Duplicate boot performance record found.\n");
> @@ -238,7 +246,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
>                         record_boot = (struct boot_performance_record *)record_header;
>                         result = sysfs_create_group(fpdt_kobj, &boot_attr_group);
>                         if (result)
> -                               return result;
> +                               goto err;
>                         break;
>
>                 default:
> @@ -247,6 +255,16 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
>                 }
>         }
>         return 0;
> +
> +err:
> +       if (record_boot)
> +               sysfs_remove_group(fpdt_kobj, &boot_attr_group);
> +       if (record_suspend)
> +               sysfs_remove_group(fpdt_kobj, &suspend_attr_group);
> +       if (record_resume)
> +               sysfs_remove_group(fpdt_kobj, &resume_attr_group);
> +
> +       return result;
>  }
>
>  static int __init acpi_init_fpdt(void)
> @@ -255,6 +273,7 @@ static int __init acpi_init_fpdt(void)
>         struct acpi_table_header *header;
>         struct fpdt_subtable_entry *subtable;
>         u32 offset = sizeof(*header);
> +       int result;
>
>         status = acpi_get_table(ACPI_SIG_FPDT, 0, &header);
>
> @@ -263,8 +282,8 @@ static int __init acpi_init_fpdt(void)
>
>         fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
>         if (!fpdt_kobj) {
> -               acpi_put_table(header);
> -               return -ENOMEM;
> +               result = -ENOMEM;
> +               goto err_nomem;
>         }
>
>         while (offset < header->length) {
> @@ -272,8 +291,10 @@ static int __init acpi_init_fpdt(void)
>                 switch (subtable->type) {
>                 case SUBTABLE_FBPT:
>                 case SUBTABLE_S3PT:
> -                       fpdt_process_subtable(subtable->address,
> +                       result = fpdt_process_subtable(subtable->address,
>                                               subtable->type);
> +                       if (result)
> +                               goto err_subtable;
>                         break;
>                 default:
>                         /* Other types are reserved in ACPI 6.4 spec. */
> @@ -282,6 +303,11 @@ static int __init acpi_init_fpdt(void)
>                 offset += sizeof(*subtable);
>         }
>         return 0;
> +err_subtable:
> +       kobject_put(fpdt_kobj);
> +err_nomem:
> +       acpi_put_table(header);
> +       return result;
>  }
>
>  fs_initcall(acpi_init_fpdt);
> --

Applied (with some minor tweaks) as 6.7 material, thanks!
