Return-Path: <linux-kernel+bounces-75157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55385E3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B81F24A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F0583A09;
	Wed, 21 Feb 2024 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xa1OPKnv"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5CA4D9FD;
	Wed, 21 Feb 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535059; cv=none; b=hcnc45N9MtGApp/oDPuvyXq1hGOVynFhzRHp71Si6sNSDwGovXfWDd4dDBMqdSvIwzVA1i274ugfFWQkW3Awg/QKf35hZQpAGU4QOM7ygNF07NDZFgjGDxhLbXa2LE1Wp9rbGCdJGT2P3SwLax2FNC4RxdaFMZHaRawJzpfuxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535059; c=relaxed/simple;
	bh=wJjdBf0kDUo7w5pIahZt7IKBXLXXO6tr+OfriRn0oN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7ONivPhnIg4qW96YqKy2YzDClr306xzVdI+gm7My1PsaP7Ozy5or6m94oG2MbHd0Eaf1BenUvLu5bXF9pMV5o3GR/PrpiJ50eZNyw+YXa6GMLVl7H2AyyZCDMiXUKINCCqrSnH7qwy0N1BnLprVZxoEKLy0fnHmhjHQCdzSyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xa1OPKnv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9510D20B2000;
	Wed, 21 Feb 2024 09:04:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9510D20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708535057;
	bh=1LmAN3rqQzMKWs2iC58seTXPu1/RSRwYx7zwf21mMFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xa1OPKnv5IBxlOi15hxcaR16uj31FTD3RP3qzYr6DRqVPoqGIK6fZJe9R1r0JAH69
	 7TiDxIpc//atSYqggEIYe0j6gL3TZDthbzkQoSKtnYq8LdA4/OF/wVgsq3E2n2UBPo
	 iE2h7uAf4B1IIk+R+1rSyhsg83NkmWuYYwCCFnUQ=
Date: Wed, 21 Feb 2024 09:04:15 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3 1/4] tracing/user_events: Prepare find/delete for same
 name events
Message-ID: <20240221170415.GC441-beaub@linux.microsoft.com>
References: <20240214175046.240-1-beaub@linux.microsoft.com>
 <20240214175046.240-2-beaub@linux.microsoft.com>
 <20240221101721.4e81e9e5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221101721.4e81e9e5@gandalf.local.home>

On Wed, Feb 21, 2024 at 10:17:21AM -0500, Steven Rostedt wrote:
> On Wed, 14 Feb 2024 17:50:43 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> So the patches look good, but since I gave you some updates, I'm now going
> to go though "nits". Like grammar and such ;-)
> 

Sure thing.

> > The current code for finding and deleting events assumes that there will
> > never be cases when user_events are registered with the same name, but
> > different formats. In the future this scenario will exist to ensure
> 
> > user programs can be updated or modify their events and run different
> > versions of their programs side-by-side without being blocked.
> 
> Can you change the last sentence above. I read it three times and it's
> still awkward to understand it. Particularly, the "user programs can be
> updated or modify their events". That just doesn't want to compute.
> 

Yeah, I'll clean this up.

> > 
> > This change does not yet allow for multi-format events. If user_events
> > are registered with the same name but different arguments the programs
> > see the same return values as before. This change simply makes it
> > possible to easily accomodate for this in future changes.
> 
> I think you can drop the "in future changes" part.
> 

Agreed.

> > 
> > Update find_user_event() to take in argument parameters and register
> > flags to accomodate future multi-format event scenarios. Have find
> > validate argument matching and return error pointers to cover address
> > in use cases, or allocation errors. Update callers to handle error
> 
>   "to cover address in use cases" ?

Yeah, if the ABI is using a single-format event and it's already in use,
we return -EADDRINUSE. It does not happen in multi-format event cases,
since that is allowed.

I'll try to clarify this a bit.

> 
> > pointer logic.
> > 
> > Move delete_user_event() to use hash walking directly now that find has
> > changed. Delete all events found that match the register name, stop
> 
> "now that find has changed" ?  You mean the "find function"?
> 

Yeah, I'll just use the function name here, find_user_event().

> > if an error occurs and report back to the user.
> > 
> > Update user_fields_match() to cover list_empty() scenarios instead of
> > each callsite doing it now that find_user_event() uses it directly.
> 
> The above is a bit of a run-on sentence.
> 

I'll clean it up a bit.

Thanks,
-Beau

> -- Steve
> 
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---

