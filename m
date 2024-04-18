Return-Path: <linux-kernel+bounces-150418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DF8A9EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF6B2829FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CE16F284;
	Thu, 18 Apr 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFKzHdH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7B16C434;
	Thu, 18 Apr 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455217; cv=none; b=c05KP7fv9k7kns9zlePbUCKnmw4da2cZAjFFoNBkQpvic2JJPb1FJzXW48HPJh7BXjfveHETqEiKgbkfNAtjsdD1mMVNi4WRk4sOteBj7XkIu5I0aL9BTiHeNMXWbyCwD2MhN75gORSsC0vGARJHqOZwXxqhHIrCpSFDiq0woB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455217; c=relaxed/simple;
	bh=CSADx2CB69mfT8jOoCkrOeYysFybh9E9rmHaG61n528=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl8cF2dqe22SkJlno8aFU4TFmDmhYsAmETPJjRv6h8F2N95YiCWefbBMeQsi2SqH+iD0FECmIYOtq48bGLoPg/rkXWrf9rwHbwW1uob9pfOwUsLnGx3y4GCe5OD63isAfl5OMBRo2atjZUnAke56bZtMXyIcjiHtBX2OZdvbvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFKzHdH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42706C32782;
	Thu, 18 Apr 2024 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713455217;
	bh=CSADx2CB69mfT8jOoCkrOeYysFybh9E9rmHaG61n528=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFKzHdH8ja1Efdd5hQT3JgGoW263bR7EeNpDUDXUL4XVWanxMqJFbAsotyQVmMfl/
	 ePCIcAsmDs8qRilsFGd3NH7z4uA263dKdJa1HXenInrxspe2ju92SHDkXDwGUiuPp7
	 mvyw0N/G6GNCzhKvmDSAiIK8UtpzE3b//hVFixWbPZCaG0gO447yNkPo8L6QzmYyLo
	 wNUqTpIy9A68SZK0SFhPhbeFUeRZyLU1CCng/vvbuU+78cB2zD3gEonJSz1fyEDCMg
	 kr4QKlgpO+KuvLmggUB8IjAozvMJdEhktlyYkotv29xJdb/oFvcTldMS4aoIFazC+2
	 BVX6Un8RfU9TA==
Date: Thu, 18 Apr 2024 17:46:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Haifeng Xu <haifeng.xu@shopee.com>, mingo@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf/core: Fix missing wakeup when waiting for
 context reference
Message-ID: <ZiFAb8VwTD8TddkK@localhost.localdomain>
References: <20240418114209.22233-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418114209.22233-1-haifeng.xu@shopee.com>

Le Thu, Apr 18, 2024 at 11:42:09AM +0000, Haifeng Xu a écrit :
> In our production environment, we found many hung tasks which are
> blocked for more than 18 hours. Their call traces are like this:
> 
> [346278.191038] __schedule+0x2d8/0x890
> [346278.191046] schedule+0x4e/0xb0
> [346278.191049] perf_event_free_task+0x220/0x270
> [346278.191056] ? init_wait_var_entry+0x50/0x50
> [346278.191060] copy_process+0x663/0x18d0
> [346278.191068] kernel_clone+0x9d/0x3d0
> [346278.191072] __do_sys_clone+0x5d/0x80
> [346278.191076] __x64_sys_clone+0x25/0x30
> [346278.191079] do_syscall_64+0x5c/0xc0
> [346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
> [346278.191086] ? do_syscall_64+0x69/0xc0
> [346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
> [346278.191092] ? irqentry_exit+0x19/0x30
> [346278.191095] ? exc_page_fault+0x89/0x160
> [346278.191097] ? asm_exc_page_fault+0x8/0x30
> [346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The task was waiting for the refcount become to 1, but from the vmcore,
> we found the refcount has already been 1. It seems that the task didn't
> get woken up by perf_event_release_kernel() and got stuck forever. The
> below scenario may cause the problem.
> 
> Thread A					Thread B
> ...						...
> perf_event_free_task				perf_event_release_kernel
> 						   ...
> 						   acquire event->child_mutex
> 						   ...
> 						   get_ctx
>    ...						   release event->child_mutex
>    acquire ctx->mutex
>    ...
>    perf_free_event (acquire/release event->child_mutex)
>    ...
>    release ctx->mutex
>    wait_var_event
> 						   acquire ctx->mutex
> 						   acquire event->child_mutex
> 						   # move existing events to free_list
> 						   release event->child_mutex
> 						   release ctx->mutex
> 						   put_ctx
> ...						...
> 
> In this case, all events of the ctx have been freed, so we couldn't
> find the ctx in free_list and Thread A will miss the wakeup. It's thus
> necessary to add a wakeup after dropping the reference.
> 
> Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

