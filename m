Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371597756D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjHIKJc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 06:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjHIKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:09:30 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5391FEA;
        Wed,  9 Aug 2023 03:09:28 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-563393b63dbso1017723eaf.1;
        Wed, 09 Aug 2023 03:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691575768; x=1692180568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lruAN6PdSL/eoPEROZtItsfiM38Gp4Ilk4urlqfchf4=;
        b=A+8wTnOmet0Q4Ng0fNGd3LSPrYxaECGV8DYH/4G9XRB+npbZptbirCCdgwOOHwXks6
         0O3mR97D4QkTtMfnVqkkVzME9vgMO5gdleqbJkseu9kylSu5yKy0HZTlVR3NwhPm6i5i
         mVuUDR59s1kk6HExwajmOjHkGmOYiM/xVaX8ptwCWEX0rbH/d/SqSStfu/rt9VgvpDGK
         SPYn4lPLcULiyM2BoT0vFL+rUtIaGtl623P4TcUt7ENK39iWpjZ0hnWT4Pbc1hOe1JVU
         LrU7KQzjtrmGzfcgE32BE3i03Ai9F3NMsy+HIabUGs8OzTfa7zEqGfDXaO5r1/RqlBoK
         6fRg==
X-Gm-Message-State: AOJu0YwnD3s52KrCqKhy+E2Qb0ZrFXPse2zMQDb4c5Dk5uHnsyhGfJw8
        4/TsQ6kuVi9GuxFmQRRyUrKmMCPerYjJ4J4y/A0=
X-Google-Smtp-Source: AGHT+IGqUrozRoTrngbi/ago/HXT8Opnwu+LlLGQ6Uh2fFDFsNkBabFIKUU4gOJxva7Nm7I8OtTPj5UbYvkhlTqZaxk=
X-Received: by 2002:a4a:a64a:0:b0:56c:484a:923d with SMTP id
 j10-20020a4aa64a000000b0056c484a923dmr2108863oom.1.1691575767899; Wed, 09 Aug
 2023 03:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230809094451.15473-1-ivan.hu@canonical.com>
In-Reply-To: <20230809094451.15473-1-ivan.hu@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Aug 2023 12:09:16 +0200
Message-ID: <CAJZ5v0hh=AccmG12iE5Y5JHOjwtDrDbLSgwY8K+QwtfBZN3N2Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: extend the acpi maximum handles for _PSL method
To:     Ivan Hu <ivan.hu@canonical.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
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

On Wed, Aug 9, 2023 at 11:44 AM Ivan Hu <ivan.hu@canonical.com> wrote:
>
> Several platforms encountered the following kernel message:
> ACPI: \_TZ_.BATZ: Invalid passive threshold
>
> This issue arises due to the failure of the acpi_evaluate_reference function
> in drivers/acpi/thermal.c while evaluating the ACPI _PSL method.
>
> status = acpi_evaluate_reference(tz->device->handle, "_PSL",
>                          NULL, &devices);
> if (ACPI_FAILURE(status)) {
>         acpi_handle_info(tz->device->handle,
>                          "Invalid passive threshold\n");
>         tz->trips.passive.valid = false;
> } else {
>         tz->trips.passive.valid = true;
> }
>
> However, the root cause lies in the _PSL method returning packages with a count
> exceeding ACPI_MAX_HANDLES in acpi_evaluate_reference.
>
> As per the ACPI specification, the _PSL (Passive List) method is defined under
> a thermal zone and evaluates to a list of processor objects to be used for
> passive cooling. And it will return a variable-length Package containing a list
> of References to processor objects.
>
> Signed-off-by: Ivan Hu <ivan.hu@canonical.com>

Please check if this patch fixes the problem for you (it may need to
be rebased):

https://patchwork.kernel.org/project/linux-acpi/patch/20230330030446.2469338-1-vi@endrift.com/

> ---
>  include/acpi/acpi_bus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 23fbe4a16972..dc7b38826113 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -13,7 +13,7 @@
>  #include <linux/property.h>
>
>  /* TBD: Make dynamic */
> -#define ACPI_MAX_HANDLES       10
> +#define ACPI_MAX_HANDLES       32
>  struct acpi_handle_list {
>         u32 count;
>         acpi_handle handles[ACPI_MAX_HANDLES];
> --
> 2.34.1
>
