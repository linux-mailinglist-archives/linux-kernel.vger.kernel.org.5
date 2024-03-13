Return-Path: <linux-kernel+bounces-101065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B474A87A1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B08F1F22E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC18DDCD;
	Wed, 13 Mar 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KJhzz6fR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5BC13D;
	Wed, 13 Mar 2024 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299416; cv=none; b=DggDZXmfbNqBtxD0X2LmMHhin3agvn997b2VC4XHtCpglirgKd0Y9v/sOAyaCCj3DILwmBgPA0CupDvGFALZ70a4+zVrBxJY0elkwK4Xm3j58u11dkOCO1wdCI13FsSKOmzQTPqx6hEKOo9AHv0tTFbkj5/LX3TZn2HY30b9kQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299416; c=relaxed/simple;
	bh=3ln4/GnBIP4oV2h2oSRmTzxT3ghcHRohR0dDGm7KsQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRsiUzZxSWp3u/5+2Sy4xl1CMJ8I/5gPXpIjB4FSZOH6lE0JFgtAeAk0Src1RzNzAjZlkRPXW6oBGvZHveGr1w1Uf0V2vdi+x0i9vmP+1WNSI7XykWGXOqhItmEDTmMhwM1nERhX4pSLw1yKUPLvk3dcQ4T44Ra76uoY7LvK2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=KJhzz6fR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710299410;
	bh=Emukq/0z7fFdOeR5l3w0urGSC0/F+i7oAy4ECKFxgt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KJhzz6fRBmd6//UuYsHapNN0S+TdNJ82IW+XOMqJ4sfmll2gkoneKRks56oeIbRWb
	 cg4+x3moZf9qJl1vHR18IvwNMyArbaPMw2UPWyGvdp1Av0BxD5alH1YJ0ktZu+EOKO
	 Ra7KNGIuHcsSweBAjqRQ5qCuGpSY3cupOWqzhhQ5mUgEyor0qBRMfT8SgrwDnI3kys
	 8F1PQFM3OEy0yJKEvJVDojwy6ZdmfL3mUmFuTLVccIxcl6QlPtJsuJdKegAtLRnCBC
	 epfCWbuQ2to+U+4RUqCqYlUsFXnJyBcQ71NMoriMpo3cX4QNdBoEASHwYlcuJSJhpU
	 kSLLyef/iSFOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvb9G2BZNz4wcR;
	Wed, 13 Mar 2024 14:10:10 +1100 (AEDT)
Date: Wed, 13 Mar 2024 14:10:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240313141008.1ed845d7@canb.auug.org.au>
In-Reply-To: <EDA79CE3-E8F1-4E86-9A2F-857F533BC8FF@oracle.com>
References: <20240219104450.4d258995@canb.auug.org.au>
	<20240313104158.5649190c@canb.auug.org.au>
	<EDA79CE3-E8F1-4E86-9A2F-857F533BC8FF@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A+PdbQiqrwKabCJ5rgUs0rC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/A+PdbQiqrwKabCJ5rgUs0rC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Tue, 12 Mar 2024 23:45:23 +0000 Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>
> Sorry, I thought Linus was going to address this when he merged
> nfsd-next today. What's the preferred resolution?

I started this morning before Linus merged your tree.  It's all good
now, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/A+PdbQiqrwKabCJ5rgUs0rC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXxGRAACgkQAVBC80lX
0GyfOQf+L8ZeBAge+Cq0ps49wZw8s78Ol9VEWpcDfVrcT1p2T4xtV6WF3IjBKVCC
eNkSeM0h+QQAwPLkZL7Jj09tEdMJCIYs3SYFgWnFoV9BURgB3cK8ynGy1DUleV/P
EPGYna9RGEN7C7gV84NhREaLjJmC1HijS4jjiRCaA8cHVDsxZJIk263HG4F5C2gG
J/Ece2r97bqKTwocanmLiMAGua5Yv7sZEHIQn2foHS4cLp3YNPffcpPB5tg8w31C
/mj6JpvD9IYr4ZU737kpDADn/Ua74POpBGMLSeP4OEKvmZVRCKCQ2DEdHs4TGBoD
VkBwhvyXF6kLM4iR63PeiV8CVH1CNQ==
=ZYOW
-----END PGP SIGNATURE-----

--Sig_/A+PdbQiqrwKabCJ5rgUs0rC--

