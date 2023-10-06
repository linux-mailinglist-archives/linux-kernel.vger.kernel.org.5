Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738727BBD9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjJFRWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJFRV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:21:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6966AD;
        Fri,  6 Oct 2023 10:21:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8C4C15;
        Fri,  6 Oct 2023 10:22:34 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.37.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D40043F5A1;
        Fri,  6 Oct 2023 10:21:53 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:21:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kernel@quicinc.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: hibernate: Fix a bug in copying the zero bitmap
 to safe pages
Message-ID: <ZSBCLE1VLxN-hdRD@FVFF77S0Q05N.cambridge.arm.com>
References: <20231004-hib_zero_bitmap_fix-v2-1-6a530b7b6e98@quicinc.com>
 <CADyq12ziGEpkpvLv9zg91Zpp-12GW1iLnXcT8LaMt48WiKaVMw@mail.gmail.com>
 <CAJZ5v0g8uBw6syXMC9p6BRn_E77wyUsvBOYX3dv1jwXU7k-uHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g8uBw6syXMC9p6BRn_E77wyUsvBOYX3dv1jwXU7k-uHA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Oct 04, 2023 at 08:46:56PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 4, 2023 at 2:19 PM Brian Geffon <bgeffon@google.com> wrote:
> >
> > On Wed, Oct 4, 2023 at 1:01 AM Pavankumar Kondeti
> > <quic_pkondeti@quicinc.com> wrote:
> > >
> > > The following crash is observed 100% of the time during resume from
> > > the hibernation on a x86 QEMU system.
> > >
> > > [   12.931887]  ? __die_body+0x1a/0x60
> > > [   12.932324]  ? page_fault_oops+0x156/0x420
> > > [   12.932824]  ? search_exception_tables+0x37/0x50
> > > [   12.933389]  ? fixup_exception+0x21/0x300
> > > [   12.933889]  ? exc_page_fault+0x69/0x150
> > > [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> > > [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> > > [   12.935428]  snapshot_write_next+0x7c/0x9f0
> > > [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> > > [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> > > [   12.937035]  ? hib_submit_io+0xa5/0x110
> > > [   12.937501]  load_image+0x83/0x1a0
> > > [   12.937919]  swsusp_read+0x17f/0x1d0
> > > [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> > > [   12.938967]  load_image_and_restore+0x45/0xc0
> > > [   12.939494]  software_resume+0x13c/0x180
> > > [   12.939994]  resume_store+0xa3/0x1d0
> > >
> > > The commit being fixed introduced a bug in copying the zero bitmap
> > > to safe pages. A temporary bitmap is allocated with PG_ANY flag in
> > > prepare_image() to make a copy of zero bitmap after the unsafe pages
> > > are marked. Freeing this temporary bitmap with PG_UNSAFE_KEEP later
> > > results in an inconsistent state of unsafe pages. Since free bit is
> > > left as is for this temporary bitmap after free, these pages are
> > > treated as unsafe pages when they are allocated again. This results
> > > in incorrect calculation of the number of pages pre-allocated for the
> > > image.
> > >
> > > nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;
> > >
> > > The allocate_unsafe_pages is estimated to be higher than the actual
> > > which results in running short of pages in safe_pages_list. Hence the
> > > crash is observed in get_buffer() due to NULL pointer access of
> > > safe_pages_list.
> > >
> > > Fix this issue by creating the temporary zero bitmap from safe pages
> > > (free bit not set) so that the corresponding free bits can be cleared while
> > > freeing this bitmap.
> > >
> > > Cc: stable <stable@kernel.org>
> > > Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
> > > Suggested-by:: Brian Geffon <bgeffon@google.com>
> > > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> >
> > Reviewed-by: Brian Geffon <bgeffon@google.com>
> 
> Applied as 6.7 material, but without the Cc: stable tag that is (a)
> invalid (there should be vger.kernel.org in the host part) and (b)
> unnecessary AFAICS.

Just to check, did you mean as v6.6 material?

I'm consistently hitting this on real arm64 hardware with v6.6-rc*.

If this is v6.7 material, are we going to revert 005e8dddd497 for now?

I've tested the above patch atop v6.6-rc3, and it solves the problem for me, so
FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
