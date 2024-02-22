Return-Path: <linux-kernel+bounces-77450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8285E860574
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965552888C0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2E12D21D;
	Thu, 22 Feb 2024 22:11:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C073F20;
	Thu, 22 Feb 2024 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639915; cv=none; b=M4Vi89pxeT8CKgOv0hHnndMUpzByY2r70O0Ir0sNfHE5klAYt1Nm03ilK9G06HBA1osWeS+6aOf9T7+j9uHmhGAqa+CMn9vTAdPE4r2uHKh3NFlptXQz3rltp+Gk4wH2EizPa0To1w/jiOLHuETuCFCCPjb3sRSxdV8vD+t3QY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639915; c=relaxed/simple;
	bh=p+8uhwqkWinqy5UVg9deOCr1wsUGH7ZlNzrnMxbpJCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbFrHna5KoxRWNvRIxCaYRqoFi4ZIFfm52b8lShWOGOXjtsTCxy3DOiphSdTa1oUb5BXmbWH8E9o7GxTktscmB2xsGwzrpFH17B6jdVX6QsE2gbV9HrR7IU4MNjl6sSeQnBSEZkHW0EYQ9KbpquPSZ7lRC41szybgvn6QmjN5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F909C433F1;
	Thu, 22 Feb 2024 22:11:54 +0000 (UTC)
Date: Thu, 22 Feb 2024 17:13:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 2/4] tracing/user_events: Introduce multi-format
 events
Message-ID: <20240222171345.25b1a289@gandalf.local.home>
In-Reply-To: <20240222001807.1463-3-beaub@linux.microsoft.com>
References: <20240222001807.1463-1-beaub@linux.microsoft.com>
	<20240222001807.1463-3-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 00:18:05 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Currently user_events supports 1 event with the same name and must have
> the exact same format when referenced by multiple programs. This opens
> an opportunity for malicous or poorly thought through programs to

  malicious? ;-)

-- Steve

> create events that others use with different formats. Another scenario
> is user programs wishing to use the same event name but add more fields
> later when the software updates. Various versions of a program may be
> running side-by-side, which is prevented by the current single format
> requirement.
> 
> Add a new register flag (USER_EVENT_REG_MULTI_FORMAT) which indicates
> the user program wishes to use the same user_event name, but may have
> several different formats of the event. When this flag is used, create
> the underlying tracepoint backing the user_event with a unique name
> per-version of the format. It's important that existing ABI users do
> not get this logic automatically, even if one of the multi format
> events matches the format. This ensures existing programs that create
> events and assume the tracepoint name will match exactly continue to
> work as expected. Add logic to only check multi-format events with
> other multi-format events and single-format events to only check
> single-format events during find.
> 
> Change system name of the multi-format event tracepoint to ensure that
> multi-format events are isolated completely from single-format events.
> This prevents single-format names from conflicting with multi-format
> events if they end with the same suffix as the multi-format events.
> 
> Add a register_name (reg_name) to the user_event struct which allows for
> split naming of events. We now have the name that was used to register
> within user_events as well as the unique name for the tracepoint. Upon
> registering events ensure matches based on first the reg_name, followed
> by the fields and format of the event. This allows for multiple events
> with the same registered name to have different formats. The underlying
> tracepoint will have a unique name in the format of {reg_name}.{unique_id}.
> 
> For example, if both "test u32 value" and "test u64 value" are used with
> the USER_EVENT_REG_MULTI_FORMAT the system would have 2 unique
> tracepoints. The dynamic_events file would then show the following:
>   u:test u64 count
>   u:test u32 count
> 
> The actual tracepoint names look like this:
>   test.0
>   test.1
> 
> Both would be under the new user_events_multi system name to prevent the
> older ABI from being used to squat on multi-formatted events and block
> their use.
> 
> Deleting events via "!u:test u64 count" would only delete the first
> tracepoint that matched that format. When the delete ABI is used all
> events with the same name will be attempted to be deleted. If
> per-version deletion is required, user programs should either not use
> persistent events or delete them via dynamic_events.
> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>

