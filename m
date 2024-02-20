Return-Path: <linux-kernel+bounces-73196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86F85BF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DAD285291
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C35F6BFC6;
	Tue, 20 Feb 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lxTrYu90"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D724C60;
	Tue, 20 Feb 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440616; cv=none; b=Mp9UtKgUtZiE7haDOyjwwpDgFQkv1av20WcN39AX4xmEzdtAOVdRHKrKV7+MPgzEfNRpgoNJVNovaLxgsqjVMsXBN7AFfI/dfLcdXm2u5K5SbulAzsqxg7hWBKgYoV5lNqCRAjsMaFeVVhvur9rL3ptSLLbBIE9MpSq+B7hUk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440616; c=relaxed/simple;
	bh=euHbDxFyPPGVlDKk4mAEbn56t1+RfQJUxqE3/YcCOwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pY8tpPmfBuX8KUi4DKrb6f/cGxXZ7o92ZVCNEq2pRS9WxRpOAWtURORZMAbIQBMXDX9WXg6sL7rk3kzXAQa1fOgsbmdhiQxUF9lCsLmy8VnhSiKG6xZQYL5vedN8pjpoPzGpSByFvYxx/FW5kW4FqzdKY3lVUg9OXNw3GmH3mcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lxTrYu90; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708440613;
	bh=euHbDxFyPPGVlDKk4mAEbn56t1+RfQJUxqE3/YcCOwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lxTrYu90uKIlyJi0Rjc6cK3nVw+ATH7T0WzwhIdeLOCKewFx4USVpAcRyX5jWVGa7
	 BHpVuotewDjQuTSLFWZ+AZi06Ev7FF3xYAadyKsaDsufuoPcV/olPDl1Ukdt8Oqj6y
	 g5zv5aFyAdxf+2jl0pkd3pPbrlOHiAYi/kKCP4otI2hYph7FZdhWR4SvpBA5uHenot
	 FpsYxNdMwimqqZXURKgb1j2C1Mtfh3BKX8KWaNDFt4+NHnae6FPAOwQh+54V2FRj13
	 V84smn+PEQSf0xS4k/5dB3iD7IRp7xbGBQyfM6sXSFfbj14xzd9x6B0B0tF5pCtLlm
	 vNFegNATfCSAA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TfMl92MX5zb06;
	Tue, 20 Feb 2024 09:50:13 -0500 (EST)
Message-ID: <168765ff-98ea-42a1-82f7-56178bfcf7ec@efficios.com>
Date: Tue, 20 Feb 2024 09:50:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20240219182032.2605d0a3@gandalf.local.home>
 <20240220091922.45848d9a@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240220091922.45848d9a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-20 09:19, Steven Rostedt wrote:
> On Mon, 19 Feb 2024 18:20:32 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Instead of using local_add_return() to reserve the ring buffer data,
>> Mathieu Desnoyers suggested using local_cmpxchg(). This would simplify the
>> reservation with the time keeping code.
>>
>> Although, it does not get rid of the double time stamps (before_stamp and
>> write_stamp), using cmpxchg() does get rid of the more complex case when
>> an interrupting event occurs between getting the timestamps and reserving
>> the data, as when that happens, it just tries again instead of dealing
>> with it.
>>
>> Before we had:
>>
>> 	w = local_read(&tail_page->write);
>> 	/* get time stamps */
>> 	write = local_add_return(length, &tail_page->write);
>> 	if (write - length == w) {
>> 		/* do simple case */
>> 	} else {
>> 		/* do complex case */
>> 	}
>>
>> By switching the local_add_return() to a local_try_cmpxchg() it can now be:
>>
>> 	 w = local_read(&tail_page->write);
>>   again:
>> 	/* get time stamps */
>> 	if (!local_try_cmpxchg(&tail_page->write, &w, w + length))
>> 		goto again;
>>
>> 	 /* do simple case */
> 
> Something about this logic is causing __rb_next_reserve() to sometimes
> always return -EAGAIN and triggering the:
> 
>      RB_WARN_ON(cpu_buffer, ++nr_loops > 1000)
> 
> Which disables the ring buffer.
> 
> I'm not sure what it is, but until I do, I'm removing the patch from my
> queue.

Try resetting the info->add_timestamp flags to add_ts_default on goto again
within __rb_reserve_next().

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


