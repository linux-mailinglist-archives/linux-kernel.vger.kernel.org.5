Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C724F752711
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjGMPaL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjGMP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:29:12 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9830EF;
        Thu, 13 Jul 2023 08:28:49 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b838dbb3d0so31791fa.0;
        Thu, 13 Jul 2023 08:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262127; x=1691854127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7LJojRLRLATowLcMM86EnUJ055nNQbp52MryneqIq0=;
        b=jPF6ts9Fwn7LJVxk+yFm4RK/nydoMpDu3/hJpp9J+EfhvThRNe5+lr7WRTMrTHLyJ1
         4mYPaWnTS9MIJ4FifPTw4KrpdrglxaLEA1LSeiEIVYQjbxhRSsBK5qr9JaWNDgrxdVsp
         x9miOuNYR4XOW1F3EYENCFwbwFQ77B3YU/YP7sd0S6gGPOhCOGKNQIp9cZTU6h6LmbaM
         1UHOWi65lq6Uj0pu6Kgl/a09QAbUWh3ooE2IDIV5p9rGpnxaNi8pWYbTE04gyTYfGxw8
         uFy177ZUa1G0K30N1wZwB3er2z5Tl9M/2NOz/Fd0DTae/cTZoAz5Ovmq1HYKBTgVRHul
         aKmA==
X-Gm-Message-State: ABy/qLYWBAifTPGXv4da4kJ5W416h/31D/5LlJlt8lCQemEfd0pJWoFU
        318sBthCWtDh1+FEIj6/Tjx4hoy7AmXzxO9DWEx0ikS+oLI=
X-Google-Smtp-Source: APBJJlEMGDUVjcFAVDO9KEsO9uXaPtxei9or7qSbCTezqjjcv62UHPaAY3UTK/adigW/Dw3D1nxl67NeiLGjeOJAi2o=
X-Received: by 2002:a05:651c:2104:b0:2b6:b9ee:a7b1 with SMTP id
 a4-20020a05651c210400b002b6b9eea7b1mr1906847ljq.5.1689262127320; Thu, 13 Jul
 2023 08:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230710063340.1716007-1-maobibo@loongson.cn>
In-Reply-To: <20230710063340.1716007-1-maobibo@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jul 2023 17:28:35 +0200
Message-ID: <CAJZ5v0h8Bw9kS0tq8S1KJKZ+TW1xBSn=YhZXXjQuso2ydJjm_A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor_core: LoongArch: Get physical id from
 MADT table
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 8:33 AM Bibo Mao <maobibo@loongson.cn> wrote:
>
> With ACPI Spec 6.5 physical id can be parsed from MADT table for
> LoongArch system, also it can be used in MAT table for cpu hotplug
> stage. This patch adds physical id parsing for LoongArch system.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/acpi/processor_core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index d6606a9f2da6..51239cd2a485 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -132,6 +132,26 @@ static int map_rintc_hartid(struct acpi_subtable_header *entry,
>         return -EINVAL;
>  }
>
> +/*
> + * Retrieve LoongArch CPU physical id
> + */
> +static int map_core_pic_id(struct acpi_subtable_header *entry,
> +               int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
> +{
> +       struct acpi_madt_core_pic *core_pic =
> +               container_of(entry, struct acpi_madt_core_pic, header);
> +
> +       if (!(core_pic->flags & ACPI_MADT_ENABLED))
> +               return -ENODEV;
> +
> +       if (device_declaration && (core_pic->processor_id == acpi_id)) {
> +               *apic_id = core_pic->core_id;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
>                                    int type, u32 acpi_id)
>  {
> @@ -165,6 +185,9 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
>                 } else if (header->type == ACPI_MADT_TYPE_RINTC) {
>                         if (!map_rintc_hartid(header, type, acpi_id, &phys_id))
>                                 break;
> +               } else if (header->type == ACPI_MADT_TYPE_CORE_PIC) {
> +                       if (!map_core_pic_id(header, type, acpi_id, &phys_id))

Is ACPI_MADT_TYPE_CORE_PIC specific to LoongArch?  The changelog
should mention it if that's the case.

> +                               break;
>                 }
>                 entry += header->length;
>         }
> @@ -216,6 +239,8 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>                 map_x2apic_id(header, type, acpi_id, &phys_id);
>         else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
>                 map_gicc_mpidr(header, type, acpi_id, &phys_id);
> +       else if (header->type == ACPI_MADT_TYPE_CORE_PIC)
> +               map_core_pic_id(header, type, acpi_id, &phys_id);
>
>  exit:
>         kfree(buffer.pointer);
> --
> 2.27.0
>
