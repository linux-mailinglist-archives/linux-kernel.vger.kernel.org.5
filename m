Return-Path: <linux-kernel+bounces-121815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8771388EE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7A1C2DAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851514EC73;
	Wed, 27 Mar 2024 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RkxWd7fx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6C130A63;
	Wed, 27 Mar 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563463; cv=none; b=KNSdfrj3qdm3WB4VO4w7otPFDA6KbIkv2YwYM98Vc3zXBBS/nf33YzENmouuAA4bvH8GPmRaYoe6cKGXBQhX2Es9CkE4qZXtl5yldu4Iq3Z7Mwldd43EOrwW/KSFpKsRjlfDHQ/ukPFuOsx/ujv6wPqkHdx4+wf6P+hYlDIy9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563463; c=relaxed/simple;
	bh=cuOPfgYarGsg6xpTgF2yo+uJ/Cd9/PbvYrZtfzWIAWA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pz5VT01FaeJh7nPWl99os+j8lz9tJh7uTJr1Fa5+RpgcjCm6qf6NK3DO0jnu5Usnh35hV7vthK/MKOXCYwsOsysHKAkJDkd7MneDS3WzGCna9L4CV+bZZz3OFCVXxOXVy2OYX05yqENksSFJLASWGku/olzB9Aj6s2XC1/Vx24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RkxWd7fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680A4C43390;
	Wed, 27 Mar 2024 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711563462;
	bh=cuOPfgYarGsg6xpTgF2yo+uJ/Cd9/PbvYrZtfzWIAWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RkxWd7fxszjbkBAhnxMMmGIe1h9FKHAVl8O+/y4E+OyVKiv7IRTOoVWnBexJe9Qi9
	 +TAsEnYgru/VQSeepmbuUfEprBv2RQg5xWifJm48Tf7YU36SeMA36iZubYcx/pS1In
	 9D8kpe1b6ypL+O0tgl7HcF34HzDsZeDajYeDtxlE=
Date: Wed, 27 Mar 2024 11:17:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: gregkh@linuxfoundation.org, patches@amperecomputing.com,
 rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, yury.norov@gmail.com, kuba@kernel.org,
 vschneid@redhat.com, mingo@kernel.org, vbabka@suse.cz, rppt@kernel.org,
 tglx@linutronix.de, jpoimboe@kernel.org, ndesaulniers@google.com,
 mikelley@microsoft.com, mhiramat@kernel.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
 cl@os.amperecomputing.com
Subject: Re: [PATCH v3] NUMA: Early use of cpu_to_node() returns 0 instead
 of the correct node id
Message-Id: <20240327111740.f8d3802b0eae15bcb8727e04@linux-foundation.org>
In-Reply-To: <20240126064451.5465-1-shijie@os.amperecomputing.com>
References: <20240126064451.5465-1-shijie@os.amperecomputing.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 14:44:51 +0800 Huang Shijie <shijie@os.amperecomputing.com> wrote:

> During the kernel booting, the generic cpu_to_node() is called too early in
> arm64, powerpc and riscv when CONFIG_NUMA is enabled.
> 
> There are at least four places in the common code where
> the generic cpu_to_node() is called before it is initialized:
> 	   1.) early_trace_init()         in kernel/trace/trace.c
> 	   2.) sched_init()               in kernel/sched/core.c
> 	   3.) init_sched_fair_class()    in kernel/sched/fair.c
> 	   4.) workqueue_init_early()     in kernel/workqueue.c
> 
> In order to fix the bug, the patch introduces early_numa_node_init()
> which is called after smp_prepare_boot_cpu() in start_kernel.
> early_numa_node_init will initialize the "numa_node" as soon as
> the early_cpu_to_node() is ready, before the cpu_to_node() is called
> at the first time.

What are the userspace-visible runtime effects of this bug?



