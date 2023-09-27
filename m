Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397037B0AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjI0ROP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:14:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AA3A1;
        Wed, 27 Sep 2023 10:14:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888CDC433C8;
        Wed, 27 Sep 2023 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695834851;
        bh=bTgktVSYX5Ufv9Td8sPF03LeSvA3mKcRwebt1XzVdvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uP6mOVzO86iIZFGZxtuWQQ8i3ED5mEK1L01WNXAg6ZLNKlX1ERE6csTZku3F2GKkg
         rKY/e9ZqNnAezwK/wZtoQnueVrtsBPAp+F/uyPlr4D+QYbIFtDnY4zsp5YAdxMAINs
         RZfZyTiDk0Cj+1vv7MRuwM3s4OlVKB226Qzs3irg=
Date:   Wed, 27 Sep 2023 10:14:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Message-Id: <20230927101410.920fd8a88d2453f5c530aff3@linux-foundation.org>
In-Reply-To: <20230927160746.1928098-2-Liam.Howlett@oracle.com>
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
        <20230927160746.1928098-2-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 12:07:44 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> When merging of the previous VMA fails after the vma iterator has been
> moved to the previous entry, the vma iterator must be advanced to ensure
> the caller takes the correct action on the next vma iterator event.  Fix
> this by adding a vma_next() call to the error path.
> 
> Users may experience higher CPU usage, most likely in very low memory
> situations.

Looking through this thread:

> Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/

I'm seeing no indication that the effect is CPU consumption?  Jann is
excpecting bogus oom-killing?

