Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693EC7B0D28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjI0UGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjI0UGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:06:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31DA10A;
        Wed, 27 Sep 2023 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5CIG4IN+NULdj6GDXp85UVQu/M7lEt+lk7D7J1xFff4=; b=XaLZv/B8s0zD31RKwX7U3qW6VG
        oPGodBmh1pBJJkZTC/2i1KbCUy6vQCsLB0t7I4bMeJdms5EFe/GltInDYHWXOU/bzjLVKBc+olvuv
        7I7By2Uqq49Mi+lsIyXmK7jIU+C9S00LOK0BLgL4raNGWaTMoElaQNBh0sU5G6xMwBuNqsG3VHpdp
        f7S8rjtHGp92uNjrdFUtI7LQIOITCTjzVZtWN3n7CpKReC2vEco3ZYJnVSbT2364P1TLeoQ+7ptGY
        vf+zn3B1Q2sc51++AFk+ASRSV9eehPszFOHr7m4uNpfhi++XKXeLAlANvz3+B/FXHvdMBvS18ZZqJ
        WQiyvykA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlank-00FpkC-EK; Wed, 27 Sep 2023 20:06:28 +0000
Date:   Wed, 27 Sep 2023 21:06:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Message-ID: <ZRSLRN1Yfku/2dMZ@casper.infradead.org>
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
 <20230927160746.1928098-2-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927160746.1928098-2-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 12:07:44PM -0400, Liam R. Howlett wrote:
> +++ b/mm/mmap.c
> @@ -968,14 +968,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  				vma_pgoff = curr->vm_pgoff;
>  				vma_start_write(curr);
>  				remove = curr;
> -				err = dup_anon_vma(next, curr);
> +				err = dup_anon_vma(next, curr, &anon_dup);

This isn't bisectable.  dup_anon_vma() doesn't gain a third argument
until patch 2.

