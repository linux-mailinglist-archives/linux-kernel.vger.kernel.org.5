Return-Path: <linux-kernel+bounces-48676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E352845FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED781C29E73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6469364D5;
	Thu,  1 Feb 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zD8l1c9e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FE12FB2E;
	Thu,  1 Feb 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811172; cv=none; b=ixl9bB31/03kXviLXqvT/iTxRbHLaavN2lsh0ElLmZVWdMc/rRf1P1WNw4cC0AmDTcjezIiPiRo3PObNJrBSvvPCnggRtQuL99yOKKMVE3QUzc/mQxEh32UhP/MndM+YzYxcqTQRihGY3KNxYOP7vsetP7uXK34bFbrB3PeZpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811172; c=relaxed/simple;
	bh=HJG6D28f/6UezLADAmCTHd4FJmpCRxhoaSAuded31YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2pJgCielcQxbi5tQQvoWhDdfOIlpfq0trb62KLCQDN43XXxLDjdEPamhMhTkN1SXvikBrNssFLnk03F6sLbhO0kpopks09BvdTn/7gXH28GQFIxpBz13Q53czswWnAHb0ELVxBn+15wULJLIfvDky0Qr4ICabHP0TN1kfqW1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zD8l1c9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C15BC433B2;
	Thu,  1 Feb 2024 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706811171;
	bh=HJG6D28f/6UezLADAmCTHd4FJmpCRxhoaSAuded31YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zD8l1c9e2vOlUihn2RvIcrenV1Q0sOX24MxGbP9ZBZLhH5WGNiXSsdA46Yh5JHXBM
	 h8c4VQ1fdy5RyJAVXzD000xMq5GxnBQnTvJ0ZUY97Q/4EGJGOM74ZN0WpRo3hEBxy/
	 32qciLm6jXuhp5+kde+EIX/6I3+UHIYOTzr0SoN0=
Date: Thu, 1 Feb 2024 10:12:50 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd open()
Message-ID: <2024020140-santa-bagful-51d8@gregkh>
References: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
 <2024020109-duffel-finally-4f0b@gregkh>
 <05c12163-d348-4615-a9e3-f36787629e0e@kernel.org>
 <2024020122-uncombed-moody-a96d@gregkh>
 <20240201130823.36f1da8d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201130823.36f1da8d@gandalf.local.home>

On Thu, Feb 01, 2024 at 01:08:23PM -0500, Steven Rostedt wrote:
> On Thu, 1 Feb 2024 10:05:59 -0800
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > timerlat_fd = open("/sys/kernel/tracing/osnoise/per_cpu/cpu0/timerlat_fd", 'r')
> > > timerlat_fd.close();
> > > 
> > > # ./taskset -c 0 ./timerlat_load.py
> > > <BOOM>  
> > 
> > Then obviously, this is a real, functional, change, so say so in the
> > kernel changelog :)
> 
> I've updated the change log to remove that comment and add the reproducer.

And cc: stable properly?  thanks!

