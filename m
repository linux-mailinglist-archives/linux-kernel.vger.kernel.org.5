Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7560578E991
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbjHaJfl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 05:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjHaJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:35:40 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60361CDD;
        Thu, 31 Aug 2023 02:35:37 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5733d11894dso147846eaf.0;
        Thu, 31 Aug 2023 02:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693474536; x=1694079336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1zXFq6yH7gKwLUxTi+5zNAwg8QTKD31cnvIQY4Ezq4=;
        b=MdQZEA+QRH/2YwCpiwqPxcVTSPPPiY85nOMb4Fwr0eYW7x4rDUa4cny7IQL1FwfDIx
         qwNjRICZRVRNrw6kZHatEI6UlP21bSmSduWGTiCMPWBJem1QEVXu3RibF8Gi1N9Cm/86
         /NIp/il3aQ2lwmaqpN0vad6I+pwYDkn/pYVTU7xWPXYiG4ZptLPdB1vgma5tDlnq2xYX
         lB5rZq2kVOM3Q6FW/KB9n/s7TMB5JEF/S7PBDsX+LEWgZk2Q8D1ny/hjhA2RaCQCnP1d
         ZknscjsER6+Vs80bzK/AfgwtpBArS0i+fySahEV+sbB+ZNs0g4anG0g8Jittv5J8djHv
         XUBg==
X-Gm-Message-State: AOJu0YxYKMAVltPBnOC+qC+D73oz6b3CgYmbRDTSypk6xnMs1OZQCYuP
        gEMtWKjcGsvpZ5qMN5qjUjvWztpl1ka//o4bPAbpZI+gZhw=
X-Google-Smtp-Source: AGHT+IGs+OAQkyf1C22XbnDRZlpFQWeSdCYSJR8ugVMflKZNJqiA0hEKd6f20IUpQWn0zmZLVycO62nGOrz+psrh70U=
X-Received: by 2002:a4a:a302:0:b0:573:764b:3b8d with SMTP id
 q2-20020a4aa302000000b00573764b3b8dmr4332395ool.0.1693474536546; Thu, 31 Aug
 2023 02:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230831073432.1712904-1-suhui@nfschina.com>
In-Reply-To: <20230831073432.1712904-1-suhui@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Aug 2023 11:35:24 +0200
Message-ID: <CAJZ5v0iBZhz6oRgzU3_E+TFT244cgcWxS5ufo_8LnsgvrbbTJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPICA: Use strscpy to replace strncpy
To:     Su Hui <suhui@nfschina.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
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

On Thu, Aug 31, 2023 at 9:35 AM Su Hui <suhui@nfschina.com> wrote:
>
> With gcc and W=1 option to compile kernel, warning happens:
>
> inlined from ‘acpi_tb_find_table’ at drivers/acpi/acpica/tbfind.c:60:2:
> include/linux/fortify-string.h:68:30: error: ‘__builtin_strncpy’ specified
> bound 6 equals destination size [-Werror=stringop-truncation]
>
> Use strscpy to avoid this warning and is safer.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>

Please see

https://lore.kernel.org/linux-acpi/202308241612.DFE4119@keescook/

> ---
>  drivers/acpi/acpica/tbfind.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
> index 1c1b2e284bd9..5536d1755188 100644
> --- a/drivers/acpi/acpica/tbfind.c
> +++ b/drivers/acpi/acpica/tbfind.c
> @@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
>
>         memset(&header, 0, sizeof(struct acpi_table_header));
>         ACPI_COPY_NAMESEG(header.signature, signature);
> -       strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> -       strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
> +       strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> +       strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
>
>         /* Search for the table */
>
> --
> 2.30.2
>
