Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB97B8AED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244517AbjJDSm4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbjJDSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:42:53 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67A3C4;
        Wed,  4 Oct 2023 11:42:49 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57b68555467so8590eaf.0;
        Wed, 04 Oct 2023 11:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444969; x=1697049769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8s+6m9BEsGqmegjmEMQJTpUF0Z6UX9C9OppOPuzfH2g=;
        b=Sk48lb/mULGEToam9I+vVLhvTtoNyKfolAX6OZZya7xUt/M02pehdFLOxK3PsFn0J9
         TfUDIl1GKR8mgOEeVVcJ23zf0XAkzJDaGSgK6N5XRq1wJepeyORAKKb/KJKwFN5HBPtf
         qAdVRp6Kryb3Y43/md0R6GpgCFimFO4ju6W49NG6hCQXJrgWuhuXS4sqZ5bRsJ8qfv7P
         f4tw2fwXw/nMfcpPPl/xtcG862zxSf8OevWwt1lt3qsDCADXWr7Bs/hmuJL24bEQGZWt
         UHuJXj36iwxRQNBBxakOY9HuP7itua77QCIP9AlMP+kQcTTm7romhIirSP6pNRd9XNWv
         yTew==
X-Gm-Message-State: AOJu0Yyq2/uL426UWLESFCgUlkc40PI3+FRgwsvJfCZOS4//rbMRL1bu
        92BAMESIAPvmGj3Pfy9AtQ+Kw+aaQ/omootWywg=
X-Google-Smtp-Source: AGHT+IGtp5mZcvEOsvezG3nc9wPvbnGaCm9i+RbXDlKGHH4PZ32XVLkUJoWdc2yMvAwye9V831diJ43l0YN+YPtadZQ=
X-Received: by 2002:a4a:df07:0:b0:57b:73f6:6f80 with SMTP id
 i7-20020a4adf07000000b0057b73f66f80mr3213282oou.0.1696444968908; Wed, 04 Oct
 2023 11:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-hib_zero_bitmap_fix-v2-1-6a530b7b6e98@quicinc.com>
In-Reply-To: <20231004-hib_zero_bitmap_fix-v2-1-6a530b7b6e98@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Oct 2023 20:42:37 +0200
Message-ID: <CAJZ5v0h_XhpcGHrKKOQoita7TStZO95qFZWRpiLThCmPpRxFcQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Brian Geffon <bgeffon@google.com>, kernel@quicinc.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>
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

On Wed, Oct 4, 2023 at 7:01 AM Pavankumar Kondeti
<quic_pkondeti@quicinc.com> wrote:
>
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
> to safe pages. A temporary bitmap is allocated with PG_ANY flag in
> prepare_image() to make a copy of zero bitmap after the unsafe pages
> are marked. Freeing this temporary bitmap with PG_UNSAFE_KEEP later
> results in an inconsistent state of unsafe pages. Since free bit is
> left as is for this temporary bitmap after free, these pages are
> treated as unsafe pages when they are allocated again. This results
> in incorrect calculation of the number of pages pre-allocated for the
> image.
>
> nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;
>
> The allocate_unsafe_pages is estimated to be higher than the actual
> which results in running short of pages in safe_pages_list. Hence the
> crash is observed in get_buffer() due to NULL pointer access of
> safe_pages_list.
>
> Fix this issue by creating the temporary zero bitmap from safe pages
> (free bit not set) so that the corresponding free bits can be cleared while
> freeing this bitmap.
>
> Cc: stable <stable@kernel.org>

Why is this tag present?  The commit below hasn't made it to a major
release yet AFAICS.

> Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
> Suggested-by:: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
> Changes in v2:
> - Allocate zero bit map from safe pages as suggested by Brian
> - Link to v1: https://lore.kernel.org/r/20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com
> ---
>  kernel/power/snapshot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 87e9f7e2bdc0..0f12e0a97e43 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2647,7 +2647,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
>         memory_bm_free(bm, PG_UNSAFE_KEEP);
>
>         /* Make a copy of zero_bm so it can be created in safe pages */
> -       error = memory_bm_create(&tmp, GFP_ATOMIC, PG_ANY);
> +       error = memory_bm_create(&tmp, GFP_ATOMIC, PG_SAFE);
>         if (error)
>                 goto Free;
>
> @@ -2660,7 +2660,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
>                 goto Free;
>
>         duplicate_memory_bitmap(zero_bm, &tmp);
> -       memory_bm_free(&tmp, PG_UNSAFE_KEEP);
> +       memory_bm_free(&tmp, PG_UNSAFE_CLEAR);
>         /* At this point zero_bm is in safe pages and it can be used for restoring. */
>
>         if (nr_highmem > 0) {
>
> ---
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> change-id: 20230929-hib_zero_bitmap_fix-bc5884eba0ae
>
> Best regards,
> --
> Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>
