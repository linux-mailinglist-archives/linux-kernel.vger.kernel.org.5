Return-Path: <linux-kernel+bounces-27622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D2A82F321
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D158F283CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8B1CAAF;
	Tue, 16 Jan 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUDRWVpG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B101CA87;
	Tue, 16 Jan 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425889; cv=none; b=oXY/3EOOT2P8w3oi0Ls5042UyegAvmXFLuWiy07IQfYdIgN5CUYwwEJWqYQM8b3f21+mAidTCfaO3xrm1S7WEqWmxn9oSyaAvHUDlnK13qhjl+ju9vSX15CqhwtRgsPbPzZOWiyXe9/Fy2Sxx1YT70eIXIWtMVoV6kMQCVzKfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425889; c=relaxed/simple;
	bh=68zk3+ROqHddAWsTHPJT5uR90VY+a194t7rgF1l8zAk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=tzCDLMHg6cHoqfP6rRnjpB4Gbbg0x4oWbKYd4z+Tpqcc/SucsJKNUKuoDdWpPv+J+fNL+ugpU3lM79WH7ZeafG1cgtz16XoCZ6xGUspTM/kSQo/ORyBfJd5bA40GFkrpbA7NO0NIbjMi46YXhYwT1R5tagWSAB+GITGh5HsGzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUDRWVpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2C2C433F1;
	Tue, 16 Jan 2024 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705425888;
	bh=68zk3+ROqHddAWsTHPJT5uR90VY+a194t7rgF1l8zAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUDRWVpGnr/WN61mxuVJCg1zwkmOf45QyVfUSV4PfrowukX4tDpzQA7g3ARhsOZZQ
	 /Awj5cfcq/61w0EiIJbLx0+bG5tLs0yc6cFEFbm9AXP8ByIBenRigYpJs0lUdlq/mM
	 HRownv6XmNkNf2Wd3e2AG5hvYSoGHPcSOWxjqxgx/y+xAtXa7KQRo0VOI1StgGxuWd
	 3QWVrdoQ7bV/aW4/3TdBcLKDTPso0HR+TsH8BNeD+kP1L2V5MsiBP1Jk4mGpdVTKkb
	 IfSdp/+rHGmvZykZEIjADUeEBxImuAIHk/jpyJL60Z7lhGfv57A3/6gYB3x+4iTman
	 66ktziwXDmi8w==
Date: Tue, 16 Jan 2024 17:24:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 1/4] dt-bindings: clock: sophgo: Add clock controller
 of SG2000 series SoC
Message-ID: <20240116-music-luckiness-3220a9efdbbf@spud>
References: <20240116-doubling-fanning-2a46405942ae@wendy>
 <IA1PR20MB49535AA4F070E70BB5C9848ABB732@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r9tQTiOuQ4372n5L"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49535AA4F070E70BB5C9848ABB732@IA1PR20MB4953.namprd20.prod.outlook.com>


--r9tQTiOuQ4372n5L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 04:00:45PM +0800, Inochi Amaoto wrote:
> >On Tue, Jan 16, 2024 at 08:27:59AM +0800, Inochi Amaoto wrote:
> >>> On Sun, Jan 14, 2024 at 12:16:58PM +0800, Inochi Amaoto wrote:
> >>>> SG2000 series SoC has the same clock as CV1810 series, but the clock
> >>>> related to A53 is functional in SG2000 series. So a new compatible
> >>>> string is needed for the new SoC.
> >>>>
> >>>> Add definition for the clock controller of the SG2000 series SoC.
> >>>>
> >>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >>>> Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datas=
heet-v1.0-alpha
> >>>> ---
> >>>>  Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml | 3 =
++-
> >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-c=
lk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> >>>> index c1dc24673c0d..59ef41adb539 100644
> >>>> --- a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> >>>> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> >>>> @@ -4,7 +4,7 @@
> >>>>  $id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
> >>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>
> >>>> -title: Sophgo CV1800 Series Clock Controller
> >>>> +title: Sophgo CV1800/SG2000 Series Clock Controller
> >>>>
> >>>>  maintainers:
> >>>>    - Inochi Amaoto <inochiama@outlook.com>
> >>>> @@ -14,6 +14,7 @@ properties:
> >>>>      enum:
> >>>>        - sophgo,cv1800-clk
> >>>>        - sophgo,cv1810-clk
> >>>> +      - sophgo,sg2000-clk
> >>>
> >>> I recall before you mentioned that the Sophgo folks were considering
> >>> renaming one of their devices. Is the sg2000 the renamed one, or a
> >>> different chip?
> >
> >> The sg2000/sg2002 SoCs have one A53 core which cv1812/cv1813 SoCs
> >> don't have. I prefer sg2000/sg2002 are different chips, or at least
> >> an enhanced version of existed cv1812/cv1813. It is not a simple
> >> rename.
> >>
> >> For this patch, the sg2000 doesn't need to disable A53 related clocks
> >> like cv18xx series. So this compatible is needed to bind to this new
> >> logic.
> >
> >I'm not disputing the unique compatible - you previously mentioned that
> >Sophgo were considering rebranding the cvXXXX series of chips going
> >forward and that one particular chip might undergo a name change.
> >I was wondering if this was that chip or just another device in the
> >series.
> >
> >Thanks,
> >Conor.
>=20
> For your question, this is the rename chip I mentioned.
>=20
> This is the name mapping I have known:
> cv1812cp -> sg2000
> cv1813h -> sg2002

Great, thanks :)

--r9tQTiOuQ4372n5L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa72gAKCRB4tDGHoIJi
0g8eAP9HUpaP7XCMrJxxok89GSOryAQNXy7yCjtp5wJ3O8mY3AEAuG5OIjPyP8LX
pAAvqf/m4HKVviqiyTQZXUwq+3K2Mgk=
=2l75
-----END PGP SIGNATURE-----

--r9tQTiOuQ4372n5L--

