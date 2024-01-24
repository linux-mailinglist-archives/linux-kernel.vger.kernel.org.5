Return-Path: <linux-kernel+bounces-37727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC183B47E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F43283672
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9723813541F;
	Wed, 24 Jan 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBD5fHhj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEA131E26
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134252; cv=none; b=ij2ARQnyjSWgAJ84fBPHhL1rgDS2PUxBM0o5yNuhOeB3qdvwFL1oDb9dwkFj3EGj5ZLHHgstxi1gw7fUfcCsFCzplK+9lu7Mrs2iitfvOPr1OhJFn/H1prIMuQLDng2IZgQaRyGCRJFd3LgX3Pb3ktGKPWNV2NrTQOjMJGUH2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134252; c=relaxed/simple;
	bh=qf1Bz4aoFrb6jzFeqw/Ih99tCsZ4qQQIkj71i8O1boA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tuUkrCX6WVRdAbicBqGhvAKQEhFOZ6doJa5KPVOuPHpIh1J81Y89jAHfpLEQ5MHAlOpZgwV32mO8eMYzRYBpGwoWjfC5V4ITU58Fv/zyUMm6+8fbA7lbBdcBEqz/NC78tFTFGBH3gQ64X/7S7jfcuAum6ltbEcA9JztCLD+OXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBD5fHhj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d72043fa06so9475ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706134250; x=1706739050; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Of8y99/fZ6gvxjBPOuJPhzGycvWjT9wPG4BDRVEpUOo=;
        b=rBD5fHhjCxDKMm1IaVbSPPi8b3xnXl8BSRNCu+TprOKToqAUmKufXEvLNS9q7qENqR
         wXGtkcnZxxMRpvEMKir2Otkiwf2BdupGY8hhWlnOuc+TcxoZJEB3JG3uMMAksJVTPmIs
         BSj0EYBeVrJfvHpcvdV10AXpjVTDygo0fHXHtQAwdb5ztRdSiLVxbJV0RWXos6k4yIAQ
         4g73FdPoB8mKd+fp4IBSNq0jaXyRrwwSu/B8xPYEmqv3vwFSTIZxXl6WyPDNm4w5sTzz
         VxhgZVi4NI7mEQVaqQIE3nCWaLGHsb+X6FKdaNlsODfN5RgU7EUju72gpltOmB7stbSB
         t+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706134250; x=1706739050;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of8y99/fZ6gvxjBPOuJPhzGycvWjT9wPG4BDRVEpUOo=;
        b=oSo4zG0ed5dAte76SZw0I6ZkUZISsG3dijnCJkHtQVcJy454yjff34xCReSnjcj2J6
         dRr51doQcZyTEEUADGJKCFGl/uBNzAOl+/ictTlLm6sbippkrorXPG1B1/2pHw0Uifk6
         FCeymgLvLipOuSehQqnOYbO9zZSrZwCC8nKJtPaLBvm5GdBHJMDzn6edNfDlL80M+sME
         G+M/T9+s5sWp5kppvZrxkUBpKZ2N8UbZnVkph1bMSuSRmFTs6bAgUJq4QG1XIH2/LrXz
         sFV0xmqCoyIFlYAgpDAnTHXFa/eMIxQRPKwml3IpcfnUcfRV8KwZGNKp2onlJUOIQfQM
         DrIA==
X-Gm-Message-State: AOJu0YxMWT+/GYqNchILd3bRthq2yPwPMAhISU9upt8YCMYIzM/x5I6r
	tog6RWjBtB/xDnujvHJkWBfE7ft5D9ezI8Eb6/E/PR1MNV8xYquQdGeOY0ziwtNRG1giBi2q44k
	Qyg==
X-Google-Smtp-Source: AGHT+IF8MuebQLnkd4Io7E+CqCjdzUlAXM1QZ/u2YFj/nQlkbAX6M2kaOV1kNZApOwXd36+cpgNL2w==
X-Received: by 2002:a17:903:32cf:b0:1d5:a556:7662 with SMTP id i15-20020a17090332cf00b001d5a5567662mr25291plr.9.1706134249956;
        Wed, 24 Jan 2024 14:10:49 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2a3:200:8bb1:6f4c:997b:e7c3])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170903288b00b001d72846e441sm8183171plb.72.2024.01.24.14.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:10:49 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Will Deacon <will@kernel.org>,  Waiman Long <longman@redhat.com>,  Boqun
 Feng <boqun.feng@gmail.com>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in
 percpu_up_write
In-Reply-To: <20240123150541.1508-1-hdanton@sina.com> (Hillf Danton's message
	of "Tue, 23 Jan 2024 23:05:41 +0800")
References: <xm26zfwx7z5p.fsf@google.com>
	<20240123150541.1508-1-hdanton@sina.com>
Date: Wed, 24 Jan 2024 14:10:43 -0800
Message-ID: <xm26v87imlgc.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hillf Danton <hdanton@sina.com> writes:

> On Mon, 22 Jan 2024 14:59:14 -0800 Benjamin Segall <bsegall@google.com>
>> The waitq wakeup in percpu_up_write necessarily runs the wake function
>> immediately in the current thread. With it calling
>> __percpu_rwsem_trylock on behalf of the thread being woken, the lock is
>> extremely fair and FIFO, with the window for unfairness merely being the
>> time between the release of sem->block and the completion of a relevant
>> trylock.
>> 
>> However, the woken threads that now hold the lock may not be chosen to
>> run for a long time, and it would be useful to have more of this window
>> available for a currently running thread to unfairly take the lock
>> immediately and use it.
>
> It makes no sense for lock acquirer to probe owner's activity except for
> spining on owner. Nor for owner to guess if any acquirer comes soon.

The code is not doing that; this text is just describing why we might
choose a less fair heuristic for which thread gets the lock.

>
>> This can result in priority-inversion issues
>> with high contention or things like CFS_BANDWIDTH quotas.
>
> Given mutex could not avoid PI (priority-inversion) and deadlock, why is
> percpu-rwsem special wrt PI?

I was going to say that mutex/rwsem have SPIN_ON_OWNER that dodge this
somewhat (and percpu-rwsem cannot do that). Switching
cgroup_threadgroup_rwsem to an actual rwsem and even disabling read-side
RWSEM_FLAG_HANDOFF doesn't actually help noticeably for my artificial
benchmark though, so the test may not be as representative as I hoped.

The most obvious possibility is that with the real problem
solving/not-causing the internal contention issues was sufficient, and
that also attacking it from the percpu-rwsem angle was overkill. It
wasn't sufficient for the artificial test, but cranking up the load to
get a reliable test could easily have blown past the point where the
other fix was sufficient.

>> 
>> Signed-off-by: Ben Segall <bsegall@google.com>
>> 
>> ---
>> 
>> So the actual problem we saw was that one job had severe slowdowns
>> during startup with certain other jobs on the machine, and the slowdowns
>> turned out to be some cgroup moves it did during startup. The antagonist
>> jobs were spawning huge numbers of threads and some other internal bugs
>> were exacerbating their contention. The lock handoff meant that a batch
>> of antagonist threads would receive the read lock of
>> cgroup_threadgroup_rwsem and at least some of those threads would take a
>> long time to be scheduled.
>
> If you want to avoid starved lock waiter, take a look at RWSEM_FLAG_HANDOFF
> in rwsem_down_read_slowpath().

rwsem's HANDOFF flag is the exact opposite of what this patch is doing.
Percpu-rwsem's current code has perfect handoff for read->write, and a very
short window for write->read (or write->write) to be beaten by a new writer.

