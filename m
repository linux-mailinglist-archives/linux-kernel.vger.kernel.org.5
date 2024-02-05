Return-Path: <linux-kernel+bounces-52813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB3849CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B72285DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E52C1B5;
	Mon,  5 Feb 2024 14:24:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43522F11;
	Mon,  5 Feb 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143039; cv=none; b=aDQqU+/SffuCEVFq+NK7sBvXFZWSUHAcS+XSRZ6JNW8qYFqAb5t4IyvXUehkX4oGcAdsqwQ3Kc1ykvSwG5eXx5AwlnXW6lff9a5di/P6mvuqlrJomHZWKILYxjuwiurwIorYP0Q37EFA9HKazmSuo/x5s4u5VxsvUFULXK+FcX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143039; c=relaxed/simple;
	bh=PmGTdzP340f8wjyFFbDQqtNz1SFzSSuQPke4cWFfaHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXJjvPRHwyV9RgiaWqao06e+lTBtmQkSVXJNBEKd1iV3OonfMOVdd8twJCy/NI8gu5UrpjBoTXffPKi33bHcVB7PuhuXO62O8q1LCmC+129k2a+yTd2HoUdv8b0svyLIsNmyeRBAy/SmZu742D6OFKHcZYiKkALgaHc46d/+ucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5E0C433C7;
	Mon,  5 Feb 2024 14:23:57 +0000 (UTC)
Date: Mon, 5 Feb 2024 09:23:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Message-ID: <20240205092353.523cc1ef@rorschach.local.home>
In-Reply-To: <yt9djznj3vbl.fsf@linux.ibm.com>
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 Feb 2024 14:16:30 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:
> 
> Another issue i'm hitting sometimes is this part:
> 
> csum1=`md5sum trace`
> sleep $SLEEP_TIME
> csum2=`md5sum trace`
> 
> if [ "$csum1" != "$csum2" ]; then
>     fail "Tracing file is still changing"
> fi
> 
> This is because the command line was replaced in the
> saved_cmdlines_buffer, an example diff between both files
> is:

[..]

> 
> This can be improved by:
> 
> echo 32768 > /sys/kernel/tracing/saved_cmdlines_size
> 
> But this is of course not a fix - should we maybe replace the program
> name with <...> before comparing, remove the check completely, or do
> anything else? What do you think?

Hmm, actually I would say that this exposes a real bug. Not a major
one, but one that I find annoying. The saved commandlines should only
be updated when a trace event occurs. But really, it should only be
updated if one is added to the ring buffer. If the ring buffer isn't
being updated, we shouldn't be adding new command lines.

There may be a location that has tracing off but still updating the
cmdlines which will break the saved cache.

-- Steve


