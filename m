Return-Path: <linux-kernel+bounces-43171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E34AE840CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921471F28F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD915705C;
	Mon, 29 Jan 2024 17:01:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF4155A5F;
	Mon, 29 Jan 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547678; cv=none; b=EmsyOfHVD+bFzl+oW/qdGZS77rvlLgMv9S2y/Mh/zktYVJWtOI7AxzsyqlReC1XM/1RadnUXl+MjiS+u2jzvCG+5qzYFaLToyKu+jOB4tD8rEwX95G9jv7Slq2Vn88kW5IBz5RQ1gmrO7iMdrNDBbfyBdsO9jk2cWj2i8+gEWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547678; c=relaxed/simple;
	bh=CNhm7Ccu7kTuwqe+I/IrKjglq6iSx/VH7y5Y1S7R300=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfcD1WBljcjD3q7MjCK5bCmEwQm+skG/dKsHHSZZraMqu/zuJ4KvoDEDVAzoegQ6QvG78zKhoYqQMe28Hea3FhgEKTy1uouDNjvNABCqgxjX7C5wz/bqCwo79GvVys+XNZDFfE6pSDaIMhT6321VlPfVWzgMjHA+xYjn849aYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A2CC433F1;
	Mon, 29 Jan 2024 17:01:16 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:01:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240129120125.605e97af@gandalf.local.home>
In-Reply-To: <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 20:36:12 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> End result: the d_instantiate() needs to be done *after* the inode has
> been fully filled in.
> 
> Alternatively, you could
> 
>  (a) not drop the eventfs_mutex around the create_dir() call
> 
>  (b) take the eventfs_mutex around all of set_top_events_ownership()
> 
> and just fix it by having the lock protect the lack of ordering.

Hi Linus,

Thanks for the analysis. I have a patch that removes the dropping of the
mutex over the create_dir/file() calls, and lockdep hasn't complained about
it.

I was going to add that to my queue for the next merge window along with
other clean ups but this looks like it actually fixes a real bug. I'll move
that over to my urgent queue and start testing it.

-- Steve


