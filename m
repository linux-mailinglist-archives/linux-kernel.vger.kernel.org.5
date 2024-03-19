Return-Path: <linux-kernel+bounces-107891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44E3880313
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E8F283C47
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3B18EC0;
	Tue, 19 Mar 2024 17:11:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E8179A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868272; cv=none; b=s2/3g5I5+UHpcGImlCd9ouMSDIevBTPDZVMGyFWNIrrL1kP/4rhP0Ueiu5txHbJemzJsWPN2utg3e06wKLfTlQNDk3SGNQkBo4WMeIxt5Enfj4FJUBy6QG6hghWJHodgPPN9A0M2ifJjfGmwwqsTD8XJEanY1qI/pHG909Nw7dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868272; c=relaxed/simple;
	bh=ebwOVxoBOs8lCcSplls0CzG67Wju8dHmF6pjC8vwD5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBKMm7hVoLXYiDbZNBAaICwGVpqAgWCsxbn9mlW5XzixQJjqKL1eKVdJB5OgMM5RUqdRCdMBuNKaCfseZnduYpg/tna3dmU7P2K4S1z6CjoHZ0hpRRnmN+3vlPT99Uxiz7Wku3xCVDHrZzSbwDcaOjo8Zz6udPWVmKPzbVq7lUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD7BC433C7;
	Tue, 19 Mar 2024 17:11:10 +0000 (UTC)
Date: Tue, 19 Mar 2024 13:13:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alison Schofield <alison.schofield@intel.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, John
 Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort
 <vdonnefort@google.com>, linke li <lilinke99@qq.com>
Subject: Re: [GIT PULL v2] tracing: Updates for v6.9
Message-ID: <20240319131333.504c93fc@gandalf.local.home>
In-Reply-To: <20240319130653.0cfdaf6e@gandalf.local.home>
References: <20240318113053.7f87ce7f@gandalf.local.home>
	<CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
	<20240319130653.0cfdaf6e@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 13:06:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This is in the fast path (where the trace event happens), but I can make it
> always do strcmp(), even though it will slow down what is being recorded,
> as I plan on removing the parameter in the next merge window anyway.

I'll change it to this:

#define __assign_str(dst, src)						\
	do {								\
		char *__str__ = __get_str(dst);				\
		int __len__ = __get_dynamic_array_len(dst) - 1;		\
		WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);	\
		WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
		       EVENT_NULL_STR, __len__);			\
		__str__[__len__] = '\0';				\
	} while (0)

The first WARN_ON() will report the bug if src is not NULL and the pointer
is even though the strcmp() will likely crash in that case. But that's a
bug if that happens anyway.

-- Steve

