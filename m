Return-Path: <linux-kernel+bounces-168156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637988BB465
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BF4B22F80
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E9158D6B;
	Fri,  3 May 2024 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdBrOvgB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51D134B1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714766221; cv=none; b=JqUi6syx6xwUGYlQgr0zrohXmDJTuW9M7cyTp3BeF8AZ/Tod2zl67jJQL85d8CpFz4LHjjh0dwVpkcQm33mMaGm/x/7ZRV+a//Fmhueq88PYQEY8RhliwEiY8JlC+2zVmmCrFrwumroEE3yH1rumGbiv60P/MKmBG2MkXbtbHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714766221; c=relaxed/simple;
	bh=knb1DEkpKuqFaWNSw8KT86PDMZ9bNb4DcRO+iDpfW84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHP6YEXzjTs1F3GyVTVd+1g+L+FCsGvsLcQoVoNXGV2AtspTnVeP7XcYVp/a8/1yTHhKWcOszfXdWTIHdx30HhTFS24kunLJwA+E6SuHSvYYhNSunLd7MvoIfmN6ldKQ2fXd9ASqPgf++Y7ptCOeieCiku72o3qG5+RV3xxmWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdBrOvgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FB5C116B1;
	Fri,  3 May 2024 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714766220;
	bh=knb1DEkpKuqFaWNSw8KT86PDMZ9bNb4DcRO+iDpfW84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdBrOvgByA8AcQ3Urzlz/wRFh1/Q0UliYFNV9eywCgS2OMZAnmQ2JbQeJa9JaSrEL
	 QBJWlHR8UOPR1P6JctyYIjog1A3zzpsGuUqMNzVYuENs7bETpNJAptXo1fQvIPqXGx
	 JgAOuRx9bi+V94X+B5ixwruvQAJBPXwFzZ97VqTbJaIZJymzoQqrkeCOYGNe9Xs1wV
	 O50ZVL7wm8JpUNHirr88nlDgpfjvS3hrwuWznTSp8b5ACDwHpFb8VDo2+bleTFvUbG
	 I9d+iBmJJrWM1tW3Z6qD/yy982Hf+GLV3lxg5UnPBVIdtou3IxeWvb1A0HNXI8dYQb
	 gA6gtgUccipzg==
Date: Fri, 3 May 2024 12:56:53 -0700
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
Message-ID: <20240503195653.5wkdfwno7nybepqc@treble>
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>
 <20240421052540.w7gtahoko2qerhqq@treble>
 <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
 <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
 <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>

On Thu, May 02, 2024 at 04:48:13PM -0700, Paul McKenney wrote:
> On Sun, Apr 21, 2024 at 2:47 PM Paul McKenney <paulmckrcu@gmail.com> wrote:
> >
> > And this definitely helped, thank you!
> >
> > However, this one still remains:
> >
> > vmlinux.o: warning: objtool: ia32_sys_call+0x29b6:
> > __ia32_sys_exit_group() is missing a __noreturn annotation
> 
> And looking at the patched code, this function looks to me to be
> correctly marked.
> 
> No idea...  :-/

Ah, I think I missed fixing syscall_32.tbl.  Lemme see how to do that...

-- 
Josh

