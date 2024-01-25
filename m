Return-Path: <linux-kernel+bounces-39035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B06583C9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896682969BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3A6EB67;
	Thu, 25 Jan 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H+fx3MID"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EBB6EB5D;
	Thu, 25 Jan 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203576; cv=none; b=p0rY19KCZT1H1vGDuN3pqMzxf0GjFUd5YvP+BVP8n4Jsyhnr+jlxU7mct1NaBUsnZ8lWAPqTIJ1BEeC3F+w8wd5vNetfKSGLiSDmufNY18CSer6fe4m8McAdw2K7+JLVXQGCYLyiyhwEMkXdFYyKI2bOPwlU4NRvRf9Qmiw9Wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203576; c=relaxed/simple;
	bh=ATFVMV5gFGShOpTNlWx004gxAfv5ocKeIvouTse+2k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps883YimOYeFY9H942mUvMsmxjYLJiNg9lA+j3BcdVbwBbM8CEN+fy+wspU7uMv0giA6/MlEygTnsy7T8DHfb/J5TVEQHApAS6a1SNKgosmyd2xW8YnMBGepBuYms20uBncDmYD7UHiJKuICAnhQr+FpWOtNAV858klDXunPC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H+fx3MID; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id A042F20E56B9;
	Thu, 25 Jan 2024 09:26:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A042F20E56B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706203574;
	bh=n8WD6CdN9xvqz02mq0utwmZs6xtl6OMyi2i4cJ2+O5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+fx3MIDtwH2lZhoue1LG68zQjVlmb08xh09XlhOwn4luCg9IbmYw7tN9QU/x9kG8
	 8b4x7tJOyOd6UxhukD+s0Zqwh05v0UoA+l4bTJIWigpEcAUPHNjnaUwxsdSZOxWdur
	 1Fzrv0Rl29aOTVt2S6dBwQ9fVEpJ9dYgo+1Y7xew=
Date: Thu, 25 Jan 2024 09:26:11 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 1/4] tracing/user_events: Prepare find/delete for same
 name events
Message-ID: <20240125172611.GA443-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
 <20240123220844.928-2-beaub@linux.microsoft.com>
 <20240125095903.747d657ef53bbf8cf0ddb31c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125095903.747d657ef53bbf8cf0ddb31c@kernel.org>

On Thu, Jan 25, 2024 at 09:59:03AM +0900, Masami Hiramatsu wrote:
> On Tue, 23 Jan 2024 22:08:41 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > The current code for finding and deleting events assumes that there will
> > never be cases when user_events are registered with the same name, but
> > different formats. In the future this scenario will exist to ensure
> > user programs can be updated or modify their events and run different
> > versions of their programs side-by-side without being blocked.
> 
> Ah, this is a very important point. Kernel always has only one instance
> but user program doesn't. Thus it can define the same event name.
> For the similar problem, uprobe event assumes that the user (here
> admin) will define different group name to avoid it. But for the user
> event, it is embedded, hmm.
> 

Yes, the series will handle if multi-processes use the same name, we
will find a matching version of that name within the user_event group.
If there isn't one, a new one is created. Each is backed by an
independent tracepoint which does match up with how uprobe does it. This
actually got brought up in the tracefs meetings we've had and it seemed
to get wide agreement on how to best handle this.

> > 
> > This change does not yet allow for multi-format events. If user_events
> > are registered with the same name but different arguments the programs
> > see the same return values as before. This change simply makes it
> > possible to easily accomodate for this in future changes.
> > 
> > Update find_user_event() to take in argument parameters and register
> > flags to accomodate future multi-format event scenarios. Have find
> > validate argument matching and return error pointers to cover address
> > in use cases, or allocation errors. Update callers to handle error
> > pointer logic.
> 
> Understand, that is similar to what probe events do.
> 
> > 
> > Move delete_user_event() to use hash walking directly now that find has
> > changed. Delete all events found that match the register name, stop
> > if an error occurs and report back to the user.
> 
> What happen if we run 2 different version of the applications and terminate
> one of them? The event which is used by others will be kept?
> 

Each unique version of a user_event has it's own ref-count. If one
version is not-used, but another version is, only the not-used version
will get deleted. The other version that is in use will return a -EBUSY
when it gets to that version via enumeration.

While we only have a single tracepoint per-version, we have several
user_event structures in memory that have the same name, yet different
formats. Each of which have their own lifetime, enablers and ref-counts
to keep them isolated from each other.

Thanks,
-Beau

