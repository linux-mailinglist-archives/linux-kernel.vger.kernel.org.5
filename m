Return-Path: <linux-kernel+bounces-43820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09F841933
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B43286422
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A036B11;
	Tue, 30 Jan 2024 02:23:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8A364C0;
	Tue, 30 Jan 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581438; cv=none; b=ZqSso3JR0U9rEgZ93vfYsYsUPr2i7jfFLafjd5jn4Km5L4J/LEYFxzDQPPZqT48iInF6Fq1eXn8KuIp+LwxT0RCcJk34E6CQRmN/rOpat1sjgniNeGA3+xLhXbVOmkOW1HaAI48ZArTdpjjSCdavIs7jIUkt+fXaAUp/m0Geip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581438; c=relaxed/simple;
	bh=MclRyWN5Fr1VA5Q/cVFjdRV4b2xSG14WVjCgvemUT2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3EMOGUFdnruW9aY5Egod9eVOvoyHDgQwMnHBtEuf4/WYy9b8dOT/bPouujDXvG4SBJ5RCIhrIsV5Y3KWyoJr8sdVf3MwWpLLshQXY2mOs3nkonv/hyoP1HTANuHfUGgZ89v5He0dlqsFysktw+ghcKRQzsDr7SGAveY9/o4Snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61162C433C7;
	Tue, 30 Jan 2024 02:23:57 +0000 (UTC)
Date: Mon, 29 Jan 2024 21:24:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240129212407.157a5533@gandalf.local.home>
In-Reply-To: <20240129172907.GA444-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
	<20240123220844.928-3-beaub@linux.microsoft.com>
	<20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
	<20240126191007.GA456-beaub@linux.microsoft.com>
	<20240126150445.71c5d426@gandalf.local.home>
	<20240129172907.GA444-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 09:29:07 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Thanks, yeah ideally we wouldn't use special characters.
> 
> I'm not picky about this. However, I did want something that clearly
> allowed a glob pattern to find all versions of a given register name of
> user_events by user programs that record. The dot notation will pull in
> more than expected if dotted namespace style names are used.
> 
> An example is "Asserts" and "Asserts.Verbose" from different programs.
> If we tried to find all versions of "Asserts" via glob of "Asserts.*" it
> will pull in "Asserts.Verbose.1" in addition to "Asserts.0".

Do you prevent brackets in names?

> 
> While a glob of "Asserts.[0-9]" works when the unique ID is 0-9, it
> doesn't work if the number is higher, like 128. If we ever decide to
> change the ID from an integer to say hex to save space, these globs
> would break.
> 
> Is there some scheme that fits the C-variable name that addresses the
> above scenarios? Brackets gave me a simple glob that seemed to prevent a
> lot of this ("Asserts.\[*\]" in this case).

Prevent a lot of what? I'm not sure what your example here is.

> 
> Are we confident that we always want to represent the ID as a base-10
> integer vs a base-16 integer? The suffix will be ABI to ensure recording
> programs can find their events easily.

Is there a difference to what we choose?

-- Steve

