Return-Path: <linux-kernel+bounces-59098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3484F12A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DFF1C22A14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD2865BB5;
	Fri,  9 Feb 2024 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLFBeREw"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4465BA7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465680; cv=none; b=CzE7viciGX5kdIx8XpWjpLkGFQTZl3FWYi734JhIt4J+vZNfw8xyGOz4FXi7sa2dA7+4fEW9/dnLzCsPxAAqaKQ82cMmRI8hm9pMX6J1HvHbUmfJPmkG9TiAqjchJOfFPj6Ql76e3A/mcgAwIqU8xaKHYeZQgxnQMF2QBaBLUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465680; c=relaxed/simple;
	bh=kdDlmQqEC22ksxx8OX67QmPxPKoS+SK9CvI9+bzj0gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nowF4NGvh/+ik+NHLIE0nAC6QfsPycL++JOGygEzeIruT6xHgjJ9WYlGk6P7iwyn+0ygNi4lzklgWjb8ZG2YzkQFz3eFpiWy8wSKhvrlpDXoh9RFP/JZdVtlQqbPuiU7osUvfmcOZkV2/NyTLF1B5GH7HjIOKIPdifZ2NS+gXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLFBeREw; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c01ac04569so257284e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 00:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707465677; x=1708070477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KsiZ+BblRr7NCTYXiTpbTyVjjF/y9cawt6P+Aca2g38=;
        b=fLFBeREwzGfWuBi7yr6GD+hg6HtAKX0TCmVFxJyAHKrWr0A/znclpDOubz57x64mSf
         05OoLO95tOmZRu/6mMtAJsdGvwg/8dAKOVPOBNyR3Gaq0vwDuvRsY8sI0d0AxJVeTYQD
         VpKGcL0H7Qj2MB8ygyA1aFI/H5vRw9PcWRaVTVJr4Bh+YHJmd2YvB6PPgFKFtasC+pDg
         AGz8kXAvFB6XszuUF933sQJMcgLDeBPvDl9pniRBWjUkRGiTmxil8gFF8hqbwgMz/oLA
         h6FQz9HakooIOgIFeDCbqN58jj3AtS3spMeai3mrS9LL4kX2DUQwrCjORBGwpZJJIG1F
         INEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707465677; x=1708070477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsiZ+BblRr7NCTYXiTpbTyVjjF/y9cawt6P+Aca2g38=;
        b=iLE1fx6NuCuoiLiRlu4flVler7komV75QGuhGE+ZzrV2a6Vj3P8wgv02FKJJxAplkU
         zUlgiMbw2Oox0cMg2vqb3zrzWLUVNYJvP25RC5tdqABHZRHtr3OrXuiLrIF7ipcRgw0D
         Hi2Abtgi3hSuVMUTWjxgoknCYkLZu/El6GtrK3phrCAkPi8cLkp492+KbWwrQHnZQKqk
         WgokXcV27RJA//926fVr58yxBCyN3uJmZAF6IrR80t5Hip5cdC9XjevNAB43UVWvpYX/
         p4PqFDg8cYCzft/OG3tUlRIvpmHrT90tVx2177O0ZedMmASx0zNGxhybjOhGjdiOK5kL
         cKvw==
X-Gm-Message-State: AOJu0Yw7KA0ZNdFztPbkTdutcOfagHbNCfnF6kb8/Zk6MsI3AUAwAsBJ
	K3qLGkV5BT2tZ+RiAOUb5oAZzyg9EkStY0jMuz2+dyKP6qV26T25tVCbz8EJU5QHqlF7iCQufzO
	6GOl13jUFQg+N7ZrjyH+0Ya6glGE6sqevVKBC
X-Google-Smtp-Source: AGHT+IFXjPjL6iDCeDuIk+TxXSQFdvefy0JvGxD2k7S2flDvVMhe4qrAnu3UCoLe3q+ZZX8j8IKJ2Cw+rrf91bvTYzw=
X-Received: by 2002:a1f:e6c1:0:b0:4c0:1a5c:9185 with SMTP id
 d184-20020a1fe6c1000000b004c01a5c9185mr864523vkh.4.1707465677142; Fri, 09 Feb
 2024 00:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208234539.19113-1-osalvador@suse.de> <20240208234539.19113-4-osalvador@suse.de>
