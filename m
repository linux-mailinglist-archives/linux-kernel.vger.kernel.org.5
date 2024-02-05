Return-Path: <linux-kernel+bounces-52563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F43B8499BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DE01C22866
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86CC1C6AF;
	Mon,  5 Feb 2024 12:06:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA961C6A0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134789; cv=none; b=ZIaQtcCeWzxI7CkZjsMBKrNq4V3+MEIU0bD1h2qnQYNBG1LQ6DTq01BZM6YxSGojDcHMrsct5tGIvc7iRCtr68v2uNwZ0g3uCv5ypxU/262kYs0rv/AuFXBeraiHiKRvnj1olYTkS7uDF0uip2eAFuIeUGmg7By5eddY6CZIVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134789; c=relaxed/simple;
	bh=y72GAcg/Dxp4x6KLTNOLWNBnkWRVrYb4UCaUIsTqLog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLv2QSyZENVDNTtxmsuV9UZOKhh2NQyi9OaZe1rgWsQsHA0KCclmOLeJDgP+eIMQw5uNobF/04M9ctuO3hDZ4QfSHjVY3izQiOcza5cFCyKqv7o9L6883D5v/f+EuAOrvc6t/69R1RQeD+4pw0bsXkkq4r+/aBR6azo8YOvkhJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BACC71FB;
	Mon,  5 Feb 2024 04:07:07 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DD343F762;
	Mon,  5 Feb 2024 04:06:23 -0800 (PST)
Date: Mon, 5 Feb 2024 12:06:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: catalin.marinas@arm.com, will@kernel.org, mcgrof@kernel.org,
	jpoimboe@kernel.org, j.granados@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH] arm64: remove unneeded BUILD_BUG_ON assertion
Message-ID: <ZcDPOgoQE8IncTHY@FVFF77S0Q05N>
References: <20240202040211.3118918-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202040211.3118918-1-dawei.li@shingroup.cn>

On Fri, Feb 02, 2024 at 12:02:11PM +0800, Dawei Li wrote:
> Since commit c02433dd6de3 ("arm64: split thread_info from task stack"),
> CONFIG_THREAD_INFO_IN_TASK is enabled unconditionally for arm64. So
> remove this always-true assertion from arch_dup_task_struct.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  arch/arm64/kernel/process.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 7387b68c745b..4ae31b7af6c3 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -290,9 +290,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  		fpsimd_preserve_current_state();
>  	*dst = *src;
>  
> -	/* We rely on the above assignment to initialize dst's thread_flags: */
> -	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
> -

Does the above cause any problem today, or is this patch just a cleanup?

For the benefit of other reviewers, the assertion and comment were added in
commit:

  4585fc59c0e8 ("arm64/sve: Fix wrong free for task->thread.sve_state")

.. back in 2019, 3 years after commit:

  c02433dd6de3 ("arm64: split thread_info from task stack")

The comment and assertion were a safety-net for backports, since commit
4585fc59c0e8 was a fix which dependend upon the thread_info being contained
within task_struct, and couldn't be backported to kernels without
CONFIG_THREAD_INFO_IN_TASK.

I'm sure that we currently have plenty of other code with a similar (but
undocumented) dependency. Given we've unconditionally selected
CONFIG_THREAD_INFO_IN_TASK since v4.10, and the oldest longterm stable kernel
is v4.19 (with v4.14 having EOL'd last month), I think it makes sense to delete
the assertion and comment.

So FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

