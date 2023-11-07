Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287CC7E3740
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjKGJJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjKGJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:09:16 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAED1BDD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:46 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5aecf6e30e9so74537277b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348126; x=1699952926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAcnp803Cgs1OSYvOBSO9kpsWMFwYL94yZNF13U+HEQ=;
        b=GYPG5zHzH63HKvRz99S/mJs11hOU9BrXKLpe1DKUmtWeKT+csf9hN2f3TFwjKzGs4H
         ORnRy8DYEugsEmfnX4T1QLGlY8IYsxC9xpdgqECRakeOj48aYKH261Ss1bJy085COWnf
         KulE1JXYGDn3gNU5CDFHRYyQ5hFhWaFkiOfysXsAMGLAreWOZboFsQmtA6pRP5j5eSJr
         zYgxXDzpzcdbmThoycg4aExeb2mMm5DrK5MrRX1hSl58MqAesST7eTzNGtSQ+Agbsfq8
         gxVj4gp9f51u8LZ2UH4V/5JPCV/PGwV+SKVFMYDg4Atam5b9AHPGmtOk4ajaEs/DQeMl
         BQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348126; x=1699952926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAcnp803Cgs1OSYvOBSO9kpsWMFwYL94yZNF13U+HEQ=;
        b=p4J7+8UDFmrfVHxw2oq94XxPueEM31CNjfvIxNI5/Jq8GgtylCQlp+9TaGRW3Qt6/5
         HnZqo6IdO6RgjK12eWMYwTCVz4G2bwTuum5nUXrO2Q5LL0obhOpYWZTFirVarhbRQxLq
         E2f7E+f9E2eKVcqStlvxB0ikmCVAn67Te3Emog++Y7Viegt57gT5pzQizvrLtPgdukfQ
         sKI99ZLRrlgCZcgikKq1Lfzzvvb1YhywF6RDPBBcC62fdkZlMqmzRmAGXBW3rlw90nmU
         tDg6PGMJNx3CQ+I6x3FvLqF5/CD5R+O7tEhMS0x9FYDhbeXCfdBvVFs6I6vxpX4+t1d2
         wIFQ==
X-Gm-Message-State: AOJu0YyKBYmUe4KS/kSYxiG1nILgrSu8ZmaDVHpaU5I/Ax4wAwux6FXe
        Lf4Sdb5xjIGzmfZ2JUaePeOgaMZRxZv7wLA=
X-Google-Smtp-Source: AGHT+IFFouvZhzX6LGOPJbt6IaCgFFjjLWL6mSy3mVhrRADf4hNkB06FO554hX7+dtJrDobB0prtCfIZ01VoXZg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a0d:d708:0:b0:5a7:b54e:bfc1 with SMTP id
 z8-20020a0dd708000000b005a7b54ebfc1mr252928ywd.10.1699348125924; Tue, 07 Nov
 2023 01:08:45 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:43 +0000
In-Reply-To: <20231102185934.773885-20-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-20-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090843.261410-1-aliceryhl@google.com>
Subject: Re: [PATCH 19/21] binder: perform page allocation outside of locks
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> Split out the insertion of pages to be done outside of the alloc->mutex
> in a separate binder_get_pages_range() routine. Since this is no longer
> serialized with other requests we need to make sure we look at the full
> range of pages for this buffer, including those shared with neighboring
> buffers. The insertion of pages into the vma is still serialized with
> the mmap write lock.
> 
> Besides avoiding unnecessary nested locking this helps in preparation of
> switching the alloc->mutex into a spinlock_t in subsequent patches.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

This is rather complex, so it could use more comments. However, as far
as I can tell, the change is correct.

> +/* The range of pages should include those shared with other buffers */
> +static int binder_get_page_range(struct binder_alloc *alloc,
> +				 unsigned long start, unsigned long end)
> [snip]
> +/* The range of pages should exclude those shared with other buffers */
> +static void binder_allocate_page_range(struct binder_alloc *alloc,
> +				       unsigned long start, unsigned long end)

I would really like a comment on each function explaining that:

 * The binder_allocate_page_range function ensures that existing pages
   will not be reclaimed by the shrinker.
 * The binder_get_page_range function ensures that missing pages are
   allocated and inserted.

I also don't think the names are great. The function with "allocate" in
its name is the one that doesn't perform any allocations.

>  	mmap_write_lock(alloc->mm);
> +	if (lru_page->page_ptr)
> +		goto out;

Another comment that I'd like to see somewhere is one that says
something along these lines:

    Multiple processes may call `binder_get_user_page_remote` on the
    same page in parallel. When this happens, one of them will allocate
    the page and insert it, and the other process will use the mmap
    write lock to wait for the insertion to complete. This means that we
    can't use a mmap read lock here.

> +	/* mark page insertion complete and safe to acquire */
> +	smp_store_release(&lru_page->page_ptr, page);
> [snip]
> +		/* check if page insertion is marked complete by release */
> +		if (smp_load_acquire(&page->page_ptr))
> +			continue;

We already discussed this when I asked you to make this an acquire /
release operation so that it isn't racy, but it could use a comment
explaining its purpose.

>  	mmap_write_lock(alloc->mm);
> +	if (lru_page->page_ptr)
> +		goto out;
> +
>  	if (!alloc->vma) {
>  		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
>  		ret = -ESRCH;
>  		goto out;
>  	}
>  
>  	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
>  	if (!page) {
>  		pr_err("%d: failed to allocate page\n", alloc->pid);
>  		ret = -ENOMEM;
>  		goto out;
>  	}

Maybe it would be worth to allocate the page before taking the mmap
write lock? It has the disadvantage that you may have to immediately
deallocate it if we trigger the `if (lru_page->page_ptr) goto out`
branch, but that shouldn't happen that often, and it would reduce the
amount of time we spend holding the mmap write lock.

Alice
