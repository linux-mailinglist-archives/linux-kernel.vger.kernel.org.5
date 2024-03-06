Return-Path: <linux-kernel+bounces-93803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D8F8734D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0032F1F22A45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE1A60B80;
	Wed,  6 Mar 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdmmeZGj"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121FD605B2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722177; cv=none; b=NbJuZnTIuEEaHyO31d2sBLfQ4T9VeKBbSo7cD2fhiTGgNZp+PTHlBBLy6CjyCgWIx7MpEcajz65r/s+9vIXs4txVeANxVMKfbGH+orRzDd9E0GBtFz4fzjRiZ1YCN7va3GQbLHt/nFX8yWbPwS3v5ffozT+XTwLABRTiC4PMFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722177; c=relaxed/simple;
	bh=RASrq3LBTekIgSKG7TbLLKECG+SrNyOwLafAkERxv94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGa/vqbInIKWFAjYlLCZYmasY15L6XoeVdFqeKKjVMB2cQ/RNh1qyxJcuw+GIwHcGi8N8wPfv4osGXLMYE519N347Wb2gv94Pe1KHNFbTCETu0xYrB38TFL1tKZULNTuckmQDLPFoEenXXmAjI50ZAUMEH6HwiA43m2efsnlFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdmmeZGj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33de4d3483eso4133688f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709722174; x=1710326974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmiutPs420KSubfj+E41AV5jWZP3h7vvOSaBZaC9xL0=;
        b=JdmmeZGjN6ACa8pcWynXSw/Sk3ibfpc+h/Nktcl9+z/Rjj50TCSRIGCKVBHsHTa6WU
         L1X2Zhr8zeipNbM/iXMaowEFJl6gO/JW7yHi+giDQBboojZ6Y4N8n9Q+oSwekATJplMr
         PVeXye5+MCLUud04JYqHiX8yTlwEJ9KbfIf8SY2sScr5uXbh8nWxSsicaTkO62EAa7UL
         i55tuw8ix+2OdNcWgLGLwdOpGeQhF4tpB/WLmTRZ7wamzEUium3tL7Bom8Kh/fRHkqmX
         NiGYKFp3v24j4psntFMDB1bUB3Vj5pm2Du9RdoErXLJi31TjL87bkgSNP40bD+i/8NE6
         VN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722174; x=1710326974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmiutPs420KSubfj+E41AV5jWZP3h7vvOSaBZaC9xL0=;
        b=rVbYOSA8J3bc+JpmajUyS81gM/2GK6m/9j/5enjskSUHVRtQaC0NwGd0AoBFsdpASG
         zRCrd0BxRF0EIwMZzK0eKCGPjt6q2pQz5mjzj/U8ma/orRAeoHWUakgRv2PSGebxLd8L
         vxYVh98a9UKSC7OUlgLoGSSAMbB85+i7ATBTHd9LtzT197D9AGDifbuxjhRHRyPDz7G4
         dI7fpqS99PFIGIBJOfFQrcLY3SEI/bz9ma+lbKR9AtaK1dl4VS+NfmH0gQsUlxJMhvTz
         Y31NfnjmmmOtgKw2uwdXl4snTO7B1THV2ZMT3dqOKNXhBRlxaF6yjf+gC+ieEaWWSCbD
         D1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNiERYe88/FT/9jIuAT/SIOBhDj1ySK5X5zNxhSbzfPbW0+V7b6kF46NJ4dcJdikZ9N9OXx7XjFjtxM8dbXeJCCyfYNcvVLu5A1zR+
X-Gm-Message-State: AOJu0YxKHH+kM3s1orZZt0A3jMJLffQupjyM9zaklWVwbMqtq6HC/LYh
	uKPoib8OxalR9fD4yXfAUo4WHRVTcQs8Gfx/fTO8Teel6M6UF0iSjYHaNzGCA7AvducKgvMqv8P
	JuoofW2mKXZs/be2aBjcWmwHz3ta5jmdhowA=
X-Google-Smtp-Source: AGHT+IHuDffvn/pnnziaF4PScFMpADJINdhzS4hqx6J2YTbhZdXnevKvtPrPZgkBTOW92T27l1SGBqRt+5kxzCXiHsU=
X-Received: by 2002:adf:e883:0:b0:33d:1720:8cfd with SMTP id
 d3-20020adfe883000000b0033d17208cfdmr10811564wrm.41.1709722174393; Wed, 06
 Mar 2024 02:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner> <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner> <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner> <20240305-gremien-faucht-29973b61fb57@brauner>
