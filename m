Return-Path: <linux-kernel+bounces-44436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F44842206
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E121F24E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985767E71;
	Tue, 30 Jan 2024 10:54:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEA67E61
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612053; cv=none; b=R7ErCzcguUMMZOqa7EgbkM+dld4N0auclcfY8MkvqCo0SmrQ3pkexVFI5sMU7oxshJdMT7Z9RaA+2dsTyNUnfzZgSQBiZ0Wc/aieMdFMaUzMfRyCQueqbehhh7N3VWpxwKeFoB6ZYao7ijsSoM0G5XjhK8NkmzgSiWJendFYtag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612053; c=relaxed/simple;
	bh=Uf5lm/bBKl/t66RkGmw4DAaNnqHacgZqug2RRU8WVg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvmlHakLH0c+MTChlW/SUqGdGBfPmEQl6ELdQgbnnMLW+HkFsJgqG7AxY/L/X9nHk2VyYUoDU2J26Z7gDGbZrmKVmb1wMVvTYiY2/g7nV9nGDmV7dyEuHRr2S6q9KfhXE1+sJMFZUC28CNogFYwr8O/10IxDbDGHuuY4KrhCVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DCC4DA7;
	Tue, 30 Jan 2024 02:54:53 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E77D3F5A1;
	Tue, 30 Jan 2024 02:54:08 -0800 (PST)
Date: Tue, 30 Jan 2024 10:54:06 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend
Message-ID: <ZbjVTigk0YlGd3mA@e133380.arm.com>
References: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
 <20240130-arm64-sme-resume-v1-2-0e60ebba18df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-arm64-sme-resume-v1-2-0e60ebba18df@kernel.org>

On Tue, Jan 30, 2024 at 12:02:49AM +0000, Mark Brown wrote:
> The fields in SMCR_EL1 reset to an architecturally UNKNOWN value. Since we
> do not otherwise manage the traps configured in this register at runtime we
> need to reconfigure them after a suspend in case nothing else was kind
> enough to preserve them for us. Do so for SMCR_EL1.EZT0.
> 
> Fixes: d4913eee152d (arm64/sme: Add basic enumeration for SME2)
> Reported-by: Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 69201208bb13..329782fe39c5 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1320,6 +1320,8 @@ void sme_suspend_exit(void)
>  
>  	if (system_supports_fa64())
>  		smcr |= SMCR_ELx_FA64;

Ditto comments on patch 1.

Unrelated to this patch, it is worth having a prctl for this?  The
architecture seems to discourage software written for the SME ISA to
implicitly rely on FA64, so it would useful to be able to run with it
disabled even on hardware that supports it.

> +	if (system_supports_sme2())
> +		smcr |= SMCR_ELx_EZT0;

Side question: since ZT0 is likely to be sporadically used, maybe it
is worth having separate lazy restore for it versus the main SME state?
(Not relevant for this series though, and probably best deferred until
there is hardware to benchmark on.  Also, ZT0 is small compared with
the SME state proper...)

[...]

Cheers
---Dave

