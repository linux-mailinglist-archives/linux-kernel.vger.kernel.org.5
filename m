Return-Path: <linux-kernel+bounces-75190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22ED85E477
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10C7B2096C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0783CAE;
	Wed, 21 Feb 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YALYPAzg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35F7FBDC;
	Wed, 21 Feb 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536100; cv=none; b=CUOvzjVoncXDOLUjsj12zFIeXZdJjXlkGxljgiEXQpJF3QRrZaMAIKjteDeSQ8gXnP3LL8HBacROzGa45eT8+jTgmt7za5UQMs22oFIoqPW/d9f+TKH0m7QX73cnTqA+aTnxbWDyouK5z0CWDBZSsU3AyXZo5Y7Flsot320qFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536100; c=relaxed/simple;
	bh=ZBe8kLcv6nKmj/DtMCnUmXulYac4XE50siu06IguRTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMMKI7dW0/bCgVe74b2QS/0FQux45kxAzgwGdDbgunnlg+KqAM1WfW6eA7fjmxCCBGkMD8EeIq+Yuv3B9yZh+W0G2xPW5vGvFw9X8cly8zxpSI82iLzN4SouOrNnAgikWrXDcLneXw/dUdAPQkpbl1tbPy2uVy1Cuk+n9HRg+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YALYPAzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE52BC433F1;
	Wed, 21 Feb 2024 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708536099;
	bh=ZBe8kLcv6nKmj/DtMCnUmXulYac4XE50siu06IguRTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YALYPAzgCsmBYnnuiyg9ucgSc5P82e2wCmJR8GkQktqVzGFymkpUFZ+27xPwU4ap6
	 1qleZavZftPktjsGT3cy7j/Vy5ye7im27fHk3tKziM2gVRPMsvXhT8jtYknZODoqCP
	 2kGYDoTgFfVC9aUFatofLhY+ii1qY5fme21oTBu9JU7kHz/XLrj9sU9eCUGezxlM3F
	 9YbCain7BlM98d9xbiJbmLzdLyiVSSERJ4oMwsLzBAN/zKFego8jPrtbvR/AUv4JuK
	 Wy7ZtWv+008ZLF3eQa9fnwlggZx1zY9Wb/LWP+GK3lylpP/KcBgsUGHGAeMiqbL/ax
	 YMcYD/ztkSWdQ==
Date: Wed, 21 Feb 2024 14:21:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf trace: Collect sys_nanosleep first argument
Message-ID: <ZdYxHYBftzWcQAZt@x1>
References: <ZdYtJs8nWt6ALprh@x1>
 <CAP-5=fXQPEe4KSQHs421kiUa7Ttr-WqtPtcdju2WRi6rdKy4rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXQPEe4KSQHs421kiUa7Ttr-WqtPtcdju2WRi6rdKy4rw@mail.gmail.com>

On Wed, Feb 21, 2024 at 09:15:01AM -0800, Ian Rogers wrote:
> On Wed, Feb 21, 2024 at 9:04 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > That is a 'struct timespec' passed from userspace to the kernel as we
> > can see with a system wide syscall tracing:
> >
> >   root@number:~# perf trace -e nanosleep
> >        0.000 (10.102 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >       38.924 (10.077 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      100.177 (10.107 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      139.171 (10.063 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      200.603 (10.105 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      239.399 (10.064 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      300.994 (10.096 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      339.584 (10.067 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      401.335 (10.057 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      439.758 (10.166 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      501.814 (10.110 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      539.983 (10.227 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      602.284 (10.199 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      640.208 (10.105 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      702.662 (10.163 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      740.440 (10.107 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >      802.993 (10.159 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
> >   ^Croot@number:~# strace -p 9150 -e nanosleep
> >
> > If we then use the ptrace method to look at that podman process:
> >
> >   root@number:~# strace -p 9150 -e nanosleep
> >   strace: Process 9150 attached
> >   nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
> >   nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
> >   nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
> >   nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
> >   nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
> >   nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
> >   nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
> >   ^Cstrace: Process 9150 detached
> >   root@number:~#
> >
> > With some changes we can get something closer to the strace output,
> > still in system wide mode:
> >
> >   root@number:~# perf config trace.show_arg_names=false
> >   root@number:~# perf config trace.show_duration=false
> >   root@number:~# perf config trace.show_timestamp=false
> >   root@number:~# perf config trace.show_zeros=true
> >   root@number:~# perf config trace.args_alignment=0
> >   root@number:~# perf trace -e nanosleep --max-events=10
> >   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
> >   root@number:~#
> >   root@number:~# perf config
> >   trace.show_arg_names=false
> >   trace.show_duration=false
> >   trace.show_timestamp=false
> >   trace.show_zeros=true
> >   trace.args_alignment=0
> >   root@number:~# cat ~/.perfconfig
> >   # this file is auto-generated.
> >   [trace]
> >         show_arg_names = false
> >         show_duration = false
> >         show_timestamp = false
> >         show_zeros = true
> >         args_alignment = 0
> >   root@number:~#
> >
> > This will not get reused by any other syscall as nanosleep is the only
> > one to have as its first argument a 'struct timespec" pointer argument
> > passed from userspace to the kernel:
> >
> >   root@number:~# grep timespec /sys/kernel/tracing/events/syscalls/sys_enter_*/format | grep offset:16
> >   /sys/kernel/tracing/events/syscalls/sys_enter_nanosleep/format:       field:struct __kernel_timespec * rqtp;  offset:16;      size:8; signed:0;
> >   root@number:~#
> >
> > BTF based pretty printing will simplify all this, but then lets just get
> > the low hanging fruits first.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> v2? https://lore.kernel.org/lkml/Zbq72dJRpOlfRWnf@kernel.org/

Nope, I thought I hadn't submitted and when doing a

  git rebase perf-tools-next/perf-tools-next


It was rebased, so I thought I really hadn't submitted it and sent it.

- Arnaldo

