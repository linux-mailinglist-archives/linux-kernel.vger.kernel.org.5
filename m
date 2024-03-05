Return-Path: <linux-kernel+bounces-92747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A179872571
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC221F2427E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA9C14286;
	Tue,  5 Mar 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcE6HeqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D4DDDA;
	Tue,  5 Mar 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658810; cv=none; b=dW3dYy3WltnmmHfv1MyM0ZspBwGPO8OEW7cIca74MjX0OnXaNn1rRyEv4qozMYGcSae6dISd3TJfADAWnu6aewnpiVDhcPvxEKJuaLNy9b+6GEe93ErFqgodfyOlW+vheJTxLSk41AlK6dxzHyx/9i8ob1+Q/Dlvp/odB5MJd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658810; c=relaxed/simple;
	bh=mCb5rz9ozWoqeUEaaPJgZrZ0vT0gaWXiqiWNuvVUgO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di4EheIStr7il8qRRLNKArbElSr1G/BPW/R5BWn+WESafx0LNqYMn3KEqVu34ZvC20iAiBbTfUs6hz+DGByQWBWZ6FD69PQtGTWhff75n0APE8zg0477ivd050kLXjX/fGqCM2laS2fEIbXIw5V+V9Fx7vECHfJU1uiCVxS15bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcE6HeqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259A1C433F1;
	Tue,  5 Mar 2024 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709658810;
	bh=mCb5rz9ozWoqeUEaaPJgZrZ0vT0gaWXiqiWNuvVUgO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcE6HeqOOK1wT2/YX3qgFIm/ZjXrw7B3y/5/HLj9piykdyuccrb8QPZnN0Srxl7zP
	 TBiU0e0yqNKVyp0xsVvpi8QLbgi4YZSxj61EzkYlcLimZ9yFv8xHaq2ZxsgdRx0rWG
	 35/LdjmliS4lGdI8+08v1OxZibwZ86DrccQ9LabSXIsxTM97BJwU+VsWGO59Fl12G8
	 qhF+WwlTKKbdFBVVeE5hsSny529DaK6HuASA84yqFvhYXdwfKpXTwYZQmTFl1Cr9CY
	 5IhCrTggjAa7lsaRcsz/fY9/0u309LUaWo9L4QMthPO1JlgG5CDoyLPiEv2FRVx/uZ
	 CyQWo7/0eBmNA==
Date: Tue, 5 Mar 2024 17:13:24 +0000
From: Will Deacon <will@kernel.org>
To: "levi.yun" <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nd@arm.com, stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] arm64/mm: Add memory barrier for mm_cid
Message-ID: <20240305171324.GA22616@willie-the-truck>
References: <20240305145335.2696125-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305145335.2696125-1-yeoreum.yun@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 05, 2024 at 02:53:35PM +0000, levi.yun wrote:
> Currently arm64's switch_mm() doesn't always have an smp_mb()
> which the core scheduler code has depended upon since commit:
> 
>     commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
> 
> If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear()
> can unset the activly used cid when it fails to observe active task after it
> sets lazy_put.
> 
> By adding an smp_mb() in arm64's check_and_switch_context(),
> Guarantee to observe active task after sched_mm_cid_remote_clear()
> success to set lazy_put.
> 
> Signed-off-by: levi.yun <yeoreum.yun@arm.com>
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Cc: <stable@vger.kernel.org> # 6.4.x
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> ---
>  I'm really sorry if you got this multiple times.
>  I had some problems with the SMTP server...
> 
>  arch/arm64/mm/context.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index 188197590fc9..7a9e8e6647a0 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -268,6 +268,11 @@ void check_and_switch_context(struct mm_struct *mm)
>  	 */
>  	if (!system_uses_ttbr0_pan())
>  		cpu_switch_mm(mm->pgd, mm);
> +
> +	/*
> +	 * See the comments on switch_mm_cid describing user -> user transition.
> +	 */
> +	smp_mb();
>  }

We already have a stronger barrier than smp_mb() (dsb ish) in __switch_to().
Is that not sufficient?

Will

