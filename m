Return-Path: <linux-kernel+bounces-5519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B7818B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C11A28488A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38A1CF9B;
	Tue, 19 Dec 2023 15:52:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615551D521;
	Tue, 19 Dec 2023 15:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CCCC433C8;
	Tue, 19 Dec 2023 15:52:46 +0000 (UTC)
Date: Tue, 19 Dec 2023 10:53:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Fix slowpath of interrupted event
Message-ID: <20231219105344.3b496678@gandalf.local.home>
In-Reply-To: <20231219103613.787bef51@gandalf.local.home>
References: <20231218230712.3a76b081@gandalf.local.home>
	<20231219233710.21b48850676e65da2a37fe22@kernel.org>
	<20231219101027.349b7d19@gandalf.local.home>
	<20231219103613.787bef51@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 10:36:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  |-- interrupt event --|-- normal context event --|-- interrupt event --|
> 
>          ^                            ^                     ^
>          |                            |                     |
>     ts is before before_stamp         |                     |
>                                our before_stamp             |
>                                                     absolute value
> 
> We just need to make our delta not go beyond the absolute value. So:
> 
>   ts of first event + (absolute value - our before_stamp)
> 
> Should not be greater than the absolute value.

Hmm, this isn't good enough either. Because we could have had the interrupt
happen *after* the before_stamp update, and leave the write_stamp not equal
to the before_stamp (like the original patch is fixing).

That is, in the case of finding an absolute value, there's still no way to
know what delta to use without walking the sub-buffer. Hmm, since this is
so rare, we could do that :-/

Anyway, for now, it's just going to be delta = 0, and we could do the
sub-buffer walk if it becomes an issue (which it hasn't for the last decade
or more).

-- Steve

