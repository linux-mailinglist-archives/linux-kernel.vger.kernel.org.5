Return-Path: <linux-kernel+bounces-34600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C59E83824D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2851F26E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0045B1FE;
	Tue, 23 Jan 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gSxjq6L4"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CD5A7B8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974310; cv=none; b=b7r7kqv5SnqeNmB7lju5DmKhUzaaxSlgXgEZ7Bk3ohI5JqORBKLzNEYMNUjxR+ukvWqB1V5D7DiNkUCe3M6Ccq5CVEgbE/OxRQZwjSXdGsZDkKQf7a3EzvtsVae7sSB3ESnTpKW65bwdbl0SCsShLUrENww4gER2c74xgAGgIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974310; c=relaxed/simple;
	bh=llB5x6WTwB3VTxhU+Zc/FGnN1UnmoBuh4s8GHoDEZPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n84tfrNSYZij1BALsVsYCeYIN0vIyg9pMLgWXrfdx+IjTekRTmnjfjTrKnH6GOtht3EeiziP+W35JFs+tqUyWuHgtPfI0QCuUlOaOcCq8iC4BIw0NrfC0Gm6XEVAeXexpC2pg8DfBI6DJldU4Dw2vsHFlKGxFmMXM2j2F6Xuj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gSxjq6L4; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Jan 2024 09:44:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705974305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nxUAt2BRtxbUt4m0RqE/VY6i4Z/ctqEoTRjSobIK9M=;
	b=gSxjq6L46IdL7730XzmjlUU+g5oXXpyGCe8MDStV7Rl6olklRJYipMuNBqHPhLDmHro+6X
	m+Jk2/RdhAHnbSCM7UWKHafS5LxdtCVp5M3EhhMP/X6GIRCtA40TP1sjlVCRC7JpM7wgvJ
	+6AzA3qEg3UoxnuPm45QRHGuM22XsIU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Guo <dongtai.guo@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Andrew Morton
 <akpm@linux-foundation.org>, George Guo <guodongtai@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu_fail event trace
Message-ID: <20240123094443.00007b20@linux.dev>
In-Reply-To: <20240122105700.05e5ee46@gandalf.local.home>
References: <20240122073629.2594271-1-dongtai.guo@linux.dev>
	<20240122105700.05e5ee46@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On Mon, 22 Jan 2024 10:57:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 22 Jan 2024 15:36:29 +0800
> George Guo <dongtai.guo@linux.dev> wrote:
> 
> > From: George Guo <guodongtai@kylinos.cn>
> > 
> > Add do_warn, warn_limit fields to the output of the
> > percpu_alloc_percpu_fail ftrace event.
> > 
> > This is required to percpu_alloc failed with no warning showing.  
> 
> You mean to state;
> 
>   In order to know why percpu_alloc failed but produces no warnings,
> the do_warn and warn_limit should be traced to let the user know it
> was rate-limited.
> 
> Or something like that?
> 
> Honestly, I don't think that the trace event is the proper place to do
> that. The trace event just shows that it did fail. If you are
> confused to why it doesn't print to dmesg, then you can simply add a
> kprobe to see those values as well.
> 
> -- Steve
> 
> > 
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > --- 

There are two reasons of percpu_alloc failed without warnings: 

1. do_warn is false
2. do_warn is true and warn_limit is reached the limit.

Showing do_warn and warn_limit makes things simple, maybe dont need
kprobe again.

