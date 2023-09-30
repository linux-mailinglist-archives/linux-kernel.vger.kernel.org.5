Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC3D7B4022
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjI3Lhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjI3Lhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 07:37:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7278F195
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 04:37:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27752a1e180so8236959a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 04:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696073872; x=1696678672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt7EuEXqGI7TXewH6QEsSanrI9GOVcdSiE0pkdtioME=;
        b=tvdnAlxQ2QQW0cEygPweyIfpRXwOv/hL0TNtZzrewulVCAEfCVucEfvxwhoBeC296h
         JoudJKJUpXmByRQplyOi8lGlYWWhMryTVr3m9EVctaWPTLbov7EJIV9NJqsO3l/sMkP1
         HTGEc8fute/518Dk3G9NhfOTz4Ve7J+DfSQXYItixkOEqx2fmUSFdJUei79iDjAtk/O1
         /osKNs3tmD6jdqfea97MY9l63LV/RfIdaT1jMxW0rmsqdDxci+HHCdoORpEF3vPAgEkL
         ce6IKEQli1YekWgnJMNjj7PEyO1KwLMGdMV+Dy4gF/Btvi9zEKLJjX9GMzdIndZLi5YX
         y6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696073872; x=1696678672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt7EuEXqGI7TXewH6QEsSanrI9GOVcdSiE0pkdtioME=;
        b=fkBP+MN2rMX16i7vQeZV2RpGeHyR+3sK+vNzMmjxaj8kpFDdE0PnTIB5rjrIpX5ulw
         XqDUP4K9+knEIWxakU0Leymv/xJ9Je3kRt3R6ssvNEO7hWbzJ2IklHQlSEnynJOCmHB2
         NxE1osjmsTbOc+q+jDtx9WTtZvduBZEnn4QQE4StBPZmsxuvKtmJvxHUzCshF4GriRm9
         sUT3hkHo7hO+RQwLPGWDGwVCM372QPYW/qS+ElZGVmcAJ2goqxI+9OayEFAYQm5VdTgv
         eHqwPGZBX+VP5+aIpDuA/YlOx7AzWDLP8R1P5KkZvB8zevvyIfQ92SQrIuj9pbyIGwpa
         gucA==
X-Gm-Message-State: AOJu0YxJ2xlN6TtIwBOtZH3XZjbErwFcepDU4JxjUPTdj5NwuZmAKD5+
        IVMNE0a7oCIbDR0NmpdXg66O167EUzCi74ArIIvOGA==
X-Google-Smtp-Source: AGHT+IEplTMs5wTWAV3lc34WWYLDdwEUeqbkGBjDssJRaa7W3LDVbSCo+nHNjHyv+OakTKM9V/CulKIAyJvSNclCXVg=
X-Received: by 2002:a17:90a:9a7:b0:268:2d92:55d3 with SMTP id
 36-20020a17090a09a700b002682d9255d3mr5803488pjo.39.1696073871651; Sat, 30 Sep
 2023 04:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com>
In-Reply-To: <20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Sat, 30 Sep 2023 07:37:13 -0400
Message-ID: <CADyq12wRVJURCuB0ZjL878J-U9kCxNE0pSoihRWBP8OJWk1M1A@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kernel@quicinc.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 1:31=E2=80=AFPM Pavankumar Kondeti
<quic_pkondeti@quicinc.com> wrote:
>
Hi Pavankumar,

