Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9FB80F70D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377103AbjLLTl4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 14:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjLLTlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:41:49 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3B8AF;
        Tue, 12 Dec 2023 11:41:54 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-590a21e977aso174118eaf.1;
        Tue, 12 Dec 2023 11:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702410114; x=1703014914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vfqgrr2N4bZxxdApuCQE48QKvGsi7ju/E6qD7nQ10wE=;
        b=LJGPoeb+gs77qvnfLw2KYmXgpKfHFTm85pl0fS2MdIev1WQ56b57CNU6h8s/0zZXFg
         3jzS8BYTddMGrsrTaBX847n7H5WsT4GSXIVYMxLsYEfDy3e3ecdsxx9biD13M5v3pJka
         aLcvbI9I5RTeiIIqM0yIOy5NwhiqEpCm5QobC4TfjZah6kV+/r4sAa59spzhQhuVYlsX
         2IKieR0DM2YVqbEAJCrTS2nPqWLPhUv+wEm1z4TpXkjfpPyNNxbIPAC77lc+eKF+cudO
         9gUYz7YjYE4klcNdRv2z9PZ6zkr5D/sjTiMmextkBwuLvfqrWciTstcFLtYX2VtMklz1
         JPbg==
X-Gm-Message-State: AOJu0YzWTT4e5ZpUV72TTu6e1sxP1omszi7w2mtk7m3G3spIEnmn7DS7
        y3NGW33/YTVl8O1SmVhLm0U1w/6aMVwPKZQHvzc=
X-Google-Smtp-Source: AGHT+IFnrB2AuJl6E+EBFsgZt7vWZC6v+u054H2VGsFoCmLmva8xwPjRPX8dNT+wl2qE/DdVr1p/WLBoqPPufmakzaQ=
X-Received: by 2002:a4a:e9ae:0:b0:591:4861:6b07 with SMTP id
 t14-20020a4ae9ae000000b0059148616b07mr721743ood.0.1702410114008; Tue, 12 Dec
 2023 11:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20231211111430.3910049-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231211111430.3910049-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 20:41:43 +0100
Message-ID: <CAJZ5v0jzS=FhZ1EKY4tEzDrg1J-8=6QKSRjaP+jQjjVArx5-_A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: LPSS: Fix the fractional clock divider flags
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Raag Jadav <raag.jadav@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Alex Vinarskis <alex.vinarskis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 12:14 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The conversion to CLK_FRAC_DIVIDER_POWER_OF_TWO_PS uses wrong flags
> in the parameters and hence miscalculates the values in the clock
> divider. Fix this by applying the flag to the proper parameter.
>
> Fixes: 82f53f9ee577 ("clk: fractional-divider: Introduce POWER_OF_TWO_PS flag")
> Reported-by: Alex Vinarskis <alex.vinarskis@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 79f4fc7d6871..6f454f61a432 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -453,8 +453,9 @@ static int register_device_clock(struct acpi_device *adev,
>                 if (!clk_name)
>                         return -ENOMEM;
>                 clk = clk_register_fractional_divider(NULL, clk_name, parent,
> +                                                     0, prv_base, 1, 15, 16, 15,
>                                                       CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
> -                                                     prv_base, 1, 15, 16, 15, 0, NULL);
> +                                                     NULL);
>                 parent = clk_name;
>
>                 clk_name = kasprintf(GFP_KERNEL, "%s-update", devname);
> --

Applied as 6.8 material, thanks!
