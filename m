Return-Path: <linux-kernel+bounces-77445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B1860567
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42E12861E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314C12D20E;
	Thu, 22 Feb 2024 22:06:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8ED14B81E;
	Thu, 22 Feb 2024 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639609; cv=none; b=nOdza6Om5F1IdHbMmHE4T6qLu6Ja9H6KZf9FnLm7pNt5PA3PPOe1oQfT57UFWQiCRvVjPFHiShQwclniEZo9lODGlE3GaMSPnyDpW0C/ES36QPigKx/3uIGXCZGwIo1hmiAY8fSvKLv/kBV64m3NISdCY4j5EpVRGeFWTgklNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639609; c=relaxed/simple;
	bh=CcqVXZKOZvvXSd+1YjEThyoYmIB+ItQXeZkjhL40xkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geZrlWdRg8qjYtsfKZAlCMcC1W105hnyzrFhsAuKpAZyZYK73bWwOe2kYyEeSHCUgsaPfdPI3YZZ3utuVvO+GOZviIcaW4dyr93oxsdtyw7vFwW6nRkh38jN8C7ux0cu1N3z8QhycaFx1SUK7r8U2tdJo+PgiXezrlGFGYIXCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E38C433F1;
	Thu, 22 Feb 2024 22:06:48 +0000 (UTC)
Date: Thu, 22 Feb 2024 17:08:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 1/4] tracing/user_events: Prepare find/delete for
 same name events
Message-ID: <20240222170839.71c0b1bf@gandalf.local.home>
In-Reply-To: <20240222001807.1463-2-beaub@linux.microsoft.com>
References: <20240222001807.1463-1-beaub@linux.microsoft.com>
	<20240222001807.1463-2-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 00:18:04 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> The current code for finding and deleting events assumes that there will
> never be cases when user_events are registered with the same name, but
> different formats. Scenarios exist where programs want to use the same
> name but have different formats. An example is multiple versions of a
> program running side-by-side using the same event name, but with updated
> formats in each version.
> 
> This change does not yet allow for multi-format events. If user_events
> are registered with the same name but different arguments the programs
> see the same return values as before. This change simply makes it
> possible to easily accomodate for this.

 accommodate? ;-)

> 
> Update find_user_event() to take in argument parameters and register
> flags to accomodate future multi-format event scenarios. Have find

  accommodate

> validate argument matching and return error pointers to cover when
> an existing event has the same name but different format. Update
> callers to handle error pointer logic.
> 
> Move delete_user_event() to use hash walking directly now that
> find_user_event() has changed. Delete all events found that match the
> register name, stop if an error occurs and report back to the user.
> 
> Update user_fields_match() to cover list_empty() scenarios now that
> find_user_event() uses it directly. This makes the logic consistent
> accross several callsites.

  across ?

I'll update this.

-- Steve

> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>

