Return-Path: <linux-kernel+bounces-72684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201C85B739
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B769288707
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30A5F55D;
	Tue, 20 Feb 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsV8kq1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D815F47D;
	Tue, 20 Feb 2024 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420988; cv=none; b=f5t2ZlV9hEjK/fhcPkjWq/vV0c7ctacV9bkWRL9m8vy9FbCOd6jm4LpGDu8b0LUzzM2SDDZCtYOqU40bzvqtR9E68Cq708dhrqMhlRBtlUau6cyCZvYHfh8ivwjoMAGb0Z82hicn2IrBhMkF0xuSZmgCyptivGS6r1VGm87Ls9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420988; c=relaxed/simple;
	bh=osi20qLqP/u+YS8hH5ohNztjjzr2XsST9kPCkjDKYPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twatv7oUfGnjdYMaJAV24DDczJEM70PFnlTEfUdW02iH1jntqOtfGYMOT4mwUUBrvE6D4L1Ve3R8def/ZVp7WgnwyKtYI3mw1yhq8x22mAdBwFQPondjRemczNYKt8HvlBcM9dJGH5BcnVwVotDXUygjCRwbACmc4dXA7MMnIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsV8kq1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC01C433F1;
	Tue, 20 Feb 2024 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708420987;
	bh=osi20qLqP/u+YS8hH5ohNztjjzr2XsST9kPCkjDKYPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsV8kq1x7HobSqAQRbMoEXYiEuOXiWsPHba7F7GqG7gv3Jk5m+Oknxx30WrTMeH2P
	 VTtNCgj6RnaKXBVRNLfMOorXZG0G3x2DQYMVVhgPGh+27skeckZT2lJN6Ev8FcpQ+k
	 CXeHm6njCG+KirlbynZu7SZKmpiPYo3y/UjHvv6RiHsVht0Ki2/K8qAbxNC2wCxkV8
	 eNx4nCUlFS5GgYKiZYnpm7SAwQKoVQ3tlV/3/Vq6YpP3qou4MMH8caojd2o9j6eICd
	 lyOFmzieO8Ghh8gM6yJlY8c/Y93VKdHP7M2rvHTsDmHaNX6o441HruQP+l9L16oVvg
	 fb0Ue3K5csgbA==
Date: Tue, 20 Feb 2024 10:22:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
References: <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
 <20240220090255.GA7783@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220090255.GA7783@redhat.com>

On Tue, Feb 20, 2024 at 10:02:56AM +0100, Oleg Nesterov wrote:
> On 02/20, Christian Brauner wrote:
> >
> > On Fri, Feb 16, 2024 at 07:12:14PM +0100, Oleg Nesterov wrote:
> > > On 02/16, Christian Brauner wrote:
> > > >
> > > > > SI_USER means that the target can trust the values of si_pid/si_uid
> > > > > in siginfo.
> > > >
> > > > Bah, what an annoying nonsense. I see that this can be used to emulate
> > > > stuff like SI_TIMER and SI_ASYNCIO. But I very much doubt the value of
> > > > e.g., emulating SI_DETHREAD. Maybe I'm missing something very obvious.
> > >
> > > I don't understand...
> >
> > My question was what the purpose of being able to to set si_code to
> > e.g., SI_DETHREAD is and then to send a signal to yourself? Because it
> > looks like that's what rt_{tg}sigqueueinfo() and pidfd_send_signal()
> > allows the caller to do. I'm just trying to understand use-cases for
> > this.
> 
> Ah. IIRC criu uses this hack to restore the pending (arbitrary) signals
> collected at dump time.
> 
> I was a bit surprise sys_pidfd_send_signal() allows this hack too, I don't

I think that we simply mirrored the restrictions in the other system
calls.

> think that criu uses pidfd at restore time, but I do not know.

Hm, I just checked and it doesn't use pidfd_send_signal(). It uses
pidfds but only for pid reuse detection for RPC clients.

So right now si_code is blocked for >= 0 and for SI_TKILL. If we were to
simply ensure that si_code can't be < 0 then this amounts to effectively
blocking @info from being filled in by userspace at all. Because 0 is a
valid value.

So could we just _try_ and either ignore the @info argument completely
or consistenly report EINVAL when @info is non-NULL and see if anyone
reports a regression? If there ever is a valid use-case then we can just
add a flag argument PIDFD_SIGNAL_INFO to indicate that @info should be
taken into account.

So something like the completely untested?

diff --git a/kernel/signal.c b/kernel/signal.c
index cf6539a6b1cb..2cca42175480 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3849,22 +3849,6 @@ static bool access_pidfd_pidns(struct pid *pid)
        return true;
 }

-static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
-               siginfo_t __user *info)
-{
-#ifdef CONFIG_COMPAT
-       /*
-        * Avoid hooking up compat syscalls and instead handle necessary
-        * conversions here. Note, this is a stop-gap measure and should not be
-        * considered a generic solution.
-        */
-       if (in_compat_syscall())
-               return copy_siginfo_from_user32(
-                       kinfo, (struct compat_siginfo __user *)info);
-#endif
-       return copy_siginfo_from_user(kinfo, info);
-}
-
 static struct pid *pidfd_to_pid(const struct file *file)
 {
        struct pid *pid;
@@ -3911,6 +3895,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
        if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
                return -EINVAL;

+       /* Currently unused. */
+       if (info)
+               return -EINVAL;
+
        f = fdget(pidfd);
        if (!f.file)
                return -EBADF;
@@ -3945,23 +3933,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
                break;
        }

-       if (info) {
-               ret = copy_siginfo_from_user_any(&kinfo, info);
-               if (unlikely(ret))
-                       goto err;
-
-               ret = -EINVAL;
-               if (unlikely(sig != kinfo.si_signo))
-                       goto err;
-
-               /* Only allow sending arbitrary signals to yourself. */
-               ret = -EPERM;
-               if ((task_pid(current) != pid) &&
-                   (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
-                       goto err;
-       } else {
-               prepare_kill_siginfo(sig, &kinfo, type);
-       }
+       prepare_kill_siginfo(sig, &kinfo, type);

        if (type == PIDTYPE_PGID)
                ret = kill_pgrp_info(sig, &kinfo, pid);


