Return-Path: <linux-kernel+bounces-75143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C72E85E3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FED428558D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6F82D9E;
	Wed, 21 Feb 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fr3pny1G"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD388120C;
	Wed, 21 Feb 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534430; cv=none; b=DxlixcWNB0JSD7j6fZYYhxrJpZu75YO/5uIJmXfLLBBRahPAtGV8Tb9+uNv2PoPP37nncrClvpc7gBM+gpRr+Ge221VgDXmN/PSYkgv+p/QhDwB9yYZP338nxgh7NX9V3a9vdqFXk4vf4HYcWlFnjUsdKVER+eMRP9TFvo2pQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534430; c=relaxed/simple;
	bh=AxeeFvoKkLDcSkOcVOKeQwzTbC26QJBy/Prx61GhjMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIhrPNYhE4b/CqmP4RDw+0kLTnSIJLzj3KpG9sFWLq8+7kOhpnKO7WWuBG8lQMNWM9XL1sLKXNGC7hCDBMrJxnhsHnM9TRyWJNk4p2DPQ5r8Q9TO8LRTXJdhJmHfSv/Qzq5BWlk2U8DJVpN7PMOVZxeMbeooHl7uaqBWo4TTNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fr3pny1G; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3846A20B2000;
	Wed, 21 Feb 2024 08:53:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3846A20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708534423;
	bh=WoWK2cdZE5hAZaE+2mXpfqVJo/Fqx/LjLI1coCuc52g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fr3pny1GK3v+9/F9gBlLYrMCOgBpMSr8hLdVINUQFJvVBNDlt7wGE1nSPJuUoDvnQ
	 Mc7YYA8NxnVv2lkSnnOZc3tYEQYnC+XjCxXr8bepjMfP+P2vsyF5dSzoFonbLK6Ug2
	 YTclTNDCTk6KSinCTNwaP9pIxd0BGnybE1Fa51FY=
Date: Wed, 21 Feb 2024 08:53:37 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240221165337.GA441-beaub@linux.microsoft.com>
References: <20240214175046.240-1-beaub@linux.microsoft.com>
 <20240214175046.240-3-beaub@linux.microsoft.com>
 <20240221102104.6ab80e5a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221102104.6ab80e5a@gandalf.local.home>

On Wed, Feb 21, 2024 at 10:21:04AM -0500, Steven Rostedt wrote:
> On Wed, 14 Feb 2024 17:50:44 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Currently user_events supports 1 event with the same name and must have
> > the exact same format when referenced by multiple programs. This opens
> > an opportunity for malicous or poorly thought through programs to
> > create events that others use with different formats. Another scenario
> > is user programs wishing to use the same event name but add more fields
> > later when the software updates. Various versions of a program may be
> > running side-by-side, which is prevented by the current single format
> > requirement.
> > 
> > Add a new register flag (USER_EVENT_REG_MULTI_FORMAT) which indicates
> > the user program wishes to use the same user_event name, but may have
> > several different formats of the event in the future. When this flag is
> 
> "of the event in the future." Does it have to be in the future? Is there
> use case where an application might legitimately want the same event name
> with different formats?
> 

You're right, our use cases are mostly around future facing/compat.
There are valid cases where you just want several different formats with
the same name.

I'll drop the "in the future", so it'll just be "several different
formats".

Thanks,
-Beau

> -- Steve
> 
> > used, create the underlying tracepoint backing the user_event with a
> > unique name per-version of the format. It's important that existing ABI
> > users do not get this logic automatically, even if one of the multi
> > format events matches the format. This ensures existing programs that
> > create events and assume the tracepoint name will match exactly continue
> > to work as expected. Add logic to only check multi-format events with
> > other multi-format events and single-format events to only check
> > single-format events during find.
> > 

