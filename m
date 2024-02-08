Return-Path: <linux-kernel+bounces-58390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CBF84E5D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB38A28F671
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490E481204;
	Thu,  8 Feb 2024 17:01:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60573164;
	Thu,  8 Feb 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411664; cv=none; b=KyCq0ritzOtTk/RVWyjnp+ajUkq+NakIZdvXHe0i/rbUHdnliAm4eRv2OMl1IaRv2t3uaOVXyZfjdLcNwLP3+Zv2ZsNZtV0c8Rk4TtHxfnayAs92P9XLYm3A/M3Y+DQ+iQBoACLNPRmJ7EeFnsl6XNUqMrNUXDIAx47Jr7IhzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411664; c=relaxed/simple;
	bh=5FP2zStYJG2cbpb7iAuqfEvm/NVNqwfgtgdH0s+FaZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7VADpKEM1P/GDlE9y2rhgeXrHR9qaDQEEPGIFaszWhQGi9oK7HrsHZeWx286vJfPrG1witnoktC1brgN6iIkuFMbTd969HDotYBa8pNw2wHGdcKIuuLudYZ1R0yynlOzmYjlljxmmZSYFXcWufhULv4OZHFq+rlORthy4i9XDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B44C43390;
	Thu,  8 Feb 2024 17:01:01 +0000 (UTC)
Date: Thu, 8 Feb 2024 12:00:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Carlos Galo <carlosgalo@google.com>
Cc: akpm@linux-foundation.org, surenb@google.com, android-mm@google.com,
 kernel-team@android.com, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, Roman Gushchin
 <roman.gushchin@linux.dev>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] mm: Update mark_victim tracepoints fields
Message-ID: <20240208120057.01547849@rorschach.local.home>
In-Reply-To: <20240111210539.636607-1-carlosgalo@google.com>
References: <20240111210539.636607-1-carlosgalo@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jan 2024 21:05:30 +0000
Carlos Galo <carlosgalo@google.com> wrote:

> The current implementation of the mark_victim tracepoint provides only
> the process ID (pid) of the victim process. This limitation poses
> challenges for userspace tools that need additional information
> about the OOM victim. The association between pid and the additional
> data may be lost after the kill, making it difficult for userspace to
> correlate the OOM event with the specific process.
>=20
> In order to mitigate this limitation, add the following fields:
>=20
> - UID
>    In Android each installed application has a unique UID. Including
>    the `uid` assists in correlating OOM events with specific apps.
>=20
> - Process Name (comm)
>    Enables identification of the affected process.
>=20
> - OOM Score
>    Allows userspace to get additional insights of the relative kill
>    priority of the OOM victim.
>=20

=46rom a tracing POV this looks fine to me, but it's up to the mm
maintainers to decide to take it.

> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Galo <carlosgalo@google.com>
> ---
> v2: Fixed build error. Added missing comma when printing `__entry->uid`.
>=20
>  include/trace/events/oom.h | 19 +++++++++++++++----
>  mm/oom_kill.c              |  6 +++++-
>  2 files changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
> index 26a11e4a2c36..fb8a5d1b8a0a 100644
> --- a/include/trace/events/oom.h
> +++ b/include/trace/events/oom.h
> @@ -72,19 +72,30 @@ TRACE_EVENT(reclaim_retry_zone,
>  );
> =20
>  TRACE_EVENT(mark_victim,
> -	TP_PROTO(int pid),
> +	TP_PROTO(struct task_struct *task, uid_t uid),
> =20
> -	TP_ARGS(pid),
> +	TP_ARGS(task, uid),
> =20
>  	TP_STRUCT__entry(
>  		__field(int, pid)
> +		__field(uid_t, uid)
> +		__string(comm, task->comm)
> +		__field(short, oom_score_adj)
>  	),
> =20
>  	TP_fast_assign(
> -		__entry->pid =3D pid;
> +		__entry->pid =3D task->pid;
> +		__entry->uid =3D uid;
> +		__assign_str(comm, task->comm);
> +		__entry->oom_score_adj =3D task->signal->oom_score_adj;
>  	),
> =20
> -	TP_printk("pid=3D%d", __entry->pid)
> +	TP_printk("pid=3D%d uid=3D%u comm=3D%s oom_score_adj=3D%hd",
> +		__entry->pid,
> +		__entry->uid,
> +		__get_str(comm),
> +		__entry->oom_score_adj
> +	)
>  );
> =20
>  TRACE_EVENT(wake_reaper,
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 9e6071fde34a..0698c00c5da6 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -44,6 +44,7 @@
>  #include <linux/kthread.h>
>  #include <linux/init.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/cred.h>
> =20
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -753,6 +754,7 @@ static inline void queue_oom_reaper(struct task_struc=
t *tsk)
>   */
>  static void mark_oom_victim(struct task_struct *tsk)
>  {
> +	const struct cred *cred;
>  	struct mm_struct *mm =3D tsk->mm;
> =20
>  	WARN_ON(oom_killer_disabled);
> @@ -772,7 +774,9 @@ static void mark_oom_victim(struct task_struct *tsk)
>  	 */
>  	__thaw_task(tsk);
>  	atomic_inc(&oom_victims);
> -	trace_mark_victim(tsk->pid);
> +	cred =3D get_task_cred(tsk);

get_task_cred() isn't a trivial function and is used only for tracing.
But this isn't a fast path so I guess that is fine.

For tracing:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> +	trace_mark_victim(tsk, cred->uid.val);
> +	put_cred(cred);
>  }
> =20
>  /**
>=20
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a


