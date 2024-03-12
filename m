Return-Path: <linux-kernel+bounces-100130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E2E879243
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9582F284328
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB2155E73;
	Tue, 12 Mar 2024 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUlhxw9J"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618941A85
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239805; cv=none; b=qthDoWlomLjnwPMrBJatffxdoJp31N5F2mDbjMMoEjjsZZtqdvL7D288ujDiWMZX8DK9y5/+mhgGVXqY67kJRKAsh5kDYAxgenAZWzDz648hK2ZS17cL5FNO2mYL9jkMcbFd7ma7kIWsk/03K/h19Iahfr/W9rzJFW5RwBkQfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239805; c=relaxed/simple;
	bh=ldLHT+7KKkEw/cUtr5TG6uf+iSlib8xpwUzZJgbEDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEl8zQg3zDno7Y1rPvQYYeb1FatBC2AMiB0o1l6ijrtfBYMRAQOmy13pg10RxDdHl4GS2dh9LK/Bf4q91rkwkySko86of0PW4lDi3oevN/zCkg1YvXX1HW6kLrkxWusDKNR4yMI5e2/AlXu+YgQYrtHkvsGK71O+MExwMYO/8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUlhxw9J; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4645485da6so59012266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710239802; x=1710844602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hm+6X/5k3i+VUHvnlRxvFcXi+76msRha0JCkHThjDAY=;
        b=QUlhxw9Jj5iy/Lkt+2/GnlYxo5RHR/rsCrmhKKFyE3mIxHDIlXdH1+Gfp5n7w8AbXg
         92QxRrq7qG2LwITxV0sOEP+9oqmWviESg9szDFXBuustZAW7rXufq41yYEBiEIOm+vTR
         Nq8+0mibeLLl8JbmjhlLgr9Hn4wNiP6tNk1oJ6GtW3J7RsfJdYGIiQxmXkpTc5p6NoQh
         ijibJXuYJUEJ4xcBwbPeJ0j7MjRFF8egz0aMojxq5SyCKWRCGHs49T+OVGe7DpxzISQf
         oM2AEofek+x8GIct/ndpmReIFMKmZJE49VFdj6CCyYjBP6iyJ2BNxgYf4qDYP8zLv5i0
         FTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710239802; x=1710844602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm+6X/5k3i+VUHvnlRxvFcXi+76msRha0JCkHThjDAY=;
        b=b6IuyorLCYQoJ+4oPswtLpylFWtXDdQHHIfMHDY+qZeXVKG1lZSJWm3zfmofIKxEpz
         oISrETuM3NdcBrHLD7VdohtNdUPSMVdwl3G2vDXlCnMy7LZVL4yUZlJnnZZyeXinyeS0
         3Q7x/c88eYR8ra1u0FZyZOONRYJ/F9HTNAJp8N0/DaOACgX3EBqxrLR2LHywoBEN1rcm
         Bo2eVY3qJGyekaO7wLfAtqSpnp/HDFZJ+MMWhI6cpqT8uSNiaN7Z8PvlOQ2iUrky5M10
         0vv5cM1MRLehq8p/h7V1mDMDl5eWYAA61os4qdd4SFMsVRaWxwmy7EYh/fJpvbeH3C4O
         EObw==
X-Gm-Message-State: AOJu0YwcfnjFQiAk/LwgzHQK7vB4H2Wsbm4K6MEIrJFBrk4H338B7nSv
	1M0z49xBWV1+CoI1uXvAtdOrBQKvMSUhbgSsxxOKbd9Cp2qhpb1H7ZSyxEO71ik=
X-Google-Smtp-Source: AGHT+IEZFdaFVTUdN9dVn/mTu5L7cnCYmWrxvWMEB+5DuRWu3+WE39Tm+gKlfe+4ypUAp1s4WojDGQ==
X-Received: by 2002:a17:907:9406:b0:a46:264e:6fba with SMTP id dk6-20020a170907940600b00a46264e6fbamr4675566ejc.34.1710239801376;
        Tue, 12 Mar 2024 03:36:41 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id c23-20020a1709060fd700b00a44180ab871sm3722079ejk.50.2024.03.12.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:36:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 12 Mar 2024 11:36:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 09/13] sched/balancing: Rename update_blocked_averages()
 => sched_balance_update_blocked_averages()
Message-ID: <ZfAwNufbiyt/5biu@gmail.com>
References: <20240308111819.1101550-1-mingo@kernel.org>
 <20240308111819.1101550-10-mingo@kernel.org>
 <f5687abb-cab7-497d-a997-572358d3807b@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5687abb-cab7-497d-a997-572358d3807b@126.com>


* Honglei Wang <jameshongleiwang@126.com> wrote:

> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -209,7 +209,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
> >   	 * This means that weight will be 0 but not running for a sched_entity
> >   	 * but also for a cfs_rq if the latter becomes idle. As an example,
> >   	 * this happens during idle_balance() which calls
> 
> Could we also fix this ghost idle_balance() in this serial (maybe in patch
> 10)?

Good point - I've added the patch below.

Thanks,

	Ingo

===================>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 12 Mar 2024 11:33:50 +0100
Subject: [PATCH] sched/balancing: Fix a couple of outdated function names in comments

The 'idle_balance()' function hasn't existed for years, and there's no
load_balance_newidle() either - both are sched_balance_newidle() today.

Reported-by: Honglei Wang <jameshongleiwang@126.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 kernel/sched/pelt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54177ff96e4b..c35452109c76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6866,7 +6866,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
-/* Working cpumask for: sched_balance_rq, load_balance_newidle. */
+/* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
 static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index f80955ecdce6..3a96da25b67c 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -208,7 +208,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * se has been already dequeued but cfs_rq->curr still points to it.
 	 * This means that weight will be 0 but not running for a sched_entity
 	 * but also for a cfs_rq if the latter becomes idle. As an example,
-	 * this happens during idle_balance() which calls
+	 * this happens during sched_balance_newidle() which calls
 	 * sched_balance_update_blocked_averages().
 	 *
 	 * Also see the comment in accumulate_sum().


