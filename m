Return-Path: <linux-kernel+bounces-107759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2CC880152
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD42831A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE98120F;
	Tue, 19 Mar 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V4z4A1ps"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3A657C3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864176; cv=none; b=grPLThTefzPxul0oO8+8qk274Je9TgVtuWYepNYPFUzhC+z7WswKYJwjjVZZ7Emy34c6s5+Uq7R62ocS5bZye0SwDhMCvaAGAAFFcblRk0tzI673lgzyN/jqIO+sMUGzX5AeEzhcr8zbtuX7NUi98wxqV0+4siN8Ppmsff0W8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864176; c=relaxed/simple;
	bh=3wz7G/XPmigoSxPpd91I2lSobVkAfUFWQh/kqASF6WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZIKUO2YQN/gT4M00fBCD0pEO1L6smJh1g9THI9UQxQdgBnGj4y/eUg/YK7xmfho5gCtPzDqg+c3Chao2Frjlg3lpLuBQ5zF4+XI9jV/6R0y6ld4cijrf7xUnI+LLQr8Fv3IsvnMcA2CTV1baRfJB752R6/jUt0D4OJfBiwlYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=V4z4A1ps; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-789f5ce0b5bso188109985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710864174; x=1711468974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3OnI3jLsPxTJrKU35wlWfGM59JPlAYNQ2mQI/FUsNhQ=;
        b=V4z4A1psSULeKxSnhZLfkdUbsjDWLv/+qOCPOuOTFOMdzCNv04tcspaCK1DJ1lLxZq
         q4hn4WBZubkxnv+1cPDUEFMk3HID0DU4ypCPDcfybg8L0AJ7weouWAxwZocUpQEDbzlg
         uVCKljdrkPrJUxdDO8umQIzhZWAkIJ55MlBlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864174; x=1711468974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OnI3jLsPxTJrKU35wlWfGM59JPlAYNQ2mQI/FUsNhQ=;
        b=TKDhbSNXZFvV37mWqR0MYo/vqTXG4HZaUPzvbZBg9UR/7zTw4rnt9KfvrOD7HcHOUn
         INoDoT8PssZpm9mtcJvHOl28VpPObU2UM6/avH+r6qle4y78Fx0xMCsR+YYKqpNMev/r
         mGG6I/RjoqPp00PBIIA3kFvWMXmaGfyQwBlBfY4N7bOZUEVCu2wBAioB42SVa4Tvls9A
         pI/pH1FKjZzxDAoYlMQwQcOuxGTdnZbku7HLgEiGb2U+0TW+YkKB27YDkrr1b4UVHXtl
         +j6T/UvwBZLj7H9ZBB8Ntcs9X51BZaTQFDolsWu3HHJeLvJvbNlT0M+thv47rGcy3Xrg
         aTjw==
X-Gm-Message-State: AOJu0Yyd3yh9iX0dXzPbva/aXM5lpXdJeRFkW+ogkJgstIXaYr8XcbAi
	EXSPlvcOsFtwxnpuilbyBO+YcI5kucZjeAysnKuso7FzHZYQNAGEDXEIMaqpwPU=
X-Google-Smtp-Source: AGHT+IHtNsX4RVHw9Ny9NCOjjzynoHpsZRpEk4OPFmV/077W2HaH4ln5BTRixUSsBFCJ/biMNoXGVQ==
X-Received: by 2002:a05:620a:cd4:b0:789:d9cd:47ac with SMTP id b20-20020a05620a0cd400b00789d9cd47acmr14598268qkj.32.1710864173767;
        Tue, 19 Mar 2024 09:02:53 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a16a300b00789ee7c9d2fsm3171951qkj.109.2024.03.19.09.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:02:53 -0700 (PDT)
Date: Tue, 19 Mar 2024 12:02:52 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for
 synchronize_rcu() common case
Message-ID: <20240319160252.GA186534@joelbox2>
References: <ZflgfrjZSZdqrLLw@pc636>
 <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
 <ZfmlziaLw1bl4IjX@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfmlziaLw1bl4IjX@pc636>

