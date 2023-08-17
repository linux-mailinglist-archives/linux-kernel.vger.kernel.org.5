Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A028777FD21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353824AbjHQRkc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354059AbjHQRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:40:06 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296C3581;
        Thu, 17 Aug 2023 10:40:04 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56cae50792fso16027eaf.1;
        Thu, 17 Aug 2023 10:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294003; x=1692898803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFxiQ2m+6cW+GOh7phG4Yhq5aaTkgOtH7GPedvSmphs=;
        b=kfOJsBksfUPfHPRjF7mTroCSHQ91NCTdgIMflUE1nVQ71UIPIpsAdiZXkEzL2DF8KN
         vn/pnhwMy7kgiIw5qXeblH5b9LMn+nWK0oaXsFhVf+lMhiNns24yd7jcE0Rdy1RifVgY
         xUSYdiZhDsNietyIjWnbPwk31k2qS65WhxC/Il8cFtvGugHq9jws3EpDZhhK6lvanE14
         w385mtimFJ/Q3Wc7HRqwluK1qPNNNRl0wly2cnWFA/jDgmf/ITSrQJ61NS+esVAZlojo
         SZrLupv7mzRhApPN57WTRGVQM+w2qQaOE5a2TZ+fGhzaxwWf0E0KDrtIEjRf7vo4won6
         G3IA==
X-Gm-Message-State: AOJu0Yx4+ZlBkCoQ6fd5GjFwZ+siLj1wkbz7+R6OXCJkQr7B0k2Slg3q
        6vJyJwbrqFadElSOdjf2EXxQiwXclCY/4nzTAt8=
X-Google-Smtp-Source: AGHT+IHofVobBDAIkQf95t4NTpGFRNeI0FQHifx+PC0IjGHYligki3ZG9sFys5q6WwSvM09To3FdhBRazDzSglyAOBE=
X-Received: by 2002:a4a:e684:0:b0:56d:6bd4:4db5 with SMTP id
 u4-20020a4ae684000000b0056d6bd44db5mr540208oot.0.1692294003217; Thu, 17 Aug
 2023 10:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230725052925.1712680-1-sunilvl@ventanamicro.com>
In-Reply-To: <20230725052925.1712680-1-sunilvl@ventanamicro.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:39:52 +0200
Message-ID: <CAJZ5v0icCBBvR1WXUh1qKMC-Uqie-PaoaE4gMULdmUMKNzJZ_A@mail.gmail.com>
Subject: Re: [PATCH] PNP/ACPI: Fix string truncation warning
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
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

On Tue, Jul 25, 2023 at 7:29 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> LKP reports below warning when building for RISC-V.
>
> drivers/pnp/pnpacpi/core.c:253:17:
> warning: 'strncpy' specified bound 50 equals destination
> size [-Wstringop-truncation]
>
> This appears like a valid issue since the destination
> string may not be null-terminated. To fix this, append
> the NUL explicitly after the strncpy.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307241942.Rff2Nri5-lkp@intel.com/
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/pnp/pnpacpi/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index 38928ff7472b..6ab272c84b7b 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -254,6 +254,9 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
>         else
>                 strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
>
> +       /* Handle possible string truncation */
> +       dev->name[sizeof(dev->name) - 1] = '\0';
> +
>         if (dev->active)
>                 pnpacpi_parse_allocated_resource(dev);
>
> --

Applied as 6.6 material, thanks!
