Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E616F807923
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442855AbjLFUIC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 15:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379461AbjLFUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:08:01 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9618D;
        Wed,  6 Dec 2023 12:08:06 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1fb2b83986cso37931fac.0;
        Wed, 06 Dec 2023 12:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893285; x=1702498085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOU+dMGimpnkd9aD0uyRbkl6NBIKgBfPHss6q3A/RKc=;
        b=hv5tTc8n6ucb6RG4DB2/frEaAJ1cwMRJMgcP3EehSlg42X1N3nFWw2RHC+3D2zzLsh
         W5rrTuBWabs+LBAnL7fH8TVBcuztZFF3Be3wCCyyk5Y8rv6N9Mcv5IDT6vZTEZMn9Kw8
         q3GhpuAJNW+v28BWxPYdXXt2EpJ0J7W5L8o40K8ks34GF3f2IKXBzZ0MBc9s0cKVlJAx
         21hvDBhB+YGJyuImsfNtJwnOlTyOTqKVoUXJhKaLM0gdisOJh7gbFMPmoOCs1UGLRHxA
         +P1wdaN1J1IEqfxHiwOgQvzEVuRvQXrbatkSIktglg5ZGdir1hiHPKolhQP2oT9Vxfgz
         8UHw==
X-Gm-Message-State: AOJu0Yw3lOXP/5qII0L39CXJtkovoDoJEhOMIB80ubgjl3ORNot7/sgh
        46kGo0t8NZGMC8ZgzHDsSIxP7ZnzeyEwGiVDK7A=
X-Google-Smtp-Source: AGHT+IHpuR7c+DdGHDSzgiRkNb8ETV+06EtkYa3tgv53h1rm7QnyhmlcCPKUIrI2YiFz3Oge8UaTAjhdeZj35DrMoQo=
X-Received: by 2002:a05:6870:2112:b0:1fb:25fb:fabc with SMTP id
 f18-20020a056870211200b001fb25fbfabcmr2701649oae.5.1701893285575; Wed, 06 Dec
 2023 12:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20231129081355.32317-1-liuhaoran14@163.com>
In-Reply-To: <20231129081355.32317-1-liuhaoran14@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 21:07:54 +0100
Message-ID: <CAJZ5v0jbhiGgw-vyGyQCTJe0bL67-c1d_qggkZC-vqnA8UsrbA@mail.gmail.com>
Subject: Re: [PATCH] [ACPI] fan_core: Add error handling for acpi_driver_data
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 9:14 AM Haoran Liu <liuhaoran14@163.com> wrote:
>
> This patch introduces error handling for the acpi_driver_data call
> in function acpi_fan_get_fif and acpi_fan_get_fps, within
> drivers/acpi/fan_core.c. Previously, there was no check for a null
> return from acpi_driver_data, which could lead to potential
> instability in scenarios where acpi_driver_data fails.

This needs to explain why/how it is possible for acpi_driver_data() to
return NULL in the 2 places modified by the patch.

> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/acpi/fan_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 9dccbae9e8ea..f3228fb9c90f 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -215,6 +215,13 @@ static int acpi_fan_get_fif(struct acpi_device *device)
>  {
>         struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>         struct acpi_fan *fan = acpi_driver_data(device);
> +
> +       if (!fan) {
> +               dev_err(&device->dev, "No ACPI fan data associated "
> +                       "with the device\n");
> +               return -EINVAL;
> +       }
> +
>         struct acpi_buffer format = { sizeof("NNNN"), "NNNN" };
>         u64 fields[4];
>         struct acpi_buffer fif = { sizeof(fields), fields };
> @@ -265,6 +272,12 @@ static int acpi_fan_speed_cmp(const void *a, const void *b)
>  static int acpi_fan_get_fps(struct acpi_device *device)
>  {
>         struct acpi_fan *fan = acpi_driver_data(device);
> +
> +       if (!fan) {
> +               dev_err(&device->dev, "Failed to retrieve ACPI fan data\n");
> +               return -ENODEV;
> +       }
> +
>         struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>         union acpi_object *obj;
>         acpi_status status;
> --
> 2.17.1
>
