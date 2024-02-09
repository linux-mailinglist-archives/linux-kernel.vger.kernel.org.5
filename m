Return-Path: <linux-kernel+bounces-59313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08084F53D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71CC1F249F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1F336B1C;
	Fri,  9 Feb 2024 12:35:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3B2E64F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482142; cv=none; b=JVeiZay/Fe8Tf2lz7DU3OFWw4qyRx6ImijL5YmTVELrYIoWFQCKFetBcU2uZwXOSyaWOFxKTM5IpBuhvySw+RFrTBV/bWk1fPFmvtEYuIoQjtfA8qIECUt38+OxtTzSaJhaTJZgxDKca/W4rZq5mWi1NE5/0p5yN4Dq58kNdAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482142; c=relaxed/simple;
	bh=hGkM3G5UeVZcuUc4avua0lxN7fCk4ZwrzRH5E6PJnIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkFHvj4ufGYiZC8JiMebbiF1Debrz3kAWi8OBxyhxzVhDa7WVNR8ga64LJOJq7iJK8VL3GPJSZv6UUst//w200+6/8LTv5k7oi50wJCYYx+1UmR+GsGdpOu2g+Ej6lb6aNq9CnAwWD4GuqrhFOMcayx83YeiyUY8xsDsvtwg5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9D7ADA7;
	Fri,  9 Feb 2024 04:36:20 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67F463F5A1;
	Fri,  9 Feb 2024 04:35:37 -0800 (PST)
Date: Fri, 9 Feb 2024 12:35:09 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, frederic@kernel.org,
	joel@joelfernandes.org, neeraj.iitr10@gmail.com, paulmck@kernel.org,
	peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH] locking/atomic: scripts: clarify ordering of conditional
 atomics
Message-ID: <ZcYb_U45Jro_MMeJ@FVFF77S0Q05N.cambridge.arm.com>
References: <20240129122250.1086874-1-mark.rutland@arm.com>
 <20240206184005.4125128-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206184005.4125128-1-nphamcs@gmail.com>

On Tue, Feb 06, 2024 at 10:40:05AM -0800, Nhat Pham wrote:
> Let me bring in some beginners' perspective :)
> 
> For the most part, LGTM! My only comment is regarding the conditional
> atomics with relaxed ordering on success:
> 
> /**
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> + * Otherwise, @v is not modified and no ordering is provided.
> 
> This is technically correct, but it can be confusing. It reads as if
> "relaxed ordering" is much different from no ordering, since we are
> juxtaposing them when we compare what happens when the condition holds
> v.s when it does not.
> 
> This can be potentially confusing to unfamiliar users. I consulted
> with Paul about this, and he suggested this rewording, which I like
> better:
> 
> "Otherwise, @v is not modified and relaxed ordering is provided."

I agree that makes sense, and doing the same in the commit message makes that
simpler and clearer too!

> With something along that line in place:
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks; I'll fold the above in for v2.

Mark.

