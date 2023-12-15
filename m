Return-Path: <linux-kernel+bounces-1244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE295814C54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884792854AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D739FD5;
	Fri, 15 Dec 2023 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ta7wbS5o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF613717F;
	Fri, 15 Dec 2023 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1702655619;
	bh=qzMh8frRtGFJ29d3oqzMz4SSOiBgHf2UGDFCUl3N0Qs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ta7wbS5oraWz0ep2zIvINP7c9WekLU3kFt+X+NJ8w5tsCzd/GIRB6a3jCcZJPGnR+
	 nb5uI/OGJVM8G2Gn/cymcMc49MnwbY9E/+bAHtSXcWFeOisE9kRKEN1q02IXBzTzNg
	 1DlnKIKyb8sxU590pphymOGppXtXTwnE5xrM+WzUBZXWcM4iHip9dHyu028A9b5HXk
	 6kVfIgazFe74ldumJXULV971fJRrPi3PqSfOo4sJjKJZGtPRuk3p6PbL023cBed2DI
	 jDpNTdypdAmNcBfWuPMd3ft5Qws4wBQtIvq1lBrB1kuHHcpLOoWictFQJ3/YdzI3+z
	 W4u/m/fLbgm2Q==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SsDKH3vG5zGb7;
	Fri, 15 Dec 2023 10:53:39 -0500 (EST)
Message-ID: <21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
Date: Fri, 15 Dec 2023 10:53:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20231215102633.7a24cb77@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231215102633.7a24cb77@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-15 10:26, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Normally, when the filter is enabled, a temporary buffer is created to
> copy the event data into it to perform the filtering logic. If the filter
> passes and the event should be recorded, then the event is copied from the
> temporary buffer into the ring buffer. If the event is to be discarded
> then it is simply dropped. If another event comes in via an interrupt, it
> will not use the temporary buffer as it is busy and will write directly
> into the ring buffer.
> 
> The disable-filter-buf option will disable the temporary buffer and always
> write into the ring buffer. This will avoid the copy when the event is to
> be recorded, but also adds a bit more overhead on the discard, and if
> another event were to interrupt the event that is to be discarded, then
> the event will not be removed from the ring buffer but instead converted
> to padding that will not be read by the reader. Padding will still take up
> space on the ring buffer.
> 
> This option can be beneficial if most events are recorded and not
> discarded, or simply for debugging the discard functionality of the ring
> buffer.
> 
> Also fix some whitespace (that was fixed by editing this in vscode).


I'm not convinced that a boolean state is what you need here.

Yes, today you are in a position where you have two options:

a) use the filter buffer, which falls back on copy to ring buffer
    if nested,

b) disable the filter buffer, and thus always copy to ring buffer
    before filtering,

But I think it would not be far-fetched to improve the implementation
of the filter-buffer to have one filter-buffer per nesting level
(per execution context), or just implement the filter buffer as a
per-cpu stack, which would remove the need to fall back on copy
to ring buffer when nested. Or you could even do like LTTng and
filter on the input arguments directly.

But each of these changes would add yet another boolean tunable,
which can quickly make the mix hard to understand from a user
perspective.

So rather than stacking tons of "on/off" switches for filter
features, how about you let users express the mechanism they
want to use for filtering with a string instead ? e.g.

filter-method="temp-buffer"
filter-method="ring-buffer"
filter-method="input-arguments"

?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


