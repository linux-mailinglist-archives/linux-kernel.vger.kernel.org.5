Return-Path: <linux-kernel+bounces-150942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585F28AA6FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BF0B22057
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8364C94;
	Fri, 19 Apr 2024 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHVjW4vq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9138137E;
	Fri, 19 Apr 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493990; cv=none; b=HXG2IloqH5+25w5BOfzWsQomT6t3H34JmvPNJEbt0Sklqy8IcsOXyu1Qbxqbd0d0IyfDi/IRAxNVHzZV+79irS2ERC+SN6ccqZGXxadBdzU/dMcH7lmcTNcnKByTeIF+8GxRp/IFO+0ijUKolQMAcjIk2WL9WHv40tEft+E+twc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493990; c=relaxed/simple;
	bh=b32gB5mmLTgH83geBuB0IJ9qfWDbzBC9We7CLDKlGIM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=itdlSTXOs2Er29+/3+OHmRW53LEMP2qOmWOGh8j2AG1YugCw7/nsFMRrGEETsCf6w0oMq8ba9Tj2O5LbT6h/HsjVmmqt0/dIHYNtIchHH4n+c5Cn6zSazKzlZzzBHGY14StKNTkwG/82t/R9e16BcZiKu5LMA3JzsQoBEU3yZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHVjW4vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85116C113CC;
	Fri, 19 Apr 2024 02:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713493989;
	bh=b32gB5mmLTgH83geBuB0IJ9qfWDbzBC9We7CLDKlGIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JHVjW4vqRTa3mRYpGwC6FQY2ORkbGjTCr7HbIXGGBUW1ojkPxX6skMIscw7qEseuy
	 XGlOc+8YwbJ4pmfanEkIkj0oIYJBI+8FC2DkViIBmT9eU//SmlEpLvgvpnTSHBouBK
	 pETj3z8khr4MzG+l35+wDVqEUbr7XOeesa/1L5A+jFQX2GsDnPoQyfGaKxEirF9AzO
	 DPsIpT3l2aKV26vw1iQQjftLL2Gq5qAxcmY3PUKzoVAabkMWtFc6bTqaDwpQgcl888
	 pMSktzgnrwCTb58Nb2g7XFZCSa+aEyDZJXkbyVUpESTkPPKKVqBPmNVZ12XFGKPvBO
	 YiZEH2D5zwq5g==
Date: Fri, 19 Apr 2024 11:33:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 dcook@linux.microsoft.com
Subject: Re: [PATCH 1/2] tracing/user_events: Fix non-spaced field matching
Message-Id: <20240419113305.7b0ae2b11395eec16b5c15b6@kernel.org>
In-Reply-To: <20240416224102.734-2-beaub@linux.microsoft.com>
References: <20240416224102.734-1-beaub@linux.microsoft.com>
	<20240416224102.734-2-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 22:41:01 +0000
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

Sounds good to me. I just have some nits.

> 
> Fixes: ba470eebc2f6 ("tracing/user_events: Prevent same name but different args event")
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 88 +++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 70d428c394b6..9184d3962b2a 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1989,6 +1989,92 @@ static int user_event_set_tp_name(struct user_event *user)
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
> +	}
> +
> +	return count;
> +}
> +
> +/*
> + * Copies the arguments while ensuring all ';' have a trailing space.
> + */
> +static char *fix_semis_no_space(char *args, int count)

nit: This name does not represent what it does. 'insert_space_after_semis()'
is more self-described.

> +{
> +	char *fixed, *pos;
> +	char c, last;
> +	int len;
> +
> +	len = strlen(args) + count;
> +	fixed = kmalloc(len + 1, GFP_KERNEL);
> +
> +	if (!fixed)
> +		return NULL;
> +
> +	pos = fixed;
> +	last = '\0';
> +
> +	while (len > 0) {
> +		c = *args++;
> +
> +		if (last == ';' && !isspace(c)) {
> +			*pos++ = ' ';
> +			len--;
> +		}
> +
> +		if (len > 0) {
> +			*pos++ = c;
> +			len--;
> +		}
> +
> +		last = c;
> +	}

nit: This loop can be simpler, because we are sure fixed has enough length;

/* insert a space after ';' if there is no space. */
while(*args) {
	*pos = *args++;
	if (*pos++ == ';' && !isspace(*args))
		*pos++ = ' ';
}

> +
> +	/*
> +	 * len is the length of the copy excluding the null.
> +	 * This ensures we always have room for a null.
> +	 */
> +	*pos = '\0';
> +
> +	return fixed;
> +}
> +
> +static char **user_event_argv_split(char *args, int *argc)
> +{
> +	/* Count how many ';' without a trailing space */
> +	int count = count_semis_no_space(args);
> +
> +	if (count) {

nit: it is better to exit fast, so 

	if (!count)
		return argv_split(GFP_KERNEL, args, argc);

	...

Thank you,

OT: BTW, can this also simplify synthetic events?

> +		/* We must fixup 'field;field' to 'field; field' */
> +		char *fixed = fix_semis_no_space(args, count);
> +		char **split;
> +
> +		if (!fixed)
> +			return NULL;
> +
> +		/* We do a normal split afterwards */
> +		split = argv_split(GFP_KERNEL, fixed, argc);
> +
> +		/* We can free since argv_split makes a copy */
> +		kfree(fixed);
> +
> +		return split;
> +	}
> +
> +	/* No fixup is required */
> +	return argv_split(GFP_KERNEL, args, argc);
> +}
> +
>  /*
>   * Parses the event name, arguments and flags then registers if successful.
>   * The name buffer lifetime is owned by this method for success cases only.
> @@ -2012,7 +2098,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  		return -EPERM;
>  
>  	if (args) {
> -		argv = argv_split(GFP_KERNEL, args, &argc);
> +		argv = user_event_argv_split(args, &argc);
>  
>  		if (!argv)
>  			return -ENOMEM;
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

