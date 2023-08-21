Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524A6782A53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjHUNTK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjHUNTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:19:08 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95588D1;
        Mon, 21 Aug 2023 06:19:05 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59209b12c50so13771337b3.0;
        Mon, 21 Aug 2023 06:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692623944; x=1693228744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlN4YX1GbBqtjFFK6dmiR1uEWS1S2YXDrbNvwhpYA+0=;
        b=Cn5SfbhQ4qQywI7qDelS0JxyuCM1sKg2hHmiggqKi6/FnCs1kFVNadhBnF6FVDALoK
         oPjRef+lnb7oPxP8aEZ4rIhFZ0YfEV8E2ik41+JjhC25dHuE8lGtouUWnvIZ0TE1UUjk
         JWO63swieuUyp3pH5edNE5QN7/nBHNZkjgak7DXe4dfUHDrRi+ohO6pq/0Ccj8dDuail
         U+tJ2cTwFOhXI1bSQJX6zQDCZHvp7fNGrGu2Hp2eFgfCEcbfEz+llgevoTQKbH1rZEEq
         ycXI9fgCprQmpVsOnl+Zg0ajo9yepb/YAJx7IoRtWahqOVq9eNLvXdWA9OM6nuMSvQ18
         icnA==
X-Gm-Message-State: AOJu0YwX5DgpXgNayTAaxj6UuEIXCo0tRBQm8Gdq08qEFFxTGwsFQ5wW
        jjJ3tL8weW3ZCaQ9rvVcuaA/dnf3zha/tg==
X-Google-Smtp-Source: AGHT+IHQ1BeT/AaJiadh3H/F4QLDONiKLSqbIk6vmO7yLZz8rZiNqBlLXatn11YpLi1wopPe6THl1A==
X-Received: by 2002:a0d:df92:0:b0:58c:d87b:b028 with SMTP id i140-20020a0ddf92000000b0058cd87bb028mr7828444ywe.16.1692623944630;
        Mon, 21 Aug 2023 06:19:04 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id t203-20020a815fd4000000b005777a2c356asm2205908ywb.65.2023.08.21.06.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 06:19:04 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso3257833276.0;
        Mon, 21 Aug 2023 06:19:04 -0700 (PDT)
X-Received: by 2002:a25:b9c3:0:b0:c3c:5eb1:e975 with SMTP id
 y3-20020a25b9c3000000b00c3c5eb1e975mr6423197ybj.47.1692623944352; Mon, 21 Aug
 2023 06:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org> <20230801-dt-changeset-fixes-v3-6-5f0410e007dd@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v3-6-5f0410e007dd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 15:18:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWc78KFbBiqynfTF=LrD-rOxsk8EapqzKXP4qcP2nBSXg@mail.gmail.com>
Message-ID: <CAMuHMdWc78KFbBiqynfTF=LrD-rOxsk8EapqzKXP4qcP2nBSXg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] of: Refactor node and property manipulation
 function locking
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Rob,

On Fri, Aug 18, 2023 at 10:41 PM Rob Herring <robh@kernel.org> wrote:
> All callers of __of_{add,remove,update}_property() and
> __of_{attach,detach}_node() wrap the call with the devtree_lock
> spinlock. Let's move the spinlock into the functions. This allows moving
> the sysfs update functions into those functions as well.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - Rebase due to changes in prior patch

Thanks for your patch!

> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c

> @@ -1576,37 +1587,36 @@ int __of_add_property(struct device_node *np, struct property *prop)
>   */
>  int of_add_property(struct device_node *np, struct property *prop)
>  {
> -       unsigned long flags;
>         int rc;
>
>         mutex_lock(&of_mutex);
> -
> -       raw_spin_lock_irqsave(&devtree_lock, flags);
>         rc = __of_add_property(np, prop);
> -       raw_spin_unlock_irqrestore(&devtree_lock, flags);
> -
> -       if (!rc)
> -               __of_add_property_sysfs(np, prop);
> -
>         mutex_unlock(&of_mutex);
>
> -       if (!rc)
> -               of_property_notify(OF_RECONFIG_ADD_PROPERTY, np, prop, NULL);

The notify block should be kept.

The rest LGTM, although I have some second thoughts about more
functions with a double underscore now taking devtree_lock().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
