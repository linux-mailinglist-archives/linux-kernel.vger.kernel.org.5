Return-Path: <linux-kernel+bounces-87843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84786D9DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD12E1C22772
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FD53FE55;
	Fri,  1 Mar 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0zuq18c"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B837705
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709261011; cv=none; b=dnotgqbJ4wP5huWJVDkmmy2lK7l87n2vGy1K8FsR4WPVjWWA/0IkZQdhnzcfGSPB6sBqWRmf2oZJj8aHDCaXaGEnUEVBHcjWbPyEBg99XJ9CNjkhU3nNm6S1981j/Gc0PXLGg6W04ycqA2utxvmFDpLyOWzAqw6yeT+nd3VJ5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709261011; c=relaxed/simple;
	bh=0MYeRlzYlhbFGKhPFiW8lIxf9Lil7u+9uxLArkgtrV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBz/GKLgRxTC5PaeI3sHrUHYa/Et3NEIQF2AOoxJJC8epTG1tAXQPFMk2QfAABUh+I7hzOzY/XRXgHw4x4VZfQmsUObuTc2AomrTXMwY1eDhw9VOlNQhY8DaELO8JCpOgTV36qYk0kXpHCKYnKiky9QXI0onOb/FES/xhTesbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0zuq18c; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so2863207a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709261008; x=1709865808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z08q0kBJblSF9bRw4esHear6BSBvtqf8ZvOJrf1lv7A=;
        b=W0zuq18cRgIPdSNJ+BZY587ugFXP9ELsYcUeDdvebur45ImzSwXpE6cUZeFtkZmslL
         7e3sIOCZG1fcZKYvgsyLxuDBa9D1sfUJn/0/TahnLsS1MVjMGPuzebuoPdUofTnBg9b3
         ltRq7xHdVty7uqo+IIB2vuaXoy1+M8/M3TlSLFnCasH2HyZNx0P9ka5myTJZBGJZYW59
         cl19v5YjGMpW1AHqjWCuGj5rRc0SL9Y6s5yEe89EAYy1tgkY4f+VfkHZlshmOOuVcfVa
         vrPLwj66KLa0JICzzx7ShPECEPJYjvEKW/crpvhausp+OTOGf0+pt3qz6q6d6kxXdbxO
         dpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709261008; x=1709865808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z08q0kBJblSF9bRw4esHear6BSBvtqf8ZvOJrf1lv7A=;
        b=vtwriAfI9pY3erBqsa00SoPdBlU78yqGS1EEkDwltNMo5S4UTjAXW+qEf7UG49tQJV
         L8CKYbyzhfPVdGbEWOVvZQrh4dQ4thK9KZjzFtnoS+evUfJrzvykk8e7fa1to9asztIc
         ycQ2yL8Trclq8ip9E90dGpbuUk/J97ZKJf9g3LBjh5QLhwJgIPsxrfpvnhtqsDbjGErp
         ameVoVHcuje+VMcAJCvyk3HbTq/6oqou6rQmN9oWh5GSvYjUscLxb+g5JO+zl/FUdHQg
         HTRSIcjST1WV2R7812Y8E2TV4qUt4LfzUZOfr7JssUo8xZ3rNoxlFdoBq4p3tcoUoWuB
         9AZg==
X-Forwarded-Encrypted: i=1; AJvYcCX/qoN+HkSr5ULo73gQcO1s30ocbLRnf7E25YSHuTpGvsxb1E7TxYrCY2HDq69fFsG+ap3ZG9gcSNHwWaNVg+ZEz94L4yC1iUJFmr9X
X-Gm-Message-State: AOJu0Yyg2wZfT8cIgrdZPDeP2CtC52SIW1/cyvhYcBDcIvD11CTSO6Ch
	HjYhw6zhkqqwQ+bo34/G33c0O+afongsxH88fYRPo857OEuPP5ga2GG4VvzymyvGxMu11xKWFoZ
	6/Fp9ITDLAqC41z8JSddQfpRUwyI=