> Thank you,
> 
> > 
> > Update user_fields_match() to cover list_empty() scenarios instead of
> > each callsite doing it now that find_user_event() uses it directly.
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  kernel/trace/trace_events_user.c | 106 +++++++++++++++++--------------
> >  1 file changed, 58 insertions(+), 48 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index 9365ce407426..0480579ba563 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -202,6 +202,8 @@ static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
> >  static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
> >  static void user_event_mm_put(struct user_event_mm *mm);
> >  static int destroy_user_event(struct user_event *user);
> > +static bool user_fields_match(struct user_event *user, int argc,
> > +			      const char **argv);
> >  
> >  static u32 user_event_key(char *name)
> >  {
> > @@ -1493,17 +1495,24 @@ static int destroy_user_event(struct user_event *user)
> >  }
> >  
> >  static struct user_event *find_user_event(struct user_event_group *group,
> > -					  char *name, u32 *outkey)
> > +					  char *name, int argc, const char **argv,
> > +					  u32 flags, u32 *outkey)
> >  {
> >  	struct user_event *user;
> >  	u32 key = user_event_key(name);
> >  
> >  	*outkey = key;
> >  
> > -	hash_for_each_possible(group->register_table, user, node, key)
> > -		if (!strcmp(EVENT_NAME(user), name))
> > +	hash_for_each_possible(group->register_table, user, node, key) {
> > +		if (strcmp(EVENT_NAME(user), name))
> > +			continue;
> > +
> > +		if (user_fields_match(user, argc, argv))
> >  			return user_event_get(user);
> >  
> > +		return ERR_PTR(-EADDRINUSE);
> > +	}
> > +
> >  	return NULL;
> >  }
> >  
> > @@ -1860,6 +1869,9 @@ static bool user_fields_match(struct user_event *user, int argc,
> >  	struct list_head *head = &user->fields;
> >  	int i = 0;
> >  
> > +	if (argc == 0)
> > +		return list_empty(head);
> > +
> >  	list_for_each_entry_reverse(field, head, link) {
> >  		if (!user_field_match(field, argc, argv, &i))
> >  			return false;
> > @@ -1880,10 +1892,8 @@ static bool user_event_match(const char *system, const char *event,
> >  	match = strcmp(EVENT_NAME(user), event) == 0 &&
> >  		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
> >  
> > -	if (match && argc > 0)
> > +	if (match)
> >  		match = user_fields_match(user, argc, argv);
> > -	else if (match && argc == 0)
> > -		match = list_empty(&user->fields);
> >  
> >  	return match;
> >  }
> > @@ -1922,11 +1932,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >  			    char *args, char *flags,
> >  			    struct user_event **newuser, int reg_flags)
> >  {
> > -	int ret;
> > -	u32 key;
> >  	struct user_event *user;
> > +	char **argv = NULL;
> >  	int argc = 0;
> > -	char **argv;
> > +	int ret;
> > +	u32 key;
> >  
> >  	/* Currently don't support any text based flags */
> >  	if (flags != NULL)
> > @@ -1935,41 +1945,34 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >  	if (!user_event_capable(reg_flags))
> >  		return -EPERM;
> >  
> > +	if (args) {
> > +		argv = argv_split(GFP_KERNEL, args, &argc);
> > +
> > +		if (!argv)
> > +			return -ENOMEM;
> > +	}
> > +
> >  	/* Prevent dyn_event from racing */
> >  	mutex_lock(&event_mutex);
> > -	user = find_user_event(group, name, &key);
> > +	user = find_user_event(group, name, argc, (const char **)argv,
> > +			       reg_flags, &key);
> >  	mutex_unlock(&event_mutex);
> >  
> > -	if (user) {
> > -		if (args) {
> > -			argv = argv_split(GFP_KERNEL, args, &argc);
> > -			if (!argv) {
> > -				ret = -ENOMEM;
> > -				goto error;
> > -			}
> > +	if (argv)
> > +		argv_free(argv);
> >  
> > -			ret = user_fields_match(user, argc, (const char **)argv);
> > -			argv_free(argv);
> > -
> > -		} else
> > -			ret = list_empty(&user->fields);
> > -
> > -		if (ret) {
> > -			*newuser = user;
> > -			/*
> > -			 * Name is allocated by caller, free it since it already exists.
> > -			 * Caller only worries about failure cases for freeing.
> > -			 */
> > -			kfree(name);
> > -		} else {
> > -			ret = -EADDRINUSE;
> > -			goto error;
> > -		}
> > +	if (IS_ERR(user))
> > +		return PTR_ERR(user);
> > +
> > +	if (user) {
> > +		*newuser = user;
> > +		/*
> > +		 * Name is allocated by caller, free it since it already exists.
> > +		 * Caller only worries about failure cases for freeing.
> > +		 */
> > +		kfree(name);
> >  
> >  		return 0;
> > -error:
> > -		user_event_put(user, false);
> > -		return ret;
> >  	}
> >  
> >  	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
> > @@ -2052,25 +2055,32 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >  }
> >  
> >  /*
> > - * Deletes a previously created event if it is no longer being used.
> > + * Deletes previously created events if they are no longer being used.
> >   */
> >  static int delete_user_event(struct user_event_group *group, char *name)
> >  {
> > -	u32 key;
> > -	struct user_event *user = find_user_event(group, name, &key);
> > +	struct user_event *user;
> > +	u32 key = user_event_key(name);
> > +	int ret = -ENOENT;
> >  
> > -	if (!user)
> > -		return -ENOENT;
> > +	/* Attempt to delete all event(s) with the name passed in */
> > +	hash_for_each_possible(group->register_table, user, node, key) {
> > +		if (strcmp(EVENT_NAME(user), name))
> > +			continue;
> >  
> > -	user_event_put(user, true);
> > +		if (!user_event_last_ref(user))
> > +			return -EBUSY;
> >  
> > -	if (!user_event_last_ref(user))
> > -		return -EBUSY;
> > +		if (!user_event_capable(user->reg_flags))
> > +			return -EPERM;
> >  
> > -	if (!user_event_capable(user->reg_flags))
> > -		return -EPERM;
> > +		ret = destroy_user_event(user);
> >  
> > -	return destroy_user_event(user);
> > +		if (ret)
> > +			goto out;
> > +	}
> > +out:
> > +	return ret;
> >  }
> >  
> >  /*
> > -- 
> > 2.34.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

