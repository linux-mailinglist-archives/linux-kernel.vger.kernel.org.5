Return-Path: <linux-kernel+bounces-74982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5C785E0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AE71C228FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBAF80050;
	Wed, 21 Feb 2024 15:15:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4B7BB01;
	Wed, 21 Feb 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528534; cv=none; b=iJBWiUIkEE9OylVogaDe+vO7WD8Ffvtq4ZJ6K0NwhFLByDsE8tJbGaHcHncA0FuxtPI+6mdtxxP+oS05QlSefm1gnlRKpPEZLzC1KCgSlOPtUymqMOxxzewflAjp06FSsGXbZtSmumzgoxf6Th5aKVEYEt5sQxV0nmW3TYme8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528534; c=relaxed/simple;
	bh=YHrLnauaskQSbiH77/IAsX8WjkWduQA2X1JXcmvI0Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDzvj+JVFj41imc6ZrcoD4ztgzipRlHpdrasf+1+c28quaA8e2tDqD5NbH0k6JJKfVbOdQFNo4GDENOV8IWmOxvR+DPTELuw5TMoElSwa4541iVNPIluNstSuFTzx3E9xLlZjxTuiHc6G7Zbw+5JdODgkqoQt2EAsa1p812hkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA850C43399;
	Wed, 21 Feb 2024 15:15:33 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:17:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3 1/4] tracing/user_events: Prepare find/delete for
 same name events
Message-ID: <20240221101721.4e81e9e5@gandalf.local.home>
In-Reply-To: <20240214175046.240-2-beaub@linux.microsoft.com>
References: <20240214175046.240-1-beaub@linux.microsoft.com>
	<20240214175046.240-2-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 17:50:43 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

So the patches look good, but since I gave you some updates, I'm now going
to go though "nits". Like grammar and such ;-)

> The current code for finding and deleting events assumes that there will
> never be cases when user_events are registered with the same name, but
> different formats. In the future this scenario will exist to ensure

> user programs can be updated or modify their events and run different
> versions of their programs side-by-side without being blocked.

Can you change the last sentence above. I read it three times and it's
still awkward to understand it. Particularly, the "user programs can be
updated or modify their events". That just doesn't want to compute.

> 
> This change does not yet allow for multi-format events. If user_events
> are registered with the same name but different arguments the programs
> see the same return values as before. This change simply makes it
> possible to easily accomodate for this in future changes.

I think you can drop the "in future changes" part.

> 
> Update find_user_event() to take in argument parameters and register
> flags to accomodate future multi-format event scenarios. Have find
> validate argument matching and return error pointers to cover address
> in use cases, or allocation errors. Update callers to handle error

  "to cover address in use cases" ?

> pointer logic.
> 
> Move delete_user_event() to use hash walking directly now that find has
> changed. Delete all events found that match the register name, stop

"now that find has changed" ?  You mean the "find function"?

> if an error occurs and report back to the user.
> 
> Update user_fields_match() to cover list_empty() scenarios instead of
> each callsite doing it now that find_user_event() uses it directly.

The above is a bit of a run-on sentence.

-- Steve

> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---