X-Google-Smtp-Source: AGHT+IHrPYGalHUUW9O1hgesxk82s4kdd3BWoMhc3gFtio/WSfAI+34wg+7FuWe9AuOymD6Ynab6C/3b+/QE04apg7A=
X-Received: by 2002:a17:906:2516:b0:a3e:39f7:52b4 with SMTP id
 i22-20020a170906251600b00a3e39f752b4mr312779ejb.49.1709261007863; Thu, 29 Feb
 2024 18:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202104911.125894-1-brookxu.cn@gmail.com> <d9dcd170-0ceb-489b-8df3-3fe35e9b4251@redhat.com>
In-Reply-To: <d9dcd170-0ceb-489b-8df3-3fe35e9b4251@redhat.com>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Fri, 1 Mar 2024 10:43:16 +0800
Message-ID: <CADtkEefJCbijj7eS+L3kcMCBtHqze3oMkX4yXbfoJG1mT3YkQw@mail.gmail.com>
Subject: Re: [RFC PATCH] cpuset: remove /proc/PID/cpuset
To: Waiman Long <longman@redhat.com>
Cc: lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi waiman:

Thanks for analyse in detail, we found some guy use /proc/PID/cpuset
to get the path and cause a live issue.

Thanks.

Waiman Long <longman@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=8810=E6=97=
=A5=E5=91=A8=E5=85=AD 12:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2/2/24 05:49, brookxu.cn wrote:
> > From: Chunguang Xu <chunguang.xu@shopee.com>
> >
> > Now we can get all cgroup paths from /proc/PID/cgroup for
> > a long time, so it maybe useless to keep /proc/PID/cpuset,
> > besides the path get from /proc/PID/cpuset is not consistent
> > with /proc/PID/cgroup in default hierarchy, so now we may
> > can safely remove /proc/PID/cpuset to avoid the mismatch.
>
> With cgroup v2, the value of /proc/PID/cgroup may not match
> /proc/PID/cpuset. That is the expected behavior due to the way cgroup v2
> works. For example,
>
> Root [CS] --> A [CS] --> B --> C where [CS] means cpuset controller is
> enabled at that cgroup.
>
> If a process P is in cgroup C, /proc/PID/cgroup will show /A/B/C.
> However, /proc/PID/cpuset will show /A because it is where the cpuset
> controller setting will apply to process P. Also removing an existing
> procfs file may break an existing application that relies on it. So we
> don't do that unless there is a strong reason to do so.
>
> NAK
>
> >
> > root@test:~# cat /proc/1186/cgroup
> > 0::/system.slice/lmeter.service
> >
> > root@test:~# cat /proc/1186/cpuset
> > /system.slice
> >
> > Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> > ---
> >   arch/mips/configs/sb1250_swarm_defconfig |  1 -
> >   arch/sh/configs/sdk7786_defconfig        |  1 -
> >   arch/sh/configs/urquell_defconfig        |  1 -
> >   fs/proc/base.c                           |  6 ----
> >   kernel/cgroup/cpuset.c                   | 40 -----------------------=
-
> >   5 files changed, 49 deletions(-)
> >
> > diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/confi=
gs/sb1250_swarm_defconfig
> > index ce855b644bb0..2fbea9c604df 100644
> > --- a/arch/mips/configs/sb1250_swarm_defconfig
> > +++ b/arch/mips/configs/sb1250_swarm_defconfig
> > @@ -3,7 +3,6 @@ CONFIG_HIGH_RES_TIMERS=3Dy
> >   CONFIG_LOG_BUF_SHIFT=3D15
> >   CONFIG_CGROUPS=3Dy
> >   CONFIG_CPUSETS=3Dy
> > -# CONFIG_PROC_PID_CPUSET is not set
> >   CONFIG_CGROUP_CPUACCT=3Dy
> >   CONFIG_NAMESPACES=3Dy
> >   CONFIG_RELAY=3Dy
> > diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk778=
6_defconfig
> > index 7b427c17fbfe..6fe340d4860c 100644
> > --- a/arch/sh/configs/sdk7786_defconfig
> > +++ b/arch/sh/configs/sdk7786_defconfig
> > @@ -13,7 +13,6 @@ CONFIG_CGROUP_DEBUG=3Dy
> >   CONFIG_CGROUP_FREEZER=3Dy
> >   CONFIG_CGROUP_DEVICE=3Dy
> >   CONFIG_CPUSETS=3Dy
> > -# CONFIG_PROC_PID_CPUSET is not set
> >   CONFIG_CGROUP_CPUACCT=3Dy
> >   CONFIG_CGROUP_MEMCG=3Dy
> >   CONFIG_CGROUP_SCHED=3Dy
> > diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquel=
l_defconfig
> > index 445bb451a5ec..c960221a0549 100644
> > --- a/arch/sh/configs/urquell_defconfig
> > +++ b/arch/sh/configs/urquell_defconfig
> > @@ -11,7 +11,6 @@ CONFIG_CGROUP_DEBUG=3Dy
> >   CONFIG_CGROUP_FREEZER=3Dy
> >   CONFIG_CGROUP_DEVICE=3Dy
> >   CONFIG_CPUSETS=3Dy
> > -# CONFIG_PROC_PID_CPUSET is not set
> >   CONFIG_CGROUP_CPUACCT=3Dy
> >   CONFIG_CGROUP_MEMCG=3Dy
> >   CONFIG_CGROUP_SCHED=3Dy
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 98a031ac2648..8dcd23b9212a 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3309,9 +3309,6 @@ static const struct pid_entry tgid_base_stuff[] =
=3D {
> >   #ifdef CONFIG_LATENCYTOP
> >       REG("latency",  S_IRUGO, proc_lstats_operations),
> >   #endif
> > -#ifdef CONFIG_PROC_PID_CPUSET
> > -     ONE("cpuset",     S_IRUGO, proc_cpuset_show),
> > -#endif
> >   #ifdef CONFIG_CGROUPS
> >       ONE("cgroup",  S_IRUGO, proc_cgroup_show),
> >   #endif
> > @@ -3658,9 +3655,6 @@ static const struct pid_entry tid_base_stuff[] =
=3D {
> >   #ifdef CONFIG_LATENCYTOP
> >       REG("latency",  S_IRUGO, proc_lstats_operations),
> >   #endif
> > -#ifdef CONFIG_PROC_PID_CPUSET
> > -     ONE("cpuset",    S_IRUGO, proc_cpuset_show),
> > -#endif
> >   #ifdef CONFIG_CGROUPS
> >       ONE("cgroup",  S_IRUGO, proc_cgroup_show),
> >   #endif
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index ba36c073304a..908cd7e6efa8 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -5066,46 +5066,6 @@ void __cpuset_memory_pressure_bump(void)
> >       rcu_read_unlock();
> >   }
> >
> > -#ifdef CONFIG_PROC_PID_CPUSET
> > -/*
> > - * proc_cpuset_show()
> > - *  - Print tasks cpuset path into seq_file.
> > - *  - Used for /proc/<pid>/cpuset.
> > - *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
> > - *    doesn't really matter if tsk->cpuset changes after we read it,
> > - *    and we take cpuset_mutex, keeping cpuset_attach() from changing =
it
> > - *    anyway.
> > - */
> > -int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
> > -                  struct pid *pid, struct task_struct *tsk)
> > -{
> > -     char *buf;
> > -     struct cgroup_subsys_state *css;
> > -     int retval;
> > -
> > -     retval =3D -ENOMEM;
> > -     buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> > -     if (!buf)
> > -             goto out;
> > -
> > -     css =3D task_get_css(tsk, cpuset_cgrp_id);
> > -     retval =3D cgroup_path_ns(css->cgroup, buf, PATH_MAX,
> > -                             current->nsproxy->cgroup_ns);
> > -     css_put(css);
> > -     if (retval =3D=3D -E2BIG)
> > -             retval =3D -ENAMETOOLONG;
> > -     if (retval < 0)
> > -             goto out_free;
> > -     seq_puts(m, buf);
> > -     seq_putc(m, '\n');
> > -     retval =3D 0;
> > -out_free:
> > -     kfree(buf);
> > -out:
> > -     return retval;
> > -}
> > -#endif /* CONFIG_PROC_PID_CPUSET */
> > -
> >   /* Display task mems_allowed in /proc/<pid>/status file. */
> >   void cpuset_task_status_allowed(struct seq_file *m, struct task_struc=
t *task)
> >   {
>

