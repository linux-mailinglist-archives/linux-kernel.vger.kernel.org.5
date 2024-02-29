Return-Path: <linux-kernel+bounces-85871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD186BC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F8A28899F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F92116;
	Thu, 29 Feb 2024 00:12:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBE15C3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165524; cv=none; b=qyFe86zvS6fiU2/YtKlBgzMaUzj9vl9ibuzIsO5D28fomhljgE20wyg2qM+Z48St7mbZ/15ZitaPyO5WHPDZWhXAa59if8bFzCFUZ2h5dfciLQNpWZ/SPUpPxXHn9gcF3Bn8fDqlD4lXjDnjswTgLO93kbkTzORRV6ubpUjY1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165524; c=relaxed/simple;
	bh=N6YGuaJ74E7TWcJgDpeFOe4+YYQa16bTIgjQ4usJsg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUQUX9FUmmV0VbkOmLoCO51SqGT/aqord5ryX7207KVpQzZJwzgzPsCm7+jAXJ9MYVQURghPlbvRiFr1TXE9UwnPZZhsiInsdI0NckeCC7tC+D8acgq4t13Y3Yu6d51v14KPq7d7jz5UEg8rkFn7WY5NohtTMP7ssBobKJ2H2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81C8C433F1;
	Thu, 29 Feb 2024 00:12:01 +0000 (UTC)
Date: Wed, 28 Feb 2024 19:14:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Vince
 Weaver <vincent.weaver@maine.edu>, Dave Jones <dsj@fb.com>, Jann Horn
 <jannh@google.com>, Miroslav Benes <mbenes@suse.cz>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Nilay Vaish <nilayvaish@google.com>
Subject: Re: [PATCH v2 06/11] x86/unwind/orc: Convert global variables to
 static
Message-ID: <20240228191406.21e894b0@gandalf.local.home>
In-Reply-To: <20240229000309.ibtuk7gr27d7cbxz@treble>
References: <cover.1587808742.git.jpoimboe@redhat.com>
	<43ae310bf7822b9862e571f36ae3474cfde8f301.1587808742.git.jpoimboe@redhat.com>
	<20240228183507.78c5f130@gandalf.local.home>
	<20240229000309.ibtuk7gr27d7cbxz@treble>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 16:03:09 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Wed, Feb 28, 2024 at 06:35:07PM -0500, Steven Rostedt wrote:
> > On Sat, 25 Apr 2020 05:03:05 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >   
> > > These variables aren't used outside of unwind_orc.c, make them static.
> > > 
> > > Also annotate some of them with '__ro_after_init', as applicable.  
> > 
> > So it appears that crash uses "lookup_num_blocks" to be able to do
> > back-traces with the ORC unwinder. But because it's now static, crash can no
> > longer do that.  
> 
> Hm, but why?  Even a static variable has a known address.
> 

I'm guessing because we don't have the full dwarf info?

-- Steve

