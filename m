Return-Path: <linux-kernel+bounces-125480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE58926EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5B1F22D09
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD413CF91;
	Fri, 29 Mar 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IpcGOe+G"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA136849C;
	Fri, 29 Mar 2024 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752574; cv=none; b=lsfeT/09HbSBU7HHeb/VfZm10SqeljgP3Zdfwumy/tsTIkoCn79hnVn/h3MY+QQx4ifs703OWbvS4Y4BFLjTNENZfpjl1RY5qfK48XRqpK1XlurcOFIgw7Ua1CP1jnPBh6uYzfCEJR03FgZupcqPXLJJaZ+BgLljzdWsBFd3cUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752574; c=relaxed/simple;
	bh=NUfPh5D3dQMIcCtz1EhdkcsFvsIQ6wVm83hQ6WfxnOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUQ9SK26n4OQ2Kt5cTp+sE0PZzVwEgz5keINWrxuybjfFWjkYxjw402Jj+fPE4VTHfzW0pM6/31wuMXbYWjOIXxwbElg0898TMcrkTsScF0wunMLiAdK2Dr/T7keIG5dOjb3IVsKRP+EIgcXjY80cKDmtrdfsrjwh+oHzFUbX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IpcGOe+G; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711752564;
	bh=y7/nbXFQZJjv1BJM3ikZ+A5q8QAGzIbRDpWbIYDsgHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IpcGOe+GKsUbsctsTABGZXj/TkRvnlkwMfabjWCTE+oMxrYOc1CzrHlBgK/CNM65+
	 wLB76ZWrRTCpcKHKDXef5XQTfYXlu4dZwkZU+QjiN2buY7TNbxGGQc3+pCHsNZx82F
	 BGnsu3KOBh2FhylnAMqiKghTzFvuGBx+YBTVON+zzRWIzov3zXobuxBBJts8w2lyT4
	 spF8geDua8Vxt0My4r3TMvLV0ML6ee8gjCR8gqFpweFP+KE7skh3bIHzmlABtGGzah
	 Il9MDLY1SpF2zwe9RuS6KfJZ4hqeNrdKrkCy4NiaTYio7pMczJnc9qVav5yoJqTQXh
	 +w7lOE3MLJ+BA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V5wZW0VRVz4wcn;
	Sat, 30 Mar 2024 09:49:22 +1100 (AEDT)
Date: Sat, 30 Mar 2024 09:49:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
Message-ID: <20240330094919.61e7c7b8@canb.auug.org.au>
In-Reply-To: <CAJuCfpHZGkL9urkZaVmO_o0ujpr-moDGYiBES1iRy2dh8g-t8w@mail.gmail.com>
References: <20240325123603.1bdd6588@canb.auug.org.au>
	<CAJuCfpH4Ee00hM9+B7=mi5Dwjrhov8vUK-KwPuoO3wsD7iJSAQ@mail.gmail.com>
	<5e1321ca-0d46-4e9d-a6e5-0560d99f65ff@infradead.org>
	<CAJuCfpFTOz8cNiJFiCU5tMM1u5L=wXRsXqxUhN9g-R0u77CyZw@mail.gmail.com>
	<20240328153947.3871cfdf@canb.auug.org.au>
	<20240328154427.3e926d21@canb.auug.org.au>
	<CAJuCfpHZGkL9urkZaVmO_o0ujpr-moDGYiBES1iRy2dh8g-t8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FA9pyRN8FXVoQi2ztbbKi3I";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FA9pyRN8FXVoQi2ztbbKi3I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Suren,

On Wed, 27 Mar 2024 22:35:56 -0700 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> https://lore.kernel.org/all/20240327044649.9199-1-rdunlap@infradead.org/
> which seems to not yet been pulled into mm-unstable should fix the
> following warnings:
>=20
> include/linux/slab.h:730: warning: Function parameter or struct member
> '_n' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Function parameter or struct member
> '_size' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Function parameter or struct member
> '_flags' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'n'
> description in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'size'
> description in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'flags'
> description in 'kcalloc'
>=20
> And https://lore.kernel.org/all/20240326054149.2121-1-rdunlap@infradead.o=
rg/
> should handle the _noprof warnings. I can see this patch in
> mm-unstable and running "make htmldocs" in mm-unstable does not show
> the _noprof warnings anymore. Please let me know if I should try some
> other command to reproduce these.

Those patches entered the mm tree after I had merge it on Thursday.  It
should all be good on Tuesday.

--=20
Cheers,
Stephen Rothwell

--Sig_/FA9pyRN8FXVoQi2ztbbKi3I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYHRW8ACgkQAVBC80lX
0Gxgvwf/cbqAEXHY0h2qgDEQcCMgXVslA1NPf257L3zgOuCHyXMcmL3hwwPEURq1
K1XwRlmeeSAkz98+F4yZ8Jmorf1B6XDmYGOW/4LibXX4lN3wMsAiECWJurB1nyZs
AgvztLSdVJTrW+nkydmT8ekFlIyK2xUQkwHNtr5iJ97DH6nPaLUeIqyWVaVkOGpt
atD9CE3J3dC1UYzSvH7ipdEOoxeSc4FQFDGRGvdSJ8witGnAq6HDrMYcZEmMkotp
r504oKZTeFwD0XI9nzSBSHnfzml23a/gUSwHDzxIi9TK88tPBpmS+v7ioH13luyL
n2VZEAicwEyUWC1ASZewuk3BY0fEhA==
=2moH
-----END PGP SIGNATURE-----

--Sig_/FA9pyRN8FXVoQi2ztbbKi3I--

