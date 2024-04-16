Return-Path: <linux-kernel+bounces-146630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CBE8A6883
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65CD281E83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3A127B7D;
	Tue, 16 Apr 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE05n9Rz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB863D38E;
	Tue, 16 Apr 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263657; cv=none; b=Q6HZafYb7R+0tA21Wtsi1avzcWp/Q3uHxl9BXRApmgMeBKQLTymK2KzW1reHKxviq44dEk4Pq1myGd1Eik1h0dC4LthQPEQm4C+jdojjBULJiIQyyOwBLsQGdg9F9HGhEE7OvrEng4Tisq8BGd6RJIdsd4bJriWiLnmxjRSWz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263657; c=relaxed/simple;
	bh=lb2mredCM4AdUxSTAm5hobl6mxpttwOgXqc2M0SZvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur8Ci8G3Pc9oez1KO7t6tesMHli2XZGZVeKfrCydrlqhBSkc8KVaCSzqgNDBZNmDgLkl1VpIwqm78hWO6Sup/3ZQ1CB2Y6ohATLlbTVi0/UhFmxlQBS8rOSlGxRBChXhEu6Ur/GNHpAbWk5wmQr9znXMVupgy+zK6QVveZ3ORL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE05n9Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20B6C113CE;
	Tue, 16 Apr 2024 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713263657;
	bh=lb2mredCM4AdUxSTAm5hobl6mxpttwOgXqc2M0SZvQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OE05n9RzorSVMMaYacpW4ss6P2cEo2BLuzw+a9ueig0urmRe8GXg4xn+Sftf6sDBd
	 kIzRbGtnJ54cvhld4CiCX/4aPIuthVj436tK0fBoPUQ3E4RRmveFzLVb9E4bkU1cTk
	 9YtukZTQLfLD8TSlOEyz7KJAm/0M4E+0oM89IUQVGVctfDhMqvK4abCVKyuLrpCWLK
	 Mo6P4xzVmrP87Xksv0+j/p93AzEMFZZV3lPS1hANoMSGDxm8fMnqzuzIjbx8KkMK43
	 HNs63Dro4P+I/AVTYQdwNwSKnDpzBJoPz4wF9kAOXkHGywCvPYTUoZKKExE/ItgalP
	 emi6vffqK0GGA==
Date: Tue, 16 Apr 2024 19:34:14 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Yihuang Yu <yihyu@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
Message-ID: <Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
References: <20240415141953.365222063@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zvbK2jxsbCApSYIv"
Content-Disposition: inline
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
X-Cookie: You might have mail.


--zvbK2jxsbCApSYIv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.28 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

The bisect of the boot issue that's affecting the FVP in v6.6 (only)
landed on c9ad150ed8dd988 (arm64: tlb: Fix TLBI RANGE operand),
e3ba51ab24fdd in mainline, as being the first bad commit - it's also in
the -rc for v6.8 but that seems fine.  I've done no investigation beyond
the bisect and looking at the commit log to pull out people to CC and
note that the fix was explicitly targeted at v6.6.

Bisect log:

# bad: [a4e5ff3532873150dc32d20f5c214ec59f98bcd2] Linux 6.6.28-rc1
# good: [5e828009c8b380739e13da92be847f10461c38b1] Linux 6.6.27
git bisect start 'a4e5ff3532873150dc32d20f5c214ec59f98bcd2' '5e828009c8b380739e13da92be847f10461c38b1'
# bad: [a4e5ff3532873150dc32d20f5c214ec59f98bcd2] Linux 6.6.28-rc1
git bisect bad a4e5ff3532873150dc32d20f5c214ec59f98bcd2
# bad: [f95afc8867d1f2e18e0c6abd16ca76c99a2839be] net/mlx5e: HTB, Fix inconsistencies with QoS SQs number
git bisect bad f95afc8867d1f2e18e0c6abd16ca76c99a2839be
# bad: [06e82fe83cc671df58a956cd0cf8ba64c15a6d0d] scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()
git bisect bad 06e82fe83cc671df58a956cd0cf8ba64c15a6d0d
# bad: [d2b5692676e7a204487546699cd5511baad5e9b6] ARM: OMAP2+: fix bogus MMC GPIO labels on Nokia N8x0
git bisect bad d2b5692676e7a204487546699cd5511baad5e9b6
# bad: [a438d050bf7ba5e3462dd61d90897569e7892c80] raid1: fix use-after-free for original bio in raid1_write_request()
git bisect bad a438d050bf7ba5e3462dd61d90897569e7892c80
# good: [6e869ee886dead911b2411c7cba816be52dffb19] ata: libata-scsi: Fix ata_scsi_dev_rescan() error path
git bisect good 6e869ee886dead911b2411c7cba816be52dffb19
# bad: [c9ad150ed8dd988d1cefc1a8e19df53d46990e76] arm64: tlb: Fix TLBI RANGE operand
git bisect bad c9ad150ed8dd988d1cefc1a8e19df53d46990e76
# good: [56a6896c1f107d519c0045dd6575648745bcba21] batman-adv: Avoid infinite loop trying to resize local TT
git bisect good 56a6896c1f107d519c0045dd6575648745bcba21
# first bad commit: [c9ad150ed8dd988d1cefc1a8e19df53d46990e76] arm64: tlb: Fix TLBI RANGE operand

--zvbK2jxsbCApSYIv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYeVCUACgkQJNaLcl1U
h9CJoQf/aLbhmUPsMaw34Z5cJTRhddU/q+mZXHLarxGpVF+A+aZ3O/+DITRTAcUy
AdMokVsUuN/YCaqzuG72h7Mkz7jDckgqzcjgDVbqVvFSo5Kxl7OBKnfEw8U3emR9
7uCac8TNu2TMjrqfxJQeSLWO1nX+YHvetyucLDdxVp8nG233ayTEaYpa+iFU7T1Z
xBWPgUckoLt5I7aissYoDglN8aCctetYVTMSgDZ7O0eQanyEn/HY1fOTcISmULIG
ztTwQ5G7iJMaKbI6Ktd4LjjwhVl3/8RCemPTzdcoEEwUUBqUdpBS3sLiab6Fz/r4
yY0Ci/q9mbsbe2MkySmAU5qSPHNFwg==
=t9tj
-----END PGP SIGNATURE-----

--zvbK2jxsbCApSYIv--

