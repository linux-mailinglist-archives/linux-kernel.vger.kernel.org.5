Return-Path: <linux-kernel+bounces-147952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA68A7BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CD61C21977
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5D6535C8;
	Wed, 17 Apr 2024 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bLo0X7H0"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522F53389;
	Wed, 17 Apr 2024 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331096; cv=none; b=goy830TNA/7MNFCRFpGYGALab4CgE7XOZBXq45KVmOtujhhH6nBMICMcValSRs3iSyFaAabJg8GRpSY4ZZ3OhY2UReu2qFT+oeVxf2p97aFrOgeQSOD8LjcYaPEirpGpHNC94Q/sdHagbglzorTF7cAnyKt4+67JQUdb80B4l1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331096; c=relaxed/simple;
	bh=Il9V0Kokey9Tjqc3N/KaASOnqs22ZCDqg0UEeI3u3fE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PYmX+Khinlw7xJddWKM/DM+r/lvAl7VvONl7d3EQHTKNOuSU4m9Zoi1fyspCHkiUtYeqzI35/WBB6jvtKF0c7yvEIlngXyySyY3yCGwIzCnYFhAqWp0jSpnT92iNqY9vYZkuD48yj72TNJ7JgcFprLzLfCBoA3u/cNq9vCHxprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bLo0X7H0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713331092;
	bh=aF2WuhjBofPVeU0nHFLxo1B1ck4dE7K1tTB5Yj2+mRQ=;
	h=Date:From:To:Cc:Subject:From;
	b=bLo0X7H0EH8FB98nbRjIfoJNxQ0/1rWwcvCtD/uEp/zN+dD/Phv7DnhIJwBvpDCid
	 I+wpGbuU98CVEoa6MQsOSWdOe6tzi+a+OIzNTAi8KcqSbwLRHqPe+tcVlBQeiIArJq
	 Kb9zMfOPl8lzhLh4Qw7eb+kq6MFheUn9UGfguD5WsKohItqUEZxq5V9lkrmbUmn306
	 XY2ANhaJZWi2h4sGNWfi3jpuA4UYm3cBvlNeAS9T3wCCLLmtW/DyJIkPMGI/sYY4Zx
	 fCsMwfi/RbcmGZEZ3QLEDhIhbjJaRT5rs3PI+dI0qfEuMhUL6jqUJBxnMw8dtJ9Bt/
	 cp+ERVc38jNQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VK8Lr134Zz4wyV;
	Wed, 17 Apr 2024 15:18:12 +1000 (AEST)
Date: Wed, 17 Apr 2024 15:18:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20240417151811.4484b368@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//h+ajTjQzdi6BuOLkvleB=j";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//h+ajTjQzdi6BuOLkvleB=j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/filesystems/index.rst:50: WARNING: toctree contains reference=
 to nonexisting document 'filesystems/buffer'

Introduced by commit

  4b61a0e73910 ("doc: split buffer.rst out of api-summary.rst")

from the mm-unstable branch of the mm tree.
--=20
Cheers,
Stephen Rothwell

--Sig_//h+ajTjQzdi6BuOLkvleB=j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYfW5MACgkQAVBC80lX
0GyfOQgAnpx+Mll4Pbg0o/lkBKK6tl5xjrl3z4wjb5D+PSv+UYml/AkfQRvAhaF9
+sFIN4JMUmnjpR6s5ikmV46QUVn0r/WKtrefGptJL5ZZdsAMLuWNBGx3nwjZIVob
mDCcQ/C7vx0MbFJfjlt/gHq/FfeQVKP6+RgzE2mfRfDQXpL+IHUVo2QctdQX6Sbz
Z4W9d7zE8XEDnaU34xvb5tTF/ISLzyh2FGfJxqsTSZ1X8NK46snen966An1Wje/R
RbZL10GrQNCSs+JTEZvJgZCjBoFmnsJ3pwnwBx9S7rC/AKjqKyan/hfD32ue0sW+
7BjDzZyDbs1MaITOiftMYH4bab9vrg==
=0VIB
-----END PGP SIGNATURE-----

--Sig_//h+ajTjQzdi6BuOLkvleB=j--

