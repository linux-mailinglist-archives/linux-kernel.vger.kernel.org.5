Return-Path: <linux-kernel+bounces-37840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B883B64D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B8A1C23E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A33D1369;
	Thu, 25 Jan 2024 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeP7lTCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808010E6;
	Thu, 25 Jan 2024 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144347; cv=none; b=WFdelNe3nq7rBGdl3ShKEz5JgTa4TgyGDFymYNEHH/a4rZ2Uw+UeVgluCu+z0GMyc7GDc+i4tKbtxuxtDmuBJ1uQTD4GEhoalVVdcoIaOV+US7Y8SVLwwViRGNNehxMxLw+WgGpXIAwDB83szs1MlKGBCsvOh+QY0g7rtzQrU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144347; c=relaxed/simple;
	bh=8zx8VInJbEn6Il+2QJF2mOpf6Byv0juF37c3fzeDGsM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iDdgMfvE/JmHVM4+1iLilRGVA3l2Bu6lOj966d3isnxH+2cwJ19Som9jgJVVGvQb3ZjEL2tQfzjPudkS96Qg9NRqj+2OTTAjWl29LRsKR4T7zdUCVyjAKKfRJgqOdUAyoXfAcgws/E8MqERzDQymQKQxoKQQPWhi3ab8dBSPzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeP7lTCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994DAC433F1;
	Thu, 25 Jan 2024 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706144346;
	bh=8zx8VInJbEn6Il+2QJF2mOpf6Byv0juF37c3fzeDGsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LeP7lTCmYa8/HJAfzgqmPmZ+5zZ6iIL2pMuLubPgov9S1nzLT1ihkRPRowqH36NwM
	 /pHjxp0h3eIa1oltXtlrnnnM2KE7edXd44SZwuoXYme+3jFazQ0sjvMx/xfKXXOXQI
	 /+BI6E8/nZBT7YYJGKNZaOXwJEbIEuX35qyzGJUDUFUtusyX3wAkSJsk4KzCcsElmb
	 7bfrQ2GqMkSxPRhcfkz7H9x2mN3/ZqxsNH3CGqOx5kCFD1VwGdSRZMJxpn67W5sKYi
	 3aUtFe8VIAmGp4aQ9DHr6xDapomO+IxLpzISGqkyE9iSF3s5OaIX1Ytv8RMDDcMaY7
	 phNxjNMp1MPvg==
Date: Thu, 25 Jan 2024 09:59:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 1/4] tracing/user_events: Prepare find/delete for same
 name events
Message-Id: <20240125095903.747d657ef53bbf8cf0ddb31c@kernel.org>
In-Reply-To: <20240123220844.928-2-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
	<20240123220844.928-2-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 22:08:41 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> The current code for finding and deleting events assumes that there will
> never be cases when user_events are registered with the same name, but
> different formats. In the future this scenario will exist to ensure
> user programs can be updated or modify their events and run different
> versions of their programs side-by-side without being blocked.

Ah, this is a very important point. Kernel always has only one instance
but user program doesn't. Thus it can define the same event name.
For the similar problem, uprobe event assumes that the user (here
admin) will define different group name to avoid it. But for the user
event, it is embedded, hmm.

> 
> This change does not yet allow for multi-format events. If user_events
> are registered with the same name but different arguments the programs
> see the same return values as before. This change simply makes it
> possible to easily accomodate for this in future changes.
> 
> Update find_user_event() to take in argument parameters and register
> flags to accomodate future multi-format event scenarios. Have find
> validate argument matching and return error pointers to cover address
> in use cases, or allocation errors. Update callers to handle error
> pointer logic.

Understand, that is similar to what probe events do.

> 
> Move delete_user_event() to use hash walking directly now that find has
> changed. Delete all events found that match the register name, stop
> if an error occurs and report back to the user.

What happen if we run 2 different version of the applications and terminate
one of them? The event which is used by others will be kept?

Thank you,

