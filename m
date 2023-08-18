Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D03780F56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378227AbjHRPhA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378290AbjHRPgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:36:54 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43114486;
        Fri, 18 Aug 2023 08:36:39 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58c5642701fso10694797b3.0;
        Fri, 18 Aug 2023 08:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372998; x=1692977798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9AXPzldZmE7nVYO/NeTZiuKawvhGBVFZgya8X30Oeo=;
        b=DCAIIDkIT2FLCJfO1UeXany5o5Ey1CIufqN74metmrBTVnwGI7EYqv14Tf5n39wqCl
         ByCPMruDFcjokOtX2/yEl0OMORzeNo6ij/hnEKRbdW8SRN8PAQ5bypTPMXmZBbt3VwCu
         hU50KISEJQUFjCLXbnWNtu5bnfZJcz71EB6uVhFnrsiMnnbDnq8iAGZy1Md07kxO3nPQ
         ri9IcSsFQWQLS7BKJHd4rTk0fwwCaJjjTL4POyjWRUw1b5tQh2+s+ilW7cfmy+6iS/QO
         eMOd34WLLy6KYe2xSvctTUjLpbLhm7d7oL0Mq0eoWPcMOiNSnAZXN7zNOjWXmQAC76jH
         1lqQ==
X-Gm-Message-State: AOJu0YwALQQAexBlvWsGTKrw5iK6fcz9vDXKCboFYK2EEbd8ZmD0LG43
        DJz/USqna4tYsRsi4mFFXIISYWLAJqCv+t8g
X-Google-Smtp-Source: AGHT+IH9r148FYTAuPC1zMmlcAMMH2ul4XmMsCqTt6O/wOil+dtsLwbZsuDOjHnTtcuLmQq/8ZEKlA==
X-Received: by 2002:a81:5346:0:b0:58c:53ad:ee3f with SMTP id h67-20020a815346000000b0058c53adee3fmr2778515ywb.34.1692372998594;
        Fri, 18 Aug 2023 08:36:38 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c13-20020a814e0d000000b0058c668e46cbsm501347ywb.46.2023.08.18.08.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 08:36:38 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso1034079276.0;
        Fri, 18 Aug 2023 08:36:37 -0700 (PDT)
X-Received: by 2002:a25:e087:0:b0:d12:77c7:b362 with SMTP id
 x129-20020a25e087000000b00d1277c7b362mr3123378ybg.26.1692372997759; Fri, 18
 Aug 2023 08:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org> <20230801-dt-changeset-fixes-v2-2-c2b701579dee@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v2-2-c2b701579dee@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 17:36:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4gqPLv5ZWiWe-B+bQtHSfF9AxZTKWisFZEKa29Ge2KQ@mail.gmail.com>
Message-ID: <CAMuHMdX4gqPLv5ZWiWe-B+bQtHSfF9AxZTKWisFZEKa29Ge2KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
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

On Sat, Aug 5, 2023 at 12:42 AM Rob Herring <robh@kernel.org> wrote:
> While originally it was fine to format strings using "%pOF" while
> holding devtree_lock, this now causes a deadlock.  Lockdep reports:
>
>     of_get_parent from of_fwnode_get_parent+0x18/0x24
>     ^^^^^^^^^^^^^
>     of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
>     fwnode_count_parents from fwnode_full_name_string+0x18/0xac
>     fwnode_full_name_string from device_node_string+0x1a0/0x404
>     device_node_string from pointer+0x3c0/0x534
>     pointer from vsnprintf+0x248/0x36c
>     vsnprintf from vprintk_store+0x130/0x3b4
>
> Fix this by moving the printing in __of_changeset_entry_apply() outside
> the lock. As the only difference in the the multiple prints is the
> action name, use the existing "action_names" to refactor the prints into
> a single print.
>
> Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v5 (v2 in this series):
>  - Move majority of refactoring to separate patch and minimize the fix
>    to just moving the print out of the locked section.

Thanks for your patch!

> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c

> @@ -648,20 +634,17 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
>                 }
>
>                 ret = __of_update_property(ce->np, ce->prop, &old_prop);
> -               if (ret) {
> -                       pr_err("changeset: update_property failed @%pOF/%s\n",
> -                               ce->np,
> -                               ce->prop->name);
> -                       break;
> -               }
>                 break;
>         default:
>                 ret = -EINVAL;
>         }
>         raw_spin_unlock_irqrestore(&devtree_lock, flags);
>
> -       if (ret)
> +       if (ret) {
> +               pr_err("changeset: apply failed: cset<%p> %-15s %pOF:%s\n",

Printing the cset pointer will (needlessly?) complicate the EXPECT_*()
handling in the unit test.

> +                      ce, action_names[ce->action], ce->np, ce->prop->name);

This should check ce->action to avoid an out-of-bounds access beyond
the end of action_names[].

>                 return ret;
> +       }
>
>         switch (ce->action) {
>         case OF_RECONFIG_ATTACH_NODE:

The rest LGTM to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
