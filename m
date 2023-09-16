Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BD87A3262
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 22:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjIPUEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjIPUET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 16:04:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27D1AD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:04:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618BFC433C7;
        Sat, 16 Sep 2023 20:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694894653;
        bh=bawxczNPnq3Vfgyc+ufnLqCHSJIojqF/0A0qUQ9y1j8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zLp5UXZ+KHJ/obNuLFg8OsxY+e0pepS0EIR4adFyhEfP+HNeCvIZJGVULoiIJb5n4
         SBd94FsYXibZxiBK71pST/Bc7P4FEcau+IuMnlLoqny7sMNJ3IzZvfFzCFws1YY1PR
         ZCsvfhj5DOhIOgG9VSjOFgrGoD43hlird1jD8QCY=
Date:   Sat, 16 Sep 2023 13:04:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>, arnd@arndb.de,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v2 12/19] lib/stackdepot: use list_head for stack record
 links
Message-Id: <20230916130412.bdd04e5344f80af583332e9d@linux-foundation.org>
In-Reply-To: <20230916174334.GA1030024@mutt>
References: <cover.1694625260.git.andreyknvl@google.com>
        <d94caa60d28349ca5a3c709fdb67545d9374e0dc.1694625260.git.andreyknvl@google.com>
        <20230916174334.GA1030024@mutt>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2023 19:43:35 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:

> On 2023-09-13 19:14, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> > 
> > Switch stack_record to use list_head for links in the hash table
> > and in the freelist.
> > 
> > This will allow removing entries from the hash table buckets.
> > 
> > This is preparatory patch for implementing the eviction of stack records
> > from the stack depot.
> > 
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > 
> 
> Building on an arm64 kernel from linux-next tag next-20230915, and boot
> that in QEMU. I see the following kernel panic.
> 
> ...
>
> The full log can be found [1] and the .config file [2]. I bisected down
> to this commit, see the bisect log [3].
> 
> When reverted these two commits I managed to build and the kernel
> booted.
> 
> 47590ecf1166 ("lib/stackdepot: use list_head for stack record links")
> 8729f3c26fc2 ("lib/stackdepot: allow users to evict stack traces")

Thanks, I have dropped this v2 series.