> 
> Update user_fields_match() to cover list_empty() scenarios instead of
> each callsite doing it now that find_user_event() uses it directly.
> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 106 +++++++++++++++++--------------
>  1 file changed, 58 insertions(+), 48 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 9365ce407426..0480579ba563 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -202,6 +202,8 @@ static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
>  static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
>  static void user_event_mm_put(struct user_event_mm *mm);
>  static int destroy_user_event(struct user_event *user);
> +static bool user_fields_match(struct user_event *user, int argc,
> +			      const char **argv);
>  
>  static u32 user_event_key(char *name)
>  {
> @@ -1493,17 +1495,24 @@ static int destroy_user_event(struct user_event *user)
>  }
>  
>  static struct user_event *find_user_event(struct user_event_group *group,
> -					  char *name, u32 *outkey)
> +					  char *name, int argc, const char **argv,
> +					  u32 flags, u32 *outkey)
>  {
>  	struct user_event *user;
>  	u32 key = user_event_key(name);
>  
>  	*outkey = key;
>  
> -	hash_for_each_possible(group->register_table, user, node, key)
> -		if (!strcmp(EVENT_NAME(user), name))
> +	hash_for_each_possible(group->register_table, user, node, key) {
> +		if (strcmp(EVENT_NAME(user), name))
> +			continue;
> +
> +		if (user_fields_match(user, argc, argv))
>  			return user_event_get(user);
>  
> +		return ERR_PTR(-EADDRINUSE);
> +	}
> +
>  	return NULL;
>  }
>  
> @@ -1860,6 +1869,9 @@ static bool user_fields_match(struct user_event *user, int argc,
>  	struct list_head *head = &user->fields;
>  	int i = 0;
>  
> +	if (argc == 0)
> +		return list_empty(head);
> +
>  	list_for_each_entry_reverse(field, head, link) {
>  		if (!user_field_match(field, argc, argv, &i))
>  			return false;
> @@ -1880,10 +1892,8 @@ static bool user_event_match(const char *system, const char *event,
>  	match = strcmp(EVENT_NAME(user), event) == 0 &&
>  		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
>  
> -	if (match && argc > 0)
> +	if (match)
>  		match = user_fields_match(user, argc, argv);
> -	else if (match && argc == 0)
> -		match = list_empty(&user->fields);
>  
>  	return match;
>  }
> @@ -1922,11 +1932,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  			    char *args, char *flags,
>  			    struct user_event **newuser, int reg_flags)
>  {
> -	int ret;
> -	u32 key;
>  	struct user_event *user;
> +	char **argv = NULL;
>  	int argc = 0;
> -	char **argv;
> +	int ret;
> +	u32 key;
>  
>  	/* Currently don't support any text based flags */
>  	if (flags != NULL)
> @@ -1935,41 +1945,34 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  	if (!user_event_capable(reg_flags))
>  		return -EPERM;
>  
> +	if (args) {
> +		argv = argv_split(GFP_KERNEL, args, &argc);
> +
> +		if (!argv)
> +			return -ENOMEM;
> +	}
> +
>  	/* Prevent dyn_event from racing */
>  	mutex_lock(&event_mutex);
> -	user = find_user_event(group, name, &key);
> +	user = find_user_event(group, name, argc, (const char **)argv,
> +			       reg_flags, &key);
>  	mutex_unlock(&event_mutex);
>  
> -	if (user) {
> -		if (args) {
> -			argv = argv_split(GFP_KERNEL, args, &argc);
> -			if (!argv) {
> -				ret = -ENOMEM;
> -				goto error;
> -			}
> +	if (argv)
> +		argv_free(argv);
>  
> -			ret = user_fields_match(user, argc, (const char **)argv);
> -			argv_free(argv);
> -
> -		} else
> -			ret = list_empty(&user->fields);
> -
> -		if (ret) {
> -			*newuser = user;
> -			/*
> -			 * Name is allocated by caller, free it since it already exists.
> -			 * Caller only worries about failure cases for freeing.
> -			 */
> -			kfree(name);
> -		} else {
> -			ret = -EADDRINUSE;
> -			goto error;
> -		}
> +	if (IS_ERR(user))
> +		return PTR_ERR(user);
> +
> +	if (user) {
> +		*newuser = user;
> +		/*
> +		 * Name is allocated by caller, free it since it already exists.
> +		 * Caller only worries about failure cases for freeing.
> +		 */
> +		kfree(name);
>  
>  		return 0;
> -error:
> -		user_event_put(user, false);
> -		return ret;
>  	}
>  
>  	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
> @@ -2052,25 +2055,32 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  }
>  
>  /*
> - * Deletes a previously created event if it is no longer being used.
> + * Deletes previously created events if they are no longer being used.
>   */
>  static int delete_user_event(struct user_event_group *group, char *name)
>  {
> -	u32 key;
> -	struct user_event *user = find_user_event(group, name, &key);
> +	struct user_event *user;
> +	u32 key = user_event_key(name);
> +	int ret = -ENOENT;
>  
> -	if (!user)
> -		return -ENOENT;
> +	/* Attempt to delete all event(s) with the name passed in */
> +	hash_for_each_possible(group->register_table, user, node, key) {
> +		if (strcmp(EVENT_NAME(user), name))
> +			continue;
>  
> -	user_event_put(user, true);
> +		if (!user_event_last_ref(user))
> +			return -EBUSY;
>  
> -	if (!user_event_last_ref(user))
> -		return -EBUSY;
> +		if (!user_event_capable(user->reg_flags))
> +			return -EPERM;
>  
> -	if (!user_event_capable(user->reg_flags))
> -		return -EPERM;
> +		ret = destroy_user_event(user);
>  
> -	return destroy_user_event(user);
> +		if (ret)
> +			goto out;
> +	}
> +out:
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

