Return-Path: <linux-kernel+bounces-7325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BF81A5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76B31F244A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35846533;
	Wed, 20 Dec 2023 16:55:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D354644D;
	Wed, 20 Dec 2023 16:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99994C433C8;
	Wed, 20 Dec 2023 16:55:01 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:56:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 04/15] ring-buffer: Set new size of the ring buffer
 sub page
Message-ID: <20231220115602.1903bf77@gandalf.local.home>
In-Reply-To: <20231221013456.cc03acc7b565cfa9a15cbe87@kernel.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.588995543@goodmis.org>
	<20231221013456.cc03acc7b565cfa9a15cbe87@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 01:34:56 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 19 Dec 2023 13:54:18 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> > 
> > There are two approaches when changing the size of the ring buffer
> > sub page:
> >  1. Destroying all pages and allocating new pages with the new size.
> >  2. Allocating new pages, copying the content of the old pages before
> >     destroying them.
> > The first approach is easier, it is selected in the proposed
> > implementation. Changing the ring buffer sub page size is supposed to
> > not happen frequently. Usually, that size should be set only once,
> > when the buffer is not in use yet and is supposed to be empty.
> > 
> > Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-5-tz.stoyanov@gmail.com
> >   
> 
> OK, this actually reallocate the sub buffers when a new order is set.
> BTW, with this change, if we set a new order, the total buffer size will be
> changed too? Or reserve the total size? I think either is OK but it should
> be described in the document. (e.g. if it is changed, user should set the
> order first and set the total size later.)
> 

Patch 11 keeps the same size of the buffer. As I would think that would be
what the user would expect. And not only that, it breaks the latency
tracers if it doesn't keep the same size.

-- Steve

