Return-Path: <linux-kernel+bounces-107782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2588880197
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674861F218C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162081AB3;
	Tue, 19 Mar 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS/iI66x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58228657CC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864773; cv=none; b=lSzmeR3/sZY34tcx3a5goT7RSfme+BmjwPdesAi0M9Bw61VMudsk4zKRX5mjjtQ+5gmSQ+qQ7rnbC6IrLaseZcz8rBvE9+odnh4niTuaJpVWjCTRhCh97p7EDcSrUyzh0V3WI/vAh3k2FPLQFVxqL/6xHdrkdjp5JVDpFTaCU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864773; c=relaxed/simple;
	bh=n2qXWMoeCkOJS/BwlGKgJwulo1yKia2nXcB26Tco4Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLP5LmOftqD38/v/CPz01hTKcRmBYroHnBhOxMieJUuNbWrXmXDFT2ch4pjktmv8kd1BJGNDQRubgTqFJrG87lHFLC36w5W0+sJGULnUXlIhjMs5cGgoMiIu0rxTtMav0VL4tLQsQUtiKcROQUeTupBMsa4PyEv9sIl4rAqjTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS/iI66x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2E3C433C7;
	Tue, 19 Mar 2024 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710864772;
	bh=n2qXWMoeCkOJS/BwlGKgJwulo1yKia2nXcB26Tco4Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fS/iI66xLgbkeNAN5pXT/MHavsUZHlJWJrxM9/Cz6PO8qthxQK3DE50CaUC8rEy8b
	 G6Qyus/GMX0C1tuzVPxKCjgUuryMQBv9r2f0Dx3VhYjyvZ2pIrSYPGaf/88ETAeYF5
	 1Q6rGFCc7JeLNJFyJCYlgEJDuS9iGDrCnGLtgYu1o+g0trpLEfhtU+K3hXPJuSi/Dt
	 Ds/pt6YJDqHQEEd3QZNLsaKFcoHqzGpaIe+Ul8XDKeuQuJmuf4d0WhEPiN+TfbmPXb
	 3LRhadErX06Kg+LTHrfBSaYoJkZPwIiI4xyY0FF/zaZEpWy78sL0HSjgxjqoPQg+Qu
	 STIotzrm9iL3g==
Date: Tue, 19 Mar 2024 16:12:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf: starfive: fix 64-bit only COMPILE_TEST condition
Message-ID: <20240319-epiphany-septic-03748fb30053@spud>
References: <20240318-emphatic-rally-f177a4fe1bdc@spud>
 <20240319155616.GC2901@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VFAH5IhLrRb5l3FF"
Content-Disposition: inline
In-Reply-To: <20240319155616.GC2901@willie-the-truck>


--VFAH5IhLrRb5l3FF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 03:56:16PM +0000, Will Deacon wrote:

> Thanks guys, I don't know what a starfive is so sorry for not spotting
> this when I noticed the build failure on arm64.

It's a bit like a starfish, I guess you've seen them in sealife? Or
maybe some David Attenborough show?


--VFAH5IhLrRb5l3FF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfm5gAAKCRB4tDGHoIJi
0ioAAQCCulfVe9n5+VRjncvGVg9s9dox2FwgXGGQB0L38SBNVAD/czFRewZa5BRz
4pOHsrnsPQE5Ml9Juci3eca+Zi12sAM=
=rflW
-----END PGP SIGNATURE-----

--VFAH5IhLrRb5l3FF--