On Tue, Mar 19, 2024 at 03:48:46PM +0100, Uladzislau Rezki wrote:
> On Tue, Mar 19, 2024 at 10:29:59AM -0400, Joel Fernandes wrote:
> > 
> > 
> > > On Mar 19, 2024, at 5:53 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > 
> > > ﻿On Mon, Mar 18, 2024 at 05:05:31PM -0400, Joel Fernandes wrote:
> > >> 
> > >> 
> > >>>> On Mar 18, 2024, at 2:58 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > >>> 
> > >>> ﻿Hello, Joel!
> > >>> 
> > >>> Sorry for late checking, see below few comments:
> > >>> 
> > >>>> In the synchronize_rcu() common case, we will have less than
> > >>>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > >>>> is pointless just to free the last injected wait head since at that point,
> > >>>> all the users have already been awakened.
> > >>>> 
> > >>>> Introduce a new counter to track this and prevent the wakeup in the
> > >>>> common case.
> > >>>> 
> > >>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >>>> ---
> > >>>> Rebased on paul/dev of today.
> > >>>> 
> > >>>> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
> > >>>> kernel/rcu/tree.h |  1 +
> > >>>> 2 files changed, 32 insertions(+), 5 deletions(-)
> > >>>> 
> > >>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > >>>> index 9fbb5ab57c84..bd29fe3c76bf 100644
> > >>>> --- a/kernel/rcu/tree.c
> > >>>> +++ b/kernel/rcu/tree.c
> > >>>> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> > >>>>   .ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> > >>>>   .srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> > >>>>       rcu_sr_normal_gp_cleanup_work),
> > >>>> +    .srs_cleanups_pending = ATOMIC_INIT(0),
> > >>>> };
> > >>>> 
> > >>>> /* Dump rcu_node combining tree at boot to verify correct setup. */
> > >>>> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > >>>>    * the done tail list manipulations are protected here.
> > >>>>    */
> > >>>>   done = smp_load_acquire(&rcu_state.srs_done_tail);
> > >>>> -    if (!done)
> > >>>> +    if (!done) {
> > >>>> +        /* See comments below. */
> > >>>> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> > >>>>       return;
> > >>>> +    }
> > >>>> 
> > >>>>   WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > >>>>   head = done->next;
> > >>>> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > >>>> 
> > >>>>       rcu_sr_put_wait_head(rcu);
> > >>>>   }
> > >>>> +
> > >>>> +    /* Order list manipulations with atomic access. */
> > >>>> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> > >>>> }
> > >>>> 
> > >>>> /*
> > >>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > >>>> */
> > >>>> static void rcu_sr_normal_gp_cleanup(void)
> > >>>> {
> > >>>> -    struct llist_node *wait_tail, *next, *rcu;
> > >>>> +    struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
> > >>>>   int done = 0;
> > >>>> 
> > >>>>   wait_tail = rcu_state.srs_wait_tail;
> > >>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
> > >>>>           break;
> > >>>>   }
> > >>>> 
> > >>>> -    // concurrent sr_normal_gp_cleanup work might observe this update.
> > >>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > >>>> +    /*
> > >>>> +     * Fast path, no more users to process. Remove the last wait head
> > >>>> +     * if no inflight-workers. If there are in-flight workers, let them
> > >>>> +     * remove the last wait head.
> > >>>> +     */
> > >>>> +    WARN_ON_ONCE(!rcu);
> > >>>> 
> > >>> This assumption is not correct. An "rcu" can be NULL in fact.
> > >> 
> > >> Hmm I could never trigger that. Are you saying that is true after Neeraj recent patch or something else?
> > >> Note, after Neeraj patch to handle the lack of heads availability, it could be true so I requested
> > >> him to rebase his patch on top of this one.
> > >> 
> > >> However I will revisit my patch and look for if it could occur but please let me know if you knew of a sequence of events to make it NULL.
> > >>> 
> > > I think we should agree on your patch first otherwise it becomes a bit
> > > messy or go with a Neeraj as first step and then work on youth. So, i
> > > reviewed this patch based on latest Paul's dev branch. I see that Neeraj
> > > needs further work.
> > 
> > You are right. So the only change is to drop the warning and those braces. Agreed?
> >
> Let me check a bit. Looks like correct but just in case.
> 

Thanks. I was also considering improving it for the rcu == NULL case, as
below. I will test it more before re-sending.

On top of my patch:

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0df659a878ee..a5ef844835d4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1706,15 +1706,18 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
+
+	/* Last head stays. No more processing to do. */
+	if (!rcu)
+		return;
+
 	/*
 	 * Fast path, no more users to process. Remove the last wait head
 	 * if no inflight-workers. If there are in-flight workers, let them
 	 * remove the last wait head.
 	 */
-	WARN_ON_ONCE(!rcu);
-	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
-	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
+	if (rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
 		/* Order atomic access with list manipulation. */
 		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
 		wait_tail->next = NULL;
@@ -1724,6 +1727,7 @@ static void rcu_sr_normal_gp_cleanup(void)
 	}
 
 	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 
 	/*

