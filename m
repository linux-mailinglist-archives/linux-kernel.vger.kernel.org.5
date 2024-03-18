Return-Path: <linux-kernel+bounces-106266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47787EBA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247E0282550
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71074F608;
	Mon, 18 Mar 2024 15:06:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971CF4F200
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774417; cv=none; b=UrKhFcsBnHmPphTAIUgBVY4rY4kKkV0a0wwQOQlahMYBTSgpBKo//MJ9Eimxx6crlDm0c19mr5k9JpJsDZh5LOz+BIshp219aE8clK0T2S5h68jsnRAYAbOq9nfr7BXXhu7mbabWvLoMNbZAMYVEBUs78JzNHC5tg8/+fQ+grNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774417; c=relaxed/simple;
	bh=8CiKkjy2UKGbaRU8y43ZLz/sRFNefmjZtk3HE1ejRpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyTTAVSSXeVHPH1KbrWkMf6LOKgwErAvis1nsTGM3CZ+RHf56XNdvz41tV5K9e+kWRphz958oYJJ8Jh7AQtuCfZq1jl+ZT7wgLjxhoAXsFrRvIpYu6zSqzQBrG43AnG5Z8hFRP4ekQ4sR2Su9e+aeaYcyJN/0ffBl+HiwGawIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3F25DA7;
	Mon, 18 Mar 2024 08:07:29 -0700 (PDT)
Received: from [10.57.95.135] (unknown [10.57.95.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0006F3F67D;
	Mon, 18 Mar 2024 08:06:49 -0700 (PDT)
Message-ID: <496a2f13-2d66-48f4-a710-afbd90f1bfd8@arm.com>
Date: Mon, 18 Mar 2024 15:06:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/7] sched: Split scheduler and execution contexts
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes
 <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com, Connor O'Brien <connoro@google.com>
References: <20240315044007.2778856-1-jstultz@google.com>
 <20240315044007.2778856-8-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240315044007.2778856-8-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/03/2024 4:39 am, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Let's define the scheduling context as all the scheduler state
> in task_struct for the task selected to run, and the execution
> context as all state required to actually run the task.
> 
> Currently both are intertwined in task_struct. We want to
> logically split these such that we can use the scheduling
> context of the task selected to be scheduled, but use the
> execution context of a different task to actually be run.
> 
> To this purpose, introduce rq_selected() macro to point to the
> task_struct selected from the runqueue by the scheduler, and
> will be used for scheduler state, and preserve rq->curr to
> indicate the execution context of the task that will actually be
> run.
> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Duplicate S-o-b for Peter.

[snip]


