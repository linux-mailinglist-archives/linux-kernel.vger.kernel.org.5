Return-Path: <linux-kernel+bounces-161643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D62B8B4EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E78A282894
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B9C7F9;
	Mon, 29 Apr 2024 00:28:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321638B;
	Mon, 29 Apr 2024 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350520; cv=none; b=AGwLO63muEumiOBMXWIbBtT45ckNYGdtYK0PzdLDXoTYvU7gHpWclMII/Zch7JadOzgK697f9Yxa0rC13A/UYCBi2873c+NQRT2LcH7nciySCKZFcV4NIWcDcMjVONu1/ljb2FmYRM2gRAX9GP4+1DP3XGhk8FQBEtgrBf8MJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350520; c=relaxed/simple;
	bh=Z5ik7Q4hz896X4CenAOKVNubLwUMayZQDBFuNNNZkfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjXj7mKWkWIIkRu0WpuxXmrMbYb3VrYrFMAUpCbfIbOiDyYGoVbNmNFTFXnfcV5zpqNu6xsgBqCc4m3iTEDPOwn0b3mTZW5SZV4O9IKjCXFCudKjUdE1B/5a7bjOxJqdrYUwDY6nXipG4M0HEDzTZAhBCPl+YdlzhYsjFTPBbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75705C113CC;
	Mon, 29 Apr 2024 00:28:39 +0000 (UTC)
Date: Sun, 28 Apr 2024 20:28:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tze-nan wu <Tze-nan.Wu@mediatek.com>
Cc: <mhiramat@kernel.org>, <bobule.chang@mediatek.com>,
 <wsd_upstream@mediatek.com>, Cheng-Jui Wang <cheng-jui.wang@mediatek.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] tracing: Fix uaf issue in tracing_open_file_tr
Message-ID: <20240428202837.0cabca17@rorschach.local.home>
In-Reply-To: <20240426073410.17154-1-Tze-nan.Wu@mediatek.com>
References: <20240426073410.17154-1-Tze-nan.Wu@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 15:34:08 +0800
Tze-nan wu <Tze-nan.Wu@mediatek.com> wrote:

> "tracing_event_file" is at the risk of use-after-free due to the race of
> two functions "tracing_open_file_tr" and "synth_event_release".
> Specifically, it could be freed by synth_event_release before
> tracing_open_file_tr has the opportunity to access its members.
> 
> It's easy to reproduced by first executing script 'A' and then script 'B'
> in my environment.
> 
>   Script 'A':
>     echo "hello int aaa" > /sys/kernel/tracing/synthetic_events
>     while :
>     do
>       echo 0 > /sys/kernel/tracing/events/synthetic/hello/enable
>     done
> 
>   Script 'B':
>     echo > /sys/kernel/tracing/synthetic/events

I think you meant:

      echo > /sys/kernel/tracing/synthetic_events

> 
>   My environment:
>     arm64 + generic and swtag based KASAN both enabled + kernel-6.6.18
> 
> KASAN report
> ==================================================================
> BUG: KASAN: slab-use-after-free in tracing_open_file_tr
> Read of size 8 at addr 9*ffff********** by task sh/3485
> Pointer tag: [9*], memory tag: [fe]
> 
> CPU: * PID: 3485 Comm: sh Tainted: ****************
> Call trace:
>  __hwasan_tag_mismatch
>  tracing_open_file_tr
>  do_dentry_open
>  vfs_open
>  path_openat
> 
> Freed by task 3490:
>  slab_free_freelist_hook
>  kmem_cache_free
>  event_file_put
>  remove_event_file_dir
>  __trace_remove_event_call
>  trace_remove_event_call
>  synth_event_release
>  dyn_events_release_all
>  synth_events_open
> 
> page last allocated via order 0, migratetype Unmovable:
>  __slab_alloc
>  kmem_cache_alloc
>  trace_create_new_event
>  trace_add_event_call
>  register_synth_event
>  __create_synth_event
>  create_or_delete_synth_event
>  trace_parse_run_command
>  synth_events_write
>  vfs_write

Thanks for reporting this.

> 
> Based on the assumption that eventfs_inode will persist throughout the
> execution of the tracing_open_file_tr function,
> we can fix this issue by incrementing the reference count of
> trace_event_file once it is assigned to eventfs_inode->data.
> The reference count will then be decremented during the release phase of
> eventfs_inode.
> 
> This ensures that trace_event_file is not prematurely freed while the
> tracing_open_file_tr function is being called.
> 
> Fixes: bb32500fb9b7 ("tracing: Have trace_event_file have ref counters")
> Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Tze-nan wu <Tze-nan.Wu@mediatek.com>
> ---
> BTW, I've also attempted to reproduce the same issue in another
> environment (described below).
> It's also reproducible but in a lower rate.
> 
> another environment:
>   x86 + ubuntu + generic kasan enabled + kernel-6.9-rc4
> 
> After applying the patch, KASAN no longer reports any issues when
> following the same reproduction steps in my arm64 environment. 
> However, I am concerned about potential side effects that the patch might introduce.
> Additionally, the newly added function "is_entry_event_callback" may not
> be reliable in my opinion,
> as the callback function used in the comparison could change in future. 
> Nonetheless, this is the best solution I can come up with now.
> 
> Looking for any suggestion or solution, appreciate.

Yeah, I do not think eventfs should be involved in this. It needs to be
protected at a higher level (in the synthetic/dynamic event code).

I'm just coming back from Japan, and I'll need to take a deeper look at
this after I recover from my jetlag.

Thanks,

-- Steve

