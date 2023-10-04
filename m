Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A487B8B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbjJDSrW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 14:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjJDSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:47:17 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B03102;
        Wed,  4 Oct 2023 11:47:08 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6bf106fb6a0so18629a34.0;
        Wed, 04 Oct 2023 11:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445227; x=1697050027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUXdQuy1oeAdTeK+FzBcCDuTc7loET/2cL3/p7omwJg=;
        b=JWXPPweKP6HQMvqkf9GTxdK7fw0gvunFCDKltf9NujDXfq+e+eN0Yty/nyho+9oV3H
         lknce2mKhNG8axyd2DHemw8oX1KdHhA7wev9ujQrodiSy4zqaOCwcul2QUdH/qXXPh+l
         7X0TI9FxdmI7+aZ9DWjQRtG4kD0UmDtSmiZA2phkTVqUHmn8uLA0XNriALyHnHV6mm/d
         gLN/KStaUgbr5jayQpAleDDHLoOMiEOfnZJOACTttyWETkfksnPhBUBGEIG7nAY5wAl5
         0Ia88gYbn45Unucmh7Iu/YnZmo1ydTtobDssHI72VaRuOtiv+tZtFzAonImQnPSVZj5F
         YlAw==
X-Gm-Message-State: AOJu0Ywk8qUKK0B81Xob3+bhBu6NzuD+gQk8ob9paNx9+C1ED3K502Ev
        nyEw4p9VVakC5CKGTP6yoc/0KxAFENHpWxBgM9ODNV8c
X-Google-Smtp-Source: AGHT+IG+E993eibl0OslNBX/ct+A+qHrnd+z+xQ5WIC2Q6xAUmKZLRmidkHXNmChC+mc3F+JUXzs0aXmFIaF33fNJnM=
X-Received: by 2002:a05:6820:390:b0:57c:6e35:251e with SMTP id
 r16-20020a056820039000b0057c6e35251emr2985387ooj.1.1696445227283; Wed, 04 Oct
 2023 11:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-hib_zero_bitmap_fix-v2-1-6a530b7b6e98@quicinc.com> <CADyq12ziGEpkpvLv9zg91Zpp-12GW1iLnXcT8LaMt48WiKaVMw@mail.gmail.com>
In-Reply-To: <CADyq12ziGEpkpvLv9zg91Zpp-12GW1iLnXcT8LaMt48WiKaVMw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Oct 2023 20:46:56 +0200
Message-ID: <CAJZ5v0g8uBw6syXMC9p6BRn_E77wyUsvBOYX3dv1jwXU7k-uHA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
To:     Brian Geffon <bgeffon@google.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kernel@quicinc.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 4, 2023 at 2:19 PM Brian Geffon <bgeffon@google.com> wrote:
>
> On Wed, Oct 4, 2023 at 1:01 AM Pavankumar Kondeti
> <quic_pkondeti@quicinc.com> wrote:
> >
> > The following crash is observed 100% of the time during resume from
> > the hibernation on a x86 QEMU system.
> >
> > [   12.931887]  ? __die_body+0x1a/0x60
> > [   12.932324]  ? page_fault_oops+0x156/0x420
> > [   12.932824]  ? search_exception_tables+0x37/0x50
> > [   12.933389]  ? fixup_exception+0x21/0x300
> > [   12.933889]  ? exc_page_fault+0x69/0x150
> > [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> > [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> > [   12.935428]  snapshot_write_next+0x7c/0x9f0
> > [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> > [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> > [   12.937035]  ? hib_submit_io+0xa5/0x110
> > [   12.937501]  load_image+0x83/0x1a0
> > [   12.937919]  swsusp_read+0x17f/0x1d0
> > [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> > [   12.938967]  load_image_and_restore+0x45/0xc0
> > [   12.939494]  software_resume+0x13c/0x180
> > [   12.939994]  resume_store+0xa3/0x1d0
> >
> > The commit being fixed introduced a bug in copying the zero bitmap
> > to safe pages. A temporary bitmap is allocated with PG_ANY flag in
> > prepare_image() to make a copy of zero bitmap after the unsafe pages
> > are marked. Freeing this temporary bitmap with PG_UNSAFE_KEEP later
> > results in an inconsistent state of unsafe pages. Since free bit is
> > left as is for this temporary bitmap after free, these pages are
> > treated as unsafe pages when they are allocated again. This results
> > in incorrect calculation of the number of pages pre-allocated for the
> > image.
> >
> > nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;
> >
> > The allocate_unsafe_pages is estimated to be higher than the actual
> > which results in running short of pages in safe_pages_list. Hence the
> > crash is observed in get_buffer() due to NULL pointer access of
> > safe_pages_list.
> >
> > Fix this issue by creating the temporary zero bitmap from safe pages
> > (free bit not set) so that the corresponding free bits can be cleared while
> > freeing this bitmap.
> >
> > Cc: stable <stable@kernel.org>
> > Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
> > Suggested-by:: Brian Geffon <bgeffon@google.com>
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>
> Reviewed-by: Brian Geffon <bgeffon@google.com>

Applied as 6.7 material, but without the Cc: stable tag that is (a)
invalid (there should be vger.kernel.org in the host part) and (b)
unnecessary AFAICS.

Thanks!
