Return-Path: <linux-kernel+bounces-97496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A256C876B0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27894B21A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB45917C;
	Fri,  8 Mar 2024 19:11:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189356473;
	Fri,  8 Mar 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925076; cv=none; b=M6Ylgyy4uJUynZvwqsX6iYtxITzSAgHOaf20ZYLS97BrmRDMBcR73rPCPfWF3Dd3iU1O9BoK+keEl1DUGnlcTAp30y/rcwU+PG5amWqpqHCUgPsTKQNIB9DMlasspaukPZlE8+o3lVBHCWpl6RTV938ej5DxAAScjKOp66NJPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925076; c=relaxed/simple;
	bh=5iYekLuVg5uyeI7ptQHbUlgVXer2/uWfi4AzNIce3mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh7LU1cTYBpKCERt/RywD5uYeIWvvJRSmx3V1al/i/DdFIP8e6H45yV4j91U1ouN3LPSG0TTFJfJd4fSdBWks9fPKqQl/xNNX+2csYGj7Hbae6UIcPWvwi1EDEBPQGmDxV4s1kPAxANJCRe4nMrgB+Y1zXo6p13dKOEBjHo5uO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26841C433F1;
	Fri,  8 Mar 2024 19:11:14 +0000 (UTC)
Date: Fri, 8 Mar 2024 14:13:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, joel@joelfernandes.org, linke li
 <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>, stable@vger.kernel.org
Subject: Re: [PATCH 4/6] tracing: Fix waking up tracing readers
Message-ID: <20240308141311.03eefef1@gandalf.local.home>
In-Reply-To: <20240308184007.805898590@goodmis.org>
References: <20240308183816.676883229@goodmis.org>
	<20240308184007.805898590@goodmis.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Mar 2024 13:38:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +static DEFINE_MUTEX(wait_mutex);
> +
> +static bool wait_woken_prepare(struct trace_iterator *iter, int *wait_index)
> +{
> +	bool woken = false;
> +
> +	mutex_lock(&wait_mutex);
> +	if (iter->waking)
> +		woken = true;
> +	*wait_index = iter->wait_index;
> +	mutex_unlock(&wait_mutex);
> +
> +	return woken;
> +}

The last patch adds this code after a prepare_to_wait(), which triggered
the warning:

  do not call blocking ops when !TASK_RUNNING; state=1 set at [<00000000797e3e20>] prepare_to_wait+0x48/0xf0

Which is correct. The prepare_to_wait() set task state to
TASK_INTERRUPTIBLE, so I can not call a mutex after that.

I'll send a v2 where I switch this over to spin locks.

-- Steve


> +
> +static bool wait_woken_check(struct trace_iterator *iter, int *wait_index)
> +{
> +	bool woken = false;
> +
> +	mutex_lock(&wait_mutex);
> +	if (iter->waking || *wait_index != iter->wait_index)
> +		woken = true;
> +	mutex_unlock(&wait_mutex);
> +
> +	return woken;
> +}
> +
> +static void wait_woken_set(struct trace_iterator *iter)
> +{
> +	mutex_lock(&wait_mutex);
> +	iter->waking++;
> +	iter->wait_index++;
> +	mutex_unlock(&wait_mutex);
> +}
> +
> +static void wait_woken_clear(struct trace_iterator *iter)
> +{
> +	mutex_lock(&wait_mutex);
> +	iter->waking--;
> +	mutex_unlock(&wait_mutex);
> +}
> +

