Return-Path: <linux-kernel+bounces-38680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A083183C404
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574061F2618D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A9B5A11A;
	Thu, 25 Jan 2024 13:47:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5B59B54;
	Thu, 25 Jan 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190460; cv=none; b=SpMeTdR12N1ZL7WmvV4mCVuJLdmMa2SbTmAx2EFqm4d7CrEPq3IOELXti0zuL2gMj8tyBU5JLsViOrPGrd5cEqpjyBYpaJyUMN0r3d8V4Fq5nMvnkQ8JfN8cpI+0tCT5iRPUFJaGdxiNQ9tUk/NYDLuhFNXn00yiSWPfYZIBzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190460; c=relaxed/simple;
	bh=XCIyf98Egstd1uRAnQpa6ZfcwI7PuSvSMODoF7lNvy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spFHIhtZGxw1YAUaWr8J/D8DeoapZK+7nqL4PO7L3275+DDWWRVhZQP+Fn34nBVZEIJfaapKAoMsQA8a92o79GMDTSwq8CQB4I+JJ7uRRiCjVMPyrYlo4CXSAn4nw/QdBnOW/dXg2yhwNJAMzPW6Oz+d4Cbo0x7OOf0liyeVVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF45FEC;
	Thu, 25 Jan 2024 05:48:22 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7695E3F5A1;
	Thu, 25 Jan 2024 05:47:36 -0800 (PST)
Date: Thu, 25 Jan 2024 13:47:30 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH v2 3/4] arm64/fp: Clarify effect of setting an
 unsupported system VL
Message-ID: <ZbJmcj0A32+aJIMx@e133380.arm.com>
References: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
 <20240124-arm64-sve-sme-doc-v2-3-fe3964fb3c19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-arm64-sve-sme-doc-v2-3-fe3964fb3c19@kernel.org>

On Wed, Jan 24, 2024 at 06:12:37PM +0000, Mark Brown wrote:
> The documentation for system vector length configuration does not cover all
> cases where unsupported values are written, tighten it up.
> 
> Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arch/arm64/sme.rst | 5 ++---
>  Documentation/arch/arm64/sve.rst | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
> index 3133d0e91b48..f4376c06f447 100644
> --- a/Documentation/arch/arm64/sme.rst
> +++ b/Documentation/arch/arm64/sme.rst
> @@ -379,9 +379,8 @@ The regset data starts with struct user_za_header, containing:
>  /proc/sys/abi/sme_default_vector_length
>  
>      Writing the text representation of an integer to this file sets the system
> -    default vector length to the specified value, unless the value is greater
> -    than the maximum vector length supported by the system in which case the
> -    default vector length is set to that maximum.
> +    default vector length to the specified value rounded to a supported value
> +    using the same rules as for setting vector length via PR_SME_SET_VL.
>  
>      The result can be determined by reopening the file and reading its
>      contents.
> diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
> index b45a2da19bf1..8d8837fc39ec 100644
> --- a/Documentation/arch/arm64/sve.rst
> +++ b/Documentation/arch/arm64/sve.rst
> @@ -423,9 +423,8 @@ The regset data starts with struct user_sve_header, containing:
>  /proc/sys/abi/sve_default_vector_length
>  
>      Writing the text representation of an integer to this file sets the system
> -    default vector length to the specified value, unless the value is greater
> -    than the maximum vector length supported by the system in which case the
> -    default vector length is set to that maximum.
> +    default vector length to the specified value rounded to a supported value
> +    using the same rules as for setting vector length via PR_SVE_SET_VL.
>  
>      The result can be determined by reopening the file and reading its
>      contents.

Since you picked up my suggestion, I guess I owe you a

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave

