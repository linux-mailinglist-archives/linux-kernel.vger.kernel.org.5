Return-Path: <linux-kernel+bounces-148567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA838A8482
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132062809C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E13213F43D;
	Wed, 17 Apr 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZSCN7u6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DD13E02D;
	Wed, 17 Apr 2024 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360383; cv=none; b=Q/Cw7RTBxWP3py6W4KrIuLhFDZ1RiquAr+190yG8oQjx1imqLLhZ6niRoyC9W3BUzjYf4GjBTeA4Vy/kqFshFS1+ib5ZSMm7WiIaUA1azswO+/99sNNcThY9XIktrWLBpzW9DxEeOsBDxud70N4RWg8/z1KThxOn48+STYopCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360383; c=relaxed/simple;
	bh=w8uH1uC90pKNqDMwT9Mn9CCiXOobtxADD5T7dibtAsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffcg3/XkvwhLO11imNicBhwBd2NwbYP665b+02bnt9oL/JG2+v+EH7RerJyBBiqCuZk68z0TRLAcmzFya6zvaGSKM0dO4Py+zHg7xCwBLrkKntF4mTZv6W1bJgeCaX+9my2HKHaC9dWu6wxCqKg6JAZmRC6Ekl2FyL+LekfiH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZSCN7u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C13C072AA;
	Wed, 17 Apr 2024 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713360383;
	bh=w8uH1uC90pKNqDMwT9Mn9CCiXOobtxADD5T7dibtAsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZSCN7u6SkYaxUSJzCB/i4EK5A/1Gjo7xq3b6Prtto8XIhB1uz2NQs6t1pUZxSwYI
	 E+nyJf0R0MUkCn5lwop+V/XLzOGqG0Mlct4X/eitypu864zXq4uzy8/02Fp98alg0v
	 WwrmrOpK3wG/uc073F3xo7pDx+MN79xxwYDyvL4EhSiP2pBseJA/MHr/BGG46Pb3A4
	 rDVhOCnPyIhY95gcJF7+vytWw4s36/pKCYOSVFlRTWqXiQUxnCeleIsh6SEJrQCzec
	 bXptlvEQCIhcTS6v7wMZU0wgXKzyE4YmSPV/RtQ2dpdH+sNW3/gqwqOhFR2/A25Wet
	 k/6VAs6aW3lwQ==
Date: Wed, 17 Apr 2024 14:26:19 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-clk@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clock, reset: microchip: move all mpfs reset code to
 the reset subsystem
Message-ID: <20240417-unsaid-pried-782d191d5d3b@spud>
References: <20240415-democracy-risk-419b0250a432@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MMbT+sOwNjC5Vmgx"
Content-Disposition: inline
In-Reply-To: <20240415-democracy-risk-419b0250a432@spud>


--MMbT+sOwNjC5Vmgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:04:57AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Stephen and Philipp, while reviewing patches, said that all of the aux
> device creation and the register read/write code could be moved to the
> reset subsystem, leaving the clock driver with no implementations of
> reset_* functions at all. Move them.
>=20
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

There's a couple checkpatch issues that got in without me noticing. I'll
send out another version with them sorted tomorrow.

--MMbT+sOwNjC5Vmgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/N+wAKCRB4tDGHoIJi
0kDRAP0Q+hA60Sezil6YNcjZRMNQOLImQFaXe+C0NyznIyQhbAD6AqrQm9N3mcxO
qWQgDrSG3K4RRNh6JXFotQj5m53h5gc=
=mcgc
-----END PGP SIGNATURE-----

--MMbT+sOwNjC5Vmgx--

