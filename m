Return-Path: <linux-kernel+bounces-85933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA686BCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3902B1F24664
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535EC1643D;
	Thu, 29 Feb 2024 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6oqXrPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD8184F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167374; cv=none; b=DrixLPDE/EJ7pg8tiySFl1T+jyWo/YoxDLqMxhhj7l3KGJggBr7d2QCDrwGrcnrdHfSrsMEV+kF28lMiRohy758WyY56AM2Q0r+bc3myBjACKK3x8r2Ry4VKmNHnYlGkcOj8iUdZJMGuFiuoZ3Rjfa+ZyR6KejgPcj6mtLGTbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167374; c=relaxed/simple;
	bh=QCsl9pKp5x7LKsoIXjVP5LHrz8qCzYiE3exFfnnqcQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWFirOEyY4evO3KjfEiEIicWde01ufVX8nmh6FAg7w+hrp93FmEL6lgbU0W/qL1cIb+sGdr3/FW5U1c+Kt4160NfxvjHLV48JqC3dZArz6gGU62x0lQxLtRrZPjGItW+d6v4rizD7+t2h2q6A/LMfftd2mz/PYe6b/MTN17bhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6oqXrPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9359EC433C7;
	Thu, 29 Feb 2024 00:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709167374;
	bh=QCsl9pKp5x7LKsoIXjVP5LHrz8qCzYiE3exFfnnqcQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6oqXrPCa6UtjC0C7ukWFqBHWpF59rbCjF2fm75Y7annFJmeakMabKgpaney3chYB
	 W07AWi694HDbvkHD8krVbY68fIt0ht21naZWLAUhzv4oC4mrVijLr1VLijgMYVlJdy
	 WQwIKuBdn+EajpYjaw/T0NRPhVUV85k5u9/wJuRb/1EBhmINWmETJ203joHFE0SgWh
	 KCu0WlMk7wrbNZZXB4Awn7ELYzmHxfCwoaDiSGJqQ4fYOiBY5JXWc/58ctniL2CXLT
	 9Aqu08Qgzvg8OgFxd9Y8ADGharVwXRheXmhm73avK/fRDiJ4qKv+tqB3b+7uc8SBxf
	 CJ8+T/6gwUgeA==
Date: Wed, 28 Feb 2024 16:42:52 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Vince Weaver <vincent.weaver@maine.edu>, Dave Jones <dsj@fb.com>,
	Jann Horn <jannh@google.com>, Miroslav Benes <mbenes@suse.cz>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nilay Vaish <nilayvaish@google.com>
Subject: Re: [PATCH v2 06/11] x86/unwind/orc: Convert global variables to
 static
Message-ID: <20240229004252.awmammhp63f5udyy@treble>
References: <cover.1587808742.git.jpoimboe@redhat.com>
 <43ae310bf7822b9862e571f36ae3474cfde8f301.1587808742.git.jpoimboe@redhat.com>
 <20240228183507.78c5f130@gandalf.local.home>
 <20240229000309.ibtuk7gr27d7cbxz@treble>
 <20240228191406.21e894b0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228191406.21e894b0@gandalf.local.home>

On Wed, Feb 28, 2024 at 07:14:06PM -0500, Steven Rostedt wrote:
> On Wed, 28 Feb 2024 16:03:09 -0800
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > On Wed, Feb 28, 2024 at 06:35:07PM -0500, Steven Rostedt wrote:
> > > On Sat, 25 Apr 2020 05:03:05 -0500
> > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >   
> > > > These variables aren't used outside of unwind_orc.c, make them static.
> > > > 
> > > > Also annotate some of them with '__ro_after_init', as applicable.  
> > > 
> > > So it appears that crash uses "lookup_num_blocks" to be able to do
> > > back-traces with the ORC unwinder. But because it's now static, crash can no
> > > longer do that.  
> > 
> > Hm, but why?  Even a static variable has a known address.
> > 
> 
> I'm guessing because we don't have the full dwarf info?

DWARF isn't needed for that.  Even the symbol table has it (as does
System.map).  For both globals and statics.

-- 
Josh

