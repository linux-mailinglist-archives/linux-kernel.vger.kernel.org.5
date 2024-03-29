Return-Path: <linux-kernel+bounces-125137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2350D892093
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C3F1C26076
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A95F11721;
	Fri, 29 Mar 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXnc6BHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8912B6C;
	Fri, 29 Mar 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726662; cv=none; b=TYne7pCX2N0yr3vEE6EJizoZXgQegnokVXT3eZeM4KbHrSBUKCVWOuw2V/OG2pvyok1r7Sz82bdRNll1zsOF2YTzyRsKMqQwnC3MHmAHD1Q5RGURv7duji5wcEu0PZhPutGOalmdKXgjtOLdt8ZcrYay5KCr1SG2TfBuI/pXiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726662; c=relaxed/simple;
	bh=3eocDvaP72RBhExznA65cm2zXjY3YiQvcbcAn357qAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWhQjJlDVavNKVwpCpFvGFkXrdsXtrRaQcD922mCfIRjG9hXPMkgRbWo4RKBQ/0wHsS3I34Vp5aaVtE3gMgJN1zKfpZVKhahWkPvgsZr4jQoJMWU3cJWHhQX8xltJW9U5reKzdjJfk9IESD8YGdABpwvFF4G7bxZ+YRX76GLIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXnc6BHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E5DC433C7;
	Fri, 29 Mar 2024 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711726661;
	bh=3eocDvaP72RBhExznA65cm2zXjY3YiQvcbcAn357qAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXnc6BHrnsmfkSrVn8YC/mv9IPF1gCGYMrjdzSWCWUa1auw49flR5dqcLBoGU3NuF
	 ZIO+0H4JZOD/y4Kmhyr6AFc0MBd8MSL3JuvThYxHpjrnwd0qnD95PJdr3h49IkTvjg
	 7dZBIcpO16MgbmkWWqO8uUQq8fhYtcY5o8tKaiKImZqKHdYCuX2jMGUPfebROcyTZO
	 Q53Zin/3DTd04ObJPnMtxYSY2sGGJiW4qUSkM9QiTv1Ows+gsYkks+P7hOrubJob6P
	 lcvplV11kG73m/vgLZZ58tnVT50nCmdEkjfBEjmJ2B1LEBiD0Ln8ANjT+ysQeNIXJ8
	 xF0s5Ae8F0hug==
Date: Fri, 29 Mar 2024 15:37:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Bjorn Helgaas <bhelgaas@google.com>, Kyle Tso <kyletso@google.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	u.kleine-koenig@pengutronix.de,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [RFC PATCH 1/2] dt-bindings: connector: Add gpio-usb-c-connector
 compatible
Message-ID: <20240329-worrisome-grasp-c70b2af9105b@spud>
References: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
 <20240329071948.3101882-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uFYv4NM+KoKHxWIC"
Content-Disposition: inline
In-Reply-To: <20240329071948.3101882-2-quic_kriskura@quicinc.com>


--uFYv4NM+KoKHxWIC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:49:47PM +0530, Krishna Kurapati wrote:
> QDU1000 IDP [1] has a Type-c connector and supports USB 3.0.
> However it relies on usb-conn-gpio driver to read the vbus and id
> gpio's and provide role switch. However the driver currently has
> only gpio-b-connector compatible present in ID table. Adding that
> in DT would mean that the device supports Type-B connector and not
> Type-c connector.
>=20
> Add gpio-usb-c-connector compatible to the driver to support such
> cases.

This is not a driver. Bindings commit messages should talk about the
hardware they're supporting, not about drivers.

>=20
> [1]: https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@quici=
nc.com/
>=20
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.ya=
ml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index fb216ce68bb3..2af27793c639 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -30,6 +30,9 @@ properties:
>            - const: samsung,usb-connector-11pin
>            - const: usb-b-connector
> =20
> +      - items:
> +          - const: gpio-usb-c-connector

This is over complicated, just needs to be "- const: gpio-usb-c-connector"

Thanks,
Conor.

> +
>    reg:
>      maxItems: 1
> =20
> --=20
> 2.34.1
>=20

--uFYv4NM+KoKHxWIC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgbgPwAKCRB4tDGHoIJi
0hs5APwLYBIyg1CBbwmd1i3CIR/+JuoYmz6qiCnxRLnOPFrm8wEA9XPaqdnvAPH+
OPEf/VJ23+e4l/uaxevEitWieixpzQA=
=v0XQ
-----END PGP SIGNATURE-----

--uFYv4NM+KoKHxWIC--

