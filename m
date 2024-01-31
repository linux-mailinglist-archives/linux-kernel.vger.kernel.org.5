Return-Path: <linux-kernel+bounces-47015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6C48447F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9381F25C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865963E479;
	Wed, 31 Jan 2024 19:27:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CA38F8F;
	Wed, 31 Jan 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729238; cv=none; b=bsZw6QPCA9MUUazhim5eF9nP77h0/0pvboApAFWQ3v7gcitBdDoqyfxKUgb299aeeAnJwGU7jduo45BYWQhOOqvlqSUM0yuPASXq45gGpi9uXEytXPtJKW+B/79xgpzhXTSt2zHVi9lgyW5RUIgaQsD80PIYJkRo2lyzd8yAVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729238; c=relaxed/simple;
	bh=CGx3+jWBXBCDWpSFmDnAT+IosPRcAo0ThBJx1AiPGVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Be/v/pmM5u2IaxcSDlvG01nttBa5i8bvULkJiEwsIJUwSog7/Wr8j51COJY5eIVfaCG4w6nx3YCH1EfW8qLh1pwA0E8+G9tJSkFALgEp/fiePtgpG5hWOY3QVRvXVe+X11zooPJRMuV5Z6Ue2mU0bxWHo+QwANJQgIcaEd+TwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E523C433F1;
	Wed, 31 Jan 2024 19:27:15 +0000 (UTC)
Date: Wed, 31 Jan 2024 14:27:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: John Garry <john.g.garry@oracle.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
 rafael@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, keescook@chromium.org, masahiroy@kernel.org,
 nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] tracing: Use uts_release
Message-ID: <20240131142729.2fe870ed@gandalf.local.home>
In-Reply-To: <20240131104851.2311358-3-john.g.garry@oracle.com>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
	<20240131104851.2311358-3-john.g.garry@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:48:49 +0000
John Garry <john.g.garry@oracle.com> wrote:

> Instead of using UTS_RELEASE, use uts_release, which means that we don't
> need to rebuild the code just for the git head commit changing.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a7c6fd934e9..68513924beb4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -13,7 +13,7 @@
>   *  Copyright (C) 2004 Nadia Yvette Chambers
>   */
>  #include <linux/ring_buffer.h>
> -#include <generated/utsrelease.h>
> +#include <linux/utsname.h>
>  #include <linux/stacktrace.h>
>  #include <linux/writeback.h>
>  #include <linux/kallsyms.h>
> @@ -4354,7 +4354,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
>  	get_total_entries(buf, &total, &entries);
>  
>  	seq_printf(m, "# %s latency trace v1.1.5 on %s\n",
> -		   name, UTS_RELEASE);
> +		   name, uts_release);
>  	seq_puts(m, "# -----------------------------------"
>  		 "---------------------------------\n");
>  	seq_printf(m, "# latency: %lu us, #%lu/%lu, CPU#%d |"


