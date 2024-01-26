Return-Path: <linux-kernel+bounces-40603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B81283E30B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E677D2878BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3042263A;
	Fri, 26 Jan 2024 20:04:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDF22EE5;
	Fri, 26 Jan 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299484; cv=none; b=bNfmILJGi8FuKUdJCy4Og3OpKQbQ6NzuWEZAjBt/pRRE/WWIeq5UbftH1bHsLlr8uuKhyf3McDjrqNOBk8DO7479NlGZzOYFe4AGiVfW21ZaapvlEmwEExjvYCW5/FosKRNZ5TbU5xCtPco6B67rv0QmrJL99YWQF6dDsQrPwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299484; c=relaxed/simple;
	bh=IfeDUEa6PaW2Z0SPW3DXlCzgYBQGS6SOuHgow2fYReU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCQTeNpnd1YiOtxFvJOl7GORKn1OWskwA0bKnlnNwaHZenUXaxWilObOgwNerqO8yR2SdTUjOOQqSeZTBrCk0hXCp7tBsTFrniCccXbEgE3lrZ9HdCnmhhMmkIumNVFWFEjtGZdDfNuEcS5yTkXmOLGEE8RbenU9m9LZIHio974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288D4C433C7;
	Fri, 26 Jan 2024 20:04:43 +0000 (UTC)
Date: Fri, 26 Jan 2024 15:04:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240126150445.71c5d426@gandalf.local.home>
In-Reply-To: <20240126191007.GA456-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
	<20240123220844.928-3-beaub@linux.microsoft.com>
	<20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
	<20240126191007.GA456-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 11:10:07 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > OK, so the each different event has suffixed name. But this will
> > introduce non C-variable name.
> > 
> > Steve, do you think your library can handle these symbols? It will
> > be something like "event:[1]" as the event name.
> > Personally I like "event.1" style. (of course we need to ensure the
> > user given event name is NOT including such suffix numbers)
> >   
> 
> Just to clarify around events including a suffix number. This is why
> multi-events use "user_events_multi" system name and the single-events
> using just "user_events".
> 
> Even if a user program did include a suffix, the suffix would still get
> appended. An example is "test" vs "test:[0]" using multi-format would
> result in two tracepoints ("test:[0]" and "test:[0]:[1]" respectively
> (assuming these are the first multi-events on the system).
> 
> I'm with you, we really don't want any spoofing or squatting possible.
> By using different system names and always appending the suffix I
> believe covers this.
> 
> Looking forward to hearing Steven's thoughts on this as well.

I'm leaning towards Masami's suggestion to use dots, as that won't conflict
with special characters from bash, as '[' and ']' do.

-- Steve

