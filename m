Return-Path: <linux-kernel+bounces-96449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B193875C53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A67DB21A13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B423757;
	Fri,  8 Mar 2024 02:22:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00FA1D546;
	Fri,  8 Mar 2024 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864522; cv=none; b=uKvXqChZOAEHB7cA+ZoTq7objI36WebpkwMSATR3wYSk7UfTThx11W3WAxSC0GfQzpvHKYeT228NqzZzeNHausORNYhk7ozqUq4C+1QHhjdyJomWZ+uKI3rcBmvqCye05QoDInssnEPiry8CEmDNK52xUSO68JiXAbWXkUbSfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864522; c=relaxed/simple;
	bh=9k5wS4nfjnGWJxJjGHHRF+euX7yLf9FPEjDUuPmmKm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mz3bDQRsQyjR9l5FX/WM0BBYyJ+Jlejjw+Ck5bjdiHuzUh8BnqM0OZgjEbB3o0IdiHLqrf9GymUfr3cInni77fy+KJ6U4QhIt6+S/vHHB+tKCVpZG9W+cr2OoRkrJvemFJiIHN3Q9lUepJPn08rOB5780mOgatH3nmNy71PtjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C9BC43390;
	Fri,  8 Mar 2024 02:22:00 +0000 (UTC)
Date: Thu, 7 Mar 2024 21:23:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kassey Li <quic_yingangl@quicinc.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] workqueue: add function in event of
 workqueue_activate_work
Message-ID: <20240307212356.2e4d77d7@gandalf.local.home>
In-Reply-To: <20240308021818.2306176-1-quic_yingangl@quicinc.com>
References: <20240308021818.2306176-1-quic_yingangl@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Mar 2024 10:18:18 +0800
Kassey Li <quic_yingangl@quicinc.com> wrote:

> The trace event "workqueue_activate_work" only print work struct.
> However, function is the region of interest in a full sequence of work.
> Current workqueue_activate_work trace event output:
>=20
>     workqueue_activate_work: work struct ffffff88b4a0f450
>=20
> With this change, workqueue_activate_work will print the function name,
> align with workqueue_queue_work/execute_start/execute_end event.
>=20
>     workqueue_activate_work: work struct ffffff80413a78b8 function=3Dvmst=
at_update
>=20
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
> Changelog:
> v1: https://lore.kernel.org/all/20240308010929.1955339-1-quic_yingangl@qu=
icinc.com/
> v1->v2:
> - do not follow checkpatch in TRACE_EVENT() macros
> - add sample "workqueue_activate_work: work struct ffffff80413a78b8 funct=
ion=3Dvmstat_update"

=46rom a tracing POV,

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  include/trace/events/workqueue.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/trace/events/workqueue.h b/include/trace/events/work=
queue.h
> index 262d52021c23..6ef5b7254070 100644
> --- a/include/trace/events/workqueue.h
> +++ b/include/trace/events/workqueue.h
> @@ -64,13 +64,15 @@ TRACE_EVENT(workqueue_activate_work,
> =20
>  	TP_STRUCT__entry(
>  		__field( void *,	work	)
> +		__field( void *,	function)
>  	),
> =20
>  	TP_fast_assign(
>  		__entry->work		=3D work;
> +		__entry->function	=3D work->func;
>  	),
> =20
> -	TP_printk("work struct %p", __entry->work)
> +	TP_printk("work struct %p function=3D%ps ", __entry->work, __entry->fun=
ction)
>  );
> =20
>  /**


