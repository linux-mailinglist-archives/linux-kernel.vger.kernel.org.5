Return-Path: <linux-kernel+bounces-133594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966589A613
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9761E1F229D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B71C36;
	Fri,  5 Apr 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4u9FmwE"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A617333E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352634; cv=none; b=uncgPLRL6pbDdu8B1NH0FM4Qaa64E1uQZ3lK7p1XlJVknKwkPY70z3slTUabmgqmW5/fgkI+rw1AU3k289BAkLHOM7zXsuNmWnT1WbImaitgNmQ3YG/OsKsaVZQLWzz5ywpcGoGqBRIvbby1erh/pSJ7/iIJALyVQ4u3OVo6Nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352634; c=relaxed/simple;
	bh=/wXCQY9VC2YObwgTZwSVracMzf0L/upLyhhw681/jbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goz4NRS3Gfdl/B+LDI7PA7Zhi3w9bUFoodb34LAom3nEr11zN6qVdAe7n6rYu63AaoKUY+e5WmPPViErvZUMjCVEm2NEofmxdkg90dcTTIqTi3OR3gqaNtgccMFoZRYSmeN27C+44EwFOsEmw3sTGN0zj8K27hfJza6BdgoHmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4u9FmwE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-432d55b0fa9so42821cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712352631; x=1712957431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wXCQY9VC2YObwgTZwSVracMzf0L/upLyhhw681/jbE=;
        b=t4u9FmwEHkfn5mkgkNkUseeUgz8csDOPgnhn7W32XzePUyLAcALHu1ohQxeNuWfQ9X
         IFdiC+BQfWkQ+3+cXLZ4CLQyg5/csVqltkLXYruawHshQoRijYyATeT08W4oMETlSrMf
         DfZFHflsW0JLtYvPCE27qVb1zENJRw7DWX1tGbfJQkoON3RYIvg8OPyQ4VBu7a1+L/Q/
         /Puehmc2ToBgabJQAEwniXqlDNfG5++s9GAOlj9GJjHXw4MOok79m1r8/DkaFiQhlgcJ
         d1HcEJC6akCM+iou+h16crtPc1telKLTScadYlKe6uBuEUFX3UvHU/BxSsM1oviFEzvW
         HDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352631; x=1712957431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wXCQY9VC2YObwgTZwSVracMzf0L/upLyhhw681/jbE=;
        b=TMQTXypbfr/e4pUlwGbVunEnoPtWGpjNoziPo6kTNYZTbDxWIP0MJW/+/YiHUDIMWA
         83MkKwcNCKeS1dbO2gvpwAiCsI+hVuuTyrR2nEnbqerPUx2Edza3pcN/IWjuA4JiIViu
         Wvv+AYQ5W6GFEpzUeFN+LdbodWqACEm6k+W4qfJ1hdHIHvzzlKzDZi9VxH4Zt9MxaQ5F
         opMXmHfm+CoNYDg5hahntGE3vH76tP2PxkGMxnxsuREtA91fJZXwirE71mejQ6WtyrwB
         A9uPqrt+fNUbIPs2F5dQS4ywU8Y9PojwhEHIu9FQ2UrNOv1Fsi/BZnJrLRFM9X5qtEF6
         9UNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAjWWPJ822ydxc73X8C56RE89JZPQma1MZfopYKtzU8AGVB6tCJAD2vJjR4ajUA8nHo3X43veW8YiWRIyYLza7/MwD+UrK204+8GuE
X-Gm-Message-State: AOJu0Yw2kcA0V8Uxme7GGX3iPFwaE6DdlK+KKnHevySAXJu+mNey2FgI
	1p1rju4BwvYjLXSW2XCMCxmfX59Yw+1W7RQNKwIg2FGF1cCcazbygRP946/9wlWoxA/7mu0ljg1
	NXGVmVFl6h3M5R+2Bp3GH6Oc/Zbzy7f+57hnq
X-Google-Smtp-Source: AGHT+IHotuSpPGdW1AUAaWUTAVTOb5iqkvDucO2JzkdGW6n0Ky9kfwJM8taS356UMjYfv/JrVyd8EHD37a15WcWcN7g=
X-Received: by 2002:a05:622a:4c87:b0:434:5e2e:a2e4 with SMTP id
 ez7-20020a05622a4c8700b004345e2ea2e4mr73005qtb.24.1712352631289; Fri, 05 Apr
 2024 14:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com> <4681c9c5-3364-4628-a581-0366d0024211@intel.com>
