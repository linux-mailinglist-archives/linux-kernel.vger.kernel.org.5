Return-Path: <linux-kernel+bounces-91546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC7987137E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDF81C22AC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49AF182C3;
	Tue,  5 Mar 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lCI0f0bu"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E118B1B;
	Tue,  5 Mar 2024 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605091; cv=none; b=KP3mekYN3dOBeU5pWc0ArlRCVs0hpbZNsx7tedUlJNVLDsP8tOo+h10GyxhDq/pqbrN6/Vzb7M8ToIKIZZVDEuoikmjJ7y9e7ukZu2JtB6YPYUtmiqi7DC3ZuxC8n//1ETUWkzsQ3HPQ2PHVQnLLCXFLV7h+SMG1z1Wt9XIEgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605091; c=relaxed/simple;
	bh=VznvMbha8hymNqu4p37WHwZZRbzqSFPs6oL0J0Wesc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O63trpDE8Rhd68834YEOEumuEFhvgVqlbNKfXiCozJIrl3RweTs5d0KodJ8GRHmdbRMcd4Y+2v+xoMmU8bbdUVxoxbCwafsgESmjm6lhUe93LyJbIItilpT+V8FJQNB5RxaEtw17wKWMxixFiBGRj7G9l/TjM0l0YksE6dEiko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lCI0f0bu; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709605087;
	bh=VznvMbha8hymNqu4p37WHwZZRbzqSFPs6oL0J0Wesc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lCI0f0buHVLHEA4+C2vqunZASFW0dtDkMnYAETOsi4r1ninB46Eq/i9Ri6Y4v9lbc
	 O375VKqlp+eLpMvhGf5bz5k78mmhuzGkFs4vFCMeHxj2owVpxY5P5Bu5PvbR3evXe3
	 a03T4JATbcMBoZGKQug5zU4ykc1hqReuRLFrz25rU+KBnZmF4a4KQO1s8MgQv3xTI3
	 l4SftT9Uc1xoH59TDO+HrrEFu8JvrOTZwofSxxtnnqfcXzhpx6sm3HwuHO4UBiI03x
	 JGOW2htX2YCOiPXUN9iE3KY+W4BU/aAA+bmpx4zpsPZiU7UfFvkjWxIbrAAbM+vtOd
	 SEnK0W4jSQ32g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TpfNv4z58zffp;
	Mon,  4 Mar 2024 21:18:07 -0500 (EST)
Message-ID: <cef0b07e-f90d-4759-ae54-0f091e87edab@efficios.com>
Date: Mon, 4 Mar 2024 21:18:13 -0500
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
 <91f27ba1-15a4-402d-8301-e2b9d23f64b0@efficios.com>
 <20240304205943.081bea96@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240304205943.081bea96@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-04 20:59, Steven Rostedt wrote:
> On Mon, 4 Mar 2024 20:42:39 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> #define TRACE_OUTPUT_META_DATA_MAX_LEN		80
>>
>> and a runtime check in the code generating this header.
>>
>> This would avoid adding an unchecked upper limit.
> 
> That would be a lot of complex code that is for debugging something that
> has never happened in the past 16 years and Linus has already reprimanded
> me on doing such things.

Is it more complex than remembering the iterator position in
print_trace_fmt() right before:

         if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO) {
                 if (iter->iter_flags & TRACE_FILE_LAT_FMT)
                         trace_print_lat_context(iter);
                 else
                         trace_print_context(iter);
         }

and then checking just after that the offset is not beyond 128
bytes ? Perhaps there is even something internal to "iter"
that already knows about this offset (?).

This would catch any context going beyond its planned upper
limit early. Failing early and not just in rare corner cases
is good.

And it's not for debugging, it's for validation of assumptions
made about an upper bound limit defined for a compile-time
check, so as the code evolves issues are caught early.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


