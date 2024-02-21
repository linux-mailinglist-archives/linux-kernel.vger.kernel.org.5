Return-Path: <linux-kernel+bounces-74966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D9485E088
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581A51F20FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F77FBDD;
	Wed, 21 Feb 2024 15:06:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A07FBA9;
	Wed, 21 Feb 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528006; cv=none; b=g9mhDgnbJwXOPzPWeI3c1s2v7gyinI+XrYim2flwOKjxuylV8RWXLjiM+S6T7gKzqzauwk7ZJVDv2prf6WZAg6bt3Yq46ANT5puo3z7sdl6T939Fdibs+xL555vokTI00WBCVq9+rog0fFqv6BV+lvqAovX8YzOkj1eCk+cca1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528006; c=relaxed/simple;
	bh=x4tyllg3kVsxkFGprOI8+rA4D5kFS9LnDsPy0r+Wi6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjeZGV1ngBqg0vrSQBpx3jwDneZDLu5Zjl2RZlHKcYFPLOZIMxPR25s/vFde6rKcopZL+FImmUOiVdzRkEAFdd5TpUfP1VztTMXO5Qx5IlD3qoH+wmsKA78CbiwM5+R5+UbM8B1RjSvCLbUobUtaVXkhHL/DVlupUpWCuhki8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707B6C43394;
	Wed, 21 Feb 2024 15:06:45 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:08:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3 2/4] tracing/user_events: Introduce multi-format
 events
Message-ID: <20240221100833.1eb5c254@gandalf.local.home>
In-Reply-To: <20240214175046.240-3-beaub@linux.microsoft.com>
References: <20240214175046.240-1-beaub@linux.microsoft.com>
	<20240214175046.240-3-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 17:50:44 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> +static char *user_event_group_system_multi_name(void)
> +{
> +	char *system_name;
> +	int len = sizeof(USER_EVENTS_MULTI_SYSTEM) + 1;

FYI, the sizeof() will include the "\0" so no need for "+ 1", but I don't
think this matters as for what I mention below.

> +
> +	system_name = kmalloc(len, GFP_KERNEL);
> +
> +	if (!system_name)
> +		return NULL;
> +
> +	snprintf(system_name, len, "%s", USER_EVENTS_MULTI_SYSTEM);
> +
> +	return system_name;

Hmm, the above looks like an open coded version of:

	system_name = kstrdup(USER_EVENTS_MULTI_SYSTEM, GFP_KERNEL);


> +}
> +
>  static struct user_event_group *current_user_event_group(void)
>  {
>  	return init_group;
> @@ -367,6 +390,11 @@ static struct user_event_group *user_event_group_create(void)
>  	if (!group->system_name)
>  		goto error;
>  
> +	group->system_multi_name = user_event_group_system_multi_name();
> +
> +	if (!group->system_multi_name)
> +		goto error;
> +
>  	mutex_init(&group->reg_mutex);
>  	hash_init(group->register_table);
>  
> @@ -1482,6 +1510,11 @@ static int destroy_user_event(struct user_event *user)
>  	hash_del(&user->node);
>  
>  	user_event_destroy_validators(user);
> +
> +	/* If we have different names, both must be freed */
> +	if (EVENT_NAME(user) != EVENT_TP_NAME(user))
> +		kfree(EVENT_TP_NAME(user));
> +
>  	kfree(user->call.print_fmt);
>  	kfree(EVENT_NAME(user));
>  	kfree(user);
> @@ -1504,12 +1537,24 @@ static struct user_event *find_user_event(struct user_event_group *group,
>  	*outkey = key;
>  
>  	hash_for_each_possible(group->register_table, user, node, key) {
> +		/*
> +		 * Single-format events shouldn't return multi-format
> +		 * events. Callers expect the underlying tracepoint to match
> +		 * the name exactly in these cases. Only check like-formats.
> +		 */
> +		if (EVENT_MULTI_FORMAT(flags) != EVENT_MULTI_FORMAT(user->reg_flags))
> +			continue;
> +
>  		if (strcmp(EVENT_NAME(user), name))
>  			continue;
>  
>  		if (user_fields_match(user, argc, argv))
>  			return user_event_get(user);
>  
> +		/* Scan others if this is a multi-format event */
> +		if (EVENT_MULTI_FORMAT(flags))
> +			continue;
> +
>  		return ERR_PTR(-EADDRINUSE);
>  	}
>  
> @@ -1889,8 +1934,12 @@ static bool user_event_match(const char *system, const char *event,
>  	struct user_event *user = container_of(ev, struct user_event, devent);
>  	bool match;
>  
> -	match = strcmp(EVENT_NAME(user), event) == 0 &&
> -		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
> +	match = strcmp(EVENT_NAME(user), event) == 0;
> +
> +	if (match && system) {
> +		match = strcmp(system, user->group->system_name) == 0 ||
> +			strcmp(system, user->group->system_multi_name) == 0;
> +	}
>  
>  	if (match)
>  		match = user_fields_match(user, argc, argv);
> @@ -1923,6 +1972,39 @@ static int user_event_trace_register(struct user_event *user)
>  	return ret;
>  }
>  
> +static int user_event_set_tp_name(struct user_event *user)
> +{
> +	lockdep_assert_held(&user->group->reg_mutex);
> +
> +	if (EVENT_MULTI_FORMAT(user->reg_flags)) {
> +		char *multi_name;
> +		int len;
> +
> +		len = snprintf(NULL, 0, "%s.%llx", user->reg_name,
> +			       user->group->multi_id) + 1;
> +
> +		multi_name = kzalloc(len, GFP_KERNEL_ACCOUNT);
> +
> +		if (!multi_name)
> +			return -ENOMEM;
> +
> +		snprintf(multi_name, len, "%s.%llx", user->reg_name,
> +			 user->group->multi_id);

I believe the above can be replaced with:

		multi_name = kasprintf(GFP_KERNEL_ACCOUNT, "%s.%llx", user->reg_name,
				       user->group->multi_id);
		if (!multi_name)
			return -ENOMEM;

-- Steve

> +
> +		user->call.name = multi_name;
> +		user->tracepoint.name = multi_name;
> +
> +		/* Inc to ensure unique multi-event name next time */
> +		user->group->multi_id++;
> +	} else {
> +		/* Non Multi-format uses register name */
> +		user->call.name = user->reg_name;
> +		user->tracepoint.name = user->reg_name;
> +	}
> +
> +	return 0;
> +}

