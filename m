Return-Path: <linux-kernel+bounces-56691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A4484CDA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F3B1F237A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854B7E77F;
	Wed,  7 Feb 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X92uDQko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2297E78A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318462; cv=none; b=VpGPXOEYWQK3Tl7ofk5LFT2IPKVIXLQm4N4FrIUyXCSUy9z33jg+8xd97P6p/Oa2B2iKLkqQ224M+XVvPPo0VfU6eNxdJ405Rca/Nl8OzCHViAyz7aWJ2wPQgOP4jrel0yuU2HL7dOSEIFy/sa+RaXYe7mIIrKDBkptX9EPYvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318462; c=relaxed/simple;
	bh=/FqWXfV/HSCjSSNlo7ORSdgjuhGmOAjdQjE+0p+5C8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVU2uogDjnzy4VCtoB9cnsxltFJKnyuOzYzW0krkCGMCj8Vei/1Iysya5ZQ3N4Ysh/yYdMiuoN/j6XwyBv9Ym8Vnka1nH5qa5NQxbiuSbUk/4FLczKkw3dAVGHebstJC2Wsh7mSL2CF0XONQqCnv7X9tu3sZymRlZOQTKptX06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X92uDQko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ED7C433C7;
	Wed,  7 Feb 2024 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707318461;
	bh=/FqWXfV/HSCjSSNlo7ORSdgjuhGmOAjdQjE+0p+5C8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X92uDQkouiJaOfpxP+Gy2vRB8fjxUG5Vc7vgi4F70HTzcsvqCcvg9GgHPAkqsL0Qo
	 EHG4ZwgG8xmDwRfSxd1m0U/ToKbe6BHC7FWB7Bi+UiyDXSMhZtnd1ZC8CMHotIHEkQ
	 GtMo1a5b6a0l9hX7OaacKDVbExHR5zB2wvZXASZGTAyia0qPvogUrrlHR0fvwivy7w
	 VQP2t+ixwzL/SdpEoU133551s0o9g0JZIIwjSN/fa4SM2r5o6wQyomVohK0RPalkzZ
	 O1K6gIvdFevIyX7mUo3lTorGWkzJLELRSwE58wyr2NeRm7Bd4irIrR4jnqitwRT3Ft
	 9+Wfl3iBoe8eA==
Date: Wed, 7 Feb 2024 15:07:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <ZcOcumjBZSYvWya1@finisterre.sirena.org.uk>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
 <ZcEW3y0IlEctOYBA@e133380.arm.com>
 <ZcEd2zU/JpeIwn5f@finisterre.sirena.org.uk>
 <ZcN2XMkvqxNnsz5K@e133380.arm.com>
 <ZcOBH7ip/KMhLYGO@finisterre.sirena.org.uk>
 <ZcOK7oIe2f/BFlDj@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o0RZcVx3sBEJPf63"
Content-Disposition: inline
In-Reply-To: <ZcOK7oIe2f/BFlDj@e133380.arm.com>
X-Cookie: You might have mail.


--o0RZcVx3sBEJPf63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2024 at 01:51:42PM +0000, Dave Martin wrote:
> On Wed, Feb 07, 2024 at 01:09:51PM +0000, Mark Brown wrote:

> > I think if we fix the ptrace regset issue we're doing a good enough job
> > of just using fully dynamic sizing with no limits other than what's been
> > enumerated there.  We could possibly deal with the enumberation code by
> > changing it to use ZCR/SMCR_ELx_LEN_ based defines so that it's
> > obviously coming from what we can possibly write to the register but
> > it's a bit less clear how to do that neatly.

> OK, but we still seem to have two competing approaches: clamp SVE_VQ_MAX
> for kernel internal purposes, or restore the dynamic sizing of
> NT_ARM_SVE based on the new regset core behaviour.

> Are you saying we should or both, or otherwise which one?

I'd like to remove uses of SVE_VQ_MAX, to the extent possible by making
things dynamic but if not by not using it I would like to not use
SVE_VQ_MAX partly due to the considerations you mentioned about people
picking up from looking at the kernel source that it's a good idea.

--o0RZcVx3sBEJPf63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDnLcACgkQJNaLcl1U
h9Cqogf/YVubSZSSKxxzH4c7ujFCQ4mUJbGhxjFtTC7VRCd/CQwVl8M/IQ1ravBm
7JX5M0ct6KXGIeQcCl87sT/5QiN00NTospgxZEVvxIdrbLOngYeTrrfjhPoWrvXW
6xHHxFLu0PZHybk7NBOXKqeNxC/ps9mAt9kqdEm1Ba2FTSS+UzXXpQFEDdaVQWHX
bZwK5RtA8pmvJPkoMkRBYEoJmQWc1s4bprGFmlB2MHY2iM686C+xwssJYT3HULm3
VMhVAl1Df/y3B3WSV0x7oi5ODrquofGg0BEbrWfAeEjcrdVvf1rRljygLL0GQtUO
aYSCVUi+9Fqgntsyy0joF4LwPA94dQ==
=yz8L
-----END PGP SIGNATURE-----

--o0RZcVx3sBEJPf63--

