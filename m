Return-Path: <linux-kernel+bounces-35835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E5839722
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300851C25EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33881AAB;
	Tue, 23 Jan 2024 18:00:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36018005D;
	Tue, 23 Jan 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032855; cv=none; b=XVabeeYRodqiLdfrESFb6IRdFDuSt/nM7q+b8XMAuNEWpMWWNuq0hQho1aiajXoogENBtDV+ve1jEgTuqYUdF0CY/Sj9ZJ4OS8jXUJ21ot+opbaY8/TXxaPj1NBa86h+IW7f8UNZHyqv+DoB5MzXTHTPOIWDmuum/EF2TOngS1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032855; c=relaxed/simple;
	bh=RvfSqt5SOt8vR1G28kL6h9RHI/bw2faiLEQHnH+r4WE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4p36S4bH6VsftteTXa95yHJt+IL4C1Mx/CdVzVNg/ywXMKwDsOJfrQgDfM8qPt8ew/9OF1xYl53AgIESLCmsfgHCmFsohkRaWE2JoLAlFkeDVe5fUbW76sspd93pJNdh7m4i9fooOEPGazijI6fk7ztctkTUJMFbgiyC3llT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F92C433C7;
	Tue, 23 Jan 2024 18:00:54 +0000 (UTC)
Date: Tue, 23 Jan 2024 13:02:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v12 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240123130225.23d5da07@gandalf.local.home>
In-Reply-To: <Za_74T-IJWAa6fny@google.com>
References: <20240123110757.3657908-1-vdonnefort@google.com>
	<20240123110757.3657908-3-vdonnefort@google.com>
	<20240123105149.36abf019@gandalf.local.home>
	<Za_74T-IJWAa6fny@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 17:48:17 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > + * @subbufs_touched:	Number of subbufs that have been filled.
> > > + * @subbufs_lost:	Number of subbufs lost to overrun.
> > > + * @subbufs_read:	Number of subbufs that have been read.  
> > 
> > Do we actually need the above 3 fields?
> > 
> > What's the use case for them? I don't want to expose internals in the API
> > unless they are needed.  
> 
> subbufs_read is gone, I just forgot to remove it here :-\.
> 
> The two other ones are used for tracing with the hypervisor. That's why I
> preemptively added them. 
> 
> I can remove them and add just append this struct later ... or just overload
> this struct with another one, only shared between the kernel and the hypervisor?

Yes, let's have them be different for now. Or we could just make them
"reserved" and say that they are not used for now.

I also think we should add a flags value too, so that when they are no
longer reserved, a flag can be set to say that they are active.

struct trace_buffer_meta {
	__u32		meta_page_size;
	__u32		meta_struct_len;

	__u32		subbuf_size;
	__u32		nr_subbufs;

	struct {
		__u64	lost_events;
		__u32	id;
		__u32	read;
	} reader;

	__u64	flags;

	__u64	entries;
	__u64	overrun;
	__u64	read;

	__u64	Reserved1;
	__u64	Reserved2;
};


And that way the hypervisor would still have those available, and updated,
but they are not filled for user space. The hypervisor could even set the
flag field saying it's using them.

That is, the first flag is:

enum {
	TRACE_BUFFER_META_FL_SUBUF_INFO		= (1 << 0),
};

And if that's set, those fields are available. But we just don't set them
now ;-)

-- Steve

