Return-Path: <linux-kernel+bounces-34691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7C838627
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B5F1C22AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57E53AE;
	Tue, 23 Jan 2024 03:47:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB7539C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705981644; cv=none; b=Nycr1aX+7ssu04ojPdXVMkU4hkMjj63BSNLND86GpT2/5s3p0iI3E909sicWUcaq4iZ494Ks+uokqzrh2aYsu+kLx5QwPBvjIO+nLPmuNh/UBcHWm+UIjRRiNaUQMtGARG+r+M9iB5Sm/w4GvZ359biXbL/ojSoVzG5xtparsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705981644; c=relaxed/simple;
	bh=Exm/fe0PGjVUjlzUbZS1DGXpWwSqBew2c8rReHa+hQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtzdK3gR6cf0K2CjjGt8z8uy9Qvke4pSvgj+qShPEMEvdy1RNty11fmUuQiL5Xvi1RbQ30gM1FMJODd7pND6rdvgYTAL4GKSTQCZniC2uBaHUD/z3dUOqvflV6vshn2f+Rc2V8ANSuxeqwHRvvAkwbvsVdgy+7MNnfZjU93gvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65A2C433F1;
	Tue, 23 Jan 2024 03:47:22 +0000 (UTC)
Date: Mon, 22 Jan 2024 22:48:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/fair: Return NULL when entity isn't a task
 in task_of()
Message-ID: <20240122224852.6ab9b498@gandalf.local.home>
In-Reply-To: <20231206063400.3206346-2-yajun.deng@linux.dev>
References: <20231206063400.3206346-1-yajun.deng@linux.dev>
	<20231206063400.3206346-2-yajun.deng@linux.dev>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 14:33:59 +0800
Yajun Deng <yajun.deng@linux.dev> wrote:

> Before calling task_of(), we need to make sure that the entity is a task.
> There is also a warning in task_of() if the entity isn't a task. That
> means we need to check the entity twice. If the entity isn't a task,

Does it really check it twice? Have you disassembled it to see if the code
is any better?

#define entity_is_task(se)	(!se->my_q)
static inline struct task_struct *task_of(struct sched_entity *se)
{
	SCHED_WARN_ON(!entity_is_task(se));
	return container_of(se, struct task_struct, se);
}

The above is a macro and a static inline, which means that the compiler
should optimized out that second check.


> return the task struct is meaningless.
> 
> Return NULL when entity isn't a task in task_of(), and call task_of()
> instead of entity_is_task() when we need a task_struct.

I'm not against the change, as it could be considered a clean up. But it is
up to the sched maintainers to decide if it's worth the churn.

-- Steve


> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

