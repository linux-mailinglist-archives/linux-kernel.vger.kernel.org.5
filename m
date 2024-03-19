Return-Path: <linux-kernel+bounces-108054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F7880549
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D4284439
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7C139FE9;
	Tue, 19 Mar 2024 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUIs1Fb9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A139FCF;
	Tue, 19 Mar 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710875661; cv=none; b=UDYJ1Ji0Brl2cgLkzTK3Q/IPTwAiNhFRrXQj7A7oZKrV8yOmfiiMLwJALOTjcD6y6SEtHhEyMuCiQiDerEF8Q5irkrkOSxRjHoZNnvIW42BH0lhHBfA88/yYNN6e9ozLgZo5n17MG3ei+SUACTZvxdnf6ns0jpKsJs82yzz8utc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710875661; c=relaxed/simple;
	bh=AskgniET8Tqn44PIKtPuXBtGixttuBhuyMYiySvc3B8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TptAkXrRwznfPu8wE0zEmaOcDsRK3EQtJPxjRAioePTWcHPIRTnjovXSsrstMocXyv/8bBWjsdmS4kTKWmcPX7ymGB61xCrScB75TvrV+4qyxbyChx8qTfDyxHcQGgLkIojBdpIwgCVQES2cz63+R0WL8G+0w6O4orYIGr7LJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUIs1Fb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C9C433C7;
	Tue, 19 Mar 2024 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710875660;
	bh=AskgniET8Tqn44PIKtPuXBtGixttuBhuyMYiySvc3B8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=YUIs1Fb9rqLF3FLp3OpW0j9RsDAvrhWxCYYoiGl7okUDJLvDb5RI9c/kfSQ8BjEIQ
	 g8nWGHyb2V5OiEWK0wW1uDTur1zE80yTmWpCjrnFFYaL8hNgnFTyX5UfkJGlqbUW5x
	 +rfXhOc5D0UVwVmufbnMzWH2JshjKLP/cYvSOv+RMIA/yJZz27x9oZdPM5P5eeOyaE
	 oFHjwm4GerzAYHtZJT9RbA+l76/bU1wzvhy6qc74n6snKI/eN9JBYvYIoSQZOKb2xV
	 yuuegtG8sOdHPfqYXMn2VfOTSJQrXzrkbuBSaQbUdjylgEy7p4MPzikAlx2jO51QHC
	 kyeUH4M+MN5aQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 21:14:16 +0200
Message-Id: <CZXYSYBHZ0XD.1XYUMR2DZ3I0O@kernel.org>
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Lukas Wunner"
 <lukas@wunner.de>, "Stefan Berger" <stefanb@linux.vnet.ibm.com>
Cc: <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <bbhushan2@marvell.com>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>
 <026ad747-eb04-44e6-9c1e-cb1a56a6e0e3@linux.ibm.com>
In-Reply-To: <026ad747-eb04-44e6-9c1e-cb1a56a6e0e3@linux.ibm.com>

On Tue Mar 19, 2024 at 8:55 PM EET, Stefan Berger wrote:
>
>
> On 3/19/24 14:22, Jarkko Sakkinen wrote:
> > On Tue Mar 19, 2024 at 12:42 AM EET, Stefan Berger wrote:
> >>
> >>
> >> On 3/18/24 14:48, Lukas Wunner wrote:
> >>> On Tue, Mar 12, 2024 at 02:36:05PM -0400, Stefan Berger wrote:
> >>>> This series adds support for the NIST P521 curve to the ecdsa module
> >>>> to enable signature verification with it.
> >>>
> >>> v6 of this series is still
> >>>
> >>> Tested-by: Lukas Wunner <lukas@wunner.de>
> >>
> >> Thanks.
> >=20
> > This has been discussed before in LKML but generally tested-by for
> > series does not have semantical meaning.
> >=20
> > Please apply only for patches that were tested.
>
> Ok, I will remove the Tested-by tag.
>
> However, patch 4/13, that only changes a comment, can also be tested in=
=20
> so far as to check whether the code is correct as-is for the tests that=
=20
> 'I' ran and no further modifications are needed for NIST P521. In this=20
> case it would mean that a single subtraction of 'n' from res.x seems=20
> sufficient and existing code is good as described by the modified comment=
.

So, since all patches are required to test anything at all, I think that
putting tested-by to 13/13 would be the most appropriate, right?

I without enabling this x509 parser, there is nothing to test, I'd
presume.

It doesn't have to be more complicated than this.

BR, Jarkko

