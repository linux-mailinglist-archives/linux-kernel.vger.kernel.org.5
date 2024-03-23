Return-Path: <linux-kernel+bounces-112246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA148887762
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6DA1C21DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F6C15D;
	Sat, 23 Mar 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs0nhRCd"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D73212;
	Sat, 23 Mar 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711177726; cv=none; b=PZ/bWNubTUfCMRm87UHyZ4kVgTzhHnhv5zYMMDjjHufrnUCg4tdRSInsdSnVU70YrqD0WZR0G6NnTz930mJjItmSil4umjVPSAcb40glkiHfgCg9QqrbB1APs9egt93d2GQWKresMVVxD9xkDVElpVmOajiZXvmPvKFs3wfqShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711177726; c=relaxed/simple;
	bh=fVgspY4EOYpnKDlZKazWyyXfzRIOV9DZ3JRbBOfpaQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzc+JUc8TAXsT+Xv06OCu+DS6hnbH8A5rbwsqJoRZcjJeZpvDuMj63Gcvkr/6qxGBhq8Gm87riau2Fhya0GKrlBQgG3CPNR+0BK8NKMAYK+Ok/KwXREAB7Ly9QvzCxyff2rn6Gk4nPLopiNZwTBiCq8oLyPFPjvjOBALC29hUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs0nhRCd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e1d327595so2120807f8f.2;
        Sat, 23 Mar 2024 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711177723; x=1711782523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioa5IoGRauAC6NGDXDWuGkDiL2WTD7gES4eHlPrc4A8=;
        b=hs0nhRCdBhZSqR9nnn4CWIx1CcB8DD/45IeLLtZRWHGS2B249tpblE86gtgniI98Bc
         KSTk9Y+0K43nNH4056dNNxS2R363/bgzvw7WflKIGc7zuHexGVKlIZsm3tlW43fMYb9h
         6Bo5WGvpHanqUufF4S7cxVaWh6ISV7Rbd5IsQyH0/irvbgooZwcPG1/c1EglCjlB6+Us
         LGCdguNyKITfYclDswNClpN1FvBvmZmpJ2mc/KIcgGHrj5/y8FFY+7uYbgfddYLNRJQ3
         hRkfr1bpShu8shOYswKSR+vI1FPfYvD3+8j5hXpbot0j5KmF/G44FTyb+fzSXuMdQ6ZU
         41YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711177723; x=1711782523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioa5IoGRauAC6NGDXDWuGkDiL2WTD7gES4eHlPrc4A8=;
        b=v8KZqdR5KKA9B2OhNVj/BUsMfy87JTj0aAjad7MjoqMKwHIGSfeUYWs7PYKDZoxCT9
         6rAPzAtcEcfpGNZ6nR0RuCabkXuAHXa7crCMs57wxYJO/W2sYkUTo+ZUw7HwMsn7yLh2
         U8zSWxKLCO6RFkkF8J81VwxEHZ7SctqFxrGbvQa6V3Hd9VwC/SD2YsNCdziH6rluFFDD
         bitwumacJcjPIfIj53waJIiE3CrFxToHgtjoUjXXekd0nFNDZPMpJ8+yJZwTUoPCe9b1
         nC/ZzJqi+WwsjHcyWQiTccSM6gd4OupwpJdftkOvCnHlbfB6IjI41M+O332MDbH0f5OR
         1lWA==
X-Forwarded-Encrypted: i=1; AJvYcCWmWBOVjB1+z9NKcLVLaf/UkR1TIZrjnl/5CNzPXbGZseHmv1XkZmCCv0aWGkzDzaZc3VOt5qK5gb3KsjqECgQNDRgINDLH0Mr093Ud89Y5kq1LcVTKRAJ+NZdyOBjd811tQkOniAdDYFWsFdzH4erm/M/o5i/VKftu
X-Gm-Message-State: AOJu0Yzn1WEUpOpnMEFw/VJ5Mh8+lWmrSvDcYSlPmsgDy88K7kDnLbjE
	MM/Qhw50Y4GILxHs2YtYsATOFGZs/LJr7XgsQDKB7acjuk1VBD3hVKLO7ylzUf4zIhoIhv8whaZ
	3geFgl/DM/OX47rO0GqWeMdXdILw=
X-Google-Smtp-Source: AGHT+IFd8NLEal2Phry3z0pAo7VE6Qqp40dBpBfgBNPId9t8TVhW/qLam9xv8Loai0iY1sFVTmBqPIPgI4HGVdhAH2I=
X-Received: by 2002:a5d:5051:0:b0:340:5b4:ba31 with SMTP id
 h17-20020a5d5051000000b0034005b4ba31mr1076129wrt.34.1711177722801; Sat, 23
 Mar 2024 00:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dc9aca0613ec855c@google.com> <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
In-Reply-To: <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 00:08:31 -0700
Message-ID: <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
To: Edward Adam Davis <eadavis@qq.com>, John Fastabend <john.fastabend@gmail.com>
Cc: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com, 42.hyeyoo@gmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, jakub@cloudflare.com, kafai@fb.com, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, 
	yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

John,
please review.
It seems this bug was causing multiple syzbot reports.

