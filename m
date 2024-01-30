Return-Path: <linux-kernel+bounces-44757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0208842701
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD928791C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EFA7E571;
	Tue, 30 Jan 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unimEILv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF97CF37
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625268; cv=none; b=LNAHNXs0DD8/D/SH2BIJ/mqUqIjo1OvvhoagqfHI36x5p7yC6Rg9asq/iTOWI6B/uUMbX8yZAAhg6matmSIO1flu62kyxNK7uCquuVlJm2xpp3GlFEPHIJE1ddaQ5dXQWLYO9S9IAeXxanr+ZjvMm9uDUhgVu3gVVd/C2Ss3n/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625268; c=relaxed/simple;
	bh=2190zxEd8Xhtvh4IrZjtdwgLMYVBXviRCIAWurSiB8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUmVKOR3WSuIxdgtdQ+iJ5ckIObigcbYPRLFaWXCUVNL4uxplYXaud/tJl5f5vmLUcBx/MclmQ96ndsuKARDqiLCyNTRatAq0XlsYrRDntfyNLk2KVeIIT4QPkfPR9KyIwOeTqJC6B9bHyUSzkf6QLYAGjSHkADRiAGRhvZtgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unimEILv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8843BC433C7;
	Tue, 30 Jan 2024 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706625267;
	bh=2190zxEd8Xhtvh4IrZjtdwgLMYVBXviRCIAWurSiB8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unimEILvQT0/gUU6fJdAnqZuexvD5RX9jtF5HLO6tJDbj7GL5corGyRLGRKhWPa0q
	 pT3TIecnZ7+5IaUwmO+JJwldFzNUtuvDBNHnRGQN5bwJA1Zbx/MSUHWYf1LVyjMThD
	 +Gp1M+xpxrQW/Nvt8UDsG4hPRApU4F+3kF7XzeTidXk8WztRcRpk1VcvE0RGsMxrB6
	 b5WfUVhbZoXKFeA0oT9SLvHAdRpgQA1TC1Qf/AoaT9/I0J3kLE9QjqLjV67ETtb5Ab
	 RyHmqRVdNhYsXmHnIX94wHPj/92zvJg0yfHmleORB3KDZtf0A1k/fpV4vqxlH7U/d1
	 Gk8LNE2t2iVjA==
Date: Tue, 30 Jan 2024 14:34:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend
Message-ID: <ca380b64-3420-4817-b3b4-584b8640c0ac@sirena.org.uk>
References: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
 <20240130-arm64-sme-resume-v1-2-0e60ebba18df@kernel.org>
 <ZbjVTigk0YlGd3mA@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VG4FkmmLh5EwClxi"
Content-Disposition: inline
In-Reply-To: <ZbjVTigk0YlGd3mA@e133380.arm.com>
X-Cookie: 1 bulls, 3 cows.


--VG4FkmmLh5EwClxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 10:54:06AM +0000, Dave Martin wrote:
> On Tue, Jan 30, 2024 at 12:02:49AM +0000, Mark Brown wrote:

> > +	if (system_supports_sme2())
> > +		smcr |= SMCR_ELx_EZT0;

> Side question: since ZT0 is likely to be sporadically used, maybe it
> is worth having separate lazy restore for it versus the main SME state?
> (Not relevant for this series though, and probably best deferred until
> there is hardware to benchmark on.  Also, ZT0 is small compared with
> the SME state proper...)

One of the advantages SME has here is that we've got a clear indication
if userspace is actively using the registers through SMSTART and SMSTOP.
We only restore ZT0 at all whenever PSTATE.ZA is set and the strong
recommendation is that should only be set when either ZA or ZT0 are in
active use for power and performance reasons.  While it is likely that
there will be code that uses ZA but doesn't touch ZT0 I would expect
that the overhead of entering the kernel to do a lazy restore will be
sufficiently high for it to be an unreasonable penalty on code that does
touch it, as you say it's not *that* big compared to likely ZA sizes.

--VG4FkmmLh5EwClxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW5CO4ACgkQJNaLcl1U
h9B+7Af/SN40T6oVk2GhtivoOnp8totsJrKK6V8RelC14Ob1Mt+jzG5v3NjGPFHa
bTkFF98KZowT2rECsOEwdt9wBwPV21FKaB3LWTZ0Ex4hjGohFfKfB7nxz30nDHCx
4uFmtRLulE0UQ1giANwy94wfmUnzb3G2t1vpAa4tUliwejZdCQaRactxOuXBIQO0
nwtq1kXYi1nmWWmMBhTNDQW2YtpFL/LZKpJQ60Z5doisyq1I+b4rVdGLtCO0VEpC
+SaGZoCmZI+eixiL7dxlkEQ8YonrR9p7mOO217Z+KueqOqtsflFa864abxADkn7y
/keIoZmj8AtVYPFvKVtHN+ZCQx6ozA==
=lbgD
-----END PGP SIGNATURE-----

--VG4FkmmLh5EwClxi--

