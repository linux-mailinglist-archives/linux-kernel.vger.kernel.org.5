Return-Path: <linux-kernel+bounces-29421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA84830E01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7AF1F246E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FCF250F0;
	Wed, 17 Jan 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0hO8Q94B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAC25545;
	Wed, 17 Jan 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523500; cv=none; b=FpzkRDe6NwgmRdm8M8Gfz35LqNp9+WhVv8lA+Mb9HfurGYpKWMDvaY9LKYJvtcFXppaYtp8nJQcisH6iWHd8sWRZ9BU9NH+1yT1UObA1oVHYUbJbIAzHZUilUsXbUxRcMHjSQ1UIdJ4AMRdeOYEA9KZHO2ek43rGwxDQp9dxOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523500; c=relaxed/simple;
	bh=J0SBN0Y/pLqk/sWpUBOHmnTzq9HxFnlLlaoNkWWBkIs=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding; b=PWBnnoQhsn0l2R4iuZnraCibkr83Zq0Dt/zIjw2L2idT1RaF224mk2rgqPUYMUMU9iVEMPCvOkMVrSN9uZsUNH2FWE+DnKnb8KoUNX0KDhhaaKUS4dlk9qnEgbub9hxzrPd2ioKV8rqKtca37YfLF8ivOKF0AqDk4spQ5WKeihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0hO8Q94B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F480C433C7;
	Wed, 17 Jan 2024 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705523499;
	bh=J0SBN0Y/pLqk/sWpUBOHmnTzq9HxFnlLlaoNkWWBkIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0hO8Q94BlwPqxzmpVv9+KPO0TIz9O67uJl9NFfFvyGCrWYal+RncSmNx/cwhDQdFu
	 nmqbjPDAN7ObyrMQyfIlgKAebjCsDy6kYi4byy5Pro7QjDSnjxXS0OD1HbBPNsoOXi
	 HQUrGrkpv0LLvKmZlPHERPWSb/1rvM201uAbwLjk=
Date: Wed, 17 Jan 2024 12:31:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chen Zhongjin <chenzhongjin@huawei.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <yangjihong1@huawei.com>, <naveen.n.rao@linux.ibm.com>,
 <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
 <paulmck@kernel.org>, <mhiramat@kernel.org>, <tglx@linutronix.de>,
 <peterz@infradead.org>, <pmladek@suse.com>, <dianders@chromium.org>,
 <npiggin@gmail.com>, <mpe@ellerman.id.au>, <jkl820.git@gmail.com>,
 <juerg.haefliger@canonical.com>, <rick.p.edgecombe@intel.com>,
 <eric.devolder@oracle.com>, <mic@digikod.net>
Subject: Re: [PATCH] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
Message-Id: <20240117123133.2e40438936167e6a4aec8b16@linux-foundation.org>
In-Reply-To: <20240117061636.288412-1-chenzhongjin@huawei.com>
References: <20240117061636.288412-1-chenzhongjin@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 06:16:36 +0000 Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> There is a deadlock scenario in kprobe_optimizer():
> 
> pid A				pid B			pid C
> kprobe_optimizer()		do_exit()		perf_kprobe_init()
> mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
> synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
> // waiting tasks_rcu_exit_srcu	kernel_wait4()
> 				// waiting pid C exit
> 
> To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
> rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
> that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.
> 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Thanks.  Should we backport this fix into earlier kernels?  If so, are
we able to identify a suitable Fixes: target?

