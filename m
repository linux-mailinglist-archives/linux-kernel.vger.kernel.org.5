Return-Path: <linux-kernel+bounces-46474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A8844042
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A56B2E4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C079DD0;
	Wed, 31 Jan 2024 13:14:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193E7BB19;
	Wed, 31 Jan 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706892; cv=none; b=ovjNdX8fHGjpstMhtYEXkdfsTeN4Jd5ejRdeFtuD1IVS+rbOhxCH7CHt4871BOzaxOxeNr9E9PnFniyW59dzGWrjsF/Zn95mykRK2TsfIqJj1JmcTWZwPmgQ8urAawvD072eaEKGnpltYJA4kbxbZNUaTun6hANAGivN07KB5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706892; c=relaxed/simple;
	bh=3LOvVtBERK8LO5HOTNwFGjviYIEoYL95JBFF4loUY0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLuETYidNbvWgrUEN4YYO0ri7iObSPBjwgH7PdxpfhYR5PhgPp2tel9HfR5Q9Kzy+HcO2x4J0StaizVkLYRkXJ3E1eocPjHk+ztOPG/eEfgYI7Qm2jz6SK9kHjS52QlF1hTFTAoferzMYQcrMsXFtUv1aiaVKEkXE5r93YbPmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA58EC43390;
	Wed, 31 Jan 2024 13:14:50 +0000 (UTC)
Date: Wed, 31 Jan 2024 08:14:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240131081449.6e917b71@rorschach.local.home>
In-Reply-To: <20240131075740.660e7634@rorschach.local.home>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
	<20240131000956.3dbc0fc0@gandalf.local.home>
	<CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
	<20240131003317.7a63e799@gandalf.local.home>
	<CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
	<CAHk-=whSse54d+X361K2Uw6jO2SvrO-U0LHLBTLnqHaA+406Fw@mail.gmail.com>
	<20240131075740.660e7634@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 07:57:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> static int instance_rmdir(const char *name)
> {
>         struct trace_array *tr;
>         int ret;
> 
>         mutex_lock(&event_mutex);

Note, event_mutex prevents dynamic events from being created. No kprobe
can be added while the event_mutex is held (not to be confused with
eventfs_mutex).

>         mutex_lock(&trace_types_lock);
> 
>         ret = -ENODEV;
>         tr = trace_array_find(name);
>         if (tr)
>                 ret = __remove_instance(tr);
> 
>         mutex_unlock(&trace_types_lock);
>         mutex_unlock(&event_mutex);
> 
>         return ret;
> }

And

static int instance_mkdir(const char *name)
{
        struct trace_array *tr;
        int ret;

        mutex_lock(&event_mutex);
        mutex_lock(&trace_types_lock);

        ret = -EEXIST;
        if (trace_array_find(name))
                goto out_unlock;

        tr = trace_array_create(name);

        ret = PTR_ERR_OR_ZERO(tr);

out_unlock:
        mutex_unlock(&trace_types_lock);
        mutex_unlock(&event_mutex);
        return ret;
}


The above functions would have been basically what would have been
called if I had created:

  echo foo >> make_instance
  echo '!foo' >> remove_instance

In fact, IIRC, I did do the above first, and then moved that code into
mkdir/rmdir. Such that the tracefs mkdir and rmdir were just helpers
and not real "mkdir" and "rmdir" routines. This isn't in git history
because it was done only on my local repository.

If you also notice, tracefs only allows mkdir/rmdir to be assigned to
one directory. Once it is assigned, no other directories can have mkdir
rmdir functionality.

 /sys/kernel/tracing/instances

is the *only* directory that can have mkdir rmdir on it.

__init struct dentry *tracefs_create_instance_dir(const char *name,
                                          struct dentry *parent,
                                          int (*mkdir)(const char *name),
                                          int (*rmdir)(const char *name))
{
        struct dentry *dentry;

        /* Only allow one instance of the instances directory. */
        if (WARN_ON(tracefs_ops.mkdir || tracefs_ops.rmdir))
                return NULL;

And IIRC, Al told me that if I released the locks, it's up to the above
functions to prevent the races from occurring. That is, no file can be
created or remove when the mkdir and rmdir are running. Which the
event_mutex prevents.

Basically, I freeze external file creation and deletion within
tracefs/eventfs when the above mkdir/rmdir is being executed, and
prevent rmdir if any file within it is open.

-- Steve

