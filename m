Return-Path: <linux-kernel+bounces-74985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A54885E0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B281F27007
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704D8060D;
	Wed, 21 Feb 2024 15:19:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E280050;
	Wed, 21 Feb 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528758; cv=none; b=It16V+tRLy0efnQZHoaPpv7YyUrb30YELd//X1/C9zFXV3g1qul8r6y9NZ6Y8XnzOUFsiTpjiMk0F4hh8ZPCN1vNpeTNhcEVzCHk3ZtVzL0LPZG6PVRO6CVillRdJ8X4OpDYYak/teHVPEdMsHq6blP87wo5VOs+BKUuc/6Fr3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528758; c=relaxed/simple;
	bh=iKOHI6CLp4g2NCjQ6yWgSXnY2MzK0cTPEJKpWfebVYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gB9x0vedJayTTdtSqBbJJ0tHkNtTmaLIFkG0vtO6y+bADDt2bO0r9IIW2kXm98bLLZ7I/6TkkAPvf9LydjvB8QOO18IDNeqrhyjr9ErmY760QZD3zxSup9meX/9/BYr8O3cICMtS6ILJRDLQWzEsPJvp801CVxkArRxMfAG4Hos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04260C433A6;
	Wed, 21 Feb 2024 15:19:16 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:21:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3 2/4] tracing/user_events: Introduce multi-format
 events
Message-ID: <20240221102104.6ab80e5a@gandalf.local.home>
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

"of the event in the future." Does it have to be in the future? Is there
use case where an application might legitimately want the same event name
with different formats?

-- Steve

> used, create the underlying tracepoint backing the user_event with a
> unique name per-version of the format. It's important that existing ABI
> users do not get this logic automatically, even if one of the multi
> format events matches the format. This ensures existing programs that
> create events and assume the tracepoint name will match exactly continue
> to work as expected. Add logic to only check multi-format events with
> other multi-format events and single-format events to only check
> single-format events during find.
> 

