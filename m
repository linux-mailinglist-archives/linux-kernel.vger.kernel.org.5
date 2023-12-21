Return-Path: <linux-kernel+bounces-7680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BE81AB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADB71C239C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E44291D;
	Thu, 21 Dec 2023 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfAlNjWq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499AF28E6;
	Thu, 21 Dec 2023 00:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC56C433C9;
	Thu, 21 Dec 2023 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703117466;
	bh=Bz8idteeUHPKAAs0PCjUkD6k7n9yUjKkLX+v+lcT8e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfAlNjWqhlxPDWK8fmG6O2z7RyNS3K3swU0NYssYUhsCeVeXFjf7Zsubgspuluh2u
	 e01huwdy6R6lj9Tvu6c8lpBGuepGWSN+b0h6N41nxicnLL2J9GPFXgZ1ExQb37NU9B
	 tG6MReEDLCKRpMAmf0qyoSdmnyUKy0ArDS+BV2Ldk7UrT7hEVleYEj/wRWBHEP+/GL
	 avf6Lg850UiZKUF5/i/xI7O8XVCFtCpR+8o3die0vDtMJRyDQfFQwH42oP3kyHSPt3
	 FJcm2p+pJyuWFq080JdpJBB+XdetzEnYV6JPBMrS2mqAvJC1BLi/Vs7Zm5PPElp7pD
	 syNkn1NfxQO7w==
Date: Thu, 21 Dec 2023 09:11:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 04/15] ring-buffer: Set new size of the ring buffer
 sub page
Message-Id: <20231221091101.c518d74654d507af07c53eb1@kernel.org>
In-Reply-To: <20231220115602.1903bf77@gandalf.local.home>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.588995543@goodmis.org>
	<20231221013456.cc03acc7b565cfa9a15cbe87@kernel.org>
	<20231220115602.1903bf77@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 11:56:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 21 Dec 2023 01:34:56 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Tue, 19 Dec 2023 13:54:18 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> > > 
> > > There are two approaches when changing the size of the ring buffer
> > > sub page:
> > >  1. Destroying all pages and allocating new pages with the new size.
> > >  2. Allocating new pages, copying the content of the old pages before
> > >     destroying them.
> > > The first approach is easier, it is selected in the proposed
> > > implementation. Changing the ring buffer sub page size is supposed to
> > > not happen frequently. Usually, that size should be set only once,
> > > when the buffer is not in use yet and is supposed to be empty.
> > > 
> > > Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-5-tz.stoyanov@gmail.com
> > >   
> > 
> > OK, this actually reallocate the sub buffers when a new order is set.
> > BTW, with this change, if we set a new order, the total buffer size will be
> > changed too? Or reserve the total size? I think either is OK but it should
> > be described in the document. (e.g. if it is changed, user should set the
> > order first and set the total size later.)
> > 
> 
> Patch 11 keeps the same size of the buffer. As I would think that would be
> what the user would expect. And not only that, it breaks the latency
> tracers if it doesn't keep the same size.

Got it!

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

