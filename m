Return-Path: <linux-kernel+bounces-108150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6168B8806B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB98284E43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAD03FBBF;
	Tue, 19 Mar 2024 21:25:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDB3C488;
	Tue, 19 Mar 2024 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883523; cv=none; b=qc36HNnkjjQ3ftf6M1GOAuInuSMh18wiwT0qNJESWYRSGbAFrotKEHVYKKZn2BjPoxWPlg/JQWoZyTW4HxfOL6Z8poX06/5/STPFIbXnJ50+EGOIlummd/x87CyVkqHEODt1d7O9YbMOZmRf9de7skEzAoqpI59Q5xydS9kx6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883523; c=relaxed/simple;
	bh=e/lPwUTH5fgcUQnQW6C64fTu7xkn/zOwEfP5KCNgUqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce53avIj2Tx+WQeiz9YVb/uMTus7fKW+U58/+kUI4hZgbqqN9cM59MFmkRxugqmZj6Uci86u+Q9NloEip/1klhCE4ip3QZIaxi3lDRLQti8qJYrZRoYFHMFaa9t1+JcFXq8Il7rX5rNTKRoRawSgTgICzckEJwv1sn55Sij9zUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A898FC433F1;
	Tue, 19 Mar 2024 21:25:21 +0000 (UTC)
Date: Tue, 19 Mar 2024 17:27:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Alison Schofield
 <alison.schofield@intel.com>, Beau Belgrave <beaub@linux.microsoft.com>,
 Huang Yiwei <quic_hyiwei@quicinc.com>, John Garry
 <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Thorsten
 Blum <thorsten.blum@toblux.com>, Vincent Donnefort <vdonnefort@google.com>,
 linke li <lilinke99@qq.com>, llvm@lists.linux.dev
Subject: Re: [GIT PULL v2] tracing: Updates for v6.9
Message-ID: <20240319172744.2e535578@gandalf.local.home>
In-Reply-To: <20240319210329.GA742040@dev-arch.thelio-3990X>
References: <20240318113053.7f87ce7f@gandalf.local.home>
	<CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
	<20240319130653.0cfdaf6e@gandalf.local.home>
	<20240319131333.504c93fc@gandalf.local.home>
	<20240319210329.GA742040@dev-arch.thelio-3990X>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 14:03:29 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> > #define __assign_str(dst, src)						\
> > 	do {								\
> > 		char *__str__ = __get_str(dst);				\
> > 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
> > 		WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);	\
> > 		WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
> > 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
> > 		       EVENT_NULL_STR, __len__);			\
> > 		__str__[__len__] = '\0';				\
> > 	} while (0)
> > 
> > The first WARN_ON() will report the bug if src is not NULL and the pointer
> > is even though the strcmp() will likely crash in that case. But that's a
> > bug if that happens anyway.  
> 
> For what it's worth, I applied that change and built ARCH=x86_64
> defconfig with LLVM 18.1.1 from [1] but it does not appear to help the
> instances of -Wstring-compare; in fact, it adds some additional warnings
> that I have not seen before. I have attached the full build log.

That was just me posting what I was going to do before testing it. You want
the actual patch that Linus pulled in.

  https://lore.kernel.org/all/20240319133959.349f5082@gandalf.local.home/

-- Steve

