Return-Path: <linux-kernel+bounces-166724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA58B9E8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05F3281B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4D15E803;
	Thu,  2 May 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkwArCD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B9154457;
	Thu,  2 May 2024 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667304; cv=none; b=IxOWkWAq4SD46k2O69tP96J57kk85GoVTG5t2hSl7BUk76KmvAio+LXX6LhxHdpwWgsrFVH0cBl6riFaZuL8yU5e7QdZMV277ToxB/cVI9Xs77wI1FKHb5xK7LTsntl3ZwzE40fLh/67ZIZzVNBMeq1I1ohJxSaWjIR6Ol1DBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667304; c=relaxed/simple;
	bh=igeGofHHX03XUM7K37J588YrkNVJAkcgHSuZsnjbMRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGrKhySPDp0ZYFTdn+N3zFMKCmGfFGyeAViWPu/jc1VsaLp7XCMLRhbBQvMrFibpD2kvLle39eooAt+iVi7b9fynje4MfuKd0bYSTw+KUyPNQtoZvhm7okGb3By/47av87eE7oxu0AS4cXdvQntZZekd92VE+5JDX6nXcppunh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkwArCD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79ADC113CC;
	Thu,  2 May 2024 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714667304;
	bh=igeGofHHX03XUM7K37J588YrkNVJAkcgHSuZsnjbMRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkwArCD524hvWVLbY/B04VyZtyU2tSmLXTC+TN/3fNo1FFjhjp+e3HDRt66njqDKB
	 wTpSEwE6jVMeS3d3xMfLLOksc1ddn7gvw3UY4Sq+w7RKVV8HA977fRZj9yYHtKwZ87
	 9cWjCOHgQJJsrNlLKy5RoiUVP4kx4WhVE7KzStDBI+tK2S8uoslj2M0TWCE2tEOFuw
	 /MOMN1Z0IdPcYVCAyk4jpzy6Lt6DIcv3VGgEkEUw+bWDxRaYzp9f+9vagunjJ7jQuq
	 2+w7eY/+3Bs++xIUIgDjNo83QuObVB4VuHPezAYebaNgU0L84haFAdu+WN8hM4n2BD
	 WaPcMNA4q+gzA==
Date: Thu, 2 May 2024 17:28:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com,
	john.garry@huawei.com, Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
Subject: Re: [PATCH v4 1/3] riscv: cacheinfo: remove the useless input
 parameter (node) of ci_leaf_init()
Message-ID: <20240502-secrecy-unleveled-e173419c54ec@spud>
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jCp1f9hek9NXabnN"
Content-Disposition: inline
In-Reply-To: <20240418034330.84721-1-cuiyunhui@bytedance.com>


--jCp1f9hek9NXabnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:43:28AM +0800, Yunhui Cui wrote:
> ci_leaf_init() is a declared static function. The implementation of the
> function body and the caller do not use the parameter (struct device_node
> *node) input parameter, so remove it.
>=20
> Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

By the way, please use cover letters for multi patch patchsets. I don't
enjoy marking previous versions "superceded" by hand in patchwork.

Thanks,
Conor.

--jCp1f9hek9NXabnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjO/IgAKCRB4tDGHoIJi
0hi4AQCMArFXXQ1jipb+xchGlJ3/aeXo1IgXwQ7MxE3mxAbG9QD/UwOrcrpHE3gN
t4eD8gxKhTy6Wmuj7HiFcstVa4iezAg=
=jJp+
-----END PGP SIGNATURE-----

--jCp1f9hek9NXabnN--

