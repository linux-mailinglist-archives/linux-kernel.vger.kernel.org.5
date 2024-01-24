Return-Path: <linux-kernel+bounces-36610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D713B83A3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA91B28E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1601754D;
	Wed, 24 Jan 2024 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="biSQO9qu"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E9171B8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083703; cv=none; b=c5x26XGcwL1Erx6tNZBVVmXq61aKazEFY2NGX5HMus1aqt+HtFFS7WoqShKnpUfWhdBKD4n6c5CG45TpvJp6wYh0yLZPSaIpVqBRyAD6MuKg7/m1i6gpmA8IRrbyZHTq4IRzFTDQsdFF56WYFWP/cCRtXbcg8eGefpwTJHrawn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083703; c=relaxed/simple;
	bh=WuTsA4t0XYhq2dKRx42Ldt/2+0SYfNeIClfxM3tW+0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGwBsV4T/4kYZbpUoV3EbOUtkYbPE6mjg4r6LGXAqV3uzugv7TZvCC42sHJqHr7corg2RNUeeg40dfxb5+PJSjJNRvAn4oIbQS9GdgdJCKJ1qA/UDfTlRzDSvIX16b4QJhlUTrNdllYMqrSpS7vtYXEwQ5H8Teb2UU/O7n9Rupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=biSQO9qu; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f40f9aa9-e722-0264-2d4d-bc9062472f12@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706083696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7MnCXuD88u4ilrUq6w2umVtP5EOnFHzJ9de6V4YW6Y=;
	b=biSQO9quUA/W3uKimuqqoTTQdqD7VSMuYwRKATFiSecYDpujfoY8ORUJlpFmEBCeAV65Gb
	+YxKHFHs+5YQZUgxn7uDYSDL7qjiAX7igl/AH+qXmvk2z9u0oQqzDYlvNcroz6bGhKpPPP
	r5pWJ30N5Gz6ZBWuSBszBraU1MJIciw=
Date: Wed, 24 Jan 2024 16:08:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] sched/fair: Return NULL when entity isn't a task
 in task_of()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
References: <20231206063400.3206346-1-yajun.deng@linux.dev>
 <20231206063400.3206346-2-yajun.deng@linux.dev>
 <20240122224852.6ab9b498@gandalf.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20240122224852.6ab9b498@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/23 11:48, Steven Rostedt wrote:
> On Wed,  6 Dec 2023 14:33:59 +0800
> Yajun Deng <yajun.deng@linux.dev> wrote:
>
>> Before calling task_of(), we need to make sure that the entity is a task.
>> There is also a warning in task_of() if the entity isn't a task. That
>> means we need to check the entity twice. If the entity isn't a task,
> Does it really check it twice? Have you disassembled it to see if the code
> is any better?
>
> #define entity_is_task(se)	(!se->my_q)
> static inline struct task_struct *task_of(struct sched_entity *se)
> {
> 	SCHED_WARN_ON(!entity_is_task(se));
> 	return container_of(se, struct task_struct, se);
> }
>
> The above is a macro and a static inline, which means that the compiler
> should optimized out that second check.


Yes, the second check should be optimized.

>
>> return the task struct is meaningless.
>>
>> Return NULL when entity isn't a task in task_of(), and call task_of()
>> instead of entity_is_task() when we need a task_struct.
> I'm not against the change, as it could be considered a clean up. But it is
> up to the sched maintainers to decide if it's worth the churn.


Return NULL in task_of() makes the code cleaner.

>
> -- Steve
>
>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

