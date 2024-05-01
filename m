Return-Path: <linux-kernel+bounces-165408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9528B8C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA311C20EFB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9F12FB1A;
	Wed,  1 May 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm2WbPJh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BB1E87C;
	Wed,  1 May 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575390; cv=none; b=jBIW1dfDN+E5SCfEflQuXpXRuS4QSLikC/19LPGdx5i0rII5CIOEl1uQL3LYb3ts1gLuccTFP7mH7qsoU1Yp2SKJHIYE7HDWBesGk8ldEedwJ9cD/p91PnEPr34ol4ty+rTpjfzFQOhc0KkCs7McdogOpmiKy6biZSI/qrEt9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575390; c=relaxed/simple;
	bh=VHoAtVLPOx3zYSUeVy7+X3UHEdH8dcd9ZPPasKe0tk8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uumtvMiZqdnke/qeQ8PtIdpHk69+ycxSLGfjxygEfLOX7koJ+BetxWzMxFEYQnmSec7IOKZ8t9VkhHvvKzwvDkAOJpf/vBkBzcwvemKIEEpRBGAmRY3bQl75uBRnjx8wNAoNaOVo3sfAMEwGsjREqkw5r1mRwlYhsLyLIw2FcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm2WbPJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C9CC072AA;
	Wed,  1 May 2024 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714575389;
	bh=VHoAtVLPOx3zYSUeVy7+X3UHEdH8dcd9ZPPasKe0tk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fm2WbPJhs0+4FoxG2fOfYLogVhy7Ss2BUVbT2dn7WfzG8hUdy72HvWVRNYf/6Mftv
	 8LimdrFXO7n9g1a/3vdXBkKWeHmcurnWWUf8ykS0vZRSncJ6etvlwC24eaCWS7xgZX
	 E+rxuqVxAZSdmObsxSW8ZZ+CSRm7JDhwHvSABvLflB+1RH9DGqnGvtwJWI/RIY/oMd
	 +ZGK4FDpTPcKfDXzmbiAtBWeyVgbs+GPWfSZPUoSHho5DrgGnca0DBoM6muKNv8Q8J
	 Z26VR5tsVtV7pkxeG6gBItBSfcsea2Dt+7kpGjOnx5TVOxvzapkrNZ3nPNG4sKlYbm
	 5KqSH+t5HUAjw==
Date: Wed, 1 May 2024 23:56:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tze-nan wu <Tze-nan.Wu@mediatek.com>
Subject: Re: [PATCH] eventfs/tracing: Add callback for release of an
 eventfs_inode
Message-Id: <20240501235626.81178236dc8826c038089c0c@kernel.org>
In-Reply-To: <20240430142327.7bff81ba@gandalf.local.home>
References: <20240430142327.7bff81ba@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 14:23:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Synthetic events create and destroy tracefs files when they are created
> and removed. The tracing subsystem has its own file descriptor
> representing the state of the events attached to the tracefs files.
> There's a race between the eventfs files and this file descriptor of the
> tracing system where the following can cause an issue:
> 
> With two scripts 'A' and 'B' doing:
> 
>   Script 'A':
>     echo "hello int aaa" > /sys/kernel/tracing/synthetic_events
>     while :
>     do
>       echo 0 > /sys/kernel/tracing/events/synthetic/hello/enable
>     done
> 
>   Script 'B':
>     echo > /sys/kernel/tracing/synthetic_events
> 
> Script 'A' creates a synthetic event "hello" and then just writes zero
> into its enable file.
> 
> Script 'B' removes all synthetic events (including the newly created
> "hello" event).
> 
> What happens is that the opening of the "enable" file has:
> 
>  {
> 	struct trace_event_file *file = inode->i_private;
> 	int ret;
> 
> 	ret = tracing_check_open_get_tr(file->tr);
>  [..]
> 
> But deleting the events frees the "file" descriptor, and a "use after
> free" happens with the dereference at "file->tr".
> 
> The file descriptor does have a reference counter, but there needs to be a
> way to decrement it from the eventfs when the eventfs_inode is removed
> that represents this file descriptor.
> 
> Add an optional "release" callback to the eventfs_entry array structure,
> that gets called when the eventfs file is about to be removed. This allows
> for the creating on the eventfs file to increment the tracing file
> descriptor ref counter. When the eventfs file is deleted, it can call the
> release function that will call the put function for the tracing file
> descriptor.
> 
> This will protect the tracing file from being freed while a eventfs file
> that references it is being opened.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Link: https://lore.kernel.org/linux-trace-kernel/20240426073410.17154-1-Tze-nan.Wu@mediatek.com/
> 
> Cc: stable@vger.kernel.org
> Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Reported-by: Tze-nan wu <Tze-nan.Wu@mediatek.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/tracefs/event_inode.c    |  7 +++++++
>  include/linux/tracefs.h     |  3 +++
>  kernel/trace/trace_events.c | 12 ++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 894c6ca1e500..dc97c19f9e0a 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -84,10 +84,17 @@ enum {
>  static void release_ei(struct kref *ref)
>  {
>  	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
> +	const struct eventfs_entry *entry;
>  	struct eventfs_root_inode *rei;
>  
>  	WARN_ON_ONCE(!ei->is_freed);
>  
> +	for (int i = 0; i < ei->nr_entries; i++) {
> +		entry = &ei->entries[i];
> +		if (entry->release)
> +			entry->release(entry->name, ei->data);
> +	}
> +
>  	kfree(ei->entry_attrs);
>  	kfree_const(ei->name);
>  	if (ei->is_events) {
> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index 7a5fe17b6bf9..d03f74658716 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -62,6 +62,8 @@ struct eventfs_file;
>  typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
>  				const struct file_operations **fops);
>  
> +typedef void (*eventfs_release)(const char *name, void *data);
> +
>  /**
>   * struct eventfs_entry - dynamically created eventfs file call back handler
>   * @name:	Then name of the dynamic file in an eventfs directory
> @@ -72,6 +74,7 @@ typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
>  struct eventfs_entry {
>  	const char			*name;
>  	eventfs_callback		callback;
> +	eventfs_release			release;
>  };
>  
>  struct eventfs_inode;
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 52f75c36bbca..6ef29eba90ce 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2552,6 +2552,14 @@ static int event_callback(const char *name, umode_t *mode, void **data,
>  	return 0;
>  }
>  
> +/* The file is incremented on creation and freeing the enable file decrements it */
> +static void event_release(const char *name, void *data)
> +{
> +	struct trace_event_file *file = data;
> +
> +	event_file_put(file);
> +}
> +
>  static int
>  event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
>  {
> @@ -2566,6 +2574,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
>  		{
>  			.name		= "enable",
>  			.callback	= event_callback,
> +			.release	= event_release,
>  		},
>  		{
>  			.name		= "filter",
> @@ -2634,6 +2643,9 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
>  		return ret;
>  	}
>  
> +	/* Gets decremented on freeing of the "enable" file */
> +	event_file_get(file);
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

