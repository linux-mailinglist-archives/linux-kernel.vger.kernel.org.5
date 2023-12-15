Return-Path: <linux-kernel+bounces-1550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E8814FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6268D287B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5438D3FB21;
	Fri, 15 Dec 2023 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RROwbnbo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D33010B;
	Fri, 15 Dec 2023 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1702667320;
	bh=UATp6Ljlid4diMibXymVZZ5Z3BZo2w0Vii6FCR1FX7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RROwbnbo2Bn6bTL6jOB+lfQg4ood193tPYpXkK7B+8tHpGSYiueXxV7u0hZu95quY
	 doJwFvj3s+NOV1T/5NbX5GWOkzp52/Cb5VUyBJx5Rh5V2fq7089hAfsmaPFunSmsMR
	 LiyKYjJNz07AN7JJwHkmuamNYOrdq1W38oDAfzHkXZ52qpKRSYhbjIoyaq8fMXQbdA
	 uDKq2VfXcOGxyjklyMJtesJwO6bT2He3bmzspfuY93vgsPdrymSBH8Fr0gbDqdqFFz
	 pDe1PO53JQYv4mnkWQxBEd0mqASUKKF0KQR+vCRv36Twfjo2tUt6itA8e80q4LO4jQ
	 DPUTAzZT47XxQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SsJfJ36PXzH29;
	Fri, 15 Dec 2023 14:08:40 -0500 (EST)
Message-ID: <368d36b2-e5ea-46d4-b214-6d04cf20685a@efficios.com>
Date: Fri, 15 Dec 2023 14:08:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <20231215102633.7a24cb77@rorschach.local.home>
 <21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
 <20231215120417.567d5ea4@rorschach.local.home>
 <fbf8991a-ce83-462c-b87a-b60c6635d223@efficios.com>
 <20231215123458.63f57238@rorschach.local.home>
 <f1a75239-341e-4611-a48d-88e10407dcd4@efficios.com>
 <20231215134335.2388aba5@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231215134335.2388aba5@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-15 13:43, Steven Rostedt wrote:
> On Fri, 15 Dec 2023 13:25:07 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>> I am not against exposing an ABI that allows userspace to alter the
>> filter behavior. I disagree on the way you plan to expose the ABI.
> 
> These are no different than the knobs for sched_debug

These are very much different. The sched features are enabled at
build-time by modifying kernel/sched/features.h. There is no userspace
ABI involved.

> 
>>
>> Exposing this option as an ABI in this way exposes too much internal
>> ring buffer implementation details to userspace.
> 
> There's already lots of exposure using options. The options are just
> knobs, nothing more.
> 
>>
>> It exposes the following details which IMHO should be hidden or
>> configurable in a way that allows moving to a whole new mechanism
>> which will have significantly different characteristics in the
>> future:
>>
>> It exposes that:
>>
>> - filtering uses a copy to a temporary buffer, and
>> - that this copy is enabled by default.
>>
>> Once exposed, those design constraints become immutable due to ABI.
> 
> No it is not. There is no such thing as "immutable ABI". The rule is
> "don't break user space" If this functionality in the kernel goes away,
> the knob could become a nop, and I doubt any user space will break
> because of it.
> 
> That is, the only burden is keeping this option exposed. But it could
> be just like that light switch that has nothing connected to it. It's
> still there, but does nothing if you switch it. This knob can act the
> same way. This does not in anyway prevent future innovation.

I am not comfortable with exposing internal ring buffer implementation
details to userspace which may or may not be deprecated as no-ops
in the future. This will lead to useless clutter.

One approach that might be somewhat better would be to only expose
those files when a new CONFIG_TRACING_DEBUG option is enabled. This
way userspace cannot rely on having those files present as part
of the ABI, but you would still be free to use them for selftests
by skipping the specific selftests if the config option is not
enabled.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


