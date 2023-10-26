Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59B67D7D10
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjJZGxW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:53:21 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD9129;
        Wed, 25 Oct 2023 23:53:18 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4a13374a1e8so266471e0c.1;
        Wed, 25 Oct 2023 23:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698303198; x=1698907998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0YdPMIyfnoGVa7CnoW2bpfQIBO0dVpufU1sOTZCxTs=;
        b=YdA9MgUSkfg1Azp8CZ4zyI68+0Ng5s7/TfZdSDWa+DCiLS1/un9HY4hqg11hz4XaU0
         0rJ7RjBNqIy7bHUvs43YthOQg/TOtIXt/qjv9Iqm0640Ab71DyD8bPJwZ1EAiwC5wKHx
         EGpwzygM4Ha+nwqu4JPrLGY1ctmVQYbOxddalIPPFkXMfRLnQlVdYjEjBQo+o2qyfsNr
         QTy+H1gUUcPm4cN3RGGDHw5Hl+CvW58xKyICZmf0+RSOt1i5QHUf3pmrdR2khk509Ddn
         DwE1QER0Ini7wlFk3012ugTjSR7Fvw0nVpo2efsBJhJ+UuW9LKUPY+88m5+KI8D/J75i
         5+xA==
X-Gm-Message-State: AOJu0YzH+1utk5VN2uC7UJI0ozHGYut5Big96a68PDCkswyFm2PD32m7
        yGi3sJl5TqFzI8GBoC6rAw8s8Tc+8Hnkew==
X-Google-Smtp-Source: AGHT+IEnaZEhVObeAshi3SeoWHTZEa6cWe6m9aDeyaups8gL4sKhoOs93DMQGGnvaA5NrvnYkZ7TdA==
X-Received: by 2002:a1f:a217:0:b0:49c:79f3:27a4 with SMTP id l23-20020a1fa217000000b0049c79f327a4mr15934012vke.3.1698303197796;
        Wed, 25 Oct 2023 23:53:17 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id w194-20020a8149cb000000b00586108dd8f5sm5771593ywa.18.2023.10.25.23.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 23:53:17 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso379492276.2;
        Wed, 25 Oct 2023 23:53:16 -0700 (PDT)
X-Received: by 2002:a25:81c6:0:b0:da0:4c63:f648 with SMTP id
 n6-20020a2581c6000000b00da04c63f648mr6168290ybm.6.1698303196340; Wed, 25 Oct
 2023 23:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231026063941.1882023-1-peng.fan@oss.nxp.com>
In-Reply-To: <20231026063941.1882023-1-peng.fan@oss.nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Oct 2023 08:53:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUA_OOvQmkZXn21pxC=nTw6wHQZp1P8mNjTca65+KjxAQ@mail.gmail.com>
Message-ID: <CAMuHMdUA_OOvQmkZXn21pxC=nTw6wHQZp1P8mNjTca65+KjxAQ@mail.gmail.com>
Subject: Re: [PATCH] clk: clk-conf: bypass setting rate/parent if already same
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, abelvesa@kernel.org, mturquette@baylibre.com,
        clement.leger@bootlin.com, sudeep.holla@arm.com,
        cristian.marussi@arm.com, kernel@pengutronix.de,
        pure.logic@nexus-software.ie, a.fatoum@pengutronix.de,
        aford173@gmail.com, absahu@codeaurora.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Thu, Oct 26, 2023 at 8:35 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> If the original rate and parent is already the same as what users
> wanna to configure through assigned clock rate and parent, there
> is no need to configure them again which may cause more cpu cycles
> or more SCMI RPC calls.
>
> So check the rate and parent first, and bypass when the original
> rate and parent are same as requested by device tree node.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks for your patch!

> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -65,7 +65,11 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
>                         goto err;
>                 }
>
> -               rc = clk_set_parent(clk, pclk);
> +               if (__clk_get_hw(pclk) != __clk_get_hw(clk_get_parent(clk)))
> +                       rc = clk_set_parent(clk, pclk);
> +               else
> +                       rc = 0;

The else branch is not needed, as rc already indicates a non-error
condition.

> +
>                 if (rc < 0)
>                         pr_err("clk: failed to reparent %s to %s: %d\n",
>                                __clk_get_name(clk), __clk_get_name(pclk), rc);
> @@ -112,7 +116,10 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
>                                 return PTR_ERR(clk);
>                         }
>
> -                       rc = clk_set_rate(clk, rate);
> +                       if (clk_get_rate(clk) != rate)
> +                               rc = clk_set_rate(clk, rate);
> +                       else
> +                               rc = 0;

Likewise.

>                         if (rc < 0)
>                                 pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n",
>                                        __clk_get_name(clk), rate, rc,

However, one can wonder whether this check should be done in
clk_set_parent() resp. clk_set_rate() instead, so it would benefit
all callers?

Also:

    /**
     * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
     *                This is only valid once the clock source has been enabled.
     * @clk: clock source
     */

So at least the second part is not guaranteed to work?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
