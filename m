Return-Path: <linux-kernel+bounces-71797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1894385AA97
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34A7283627
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD74481AE;
	Mon, 19 Feb 2024 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nQ8mYB5r"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D347F5D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366200; cv=none; b=pHFRr0bqJOR8TxDUWETI2XRm24n8Yii3B9ixb0uHId6nMrLAQGgelSakBLsxmmssPRt9JLWEIs3v6FQhok7qxybDFxjUiaeFppQNqi5CSSjfHtq1OiikqYDg69NZd945wvKHVKhIkBLkACSrucGNu65vf+kRDhS8KwHW8eltFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366200; c=relaxed/simple;
	bh=RfBCXLwyCUeqZQEFpji75aPuuqXowh06NHelS8dUuSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY6MllDQpdEkE6k9vypwsaOklp4szWnRjWrsR8lyNa3xQ84zH9tXVblQ/N78lICqkmiGQKtXL0dhE2tDKA/aprcAzaKLqzfhBSWvZG69SDGjLw4Va2dwHeqL2sHo1i0pK29lgADTWK46zOyak6f2pXFBxJzoCFT4jic0BE+pNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nQ8mYB5r; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708365676;
	bh=RfBCXLwyCUeqZQEFpji75aPuuqXowh06NHelS8dUuSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nQ8mYB5rDyHcJmVZ2AurI90Bg6HQ+uf8P+ck8e1SDJoxe53nNWLTxDwDG4c7NRKNm
	 548aH/nzgVX4jc7NOUXKC1w64SCbKxfvZb03abl3IAU/1oTs9ukktX2l0g68+5pLMM
	 G9h0UNGNMUapjggYBysuJvzwVW+wDM3QHDYi8PDRP6DvCaxhiaqfO3gBsQnyMhKqIR
	 DtF6FiWubxDBrhYvk+O+3iaqX1UmXDY7dteeGdenzFERonD1osDlqr8NdymuPndcvf
	 F2GMzzHjTShTfQz4pjM52OgOHg1JCCF7lAzrnYMhajHlYMxBR7JCPz+XyQjKXg84cp
	 FgRe3CF5ExTLQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tdr2444BqzZyH;
	Mon, 19 Feb 2024 13:01:16 -0500 (EST)
Message-ID: <776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
Date: Mon, 19 Feb 2024 13:01:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>
Cc: wenyang.linux@foxmail.com, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
 <20240219170038.GA710@redhat.com>
 <20240219122825.31579a1e@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240219122825.31579a1e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-19 12:28, Steven Rostedt wrote:
> On Mon, 19 Feb 2024 18:00:38 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
>>> void __noreturn do_exit(long code)
>>> {
>>> 	struct task_struct *tsk = current;
>>> 	int group_dead;
>>>
>>> [...]
>>> 	acct_collect(code, group_dead);
>>> 	if (group_dead)
>>> 		tty_audit_exit();
>>> 	audit_free(tsk);
>>>
>>> 	tsk->exit_code = code;
>>> 	taskstats_exit(tsk, group_dead);
>>>
>>> 	exit_mm();
>>>
>>> 	if (group_dead)
>>> 		acct_process();
>>> 	trace_sched_process_exit(tsk);
>>>
>>> There's a lot that happens before we trigger the above event.
>>
>> and a lot after.
> 
> True. There really isn't a meaningful location here is there?
> 
> I actually use this tracepoint in my pid tracing.
> 
> The set_ftrace_pid and set_event_pid from /sys/kernel/tracing will add and
> remove PIDs if the options function-fork or event-fork are set respectively.
> 
> I hook to the sched_process_fork tracepoint to add new PIDs if the parent
> pid is already in one of the files, and remove a PID via the
> sched_process_exit function.

No ? Those hook on sched_process_free, which is the actual point where the
task is freed (AFAIR after it's been a zombie and then waited for by another
task).

kernel/trace/trace_events.c:

void trace_event_follow_fork(struct trace_array *tr, bool enable)
{
         if (enable) {
                 register_trace_prio_sched_process_fork(event_filter_pid_sched_process_fork,
                                                        tr, INT_MIN);
                 register_trace_prio_sched_process_free(event_filter_pid_sched_process_exit,
                                                        tr, INT_MAX);
         } else {
                 unregister_trace_sched_process_fork(event_filter_pid_sched_process_fork,
                                                     tr);
                 unregister_trace_sched_process_free(event_filter_pid_sched_process_exit,
                                                     tr);
         }
}

kernel/trace/ftrace.c:

void ftrace_pid_follow_fork(struct trace_array *tr, bool enable)
{
         if (enable) {
                 register_trace_sched_process_fork(ftrace_pid_follow_sched_process_fork,
                                                   tr);
                 register_trace_sched_process_free(ftrace_pid_follow_sched_process_exit,
                                                   tr);
         } else {
                 unregister_trace_sched_process_fork(ftrace_pid_follow_sched_process_fork,
                                                     tr);
                 unregister_trace_sched_process_free(ftrace_pid_follow_sched_process_exit,
                                                     tr);
         }
}

AFAIU, "sched_process_exit" is issued close to the point where the task exits
(it should not go back to userspace after that). "sched_process_free" is done
when the task is really being removed.

Between "sched_process_exit" and "sched_process_free", the task can still be
observed by a trace analysis looking at sched and signal events: it's a zombie at
that stage.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


