Return-Path: <linux-kernel+bounces-8562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAAB81B96C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B105F1C25A67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4F86D6EF;
	Thu, 21 Dec 2023 14:18:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604896D6C0;
	Thu, 21 Dec 2023 14:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF226C433C7;
	Thu, 21 Dec 2023 14:18:44 +0000 (UTC)
Date: Thu, 21 Dec 2023 09:19:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, Kent
 Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 02/15] ring-buffer: Page size per ring buffer
Message-ID: <20231221091947.3b35d5d8@gandalf.local.home>
In-Reply-To: <30f49370d7ae494ab1afca5cf602ab55@AcuMS.aculab.com>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.009147038@goodmis.org>
	<84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com>
	<20231220080129.3453bca8@gandalf.local.home>
	<30f49370d7ae494ab1afca5cf602ab55@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 09:17:55 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> > Unfortunately, it has to be PAGE_SIZE (and for now it's a power of 2 to
> > make masking easy). It's used for splice and will also be used for memory
> > mapping with user space.  
> 
> Perhaps then the sysctl to set the size should be powers of 4k

It's not a sysctl but a file in tracefs

> with a minimum size of PAGE_SIZE.
> Then you don't have to know the page size when setting things up.

The user shouldn't need to know either. But the size of the sub-buffer
limits the biggest size of an event, so the user only needs to make sure
the sub-buffer is bigger than their biggest event.

> 
> I'm also guessing that no Linux kernels have a PAGE_SIZE of 2k?
> IIRC some old mmu (maybe 68020 era) used 2k pages.

I think 1kb units is perfectly fine (patch 15 changes to kb units). The
interface says its to define the minimal size of the sub-buffer, not the
actual size.

-- Steve

