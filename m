Return-Path: <linux-kernel+bounces-35518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0360A83925D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9B41F265CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C545FDC2;
	Tue, 23 Jan 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMkU3ziG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8C5FBA4;
	Tue, 23 Jan 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022900; cv=none; b=QdKoHmJsLHs/bTE8PJq6aFl17EZxJRpnDEAmBJebzXS3m/RUxDFsDiq5LSZCTGM3ZThMcREMK9T1zrzkG9Q7nHpvR77mKnD0VDSLE/iefznCieRHOA153REdX6Occh+62RmOLmaFwmKdDBShbT6JASvtdz25IDadZNRyJiS1Ow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022900; c=relaxed/simple;
	bh=WHHtfD6iWrYh6lpxYrEm1LYinhY12nzjgR0YqOljmIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay2gEGIsA8QnDuCGz7i7KoJOK8rXjQMnBfORGWdq6cPhz+7ygXI9a4ygV464zqGQHi4fDMNdiBlHn7o4FjKYZZ7+W4Hc/8r7GLvD53NDySILCYPTMnvEr8/tkPo7gFRKgZaIXsVteMYf0fmHBisFr3m/doWR81L8UsSr5RHcwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMkU3ziG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5312EC43394;
	Tue, 23 Jan 2024 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022900;
	bh=WHHtfD6iWrYh6lpxYrEm1LYinhY12nzjgR0YqOljmIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMkU3ziG6x0MwU9H/Ex+ucf9Z82j2HcRucb73B8HwSjLWVCzWsevuQcAmxd1hW9++
	 oiVUobDyTg8AqEgn9SHeGwLvmI8cbJuCWctYlpKqz5kRPY6YW0OfeL5kbLXGdYuBf3
	 5GR5YHeBoaHEnnuVi7c9fiylnRxX5YIwy+eM9qqHx0L4HIaS8FQ2hZ0dCvDw4uJfdq
	 9gwc6G+1K8a8O4k/5mytq/7NeRqvSJae9vejwKusCBLaRnpnXbyaLPcUsT/Gw9LS3r
	 lhuo3C5i4OvQ6q0hpfLjpfBi0M9+ePGyFe50ABVg12Sx0UqjFVf0+CU5NTUrxEuhWX
	 3cMQGaxKyKYbg==
Date: Tue, 23 Jan 2024 15:14:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	lukasz.luba@arm.com, ionela.voinescu@arm.com,
	pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	conor.dooley@microchip.com, suagrfillet@gmail.com,
	ajones@ventanamicro.com, lftan@kernel.org, beata.michalska@arm.com,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v7 3/7] cpufreq/schedutil: Use a fixed reference frequency
Message-ID: <302b454c-f735-4857-8cc3-101d223139b7@sirena.org.uk>
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
 <20231211104855.558096-4-vincent.guittot@linaro.org>
 <Za8cjQXptttuyb6c@finisterre.sirena.org.uk>
 <CAKfTPtAOJpr8VbXwSY_UMTf5Y2gEHAsobjHnJXqe1K1QDGygCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/sd+h4waIyD9cAu"
Content-Disposition: inline
In-Reply-To: <CAKfTPtAOJpr8VbXwSY_UMTf5Y2gEHAsobjHnJXqe1K1QDGygCA@mail.gmail.com>
X-Cookie: Stay together, drag each other down.


--M/sd+h4waIyD9cAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 08:24:00AM +0100, Vincent Guittot wrote:

> Could you tried this fix:
> https://lore.kernel.org/lkml/20240117190545.596057-1-vincent.guittot@linaro.org/

That seems to fix the issue, thanks.

--M/sd+h4waIyD9cAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWv1+kACgkQJNaLcl1U
h9CM9Af/ZW1jVyySIIghihHPhUaTN6VzTCwUE6KJua1dSFK4a44q9koNBXFkOHtK
l1AArHtcboHKaIpkJddeN7nof7iIXXcVQoDOhk6SNwhlwCUZdVWpL2hbHOPt1Tc6
SCGoFV5RiBIQZwzbnI1vQDaEXvtX6lPw2yRRO85i7xOUpR6YnSoPNs1dMeS3Wn4X
eYjZinuJAmmFm13ea3DcoyVT5QBhAI37b6BdhujLiyK4x+qWdGC7uRi3yn8Ehk53
aq7OW2XH8COcWnH/VmNscUgZkUQI6oPgFBMekw2QtGRNmVXWWq+vFHHK1Qp+hFBp
B0QJ8KHDYkRvNNdhwgLcxEQTasqDhw==
=/XiG
-----END PGP SIGNATURE-----

--M/sd+h4waIyD9cAu--

