Return-Path: <linux-kernel+bounces-78330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8B8611F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DEB283779
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795407CF08;
	Fri, 23 Feb 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHs2BTlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41328C0A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692749; cv=none; b=HdVD7ipFvhpaSJEULc4NAONS+inYqhIOUqBOM5M+dywyMNzk27xcSLry1QjiZVPrRspax7+J1DaeOfrV6aS8GFS+gEAj7AbwqAtBrWQ0tNKJuIBo7uwh0AK1vn9tZ85c6C9RJfxeDQK8eTrCd0pBcLyt/Qzybsp6xFvAuZXTyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692749; c=relaxed/simple;
	bh=IyCj5keIAQfJYXAfP7hpyBP6OruhWQ1GZ9RjUxfZQm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG4Cgx6Kqcu+aepX8ZnQSOw+axPoAL5or+D0y6YJPtz7mP9HLYDhM7uX9uN53ObMaTWUbjBlbF/OdZHc3dbymfrMo0FyscsNPwObifyMP2HnDbcuLvyjebZmWJsl2OYdJFe60tQw3d0LwDS8jJgRGHxsrcS7PvnuvpnML0DrXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHs2BTlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20503C433F1;
	Fri, 23 Feb 2024 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708692749;
	bh=IyCj5keIAQfJYXAfP7hpyBP6OruhWQ1GZ9RjUxfZQm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHs2BTlAsibvTiPS5uMtGnbO95Z5CrS7S3+VfQE1MQ8ydoVDU/7TBA3sUrx8unWeS
	 NlX6nPjBNeKzA3euVww5/83iSoXhurkXXlwPTVfMi8k+aHHcy/IxMkapQy924+3C4V
	 l6tww2r6xsNFuJgm0/YJuYrO0A3LKH4hmiX6Jx56QpRoei7ASSTgjWPNRBRLsdivXv
	 tO67neua4MvUrYTfJf2s3LCxJrvd8n9trzJ/GaCmK/nDPP+mpOSsJUajcf+uffxZt0
	 67YTFv9gvchP8jjUL+bp/QVlL8LBFFv/K0TzzsNo4hwAhPlH9qmcZ/ky2EMWm31rxe
	 Ao7vrxxRrX4/w==
Date: Fri, 23 Feb 2024 12:52:24 +0000
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/hw_breakpoint: Determine lengths from generic perf
 breakpoint macros
Message-ID: <20240223125224.GC10641@willie-the-truck>
References: <20240223113102.4027779-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223113102.4027779-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 23, 2024 at 05:01:02PM +0530, Anshuman Khandual wrote:
> Both platform i.e ARM_BREAKPOINT_LEN_X and generic i.e HW_BREAKPOINT_LEN_X
> macros are used interchangeably to convert event->attr.bp_len and platform
> breakpoint control arch_hw_breakpoint_ctrl->len. Let's be consistent while
> deriving one from the other. This does not cause any functional changes.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.8-rc5
> 
>  arch/arm64/kernel/hw_breakpoint.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 35225632d70a..1ab9fc865ddd 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -301,28 +301,28 @@ static int get_hbp_len(u8 hbp_len)
>  
>  	switch (hbp_len) {
>  	case ARM_BREAKPOINT_LEN_1:
> -		len_in_bytes = 1;
> +		len_in_bytes = HW_BREAKPOINT_LEN_1;

I don't think we should do this. The HW_BREAKPOINT_LEN_* definitions are
part of the user ABI and, although they correspond to the length in bytes,
that's not necessarily something we should rely on.

Will