In-Reply-To: <20240305-gremien-faucht-29973b61fb57@brauner>
From: Matt Denton <mpdenton@google.com>
Date: Wed, 6 Mar 2024 02:49:21 -0800
Message-ID: <CAFsT0xi1Dkv4eoG86vBHWvTzS=JjmrxBf0BNLDafi-Eq2H2tfw@mail.gmail.com>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Matthew Denton <mpdenton@chromium.org>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	kernel@collabora.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Guenter Roeck <groeck@chromium.org>, Doug Anderson <dianders@chromium.org>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Mike Frysinger <vapier@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The SECCOMP_RET_USER_NOTIF sandbox is partially implemented but the
reason we needed it (glibc blocking signals during certain syscalls we
wanted to emulate) got reverted and we haven't had any important
issues with the SECCOMP_RET_TRAP sandbox since then. /proc/pid/mem was
always restricted on ChromeOS so the plan was to use
process_vm_readv() and process_vm_writev() in the unsandboxed broker
process. We knew about the pid race of course, but this would be far
from the only place that Chrome would be potentially vulnerable to the
race so it didn't seem any worse.

We did need to use process_vm_writev() for some syscalls, like
emulating stat() required us to write into the supervised process.

On Tue, Mar 5, 2024 at 3:03=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Mar 05, 2024 at 10:58:31AM +0100, Christian Brauner wrote:
> > On Tue, Mar 05, 2024 at 01:41:29AM -0800, Kees Cook wrote:
> > > On Tue, Mar 05, 2024 at 09:59:47AM +0100, Christian Brauner wrote:
> > > > > > Uhm, this will break the seccomp notifier, no? So you can't tur=
n on
> > > > > > SECURITY_PROC_MEM_RESTRICT_WRITE when you want to use the secco=
mp
> > > > > > notifier to do system call interception and rewrite memory loca=
tions of
> > > > > > the calling task, no? Which is very much relied upon in various
> > > > > > container managers and possibly other security tools.
> > > > > >
> > > > > > Which means that you can't turn this on in any of the regular d=
istros.
> > > > >
> > > > > FWIW, it's a run-time toggle, but yes, let's make sure this works
> > > > > correctly.
> > > > >
> > > > > > So you need to either account for the calling task being a secc=
omp
> > > > > > supervisor for the task whose memory it is trying to access or =
you need
> > > > > > to provide a migration path by adding an api that let's caller'=
s perform
> > > > > > these writes through the seccomp notifier.
> > > > >
> > > > > How do seccomp supervisors that use USER_NOTIF do those kinds of
> > > > > memory writes currently? I thought they were actually using ptrac=
e?
> > > > > Everything I'm familiar with is just using SECCOMP_IOCTL_NOTIF_AD=
DFD,
> > > > > and not doing fancy memory pokes.
> > > >
> > > > For example, incus has a seccomp supervisor such that each containe=
r
> > > > gets it's own goroutine that is responsible for handling system cal=
l
> > > > interception.
> > > >
> > > > If a container is started the container runtime connects to an AF_U=
NIX
> > > > socket to register with the seccomp supervisor. It stays connected =
until
> > > > it stops. Everytime a system call is performed that is registered i=
n the
> > > > seccomp notifier filter the container runtime will send a AF_UNIX
> > > > message to the seccomp supervisor. This will include the following =
fds:
> > > >
> > > > - the pidfd of the task that performed the system call (we should
> > > >   actually replace this with SO_PEERPIDFD now that we have that)
> > > > - the fd of the task's memory to /proc/<pid>/mem
> > > >
> > > > The seccomp supervisor will then perform the system call intercepti=
on
> > > > including the required memory reads and writes.
> > >
> > > Okay, so the patch would very much break that. Some questions, though=
:
> > > - why not use process_vm_writev()?
> >
> > Because it's inherently racy as I've explained in an earlier mail in
> > this thread. Opening /proc/<pid>/mem we can guard via:
> >
> > // Assume we hold @pidfd for supervised process
> >
> > int fd_mem =3D open("/proc/$pid/mem", O_RDWR);:
> >
> > if (pidfd_send_signal(pidfd, 0, ...) =3D=3D 0)
> >         write(fd_mem, ...);
> >
> > But we can't exactly do:
> >
> > process_vm_writev(pid, WRITE_TO_MEMORY, ...);
> > if (pidfd_send_signal(pidfd, 0, ...) =3D=3D 0)
> >         write(fd_mem, ...);
> >
> > That's always racy. The process might have been reaped before we even
> > call pidfd_send_signal() and we're writing to some random process
> > memory.
> >
> > If we wanted to support this we'd need to implement a proposal I had a
> > while ago:
> >
> > #define PROCESS_VM_RW_PIDFD (1 << 0)
> >
> > process_vm_readv(pidfd,  ..., PROCESS_VM_RW_PIDFD);
> > process_vm_writev(pidfd, ..., PROCESS_VM_RW_PIDFD);
> >
> > which is similar to what we did for waitid(pidfd, P_PIDFD, ...)
> >
> > That would make it possible to use a pidfd instead of a pid in the two
> > system calls. Then we can get rid of the raciness and actually use thos=
e
> > system calls. As they are now, we can't.
>
> What btw, is the Linux sandbox on Chromium doing? Did they finally move
> away from SECCOMP_RET_TRAP to SECCOMP_RET_USER_NOTIF? I see:
>
> https://issues.chromium.org/issues/40145101
>
> What ever became of this?

