Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4EB7857FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjHWMot convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Aug 2023 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjHWMor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:44:47 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD80D1;
        Wed, 23 Aug 2023 05:44:46 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-570dae7932eso432057eaf.1;
        Wed, 23 Aug 2023 05:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692794685; x=1693399485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA94ssYMg+hOMxUBDUPz4rzxwqeehNk0LVzVo8IpmPw=;
        b=PEGQTpVRSnq16ERqKGDK2uxeS2O8lQoKHCzviQKdskwC+QnGqz6YH1EdDjhxlsyj2N
         kE68VUeh0E0aL+fDTJcfydiX8/owuVS2dVCej2KCvaw+Mt21NE1hy6U0dnJPGVzvrf6t
         94fgDKzC+xnbwigFi91tlUCEXL6+IiEqXAUfH/Ds5nS7/bJjcLmvfCxmn11webhr5Gio
         DjlFo6JGGUYXKFV7DigD9zyDRDeDC/pSBLKZTGdeDmOOGg14ygVEut/b7jpll4FnmqnU
         Li5waSZVm4D9+vQDfdNuGIFP0hIApCbwAvOGtIWBDD6BizUfK7MMyiYGUOx61wjh0AT5
         qrZA==
X-Gm-Message-State: AOJu0YweooYrEA3qvbopW77K97hKRoDNZXfqr1lbpGbGOo4FucQ0QuyI
        YR8/tHwZqy+WQIEAnnJGWHq366J5L34XJAW2kXMHXga0
X-Google-Smtp-Source: AGHT+IGNe4omwsLTO6/XXJW7RrO/oGYZv0w9G42gAvVeUJ4jCmg8siaxS9QmFSkd7pG1V206druH2OhQ6NqEgVu6mlQ=
X-Received: by 2002:a4a:d9c7:0:b0:563:3b56:5dc1 with SMTP id
 l7-20020a4ad9c7000000b005633b565dc1mr11967530oou.0.1692794685278; Wed, 23 Aug
 2023 05:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230823161329.7348-1-yu.c.chen@intel.com>
In-Reply-To: <20230823161329.7348-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Aug 2023 14:44:32 +0200
Message-ID: <CAJZ5v0hV7UFSz=REyVDuy90tW7k9NyBme-S8mEuHSRpEySAcuQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix the exclusive get block device in
 test_resume mode
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chenzhou Feng <chenzhoux.feng@intel.com>,
        syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
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

On Wed, Aug 23, 2023 at 10:19 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> commit 5904de0d735b ("PM: hibernate: Do not get block device exclusively
> in test_resume mode") fixes a hibernation issue under test_resume mode.
> That commit is supposed to open the block device in non-exclusive mode
> when in test_resume. However the code did the opposite, which is against
> its description.
>
> Fix this by really disabling exclusive mode under test_resume.
>
> Reported-by: syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000761f5f0603324129@google.com/
> Fixes: 5904de0d735b ("PM: hibernate: Do not get block device exclusively in test_resume mode")
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/power/swap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index f6ebcd00c410..c12b34dd529c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1518,7 +1518,7 @@ static void *swsusp_holder;
>
>  int swsusp_check(bool snapshot_test)
>  {
> -       void *holder = snapshot_test ? &swsusp_holder : NULL;
> +       void *holder = snapshot_test ? NULL : &swsusp_holder;
>         int error;
>
>         hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, BLK_OPEN_READ,
> @@ -1573,7 +1573,7 @@ void swsusp_close(bool snapshot_test)
>                 return;
>         }
>
> -       blkdev_put(hib_resume_bdev, snapshot_test ? &swsusp_holder : NULL);
> +       blkdev_put(hib_resume_bdev, snapshot_test ? NULL : &swsusp_holder);
>  }
>
>  /**
> --

Applied as 6.6 material, thanks!
