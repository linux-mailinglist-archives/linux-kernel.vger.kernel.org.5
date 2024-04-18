Return-Path: <linux-kernel+bounces-150825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3DD8AA546
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEDA1C214F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCFC199E98;
	Thu, 18 Apr 2024 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPjc9z4Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F97180A67
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478203; cv=none; b=Il5VHC8Aod/m+X/Lu6faFCU0x811+kMNL5zzoY5qTA87AKnMa9+Dnn43f8bcAPf5PRsBaKTOC1t1AF8Mbib5O0szvYEU586OPDVtvW7YHobhZmSTAkVQVlgLxLqKpMaS87ObRm5dMs3bqqEEnrT3WK8Bqat32DyQeFmT/T6BJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478203; c=relaxed/simple;
	bh=YSbQDzB7oVXA+6U+Fn5mPYeVPvR2ma9l+pzDAVPKnH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMWM9n1f2JjR+cCPJ1aJFiNTcIYF9fYriPh5deksNRD13q4XJlfvw1pL+AABYro7eHfkg1RDENLNLWbd29Q0g4OKkU1SGDV+mk/yNkeyomVaSPKdSqOJWLUDn+nSlyNA2BoNvWebLPcOYaisjybYXm2fRGu20nVO2oHn3+p3Hxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPjc9z4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41EFC113CE;
	Thu, 18 Apr 2024 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713478202;
	bh=YSbQDzB7oVXA+6U+Fn5mPYeVPvR2ma9l+pzDAVPKnH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPjc9z4YNOQeIrinhriBSIfB9agDKGdqBf+Mo65aoKZs20wTvEGuAzfXAMzT4qbOw
	 PpFj7+FOOPeV8O075FI+6u2cFhnvRlp/idzIma2CRSPbBNQgwz4Zj6XyYUJQTY/ApF
	 WL7bfhXgnjnGGTE/zcxtIcpmu4l6dS1N9EZFWonf8keq8h+H7OO/ZXa6ZD4LLvfvr9
	 7WsE1+ksJ0GSU7y9YBggF4qHJwS+9hNov6LVFYlDyS2xIYNhLoHvAxFQnyngVHxnRC
	 h1j+xChfAZaO0hu12ITi8TXS1VvdnT4WR9W1SCUV2GFCaY+6PYBDgg4LI9/YBM+AuR
	 l3gfmUXux9rMQ==
Date: Thu, 18 Apr 2024 23:09:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
	guoren@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, lihangjing@bytedance.com,
	dengliang.1214@bytedance.com, xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com
Subject: Re: [RFC 1/2] riscv: process: Introduce idle thread using Zawrs
 extension
Message-ID: <20240418-smilingly-overplant-c5f3a698fdc2@spud>
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <20240418114942.52770-2-luxu.kernel@bytedance.com>
 <20240418-dove-deferral-2b01100e13ca@spud>
 <20240418-d9f305770dc71c2687a6e84b@orel>
 <33de5d8f-5ccb-4dd0-9915-720e6f800560@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ugf9QOJEd3IvGO73"
Content-Disposition: inline
In-Reply-To: <33de5d8f-5ccb-4dd0-9915-720e6f800560@sifive.com>


--Ugf9QOJEd3IvGO73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 05:00:42PM -0500, Samuel Holland wrote:
> Hi Drew,
>=20
> On 2024-04-18 2:10 PM, Andrew Jones wrote:
> > On Thu, Apr 18, 2024 at 04:05:55PM +0100, Conor Dooley wrote:
> >> + Drew,
> >>
> >> On Thu, Apr 18, 2024 at 07:49:41PM +0800, Xu Lu wrote:
> >>> The Zawrs extension introduces a new instruction WRS.NTO, which will
> >>> register a reservation set and causes the hart to temporarily stall
> >>> execution in a low-power state until a store occurs to the reservation
> >>> set or an interrupt is observed.
> >>>
> >>> This commit implements new version of idle thread for RISC-V via Zawrs
> >>> extension.
> >>>
> >>> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> >>> Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
> >>> Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
> >>> Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
> >>> ---
> >>>  arch/riscv/Kconfig                 | 24 +++++++++++++++++
> >>>  arch/riscv/include/asm/cpuidle.h   | 11 +-------
> >>>  arch/riscv/include/asm/hwcap.h     |  1 +
> >>>  arch/riscv/include/asm/processor.h | 17 +++++++++++++
> >>>  arch/riscv/kernel/cpu.c            |  5 ++++
> >>>  arch/riscv/kernel/cpufeature.c     |  1 +
> >>>  arch/riscv/kernel/process.c        | 41 ++++++++++++++++++++++++++++=
+-
> >>>  7 files changed, 89 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>> index be09c8836d56..a0d344e9803f 100644
> >>> --- a/arch/riscv/Kconfig
> >>> +++ b/arch/riscv/Kconfig
> >>> @@ -19,6 +19,7 @@ config RISCV
> >>>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> >>>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> >>>  	select ARCH_HAS_BINFMT_FLAT
> >>> +	select ARCH_HAS_CPU_FINALIZE_INIT
> >>>  	select ARCH_HAS_CURRENT_STACK_POINTER
> >>>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
> >>>  	select ARCH_HAS_DEBUG_VM_PGTABLE
> >>> @@ -525,6 +526,20 @@ config RISCV_ISA_SVPBMT
> >>> =20
> >>>  	   If you don't know what to do here, say Y.
> >>> =20
> >>> +config RISCV_ISA_ZAWRS
> >>> +	bool "Zawrs extension support for wait-on-reservation-set instructi=
ons"
> >>> +	depends on RISCV_ALTERNATIVE
> >>> +	default y
> >>> +	help
> >>> +	   Adds support to dynamically detect the presence of the Zawrs
> >>> +	   extension and enable its usage.
> >>
> >> Drew, could you, in your update, use the wording:
> >> 	   Add support for enabling optimisations in the kernel when the
> >> 	   Zawrs extension is detected at boot.
> >=20
> > How about

Probably should have said, this was just a replacement for the first
paragraph, not the entire text.

> >=20
> >   The Zawrs extension defines a pair of instructions to be used in
> >   polling loops which allow a hart to enter a low-power state or to
> >   trap to the hypervisor while waiting on a store to a memory location.
> >   Enable the use of these instructions when the Zawrs extension is
>=20
>                                         ^ in the kernel
>=20
> I believe "in the kernel" was an important part of the clarification that=
 these
> Kconfig options do not affect whether userspace can use these instruction=
s.

Meant to reply earlier but forgot. Samuel's correct, it is indeed the
key bit I wanted, I just suggest what's above to match what was in the
patch I had sent earlier today. Don't really care all that much if it
is a match nor not, but I do care about the help text actually
describing /who/ gets to use the extension when the option is enabled.

Thanks,
Conor.

--Ugf9QOJEd3IvGO73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiGaNQAKCRB4tDGHoIJi
0rGbAQCve/ypa8G6DlerInRYzzxFD0tAVZln/I9+DBoPxO+1RQEAwyQ7fhUf0HZd
QigfiK03EdAOxRAxiAkuHOuIO6r5fws=
=SkO0
-----END PGP SIGNATURE-----

--Ugf9QOJEd3IvGO73--

