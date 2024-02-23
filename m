Return-Path: <linux-kernel+bounces-78578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6E186154D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF10F1C21ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97F881ACA;
	Fri, 23 Feb 2024 15:13:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE435EF1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701185; cv=none; b=PTdXddrrXfRJJcFOJZvyg9M4unTFqpfNC41nmtw6Nl+YTVMQ9bmF0Y+YJco146QINDPxHFfoc8bQM4rD2ABMCd9qY0PEzSQAeTN87CwRsSGIa9Of5M2Gk/rmsdLbtBCILfUv211t7NPzMSaYIU/5E4eIRib8RLs7qOOu8oeqHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701185; c=relaxed/simple;
	bh=vHd3FYt9Efa+bMZ0+xD3vTKyeLH+4aXhKA+sU9dr4a8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncMOZQqNVJld6YM9Bwh8zRJhnli6YesTc9i1k5cg65b5O5Vtsley4/An+XAZ9rKWMc0r2HKdfPmCZRnq018hzEJEA9DmZwTvbZqwgcwKNMEFshg+1dBh/ZvYuG8yDO8xGVdsinaWWnSe/nBUfiWdYlgoKWk6L1+F4urm+hsskSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A4BC433F1;
	Fri, 23 Feb 2024 15:13:03 +0000 (UTC)
Date: Fri, 23 Feb 2024 10:14:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [for-next][PATCH 06/13] NFSD: Fix nfsd_clid_class use of
 __string_len() macro
Message-ID: <20240223101456.25ca7bab@gandalf.local.home>
In-Reply-To: <191757a0ccb52fefa17b690a44299442fcb4e052.camel@kernel.org>
References: <20240223141838.985298316@goodmis.org>
	<20240223141902.394601874@goodmis.org>
	<191757a0ccb52fefa17b690a44299442fcb4e052.camel@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 09:36:14 -0500
Jeff Layton <jlayton@kernel.org> wrote:

> On Fri, 2024-02-23 at 09:18 -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > I'm working on restructuring the __string* macros so that it doesn't need
> > to recalculate the string twice. That is, it will save it off when
> > processing __string() and the __assign_str() will not need to do the work
> > again as it currently does.
> > 
> > Currently __string_len(item, src, len) doesn't actually use "src", but my
> > changes will require src to be correct as that is where the __assign_str()
> > will get its value from.
> > 
> > The event class nfsd_clid_class has:
> > 
> >   __string_len(name, name, clp->cl_name.len)
> > 
> > But the second "name" does not exist and causes my changes to fail to
> > build. That second parameter should be: clp->cl_name.data.
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/20240222122828.3d8d213c@gandalf.local.home
> > 

> 
> Acked-by: Jeff Layton <jlayton@kernel.org>

Thanks!

-- Steve

