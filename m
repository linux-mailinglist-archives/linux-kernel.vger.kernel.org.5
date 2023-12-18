Return-Path: <linux-kernel+bounces-4063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64423817769
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F01C24C13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669D498A8;
	Mon, 18 Dec 2023 16:27:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFD36B04;
	Mon, 18 Dec 2023 16:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E68CC433C8;
	Mon, 18 Dec 2023 16:27:21 +0000 (UTC)
Date: Mon, 18 Dec 2023 11:28:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 0/2] ring-buffer: Rename sub-buffer into buffer page
Message-ID: <20231218112817.7f3c8847@gandalf.local.home>
In-Reply-To: <20231218154618.954997-1-vdonnefort@google.com>
References: <20231218151451.944907-1-vdonnefort@google.com>
	<20231218154618.954997-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 15:46:18 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Previously was introduced the ability to change the ring-buffer page
> size. It also introduced the concept of sub-buffer that is, a contiguous
> virtual memory space which can now be bigger than the system page size
> (4K on most systems). But behind the scene this is really just a page
> with an order > 0 and a struct buffer_page (often refered as "bpage")
> already exists. We have then an unnecessary duplicate subbuffer ==
> bpage.
> 
> Remove all references to sub-buffer and replace them with either bpage
> or ring_buffer_page.

No! I think you misunderstood me before.

I want it the other way around. In Linux, "page" usually means the
architecture page (4096 on x86). If we are going to remove the duplicate of
subbuffer == bpage, remove the "page" part, *not* the subbuffer part. The
"subbuf" part is part of the design, not an implementation detail. The page
part, was just an implementation detail that we do not want to expose!

When you say "page" you mean a single page. If you say buffer_page_size,
one will think this is an architecture page, not the subbuffer size.

The ring buffer is broken up into subbuffers, The page is just an
implementation detail. Let's not confuse that with the design.

Thanks,

-- Steve

