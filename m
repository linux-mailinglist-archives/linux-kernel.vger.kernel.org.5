Return-Path: <linux-kernel+bounces-43780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E328418CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E3E2853F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA2C364C7;
	Tue, 30 Jan 2024 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCYneb/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2C364A9;
	Tue, 30 Jan 2024 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580577; cv=none; b=CkAbWTDAsHBvdRzIWHzuGfR8nDMC0N6y3o6as/1upZ+nwdxfnpn6TSNg7X7ohOiUzpnj/AA79QQeTid6pIt5wWmxXgMAj2TkhV9lm77HIAtWDJ/wxQp9+iWzwnw8qCbjOpLe+D8hHAieHcD+X41O7LUSaegzlIAEIY1fTIWQYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580577; c=relaxed/simple;
	bh=AtIFfKEU50x8ic2rwnKi7D3UN2L2uDca9A0dr0cTcgA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nJLOOyrw6ue/OPL0zYfVoN2QFRK7GzLIGsRQMa7bwHs2S5ph+IRXdCopxwWCJ6trOOHMUpzjyFxAXIHVNc/jIuWjtCO1NtLR3WWr941LCgEolgq7xEXLW7fms//1ipS6Uoz6CT/rppsWd+0U+SWbzjKMPS87ZMOABGtyBtkvAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCYneb/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E44C433F1;
	Tue, 30 Jan 2024 02:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706580577;
	bh=AtIFfKEU50x8ic2rwnKi7D3UN2L2uDca9A0dr0cTcgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kCYneb/wHH9FYwBKFArgINYa/RWHPpDkJmM7wHvq3Cd+ljtY35WXuv4iyOcgB+BQl
	 CaGx3SS2OCg9Jj0VmjZJ0msbYtb0ar290s6Cr5XO0tRMeVFMT5dwXIjRrYQ/u7YvK5
	 UkqpSmomg3teapn8jLCDoD5Xsb0EDpARpoAJEFRrjgrRTli2OBRYYioCIRMTVMKSZi
	 JDF6/4qgTiHsoQ65YQs4jhxomdOB2ZZ6NQ+nx0m4V5acO8vOA6pwJ1qSR7Y/mEL+Nq
	 GYvnMboCOU/EsvkBxLEMDBqXRs0m7tBE6oJNXXVgjTeyKaaxqKBgSR/iu2YQ/kGhwN
	 8he8duUWCE2hQ==
Date: Tue, 30 Jan 2024 11:09:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 0/4] tracing/user_events: Introduce multi-format events
Message-Id: <20240130110933.32c9aa0eceff2f0f917affd1@kernel.org>
In-Reply-To: <20240123220844.928-1-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Beau,

On Tue, 23 Jan 2024 22:08:40 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Currently user_events supports 1 event with the same name and must have
> the exact same format when referenced by multiple programs. This opens
> an opportunity for malicous or poorly thought through programs to
> create events that others use with different formats. Another scenario
> is user programs wishing to use the same event name but add more fields
> later when the software updates. Various versions of a program may be
> running side-by-side, which is prevented by the current single format
> requirement.
> 
> Add a new register flag (USER_EVENT_REG_MULTI_FORMAT) which indicates
> the user program wishes to use the same user_event name, but may have
> several different formats of the event in the future. When this flag is
> used, create the underlying tracepoint backing the user_event with a
> unique name per-version of the format. It's important that existing ABI
> users do not get this logic automatically, even if one of the multi
> format events matches the format. This ensures existing programs that
> create events and assume the tracepoint name will match exactly continue
> to work as expected. Add logic to only check multi-format events with
> other multi-format events and single-format events to only check
> single-format events during find.

Thanks for this work! This will allow many instance to use the same
user-events at the same time.

BTW, can we force this flag set by default? My concern is if any user
program use this user-event interface in the container (maybe it is
possible if we bind-mount it). In this case, the user program can
detect the other program is using the event if this flag is not set.
Moreover, if there is a malicious program running in the container,
it can prevent using the event name from other programs even if it
is isolated by the name-space.

Steve suggested that if a user program which is running in a namespace
uses user-event without this flag, we can reject that by default.

What would you think about?

Thank you,


> 
> Add a register_name (reg_name) to the user_event struct which allows for
> split naming of events. We now have the name that was used to register
> within user_events as well as the unique name for the tracepoint. Upon
> registering events ensure matches based on first the reg_name, followed
> by the fields and format of the event. This allows for multiple events
> with the same registered name to have different formats. The underlying
> tracepoint will have a unique name in the format of {reg_name}:[unique_id].
> The unique_id is the time, in nanoseconds, of the event creation converted
> to hex. Since this is done under the register mutex, it is extremely
> unlikely for these IDs to ever match. It's also very unlikely a malicious
> program could consistently guess what the name would be and attempt to
> squat on it via the single format ABI.
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
> Deleting events via "!u:test u64 count" would only delete the first
> tracepoint that matched that format. When the delete ABI is used all
> events with the same name will be attempted to be deleted. If
> per-version deletion is required, user programs should either not use
> persistent events or delete them via dynamic_events.
> 
> Beau Belgrave (4):
>   tracing/user_events: Prepare find/delete for same name events
>   tracing/user_events: Introduce multi-format events
>   selftests/user_events: Test multi-format events
>   tracing/user_events: Document multi-format flag
> 
>  Documentation/trace/user_events.rst           |  23 +-
>  include/uapi/linux/user_events.h              |   6 +-
>  kernel/trace/trace_events_user.c              | 224 +++++++++++++-----
>  .../testing/selftests/user_events/abi_test.c  | 134 +++++++++++
>  4 files changed, 325 insertions(+), 62 deletions(-)
> 
> 
> base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