On Fri, Mar 22, 2024 at 10:42=E2=80=AFPM Edward Adam Davis <eadavis@qq.com>=
 wrote:
>
> [Syzbot reported]
> WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> 6.8.0-syzkaller-05221-gea80e3ed09ab #0 Not tainted
> -----------------------------------------------------
> rcu_exp_gp_kthr/18 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
> ffff88802b5ab020 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh i=
nclude/linux/spinlock.h:356 [inline]
> ffff88802b5ab020 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_dele=
te_elem+0xb0/0x300 net/core/sock_map.c:939
>
> and this task is already holding:
> ffffffff8e136558 (rcu_node_0){-.-.}-{2:2}, at: sync_rcu_exp_done_unlocked=
+0xe/0x140 kernel/rcu/tree_exp.h:169
> which would create a new lock dependency:
>  (rcu_node_0){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}
>
> but this new dependency connects a HARDIRQ-irq-safe lock:
>  (rcu_node_0){-.-.}-{2:2}
>
> ... which became HARDIRQ-irq-safe at:
>   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>   rcu_report_exp_cpu_mult+0x27/0x2f0 kernel/rcu/tree_exp.h:238
>   csd_do_func kernel/smp.c:133 [inline]
>   __flush_smp_call_function_queue+0xb2e/0x15b0 kernel/smp.c:542
>   __sysvec_call_function_single+0xa8/0x3e0 arch/x86/kernel/smp.c:271
>   instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
>   sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
>   asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry=
h:709
>   __sanitizer_cov_trace_switch+0x90/0x120
>   update_event_printk kernel/trace/trace_events.c:2750 [inline]
>   trace_event_eval_update+0x311/0xf90 kernel/trace/trace_events.c:2922
>   process_one_work kernel/workqueue.c:3254 [inline]
>   process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
>   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>   kthread+0x2f0/0x390 kernel/kthread.c:388
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>
> to a HARDIRQ-irq-unsafe lock:
>  (&htab->buckets[i].lock){+...}-{2:2}
>
> ... which became HARDIRQ-irq-unsafe at:
> ...
>   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
>   spin_lock_bh include/linux/spinlock.h:356 [inline]
>   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
>   0xffffffffa0001b0e
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
>   trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
>   __mutex_lock_common kernel/locking/mutex.c:617 [inline]
>   __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
>   futex_cleanup_begin kernel/futex/core.c:1091 [inline]
>   futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
>   exit_mm_release+0x1a/0x30 kernel/fork.c:1652
>   exit_mm+0xb0/0x310 kernel/exit.c:542
>   do_exit+0x99e/0x27e0 kernel/exit.c:865
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1027
>   __do_sys_exit_group kernel/exit.c:1038 [inline]
>   __se_sys_exit_group kernel/exit.c:1036 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> other info that might help us debug this:
>
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&htab->buckets[i].lock);
>                                local_irq_disable();
>                                lock(rcu_node_0);
>                                lock(&htab->buckets[i].lock);
>   <Interrupt>
>     lock(rcu_node_0);
>
>  *** DEADLOCK ***
> [Fix]
> Ensure that the context interrupt state is the same before and after usin=
g the
> bucket->lock.
>
> Reported-and-tested-by: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail=
com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/core/sock_map.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 27d733c0f65e..ae8f81b26e16 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct bpf_map *m=
ap, void *key)
>         struct bpf_shtab_bucket *bucket;
>         struct bpf_shtab_elem *elem;
>         int ret =3D -ENOENT;
> +       unsigned long flags;
>
>         hash =3D sock_hash_bucket_hash(key, key_size);
>         bucket =3D sock_hash_select_bucket(htab, hash);
>
> -       spin_lock_bh(&bucket->lock);
> +       spin_lock_irqsave(&bucket->lock, flags);
>         elem =3D sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_=
size);
>         if (elem) {
>                 hlist_del_rcu(&elem->node);
> @@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct bpf_map *map=
, void *key)
>                 sock_hash_free_elem(htab, elem);
>                 ret =3D 0;
>         }
> -       spin_unlock_bh(&bucket->lock);
> +       spin_unlock_irqrestore(&bucket->lock, flags);
>         return ret;
>  }
>
> @@ -1136,6 +1137,7 @@ static void sock_hash_free(struct bpf_map *map)
>         struct bpf_shtab_elem *elem;
>         struct hlist_node *node;
>         int i;
> +       unsigned long flags;
>
>         /* After the sync no updates or deletes will be in-flight so it
>          * is safe to walk map and remove entries without risking a race
> @@ -1151,11 +1153,11 @@ static void sock_hash_free(struct bpf_map *map)
>                  * exists, psock exists and holds a ref to socket. That
>                  * lets us to grab a socket ref too.
>                  */
> -               spin_lock_bh(&bucket->lock);
> +               spin_lock_irqsave(&bucket->lock, flags);
>                 hlist_for_each_entry(elem, &bucket->head, node)
>                         sock_hold(elem->sk);
>                 hlist_move_list(&bucket->head, &unlink_list);
> -               spin_unlock_bh(&bucket->lock);
> +               spin_unlock_irqrestore(&bucket->lock, flags);
>
>                 /* Process removed entries out of atomic context to
>                  * block for socket lock before deleting the psock's
> --
> 2.43.0
>

