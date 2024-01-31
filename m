Return-Path: <linux-kernel+bounces-47339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82231844CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170481F223E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A539FD3;
	Wed, 31 Jan 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg2xm+pl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C43A1DF;
	Wed, 31 Jan 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742439; cv=none; b=oIZouqFg6om4PkazWvteYjip57WQfqCxfRF3nj+Rg3zOJsyiXTvpSgrZiY39SlHXc3nJr7OfG6n+rIPmavQrExTV+yq23gc97IRZ0s0Lz+lZsx2DXvM7CHJQd/FtdfiW963eDUnu1jio5kZSfRaqfVKcnrCOByPvn/gZWEJjHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742439; c=relaxed/simple;
	bh=Wggs9PE5/hrQg3P8oEkZJ8ajg/xH6BAOahmm/U0oUOo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k/XhOLipqfc1Z/bHo+jZKdmwD9jwtaHC8eWvgMld/lM9whYVhBznwYJVcGGH0F/F0D6Si0S2n6K1FYtJVg3fF2i9hmp//ZTc7H9cV1tF7gDeQsN7JTxWe7UuyBNp0WvW1Lb0bXVGGp2dgOA2kTrE4Po7SA/rtgp4sdFzKzZibI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg2xm+pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BE0C433F1;
	Wed, 31 Jan 2024 23:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742439;
	bh=Wggs9PE5/hrQg3P8oEkZJ8ajg/xH6BAOahmm/U0oUOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fg2xm+pl+AZChWrhKCFxSfuF16PIGB9b2sztYsV/VK+gs6ut7QbZYZvqMW0wsbNMk
	 OZ1dAaHlwUS3MIpzzOb7SczBccTUPdSVpSKC4vE1K3L8I7pkyEkLdSwJ6RQUCFqSlI
	 zjdCc9PU95y8Ul4Korc5MsWnCy2NnOMcpw52JmBldkUMbpA7gqQRsdKZBhVmYggybV
	 Jic2++Y3Mq5RcdiJZxFIjMTdgGtm4Nx8coxV/rkNlRJKLplcf6ksGalel8U/FoBg3c
	 J6W97UYMmiZu+QUZSLsCmT6aQdeM7mMZba8YqC5Qy9I5BguQwmDfCL+Eni6/qRudcM
	 d0VHAMNB7My2w==
Date: Thu, 1 Feb 2024 08:07:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate
 function
Message-Id: <20240201080715.80fadd15f38396c95bf39a00@kernel.org>
In-Reply-To: <20240131130039.241c8978@gandalf.local.home>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-6-torvalds@linux-foundation.org>
	<20240131130039.241c8978@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 13:00:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 30 Jan 2024 11:03:55 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > It would probably be cleaner to make eventfs its own filesystem, or at
> > least set its own dentry ops when looking up eventfs files.  But as it
> > is, only eventfs dentries use d_fsdata, so we don't really need to split
> > these things up by use.
> 
> BTW, I have been thinking about making eventfs a completely separate file
> system that could be mounted outside of tracefs. One that is readonly that
> only contains the "id" and "format" files and nothing more.
> 
> Why? Because perf and powertop both use those files to know how to parse
> the raw event formats. I don't think there's anything in there that
> requires root privileges to read. They should not be exposing any internal
> kernel information besides the event format layouts, and it would be nice
> to have a /sys/kernel/events directory that only had that.

That's a good idea! So maybe we can allow perf to read it without root user.

> 
> Making eventfs a separate file system where, when added to tracefs, has the
> control files for the specific trace_array, but for the /sys/kernel
> directory, only cares about the trace format files.
> 
> Then tracefs could be nicely converted over to kernfs, and eventfs would be
> its own entity.

If so, maybe we can just make symlinks to the 'id' and 'format' from events
under tracefs? :)

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

