Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910E7A9A61
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjIUSit convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjIUSiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:38:10 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964CAD62E8;
        Thu, 21 Sep 2023 11:26:50 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3adc95fdceeso83763b6e.0;
        Thu, 21 Sep 2023 11:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320810; x=1695925610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n/wqWr27pRntEElj0EkXR3VCLKvT4G/Xcd993NCAk4=;
        b=JVnGpV8TDgfBN4Hk8s0JvmB3A98d61iOmzqRcFV9g6bmAYjc8yphO8g1ebfLsfyUWu
         iwqX8gUrB/jtipEvdMsumntv9mM8kmkdgiOWKDaRhthyRmDG1Pp5+DSHXzHZvA5Jg0wY
         S2b0Im4TeshTSII5FN9YfvKeu7eIU5jG5nXcBq4zBkipAWnrmxxX8qvoKs2raN9xhmr7
         w9A7xdznhP/CZCZQ5n+UejykLW0lEwBZ89IEoqFmGMxd3gImdnC3U8honwGxoGtxL3zG
         o8LDpGOQcQ0V21EOYM7k3Tapd3tqUlIRKrpVia5H/2nUzALx66cT9VwwYnxXwsgqEaSt
         VjFA==
X-Gm-Message-State: AOJu0YwW4UYVbm7z1oTpMwH/Xf31yoOXSHYRJEnf77FGUe1jZetDlJvf
        GTqS5tkTLONqxbRmvV/EO38/Z5CZ1paoax7SQfe4paw0
X-Google-Smtp-Source: AGHT+IHrxNnigtLDAImoAjPYXbdlPLItCPsgM9jP/lbemDhG/GboyCzrBZG0LxMXhPHJITu+MFQrBEHm/2Ne9DJnuAA=
X-Received: by 2002:a05:6808:20a7:b0:3ad:f525:52d5 with SMTP id
 s39-20020a05680820a700b003adf52552d5mr5455443oiw.4.1695320809853; Thu, 21 Sep
 2023 11:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230921170045.4189251-1-bgeffon@google.com>
In-Reply-To: <20230921170045.4189251-1-bgeffon@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Sep 2023 20:26:38 +0200
Message-ID: <CAJZ5v0g1PyhxaD+mk0ccHStpO0YZhRXLdE=X5zKCx0xAGpL5QQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: use __get_safe_page() rather than touching
 the list.
To:     Brian Geffon <bgeffon@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>, stable@vger.kernel.org
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

On Thu, Sep 21, 2023 at 7:01 PM Brian Geffon <bgeffon@google.com> wrote:
>
> We found at least one situation where the safe pages list was empty and
> get_buffer() would gladly try to use a NULL pointer.
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Fixes: 8357376 ("swsusp: Improve handling of highmem")
> Cc: stable@vger.kernel.org
>
> Change-Id: Ibb43a9b4ac5ff2d7e3021fdacc08e116650231e9
> ---
>  kernel/power/snapshot.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 362e6bae5891..2dcb33248518 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2544,8 +2544,9 @@ static void *get_highmem_page_buffer(struct page *page,
>                 pbe->copy_page = pfn_to_page(pfn);
>         } else {
>                 /* Copy of the page will be stored in normal memory */
> -               kaddr = safe_pages_list;
> -               safe_pages_list = safe_pages_list->next;
> +               kaddr = __get_safe_page(ca->gfp_mask);
> +               if (!kaddr)
> +                       return ERR_PTR(-ENOMEM);
>                 pbe->copy_page = virt_to_page(kaddr);
>         }
>         pbe->next = highmem_pblist;
> @@ -2747,8 +2748,9 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
>                 return ERR_PTR(-ENOMEM);
>         }
>         pbe->orig_address = page_address(page);
> -       pbe->address = safe_pages_list;
> -       safe_pages_list = safe_pages_list->next;
> +       pbe->address = __get_safe_page(ca->gfp_mask);
> +       if (!pbe->address)
> +               return ERR_PTR(-ENOMEM);
>         pbe->next = restore_pblist;
>         restore_pblist = pbe;
>         return pbe->address;
> --

Applied as 6.7 material, thanks!