> The following crash is observed 100% of the time during resume from
> the hibernation on a x86 QEMU system.
>
> [   12.931887]  ? __die_body+0x1a/0x60
> [   12.932324]  ? page_fault_oops+0x156/0x420
> [   12.932824]  ? search_exception_tables+0x37/0x50
> [   12.933389]  ? fixup_exception+0x21/0x300
> [   12.933889]  ? exc_page_fault+0x69/0x150
> [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> [   12.935428]  snapshot_write_next+0x7c/0x9f0
> [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> [   12.937035]  ? hib_submit_io+0xa5/0x110
> [   12.937501]  load_image+0x83/0x1a0
> [   12.937919]  swsusp_read+0x17f/0x1d0
> [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> [   12.938967]  load_image_and_restore+0x45/0xc0
> [   12.939494]  software_resume+0x13c/0x180
> [   12.939994]  resume_store+0xa3/0x1d0
>
> The commit being fixed introduced a bug in copying the zero bitmap
> to safe pages. A temporary bitmap is allocated in prepare_image()
> to make a copy of zero bitmap after the unsafe pages are marked.
> Freeing this temporary bitmap later results in an inconsistent state
> of unsafe pages. Since free bit is left as is for this temporary bitmap
> after free, these pages are treated as unsafe pages when they are
> allocated again. This results in incorrect calculation of the number
> of pages pre-allocated for the image.
>
> nr_pages =3D (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_uns=
afe_pages;
>
> The allocate_unsafe_pages is estimated to be higher than the actual
> which results in running short of pages in safe_pages_list. Hence the
> crash is observed in get_buffer() due to NULL pointer access of
> safe_pages_list.

Rafael pulled https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-=
pm.git/commit/?h=3Dlinux-next&id=3Df0c7183008b41e92fa676406d87f18773724b48b
which addresses the null pointer dereference which regardless
shouldn't be touching the list directly and should be using
__get_safe_page(). I'll review this patch in the next day or two.

>
> Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image =
file")
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  kernel/power/snapshot.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 87e9f7e2bdc0..cb7341a71a21 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2628,7 +2628,7 @@ static int prepare_image(struct memory_bitmap *new_=
bm, struct memory_bitmap *bm,
>                 struct memory_bitmap *zero_bm)
>  {
>         unsigned int nr_pages, nr_highmem;
> -       struct memory_bitmap tmp;
> +       struct memory_bitmap tmp_zero_bm;
>         struct linked_page *lp;
>         int error;
>
> @@ -2636,6 +2636,16 @@ static int prepare_image(struct memory_bitmap *new=
_bm, struct memory_bitmap *bm,
>         free_image_page(buffer, PG_UNSAFE_CLEAR);
>         buffer =3D NULL;
>
> +       /*
> +        * Allocate a temporary bitmap to create a copy of zero_bm in
> +        * safe pages. This allocation needs to be done before marking
> +        * unsafe pages below so that it can be freed without altering
> +        * the state of unsafe pages.
> +        */
> +       error =3D memory_bm_create(&tmp_zero_bm, GFP_ATOMIC, PG_ANY);
> +       if (error)
> +               goto Free;
> +
>         nr_highmem =3D count_highmem_image_pages(bm);
>         mark_unsafe_pages(bm);
>
> @@ -2646,12 +2656,7 @@ static int prepare_image(struct memory_bitmap *new=
_bm, struct memory_bitmap *bm,
>         duplicate_memory_bitmap(new_bm, bm);
>         memory_bm_free(bm, PG_UNSAFE_KEEP);
>
> -       /* Make a copy of zero_bm so it can be created in safe pages */
> -       error =3D memory_bm_create(&tmp, GFP_ATOMIC, PG_ANY);
> -       if (error)
> -               goto Free;
> -
> -       duplicate_memory_bitmap(&tmp, zero_bm);
> +       duplicate_memory_bitmap(&tmp_zero_bm, zero_bm);
>         memory_bm_free(zero_bm, PG_UNSAFE_KEEP);
>
>         /* Recreate zero_bm in safe pages */
> @@ -2659,8 +2664,8 @@ static int prepare_image(struct memory_bitmap *new_=
bm, struct memory_bitmap *bm,
>         if (error)
>                 goto Free;
>
> -       duplicate_memory_bitmap(zero_bm, &tmp);
> -       memory_bm_free(&tmp, PG_UNSAFE_KEEP);
> +       duplicate_memory_bitmap(zero_bm, &tmp_zero_bm);
> +       memory_bm_free(&tmp_zero_bm, PG_UNSAFE_KEEP);
>         /* At this point zero_bm is in safe pages and it can be used for =
restoring. */
>
>         if (nr_highmem > 0) {
>
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230929-hib_zero_bitmap_fix-bc5884eba0ae
>
> Best regards,
> --
> Pavankumar Kondeti <quic_pkondeti@quicinc.com>

Thanks,
Brian

>
