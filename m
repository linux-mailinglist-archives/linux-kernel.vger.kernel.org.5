Return-Path: <linux-kernel+bounces-168199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82358BB502
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FB4284EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313242D05E;
	Fri,  3 May 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp6osNYl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424A23775
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769061; cv=none; b=XR785hLUtSMxKktTZpcExwHK9KWRnE8bEOx7pvWv7RGc0ppNUVo3ll2sHYiNfL6mVpb2dLKF6RsyJpH4SdL6QVheLiOYuYk879ilXmCOfThFfnaQsoKuIkd9vgucHaP/QSo/FcA5MWl9Ga42f+du1NERC2Q3dS1IgJVCVHZKR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769061; c=relaxed/simple;
	bh=VE7V4SIUfe1zCt37EDtWVzjhKzO2WS4pVTTO1nQaaxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds06DHknaZwrkRM8mX7HhVNA2DdJ9tztGVrekmiu7juR0VTXL+kw9xuJjie0AGUbbvSuPXy0irMs8KNN9prd8+cCJNgJhi8nGyIm/e6GYue0ISqggrXlsuCnd7Ym4nmb0cbxUepXGZ8PNJtH8Y97JcqLnmEnP5vYAxUab6nB9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tp6osNYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85AEC116B1;
	Fri,  3 May 2024 20:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714769061;
	bh=VE7V4SIUfe1zCt37EDtWVzjhKzO2WS4pVTTO1nQaaxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tp6osNYl3Gi1Cvl045VauvM3F++OaR6ATK2YMWZitYSxx/FsGwZtHbWCNV6Ausev6
	 DhAKWYklQPhf44g40HyLjarrbueNbIN9vvbZBiZ+367JeFfsxtqBQAwkj7sMDjyPL0
	 O9XAiGIG3Zq452RaOost7vskNHGPPS80uQeoez8LcMqb0iV0Mrwt/Ly2x6xWWz2De/
	 EXUu0OIdHXbrYUJzCKwKkB3GmJaCZSZeR1uq7Ad0hC61O5IptjaOZEM56uxynnu8ox
	 HiH2Bj2sMfzRpaZKw5HqlWbs/reKPR8N3Dc2a3y3NnvpZgPJDDiwRFumHcBUAYxdo5
	 XnE7frtkdMiGA==
Date: Fri, 3 May 2024 13:44:17 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Paul McKenney <paulmckrcu@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <20240503204417.2kxp2i3xjdmtapxq@treble>
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>
 <20240421052540.w7gtahoko2qerhqq@treble>
 <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
 <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
 <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>
 <20240503195653.5wkdfwno7nybepqc@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503195653.5wkdfwno7nybepqc@treble>

On Fri, May 03, 2024 at 12:57:00PM -0700, Josh Poimboeuf wrote:
> On Thu, May 02, 2024 at 04:48:13PM -0700, Paul McKenney wrote:
> > On Sun, Apr 21, 2024 at 2:47 PM Paul McKenney <paulmckrcu@gmail.com> wrote:
> > >
> > > And this definitely helped, thank you!
> > >
> > > However, this one still remains:
> > >
> > > vmlinux.o: warning: objtool: ia32_sys_call+0x29b6:
> > > __ia32_sys_exit_group() is missing a __noreturn annotation
> > 
> > And looking at the patched code, this function looks to me to be
> > correctly marked.
> > 
> > No idea...  :-/
> 
> Ah, I think I missed fixing syscall_32.tbl.  Lemme see how to do that...

Can you try adding this on top?

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 5f8591ce7f25..f30b608d14dc 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -12,7 +12,7 @@
 # The abi is always "i386" for this file.
 #
 0	i386	restart_syscall		sys_restart_syscall
-1	i386	exit			sys_exit
+1	i386	exit			sys_exit			0 noreturn
 2	i386	fork			sys_fork
 3	i386	read			sys_read
 4	i386	write			sys_write
@@ -263,7 +263,7 @@
 249	i386	io_cancel		sys_io_cancel
 250	i386	fadvise64		sys_ia32_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
-252	i386	exit_group		sys_exit_group
+252	i386	exit_group		sys_exit_group			0 noreturn
 253	i386	lookup_dcookie
 254	i386	epoll_create		sys_epoll_create
 255	i386	epoll_ctl		sys_epoll_ctl

