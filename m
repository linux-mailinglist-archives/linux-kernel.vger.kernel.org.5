Return-Path: <linux-kernel+bounces-35499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4179839207
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC4F28C073
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75825FBA0;
	Tue, 23 Jan 2024 15:06:09 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8625D8F5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022369; cv=none; b=oND/tFhfJuz81WuP83nnsZo8BFJxXMvAcjVTw22ceZKm2njPnmUbJv7PuEY5J04+NYEK8RLG1jGi4Ld8CbqvYqh8h8BygP6CYjcEZyGZA2PvLFdGEPq3oMbgBKLoHGoXCjXBcSRDvVwvS0rIBlYIyhXwXWEdb/KAIHMX04EEYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022369; c=relaxed/simple;
	bh=zZMgQjgS5FlQlJ0DhHdvJ6OUiCqzY39GDEOwUWyjTmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+B1fvLPpLWMAdXFA4WYBll8VB4HQq9hkgp1jUU+6NT5KbW9aYqov41cd8Xh14hsi0Ke61Zq7b+PHnorIyHj8Cf2CKZ7SdyvKiDfsJkWq73u8IjWfarruRhfEeKpTmpjxpYrIi7ygc2qXsN/6Q0GyoPM8c4fZSfs50LxgjxwBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.147])
	by sina.com (10.75.12.45) with ESMTP
	id 65AFD5CD00009F76; Tue, 23 Jan 2024 23:05:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 55216031457639
X-SMAIL-UIID: CCEF3CD1EF3C458E93D6B80898736B14-20240123-230555-1
From: Hillf Danton <hdanton@sina.com>
To: Benjamin Segall <bsegall@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in percpu_up_write
Date: Tue, 23 Jan 2024 23:05:41 +0800
Message-Id: <20240123150541.1508-1-hdanton@sina.com>
In-Reply-To: <xm26zfwx7z5p.fsf@google.com>
References: <xm26zfwx7z5p.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 14:59:14 -0800 Benjamin Segall <bsegall@google.com>
> The waitq wakeup in percpu_up_write necessarily runs the wake function
> immediately in the current thread. With it calling
> __percpu_rwsem_trylock on behalf of the thread being woken, the lock is
> extremely fair and FIFO, with the window for unfairness merely being the
> time between the release of sem->block and the completion of a relevant
> trylock.
> 
> However, the woken threads that now hold the lock may not be chosen to
> run for a long time, and it would be useful to have more of this window
> available for a currently running thread to unfairly take the lock
> immediately and use it.

It makes no sense for lock acquirer to probe owner's activity except for
spining on owner. Nor for owner to guess if any acquirer comes soon.

> This can result in priority-inversion issues
> with high contention or things like CFS_BANDWIDTH quotas.

Given mutex could not avoid PI (priority-inversion) and deadlock, why is
percpu-rwsem special wrt PI?
> 
> The even older version of percpu_rwsem that used an rwsem at its core
> provided some related gains in a different fashion through
> RWSEM_SPIN_ON_OWNER; while it had a similarly small window, waiting
> writers could spin, making it far more likely that a thread would hit
> this window.
> 
> Signed-off-by: Ben Segall <bsegall@google.com>
> 
> ---
> 
> So the actual problem we saw was that one job had severe slowdowns
> during startup with certain other jobs on the machine, and the slowdowns
> turned out to be some cgroup moves it did during startup. The antagonist
> jobs were spawning huge numbers of threads and some other internal bugs
> were exacerbating their contention. The lock handoff meant that a batch
> of antagonist threads would receive the read lock of
> cgroup_threadgroup_rwsem and at least some of those threads would take a
> long time to be scheduled.

If you want to avoid starved lock waiter, take a look at RWSEM_FLAG_HANDOFF
in rwsem_down_read_slowpath().