In-Reply-To: <20240208234539.19113-4-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Fri, 9 Feb 2024 09:00:40 +0100
Message-ID: <CANpmjNNcPr=pPco_HN9nXBabubtfo02SAH=taZGNCvYDq42YUQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 00:45, Oscar Salvador <osalvador@suse.de> wrote:
>
> This patch adds a new file called 'page_owner_stacks', which
> will show all stacks that were added by page_owner followed by
> their counting, giving us a clear overview of stack <-> count
> relationship.
>
> E.g:
>
>   prep_new_page+0xa9/0x120
>   get_page_from_freelist+0x801/0x2210
>   __alloc_pages+0x18b/0x350
>   alloc_pages_mpol+0x91/0x1f0
>   folio_alloc+0x14/0x50
>   filemap_alloc_folio+0xb2/0x100
>   __filemap_get_folio+0x14a/0x490
>   ext4_write_begin+0xbd/0x4b0 [ext4]
>   generic_perform_write+0xc1/0x1e0
>   ext4_buffered_write_iter+0x68/0xe0 [ext4]
>   ext4_file_write_iter+0x70/0x740 [ext4]
>   vfs_write+0x33d/0x420
>   ksys_write+0xa5/0xe0
>   do_syscall_64+0x80/0x160
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  stack_count: 4578
>
> In order to show all the stacks, we implement stack_depot_get_next_stack(),
> which walks all buckets while retrieving the stacks stored in them.
> stack_depot_get_next_stack() will return all stacks, one at a time,
> by first finding a non-empty bucket, and then retrieving all the stacks
> stored in that bucket.
> Once we have completely gone through it, we get the next non-empty bucket
> and repeat the same steps, and so on until we have completely checked all
> buckets.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/stackdepot.h | 20 +++++++++
>  lib/stackdepot.c           | 46 +++++++++++++++++++++
>  mm/page_owner.c            | 85 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index ac62de4d4999..d851ec821e6f 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -183,6 +183,26 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>   */
>  struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle);
>
> +/**
> + * stack_depot_get_next_stack - Returns all stacks, one at a time

"Returns all stack_records" to be clear that this is returning the struct.

> + *
> + * @table:     Current table we are checking
> + * @bucket:    Current bucket we are checking
> + * @last_found:        Last stack that was found
> + *
> + * This function finds first a non-empty bucket and returns the first stack
> + * stored in it. On consequent calls, it walks the bucket to see whether
> + * it contains more stacks.
> + * Once we have walked all the stacks in a bucket, we check
> + * the next one, and we repeat the same steps until we have checked all of them

I think for this function it's important to say that no entry returned
from this function can be evicted.

I.e. the easiest way to ensure this is that the caller makes sure the
entries returned are never passed to stack_depot_put() - which is
certainly the case for your usecase because you do not use
stack_depot_put().

> + * Return: A pointer a to stack_record struct, or NULL when we have walked all
> + * buckets.
> + */
> +struct stack_record *stack_depot_get_next_stack(unsigned long *table,

To keep consistent, I'd also call this
__stack_depot_get_next_stack_record(), so that we're clear this is
more of an internal function not for general usage.

> +                                               struct list_head **bucket,
> +                                               struct stack_record **last_found);
> +
>  /**
>   * stack_depot_fetch - Fetch a stack trace from stack depot
>   *
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 197c355601f9..107bd0174cd6 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -782,6 +782,52 @@ unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
>  }
>  EXPORT_SYMBOL(stack_depot_get_extra_bits);
>
> +struct stack_record *stack_depot_get_next_stack(unsigned long *table,
> +                                               struct list_head **curr_bucket,
> +                                               struct stack_record **last_found)
> +{
> +       struct list_head *bucket = *curr_bucket;
> +       unsigned long nr_table = *table;
> +       struct stack_record *found = NULL;
> +       unsigned long stack_table_entries = stack_hash_mask + 1;
> +
> +       rcu_read_lock_sched_notrace();

We are returning pointers to stack_records out of the RCU-read
critical section, which are then later used to continue the iteration.
list_for_each_entry_continue_rcu() says this is fine if "... you held
some sort of non-RCU reference (such as a reference count) ...".
Updating the function's documentation to say none of these entries can
be evicted via a stack_depot_put() is required.

> +       if (!bucket) {
> +               /*
> +                * Find a non-empty bucket. Once we have found it,
> +                * we will use list_for_each_entry_continue_rcu() on the next
> +                * call to keep walking the bucket.
> +                */
> +new_table:
> +               bucket = &stack_table[nr_table];
> +               list_for_each_entry_rcu(found, bucket, hash_list) {
> +                       goto out;
> +               }
> +       } else {
> +                /* Check whether we have more stacks in this bucket */
> +               found = *last_found;
> +               list_for_each_entry_continue_rcu(found, bucket, hash_list) {
> +                       goto out;
> +               }
> +       }
> +
> +       /* No more stacks in this bucket, check the next one */
> +       nr_table++;
> +       if (nr_table < stack_table_entries)
> +               goto new_table;
> +
> +       /* We are done walking all buckets */
> +       found = NULL;
> +
> +out:
> +       *table = nr_table;
> +       *curr_bucket = bucket;
> +       *last_found = found;
> +       rcu_read_unlock_sched_notrace();
> +
> +       return found;
> +}
> +
>  static int stats_show(struct seq_file *seq, void *v)
>  {
>         /*
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 0adf41702b9d..aea212734557 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -749,6 +749,89 @@ static const struct file_operations proc_page_owner_operations = {
>         .llseek         = lseek_page_owner,
>  };
>
> +struct stack_iterator {
> +       unsigned long nr_table;
> +       struct list_head *bucket;
> +       struct stack_record *last_stack;
> +};
> +
> +static void *stack_start(struct seq_file *m, loff_t *ppos)
> +{
> +       struct stack_iterator *iter = m->private;
> +
> +       if (*ppos == -1UL)
> +               return NULL;
> +
> +       return stack_depot_get_next_stack(&iter->nr_table,
> +                                         &iter->bucket,
> +                                         &iter->last_stack);
> +}
> +
> +static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
> +{
> +       struct stack_iterator *iter = m->private;
> +       struct stack_record *stack;
> +
> +       stack = stack_depot_get_next_stack(&iter->nr_table,
> +                                          &iter->bucket,
> +                                          &iter->last_stack);
> +       *ppos = stack ? *ppos + 1 : -1UL;
> +
> +       return stack;
> +}
> +
> +static int stack_print(struct seq_file *m, void *v)
> +{
> +       char *buf;
> +       int ret = 0;
> +       struct stack_iterator *iter = m->private;
> +       struct stack_record *stack = iter->last_stack;
> +
> +       if (!stack->size || stack->size < 0 || refcount_read(&stack->count) < 2)
> +               return 0;
> +
> +       buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +
> +       ret += stack_trace_snprint(buf, PAGE_SIZE, stack->entries, stack->size,
> +                                  0);
> +       if (!ret)
> +               goto out;
> +
> +       scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
> +                 refcount_read(&stack->count));
> +
> +       seq_printf(m, buf);
> +       seq_puts(m, "\n\n");
> +out:
> +       kfree(buf);
> +
> +       return 0;
> +}
> +
> +static void stack_stop(struct seq_file *m, void *v)
> +{
> +}
> +
> +static const struct seq_operations page_owner_stack_op = {
> +       .start  = stack_start,
> +       .next   = stack_next,
> +       .stop   = stack_stop,
> +       .show   = stack_print
> +};
> +
> +static int page_owner_stack_open(struct inode *inode, struct file *file)
> +{
> +       return seq_open_private(file, &page_owner_stack_op,
> +                               sizeof(struct stack_iterator));
> +}
> +
> +const struct file_operations page_owner_stack_operations = {
> +       .open           = page_owner_stack_open,
> +       .read           = seq_read,
> +       .llseek         = seq_lseek,
> +       .release        = seq_release,
> +};
> +
>  static int __init pageowner_init(void)
>  {
>         if (!static_branch_unlikely(&page_owner_inited)) {
> @@ -758,6 +841,8 @@ static int __init pageowner_init(void)
>
>         debugfs_create_file("page_owner", 0400, NULL, NULL,
>                             &proc_page_owner_operations);
> +       debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
> +                           &page_owner_stack_operations);
>
>         return 0;
>  }
> --
> 2.43.0
>

