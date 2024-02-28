Return-Path: <linux-kernel+bounces-85262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2642F86B326
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2987B228A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF115CD6A;
	Wed, 28 Feb 2024 15:29:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0815B969
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134183; cv=none; b=gqbZO4H2CjcEVYh9cvLzaYwP23hWj9QKV80g2cPRJBEXyHgVZSJHw5Bnt7ksXIQsuBvMgbsWFyXc9ajiTS7w7vBFIcb/6p44tvQCAzxaiQxn8zZHR7kETHRX/9kQHV2gepkIUw9PX2H1Jlve7CRbg1/vC0TN4jdgXDUXmmQxogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134183; c=relaxed/simple;
	bh=DmM1/6SNlE0aFqtiXoU7/D622ujQIQV6YU/laUWpeqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHpP3EbTYU2wP8psq0/mma2j1dGnBc/hFYr+xLuXiNqI2M1gqrakva3BtBunGFeIg70cBlZdFQYZX4ED2y0qs83uxyMzw3RjjZytCgX3nY0SEnTZbUtcTVv+LnpAm5cutfUgNk06hQurPlI7F9mFLZpU9zN4DVrIwm4a59Tg248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064EEC433C7;
	Wed, 28 Feb 2024 15:29:41 +0000 (UTC)
Date: Wed, 28 Feb 2024 15:29:39 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/hw_breakpoint: Define an ISS code for watchpoint
 exception
Message-ID: <Zd9RY68L8cJRRSzE@arm.com>
References: <20240223094615.3977323-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223094615.3977323-1-anshuman.khandual@arm.com>

On Fri, Feb 23, 2024 at 03:16:15PM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 353fe08546cf..6c0a0b77fd2c 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -143,6 +143,10 @@
>  #define ESR_ELx_CM_SHIFT	(8)
>  #define ESR_ELx_CM 		(UL(1) << ESR_ELx_CM_SHIFT)
>  
> +/* ISS field definitions for Watchpoint exception */
> +#define ESR_ELx_WnR_SHIFT	(6)
> +#define ESR_ELx_WnR		(UL(1) << ESR_ELx_WnR_SHIFT)

We had ESR_ELx_WNR since about 2015, maybe even earlier in the form of
EL1 or EL2. Only that the 'n' is uppercase. So please use that, don't
add a new definition.

-- 
Catalin

