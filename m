Return-Path: <linux-kernel+bounces-144413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2408A45F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A161F21435
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FCD13775F;
	Sun, 14 Apr 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rothwell.id.au header.i=@rothwell.id.au header.b="WY6eyNg6"
Received: from mail.rothwell.id.au (gimli.rothwell.id.au [103.230.158.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE296136E21;
	Sun, 14 Apr 2024 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.230.158.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713133588; cv=none; b=ZjP1jOZ1RRmNwl+yoiLT+IUXqzddB42uCnUUtEJ3i/TTrbkBahZ54BA9VPSq2XrMSIfZzGL7ebNDBM5HAnDoJLtmYDDl+dTcEYgJqUJBHxePrdmpspKEIP1vntnibSVRNWxsbG2X8WreDLctPYCPtjYmfminQLSJwI3XZwcs3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713133588; c=relaxed/simple;
	bh=+ghWU8oi0+edXCpEfVT/DjC4E+tVj0hs8sTKXvlPtf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=if4NwcQ1t5OIUypiTwwtBOOxeFPvNuF2DSK2DspMgNHtPy+ngKvbuDsvG6M6DbQdAvmlll8V8iDJcBUWcUuJBxQciBWVGrT8GxXJXhrV6ecY+Nrfzws/9L3MMcKps6bZt4c8L0EI/gXg2dUz1F+27ssHjJn3Ie0pxHqmteJbQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rothwell.id.au; spf=pass smtp.mailfrom=rothwell.id.au; dkim=pass (2048-bit key) header.d=rothwell.id.au header.i=@rothwell.id.au header.b=WY6eyNg6; arc=none smtp.client-ip=103.230.158.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rothwell.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rothwell.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
	s=201702; t=1713133115;
	bh=Zex7vZfysAqqFpHFj6AZeIO2KXBBGaa1ARC2QHSXc74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WY6eyNg6TN9czkOHxS+N5riRPXMqHUyhdFEwHOTONBBolw2rgaQfyeM8lbxX+anxx
	 0/DOtaDgWNjHMrF3xLwFUZljv46CEOsOyU8qjCCjYu770DvRSerOJKRJ7PP+UifM3G
	 Aq2kVJuSUz3oP1qp8kC2WNxuWZYCDmW6b6Ca5EQ2m9h2MqpZkReEmYCwEjzoZuWes1
	 unjtT5l4BwPVvYg0k97WywfN2uPYcTRrOHBWif1WMPB8xAZqk9AaXVPle0Xy5hycBV
	 Co6rn7ySrWmXySGJQ+6olpn5rFHOkfGiFbNtHUCAF6wHwgqKRmY4G+JpcoqZAuBoU5
	 74jny6yFeHH2Q==
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.rothwell.id.au (Postfix) with ESMTPSA id 4VHl7X3MpBz8R;
	Mon, 15 Apr 2024 08:18:32 +1000 (AEST)
Date: Mon, 15 Apr 2024 08:18:30 +1000
From: Stephen Rothwell <sfr@rothwell.id.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Stephen Rothwell"
 <sfr@canb.auug.org.au>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-kbuild@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@suse.de>, "Nicolas Schier" <nicolas@fjasle.eu>, "Nick Desaulniers"
 <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/12] firmware: dmi-id: add a release callback function
Message-ID: <20240415081830.3057ade1@oak>
In-Reply-To: <20240413223857.7c01985f@endymion.delvare>
References: <20240326144741.3094687-1-arnd@kernel.org>
	<20240326145140.3257163-4-arnd@kernel.org>
	<20240329134917.579c3557@endymion.delvare>
	<63909b0a-7d76-418d-a54c-1061bd3b6e11@app.fastmail.com>
	<20240408095943.48e6c0cc@endymion.delvare>
	<28ba40ea-7f48-41b0-ae57-99a870e68fb8@app.fastmail.com>
	<20240413223857.7c01985f@endymion.delvare>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J+j9Uv/rB+H8SWjIizFhSRA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/J+j9Uv/rB+H8SWjIizFhSRA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Sat, 13 Apr 2024 22:38:57 +0200 Jean Delvare <jdelvare@suse.de> wrote:
>
> Hmm, Stephen cleaned up the list of trees he pulls from 2 months ago.
> Back then, I objected that I may use my tree again in the future, and I
> thought he had added it back to the list, but maybe I misunderstood.
>=20
> Stephen, can you check if you still pull from tree above, and if not,
> add it back to the list? Thanks in advance.

I also misunderstood your position at the time.  I have now restored
the dmi tree to linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/J+j9Uv/rB+H8SWjIizFhSRA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYcVjYACgkQAVBC80lX
0GwWmQf+I+OtIbKE6pkPfebdfoH3KcsgRiBBVTIRuH7K668elAfMvPCxYnXK/YSM
8lhrLeBvH/ZEpcfwrSVun4uTUoouGlLYbq9MP7DTWsgCIVdrJZ0H5koh8pT47C6G
wybvmUvhXidlIiwV4DI14iSfMGcA9dddrBre4aE65NbUN3llGFtf6apMT/zvmE1W
yV3sHVGTIPtX5EQ5BC49rkDeBiTAiAbZ/4OL42OZh8xNAmjkcuIWwRnUzSYSxtK7
SKq0Jm39tK0cBNTlHt0dRTtLtRKIcmptJ1KYNTPvaGfTtPOUzK9nipmMc1EKd6oj
59qM6ec+wLRn/7hwgPB2AuH3zuHP2Q==
=ffFN
-----END PGP SIGNATURE-----

--Sig_/J+j9Uv/rB+H8SWjIizFhSRA--

