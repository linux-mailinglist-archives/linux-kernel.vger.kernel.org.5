Return-Path: <linux-kernel+bounces-91508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54487126D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5FF1C226E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58517C79;
	Tue,  5 Mar 2024 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="whQ0YrKl"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC635CBD;
	Tue,  5 Mar 2024 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602955; cv=none; b=Bqf2KFSG0hdSCpIBKOSxmBSm5Bct82BRi2KDCT2R98Bz5Wbnc4jGDvtrK7FKy4BxZHdWBey59nZKH1VE/E5PRPafdZUA6WZIpEjFZcXGoNPJi2b789E9TI9M6bFhCZ9/oFXrssSROl4cHvoQHMp8d1+dloHVvrJ2vikrBe+JSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602955; c=relaxed/simple;
	bh=/Lpzc2sxxlqM30kwm13wev3MJZHwTfo3SXYSvymjDmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Six146rlge0gJT5GMxs7zrYUV1SDsMYyUd19eDHu5sU1Rmhj8EJ/fOt07UkatNpS7u2ALmqlOEOOIZUo30N3f0t7xhtw0/+bxqNlh8K62FSD69Sxyi2BanrtZLztFmzno+5QrPdBVHwbctS3OpPqf+JtL4jZkYcJbJZ9YyOP3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=whQ0YrKl; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709602952;
	bh=/Lpzc2sxxlqM30kwm13wev3MJZHwTfo3SXYSvymjDmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=whQ0YrKl8jau36tWYE2sKAAO+dkAAqBa47z2PlZZT4kasnOfChkBIr2HzAt4F6NOp
	 cXEURfs9f5Df2z8SFS658r/VaF862xkAvxTUN3hucMPdB/pzmfFOLvvxk/3iYY2jOU
	 SxOhtFEAulHkS5sQUhMpd9+eBn8bgwu7c0WBOrP9MGaZ7cNM2qw2dxW/botCHnpBya
	 6cTBDGCsGknyRyN5t9PeBN/224Ku6MU5tplImmVTs64ad8boFU0ZVF0KxhV5atpbrH
	 ZMMN1Hrt+2zIC0KFjFyeiEwxe63sSXqzQEn5JnMpJRmas9Fya8OIirnNtubASsIfn0
	 axhkcRHFGDw0w==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tpdbr4NG6zfYg;
	Mon,  4 Mar 2024 20:42:32 -0500 (EST)
Message-ID: <91f27ba1-15a4-402d-8301-e2b9d23f64b0@efficios.com>
Date: Mon, 4 Mar 2024 20:42:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
References: <20240304192710.4c99677c@gandalf.local.home>
 <469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
 <20240304203516.45b7a551@gandalf.local.home>
 <20240304204119.7503ab0b@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240304204119.7503ab0b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-04 20:41, Steven Rostedt wrote:
> On Mon, 4 Mar 2024 20:35:16 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> BUILD_BUG_ON(TRACING_MARK_MAX_SIZE + sizeof(meta data stuff...) > TRACE_SEQ_SIZE);
>>
>> That's not the meta size I'm worried about. The sizeof(meta data) is the
>> raw event binary data, which is not related to the size of the event output.
>>
>>   # cd /sys/kernel/tracing
>>   # echo hello > trace_marker
>>   # cat trace
>> [..]
>>             <...>-999     [001] .....  2296.140373: tracing_mark_write: hello
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     This is the meta data that is added to trace_seq
> 
> That said, the meta data is most likely not going to be more than 128 bytes
> (it shouldn't be more than 80).
> 
> I could do as you suggest and create a separate TRACE_MARKER_SIZE and just
> make sure that it's less than TRACE_SEQ_BUFFER_SIZE (as that's the size of
> the content) by 128 bytes.
> 
> /* Added meta data should not be more than 128 bytes */
> BUILD_BUG_ON((TRACE_MARKER_MAX_SIZE + 128) > TRACE_SEQ_BUFFER_SIZE);

Bonus points if you add

#define TRACE_OUTPUT_META_DATA_MAX_LEN		80

and a runtime check in the code generating this header.

This would avoid adding an unchecked upper limit.

Thanks,

Mathieu

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