In-Reply-To: <4681c9c5-3364-4628-a581-0366d0024211@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 5 Apr 2024 14:30:20 -0700
Message-ID: <CALPaoCh0SbG1+VbbgcxjubE7Cc2Pb6QqhG3NH6X=WwsNfqNjtA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] x86/resctrl: Avoid searching tasklist during mongrp_reparent
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Thu, Apr 4, 2024 at 4:09=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 3/25/2024 10:27 AM, Peter Newman wrote:
> > I've been working with users of the recently-added mongroup rename
> > operation[1] who have observed the impact of back-to-back operations on
> > latency-sensitive, thread pool-based services. Because changing a
> > resctrl group's CLOSID (or RMID) requires all task_structs in the syste=
m
> > to be inspected with the tasklist_lock read-locked, a series of move
> > operations can block out thread creation for long periods of time, as
> > creating threads needs to write-lock the tasklist_lock.
>
> Could you please give some insight into the delays experienced? "long
> periods of time" mean different things to different people and this
> series seems to get more ominous as is progresses with the cover letter
> starting with "long periods of time" and by the time the final patch
> appears it has become "disastrous".

There was an incident where 99.999p tail latencies of a service
increased from 100 milliseconds to over 2 seconds when the container
manager switched from our legacy downstream CLOSID-reuse technique[1]
to mongrp_rename().

A more focused study benchmarked creating 128 threads with
pthread_create() on a production host found that moving mongroups
unrelated to any of the benchmark threads increased the completion cpu
time from 30ms to 183ms. Profiling the contention on the tasklist_lock
showed that the average contention time on the tasklist_lock was about
70ms when mongroup move operations were taking place.

It's difficult for me to access real production workloads, but I
estimated a crude figure by measuring the task time of "wc -l
/sys/fs/resctrl" with perf stat on a relatively idle Intel(R) Xeon(R)
Platinum 8273CL CPU @ 2.20GHz. As I increased the thread count, it
converged to a line where every additional 1000 threads added about 1
millisecond.

Incorporating kernfs_rename() into the solution for changing a group's
class of service also contributes a lot of overhead (about 90% of a
mongroup rename seems to be spent here), but the global impact is far
less than that of the tasklist_lock contention.


>
> >
> > To avoid this issue, this series replaces the CLOSID and RMID values
> > cached in the task_struct with a pointer to the task's rdtgroup, throug=
h
> > which the current CLOSID and RMID can be obtained indirectly during a
>
> On a high level this seems fair but using a pointer to the rdtgroup in th=
e
> task_struct means that the scheduling code needs to dereference that poin=
ter
> without any lock held. The changes do take great care and it
> would be valuable to clearly document how these accesses are safe. (pleas=
e
> see patch #4 and #6)

I'll clarify that the existing technique for revoking a CLOSID or RMID
through a blocking IPI solves most of the problem already.

>
> > context switch. Updating a group's ID then only requires the current
> > task to be switched back in on all CPUs. On server hosts with very larg=
e
> > thread counts, this is much less disruptive than making thread creation
> > globally unavailable. However, this is less desirable on CPU-isolated,
> > realtime workloads, so I am interested in suggestions on how to reach a
> > compromise for the two use cases.
>
> As I understand this only impacts moving a monitor group? To me this soun=
ds
> like a user space triggered event associated with a particular use case t=
hat
> may not be relevant to the workloads that you refer to. I think this coul=
d be
> something that can be documented for users with this type of workloads.
> (please see patch #6)

All of the existing rmdir cases seem to have the same problem, but
they must not be used frequently enough for any concerns to be raised.

It seems that it's routine for the workload of hosts to be increased
until memory bandwidth saturation, so applying and unapplying
allocation restrictions happens rather frequently.

>
> >
> > Also note that the soft-ABMC[2] proposal is based on swapping the RMID
> > values in mongroups when monitors are assigned to them, which will
> > result in the same slowdown as was encountered with re-parenting
> > monitoring groups.
> >
> > Using pointers to rdtgroups from the task_struct been used internally a=
t
>
> "have been used internally"?

Thanks, I'll fix that.

>
> > Google for a few years to support an alternate CLOSID management
> > technique[3], which was replaced by mongroup rename. Usage of this
> > technique during production revealed an issue where threads in an
> > exiting process become unreachable via for_each_process_thread() before
> > destruction, but can still switch in and out. Consequently, an rmdir
> > operation can fail to remove references to an rdtgroup before it frees
> > it, causing the pointer to freed memory to be dereferenced after the
> > structure is freed. This would result in invalid CLOSID/RMID values
> > being written into MSRs, causing an exception. The workaround for this
> > is to clear a task's rdtgroup pointer when it exits.
>
> This does not sound like a problem unique to this new implementation but =
the
> "invalid CLOSID/RMID values being written into MSRs" sounds like somethin=
g
> that happens today? Probably not worth pulling out for this reason becaus=
e
> in its current form the exiting process will keep using the original
> CLOSID/RMID that have no issue being written to MSRs.

Today the values are at worst stale and in the range of valid CLOSIDs
and RMIDs. If __resctrl_sched_in() dereferences a freed struct
rdtgroup pointer, the resulting value could be an arbitrary u32, the
vast majority of which are not valid CLOSID/RMID values.

-Peter


[1] https://lore.kernel.org/lkml/CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQ=
TfuxY4a0w@mail.gmail.com/

