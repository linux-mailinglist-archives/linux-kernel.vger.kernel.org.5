Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6BF78289D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjHUMJ6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 08:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjHUMJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:09:57 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9881EA;
        Mon, 21 Aug 2023 05:09:53 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-58fb73e26a6so21780737b3.1;
        Mon, 21 Aug 2023 05:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619793; x=1693224593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FZHPyft/+sY1fQX8QQlFOV640RABw9ahBxyarwzqDM=;
        b=MyjlL9lYw/BsufA12XsDed1QSm24w8MJYdLxQiP6RZn5Y55SUmQTbJeZ8oVBT7GFdB
         n6DF5uA3WdjP3Hfyue6O7EpE49jeERsmj+jXN9o5p6N2m35a/HBWTGw2hHUtwiKe+2pG
         pcC1YTdSCVM+6ANnyi2ap7X4viX0Zg7vnJximTzVy7XN1DAIpwVzzhIPVlE2Plv7mVjb
         TRUMnHyl/87XgEV6+IsnE0VVtN83xrTr9qgykgJoukBSQYrbF70TRTDNSq9+PQ8lrJZr
         DGYCYeGIYxclns7+w496CS+b4LN7j0jxUZxhAOeezOmqVO7UbbSDO8bdIiQKpT+TXV5a
         Xg+g==
X-Gm-Message-State: AOJu0YyFGeaT+OTLX21SNjo732j2bsO6vfU2GszY1/epXmVyqK0nEEkA
        khRaEwqcCUD75uem1idpeVkkgWomOgBWag==
X-Google-Smtp-Source: AGHT+IFFtxtePuwgkPDT8NcVZN61W+p4zcerz+PW/cjSOmpmVZS9cXLxY8FBiS7dT1OnVQxrl7iHyw==
X-Received: by 2002:a25:aa26:0:b0:d43:9eae:52b8 with SMTP id s35-20020a25aa26000000b00d439eae52b8mr6867095ybi.10.1692619792821;
        Mon, 21 Aug 2023 05:09:52 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id v17-20020a259111000000b00d74b8fa3497sm506816ybl.20.2023.08.21.05.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:09:52 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d7485d37283so1619177276.1;
        Mon, 21 Aug 2023 05:09:51 -0700 (PDT)
X-Received: by 2002:a25:c5c1:0:b0:d47:30a5:2f01 with SMTP id
 v184-20020a25c5c1000000b00d4730a52f01mr7643322ybe.13.1692619791525; Mon, 21
 Aug 2023 05:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org> <20230801-dt-changeset-fixes-v3-3-5f0410e007dd@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v3-3-5f0410e007dd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 14:09:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXo07jXLL6pn=J+Y-wPGT_wccST4wCbE01bRH3r2xf_qQ@mail.gmail.com>
Message-ID: <CAMuHMdXo07jXLL6pn=J+Y-wPGT_wccST4wCbE01bRH3r2xf_qQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] of: dynamic: Refactor changeset action printing to
 common helpers
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

Thanks for the update!

On Fri, Aug 18, 2023 at 10:41 PM Rob Herring <robh@kernel.org> wrote:
> Several places print the changeset action with node and property
> details. Refactor these into a common printing helper. The complicating
> factor is some prints are debug and some are errors. Solve this with a
> bit of preprocessor magic.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - Drop printing changeset entry pointers

I think it would be good to mention this in the actual patch
description, too.

> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c

> @@ -598,7 +568,7 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
>         unsigned long flags;
>         int ret = 0;
>
> -       __of_changeset_entry_dump(ce);
> +       of_changeset_action_debug("applying: ", ce->action, ce->np, ce->prop);

s/applying/apply/ ?

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
