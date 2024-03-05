Return-Path: <linux-kernel+bounces-92410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364FC871FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533AF1C21D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC1F8593B;
	Tue,  5 Mar 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ojt6sEpe"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2655E77;
	Tue,  5 Mar 2024 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644509; cv=none; b=gVqb6XJeW6UXfa2vKWUKJX1X4ShUgjjXA9gnifKEvuFas0TJ6QoDiTuagVYyMqqQxx8w2FpZ3Ng9ji2n4AmTx/nZ6RQDWP39E0IZ1wBSwVQT0tOfutfVzymQKfej4xhK/gdhG3AT7qK7BMSbsAgwc68oGOrucyCnqKqZiV1kH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644509; c=relaxed/simple;
	bh=Mt3i67yyuDydqnXVcgB2atQewvic9jWhmOAl8+mqlp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FN0Py/B0lVvn4TFU/tUJ0wKE7oyMeBWhNOCvvcCkyqet5WLgYMoteFFXI+aVfy0QxUfoE7v/A0vnmoxCt7KIm6UKDHh9oPfT2kNpZK4D0M8MyxlyTrPc/+UFwMVQxsdldojIpwxFtAN9nwZ4S07Ie8ssllpl6gLXoGwfK5Ng/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ojt6sEpe; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709644505;
	bh=Mt3i67yyuDydqnXVcgB2atQewvic9jWhmOAl8+mqlp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ojt6sEpeQVhUGth5jdjIC1w+pnTAsrrHqAn60/Q60wE07DS7tehtGry07t//rJjTC
	 A+TibrJnONGxbKeJKLXAkad2Ul9UZOEIreiilPe7KHtyFbSv7hli2qR957kS5pOUYX
	 vxdnxnEwEJw1jx9IrFudMeCNbiqH7dGk82XOMmWi5CGz9eo8IRDl1uDYxhWxqSXs+l
	 BqYeIeRCyKKuD22MfsyUTHvrPLQHGgH9WfsHoy5kKhp0Tae1RdEeHLuGDVSlZOTnMn
	 2k30Ycv7u6V4vnKWDP3MFZCwXny0UMEtIrQgJU+K/1wPbm4vPbQdaoRy3cpZB9nn+n
	 xO7cRO27Q5naQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tpwyx3TL0zfr1;
	Tue,  5 Mar 2024 08:15:05 -0500 (EST)
Message-ID: <2ad31b01-3529-439f-bc48-6b726ca5c66c@efficios.com>
Date: Tue, 5 Mar 2024 08:15:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: Limit trace_marker writes to just 4K
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
References: <20240304223433.4ba47dff@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240304223433.4ba47dff@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-04 22:34, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Limit the max print event of trace_marker to just 4K string size. This must
> also be less than the amount that can be held by a trace_seq along with
> the text that is before the output (like the task name, PID, CPU, state,
> etc). As trace_seq is made to handle large events (some greater than 4K).
> Make the max size of a trace_marker write event be 4K which is guaranteed
> to fit in the trace_seq buffer.
> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

 From my perspective I only attempted to clarify the point Linus made
about limiting the trace_marker input to 4kB. Feel adapt the
Suggested-by tag accordingly.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240304192710.4c99677c@gandalf.local.home/
> 
> - Just make the max limit 4K and not half of the trace_seq size.
>    The trace_seq is already made to handle events greater than 4k.
> 
>   kernel/trace/trace.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8198bfc54b58..d16b95ca58a7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7293,6 +7293,8 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
>   	return 0;
>   }
>   
> +#define TRACE_MARKER_MAX_SIZE		4096
> +
>   static ssize_t
>   tracing_mark_write(struct file *filp, const char __user *ubuf,
>   					size_t cnt, loff_t *fpos)
> @@ -7320,6 +7322,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>   	if ((ssize_t)cnt < 0)
>   		return -EINVAL;
>   
> +	if (cnt > TRACE_MARKER_MAX_SIZE)
> +		cnt = TRACE_MARKER_MAX_SIZE;
> +
>   	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
>    again:
>   	size = cnt + meta_size;
> @@ -7328,11 +7333,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>   	if (cnt < FAULTED_SIZE)
>   		size += FAULTED_SIZE - cnt;
>   
> -	if (size > TRACE_SEQ_BUFFER_SIZE) {
> -		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
> -		goto again;
> -	}
> -
>   	buffer = tr->array_buffer.buffer;
>   	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>   					    tracing_gen_ctx());

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


