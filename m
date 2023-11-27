Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3267FAB23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjK0URE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0URC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:17:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EAA1B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:17:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADBFC433CC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701116228;
        bh=iFIXHwvfTSTEDZaoApsKmxK/L88uaLZE4LGuvxU3ZOc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=muUw2Pon+VtCXUdO83+eYrfdpX3kRweY/McLQhNKLS/2FLHuA1zmb7gRxJN35dVlu
         5nqFXFf1lv+FLOu7Mw20tRFQH47UV/NjnoYb6RZSU3rJjkwbdlwsFbbBzUThFTn3Mo
         KApySerna9K4S39NFiq0368e1GlhaSal0zwoAdZ30I7/ezf3lQmD7wTXzqU8n23Pb0
         gC+jU2t6J+8JHl05Ta3vaFyp6oH9q8DA4aapdjmeyK6XLM2c0OdcCTxw25OpRzTHxK
         3ychkGV82EWjhXzJ5tVIj/eprj3+d+ltatHw7btRSjbY64olVh8F0b5RPsAnyVVF/7
         QStv6AO3f5NcA==
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso12218165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:17:08 -0800 (PST)
X-Gm-Message-State: AOJu0Yycbr9/QhiYwg/SlSuZSnD/z3ScKZ8z2HEkmm78e0h59lZK7yi3
        VUk4F2H6GdBan18dDZqpqgW3yxE7VGnRVZOZy2vpyw==
X-Google-Smtp-Source: AGHT+IFHEnC7JReexqTgI2LSFW0v0eUVq4Y8pUZBBp92qbERuBc2GTKbwJNgS0fEesn5PN6e9hZM0ZWnCUsgmAuJ5u0=
X-Received: by 2002:a17:90b:4b0e:b0:285:b940:b51d with SMTP id
 lx14-20020a17090b4b0e00b00285b940b51dmr5274686pjb.20.1701116228069; Mon, 27
 Nov 2023 12:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20231127160058.586446-1-fabio.maria.de.francesco@linux.intel.com>
In-Reply-To: <20231127160058.586446-1-fabio.maria.de.francesco@linux.intel.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 27 Nov 2023 12:16:56 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMakA-UbHi4Z5uCtB+6S0vcZiULKXu6GQh+7KBHQSR6Bg@mail.gmail.com>
Message-ID: <CAF8kJuMakA-UbHi4Z5uCtB+6S0vcZiULKXu6GQh+7KBHQSR6Bg@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Replace kmap_atomic() with kmap_local_page()
To:     "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Mon, Nov 27, 2023 at 8:01=E2=80=AFAM Fabio M. De Francesco
<fabio.maria.de.francesco@linux.intel.com> wrote:
>
> kmap_atomic() has been deprecated in favor of kmap_local_page().
>
> Therefore, replace kmap_atomic() with kmap_local_page() in
> zswap.c.
>
> kmap_atomic() is implemented like a kmap_local_page() which also
> disables page-faults and preemption (the latter only in !PREEMPT_RT
> kernels). The kernel virtual addresses returned by these two API are
> only valid in the context of the callers (i.e., they cannot be handed to
> other threads).
>
> With kmap_local_page() the mappings are per thread and CPU local like
> in kmap_atomic(); however, they can handle page-faults and can be called
> from any context (including interrupts). The tasks that call
> kmap_local_page() can be preempted and, when they are scheduled to run
> again, the kernel virtual addresses are restored and are still valid.

As far as I can tell, the kmap_atomic() is the same as
kmap_local_page() with the following additional code before calling to
"__kmap_local_page_prot(page, prot)", which is common between these
two functions.

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                migrate_disable();
        else
                preempt_disable();

        pagefault_disable();

From the performance perspective, kmap_local_page() does less so it
has some performance gain. I am trying to think would it have another
unwanted side effect of enabling interrupt and page fault while zswap
decompressing a page.
The decompression should not generate page fault. The interrupt
enabling might introduce extra latency, but most of the page fault was
having interrupt enabled anyway. The time spent in decompression is
relatively small compared to the whole duration of the page fault. So
the interrupt enabling during those short windows should be fine.
"Should" is the famous last word.

I am tempted to Ack on it. Let me sleep on it a before more. BTW,
thanks for the patch.

Chris
