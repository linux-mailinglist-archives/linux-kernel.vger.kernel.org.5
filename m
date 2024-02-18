Return-Path: <linux-kernel+bounces-70469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2785985B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84BD1F219F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1296EB78;
	Sun, 18 Feb 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifWmXuqy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2BE57E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278814; cv=none; b=MoBfGeiLqooE92AmJamHxLBCpQ0M2HvAd+2HdiV9N6ADJcgmzWzLCC8xPIabdvYU5wt9ZdU5A7LFc/yxLNWPj3Zj8hO47uUyk14kXXWKfAFgK5qEhNrf6jwZKvu/v0yUIEWtZhFCuwtiswDvTGlmI2XSg/mWbZ3saqLRXf8HRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278814; c=relaxed/simple;
	bh=8zoV8WXBsR0pcZhHyvtP8YXX7xixf7hY+qk/TnEcFzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEZOuvXCkWF/TZBZH85AkI0frLbAE2TpxZ4dwlzLIiRpoe/Um2Flm+AStL96lqvfi2V1es1eBHiVMW1Lbd+6XoPE+G490H87RG/Ra9P3yMs2Gyun15P/DzBn7Py7ZA9YnwuxKMrFPk81KxmKUIbgixwNHIaTWcxff9IIAijcDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifWmXuqy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708278811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zoV8WXBsR0pcZhHyvtP8YXX7xixf7hY+qk/TnEcFzQ=;
	b=ifWmXuqyUuGXWMXBx16MHXIDeBbKaZDjmc/ZXM4fm3LCwq0bz4slkkhQINOddQ5MFpDCT0
	sjftbpG7GBlQ4gmiQa1+vgb6obgFx2RZ1+3LcXFo8r1MrukV05O6Rhs54A4glvYANbfBrc
	tB+OLgkvSH6r1QKjrnOWYhJYU19mKf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-u4q3AoamNcWj4kzj3qtgLQ-1; Sun, 18 Feb 2024 12:53:25 -0500
X-MC-Unique: u4q3AoamNcWj4kzj3qtgLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 233FE85A589;
	Sun, 18 Feb 2024 17:53:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with SMTP id 323E42166B33;
	Sun, 18 Feb 2024 17:53:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 18 Feb 2024 18:52:07 +0100 (CET)
Date: Sun, 18 Feb 2024 18:52:04 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Wen Yang <wenyang.linux@foxmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240218175204.GB24311@redhat.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <tencent_6EFB821C2775D38F99EBFC6C9F7FAB82A809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_6EFB821C2775D38F99EBFC6C9F7FAB82A809@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/18, Wen Yang wrote:
>
> On 2024/2/17 18:49, Oleg Nesterov wrote:
> >On 02/17, wenyang.linux@foxmail.com wrote:
> >>From: Wen Yang <wenyang.linux@foxmail.com>
> >>
> >>Currently coredump_task_exit() takes some time to wait for the generation
> >>of the dump file. But if the user-space wants to receive a notification
> >>as soon as possible it maybe inconvenient.
> >>
> >>Add the new trace_sched_process_coredump() into coredump_task_exit(),
> >>this way a user-space monitor could easily wait for the exits and
> >>potentially make some preparations in advance.
> >Can't comment, I never know when the new tracepoint will make sense.
> >
> >Stupid question.
> >Oleg.
>
> Thanks for your help.

Well thanks, but no, I can't help. As I said I can't really comment this
patch.

> trace_sched_process_exit() is located after the PF_EXITING flag is set

Yes,

> so it could not be moved to there.

Why? DECLARE_EVENT_CLASS(sched_process_template) doesn't report task->flags.

Again, again, I am not arguing. But I think that the changelog should
explain why we can't move trace_sched_process_exit() in more details.

> Could we make the following modifications?
..
>
> @@ -2866,6 +2866,7 @@ bool get_signal(struct ksignal *ksig)
>                  * Anything else is fatal, maybe with a core dump.
>                  */
>                 current->flags |= PF_SIGNALED;
> +               trace_sched_process_kill(current);

Another case when I can't comment the intent.

We already have trace_signal_deliver() in get_signal(). I'm afraid you
need to explain why do you think userspace needs yet another tracepoint.

Oleg.


