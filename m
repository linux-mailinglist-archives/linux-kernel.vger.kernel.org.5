Return-Path: <linux-kernel+bounces-48392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4BF845B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A522954EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336AD15D5BA;
	Thu,  1 Feb 2024 15:22:22 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7A15DBBD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800941; cv=none; b=CH3eekubq2LABqlAyUcP9KREMwrvLR774y1csgNu0hzghGgwYnA6NbGW+F/Ulm660clDcq1PXdcX+oZAUBkkChK0zrQ4+WzdzotcpJNxPtXPBxJVeQ6fv4Xa+D35gnhR9Bu8jL4NYPMQyp8GD9kUoyBsk4YK5X0G7gg7Nj3B4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800941; c=relaxed/simple;
	bh=/fNW+EnrstF3l6Tjhf3Juk+33vhljOeeF3e/iB7fpLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6sauhZCMESpUnWxNWrBQycdjLhpRh1tJ9pgWeeqMa/UCAkTKUkWOp5iPAg7YJoggNbk27I5gzdGYLxax3rXWiWWBiEcXEOO8n/GZvybsdtPmi81cqZHFBYdwVOh3/Hely30l7ix9FHIPKrwb5FOX4ajbkfp65RwkRGA2JebFXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0410E41ED5;
	Thu,  1 Feb 2024 16:22:13 +0100 (CET)
Message-ID: <34292692-67e9-4132-be1c-eba79dd3a84f@proxmox.com>
Date: Thu, 1 Feb 2024 16:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: Drop spinlocks on contention iff kernel is
 preemptible
To: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
 Valentin Schneider <valentin.schneider@arm.com>,
 Marco Elver <elver@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 David Matlack <dmatlack@google.com>
References: <20240110214723.695930-1-seanjc@google.com>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <20240110214723.695930-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 22:47, Sean Christopherson wrote:
> Use preempt_model_preemptible() to detect a preemptible kernel when
> deciding whether or not to reschedule in order to drop a contended
> spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
> built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
> preemption model is "none" or "voluntary".  In short, make kernels with
> dynamically selected models behave the same as kernels with statically
> selected models.
> 
> Somewhat counter-intuitively, NOT yielding a lock can provide better
> latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
> rwlock, is often contended between an invalidation event (takes mmu_lock
> for write) and a vCPU servicing a guest page fault (takes mmu_lock for
> read).  For _some_ setups, letting the invalidation task complete even
> if there is mmu_lock contention provides lower latency for *all* tasks,
> i.e. the invalidation completes sooner *and* the vCPU services the guest
> page fault sooner.

I've been testing this patch for some time now:

Applied on top of Linux 6.7 (0dd3ee31) on a PREEMPT_DYNAMIC kernel with
preempt=voluntary, it fixes an issue for me where KVM guests would
temporarily freeze if NUMA balancing and KSM are active on a NUMA host.
See [1] for more details.

In addition, I've been running with this patch on my (non-NUMA)
workstation with (admittedly fairly light) VM workloads for two weeks
now and so far didn't notice any negative effects (this is on top of a
modified 6.5.11 kernel though).

Side note: I noticed the patch doesn't apply anymore on 6.8-rc2, seems
like sched.h was refactored in the meantime.

[1]
https://lore.kernel.org/kvm/ef81ff36-64bb-4cfe-ae9b-e3acf47bff24@proxmox.com/


