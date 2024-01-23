Return-Path: <linux-kernel+bounces-34674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08CA8385F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4132D1F26340
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21811FB5;
	Tue, 23 Jan 2024 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s8tLkruD"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113121C17
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705979987; cv=none; b=uG9iEdjL9STJYonsNApg2YzATb8yB9tWoFlMAsbG5BiQLn3TpZNXSxKeed+ImdFDCxKz+CjXau1oYFCZ02Z4tKvwA9VyVN3XmRk3BA9U/n9Sn9ZvUY9GVLolpO7NZ4uczVqN0DgPRUtjx8ceQCGBVFgWcH+Usop/kkPWW2aa6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705979987; c=relaxed/simple;
	bh=vgGiIj9ykyyfl2ApNKtHMtH1nqhRah4USy7ABM67MwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7a0EYFN15fpxY9R7IYiyTk+0jvuIpcnLHl41E1da0VcwUYya4yAco9vI6IWbTk3DE4hD6Ei1EIMhrhJVWHURZFl0V04mbFhR0tms6nIU/mFDQZLVMNjkUbNzYhPwVKQ5nuHu1ZI6brXcX8Bqyky0K1OYD8q/iJqdW+mEa4b1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s8tLkruD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9c474667-e1b3-18fa-e7dd-a9c1228091df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705979983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gui+pdhQWkXP6dWC9v7eCS3u6Ys/Ix9iDrO2B7ADWgI=;
	b=s8tLkruDJXThxzi1z315IPSgnOfqYGRgpO6Zk+kHfqiscGtfTd0hbgidgBLJbTzMHybSZw
	gnBA+kvz93THR9XsX5UeUiqj8z68yrRfly2BPcg0wLpEN9/yn2giM12YKMhFKimsDzzNL0
	0fSx9bzcnPMohyTl+CUlZMGCGWTbGTE=
Date: Tue, 23 Jan 2024 11:19:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] sched: Return NULL when entity isn't a task
Content-Language: en-US
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
References: <20231206063400.3206346-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231206063400.3206346-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Kindly ping...

Thanks


On 2023/12/6 14:33, Yajun Deng wrote:
> If the entity isn't a task, return the task struct is meaningless.
> Return NULL when entity isn't a task that makes the code more concise.
>
> v1 -> v2:
> fix 'struct rt_rq' no member named 'highest_prio'.
>
> Yajun Deng (2):
>    sched/fair: Return NULL when entity isn't a task in task_of()
>    sched/rt: Return NULL when rt entity isn't a task in rt_task_of()
>
>   kernel/sched/fair.c  | 50 ++++++++++++++++++------------------
>   kernel/sched/rt.c    | 60 +++++++++++++-------------------------------
>   kernel/sched/sched.h |  4 ++-
>   3 files changed, 44 insertions(+), 70 deletions(-)
>

