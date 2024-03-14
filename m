Return-Path: <linux-kernel+bounces-103618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62187C200
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6C81C20981
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CA74E11;
	Thu, 14 Mar 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVU8DRaO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB9745EF;
	Thu, 14 Mar 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436579; cv=none; b=KAouChoGunhqSPf0baDwSYOCB3X4vPjCvZaQbI0kFK0MEZvlcOH7Y3slM+nWF3HfKfAF/7jomL7wHkhV7zw4NvbCmiktjaukkQ8wtE32hgXuFW3H8Y0s2S+H0fgQG5fEoKDctMyvdRs9y8hH+X7JEpR9maqnSTSoW06SfxC73cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436579; c=relaxed/simple;
	bh=pGyhDtx7U38/KEVxI7oHYe+wiEczizknyEbNsI4Y7yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQkthoVT5kXm4Vi8XXCelTG0YybVa75BR15iPuGg4wy6rRglwOaU7wc/YQ/zrYVx673+yNzsxTV9Y9PPEsX3km5RmPMFfHIu1t+vtJmPEq8AQ9hm1DHTIuha2oNDD4me4odfdtHNMH/B3GXd8bU62ZNOwAlgzma6bTaGadC/XvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVU8DRaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F910C43390;
	Thu, 14 Mar 2024 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710436578;
	bh=pGyhDtx7U38/KEVxI7oHYe+wiEczizknyEbNsI4Y7yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVU8DRaOFCUY4k7U5k79+C+zLjmY6l1d31ADpOQkNocdVJ4iDCIuVqoeoxJKm56b6
	 7sH9uuQqkv4BDr01c9D7pLz+3pvAQ+JEH6bgq+yzKTkQZh7OD3SPbz/UbHaWlDobiz
	 RArtKW+vbBRzVDaewD8ItVe7CQFcqA/nz3sw7BPOpCU2ofOAis7G3wyIwh8TTNEhle
	 T4Y1fVaw1fkl58IUO039KtyoPwBkpU4DJBqMi/JbRUNnT6lbEscsUExTe9eJQudta7
	 aMGalX9wD8ETIk/acxc8aRMIuhlb1RXij3FRNPZRoVETAKRA0kj8WRpuhTiVsnWtaO
	 T5239dJQfxdBw==
Date: Thu, 14 Mar 2024 17:16:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block
 driver
Message-ID: <20240314-capped-creole-7b11c1563f86@spud>
References: <20240313110515.70088-1-nmi@metaspace.dk>
 <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
 <c38358c418d4db11221093d7c38c080e4c2d737f.camel@redhat.com>
 <5f502f91-0450-454d-ae8f-36223920532e@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pk7WrlyY/BqNsZtB"
Content-Disposition: inline
In-Reply-To: <5f502f91-0450-454d-ae8f-36223920532e@acm.org>


--Pk7WrlyY/BqNsZtB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just a passer-by here, but I noticed the link to Laurent's talk..

On Thu, Mar 14, 2024 at 10:03:28AM -0700, Bart Van Assche wrote:
> On 3/14/24 05:14, Philipp Stanner wrote:
>=20
> > The Kernel's C already has more memory safety than standardized C:
> > There's devres, and since last year there's the __cleanup attribute.
> > =E2=80=93 but the thing is, you can just ignore it and do it the old wa=
y.
>=20
> devres is controversial - see also Laurent Pinchart, "Why is
> devm_kzalloc() harmful and what can we do about it", LPC, 2022
> (https://lpc.events/event/16/contributions/1227/).

I don't think that's a great thing to cite, that talk prompted a series
of others with (AFAIK*) the most recent being from Bart at LPC this year:
https://lpc.events/event/17/contributions/16f
The TL;DR is that it's not actually problem caused by devres.

* I think Wolfram also talked about it at an automotive conference, but
  that seemed like a bit of a pitch for funding from the safety
  conscious=20


--Pk7WrlyY/BqNsZtB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfMwxgAKCRB4tDGHoIJi
0j+gAP9WfX58/nQt3jltC+8M270HUvjPJmZyrK0+DRah8vD2VgEA5wxGAnUDrSFD
yKkVFD4fjcc2jhvn2r53fjz7GEACpwk=
=z+PJ
-----END PGP SIGNATURE-----

--Pk7WrlyY/BqNsZtB--

