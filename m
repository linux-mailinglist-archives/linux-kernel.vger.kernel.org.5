Return-Path: <linux-kernel+bounces-166668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A288B9DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99082814AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A715CD50;
	Thu,  2 May 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAz1pkl9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DD15B578;
	Thu,  2 May 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665291; cv=none; b=RsNxZMjDvM6XWyj6AJBmPYXk4nRA9MFGyQf88Jmx5LBx6V1bLgifvigChuooiMzbE2XcwS0j4/fc+PPOXaWQUyYqPQ5XLWmGI7qb9NZRSMmXwmgY51iELVxZRMcT5STmOK+OAqKNJY5y6yPJbUus15NPQesEE+4OfyUcABOMZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665291; c=relaxed/simple;
	bh=r8OebLc96WPRSNwChpSCzfDAiTtMCUd2QwenhT091WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD0wPf8ZikLfbp11jfS1KYKvls1x6aXGrwcodzeCqa+VFMWFx2/yIscWxBaFLWGMgAJGn4QUTthq+oi+N6X8xjUHYRbNMkvW2l1JF6KWOMF05htaIKGwBW5Sk5Hj8F95P4nnaLbsIxPEsZefwZTC6MrLfwjqNla4bP2VF4ALFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAz1pkl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48100C4AF18;
	Thu,  2 May 2024 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714665290;
	bh=r8OebLc96WPRSNwChpSCzfDAiTtMCUd2QwenhT091WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAz1pkl9vN871eOe7gJHmVTMqyHlEPwkjJMl35emMXbcf5KQco7Sehm/W0WiUp8Cf
	 nX1rs+1d4p2hehVsxE8K1frzjYcHcip1FBf07L04Xl/02GKdoMjHIACieKABotDVrq
	 UE9jUY2HhnHOtWhLFGF9GMMcNqx9aWyH5xg328jEDxm1ba6PcYH9ChrN0rvAptopOX
	 mU/IFtYIlyvG/L0cileCrD7CnJxOgYwREqmlPNwvYrBh0SgEh2VPayg727pqCU7L7N
	 CMIzuUwuzGNZ9yggBU+M8b7/TJUaIlT1QHiRy8vmOWIekBSL1SYa9bz5yz7SL6YDu3
	 EylyBEet2EpoQ==
Date: Thu, 2 May 2024 16:54:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com
Subject: Re: [PATCH 1/3] spi: spi-microchip-core: Add support for GPIO based
 CS
Message-ID: <20240502-produce-gallery-3b8e17db9c01@spud>
References: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
 <20240502143410.12629-2-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RFYwY/Nam1P3ueHY"
Content-Disposition: inline
In-Reply-To: <20240502143410.12629-2-prajna.rajendrakumar@microchip.com>


--RFYwY/Nam1P3ueHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 03:34:08PM +0100, Prajna Rajendra Kumar wrote:
> The SPI controller within the PolarFire SoC is capable of handling
> multiple CS, but only one CS line is wired in the MSS. Therefore,
> use GPIO descriptors to configure additional CS lines.
>=20
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--RFYwY/Nam1P3ueHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjO3RgAKCRB4tDGHoIJi
0kPSAPiTRfo+gPE5ctQPx4+xDZ6kHdX4imtKH396RVtO0xx3AP9rVc/Jkfpg2Nrw
o7xTU7ZdJcc06vss/e1NxTwDdx7KAg==
=R2rj
-----END PGP SIGNATURE-----

--RFYwY/Nam1P3ueHY--

