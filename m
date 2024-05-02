Return-Path: <linux-kernel+bounces-166925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981478BA213
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC60E1C21D80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDEE181CE4;
	Thu,  2 May 2024 21:15:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E3181BAF;
	Thu,  2 May 2024 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684550; cv=none; b=l7GUI32PnrNVZeBbAGsVy4btkOWx+R7R1yWcRlc6DEbWrnW5wddcTb7ERwKpZpa/hO/6W7Vb+WsVSYg8HiW0K6Zac3cNicBzUgcHMoF9NqVheSL0jpVxgeKeYbejB76LrjfwLuqlw+lqtLa0t2jc/nVJf+7GYUAyo+g4tanmvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684550; c=relaxed/simple;
	bh=gBlUE5+Z1S21TQ+LKJ26JNh+iN6+3wT53AYZTaqpyZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujASGLNhTY+Oq/HQBu+F1uoN42RiWn0TQaP87630sR5M7P9lOdUO14To3G8gHahPRIoGLmCDjZvYCyo7JcLKpE58FDk1yTC8BIg+kJ0hKYhjStK3m/u31j5pSbjb64rz3oo8RHcWV1Fd51v32/4u897QAnXaJq4V3ZK9yFsnNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E3C113CC;
	Thu,  2 May 2024 21:15:48 +0000 (UTC)
Date: Thu, 2 May 2024 17:16:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 dcook@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] tracing/user_events: Fix non-spaced field
 matching
Message-ID: <20240502171634.7e2ac794@gandalf.local.home>
In-Reply-To: <20240423162338.292-2-beaub@linux.microsoft.com>
References: <20240423162338.292-1-beaub@linux.microsoft.com>
	<20240423162338.292-2-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 16:23:37 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> When the ABI was updated to prevent same name w/different args, it
> missed an important corner case when fields don't end with a space.
> Typically, space is used for fields to help separate them, like
> "u8 field1; u8 field2". If no spaces are used, like
> "u8 field1;u8 field2", then the parsing works for the first time.
> However, the match check fails on a subsequent register, leading to
> confusion.
> 
> This is because the match check uses argv_split() and assumes that all
> fields will be split upon the space. When spaces are used, we get back
> { "u8", "field1;" }, without spaces we get back { "u8", "field1;u8" }.
> This causes a mismatch, and the user program gets back -EADDRINUSE.
> 
> Add a method to detect this case before calling argv_split(). If found
> force a space after the field separator character ';'. This ensures all
> cases work properly for matching.
> 
> With this fix, the following are all treated as matching:
> u8 field1;u8 field2
> u8 field1; u8 field2
> u8 field1;\tu8 field2
> u8 field1;\nu8 field2

I'm curious, what happens if you have: "u8 field1; u8 field2;" ?

Do you care? As you will then create "u8 field1; u8 field2; "

but I'm guessing the extra whitespace at the end doesn't affect anything.


> 
> Fixes: ba470eebc2f6 ("tracing/user_events: Prevent same name but different args event")
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 76 +++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 70d428c394b6..82b191f33a28 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1989,6 +1989,80 @@ static int user_event_set_tp_name(struct user_event *user)
>  	return 0;
>  }
>  
> +/*
> + * Counts how many ';' without a trailing space are in the args.
> + */
> +static int count_semis_no_space(char *args)
> +{
> +	int count = 0;
> +
> +	while ((args = strchr(args, ';'))) {
> +		args++;
> +
> +		if (!isspace(*args))
> +			count++;

This will count that "..;" 

This is most likely not an issue, but since I didn't see this case
anywhere, I figured I bring it up just to confirm that it's not an issue.

-- Steve


> +	}
> +
> +	return count;
> +}
> +
> +/*
> + * Copies the arguments while ensuring all ';' have a trailing space.
> + */
> +static char *insert_space_after_semis(char *args, int count)
> +{
> +	char *fixed, *pos;
> +	int len;
> +
> +	len = strlen(args) + count;
> +	fixed = kmalloc(len + 1, GFP_KERNEL);
> +
> +	if (!fixed)
> +		return NULL;
> +
> +	pos = fixed;
> +
> +	/* Insert a space after ';' if there is no trailing space. */
> +	while (*args) {
> +		*pos = *args++;
> +
> +		if (*pos++ == ';' && !isspace(*args))
> +			*pos++ = ' ';
> +	}
> +
> +	*pos = '\0';
> +
> +	return fixed;
> +}
> +

