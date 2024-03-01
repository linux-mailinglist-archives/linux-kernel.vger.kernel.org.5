Return-Path: <linux-kernel+bounces-88636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94AC86E4A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792E81F24D5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57EA7002C;
	Fri,  1 Mar 2024 15:47:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2D39846;
	Fri,  1 Mar 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308057; cv=none; b=dTLEZo+yyC6Y4rrV4sqP75dRkBMkqH+oOLl/Ik9swGX/KzUUHQ3Y2k2NqYTB9MwEwYnRHWTlD1DLQxWMrKc1r/8zm5RHo/DrzaCTbLGSjPoRJpP1TlWuLsjsNS2csYMjeN8oh2Rw+5GYj1iE5WnAKFbH8JcMeVO/KXFFhmii+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308057; c=relaxed/simple;
	bh=+bBuSmzM80Yud3CUFZjh8lncJb6Dwdf1wkNLv/XbCmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8pbmzmf6oxtABmpGHWown+JXQdYmd0OAmm1Dttr7IUdYLQhC0EZncOEMe4tOtgXXGDqIdyZkC4jYcF7+WHE2TwZJ743u/EJx/aOWM61zewni+2lV3hSQolmXP+0Jj/0cmt3XDwxz6Wg4paqsZpyg5N0KwRLzS4aLGFanC8Jors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7112FC433F1;
	Fri,  1 Mar 2024 15:47:36 +0000 (UTC)
Date: Fri, 1 Mar 2024 10:49:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linke <lilinke99@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org
Subject: Re: [PATCH] ring-buffer: use READ_ONCE() to read
 cpu_buffer->commit_page in concurrent environment
Message-ID: <20240301104945.43119349@gandalf.local.home>
In-Reply-To: <tencent_3F31ADAB6142D8948E5BD02B854ED2A77106@qq.com>
References: <tencent_3F31ADAB6142D8948E5BD02B854ED2A77106@qq.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 13:37:18 +0800
linke <lilinke99@qq.com> wrote:

> > So basically you are worried about read-tearing?
> > 
> > That wasn't mentioned in the change log.  
> 
> Yes. Sorry for making this confused, I am not very familiar with this and
> still learning.

No problem. We all have to learn this anyway.

> 
> > Funny part is, if the above timestamp read did a tear, then this would
> > definitely not match, and would return the correct value. That is, the
> > buffer is not empty because the only way for this to get corrupted is if
> > something is in the process of writing to it.  
> 
> I agree with you here.
> 
> 	commit = rb_page_commit(commit_page);
> 
> But if commit_page above is the result of a torn read, the commit field
> read by rb_page_commit() may not represent a valid value. 

But commit_page is a word length, and I will argue that any compiler that
tears "long" words is broken. ;-)

> 
> In this case, READ_ONCE() is only needed for the commit_page.

But we can at least keep the READ_ONCE() on the commit_page just because it
is used in the next instruction.

-- Steve

