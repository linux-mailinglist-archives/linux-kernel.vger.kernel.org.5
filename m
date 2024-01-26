Return-Path: <linux-kernel+bounces-40237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66683DCFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8B81F22D08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6164E1CD09;
	Fri, 26 Jan 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDIHWsic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37281CA9A;
	Fri, 26 Jan 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281268; cv=none; b=sELD6XRU6Z2lBZWPDasBLIIzEw/hpWd0rpZ6Fbugwg1Pahv9dD6Q8GvAcUtPCH3/RESYY9UTZA7JJ4ohit7afPKYYO8N/+9uPbULjhrMnSS/0zTSI7Gb/Ol0f2rwflPi+YvY57jFQen8h26Jl/ml1MOFCgqoqq8QvdxT3TcmWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281268; c=relaxed/simple;
	bh=wpIIhHC7FF0JMdEEtnwkKOxQlezV/4Rsn65xHYSsIhI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cJXU34FlW57JHuJzH/bNhaq8B5mYmaH2y+obHVp+W2c73JzRbxBKM3gjkprO9GLw6Zk1jnoJgS1Do2rIoXKzmoB0f3xHMmvnO2/+ByPvXRX8MEkmMo1BrHe83P1wBr5x+AShlh8kM3mDhMSlARqXE8cQHs3fujdET6PMzS7f0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDIHWsic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8330C433C7;
	Fri, 26 Jan 2024 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706281268;
	bh=wpIIhHC7FF0JMdEEtnwkKOxQlezV/4Rsn65xHYSsIhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TDIHWsicbwX4uLgMVxG7k8LegcFu1it1TpGST36SCFPdMZRZbrc77saGR7XSsvJsy
	 NdSx7VVrmMHhANo6rqlfYmh7xc5bcwRkdVL7HOc/n8fpcwOWtHTZIXDbXS7KcXG3mW
	 xrp7ZFrcucY6WJ80WIU7bG5jV4YHsDEPmgHd2yQdH5aMd3jtZ4Yp1WYrqLUCJTMOix
	 ZwhlFv6xZkJ7dBE7aaSLHizboYxIsaaL1lQVwsDh4nq0UN7zYwQxEdzANpkcy7mriT
	 VTVmyRL79xrMxjoORy5h/87r1cEmXfXeECQbFdyr7HCqMrYEPyvFCgTaAeamHNScuj
	 2pFTEnafO1wXQ==
Date: Sat, 27 Jan 2024 00:01:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-Id: <20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
In-Reply-To: <20240123220844.928-3-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
	<20240123220844.928-3-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 22:08:42 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Add a register_name (reg_name) to the user_event struct which allows for
> split naming of events. We now have the name that was used to register
> within user_events as well as the unique name for the tracepoint. Upon
> registering events ensure matches based on first the reg_name, followed
> by the fields and format of the event. This allows for multiple events
> with the same registered name to have different formats. The underlying
> tracepoint will have a unique name in the format of {reg_name}:[unique_id].
> 
> For example, if both "test u32 value" and "test u64 value" are used with
> the USER_EVENT_REG_MULTI_FORMAT the system would have 2 unique
> tracepoints. The dynamic_events file would then show the following:
>   u:test u64 count
>   u:test u32 count
> 
> The actual tracepoint names look like this:
>   test:[d5874fdac44]
>   test:[d5914662cd4]
> 
> Both would be under the new user_events_multi system name to prevent the
> older ABI from being used to squat on multi-formatted events and block
> their use.
[...]
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
> +		len = snprintf(NULL, 0, "%s:[%llx]", user->reg_name,
> +			       user->group->multi_id) + 1;
> +
> +		multi_name = kzalloc(len, GFP_KERNEL_ACCOUNT);
> +
> +		if (!multi_name)
> +			return -ENOMEM;
> +
> +		snprintf(multi_name, len, "%s:[%llx]", user->reg_name,
> +			 user->group->multi_id);

OK, so the each different event has suffixed name. But this will
introduce non C-variable name.

Steve, do you think your library can handle these symbols? It will
be something like "event:[1]" as the event name.
Personally I like "event.1" style. (of course we need to ensure the
user given event name is NOT including such suffix numbers)

Thank you.

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

