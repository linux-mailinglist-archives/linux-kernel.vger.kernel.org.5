Return-Path: <linux-kernel+bounces-127886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60357895241
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923FB1C21EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05761757FC;
	Tue,  2 Apr 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiQw91jq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B46A8A8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059128; cv=none; b=ErGN9U8/0l5LazrDwWHUkNIuCgeMKDMEPvWDqUK7m8JI9hPGgilvb9O38qSUBXwL/1lErUtZPL+L+2W5ZBse9Si4V7zlMi6oiWMBGmkUGYPqMO+mn77/KfuD/0c7yFSTRieGlcEL0/qBmwaXREh1ipY59riHHNKb9tBVSW80Lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059128; c=relaxed/simple;
	bh=Hw2vaUWp3gpk6uvfspN8upqqDYFfDn7KHW0rB6j9DgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLtRTnvqI+J3p83sMjAx3cwaKec+Z1KBq4Kjb32WIkyx6H7AtJG5qXDJhn5FF4h73VUOxnipjQ6WbP+s6TyfvdMKMJZbfPQTC72/4ftuP41BThdBo0CVq5PUcuDjML1/R6yaK7++UlpGBgjQx3JazXns9XgzNyalvLNo2VFyoME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiQw91jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8532EC433F1;
	Tue,  2 Apr 2024 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712059127;
	bh=Hw2vaUWp3gpk6uvfspN8upqqDYFfDn7KHW0rB6j9DgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LiQw91jqMXzj+GnAus9ZnNmyXuwlBxk79xApuMWpOro87vP8LfnM8Z3F8HZblWQP1
	 LXco6b2zuavEqtVQyHH5dwiuLIAMHzaYV+qDceHd+uzStg+zRXSln1l1bDW00owuGh
	 3h5QRf4bF+Or77b7X8UhC5rdcNYw9+rA7M96Ckn0DuUuLwS8XgaNetyb9NDFqq5ws8
	 6UtbFp6xTNEFLzTCtgkThDbayqqVXzQM3WO90fO0jx6bnqGP/GMZEtWwtzIUSq5xSh
	 b7Fp51XBVPAm7YX7OJM3Qnv9vpE5vDNCDNh3+rmJ3DTpqp6DDxlyoLtIHIgjEWcb4X
	 NOMBOfvJwxQ5Q==
Date: Tue, 2 Apr 2024 12:58:41 +0100
From: Will Deacon <will@kernel.org>
To: Seongsu Park <sgsu.park@samsung.com>
Cc: catalin.marinas@arm.com, ardb@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Leem ChaeHoon <infinite.run@gmail.com>,
	Gyeonggeon Choi <gychoi@student.42seoul.kr>,
	Soomin Cho <to.soomin@gmail.com>, DaeRo Lee <skseofh@gmail.com>,
	kmasta <kmasta.study@gmail.com>
Subject: Re: [PATCH] arm64: Fix double TCR_T0SZ_OFFSET shift
Message-ID: <20240402115841.GA16533@willie-the-truck>
References: <CGME20240402104955epcas1p3dd15334a1305b99f3e1b82000e3c7c42@epcas1p3.samsung.com>
 <20240402104950.170632-1-sgsu.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402104950.170632-1-sgsu.park@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Apr 02, 2024 at 07:49:50PM +0900, Seongsu Park wrote:
> We have already shifted the value of t0sz in TCR_T0SZ by TCR_T0SZ_OFFSET.
> So, the TCR_T0SZ_OFFSET shift here should be removed.
> 
> Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
> Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
> Co-developed-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
> Signed-off-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
> Co-developed-by: Soomin Cho <to.soomin@gmail.com>
> Signed-off-by: Soomin Cho <to.soomin@gmail.com>
> Co-developed-by: DaeRo Lee <skseofh@gmail.com>
> Signed-off-by: DaeRo Lee <skseofh@gmail.com>
> Co-developed-by: kmasta <kmasta.study@gmail.com>
> Signed-off-by: kmasta <kmasta.study@gmail.com>
> Signed-off-by: Seongsu Park <sgsu.park@samsung.com>

heh, that's quite a lot of people. Did you remove three chars each? :p

> ---
>  arch/arm64/include/asm/mmu_context.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index c768d16b81a4..58de99836d2e 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -76,7 +76,7 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
>  		return;
>  
>  	tcr &= ~TCR_T0SZ_MASK;
> -	tcr |= t0sz << TCR_T0SZ_OFFSET;
> +	tcr |= t0sz;

Thankfully, TCR_T0SZ_OFFSET is 0 so this isn't as alarming as it looks.
Even so, if we're going to make the code consistent, then shouldn't the
earlier conditional be updated too?

	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
		return;

seems to assume that t0sz is unshifted.

Will

