Return-Path: <linux-kernel+bounces-91055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50EE870909
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7042880DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6213C61687;
	Mon,  4 Mar 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASP9tDum"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D13CF40
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575475; cv=none; b=fhgdSrvAq458rh39M67n4Hm7bJBnF4XbHrSYn+TprhLuBAQ++/H9TzSRUe/7vXUxebHUFQB5guJD2dLdr5lIJQUdaAMig8gJ0jgrtVgYvv7tidGPE+mtdGFH5wB8PMEQ+yUyqzBsxMBq8537ed+0NUMO1pqSvXUYyYpWDjpT6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575475; c=relaxed/simple;
	bh=zCSQOLBMW/dXzbiniKZg+jQ3DjKtHORHN2WIjSPZGTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQSuVKs8b4pntHj4hocyF8dB9MiBrg/jQXK6UXOtxsLZtEEs2vdKzSTiYlx+Apk/tjL/yJ96z+Nd2EiHesqyBbdwBDkCvsWOB+rmdfR7RyRLGZzfRw+Y51c3Cao73aK7inZbCm1ZqawFEVMUqGmwarOU8k1gFkwqTVscQPXJfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASP9tDum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBE2C433F1;
	Mon,  4 Mar 2024 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709575475;
	bh=zCSQOLBMW/dXzbiniKZg+jQ3DjKtHORHN2WIjSPZGTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASP9tDum5p+yuPKxJUnVgX/bUl/11L13Z0hTdqAQ7AAujOJqI42sCZ46P06Y61odg
	 +E7bLzUL0zgG7kgUCzBco/Nm4K3Nr8U3AsaflyDhyPZqO0qzq/pe5WxVKPs1UCXdoD
	 fwCXmc1Fi8KgsSDE4u0dyHYNQsV8px3Ya0Cr8o+xSoigkUaGWVCO9H+iz78UP2imC0
	 BB2ZqVBt3sbC/KekWZ+17a1ZyzK0ZDpCqbfSRS02nr/lImZpi/ma8PEPGe7bcCuho1
	 9OIJ8LVeGbvhpsZv+YodiN3R/FK4vIBBjOCVHEzhlUKyc22ak+T3AajJp3TJdwy4k/
	 yl9Q3yVdcRh4Q==
Date: Mon, 4 Mar 2024 18:04:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: x86 boot issues in -next
Message-ID: <f2dc0a62-f9b0-41e7-8e13-d81887fc1f48@sirena.org.uk>
References: <05a45cc8-e0fc-422e-80d2-596ed63202a3@sirena.org.uk>
 <71f9b0b7-190f-453c-b55b-c842db4a825d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0qNiEXbJs1qiWn9"
Content-Disposition: inline
In-Reply-To: <71f9b0b7-190f-453c-b55b-c842db4a825d@intel.com>
X-Cookie: He who hesitates is last.


--i0qNiEXbJs1qiWn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 01:48:41PM -0800, Dave Hansen wrote:
> On 3/1/24 13:29, Mark Brown wrote:

> > For the past few days -next has been failing to boot an x86_64 defconfig
> > on the x86 machine Linaro has available in their lab.  DMI says it's a
> > "Dell Inc. PowerEdge R200/0TY019, BIOS 1.4.3 05/15/2009" and the CPU is
> > described as "Intel(R) Xeon(R) CPU X3220  @ 2.40GHz (family: 0x6, model:
> > 0xf, stepping: 0xb)", it's running happily with mainline and
> > pending-fixes.

> This wouldn't explain the bisect results, but there's been a crash fixed
> in here:

> > https://lore.kernel.org/all/170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com/

> that looks pretty similar to your signature.

> Could you give Dan's patch a shot?

Whatever the issue was it's gone today - Dan's patch is in -next so I'm
guessing it may well have been it.  I'm guessing the bisection might've
been due to some combination of the two trees causing an empty group to
get added?  Thanks for looking into it.

--i0qNiEXbJs1qiWn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXmDS0ACgkQJNaLcl1U
h9Cmzgf/Um8ZI9/CArhfn8sgMoPIAh3/Q//gEUzaWU8T7eWm3cKqdogEMQOf1OMZ
bwm4nCcp+ltmZsid6wJrOSIbuyiWpi15gKkPgfA6l5oNHRg+BJGzmmC6g952mg1s
PQ7HTMBS3nrtRJhCOxNqh/eX58tsUmJGPcc6GSolgwJ26e/ctzAUpKU95dTwDtOZ
/TxJ8St/K7FzSs+eLHIYF7/0/W4xDvZ3SvX+kz5dXPEf5UqQjJa31QhjPNk18vxS
ABzSCR+mXsdT7oBZjLFkcS9Jqox1YKOho6cRJRlZFKuGj81SKg72G1tUd6oNhVAq
5FRYhwgaaXDvYv6+i19XF4SYlm7ssQ==
=FRnd
-----END PGP SIGNATURE-----

--i0qNiEXbJs1qiWn9--

