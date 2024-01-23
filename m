Return-Path: <linux-kernel+bounces-35621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44B83944E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C152963E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608BD664C2;
	Tue, 23 Jan 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqKDF9P/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4A612F0;
	Tue, 23 Jan 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025997; cv=none; b=u3UYdKM7absC8LoTxvSCQFYeSrn192Ryfsmnzz0cGdwsV+JLVflZwT69pQcJ5JXPeYgEtoy0OzkqOOHejoTwRJRgXDXmyto3CeqyxNATadKfyGjSiQ6mOSFQYNDEiPWW42Yhxa0Cw/dDHyMSd9htreOb3aOMMoE3M3yxH9brtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025997; c=relaxed/simple;
	bh=c+2cQ1AyZkqNt9Y2ompQm2rjkM685pFW95EhdYleG2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLTc4dAlTw0Vjav50id/LIAxuvpMsnHCKnmu1G8UB7mWwTlHmyJxrrmJCXwum4BndzQm+3vuyLuL69aTaDHfE7vyvoqv9KSgNbRdoh0q3TExCnO6YE6lMR31Ys2w5Ir6fgzf2AFC22v5RTE7dj2eCgV2AF6B5dFPJf6IYy4IHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqKDF9P/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F6C433C7;
	Tue, 23 Jan 2024 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025997;
	bh=c+2cQ1AyZkqNt9Y2ompQm2rjkM685pFW95EhdYleG2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqKDF9P/mvQjLAc8h3Abn9WoTJUp9KtaR6/uA+yfV/pt26Ro5WhvSGkyNGHl0z50N
	 CNXdkMh0bnD1wXemYLC1ueyErXN5KrfnTMWUKETpXP5UCpyYC0gD5PlMiVvFKa9NUL
	 UWEeCGQm7oVnf+/xZArWo6QcXGGFsz0HoGYikoqRIe2yBh5Trih0ZlNo24J/lBqqX7
	 BqvTDYyz1y82cgpFPT0W+GNridgk8nez4kKxANPW6edNRi6lzCXK3BYowfZRzgSrDS
	 bUZvMJRDWivim7ncP3SHc+qQgKJQ89qJvutMuG07s3jWozNpCW9ZiHzavdUSxCM6RN
	 RCxvYbjxbaDzQ==
Date: Tue, 23 Jan 2024 16:06:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Marek Vasut <marex@denx.de>,
	Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Philippe Schenker <philippe.schenker@impulsing.ch>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
Message-ID: <20240123-ripening-tabby-b97785375990@spud>
References: <20240123135014.614858-1-dev@pschenker.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NI/8LBe6Z0gbguMf"
Content-Disposition: inline
In-Reply-To: <20240123135014.614858-1-dev@pschenker.ch>


--NI/8LBe6Z0gbguMf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 02:50:13PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
>=20
> This commit adds the dt-binding for KSZ8567, a robust 7-port
> Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
> each capable of gigabit speeds, complemented by five 10/100 Mbps
> MAC/PHYs.
>=20
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>

This device has all the same constraints as the other ones in this
binding, why is it not compatible with any of them? If it isn't, the
compatible should mention why it is not.

Cheers,
Conor.

> ---
>=20
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=
 b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index c963dc09e8e1..52acc15ebcbf 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -31,6 +31,7 @@ properties:
>        - microchip,ksz9893
>        - microchip,ksz9563
>        - microchip,ksz8563
> +      - microchip,ksz8567
> =20
>    reset-gpios:
>      description:
> --=20
> 2.34.1
>=20

--NI/8LBe6Z0gbguMf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/kBwAKCRB4tDGHoIJi
0qIwAP0cAGkY71vvUkGVLtIl9vMLiEQ4yyjNGvN6RsdtKatZwwEAnjjiGl1UYl8C
Ha3eBRlaGSPNPIG1GySfDMPmK5FZhgc=
=Jrfg
-----END PGP SIGNATURE-----

--NI/8LBe6Z0gbguMf--

