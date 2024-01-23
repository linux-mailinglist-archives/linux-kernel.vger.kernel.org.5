Return-Path: <linux-kernel+bounces-35517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB2839246
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E03C295CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4405FBBA;
	Tue, 23 Jan 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXTlGlO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2453812
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022868; cv=none; b=qn5YJre8j5BF/RsUxxgdAAlaRJ6wTdg8KbDXvMU9XK4rGKPURN6vkHaLwvwqll95xsjcdR6CfjlYSDwEDsT0T5LoFOQ/Q5brSP55RSV1rDmtmdeQToDRjfcp+bDG9cvKuKgq3Amvs4Mf3fKQTSaH3O13C8tVRd00ASLvzGVUkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022868; c=relaxed/simple;
	bh=BFaSfOhIqYrKxv5lf1WwzFaAFsFyAKOIuVWdrM7IF9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ds2yFSkt36StspwDmM7okMS9zxrG2PeJtwzzbVHY7LltjuCrMi4aesBQGV1f7UsQ9/q3wTO79Hqg1oWxpz19UX9bK4KeNE2WW9mf28wUiqy1riw5/Fn7O1r5FI/6k0Au3Fb5XhkpgTLRT8gWGDKU7vJF0pulT5LfJtp286xuQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXTlGlO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5556EC433F1;
	Tue, 23 Jan 2024 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022867;
	bh=BFaSfOhIqYrKxv5lf1WwzFaAFsFyAKOIuVWdrM7IF9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXTlGlO+HkKVs31XfKYYU9wqr2fMWgK2ftHYU3LB28LAch0NEKgAY1ANWTxE7wAT5
	 uAhq1o9Vbcn2IRh40cDL7ND2bjtCraSnctrf7KvU7Vf2WTJyMW9ljdQ1Kj0WTHJtMw
	 Vsy/mwUa3DgHC/8wwVgR9X/VPmmYSqy8NhFWEiQ4tLsuXe3brKgLm4a6+f1Zr14GK2
	 /loy+xIDq56CgBgFsjLKbs4wmnjO+w+HNzWk6Q+7Aa9Evo50eeInGov9uSIt3Co6UP
	 CyMU9UVhlpE5P9R9geX2x28Ae1x7GrAoIZoLKqSoXuTutPgMxL+JWVwPIDYGNs/Ga0
	 ekM9Mnm2DV3NQ==
Date: Tue, 23 Jan 2024 15:14:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	ionela.voinescu@arm.com
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
Message-ID: <a3d72dd4-53d2-4234-a6a9-7337e1e7473c@sirena.org.uk>
References: <20240117190545.596057-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PJcyjG4f+qYg641L"
Content-Disposition: inline
In-Reply-To: <20240117190545.596057-1-vincent.guittot@linaro.org>
X-Cookie: Bones: "The man's DEAD, Jim!"


--PJcyjG4f+qYg641L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2024 at 08:05:45PM +0100, Vincent Guittot wrote:
> If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
> normalization step which includes setting per_cpu capacity_freq_ref.
> Always register the notifier but skip the capacity normalization if
> raw_capacity is null.

This appears to resolve the issues in mainline with kselftest-dt on
potato:

Tested-by: Mark Brown <broonie@kernel.org>

--PJcyjG4f+qYg641L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWv18wACgkQJNaLcl1U
h9AORwf/dU+enCJfvAYgCpnsCLmvGCxhegNcdPHQKZxIG6Lqf60R0IXejGy1YoLn
r/WPlT3JCf7gFgTLcKaGRnXKE6Obxou5wXeFXzQP1ymUmPQD5Vt1IoIAemjBD5Ks
JKFi0zqXaEiVcJlshw7ef+Hp4Hg8bC8L3gU6hp3zxz/aPgUvzoztE9tGgIIzkSo4
2kzsdCkSqftufzF2kiZjHLaJXE6VBH3lN0lcLq7ioUgn8n3kj2rjqjbpYgVkauS5
1tQ0d77kBmxZspL1bpFztlu4qEPH/20xjuZY1bcsJOkmBB7Egrg2fu9J40fINxy3
Q1/qy+1r1jmC/KC/TrdSzStMekseeg==
=MUkO
-----END PGP SIGNATURE-----

--PJcyjG4f+qYg641L--

