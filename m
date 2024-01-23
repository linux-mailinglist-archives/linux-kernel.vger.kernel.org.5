Return-Path: <linux-kernel+bounces-35592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5D8393DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD11B27346
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB286026F;
	Tue, 23 Jan 2024 15:49:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6960265;
	Tue, 23 Jan 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024974; cv=none; b=bCVp3TumgGstd0YuD+zrAyNVSTBrzaAZ6qX7TPSbBjB3VR3hASNKmsJ1JlqZ3D9a6QgRA+9B9+xvAepxgs9V9kntNQafVyF4g9EI40zDfCgKoLo5ks/cNDEfY2kvNA4tqnRRSKUjmrSX2fNQcLhXvDANR7qob1E+s6uTbW9W6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024974; c=relaxed/simple;
	bh=AzbsMvmKAIX7RADh8WN6TnAlQ/vHfo/L7WFXSV5xX3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx0QVGPiD/ASAgj5xcduySzMxGUZCC6JY5ImlBWkAHi5lbQsybuXrqcTFC94U0BJIQtLjlrpWrfFdj6rIjiuH4P9ekJwtLuzR8YKWnH3YTshQlI5dxPtum6qrJS1vfE5RG7sl0XadKycPZgngIVucWoTOa1/nuJRMdOQxSmg8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD0A41FB;
	Tue, 23 Jan 2024 07:50:15 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E6C03F5A1;
	Tue, 23 Jan 2024 07:49:29 -0800 (PST)
Date: Tue, 23 Jan 2024 15:49:27 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 3/4] arm64/fp: Clarify effect of setting an unsupported
 system VL
Message-ID: <Za/gB3oCNAyiPPnu@e133380.arm.com>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-3-3d492e45265b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-arm64-sve-sme-doc-v1-3-3d492e45265b@kernel.org>

On Mon, Jan 22, 2024 at 08:41:53PM +0000, Mark Brown wrote:
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
> index 3133d0e91b48..ba0a5e5b2523 100644
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
> +    using the same rules as for setting vector length via prctl().

Do parallel changes need to be made in sve.rst?

(There seems to be so much duplication and copy-paste between these
files that I wonder whether it would make sense to merge them...  but
that's probably a separate discussion.)

Nit: is it better to name the prctl here than just to say prctl()?
That would be easier for the reader to cross-reference.

>  
>      The result can be determined by reopening the file and reading its
>      contents.
> diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
> index b45a2da19bf1..b923727ff4b9 100644
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
> +    using the same rules as for setting vector length via prctl().

Ditto.

[...]

Cheers
---Dave

