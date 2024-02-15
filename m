Return-Path: <linux-kernel+bounces-66996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5C6856493
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA3428CD19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0199130AFC;
	Thu, 15 Feb 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5I3h011"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2B130AEC;
	Thu, 15 Feb 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004256; cv=none; b=hqoVYiwbouHRB99X0B/BUvL2/acyPyspd6OjURFYhDF/ZEvIfEscx3xPxzvfEALqmEeDtmedE9jNpIw950rnxNBEgYyB+bm9Uahav7skKe9BYuhiYR4rh1keluzNQwbqm50qhl3/Gl4XGpe2L4RgJhNM1Dpn3m93vY8AyvzULWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004256; c=relaxed/simple;
	bh=dd8VzwiyY6PWQnftEh/QChhKebOTlXJhx+oLuoxNJuo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RbM3/TnYfTEItdWtvNJUQJs8LZyGCntaeRw7aZwqPWjX0HtJY0JMB7AYvWxFleJLSU+HihCBVhxVag/RM0H8dCOSCPbkHjYc+5MR3A5ftGwi80gzJIPaKMU9kReRB28qsC3Ai4plEEkDAoV0y5OJTHRqMEjxYLIUzQC3TS2Yuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5I3h011; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24777C433F1;
	Thu, 15 Feb 2024 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708004255;
	bh=dd8VzwiyY6PWQnftEh/QChhKebOTlXJhx+oLuoxNJuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K5I3h0116noauedXgGtpUofyQXu2ASXvS92ypx1O0oKqZ1pg2IBFLNBXXVv6gu9DK
	 +xtk/Ly2f7EZDzgClXM8jKIzJ7rc8fghGjGB55R3OALwY0FVSCOdI/r4NDKuu4frKv
	 IbsiX3owlZPX/zRosVS7D1iU5kjo0KlQwwB4jCZve7tq4bNvRnCx8InFwjzNe57k8w
	 qZlUIK80SWH3NF4cU9cdFh9/sp+6Xae1EI6Yi5JGuvqS0L9YQTEuYZaUGbeGdkmuLZ
	 fla1WUWA/KMbu9Mt4O/CmBfCqyXSwtsE0Ra2jQd4OmMfCgCHf9MJRLyLyxYyuTZgGY
	 7k7l1TqffD9WQ==
Date: Thu, 15 Feb 2024 22:37:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] synthetic tracing: Fix trace_string() return value
Message-Id: <20240215223731.39f2ae9ab8657d5fe739bab5@kernel.org>
In-Reply-To: <20240214220555.711598-1-thorsten.blum@toblux.com>
References: <20240214220555.711598-1-thorsten.blum@toblux.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 23:05:56 +0100
Thorsten Blum <thorsten.blum@toblux.com> wrote:

> Fix trace_string() by assigning the string length to the return variable
> which got lost in commit ddeea494a16f ("tracing/synthetic: Use union
> instead of casts") and caused trace_string() to always return 0.
> 

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fixes: ddeea494a16f ("tracing/synthetic: Use union instead of casts")
Cc: stable@vger.kernel.org

Thanks!

> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/trace/trace_events_synth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index e7af286af4f1..c82b401a294d 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -441,8 +441,9 @@ static unsigned int trace_string(struct synth_trace_event *entry,
>  	if (is_dynamic) {
>  		union trace_synth_field *data = &entry->fields[*n_u64];
>  
> +		len = fetch_store_strlen((unsigned long)str_val);
>  		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
> -		data->as_dynamic.len = fetch_store_strlen((unsigned long)str_val);
> +		data->as_dynamic.len = len;
>  
>  		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
>  
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

