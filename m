Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3610757986
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGRKsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGRKsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:48:37 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079394
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:48:37 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7835971026fso237228639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689677316; x=1692269316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cYSPPJQnROQbUy1Pjj2qdruexKLfeAOlY4k9OqiPSDI=;
        b=upKnMj9OHGor0jAw0lwQddx4TNrZLQVqwdQ0yIgg0HvCXIIREeO/bEmETgaU+byIzb
         8yJloVzfCEgDNhMi3OLALyDcCEnxCymXYhbgbowQ8WuUDl6Rl/plSVfly+t+YuoDbtY7
         +/FjKlTMK6nhF+2TO+byewub2QjZc83GiX+xRThvbG3u3xBGkV4XhzZEYNZA1U8YZ3wd
         T3YuBSYZ9K++LmnJS3MFi6ukJeONUM9EmiNtyF6Cch36UyEvqvuQGzvktAjlKxhXqBgw
         1OTuCkSvgJoQ5RMEUwY6drQAg9jVcJRdOQ/nW4lL6/i9yIrDLA684CJraQt05jtFqOLI
         wPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689677316; x=1692269316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYSPPJQnROQbUy1Pjj2qdruexKLfeAOlY4k9OqiPSDI=;
        b=i5Ovx3crDT0GLjxJ9ndVhosd/7gtdLwoZt8MSlP5uCoVMwDt1uxM5IEtMYGfiwsz9M
         zZPLrrsRRWVALY/fQxBF9f1WkfJ6mtqBftH+Kz6t7Sko6qTifFGq/BdANcQZVyr0JPnM
         Y2Ne5RoCKJkN0BxqPBT48RVG6v2eB1PglyaYdbX1jfarMesUzrkSxTRscF1rPmpLdrCl
         1t217qV31X4v+mqda+ZKTYQZF/RFs6tNegu2AfavhgSZinp10rFWrZcODRyHittg45Aq
         vjpnfjQqehQPxLQGn2mzE/FvoLvD2WIImDJF4tc7WkzZpYMT3AXSJYqI7f9NjIXb0mf0
         oK5Q==
X-Gm-Message-State: ABy/qLaISgi8XGw9R+jJL1dkTWeZYTwezx8WbPI4WVWtsn9vbdak1STq
        rdUEQW4sNMInWwmVqaNtIoIpFLnralLQvRgv6PQn3A==
X-Google-Smtp-Source: APBJJlGlBsNfI4yPZJjLfSpvV/VK/Fuo7gJwANmtQHkJ/5BNOliXQDDUu3Qupar6obZ2eN492JmzcfFhyR6oC/jmdDU=
X-Received: by 2002:a05:6602:2292:b0:787:a73:b411 with SMTP id
 d18-20020a056602229200b007870a73b411mr1776776iod.17.1689677316443; Tue, 18
 Jul 2023 03:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-6-glider@google.com>
 <ZLVH6t25HD+HhCka@smile.fi.intel.com>
In-Reply-To: <ZLVH6t25HD+HhCka@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 18 Jul 2023 12:48:00 +0200
Message-ID: <CAG_fn=Xvb9_K+vTLERVnNOSYMmn9+vt7SOMe_TJTAc=B0UtRKQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: mte: add compression support to mteswap.c
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#include <linux/mm_types.h>
>
> But you actually don't use that.
>
> struct page;
>
> forward declaration is enough.
Fair enough.
>
> > +void *_mte_alloc_and_save_tags(struct page *page);
> > +void _mte_free_saved_tags(void *tags);
> > +void _mte_restore_tags(void *tags, struct page *page);
> > +
> > +#endif // ARCH_ARM64_MM_MTESWAP_H_
>
> ...
>
> > +void _mte_free_saved_tags(void *storage)
> > +{
> > +     unsigned long handle = xa_to_value(storage);
> > +     int size;
> > +
> > +     if (!handle)
> > +             return;
>
> Perhaps
>
>         unsigned long handle;
>
>         handle = xa_to_value(storage);
>         if (!handle)
>                 return;

I don't have a strong preference and am happy to change this, but, out
of curiosity, why do you think it is better?
This pattern (calling (even non-)trivial functions when declaring
variables) is widely used across the kernel.
Or is it just for consistency with how `handle` is used in the rest of the file?


> > +void _mte_restore_tags(void *tags, struct page *page)
> > +{
>
> As per above.

Ack

> > +     if (try_page_mte_tagging(page)) {
> > +             if (!ea0_decompress(handle, tags_decomp))
> > +                     return;
> > +             mte_restore_page_tags(page_address(page), tags_decomp);
> > +             set_page_mte_tagged(page);
> > +     }
>
> I think you may drop an indentation level by
>
>         if (!try_page_mte_tagging(page))
>                 return;
>
> > +}

Ack

> ...
>
> > +void _mte_restore_tags(void *tags, struct page *page)
> > +{
> > +     if (try_page_mte_tagging(page)) {
> > +             mte_restore_page_tags(page_address(page), tags);
> > +             set_page_mte_tagged(page);
> > +     }
>
> Ditto.
Thanks!
