Return-Path: <linux-kernel+bounces-63131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD48852B51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C491C2267A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2F18657;
	Tue, 13 Feb 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QwnoWtZN"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BD18026
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813562; cv=none; b=sSY8w+VKHTzBcOD9Mn9O9J+x7TGUk2qDWfqm/PHfVHLHrwejCSdPAhGAHxtby9UwEBpFYQIxmIVGeH3lS9r39UkMPnxbmSZyakUfJQAFISTPb01qxxB+WfxdL5OJUuWro/kAL8YxCMHMDLQADuR6v/OLds81hekEyo8PynIOS5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813562; c=relaxed/simple;
	bh=rGZ/LXjfrA/5od5bjWJBEoo2GZCS/7eBxcZ355yTrFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXpCgTFNPAnsaBb9DXnCy04IVhFKfnMXIksK2k+kHWnxx0oVWougc22pU9x8fJ86lnbPc0TaMh0dH3z4vBUdhtbCosVZdjzOhuTOEgStTVs3xbfI2IK46mrakP2/3i24ZoUXhfIU6tsjfHL4al/UVF8d6TvvhQkbS7F6ebdTyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwnoWtZN; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-46d5f87548fso2256162137.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707813559; x=1708418359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fyqfWeybHMGs698ToWhPG+TlUwHa8zyGlvb2w4RdNr8=;
        b=QwnoWtZNxB0nJg5hgep+VVOvdpzGskDmPRnvvZpWWC3xTy+jXzdMqlUyH0gKwO8F4j
         uuczDX9+/l/UDisHyTwP/juhKlayhFYmSsV/hQchBbglVkIxYfU06430srN+YlXIO2zO
         H8PsrcZFszGyR0tiy/CA4j6iM+LZ2VbSkpdOPOqxdsyJdrpvwMbdXqXuC7Ei4IXC3sIt
         0tTg4wL4H/cNwt2R9v+2Nbcx0ydQfng/JY32y8KdlhYwLdwF5hR5TrYHCM2sNMkY+4qy
         K7gArbALrQ3yIBgyI2HDd18DZ8z6E/2acJb3QHsez03YpuJu3VpJlh7mORdhXMaWLie1
         OO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813559; x=1708418359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyqfWeybHMGs698ToWhPG+TlUwHa8zyGlvb2w4RdNr8=;
        b=J+f/+6H2Y5gqHoUArhkSbjnohaazjeGtonYzOeyh66Gnra/+GJ0O7oJFWmovwGsOG5
         gIo+QXU1jLyPipV9lXZKKSdCzXWxhYe0y7VlbyhsdmBfTVR2rwoXeyjj5lFOHCmE+Nf1
         v6DiDbZlJVR4XcjaYwtwXe0v3+GriXBagXmNQI2Bgk25PH8kzFPq3aubdzwPuaYAxdc/
         +JtrD/RpYUxnDffPTEVZfQWcCiwkVzMWxPGysp/8ukw6W0CernwuKFNYNMy6u8SG8IL3
         s864u0QRkzDwM5xRXfeVtsbovJv76a8DXwmvcxag8uzlQSX/rNJRiEUTmpjpnFqLhnWy
         qEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQypXQdxqvqRI5zhAMGTEqEssra5KrRgk9MPCfCao1IjTQVuliFJp9VEKJMB31wUQZECCJc5MG2UlQQyVsNIFe67+G55bk2h55gcFh
X-Gm-Message-State: AOJu0YxWN6kYtM+JTRVisTlxpf/wwIl2in4ZAfO3qPX69wRZ/VYxnp4Z
	T4z5kU5vBS8E+ccuftI0A/iaZykjEmBQie6mx3NfvQ7vYfBoY4l/Xr5/miQDVQe5kkEydbhHAQv
	+TfXVXt0ICMorCo+3Nt+ITmDdj5pcQLL51iMSDgz1BrrD39ckuA==
X-Google-Smtp-Source: AGHT+IHaStbYhTfQCh40cjCa00p/FVTyac3jnxlHzQn7kytpMqveLeq2NVuvSBF9mJ7hURK4BwkBkjTyvRVCO4CUTsc=
X-Received: by 2002:a05:6102:2265:b0:46d:2675:5ae6 with SMTP id
 v5-20020a056102226500b0046d26755ae6mr1249474vsd.15.1707813559082; Tue, 13 Feb
 2024 00:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212223029.30769-1-osalvador@suse.de> <20240212223029.30769-4-osalvador@suse.de>
