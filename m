Return-Path: <linux-kernel+bounces-127382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD85894A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0ED11C21315
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5817C6A;
	Tue,  2 Apr 2024 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Q806oSm5"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7712581;
	Tue,  2 Apr 2024 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032929; cv=none; b=Q5lcm9QklBNwWb8a16pcFSe7thNfrTZXCZHLmMSFWVsbmzXQ7vD4Ker2aOhUul+mj7dZbDEYaWLOSnUsZRcmKYEWreFqmGOpcj9kBalzxoKYSjhUnPV3LqDWc2rW18geV3mOxAWX33uMVq0Hd4+Y462xus6LWnKZn6CzNQ4rCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032929; c=relaxed/simple;
	bh=Cq4y5V9tgRGo3LoHQcADYNRf6oy3wrq7fzGOaXsz42c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSbC8kVWIOrX/q/2DDrfWiJ4BX35Jyd0ibKOM8f2vUAqfDT6R9QEo2OUzY6GhRskrx2WDbeTxlWO5rhbhBjYAVdbkdmePmDg0JeYEnQhGLAVd4h7GRkLjjHQTvgWR0L3q3Iz+L9ksIimc8GaP3+eX3DnoRen3lCyKDyyV3ZaZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Q806oSm5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4011420016;
	Tue,  2 Apr 2024 12:41:56 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712032918;
	bh=fRcs8rvk7aWDd3jH1iz3Wdk5wU4Tj0kt/f5n2x/Nrm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q806oSm5OfEMDMJ/wLaqtQwDlfkPA1UW3d3kM0I97eEHY8VnrfYoNhex0sFxwKvNU
	 6ABUEJQjE84Nt41hQNrgJIZg172+oSPEcLDq42RZfwDIwJSHxrSx07P9n4ymSCw8ep
	 +3/OO15E0JLuAoaxhHDtcqt7DckH201EFNTyTtAlt8kfEbsZPjrDK11b/4nQxhqlOp
	 pnuud1xzxMRIV1k5kjs2qYfX9hIKg2uqZaLV7UkvbkXu4RWSM58ygdljZA0e3q22f7
	 4ff5N3+gQpp+ZU95Tu7iwprzzaRA9m/KlKiBgz7PD4BtQl9Mp4u8XX5sDt8zsANeZW
	 eR68bplZPpB9Q==
Message-ID: <3aad5148383ba9e8fd905b09690ffa9c378b31de.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] Revise duty cycle for SMB9 and SMB10
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 02 Apr 2024 15:11:55 +1030
In-Reply-To: <20240401090509.2338027-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20240401090509.2338027-1-Delphine_CC_Chiu@Wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-01 at 17:05 +0800, Delphine CC Chiu wrote:
> ARM: dts: aspeed: yosemite4:
> Revise duty cycle for SMB9 and SMB10 to 40:60
> To meet 400kHz-i2c clock low time spec (> 1.3 us).
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 64075cc41d92..b3a2aa8f53a5 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -257,6 +257,7 @@ power-sensor@40 {
>  &i2c8 {
>  	status =3D "okay";
>  	bus-frequency =3D <400000>;
> +	i2c-clk-high-min-percent =3D <40>;

A grep of the 6.9-rc2 tree doesn't turn up any mention of this property
name.

More work needs to be done if this is meant to have any effect.

What tree are you developing your patches against? If you're sending
them upstream then you must do your work (and test) in the context of
upstream.

Andrew

