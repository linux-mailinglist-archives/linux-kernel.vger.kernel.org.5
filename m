Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32CE7A9B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjIUS7I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 14:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjIUS6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:58:52 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD37914FD;
        Thu, 21 Sep 2023 11:52:48 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ae0df6494bso68213b6e.1;
        Thu, 21 Sep 2023 11:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322368; x=1695927168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S368RYIxIE+vfbv4FtAkq0lxjLR2QQXx+z91SUfGEkA=;
        b=JLHc4XAtJy9L4auLTrVerezSNqQGMotveQFaLVrVIkCWsNuUT9Dhi9zcff8ES3/K49
         f0CGvKT95ZsWgQU3QPMXF5WZsqrg0h4sBx0geT5N96UD9MLu/wgB9lRdECYgy8/LWxEr
         K+xrD+AWv3KK2WPYQBy5Fd56Gcmi+ZfTkXHNAD7YhywxOpmEGUIjF/wE2GrquXX2Gjdb
         XRg41Rksp/mHmGguN39HNxVsy4zFsxRdgQ3pWeAiMCqHSY7NWtNi7d2xHpjGGwNCXRF1
         fmPPOCiABCE16Aob0M29RYT+ymHN2DscukHI0PWXq0w5CUCv36Ndhj60SvfL9RpBBNMc
         x7Dg==
X-Gm-Message-State: AOJu0YxQ17+zMsY3l25fsEefcthm1FwQNR35G4hguRY6oarl5hn+DAwP
        Fc6kcmHnVdPr7+O5ZanR/BTdDwbb0z61a2KlVfnWhksj
X-Google-Smtp-Source: AGHT+IEn8NLYB0nu5g45X7aTiJystRGnaPlbDekU48JgG/maT3448p4/tZ9WQhxai3uevSrP3pklcUd3uC3Bbhpwqow=
X-Received: by 2002:a05:6808:1496:b0:3ab:8ae5:e7c6 with SMTP id
 e22-20020a056808149600b003ab8ae5e7c6mr7272698oiw.1.1695322367835; Thu, 21 Sep
 2023 11:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230831073456.1713093-1-suhui@nfschina.com>
In-Reply-To: <20230831073456.1713093-1-suhui@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Sep 2023 20:52:37 +0200
Message-ID: <CAJZ5v0gH6XF1tD7=8O1Qb8OA2U-8MOS7EiLUUN-TBOo69+qQhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: OSL: add __printf format attribute to acpi_os_vprintf
To:     Su Hui <suhui@nfschina.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 9:35 AM Su Hui <suhui@nfschina.com> wrote:
>
> With gcc and W=1 option to compile kernel, warning happends:
>
> drivers/acpi/osl.c:156:2: error:
> function ‘acpi_os_vprintf’ might be a candidate for ‘gnu_printf’
> format attribute [-Werror=suggest-attribute=format].
>
> Allow the compiler to recognize and check format strings is safer.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/acpi/osl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f725813d0cce..357f1325485d 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -149,7 +149,7 @@ void acpi_os_printf(const char *fmt, ...)
>  }
>  EXPORT_SYMBOL(acpi_os_printf);
>
> -void acpi_os_vprintf(const char *fmt, va_list args)
> +void __printf(1, 0) acpi_os_vprintf(const char *fmt, va_list args)
>  {
>         static char buffer[512];
>
> --

Applied (with some subject and changelog edits) as 6.7 material, thanks!
