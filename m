Return-Path: <linux-kernel+bounces-44731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F18426A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4641C24112
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D236DCEA;
	Tue, 30 Jan 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQNym423"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD86D1BC;
	Tue, 30 Jan 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623778; cv=none; b=iLkZFOKqS2KqIFGldMUT5Yk4VoX/biKxvQEIEzmZ9reGxv255SEC5U811Y7BZdxxtpAr5MGOgrOGYGxJOX9ksQHxIOTV2nIShu91LD62hG/yJydkCTRrrNa+6ZE/GBuaLjrst71mBGV2TAtqTb1zQN5CxKcSRo8kW6dxI4gxKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623778; c=relaxed/simple;
	bh=HTB7rybbrmbLBHLUmBY3wflc1iO/bGggajnCBCZ837A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5ABP7YH8zJZ61IWx8hOW6We3UjZzoK+MdJMPT7+gFtPHuBluZG3qMW6Do5OZgQnBEP2MtZIWsrTmLJoZE3SfysY2rmL6fiv8oF8nuuK1psAG0000qbsAN4R5NNULmlDUiVQ3we+2gjb6Zbl1xa4TibzCYnM7AKIRB3bDP0OHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQNym423; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E09C433F1;
	Tue, 30 Jan 2024 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706623778;
	bh=HTB7rybbrmbLBHLUmBY3wflc1iO/bGggajnCBCZ837A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQNym423x0kFxEl0MW3XhtBx7QDJJ5CHG5jvHw0Flo0cVYOBwwfgcmF3nV8HPFRvG
	 XSZT/Aq72o9Qh92ICo0aMrIUZ1YMIaGlNomY6F3QMPQRQ0GLiEQa2MGgSd2Th7kaPY
	 s1Xr5td2sIOY8TQjFArxHam5BnqTMYITDjpOA+owhOSJtRPWamC/smU/Cti6IhUvSA
	 Eg8SVqNZkw5BcDyB74LVjOMhy5JI/MYstSJkGCEjb5TRnZBE30NgbWSB2RaNdV9B9L
	 tKsPW2OjS+dBsLOZBIaC5nWsb6Gm8JEA1WJB/oYh8Q2LfwjLDC+sy0PHON5fn1fkIh
	 AntSKyLFcct7A==
Date: Tue, 30 Jan 2024 14:09:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Dave Martin <dave.martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <b0ed6698-bc65-48fb-96b8-0cd077448196@sirena.org.uk>
References: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
 <20240130115107.GB13551@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uWPAAXNST8xADQkB"
Content-Disposition: inline
In-Reply-To: <20240130115107.GB13551@willie-the-truck>
X-Cookie: 1 bulls, 3 cows.


--uWPAAXNST8xADQkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 11:51:07AM +0000, Will Deacon wrote:
> On Fri, Jan 19, 2024 at 12:29:13PM +0000, Mark Brown wrote:

> > -	if (test_thread_flag(TIF_SVE))
> > +	if (current->thread.fp_type == FP_STATE_SVE)
> >  		sve_to_fpsimd(current);
> >  }

> I don't think this hunk applies on -rc2 ^^.

Hrm, git seemed to figure out a rebase with no intervention - I've
thrown it at my CI and will resend assuming no changes from the rest of
the discussion.

> > -		if (add_all || test_thread_flag(TIF_SVE) ||
> > +		if (add_all || current->thread.fp_type == FP_STATE_SVE ||
> >  		    thread_sm_enabled(&current->thread)) {
> >  			int vl = max(sve_max_vl(), sme_max_vl());

> I think this code is preemptible, so I'm struggling to understand what
> happens if the fp_type changes under our feet as a result of a context
> switch.

We are relying here on having forced a flush of the floating point
register state prior to this code running, simple preemption won't
change the state from what was already saved.  The same consideration
also applies to the check for streaming mode here.

That said if this is preempted ptrace *could* come in and rewrite the
data or at worst change the vector length (which could leave us with
sve_state deallocated or a different size, possibly while we're in the
middle of accessing it).  This could also happen with the existing check
for TIF_SVE so I don't think there's anything new here - AFAICT this has
always been an issue with the vector code, unless I'm missing some
bigger thing which excludes ptrace.  I think any change that's needed
there won't overlap with this one, I'm looking.

--uWPAAXNST8xADQkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW5Ax0ACgkQJNaLcl1U
h9CV/Qf+M+B80WOMZNgHU9dCZZG69Aykjj55IozuDVFkd5exazmMfTEW34Ojr6Ab
Oqj5DCHsru08tlJPGg1fgUKbx/g2vRP/rwLathQOZVwHKomcbc9P56EzHduVn43a
fXecMSex+3LDm85+En5p2pCDrDyHEthdHdLALVM1QhEVbKGtsV/UpAH8OmQaPL7m
L6fMUh8qdP8gRZSFyXfCRhJDbmAy1Y2wVxiX1wAuee2UcFF0e8h6W8zamC6h9Lf7
PlwmVqT3NKan89/f61Fhckh//vw6/B9y/MFTthhCUz9W8m07AZ27xqd+ZNsF1Vsm
i/eugtrfijoSaHKnYWMVE8ZuILjNzA==
=7Na8
-----END PGP SIGNATURE-----

--uWPAAXNST8xADQkB--

