Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2598C7C8C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJMRfR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:35:15 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D65A9;
        Fri, 13 Oct 2023 10:35:14 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57be74614c0so60409eaf.1;
        Fri, 13 Oct 2023 10:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218513; x=1697823313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVZ2KoSdWfm9vU181b1VE9CrcI7d4A9Y2SwYBj4ZNFQ=;
        b=eDvVh/XhjIWqrFVjybj2lC0zJ3YQMImVdd+EQO60wH2XBIbbxRzduW8w8fKUIvCAF9
         9Wnoggwzuc/WYolq9y61CvWdbnNXTORAgrQZlcsCW9kVvEqHcRpr0igMGk4L/2tIMYbl
         SWPLG8+W88p0qWUShUDkaOczGpA/nTWnZ6ACm6v9Kh5A5m83MypCBUFe3F7Bhp7zcVPJ
         DRVi/wDJ3atuTJD5/IWdir4rpMGBUvxQygzq9Q8k0zklvQyrn+h9/bogGr5I8IXy+vEV
         AGz1C6l2s+uiIAzaBS161+C8PMJfRhs/5TPQknN61T8o6b0dHWqaedoxGxLHd7zQs3Y9
         AU0A==
X-Gm-Message-State: AOJu0Yz3enznZofcAY4pGpDyio0j6VpPT9L/BCPWVhVMrfjKll2tv90N
        qjwbZ9Q4vDKdbWx4bjRzQl89ZZog/hynpi/mCf4=
X-Google-Smtp-Source: AGHT+IH3xv7V34FMwvzR1bbYcbgAU7fSJdrqQFOkjnTGDH1njPe4OVrx7RRPKcLGBYtI8xJr/hXYh1u8+rf4M0xUFRs=
X-Received: by 2002:a4a:d9d1:0:b0:581:84e9:a7ad with SMTP id
 l17-20020a4ad9d1000000b0058184e9a7admr1895451oou.1.1697218513548; Fri, 13 Oct
 2023 10:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231011083334.3987477-1-michal.wilczynski@intel.com> <20231011083334.3987477-3-michal.wilczynski@intel.com>
In-Reply-To: <20231011083334.3987477-3-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Oct 2023 19:35:02 +0200
Message-ID: <CAJZ5v0h-NCAst+pQre2kVeidE7t4N5PM2UU46LbYPsdmKDRAoQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: AC: Use string_choices API instead of
 ternary operator
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Wed, Oct 11, 2023 at 10:34 AM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Use modern string_choices API instead of manually determining the
> output using ternary operator.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/ac.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 83d45c681121..f809f6889b4a 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> +#include <linux/string_choices.h>
>  #include <linux/acpi.h>
>  #include <acpi/battery.h>
>
> @@ -243,8 +244,8 @@ static int acpi_ac_add(struct acpi_device *device)
>                 goto err_release_ac;
>         }
>
> -       pr_info("%s [%s] (%s)\n", acpi_device_name(device),
> -               acpi_device_bid(device), ac->state ? "on-line" : "off-line");
> +       pr_info("%s [%s] (%s-line)\n", acpi_device_name(device),
> +               acpi_device_bid(device), str_on_off(ac->state));
>
>         ac->battery_nb.notifier_call = acpi_ac_battery_notify;
>         register_acpi_notifier(&ac->battery_nb);
> --

Applied as 6.7 material, thanks!
