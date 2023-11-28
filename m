Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55A87FC5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjK1Unm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjK1Und (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:43:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398F19B2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CA3C433C9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701204219;
        bh=dUgTGnBvyni9rwICv+SXPMmCh79rCf51zZBSe5UWymw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MXoOpnZevWjE8Ej+PcA0NUdIprGWk8COluDTOPxY5vvD/35dH7lL4yQgP+1a0epn3
         cLv9EFzXR23yWIphtyB3KqIKX/ZlS/GyDAdwsDAXBcIojxUTX69fnl/eDYAtze4U8A
         s+LfUz6ZtYh5SZcnr/tX56VCz8KLToMZX72eFdlJUvhhqyB/nErRRnvZWFCYWWFlcQ
         Ouo3ODf6ueRK2mAVBgAukLt5Q7suXlaFQfqzWY4UrGJcDaNNNjejSulWeOO0RmSXO/
         D2HM2zwhMsmXSYiU5bIC2vj8wOepDIGJAK9x3VQy4x9vy0GKZsx/y316mJ+wkKU9HI
         MDovjx3nfpfmw==
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c5ff5a69f0so242200a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:39 -0800 (PST)
X-Gm-Message-State: AOJu0YyTGBvwseAOqiAfeBNDb342reJmiuQyWdfAuCtNLUiCJcgJBFm/
        kyBTO8M8/fAAtj9SDWdUhHH2+NMQX+fvSxZrkEJQdQ==
X-Google-Smtp-Source: AGHT+IHJ6RxMb0AXm3RZ0SOnfsUX8ufpGFi3Jf2EIhd4yB0xF73EZBYwC9oyT8DjnPg4hBkQ3xgcrxbI/yFzFsHtOok=
X-Received: by 2002:a17:90b:3946:b0:285:be73:45ae with SMTP id
 oe6-20020a17090b394600b00285be7345aemr7679655pjb.49.1701204219017; Tue, 28
 Nov 2023 12:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20231127160058.586446-1-fabio.maria.de.francesco@linux.intel.com>
 <CAF8kJuMakA-UbHi4Z5uCtB+6S0vcZiULKXu6GQh+7KBHQSR6Bg@mail.gmail.com> <ZWX0h9JEAuw4qGyV@casper.infradead.org>
In-Reply-To: <ZWX0h9JEAuw4qGyV@casper.infradead.org>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 28 Nov 2023 12:43:26 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPNYpHy=5fTzH5b0RoDHfCQKLkJM_APtnUQ-bs=Y60mmg@mail.gmail.com>
Message-ID: <CAF8kJuPNYpHy=5fTzH5b0RoDHfCQKLkJM_APtnUQ-bs=Y60mmg@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Replace kmap_atomic() with kmap_local_page()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Nov 28, 2023 at 6:09=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
> >
> > >From the performance perspective, kmap_local_page() does less so it
> > has some performance gain. I am trying to think would it have another
> > unwanted side effect of enabling interrupt and page fault while zswap
> > decompressing a page.
> > The decompression should not generate page fault. The interrupt
> > enabling might introduce extra latency, but most of the page fault was
> > having interrupt enabled anyway. The time spent in decompression is
> > relatively small compared to the whole duration of the page fault. So
> > the interrupt enabling during those short windows should be fine.
> > "Should" is the famous last word.
>
> Interrupts are enabled with kmap_atomic() too.  The difference is
> whether we can be preempted by a higher-priority process.
>
You are right, thanks for the clarification.

Hi Fabio,

Acked-by: Chris Li <chrisl@kernel.org> (Google)

Chris