In-Reply-To: <20240212223029.30769-4-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Tue, 13 Feb 2024 09:38:43 +0100
Message-ID: <CANpmjNM8pWMvEYW1YffTjy5xRgyeTOP0sGJoV31pbKU1dH5b9w@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] mm,page_owner: Display all stacks and their count
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
>
> This patch adds a new directory called 'page_owner_stacks' under
> /sys/kernel/debug/, with a file called 'show_stacks' in it.
> Reading from that file will show all stacks that were added by page_owner
> followed by their counting, giving us a clear overview of stack <-> count
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
> The seq stack_{start,next} functions will iterate through the list
> stack_list in order to print all stacks.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Marco Elver <elver@google.com>

Minor comments below.

> ---
>  mm/page_owner.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 7d1b3f75cef3..3e4b7cd7c8f8 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -84,7 +84,12 @@ static void add_stack_record_to_list(struct stack_record *stack_record)
>                         stack_list = stack;
>                 } else {
>                         stack->next = stack_list;
> -                       stack_list = stack;
> +                       /* This pairs with smp_load_acquire() from function

Comment should be

/*
 *
..
 */

(Unless in networking or other special subsystems with their own comment style.)

> +                        * stack_start(). This guarantees that stack_start()
> +                        * will see an updated stack_list before starting to
> +                        * traverse the list.
> +                        */
> +                       smp_store_release(&stack_list, stack);
>                 }
>                 spin_unlock_irqrestore(&stack_list_lock, flags);
>         }
> @@ -792,8 +797,97 @@ static const struct file_operations proc_page_owner_operations = {
>         .llseek         = lseek_page_owner,
>  };
>
> +static void *stack_start(struct seq_file *m, loff_t *ppos)
> +{
> +       struct stack *stack;
> +
> +       if (*ppos == -1UL)
> +               return NULL;
> +
> +       if (!*ppos) {
> +               /*
> +                * This pairs with smp_store_release() from function
> +                * add_stack_record_to_list(), so we get a consistent
> +                * value of stack_list.
> +                */
> +               stack = smp_load_acquire(&stack_list);

I'm not sure if it'd make your code simpler or not: there is
<linux/llist.h> for singly-linked linked lists, although the code to
manage the list is simple enough I'm indifferent here. Only consider
it if it helps you make the code simpler.

> +       } else {
> +               stack = m->private;
> +               stack = stack->next;
> +       }
> +
> +       m->private = stack;
> +
> +       return stack;
> +}
> +
> +static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
> +{
> +       struct stack *stack = v;
> +
> +       stack = stack->next;
> +       *ppos = stack ? *ppos + 1 : -1UL;
> +       m->private = stack;
> +
> +       return stack;
> +}
> +
> +static int stack_print(struct seq_file *m, void *v)
> +{
> +       char *buf;
> +       int ret = 0;
> +       struct stack *stack = v;
> +       struct stack_record *stack_record = stack->stack_record;
> +
> +       if (!stack_record->size || stack_record->size < 0 ||
> +           refcount_read(&stack_record->count) < 2)
> +               return 0;
> +
> +       buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +
> +       ret += stack_trace_snprint(buf, PAGE_SIZE, stack_record->entries,
> +                                  stack_record->size, 0);
> +       if (!ret)
> +               goto out;
> +
> +       scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
> +                 refcount_read(&stack_record->count));
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

Is this function even needed if it's empty? I recall there were some
boilerplate "nop" functions that could be used.

> +static const struct seq_operations page_owner_stack_op = {
> +       .start  = stack_start,
> +       .next   = stack_next,
> +       .stop   = stack_stop,
> +       .show   = stack_print
> +};
> +
> +static int page_owner_stack_open(struct inode *inode, struct file *file)
> +{
> +       return seq_open_private(file, &page_owner_stack_op, 0);
> +}
> +
> +static const struct file_operations page_owner_stack_operations = {
> +       .open           = page_owner_stack_open,
> +       .read           = seq_read,
> +       .llseek         = seq_lseek,
> +       .release        = seq_release,
> +};
> +
>  static int __init pageowner_init(void)
>  {
> +       struct dentry *dir;
> +
>         if (!static_branch_unlikely(&page_owner_inited)) {
>                 pr_info("page_owner is disabled\n");
>                 return 0;
> @@ -801,6 +895,9 @@ static int __init pageowner_init(void)
>
>         debugfs_create_file("page_owner", 0400, NULL, NULL,
>                             &proc_page_owner_operations);
> +       dir = debugfs_create_dir("page_owner_stacks", NULL);
> +       debugfs_create_file("show_stacks", 0400, dir, NULL,
> +                           &page_owner_stack_operations);
>
>         return 0;
>  }
> --
> 2.43.0
>

