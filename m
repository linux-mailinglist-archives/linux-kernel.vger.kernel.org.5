Return-Path: <linux-kernel+bounces-36270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2D839E39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8378D1F2B078
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE37F3D8F;
	Wed, 24 Jan 2024 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P3YtdJXD"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734323C9;
	Wed, 24 Jan 2024 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059625; cv=none; b=KH//5+pj/uOsdl5EpTcPNRDfJU1cpAwe6dGiEYFYcSyJ3wsJZy1aMmYgDxOPQcqijlErUCILyq89FfStkt4ZwY4Uh0kRxG4wkoDqiqzRqxscAMgUZNZLs6BkDZHzvPG0r/6dq5zrXqIMa4DVdfl8ZrWiEyz1tch5s63+tci0dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059625; c=relaxed/simple;
	bh=CwnF1RLedr0VAG5gpWbO8BA47Nu19+G9Eezjy1BRssI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGqIk/9Nc0UxzKLcmkKJeaQPNmE5ed/tyClp2OuLMTMnWqdVyBTZNqOeDnyvFxnJ+4k+OBOcbyJ7XJFmscWMplVrPi+gH8GB6Ewmq6YPsXqeDXoccBtzBRXwoLqpmlQubmfspoEVG36QKVd2spySAJtKHOiG3/o0MKzXuqzl0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=P3YtdJXD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706059620;
	bh=YnVXiiq94aCxCahXVksW2BxErM3PzztZ/SdNRmm/714=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P3YtdJXDRvbh3VvzkhBRYfv63vXkwTqLrlN93BFx/Bma4xYNh9dRfJTaFd8Bn1nL7
	 RfGhwG3F638RE8BK8ILMFOQ56S6NUmcJPHdNCr0sXoQyk5Jix6KScGYTymJGZztLj6
	 hJ832DlR4QewqjJo4AGDd6mEpJTgL+f2ISyfmjEIhFmGMASTX+seghpuz/KcCnA+PJ
	 8tF2YhPlPUfnud2O5oJYbZD8yfP1GrhhGmZG6BUZChu6Ks5pXRBoQyk93uEoW9T4y6
	 HiZaGt9H8eGboYCSmp4rwPciwZCC8ZVyWR4I/Ie3QgkwV0YLTP6dE+15Uk55ab9BSo
	 3r8DK5C73IUvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKRBr3W9Tz4x2T;
	Wed, 24 Jan 2024 12:27:00 +1100 (AEDT)
Date: Wed, 24 Jan 2024 12:26:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 6.8-rc1)
Message-ID: <20240124122659.0405e382@canb.auug.org.au>
In-Reply-To: <CAHk-=wiB4iHTtfZKiy5pC24uOjun4fbj4kSX0=ZnGsOXadMf6g@mail.gmail.com>
References: <CAHk-=wiB4iHTtfZKiy5pC24uOjun4fbj4kSX0=ZnGsOXadMf6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3VfPglI5Xlmd_t6os2PkxDm";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3VfPglI5Xlmd_t6os2PkxDm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20240108 was the first linux-next after
the merge window opened.)

Commits in v6.8-rc1 (relative to v6.7):            12239
Commits in next-20240108:                          11796
Commits with the same SHA1:                        11318
Commits with the same patch_id:                      201 (1)
Commits with the same subject line:                   14 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20240108:     11533 94%

Some breakdown of the list of extra commits (relative to next-20240108)
in -rc1:

Top ten first word of commit summary:

     88 drm
     47 riscv
     47 bcachefs
     25 net
     25 dt-bindings
     18 s390
     17 mailbox
     16 selftests
     15 pci
     15 maintainers

Top ten authors:

     42 kent.overstreet@linux.dev
     16 kuba@kernel.org
     15 u.kleine-koenig@pengutronix.de
     14 rdunlap@infradead.org
     12 arnd@arndb.de
     10 hch@lst.de
      9 zhoubinbin@loongson.cn
      9 zhao1.liu@intel.com
      9 nathan@kernel.org
      9 ira.weiny@intel.com

Top ten commiters:

     69 palmer@rivosinc.com
     53 alexander.deucher@amd.com
     49 kuba@kernel.org
     47 kent.overstreet@linux.dev
     30 stfrench@microsoft.com
     28 axboe@kernel.dk
     25 kbusch@kernel.org
     22 chenhuacai@kernel.org
     21 rafael.j.wysocki@intel.com
     20 jaswinder.singh@linaro.org

There are also 263 commits in next-20240108 that didn't make it into
v6.8-rc1.

Top ten first word of commit summary:

     40 drm
     28 x86
     25 i2c
     20 fs
     20 arm
     14 soc
      7 dt-bindings
      6 bluetooth
      5 lib
      5 firmware

Top ten authors:

     36 yury.norov@gmail.com
     25 ubizjak@gmail.com
     25 andriy.shevchenko@linux.intel.com
     17 almaz.alexandrovich@paragon-software.com
     11 yangchen.openbmc@gmail.com
      9 kkartik@nvidia.com
      8 jani.nikula@intel.com
      7 jouni.hogander@intel.com
      7 arnd@arndb.de
      6 suijingfeng@loongson.cn

Top ten commiters:

     38 yury.norov@gmail.com
     27 mingo@kernel.org
     26 wsa@kernel.org
     22 joel@jms.id.au
     17 almaz.alexandrovich@paragon-software.com
     11 treding@nvidia.com
     11 jani.nikula@intel.com
     10 l.stach@pengutronix.de
      7 jouni.hogander@intel.com
      7 ebiederm@xmission.com

--=20
Cheers,
Stephen Rothwell

--Sig_/3VfPglI5Xlmd_t6os2PkxDm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwZ2MACgkQAVBC80lX
0Gytegf/QSal6eIoJx6guRerZDEftNZude6uKuCMDi+pXjXaMQwT+5yrma5gS4gS
8RJ8r/s9m69C4laA49c4fPuJ2KArt+dLcheR2mJjOC+4AUVMxBIPeCjTS/FakAe5
r2sjsubIk49ktRazntpiSPd2LRATxPhDW+iboVrvdK5GfDVmIiLer2vZLeJWW59K
ZEWdsuEVcL95VP49SyZ2kn8vLaNpF8xxGRqIeq1Zha7cUIJtnbzEi+sL8cpsbiAO
ajzgO8yTNB9BqAIJ6gNHmUSHgTApvNKmhHVngRjHWJ76Tv5cRtStFhC7SU+Wd2gF
VJ3bC/q32IXKD1aBDq/jv5d7olOR4g==
=e+b3
-----END PGP SIGNATURE-----

--Sig_/3VfPglI5Xlmd_t6os2PkxDm--

